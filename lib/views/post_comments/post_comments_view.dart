import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/models/post_comments_request.dart';
import 'package:instagram_clone/state/comments/providers/posts_comments_provider.dart';
import 'package:instagram_clone/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone/views/comment/comment_tile.dart';
import 'package:instagram_clone/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/extensions/dismiss_keyboard.dart';

import '../../state/posts/typedef/post_id.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentsView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('postId $postId');

    final commentController = useTextEditingController();
    final hasText = useState(false);

    final request = useState(
      RequestForPostsAndComments(postId: postId),
    );

    final comments = ref.watch(
      postsCommentsProvider(
        request.value,
      ),
    );

    comments.when(data: (comments) {
      print('comments $comments}');
    }, error: (err, __) {
      print('error $err');
    }, loading: () {
      print('loading');
    });

    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(
                        postsCommentsProvider(
                          request.value,
                        ),
                      );
                      return Future.delayed(
                        const Duration(
                          seconds: 1,
                        ),
                      );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments.elementAt(index);
                        return CommentTile(
                          comment: comment,
                        );
                      },
                    ),
                  );
                },
                error: (_, __) {
                  return const ErrorAnimationView();
                },
                loading: () {
                  return const LoadingAnimationView();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );

    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
