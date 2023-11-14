import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orgasync/src/utils/extensions/formatted_locale.dart';

class ButtonSwitchLanguage extends StatelessWidget {
  const ButtonSwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        if (context.locale == const Locale("en", "US")) {
          context.setLocale(const Locale("id"));
        } else {
          context.setLocale(const Locale("en", "US"));
        }
      },
      icon: const Icon(Icons.language),
      label: Text(context.locale.formattedLocale),
    );
  }
}
