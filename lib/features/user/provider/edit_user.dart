import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'edit_user.g.dart';

/// サンプルNotifierです。
@riverpod
class EditUser extends _$EditUser {
  late final supabase.SupabaseClient _supabase;

  void inputName(String name) {
    state = AsyncValue.data(
      state.requireValue.copyWith(displayName: name),
    );
  }

  void inputProductName(String name) {
    state = AsyncValue.data(
      state.requireValue.copyWith(product: name),
    );
  }

  void inputImage(String image) {
    state = AsyncValue.data(
      state.requireValue.copyWith(thumbnail: image),
    );
  }

  void inputSNSLink(String url) {
    state = AsyncValue.data(
      state.requireValue.copyWith(snsUrl: url),
    );
  }

  Future<void> updateUser() async {
    return ref.read(userRepositoryProvider).updateUser(state.requireValue);
  }

  void inputUser({
    required User user,
  }) {
    state = AsyncValue.data(
      state.requireValue.copyWith(
        displayName: user.displayName,
        product: user.product,
        thumbnail: user.thumbnail,
        snsUrl: user.snsUrl,
      ),
    );
  }

  @override
  Future<User> build() async {
    final currentUser = _supabase.auth.currentUser;

    final user =
        await ref.watch(userRepositoryProvider).fetchUser(currentUser!.id);
    return user;
  }
}
