import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../config/contants/base_url.dart';

class CircleAvatarNetwork extends StatelessWidget {
  final String? image;
  final double? size;

  const CircleAvatarNetwork(this.image,{super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size!,
      width: size!,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceVariant,
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: CircularProgressIndicator(value: progress.progress),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(child: Icon(Icons.error));
        },
        fit: BoxFit.cover,
        width: 170,
        height: 170,
        imageUrl: '${ConstantUrl.BASEIMGURL}/$image',
      ),
    );
  }
}
