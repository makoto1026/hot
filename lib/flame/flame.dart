import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/flame/widget/character_component.dart';

/// フレーム
class AppFlame extends FlameGame with TapDetector, HasGameRef {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteAnimationComponent myCharacter;
  late SpriteAnimationComponent character2;
  late SpriteAnimationComponent character3;

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 2.5;
  final double returnSpeed = 2.5;

  /// アニメーションとアイドル画像
  late Sprite idleSprite;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkLeftAnimation;
  late SpriteAnimation walkRightAnimation;

  // ターゲット位置と移動中フラグ
  Vector2? targetPosition;
  double elapsedTime = 0;
  double returnDuration = 0; // 戻りにかかる時間

  @override
  Future<void> onLoad() async {
    // マップの読み込みと表示
    map = SpriteComponent()
      ..sprite = await loadSprite('map.png')
      ..size = size;
    add(map);

    // アイドル状態の画像（待機状態）
    idleSprite = await loadSprite('character.png'); // idle.png はアイドル状態の画像

    // 歩行アニメーションの読み込みと設定
    final spriteSheet = await images.load('cat.png'); // 添付された歩行アニメーションスプライトシート
    walkUpAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 144),
      ),
    );

    walkDownAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 0),
      ),
    );

    walkLeftAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 48),
      ),
    );

    walkRightAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 96),
      ),
    );

    final character2SpriteSheet =
        await images.load('character_2.png'); // 添付された歩行アニメーションスプライトシート
    final character2Animation = SpriteAnimation.fromFrameData(
      character2SpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.1, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
      ),
    );

    final character3SpriteSheet =
        await images.load('character_3.png'); // 添付された歩行アニメーションスプライトシート
    final character3Animation = SpriteAnimation.fromFrameData(
      character3SpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.1, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
      ),
    );

    // キャラクターの読み込みと表示
    myCharacter = CharacterComponent(
      name: 'じぶん',
      characterPositionX: size.x / 2,
      characterPositionY: size.y / 2,
    )
      ..animation =
          SpriteAnimation.spriteList([idleSprite], stepTime: double.infinity)
      ..size = Vector2(32, 48) // キャラクターサイズを設定
      ..position = Vector2(size.x / 2, size.y / 2); // 初期位置を画面中央に設定

    // キャラクターの読み込みと表示
    character2 = CharacterComponent(
      name: '友だち１',
      characterPositionX: size.x / 3,
      characterPositionY: size.y / 3,
    )
      ..animation = character2Animation
      ..size = Vector2(32, 48) // キャラクターサイズを設定
      ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    // キャラクターの読み込みと表示
    character3 = CharacterComponent(
      name: '友だち２',
      characterPositionX: size.x / 1.5,
      characterPositionY: size.y / 1.5,
    )
      ..animation = character3Animation
      ..size = Vector2(32, 48) // キャラクターサイズを設定
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

    // ターゲット位置がない場合のみジョイスティック入力を反映
    if (targetPosition == null && joystick.delta != Vector2.zero()) {
      final delta = joystick.delta;

      // キャラクターの向きを判定してアニメーションを設定
      if (delta.x.abs() > delta.y.abs()) {
        if (delta.x < 0) {
          myCharacter.animation = walkLeftAnimation;
        } else {
          myCharacter.animation = walkRightAnimation;
        }
      } else {
        if (delta.y < 0) {
          myCharacter.animation = walkUpAnimation;
        } else {
          myCharacter.animation = walkDownAnimation;
        }
      }

      // キャラクターを移動させる
      myCharacter.position += delta * moveSpeed * dt;

      // ターゲット位置が設定されている場合、そこへスムーズに移動
      Future.delayed(Duration(seconds: 3), () {
        if (targetPosition == null) {
          targetPosition = Vector2(size.x / 2, size.y / 2);
          elapsedTime = 0;

          // 距離に基づいて戻りにかかる時間を計算
          double distance = myCharacter.position.distanceTo(targetPosition!);
          returnDuration = distance / returnSpeed; // 距離と速度から時間を計算
        }
      });
    } else if (joystick.delta == Vector2.zero() && targetPosition == null) {
      // ジョイスティックの入力がない場合はアイドル状態に戻す
      myCharacter.animation =
          SpriteAnimation.spriteList([idleSprite], stepTime: double.infinity);
    }

    if (targetPosition != null) {
      elapsedTime += dt;
      final t = (elapsedTime / returnDuration).clamp(0, 1);

      // カスタム線形補間を使用して位置をスムーズに更新
      myCharacter.position = Vector2(
        myCharacter.position.x +
            (targetPosition!.x - myCharacter.position.x) * t,
        myCharacter.position.y +
            (targetPosition!.y - myCharacter.position.y) * t,
      );
    }
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void setCharacterPositionFromGeoLocate(double x, double y) {
    myCharacter.position = Vector2(x, y) * moveSpeed * 0.01;
  }
}
