import 'package:flutter/material.dart';

extension FormattedLocale on Locale {
  /// Returns the formatted locale string.
  String get formattedLocale {
    if (languageCode == "id") {
      return "Indonesia";
    } else {
      return "English";
    }
  }
}
