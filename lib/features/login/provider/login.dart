import 'package:hub_of_talking/features/login/domain/model/login_request.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository_provider.dart';
import 'package:hub_of_talking/features/login/provider/login_state.dart';
import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login.g.dart';

@riverpod
class Login extends _$Login {
  Future<void> login() async {
    try {
      final authUser =
          await ref.read(loginRepositoryProvider).loginAnonymously();

      final user = User(
        id: authUser.id,
        displayName: state.name,
        thumbnail: state.thumbnail,
        snsUrl: state.snsLink,
        product: state.product,
      );
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.insertUser(user);
    } catch (e) {
      print('LoginNotifier: $e');
      return;
    }
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setSnsLink(String snsLink) {
    state = state.copyWith(snsLink: snsLink);
  }

  void setProduct(String product) {
    state = state.copyWith(product: product);
  }

  @override
  LoginState build() {
    return const LoginState();
  }
}
