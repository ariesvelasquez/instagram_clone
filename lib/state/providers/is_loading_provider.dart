import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instagram_clone/state/posts/providers/delete_post_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  final sendComment = ref.watch(sendCommentProvider);
  final deleteComment = ref.watch(deleteCommentProvider);
  final deletePost = ref.watch(deletePostStateProvider);

  return authState.isLoading ||
      isUploadingImage ||
      sendComment ||
      deleteComment ||
      deletePost;
});
