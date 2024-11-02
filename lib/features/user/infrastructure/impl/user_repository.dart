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
      );

      return sample;
    } catch (e) {
      print('Error fetching samples: $e');
      return const User(sampleId: '');
    }
  }
}
