import 'package:hub_of_talking/features/user/domain/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// [UserRepository]です。
class ImplUserRepository implements UserRepository {
  ImplUserRepository(this._ref) {
    _supabase = supabase.Supabase.instance.client;
  }

  final Ref _ref;
  late final supabase.SupabaseClient _supabase;

  @override
  Future<User> fetchUsers() async {
    try {
      final response = await _supabase
          .from('users') // テーブル名
          .select()
          .limit(1)
          .single();

      final sample = User(
        sampleId: response['id'] as String,
        name: response['display_name'] as String,
        thumbnail: response['thumbnail'] as String,
        snsUrl: response['sns_url'] as String,
        product: response['product'] as String,
      );

      return sample;
    } catch (e) {
      print('Error fetching samples: $e');
      return const User(
        sampleId: '',
        name: '',
        thumbnail: '',
        snsUrl: '',
        product: '',
      );
    }
  }

  /// ユーザーのメタデータをDBにアップデート
  @override
  Future<void> updateUserProfileFromMetadata() async {
    try {
      final user = _supabase.auth.currentUser;

      if (user != null) {
        final metadata = user.userMetadata;

        // メタデータから必要な情報を取り出す
        final name = metadata?['display_name'] as String? ?? '';
        final snsUrl = metadata?['sns_url'] as String? ?? '';
        final image = metadata?['image'] as String? ?? '';
        final product = metadata?['product'] as String? ?? '';

        // profilesテーブルにデータを保存または更新
        final response = await _supabase.from('users').upsert({
          'id': user.id,
          'display_name': name,
          'sns_url': snsUrl,
          'thumbnail': image,
          'product': product,
        });
        print('User profile updated: $response');
      }
    } catch (e) {
      print('Error updating user profile from metadata: $e');
    }
  }
}
