import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/fetaures/theme/provider/theme_notifier.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref.watch(storageProvider));
});
