import 'package:hub_of_talking/features/location/domain/model/location.dart';

/// LocationRepositoryです。
abstract class LocationRepository {
  /// データを登録または更新します。
  Future<Location> upsert(String id, Location location);

  /// 全データを取得します。
  Stream<List<Location>> all();

  /// データを取得します。
  Future<Location> get(String userId);
}
