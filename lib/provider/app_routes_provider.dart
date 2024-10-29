import 'package:flutter_sample/constants/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_routes_provider.g.dart';

/// [GoRouter]のProviderです。
@Riverpod(keepAlive: true)
GoRouter appRoutes(Ref ref) {
  return appRouter(ref);
}
