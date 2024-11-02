import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class ImplLoginRepository implements LoginRepository {
  ImplLoginRepository(this._ref) {
    _supabase = supabase.Supabase.instance.client;
  }

  final Ref _ref;
  late final supabase.SupabaseClient _supabase;

  @override
  // TODO 認証はserviceに移動して、updateはUserRepositoryでやる
  Future<void> loginAnonymously() async {
    try {
      await _supabase.auth.signInAnonymously();

      // 匿名ログインが成功した後にメタデータを更新
      //TODO
      final user = _supabase.auth.currentUser;

      final displayName = user?.appMetadata['display_name'] ?? '';
      final snsUrl = user?.appMetadata['sns_url'] ?? '';
      final thumbnail = user?.appMetadata['thumbnail'] ?? '';
      final product = user?.appMetadata['product'] ?? '';

      if (user != null) {
        await _supabase.auth.updateUser(
          supabase.UserAttributes(
            data: {
              'display_name': displayName,
              'sns_url': snsUrl,
              'thumbnail': thumbnail,
              'product': product,
            },
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
