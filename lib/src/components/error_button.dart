import 'package:flutter/material.dart';

class ErrorButtonWidget extends StatelessWidget {
  final String errorMsg;
  final void Function()? onTap;
  const ErrorButtonWidget(
      this.errorMsg,
      this.onTap, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.refresh),
        label: Text(errorMsg),
      ),
    );
  }
}