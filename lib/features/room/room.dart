import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/flame/flame.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Roomページです。
class RoomPage extends HookConsumerWidget {
  /// コンストラクタ
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
