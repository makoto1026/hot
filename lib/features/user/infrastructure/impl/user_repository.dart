import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/features/user/domain/repository/user_repository.dart';
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
  Future<void> updateUser(User user) async {
    try {
      // TODOfreezedのtoJsonを使う
      await _supabase
          .from('users')
          .update(user.toJson())
          .eq('device_id', user.deviceId);
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  // TODO freezedのtoJsonを使う
  @override
  Future<void> insertUser(User user) async {
    await _supabase.from('users').insert(user.toJson());
  }

  @override
  Future<User> fetchUser(String id) async {
    final response = await _supabase
        .from('users') // テーブル名
        .select()
        .eq('id', id)
        .single();
    return User.fromJson(response);
  }

  @override
  Future<User> fetchUserByDeviceId(String deviceId) async {
    final response = await _supabase
        .from('users') // テーブル名
        .select()
        .eq('device_id', deviceId)
        .single();
    return User.fromJson(response);
  }
}
