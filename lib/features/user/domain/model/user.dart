import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)

  /// コンストラクタ
  const factory User({
    required String id,
    required String displayName,
    required String thumbnail,
    required String snsUrl,
    required String product,
    required String deviceId,
  }) = _User;

  /// JSONからUserに変換します。
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
