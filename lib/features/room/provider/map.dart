import 'dart:async';
import 'package:hub_of_talking/features/location/infrastructure/location_repository_provider.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:hub_of_talking/flame/flame.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map.g.dart';

@riverpod
class Map extends _$Map {
  @override
  Future<AppFlame> build() async {
    final users = await ref.watch(userRepositoryProvider).fetchUsers();

    for (final u in users) {
      unawaited(state.value?.addMember(u));
    }
    ref.watch(locationRepositoryProvider).all().listen((location) {
      // locationをセットする
      for (final l in location) {
        unawaited(state.value?.updateLocation(l));
      }
    });
    return AppFlame();
  }
}
