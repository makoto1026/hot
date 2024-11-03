import 'dart:async';
import 'package:hub_of_talking/features/location/infrastructure/location_repository_provider.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:hub_of_talking/flame/flame.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map.g.dart';

@Riverpod(keepAlive: true)
class Map extends _$Map {
  late AppFlame flame;
  @override
  void build() {
    flame = AppFlame();
    init();
    return;
  }

  Future<void> init() async {
    final users = await ref.watch(userRepositoryProvider).fetchUsers();

    for (final u in users) {
      unawaited(flame.addMember(u));
    }
    final listener =
        ref.watch(locationRepositoryProvider).all().listen((location) {
      // locationをセットする
      for (final l in location) {
        unawaited(flame.updateLocation(l));
      }
    });
    ref.watch(locationManagerProvider).maybeWhen(
          data: (position) {
            flame.updateMeLocation(position);
          },
          orElse: () {},
        );

    ref.onDispose(
      listener.cancel,
    );
  }
}
