import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hub_of_talking/features/location/provider/location_permission_manager.dart';
import 'package:hub_of_talking/provider/app_routes_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/theme/light_theme.dart';

/// サンプルアプリです。
class SampleApp extends HookConsumerWidget {
  /// コンストラクタ
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRoutesProvider);

    useEffect(
      () {
        Future.microtask(() async {
          await ref.read(locationPermissionManagerProvider.notifier).load();
        });
        return null;
      },
      [],
    );
    return MaterialApp.router(
      title: 'HUB OF TALKING',
      theme: ref.watch(lightThemeProvider),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
