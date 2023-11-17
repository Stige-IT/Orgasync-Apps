import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty.png", width: 200),
        const SizedBox(height: 20),
        Text("empty".tr(), style: context.theme.textTheme.bodyLarge)
      ],
    ));
  }
}
