import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SecureStorage _storage;

  ThemeNotifier(this._storage) : super(ThemeMode.light);

  Future<void> getTheme() async {
    final theme = await _storage.read("theme");
    if (theme == "dark") {
      state = ThemeMode.dark;
    } else if (theme == "light") {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    if (theme == ThemeMode.dark) {
      await _storage.write("theme", "dark");
    } else if (theme == ThemeMode.light) {
      await _storage.write("theme", "light");
    } else {
      await _storage.write("theme", "system");
    }
    state = theme;
  }
}
