import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/constants/firebase_field_name.dart';

import '../../posts/typedef/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    this.email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
          },
        );

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
        );

  @override
  bool operator ==(covariant UserInfoModel other) =>
      identical(this, other) &&
      userId == other.userId &&
      displayName == other.displayName &&
      email == other.email;

  @override
  int get hashCode => Object.hashAll([
        userId,
        displayName,
        email,
      ]);
}
