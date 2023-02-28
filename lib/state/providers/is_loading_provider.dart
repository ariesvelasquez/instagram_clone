
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  final sendComment = ref.watch(sendCommentProvider);
  final deleteComment = ref.watch(deleteCommentProvider);

  return authState.isLoading || isUploadingImage || sendComment || deleteComment;
});
