import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kReleaseMode) {
    // ignore: avoid_print
    log("Running in debug mode", name: "Debug Mode");
  }
  if(!kIsWeb){
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // ignore: avoid_print
      log("Running in desktop mode", name: "Desktop Mode");
      windowManager.waitUntilReadyToShow().then((value) async {
        windowManager.setTitle("Orgasync");
        await windowManager.setTitleBarStyle(TitleBarStyle.normal);
        await windowManager.setBackgroundColor(Colors.transparent);
        await windowManager.setSize(const Size(1920, 1080));
        await windowManager.setMinimumSize(const Size(600, 545));
        await windowManager.show();
        await windowManager.setSkipTaskbar(false);
      });
    }
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', "US"), Locale('id')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', "US"),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}
