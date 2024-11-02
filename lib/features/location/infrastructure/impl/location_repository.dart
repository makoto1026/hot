import 'package:hub_of_talking/features/location/domain/repository/location_repository.dart';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// [LocationRepository]です。
class ImplLocationRepository implements LocationRepository {
  ImplLocationRepository(this._ref) {
    _supabase = supabase.Supabase.instance.client;
  }

  final Ref _ref;
  late final supabase.SupabaseClient _supabase;

  @override
  Future<Location> upsert(String id, Location location) async {
    final response = await _supabase
        .from('locations') // テーブル名
        .upsert(location.toJson())
        .eq('user_id', id);

    return location;
  }

  @override
  Stream<List<Location>> all() {
    final response = _supabase
        .from('locations') // テーブル名
        .stream(primaryKey: ['id']).map((data) {
      // MapのリストをLocationオブジェクトのリストに変換
      return data.map(Location.fromJson).toList();
    });
    return response;
  }

  @override
  Future<Location> get(String userId) async {
    final response = await _supabase
        .from('locations') // テーブル名
        .select()
        .eq('user_id', userId)
        .single();
    return Location.fromJson(response);
  }
}
