import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hub_of_talking/features/page/web_view_page.dart';
import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/flame/member.dart';
import 'package:hub_of_talking/flame/widget/character_component.dart';

typedef UserId = String;

/// フレーム
// 部屋の四隅の座標
class GPSPoint {
  /// コンストラクタ
  GPSPoint(this.latitude, this.longitude);

  /// 緯度
  final double latitude;

  /// 経度
  final double longitude;
}

/// 部屋の四隅の座標を指定
final GPSPoint topLeft = GPSPoint(35.66244977971531, 139.69611780001182);

/// 右上
final GPSPoint topRight = GPSPoint(35.66244977971531, 139.6961201177803);

/// 左下
final GPSPoint bottomLeft = GPSPoint(35.66243408820496, 139.69608109696554);

/// 右下
final GPSPoint bottomRight = GPSPoint(35 / 662432616337284, 139.69607877919705);

/// 擬似マップの大きさ（ピクセル単位）
const double mapWidth = 1231;

/// 擬似マップの大きさ（ピクセル単位）
const double mapHeight = 1112;

/// フレーム
class AppFlame extends FlameGame with TapDetector, HasGameRef {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteAnimationComponent me;

  /// キャラクター
  late SpriteAnimationComponent character2;

  /// キャラクター
  late SpriteAnimationComponent character3;

  /// キャラクター
  late Map<UserId, Member> members = {};

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 2.5;

  /// 戻り速度
  final double returnSpeed = 2.5;

  /// アニメーションとアイドル画像
  late Sprite idleSprite;
  late Sprite memberIdleSprite;
  late SpriteAnimation walkUpAnimation;
  late SpriteAnimation walkDownAnimation;
  late SpriteAnimation walkLeftAnimation;
  late SpriteAnimation walkRightAnimation;

  // ターゲット位置と移動中フラグ
  Vector2? targetPosition;
  double elapsedTime = 0;
  double returnDuration = 0; // 戻りにかかる時間

  @override
  bool isLoaded = false;

  /// 現在位置を部屋の四隅を基準に擬似マップ上の相対位置に変換する関数
  Vector2 getRelativePosition(GPSPoint currentPosition) {
    final random = Random();
    // 緯度経度の範囲を計算
    final latitudeRange = topLeft.latitude - bottomLeft.latitude;
    final longitudeRange = topRight.longitude - topLeft.longitude;

    // 範囲外チェック
    final isOutOfLatitudeRange =
        currentPosition.latitude < bottomLeft.latitude ||
            currentPosition.latitude > topLeft.latitude;
    final isOutOfLongitudeRange =
        currentPosition.longitude < topLeft.longitude ||
            currentPosition.longitude > topRight.longitude;

    // 緯度が範囲外ならランダムな緯度を生成
    final latitude = isOutOfLatitudeRange
        ? bottomLeft.latitude + random.nextDouble() * latitudeRange
        : currentPosition.latitude;

    // 経度が範囲外ならランダムな経度を生成
    final longitude = isOutOfLongitudeRange
        ? topLeft.longitude + random.nextDouble() * longitudeRange
        : currentPosition.longitude;

    // 緯度・経度の相対位置をピクセル座標に変換
    final relativeX =
        ((longitude - topLeft.longitude) / longitudeRange) * mapWidth;
    final relativeY =
        ((topLeft.latitude - latitude) / latitudeRange) * mapHeight;

    return Vector2(relativeX, relativeY);
  }

