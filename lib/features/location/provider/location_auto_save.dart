import 'dart:async';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hub_of_talking/features/location/infrastructure/location_repository_provider.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_auto_save.g.dart';

@riverpod
class LocationAutoSave extends _$LocationAutoSave {
  Timer? timer;

  @override
  Future<Location?> build(String args) async {
    ref
      ..watch(locationManagerProvider).maybeWhen(
        data: (position) async {
          if (timer == null || !timer!.isActive) {
            timer = Timer.periodic(const Duration(seconds: 20), (_) {
              final location = state.value?.copyWith(
                latitude: position.latitude,
                longitude: position.longitude,
                updatedAt: DateTime.now(),
              );

              ref
                  .watch(locationRepositoryProvider)
                  .upsert(location!.id, location);
            });
          }
        },
        orElse: () => {},
      )
      ..onDispose(() => timer?.cancel());

    return null;
  }
}
