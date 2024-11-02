import 'package:hub_of_talking/features/user/domain/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'user_notifier.g.dart';

/// サンプルNotifierです。
@riverpod
class UserNotifier extends _$UserNotifier {
  late final supabase.SupabaseClient _supabase;

  void inputName(String name) {
    state = AsyncValue.data(
      state.requireValue.copyWith(name: name),
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

  Future<void> updateUser(User user) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.updateUser(user: user);
    } catch (e) {
      print('updateUserError: $e');
      return;
    }
  }

  void inputUser({
    required User user,
  }) {
    state = AsyncValue.data(
      state.requireValue.copyWith(
        name: user.name,
        product: user.product,
        thumbnail: user.thumbnail,
        snsUrl: user.snsUrl,
      ),
    );
  }

  @override
  Future<User> build() async {
    final user = _supabase.auth.currentUser;

    final displayName = user?.appMetadata['display_name'].toString() ?? '';
    final snsUrl = user?.appMetadata['sns_url'].toString() ?? '';
    final thumbnail = user?.appMetadata['thumbnail'].toString() ?? '';
    final product = user?.appMetadata['product'].toString() ?? '';
    await ref.watch(userRepositoryProvider).fetchUsers();
    return User(
      sampleId: user?.id ?? '',
      name: displayName,
      thumbnail: thumbnail,
      snsUrl: snsUrl,
      product: product,
    );
  }
}
