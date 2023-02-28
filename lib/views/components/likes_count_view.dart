import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/likes/providers/post_like_provider.dart';
import 'package:instagram_clone/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';

import '../../state/posts/typedef/post_id.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;

  const LikesCountView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikeProvider(
        postId,
      ),
    );
    return likesCount.when(
      data: (int likeCount) {
        final personOrPeople =
            likesCount.value == 1 ? Strings.person : Strings.people;
        final likesText = '$likeCount $personOrPeople ${Strings.likedThis}';
        return Text(likesText);
      },
      error: (error, __) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
