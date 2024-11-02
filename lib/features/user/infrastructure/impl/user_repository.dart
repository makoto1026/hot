import 'package:hub_of_talking/features/login/domain/model/login_request.dart';
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
  Future<List<User>> fetchUsers() async {
    final response = await _supabase
        .from('users') // テーブル名
        .select()
        .limit(100);
    return response.map(User.fromJson).toList();
  }

  @override
  Future<void> updateUser({required User user}) async {
    try {
      // TODOfreezedのtoJsonを使う
      await _supabase.from('users').update({
        'display_name': user.name,
        'sns_url': user.snsUrl,
        'thumbnail': user.thumbnail,
        'product': user.product,
      }).eq('id', user.id);
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  // TODO freezedのtoJsonを使う
  @override
  Future<void> insertUser({required LoginRequest loginRequest}) async {
    await _supabase.from('users').insert({
      'display_name': loginRequest.displayName,
      'sns_url': loginRequest.snsUrl,
      'thumbnail': loginRequest.thumbnail,
      'product': loginRequest.product,
    });
  }
}
