import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImplLoginRepository implements LoginRepository {
  ImplLoginRepository(this._ref) {
    _supabase = Supabase.instance.client;
  }

  final Ref _ref;
  late final SupabaseClient _supabase;

  @override
  // TODO 認証はserviceに移動して、updateはUserRepositoryでやる
  Future<User> loginAnonymously() async {
    final response = await _supabase.auth.signInAnonymously();

    if (response.user == null) {
      throw Exception('Failed to sign in anonymously');
    }

    // 匿名ログインが成功した後にメタデータを更新
    return response.user!;
  }
}
