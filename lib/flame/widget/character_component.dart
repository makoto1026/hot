import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as ui;

/// キャラクターコンポーネント
class CharacterComponent extends SpriteAnimationComponent
    with TapCallbacks, HasGameRef, CollisionCallbacks {
  /// コンストラクタ
  CharacterComponent({
    required this.name,
    required this.characterPositionX,
    required this.characterPositionY,
    required this.onTap,
    this.overlayImageUrl,
    this.isMe = false,
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

  /// 重ねる画像のURL（https:// から始まるURL）
  final String? overlayImageUrl;

  /// 重ねる画像用のスプライトコンポーネント
  SpriteComponent? overlayImageComponent;

  /// 縁取り用のスプライトコンポーネント
  SpriteComponent? borderImageComponent;

  /// 自分自身かどうか
  final bool isMe;

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
      ..position = Vector2(15, isMe ? -15 : -55);
    add(nameText);

    if (!isMe) {
      // 縁取り画像の追加
      final borderSprite = await Sprite.load('white_border.png');
      borderImageComponent = SpriteComponent()
        ..sprite = borderSprite
        ..size = Vector2(60, 60)
        ..position = Vector2(-15, -40)
        ..add(RectangleHitbox()..size = Vector2(60, 60));
      add(borderImageComponent!);

      // タップ検知用のヒットボックスを追加
      add(
        RectangleHitbox()
          ..size = Vector2(60, 60)
          ..anchor = Anchor.center,
      );

      // ネットワーク画像の読み込みとエラーハンドリング
      Sprite overlaySprite;
      try {
        overlaySprite = await _loadNetworkSprite(overlayImageUrl);
      } catch (_) {
        overlaySprite = await Sprite.load('placeholder.png'); // プレースホルダー画像
      }

      overlayImageComponent = SpriteComponent()
        ..sprite = overlaySprite
        ..size = Vector2(50, 50)
        ..position = Vector2(-10, -35)
        ..add(RectangleHitbox()..size = Vector2(50, 50));
      add(overlayImageComponent!);
    }

    // 親コンポーネント自体のタップ範囲設定
    add(
      RectangleHitbox()
        ..size = Vector2(80, 80)
        ..anchor = Anchor.center,
    );
  }

  /// ネットワーク画像の読み込み処理
  Future<Sprite> _loadNetworkSprite(String? imageUrl) async {
    final networkImage = ui.NetworkImage(
      imageUrl != '' && imageUrl != null
          ? imageUrl
          : 'https://placehold.jp/50x50.png',
    );
    final imageStream = networkImage.resolve(ui.ImageConfiguration());
    final completer = Completer<Sprite>();

    imageStream.addListener(
      ImageStreamListener(
        (ImageInfo info, _) {
          completer.complete(Sprite(info.image));
        },
        onError: (Object error, StackTrace? stackTrace) {
          completer.completeError(error); // エラーをCompleterに渡す
        },
      ),
    );

    return completer.future;
  }

  @override
  bool onTapDown(TapDownEvent event) {
    onTap();
    return true;
  }
}
