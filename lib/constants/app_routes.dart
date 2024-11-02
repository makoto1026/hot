import 'package:flutter/material.dart';
import 'package:hub_of_talking/components/top_bottom_sheet_tab.dart';
import 'package:hub_of_talking/features/page/signin/login_page.dart';
import 'package:hub_of_talking/features/room/room_page.dart';
import 'package:hub_of_talking/features/user/sample2_page.dart';
import 'package:hub_of_talking/features/sample3/sample3_page.dart';
import 'package:hub_of_talking/features/top/top_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリのルーティングです。
GoRouter appRouter(Ref ref) => GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.top.path,
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
              child: Sample2Page(),
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
              child: Sample3Page(),
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
];

/// アプリのルーティングパスです。
enum AppRoutes {
  /// トップページ
  top('/top'),

  /// Roomページ
  room('/room'),

  /// Loginページ
  login('/login'),

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
