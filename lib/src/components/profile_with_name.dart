import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orgasync/src/config/theme/colors.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

class ProfileWithName extends StatelessWidget {
  final String? name;
  final double? size;

  const ProfileWithName(this.name, {super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: colors[Random().nextInt(colors.length)],
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Center(
          child: Text(
            (name ?? "  ").substring(0, 2).toUpperCase(),
            style:
                TextStyle(fontSize: size! * 0.5, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
