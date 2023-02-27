import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/post_settings.dart';

class PostSettingNotifier extends StateNotifier<Map<PostSettingEnum, bool>> {
  PostSettingNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSettingEnum.values) setting: true,
            },
          ),
        );

  void setSetting(
    PostSettingEnum postSetting,
    bool value,
  ) {
    final existingValue = state[postSetting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[postSetting] = value,
    );
  }
}
