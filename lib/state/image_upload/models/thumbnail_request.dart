import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest {
  final File file;
  final FileTypeEnum fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  @override
  bool operator ==(covariant ThumbnailRequest other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          fileType == other.fileType &&
          file == other.file;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          file,
          fileType,
        ],
      );
}
