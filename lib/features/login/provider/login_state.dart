import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
  }) = _LoginState;
  const LoginState._();
}
