import 'package:hub_of_talking/features/login/domain/model/login_request.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository_provider.dart';
import 'package:hub_of_talking/features/login/provider/login_state.dart';
import 'package:hub_of_talking/features/user/domain/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  Future<void> login({required LoginRequest request}) async {
    try {
      await ref.read(loginRepositoryProvider).loginAnonymously();

      final currentUser = LoginRequest(
        displayName: request.displayName,
        thumbnail: request.thumbnail,
        snsUrl: request.snsUrl,
        product: request.product,
      );
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.insertUser(loginRequest: currentUser);
    } catch (e) {
      print('LoginNotifier: $e');
      return;
    }
  }

  @override
  Future<LoginState> build() async {
    return const LoginState();
  }
}
