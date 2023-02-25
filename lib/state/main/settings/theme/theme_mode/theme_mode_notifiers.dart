import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark);

  Future<void> toggleThemeMode() async {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
