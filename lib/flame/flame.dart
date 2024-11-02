import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/// フレームワークのサンプルです。
class AppFlame extends FlameGame with TapDetector {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteComponent character;

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 3;

  @override
  Future<void> onLoad() async {
    // マップの読み込みと表示
    map = SpriteComponent()
      ..sprite = await loadSprite('map.png')
      ..size = size;
    add(map);

    // キャラクターの読み込みと表示
    character = SpriteComponent()
      ..sprite = await loadSprite('character.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 2, size.y / 2); // 初期位置を画面中央に設定
    add(character);

    // TODO(tera): 不要になるので消す。イメージしやすいようにセットしているだけです。
    // ジョイスティックの追加
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: BasicPalette.white.paint()),
      background: CircleComponent(
        radius: 45,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      margin: const EdgeInsets.only(left: 16, bottom: 16),
    );

    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    character.position += joystick.delta * moveSpeed * 0.01;
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void setCharacterPositionFromGeoLocate(double x, double y) {
    character.position = Vector2(x, y) * moveSpeed * 0.01;
  }
}
