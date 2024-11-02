import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

/// フレームワークのサンプルです。
class AppFlame extends FlameGame with TapDetector {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteComponent character;

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
  }

  @override
  void onTapDown(TapDownInfo info) {
    // タップした位置にキャラクターが移動
    character.position = Vector2(1, 1); // 中央に配置
  }
}
