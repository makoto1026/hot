import 'package:hub_of_talking/features/user/infrastructure/impl/user_repository.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

/// [UserRepository]を取得します。
@riverpod
UserRepository userRepository(Ref ref) {
  return ImplUserRepository(ref);
}
