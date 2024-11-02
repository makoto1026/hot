import 'package:hub_of_talking/features/user/domain/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

/// サンプルNotifierです。
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User> build() async {
    await ref.watch(userRepositoryProvider).fetchUsers();
    return const User(
      id: '',
    );
  }
}
