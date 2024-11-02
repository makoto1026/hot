import 'package:flutter/material.dart';
import 'package:hub_of_talking/constants/app_theme.dart';
import 'package:hub_of_talking/provider/app_routes_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// サンプルアプリです。
class SampleApp extends ConsumerWidget {
  /// コンストラクタ
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRoutesProvider);

    return MaterialApp.router(
      title: 'サンプリアプリ',
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
