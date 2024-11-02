import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_of_talking/features/room/widget/map_space.dart';
import 'package:hub_of_talking/flame/flame.dart';

/// Roomページです。
class RoomPage extends StatelessWidget {
  /// コンストラクタ
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          context.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[50],
        ),
        backgroundColor: Colors.green[50],
        body: const MapSpace(),
      ),
    );
  }
}
