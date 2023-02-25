import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/main/settings/theme/theme_mode/theme_mode_state_provider.dart';

final themeModeIconProvider = Provider<IconData>((ref) {
  IconData icon;
  final themeMode = ref.watch(themeModeStateProvider);
  if (themeMode == ThemeMode.light) {
    icon = Icons.dark_mode_outlined;
  } else {
    icon = Icons.light_mode_outlined;
  }
  return icon;
});
