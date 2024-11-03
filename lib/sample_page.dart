import 'package:flutter/material.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

/// トップページです。
class SamplePage extends HookConsumerWidget {
  /// コンストラクタ
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationManagerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
      ),
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.maybeWhen(
              orElse: () => const Text('Loading...'),
              data: (position) {
                return Column(
                  children: [
                    Text(
                      'Latitude: ${position.latitude}',
                      style: const TextStyle(color: ColorTheme.blue),
                    ),
                    Text(
                      'Longitude: ${position.longitude}',
                      style: const TextStyle(color: ColorTheme.blue),
                    ),
                    Text(
                      'Z: ${position.floor}',
                      style: const TextStyle(color: ColorTheme.blue),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
