import 'package:instagram_clone/state/image_upload/models/file_type.dart';

import '../../constants/firebase_collection_name.dart';

extension CollectionName on FileTypeEnum {
  String get collectionName {
    switch (this) {
      case FileTypeEnum.image:
        return FirebaseCollectionName.images;
      case FileTypeEnum.video:
        return FirebaseCollectionName.videos;
    }
  }
}