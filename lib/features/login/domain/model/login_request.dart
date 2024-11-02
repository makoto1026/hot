import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';

part 'login_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  /// コンストラクタ
  const factory LoginRequest({
    required String displayName,
    required String thumbnail,
    required String snsUrl,
    required String product,
  }) = _LoginRequest;

  /// JSONからLoginRequestに変換します。
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
