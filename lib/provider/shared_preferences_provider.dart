import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

/// [SharedPreferences]のキー
enum SharedPreferencesKey {
  /// サンプルキー
  sampleKey,
}

/// [SharedPreferences]のProviderです。
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'SharedPreferences.getInstance() をoverrideしてください',
  );
}
