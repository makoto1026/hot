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
    ref.watch(userRepositoryProvider).all().listen((user) {
      // userをセットする
      state.value?.addMembers(user);
    });
    ref.watch(locationRepositoryProvider).all().listen((location) {
      // locationをセットする
    });
    return AppFlame();
  }
}
