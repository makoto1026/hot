import 'dart:async';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hub_of_talking/features/location/infrastructure/location_repository_provider.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:hub_of_talking/flame/flame.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map.g.dart';

@Riverpod(keepAlive: true)
class Map extends _$Map {
  late AppFlame flame;
  StreamSubscription<List<Location>>? _locationListener;

  @override
  Future<void> build() async {
    flame = AppFlame();
    await init();
  }

  Future<void> init() async {
    final users = await ref.read(userRepositoryProvider).fetchUsers();

    for (final u in users) {
      unawaited(flame.addMember(u));
    }

    // すでにサブスクリプションが存在する場合は再利用
    _locationListener ??=
        ref.read(locationRepositoryProvider).all().listen((location) {
      for (final l in location) {
        unawaited(flame.updateLocation(l));
      }
    });

    // `locationManagerProvider`の状態が`data`の場合のみ実行
    ref.read(locationManagerProvider).maybeWhen(
          data: (position) {
            flame.updateMeLocation(position);
          },
          orElse: () {},
        );

    // サブスクリプションのキャンセルをonDisposeで管理
    ref.onDispose(() {
      _locationListener?.cancel();
    });
  }
}
