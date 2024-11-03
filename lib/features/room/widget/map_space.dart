import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/room/provider/map.dart';

/// マップスペースです。
class MapSpace extends HookConsumerWidget {
  /// コンストラクタ
  const MapSpace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: GameWidget(
        game: ref.watch(mapProvider.notifier).flame,
      ),
    );
  }
}
