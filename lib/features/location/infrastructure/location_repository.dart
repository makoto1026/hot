import 'package:hub_of_talking/features/location/domain/location.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class LocationRepository {
  /// サンプルです
  Future<Location> upsert(String id, Location location);
  Future<List<Location>> all();
  Future<Location> get(String userId);
}
