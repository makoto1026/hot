import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationPermissionManager extends Notifier<LocationPermission> {
  Future<void> load() async {
    state = await Geolocator.checkPermission();
  }

  Future<void> handleLocationPermission(
    AppLifecycleState appLifecycleState,
  ) async {
    if (appLifecycleState != AppLifecycleState.resumed) {
      return;
    }

    state = await Geolocator.checkPermission();

    if (state == LocationPermission.denied) {
      state = await Geolocator.requestPermission();
    }
  }

  @override
  LocationPermission build() {
    return LocationPermission.denied;
  }
}

final locationPermissionManagerProvider =
    NotifierProvider<LocationPermissionManager, LocationPermission>(
  LocationPermissionManager.new,
);
