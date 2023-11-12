import 'package:flutter/material.dart';

void nextPage(context, routeName, {Object? argument}) =>
    Navigator.pushNamed(context, routeName, arguments: argument);

void backPage(context) {
  Navigator.of(context).pop();
}

void nextPageRemove(BuildContext context, String page, {Object? argument}) {
  Navigator.pushReplacementNamed(context, page, arguments: argument);
}

void nextPageRemoveAll(BuildContext context, String page, {Object? argument}) {
  Navigator.pushNamedAndRemoveUntil(context, page, (route) => false, arguments: argument);
}