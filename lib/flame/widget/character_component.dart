import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

/// キャラクターコンポーネント
class CharacterComponent extends SpriteAnimationComponent with TapCallbacks {
  /// コンストラクタ
  CharacterComponent({
    required this.name,
    required this.characterPositionX,
    required this.characterPositionY,
  });

  /// キャラクターの名前
  final String name;

  /// キャラクターの位置X
  final double characterPositionX;

  /// キャラクターの位置Y
  final double characterPositionY;

  /// 名前表示用のテキストコンポーネント
  late TextComponent nameText;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 名前表示用のテキストコンポーネントを作成
    nameText = TextComponent(
      text: name,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
      ..anchor = Anchor.center
      ..position = Vector2(15, -15);
    add(nameText);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    // キャラクターがタップされたときのアクション
    // 名前の色を赤色に変える
    nameText.textRenderer = TextPaint(
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    // 1秒後に名前の色を元に戻す
    Future.delayed(const Duration(seconds: 1), () {
      nameText.textRenderer = TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
    });

    // trueを返すとタップイベントが完了したとみなされます
    return true;
  }
}
