import 'package:flutter/material.dart';

import 'circle_avatar_network.dart';
import 'profile_with_name.dart';

class AvatarProfile extends StatelessWidget {
  final String? image;
  final String? name;
  final double? size;
  const AvatarProfile(
      {super.key, required this.image, required this.name, this.size});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (image == null) {
          return ProfileWithName(name ?? "  ", size: size ?? 50);
        } else {
          return CircleAvatarNetwork(image, size: size ?? 50);
        }
      },
    );
  }
}
