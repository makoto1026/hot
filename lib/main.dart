import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_of_talking/config.dart';
import 'package:hub_of_talking/features/sample_app.dart';
import 'package:hub_of_talking/provider/package_info_provider.dart';
import 'package:hub_of_talking/provider/shared_preferences_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// アプリ全体のProviderContainerです。
@visibleForTesting
late ProviderContainer container;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 縦画面固定(UP固定)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // PackageInfoをキャッシュ
  final packageInfo = await PackageInfo.fromPlatform();
  // SharedPreferencesをキャッシュ
  final sharedPreferences = await SharedPreferences.getInstance();
  container = ProviderContainer(
    overrides: [
      packageInfoProvider.overrideWithValue(packageInfo),
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );

  const flavor = String.fromEnvironment('FLAVOR');

  // Supabaseを初期化
  // await Supabase.initialize(
  //   url: Config.supabaseUrl,
  //   anonKey: Config.supabaseAnon,
  // );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SampleApp(),
    ),
  );
}
