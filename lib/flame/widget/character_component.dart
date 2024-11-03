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
    required this.onTap,
  });

  /// キャラクターの名前
  final String name;

  /// キャラクターの位置X
  final double characterPositionX;

  /// キャラクターの位置Y
  final double characterPositionY;

  /// 名前表示用のテキストコンポーネント
  late TextComponent nameText;

  /// タップ時のコールバック
  final void Function() onTap;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 名前表示用のテキストコンポーネントを作成
    nameText = TextComponent(
      text: name,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
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
    onTap();
    // trueを返すとタップイベントが完了したとみなされます
    return true;
  }
}
