import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserIcon extends HookConsumerWidget {
  const UserIcon({
    this.imageUrl,
    this.borderRadius,
    this.width,
    this.height,
    super.key,
  });
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: imageUrl != null && Uri.tryParse(imageUrl!)!.hasAbsolutePath
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: width,
              height: height,
              placeholder: (_, __) => const ColoredBox(color: Colors.white),
              errorWidget: (context, error, stackTrace) => Icon(
                Icons.person,
                size: width,
              ),
            )
          : Container(
              width: width,
              height: height,
              color: Colors.grey,
            ),
    );
  }
}
