/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAppIconGen {
  const $AssetsAppIconGen();

  /// File path: assets/app_icon/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/app_icon/app_icon.png');

  /// File path: assets/app_icon/app_icon_dev.png
  AssetGenImage get appIconDev =>
      const AssetGenImage('assets/app_icon/app_icon_dev.png');

  /// File path: assets/app_icon/app_icon_foreground.png
  AssetGenImage get appIconForeground =>
      const AssetGenImage('assets/app_icon/app_icon_foreground.png');

  /// File path: assets/app_icon/app_icon_foreground_dev.png
  AssetGenImage get appIconForegroundDev =>
      const AssetGenImage('assets/app_icon/app_icon_foreground_dev.png');

  /// File path: assets/app_icon/app_icon_foreground_stg.png
  AssetGenImage get appIconForegroundStg =>
      const AssetGenImage('assets/app_icon/app_icon_foreground_stg.png');

  /// File path: assets/app_icon/app_icon_stg.png
  AssetGenImage get appIconStg =>
      const AssetGenImage('assets/app_icon/app_icon_stg.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        appIcon,
        appIconDev,
        appIconForeground,
        appIconForegroundDev,
        appIconForegroundStg,
        appIconStg
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cat.png
  AssetGenImage get cat => const AssetGenImage('assets/images/cat.png');

  /// File path: assets/images/character.png
  AssetGenImage get character =>
      const AssetGenImage('assets/images/character.png');

  /// File path: assets/images/character_2.png
  AssetGenImage get character2 =>
      const AssetGenImage('assets/images/character_2.png');

  /// File path: assets/images/character_3.png
  AssetGenImage get character3 =>
      const AssetGenImage('assets/images/character_3.png');

  /// File path: assets/images/exit.png
  AssetGenImage get exit => const AssetGenImage('assets/images/exit.png');

  /// File path: assets/images/man.png
  AssetGenImage get man => const AssetGenImage('assets/images/man.png');

  /// File path: assets/images/man_idle.png
  AssetGenImage get manIdle =>
      const AssetGenImage('assets/images/man_idle.png');

  /// File path: assets/images/man_walk.png
  AssetGenImage get manWalk =>
      const AssetGenImage('assets/images/man_walk.png');

  /// File path: assets/images/map.png
  AssetGenImage get map => const AssetGenImage('assets/images/map.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        cat,
        character,
        character2,
        character3,
        exit,
        man,
        manIdle,
        manWalk,
        map
      ];
}

class Assets {
  Assets._();

  static const $AssetsAppIconGen appIcon = $AssetsAppIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
