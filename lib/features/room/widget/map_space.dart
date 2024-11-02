import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/flame/flame.dart';

/// マップスペースです。
class MapSpace extends StatelessWidget {
  /// コンストラクタ
  const MapSpace({super.key});

  @override
  Widget build(BuildContext context) {
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
