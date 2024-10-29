import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/features/sample_app.dart';
import 'package:flutter_sample/provider/package_info_provider.dart';
import 'package:flutter_sample/provider/shared_preferences_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SampleApp(),
    ),
  );
}
