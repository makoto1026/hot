import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String name,
    @Default('') String SnsLink,
    @Default('') String thumbnail,
    @Default('') String product,
  }) = _LoginState;
  const LoginState._();
}
