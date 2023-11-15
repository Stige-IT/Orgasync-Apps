import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 24,
          height: 24,
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: context.theme.primaryColorDark,
            rightDotColor: context.theme.primaryColorLight,
            size: 24,
          )),
    );
  }
}
