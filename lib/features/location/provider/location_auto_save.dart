import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hub_of_talking/features/location/domain/model/location.dart';
import 'package:hub_of_talking/features/location/infrastructure/location_repository_provider.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/v4.dart';

part 'location_auto_save.g.dart';

@Riverpod(keepAlive: true)
class LocationAutoSave extends _$LocationAutoSave {
  Timer? timer;
  String? deviceId;
  User? _user;

  @override
  void build() {
    try {
      init();
      checkPermission().then(
        (data) {
          final listener = Geolocator.getPositionStream().listen(
            (position) {
              if (timer == null || !timer!.isActive) {
                timer = Timer.periodic(const Duration(seconds: 20), (_) {
                  if (_user != null) {
                    final location = Location(
                      id: UuidV4().generate(),
                      userId: _user!.id,
                      latitude: position.latitude,
                      longitude: position.longitude,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    ref
                        .watch(locationRepositoryProvider)
                        .upsert(location.userId, location);
                  }
                });
              }
            },
          );
          ref.onDispose(listener.cancel);
        },
      );
    } catch (e) {
      print(e);
    }
    ref.onDispose(() => timer?.cancel());

    return;
  }

  Future<void> init() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    final userRepository = ref.read(userRepositoryProvider);
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id; // AndroidのユニークID
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor; // iOSのユニークID
      }

      deviceId ??= UuidV4().generate();
      print(deviceId);
      _user = await userRepository.fetchUserByDeviceId(deviceId!);
      print(_user);
    } catch (e) {
      print(e);
    }
  }
}
