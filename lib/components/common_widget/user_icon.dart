import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
    required this.imageUrl,
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
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(
            height: 100,
            width: 100,
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
        Assets.images.iconFrame.image(
          height: 110,
          width: 110,
        ),
      ],
    );
  }
}
