import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/components/top_bottom_sheet_tab.dart';
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
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state, navigationShell) =>
        TopBottomSheetTab(navigationShell: navigationShell),
    branches: [
      ///MEMO: タブ分けしたいページをここに追加してください。
      StatefulShellBranch(
        navigatorKey: _topNavigatorKey,
        routes: [
          GoRoute(
            path: AppRoutes.top.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TopPage(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _sample2NavigatorKey,
        routes: [
          GoRoute(
            path: AppRoutes.sample2.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SamplePage(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _sample3NavigatorKey,
        routes: [
          GoRoute(
            path: AppRoutes.sample3.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SizedBox(),
            ),
          ),
        ],
      ),
    ],
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

// トップのナビゲーションキー
final _topNavigatorKey = GlobalKey<NavigatorState>();

// サンプリページ２のナビゲーションキー
final _sample2NavigatorKey = GlobalKey<NavigatorState>();

// サンプリページ3のナビゲーションキー
final _sample3NavigatorKey = GlobalKey<NavigatorState>();
