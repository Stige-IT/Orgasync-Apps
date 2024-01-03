import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/config/routes.dart';
import 'package:orgasync/src/config/theme/theme.dart';

import 'fetaures/theme/provider/theme_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    Future.microtask(()=> ref.read(themeProvider.notifier).getTheme());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false, // uncomment this line to hide for release
      title: "Orgasync",
      routes: AppRoute.routes,
      initialRoute: "/splash",
      themeMode: themeMode,
      theme: AppTheme.themeData,
      darkTheme: AppTheme.darkThemeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
