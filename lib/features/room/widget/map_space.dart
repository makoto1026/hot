import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/location/provide/location_manager.dart';
import 'package:hub_of_talking/flame/flame.dart';

/// マップスペースです。
class MapSpace extends HookConsumerWidget {
  /// コンストラクタ
  const MapSpace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationProvider = ref.watch(locationManagerProvider);

    /// TODO(tera): 位置情報をマップに反映します（WIP）
    useEffect(
      () {
        final appFlame = AppFlame();
        // AsyncValueの状態が変わったら呼ばれる
        final location = locationProvider.asData?.value;

        if (location != null) {
          appFlame.setCharacterPositionFromGeoLocate(
            location.longitude,
            location.latitude,
          );
        }
        return null;
      },
      [locationProvider],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
      ),
      backgroundColor: Colors.green[50],
      body: GameWidget(
        game: AppFlame(),
      ),
    );
  }
}
