import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  /// コンストラクタ
  const factory User({
    required String id,
    required String name,
    required String thumbnail,
    required String snsUrl,
    required String product,
  }) = _User;

  /// JSONからUserに変換します。
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
