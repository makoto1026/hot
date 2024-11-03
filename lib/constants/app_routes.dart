import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/page/login_page.dart';
import 'package:hub_of_talking/features/page/room_page.dart';
import 'package:hub_of_talking/features/page/top_page.dart';
import 'package:hub_of_talking/features/page/web_view_page.dart';
import 'package:hub_of_talking/sample_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// アプリのルーティングです。
GoRouter appRouter(Ref ref) => GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Supabase.instance.client.auth.currentUser != null
          ? AppRoutes.login.path
          : AppRoutes.top.path,
      routes: appRoutes,
    );

/// アプリのルート情報です。
@visibleForTesting
final appRoutes = [
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: AppRoutes.top.path,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: TopPage(),
    ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: AppRoutes.sample2.path,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: SizedBox(), // サンプルページ2の内容
    ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: AppRoutes.sample3.path,
    pageBuilder: (context, state) => const NoTransitionPage(
      child: SizedBox(), // サンプルページ3の内容
    ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: AppRoutes.room.path,
    pageBuilder: (context, state) => const MaterialPage(
      child: RoomPage(),
    ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: AppRoutes.login.path,
    pageBuilder: (context, state) => const MaterialPage(
      child: LoginPage(),
    ),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: '${AppRoutes.webView.path}/:url',
    pageBuilder: (context, state) => MaterialPage(
      child: WebViewPage(
        url: state.pathParameters['url']!,
      ),
    ),
  ),
];

/// アプリのルーティングパスです。
enum AppRoutes {
  /// トップページ
  top('/top'),

  /// Roomページ
  room('/room'),

  /// Loginページ
  login('/login'),

  /// webViewページ
  webView('/webview'),

  /// サンプルページ2
  sample2('/sample2'),

  /// サンプルページ3
  sample3('/sample3');

  const AppRoutes(this.path);

  /// ルートのパス
  final String path;
}

/// ルート用のキー
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
