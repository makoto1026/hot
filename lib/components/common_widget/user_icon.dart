import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
    required this.imageUrl, // imageUrlを外部から渡せるようにする
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Assets.images.iconFrame.image(
          height: 110,
          width: 110,
        ),
      ],
    );
  }
}
