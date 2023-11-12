import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orgasync/src/config/routes.dart';
import 'package:orgasync/src/config/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false, // uncomment this line to hide for release
      title: "Orgasync",
      routes: AppRoute.routes,
      initialRoute: "/splash",
      themeMode: ThemeMode.system,
      theme: AppTheme.themeData,
      darkTheme: AppTheme.darkThemeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
