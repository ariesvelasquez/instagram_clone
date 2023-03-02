import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/posts/typedef/user_id.dart';

import '../../posts/typedef/post_id.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;

  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
