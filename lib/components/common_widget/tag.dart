import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    required this.text,
    required this.backgroundColor,
    this.icon,
    this.image,
    super.key,
  });

  final String text;
  final Color backgroundColor;
  final IconData? icon;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(
        8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (image != null)
            CachedNetworkImage(
              imageUrl: image!,
              width: 15,
              height: 15,
            ),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (icon != null) Icon(icon),
        ],
      ),
    );
  }
}
