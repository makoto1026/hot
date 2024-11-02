import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hub_of_talking/features/location/domain/location.dart';
import 'package:hub_of_talking/features/user/domain/user.dart';

part 'member.freezed.dart';

/// サンプル情報です。
@freezed
class Member with _$Member {
  /// コンストラクタ
  const factory Member({
    required User user,
    Location? location,
    required SpriteAnimationComponent spriteComponent,
  }) = _Member;
}
