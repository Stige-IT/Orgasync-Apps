import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
