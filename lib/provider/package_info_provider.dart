import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_provider.g.dart';

/// [PackageInfo] のProviderです。
@Riverpod(keepAlive: true)
PackageInfo packageInfo(Ref ref) {
  throw UnimplementedError(
    'PackageInfo.fromPlatform() をoverrideしてください',
  );
}
