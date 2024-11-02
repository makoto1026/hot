import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/location/domain/repository/location_repository.dart';
import 'package:hub_of_talking/features/location/infrastructure/impl/location_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_repository_provider.g.dart';

/// [LocationRepository]を取得します。
@riverpod
LocationRepository locationRepository(Ref ref) {
  return ImplLocationRepository(ref);
}
