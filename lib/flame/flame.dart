import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hub_of_talking/features/location/domain/location.dart';
import 'package:hub_of_talking/features/user/domain/user.dart';
import 'package:hub_of_talking/flame/member.dart';
import 'package:hub_of_talking/flame/widget/character_component.dart';

typedef UserId = String;

/// フレーム
// 部屋の四隅の座標
class GPSPoint {
  GPSPoint(this.latitude, this.longitude);
  final double latitude;
  final double longitude;
}

// 部屋の四隅の座標を指定
final GPSPoint topLeft = GPSPoint(35.6895, 139.6917); // 左上
final GPSPoint topRight = GPSPoint(35.6895, 139.7000); // 右上
final GPSPoint bottomLeft = GPSPoint(35.6850, 139.6917); // 左下
final GPSPoint bottomRight = GPSPoint(35.6850, 139.7000); // 右下

// 擬似マップの大きさ（ピクセル単位）
const double mapWidth = 500;
const double mapHeight = 500;

class AppFlame extends FlameGame with TapDetector {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteComponent me;
  late Map<UserId, Member> members = {};

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 4;

// 現在位置を部屋の四隅を基準に擬似マップ上の相対位置に変換する関数
  Vector2 getRelativePosition(GPSPoint currentPosition) {
    // 緯度経度の範囲を計算
    final latitudeRange = topLeft.latitude - bottomLeft.latitude;
    final longitudeRange = topRight.longitude - topLeft.longitude;

    // 現在位置の相対的なX, Y位置を算出
    final relativeX =
        ((currentPosition.longitude - topLeft.longitude) / longitudeRange) *
            mapWidth;
    final relativeY =
        ((topLeft.latitude - currentPosition.latitude) / latitudeRange) *
            mapHeight;

    return Vector2(relativeX, relativeY);
  }

  @override
  Future<void> onLoad() async {
    // マップの読み込みと表示
    map = SpriteComponent()
      ..sprite = await loadSprite('map.png')
      ..size = size;
    add(map);

    // // キャラクターの読み込みと表示
    me = CharacterComponent(
      name: 'じぶん',
      characterPositionX: size.x / 2,
      characterPositionY: size.y / 2,
    )
      ..sprite = await loadSprite('character.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 2, size.y / 2); // 初期位置を画面中央に設定

    // // キャラクターの読み込みと表示
    // character2 = CharacterComponent(
    //   name: '友だち１',
    //   characterPositionX: size.x / 3,
    //   characterPositionY: size.y / 3,
    // )
    //   ..sprite = await loadSprite('character_2.png')
    //   ..size = Vector2(32, 32) // キャラクターサイズを設定
    //   ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    // // キャラクターの読み込みと表示
    // character3 = CharacterComponent(
    //   name: '友だち２',
    //   characterPositionX: size.x / 1.5,
    //   characterPositionY: size.y / 1.5,
    // )
    //   ..sprite = await loadSprite('character_3.png')
    //   ..size = Vector2(32, 32) // キャラクターサイズを設定
    //   ..position = Vector2(size.x / 1.5, size.y / 1.5); // 初期位置を画面中央に設定

    add(me);
    // add(character2);
    // add(character3);

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
    me.priority = 1;
  }

  Future<void> addMember(User user) async {
    //もし存在してたら何もしない
    if (members.containsKey(user.id)) {
      return;
    }

    final character = CharacterComponent(
      name: '友だち１',
      characterPositionX: size.x / 3,
      characterPositionY: size.y / 3,
    )
      ..sprite = await loadSprite('character_2.png')
      ..size = Vector2(32, 32) // キャラクターサイズを設定
      ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    members[user.id] = Member(user: user, spriteComponent: character);
    add(character);
  }

  Future<void> updateLocation(Location location) async {
    members[location.userId]!.spriteComponent.position =
        getRelativePosition(GPSPoint(location.latitude, location.longitude));
  }

  @override
  void update(double dt) {
    super.update(dt);
    print('update');
    me.position += joystick.delta * moveSpeed * 0.01;
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void updateMeLocation(Position position) {
    print('updateMeLocation');
    final relativePosition =
        getRelativePosition(GPSPoint(position.latitude, position.longitude));
    me.position =
        Vector2(relativePosition.x, relativePosition.y) * moveSpeed * 0.01;
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void setMeLocation() {
    print('updateMeLocation');
    me.position = Vector2(0, 0) * moveSpeed * 0.01;
  }
}
