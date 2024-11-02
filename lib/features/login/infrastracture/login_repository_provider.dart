import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/login/infrastracture/impl/login_repository.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository_provider.g.dart';

@riverpod
LoginRepository loginRepository(Ref ref) {
  return ImplLoginRepository(ref);
}
