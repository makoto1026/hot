import 'dart:async';
import 'dart:io';

import 'package:flutter_sample/features/login/provider/login_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends AutoDisposeAsyncNotifier<LoginState> {
  Login();

  int? forceResendingToken;
  Timer? resendTimer;

  void inputPhoneNumber(String phoneNumber) {
    state = AsyncValue.data(
      state.requireValue.copyWith(phoneNumber: phoneNumber),
    );
  }

  void handleError() {
    state = AsyncValue.data(state.requireValue);
  }

  Future<void> login({required String smsCode}) async {
    state = await AsyncValue.guard(() async {
      final accessToken =
          await ref.read(servicesProvider).authentication.verifySmsCode(
                verificationId: state.requireValue.verificationId,
                smsCode: smsCode,
              );

      final fcmToken = await FirebaseMessaging.instance.getToken() ?? '';

      final apiToken = await ref.read(servicesProvider).authentication.logIn(
            LoginRequest(
              phoneNumber: state.requireValue.phoneNumber,
              firebaseAccessToken: accessToken,
              deviceId: state.requireValue.deviceId.value,
              fcmToken: fcmToken,
            ),
          );

      await ref.read(servicesProvider).localStorage.write(
            key: 'refreshToken',
            value: apiToken.refreshToken,
            isSecure: true,
          );

      ref.read(apiTokenHolderProvider.notifier).apiToken = apiToken;

      return state.requireValue;
    });
  }

  Future<void> verifyPhoneNumber() async {
    final completer = Completer<void>();

    try {
      await ref
          .read(servicesProvider)
          .authentication
          .incrementAuthCount(state.requireValue.deviceId);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
    try {
      ref.read(servicesProvider).authentication.verifyPhoneNumber(
            phoneNumber: '+81${state.requireValue.phoneNumber.substring(
              1,
              state.requireValue.phoneNumber.length,
            )}',
            verificationFailed: (exception) {
              state = AsyncError(exception, StackTrace.current);
              completer.completeError(exception);
              return;
            },
            codeSent: (verificationId, forceResendingToken) {
              state = AsyncValue.data(
                state.requireValue.copyWith(verificationId: verificationId),
              );
              completer.complete();
            },
            forceResendingToken: forceResendingToken,
          );
    } on Exception {
      rethrow;
    }

    return completer.future;
  }

  Future<void> resend({required void Function() codeSent}) async {
    try {
      await ref
          .read(servicesProvider)
          .authentication
          .incrementAuthCount(state.requireValue.deviceId);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
    state = AsyncValue.data(
      state.requireValue.copyWith(enabledResend: false),
    );
    resendTimer?.cancel();

    resendTimer = Timer(const Duration(seconds: 30), () {
      state = AsyncValue.data(
        state.requireValue.copyWith(enabledResend: true),
      );
    });

    return verifyPhoneNumber();
  }

  @override
  Future<LoginState> build() async {
    return const LoginState();
  }
}

final loginProvider =
    AsyncNotifierProvider.autoDispose<Login, LoginState>(Login.new);
