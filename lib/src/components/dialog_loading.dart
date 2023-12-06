import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: LoadingAnimationWidget.threeRotatingDots(
          color: context.theme.colorScheme.onBackground,
          size: 30,
        ),
      ),
    );
  }
}