  /// ユーザー情報ダイアログを表示
  void showUserInfoDialog(User user) {
    // FlutterのshowDialogを使用してユーザー情報ダイアログを表示
    showDialog<String>(
      context: gameRef.buildContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${user.displayName}さん'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'SNS: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(); // ダイアログを閉じる
                        showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return WebViewPage(url: user.snsUrl);
                          },
                        );
                      },
                      child: Text(
                        user.snsUrl,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  'プロダクト: ${user.product}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> onLoad() async {
    // マップの読み込みと表示
    final mapSprite = await loadSprite('map.png');
    map = SpriteComponent()
      ..sprite = mapSprite
      ..size = mapSprite.srcSize;

    // アイドル状態の画像（待機状態）
    idleSprite = await loadSprite('man.png'); // idle.png はアイドル状態の画像

    // 歩行アニメーションの読み込みと設定
    final spriteSheet =
        await images.load('man_walk.png'); // 添付された歩行アニメーションスプライトシート
    walkUpAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 144),
      ),
    );

    walkDownAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 0),
      ),
    );

    walkLeftAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 48),
      ),
    );

    walkRightAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.3, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
        texturePosition: Vector2(0, 96),
      ),
    );

    const user = User(
      id: '1',
      displayName: 'じぶん',
      thumbnail: 'https://placehold.jp/50x50.png',
      snsUrl: 'snsUrl',
      product: 'product',
      deviceId: 'deviceId',
    );

    // // キャラクターの読み込みと表示
    me = CharacterComponent(
      name: 'じぶん',
      characterPositionX: size.x / 2,
      characterPositionY: size.y / 2,
      onTap: () => showUserInfoDialog(user),
      isMe: true,
    )
      ..animation = SpriteAnimation.spriteList(
        [idleSprite],
        stepTime: double.infinity,
      )
      ..size = Vector2(32, 48) // キャラクターサイズを設定
      ..position = Vector2(size.x / 2, size.y / 2); // 初期位置を画面中央に設定

    // TODO(tera): 不要になるので消す。イメージしやすいようにセットしているだけです。
    // ジョイスティックの追加
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: BasicPalette.white.paint()),
      background: CircleComponent(
        radius: 45,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      position: Vector2(size.x / 2, size.y - 100),
    );

    gameRef.world.add(map);
    gameRef.world.add(me);
    camera.viewport.add(joystick);

    /// meを画面の一番上に表示する
    me.priority = 1;

    isLoaded = true;
  }

  /// メンバー追加
  Future<void> addMember(User user) async {
    if (!isLoaded) {
      return;
    }
    // TODO(tera): onLoadedとの兼ね合いでこのままだと動かない
    //もし存在してたら何もしない
    if (members.containsKey(user.id)) {
      return;
    }
    // アイドル状態の画像（待機状態）
    memberIdleSprite = await loadSprite('man.png'); // idle.png はアイドル状態の画像

    final character = CharacterComponent(
      name: user.displayName,
      characterPositionX: size.x / 3,
      characterPositionY: size.y / 3,
      onTap: () => showUserInfoDialog(user),
      overlayImageUrl: user.thumbnail,
    )
      ..animation = SpriteAnimation.spriteList(
        [memberIdleSprite],
        stepTime: double.infinity,
      )
      ..size = Vector2(32, 48) // キャラクターサイズを設定
      ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    members[user.id] = Member(user: user, spriteComponent: character);
    gameRef.world.add(character);
  }

  Future<void> updateLocation(Location location) async {
    print('updateLocation');
    print(
      getRelativePosition(GPSPoint(location.latitude, location.longitude)).x,
    );
    print(
      getRelativePosition(GPSPoint(location.latitude, location.longitude)).y,
    );
    members[location.userId]?.spriteComponent.position =
        getRelativePosition(GPSPoint(location.latitude, location.longitude));
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
          me.animation = walkLeftAnimation;
        } else {
          me.animation = walkRightAnimation;
        }
      } else {
        if (delta.y < 0) {
          me.animation = walkUpAnimation;
        } else {
          me.animation = walkDownAnimation;
        }
      }

      // 新しい位置を計算
      final newPosition = me.position + delta * moveSpeed * dt;

      // マップの境界チェック
      newPosition.x = newPosition.x.clamp(0, mapWidth - me.size.x);
      newPosition.y = newPosition.y.clamp(0, mapHeight - me.size.y);

      // キャラクターの位置を更新
      me.position = newPosition;

      // // TODO(tera): positionを自動で更新するコード、後で消す
      // Future.delayed(Duration(seconds: 3), () {
      //   if (targetPosition == null) {
      //     targetPosition = Vector2(size.x / 2, size.y / 2);
      //     elapsedTime = 0;

      //     // 距離に基づいて戻りにかかる時間を計算
      //     double distance = me.position.distanceTo(targetPosition!);
      //     returnDuration = distance / returnSpeed; // 距離と速度から時間を計算
      //   }
      // });
    } else if (joystick.delta == Vector2.zero() && targetPosition == null) {
      // ジョイスティックの入力がない場合はアイドル状態に戻す
      me.animation =
          SpriteAnimation.spriteList([idleSprite], stepTime: double.infinity);
    }

    if (targetPosition != null) {
      elapsedTime += dt;
      final t = (elapsedTime / returnDuration).clamp(0, 1);

      // カスタム線形補間を使用して位置をスムーズに更新
      me.position = Vector2(
        me.position.x + (targetPosition!.x - me.position.x) * t,
        me.position.y + (targetPosition!.y - me.position.y) * t,
      );
    }

    camera.follow(me);
  }

  /// X座標、Y座標を指定してキャラクターの位置を設定します。
  void updateMeLocation(Position position) {
    final relativePosition =
        getRelativePosition(GPSPoint(position.latitude, position.longitude));

    me.position = Vector2(relativePosition.x, relativePosition.y);
  }
}
