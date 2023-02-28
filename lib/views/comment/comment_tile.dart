import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/delete_dialog.dart';

import '../../state/comments/models/comment.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;

  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );

    return userInfo.when(
      data: (userInfoModel) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          title: Text(userInfoModel.displayName),
          subtitle: Text(comment.comment),
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);

                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
        );
      },
      error: (_, __) {
        return const Center(
          child: SmallErrorAnimationView(),
        );
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.delete)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
