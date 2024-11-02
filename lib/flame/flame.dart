import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/flame/widget/character_component.dart';

/// フレーム
class AppFlame extends FlameGame with TapDetector {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteComponent myCharacter;
  late SpriteComponent character2;
  late SpriteComponent character3;

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 4;

  @override
  Future<void> onLoad() async {
    // マップの読み込みと表示
    map = SpriteComponent()
      ..sprite = await loadSprite('map.png')
      ..size = size;
    add(map);

    // キャラクターの読み込みと表示
    myCharacter = CharacterComponent(
      name: 'じぶん',
      characterPositionX: size.x / 2,
      characterPositionY: size.y / 2,
    )
      ..sprite = await loadSprite('character.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 2, size.y / 2); // 初期位置を画面中央に設定

    // キャラクターの読み込みと表示
    character2 = CharacterComponent(
      name: '友だち１',
      characterPositionX: size.x / 3,
      characterPositionY: size.y / 3,
    )
      ..sprite = await loadSprite('character_2.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    // キャラクターの読み込みと表示
    character3 = CharacterComponent(
      name: '友だち２',
      characterPositionX: size.x / 1.5,
      characterPositionY: size.y / 1.5,
    )
      ..sprite = await loadSprite('character_3.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 1.5, size.y / 1.5); // 初期位置を画面中央に設定

    add(myCharacter);
    add(character2);
    add(character3);

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

    /// myCharacterを画面の一番上に表示する
    myCharacter.priority = 1;
  }

  @override
  void update(double dt) {
    super.update(dt);
    myCharacter.position += joystick.delta * moveSpeed * 0.01;
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void setCharacterPositionFromGeoLocate(double x, double y) {
    myCharacter.position = Vector2(x, y) * moveSpeed * 0.01;
  }
}
