import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

/// サンプル情報です。
@freezed
class User with _$User {
  /// コンストラクタ
  const factory User({
    required String sampleId,
  }) = _User;

  /// JSONからUserに変換します。
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
