import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/image_upload/models/file_type.dart';
import 'package:instagram_clone/state/posts/models/post_key.dart';

import '../../post_settings/models/post_settings.dart';
import '../typedef/user_id.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required final UserId userId,
    required final String message,
    required final String thumbnailUrl,
    required final String fileUrl,
    required final FileTypeEnum fileType,
    required final String fileName,
    required final double aspectRatio,
    required final String thumbnailStorageId,
    required final String originalFileStorageId,
    required Map<PostSettingEnum, bool> postSettings,
  }) : super(
          {
            PostKey.userId: userId,
            PostKey.message: message,
            PostKey.createdAt: FieldValue.serverTimestamp(),
            PostKey.thumbnailUrl: thumbnailUrl,
            PostKey.fileUrl: fileUrl,
            PostKey.fileType: fileType.name,
            PostKey.fileName: fileName,
            PostKey.aspectRatio: aspectRatio,
            PostKey.thumbnailStorageId: thumbnailStorageId,
            PostKey.originalFileStorageId: originalFileStorageId,
            PostKey.postSettings: {
              for (final settings in postSettings.entries)
                settings.key.storageKey: settings.value,
            }
          },
        );
}
