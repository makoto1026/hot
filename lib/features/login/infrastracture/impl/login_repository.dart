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
  Future<void> signInAnonymously() async {
    try {
      final response = await _supabase.auth.signInAnonymously();

      print('response: $response');

      // 匿名ログインが成功した後にメタデータを更新
      final user = _supabase.auth.currentUser;

      print('user$user');
      if (user != null) {
        final updateResponse = await _supabase.auth.updateUser(
          supabase.UserAttributes(
            data: {
              'display_name': 'test man',
              'sns_url': 'SNSのURL',
              'thumbnail': '画像のURL',
              'product': '製品情報',
            },
          ),
        );
        print('User metadata updated: $updateResponse');
        print(
          'updateResponse.user?.toJson(): ${updateResponse.user?.toJson()}',
        );
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
