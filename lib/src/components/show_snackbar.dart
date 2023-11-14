import 'package:flutter/material.dart';

enum SnackBarType { success, warning, error }

void showSnackbar(BuildContext context, String title, {SnackBarType? type}) {
  Color color = Colors.black;
  switch (type) {
    case SnackBarType.success:
      color = Colors.green;
      break;
    case SnackBarType.warning:
      color = Colors.orange;
      break;
    case SnackBarType.error:
      color = Colors.red;
      break;
    default:
      color = Colors.black;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Text(title),
    ),
  );
}
