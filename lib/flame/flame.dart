import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hub_of_talking/features/page/web_view_page.dart';
import 'package:hub_of_talking/features/user/domain/model/user.dart';
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

class AppFlame extends FlameGame with TapDetector, HasGameRef {
  /// マップ
  late SpriteComponent map;

  /// キャラクター
  late SpriteAnimationComponent me;
  late SpriteAnimationComponent character2;
  late SpriteAnimationComponent character3;
  late Map<UserId, Member> members = {};

  /// ジョイスティック
  late JoystickComponent joystick;

  /// 移動速度
  final double moveSpeed = 2.5;
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

  bool isLoaded = false;

  /// 現在位置を部屋の四隅を基準に擬似マップ上の相対位置に変換する関数
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

  /// TODO(tera): 別の場所に移動する必要あるかも
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
                  InkWell(
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
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '製品: ${user.product}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
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
    map = SpriteComponent()
      ..sprite = await loadSprite('map.png')
      ..size = size;
    add(map);

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

    final character3SpriteSheet =
        await images.load('character_3.png'); // 添付された歩行アニメーションスプライトシート
    final character3Animation = SpriteAnimation.fromFrameData(
      character3SpriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4, // フレーム数 (例: スプライトシートに4フレームある場合)
        stepTime: 0.1, // 各フレームの表示時間
        textureSize: Vector2(32, 48), // 各フレームのサイズ
      ),
    );

    final user = User(
      id: '1',
      displayName: 'じぶん',
      thumbnail: 'thumbnail',
      snsUrl: 'snsUrl',
      product: 'product',
    );

    // // キャラクターの読み込みと表示
    me = CharacterComponent(
      name: 'じぶん',
      characterPositionX: size.x / 2,
      characterPositionY: size.y / 2,
      onTap: () => showUserInfoDialog(user),
    )
      ..animation = SpriteAnimation.spriteList(
        [idleSprite],
        stepTime: double.infinity,
      )
      ..size = Vector2(32, 48) // キャラクターサイズを設定
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
    )
      ..animation = SpriteAnimation.spriteList(
        [memberIdleSprite],
        stepTime: double.infinity,
      )
      ..size = Vector2(32, 48) // キャラクターサイズを設定
      ..position = Vector2(size.x / 3, size.y / 3); // 初期位置を画面中央に設定

    members[user.id] = Member(user: user, spriteComponent: character);
    add(character);
  }

  Future<void> updateLocation(Location location) async {
    print("updateLocation");
    members[location.userId]!.spriteComponent.position =
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

      // キャラクターを移動させる
      me.position += delta * moveSpeed * dt;

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
