import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// トップページのボトムシートのタブです。
class TopBottomSheetTab extends StatelessWidget {
  /// コンストラクタ
  const TopBottomSheetTab({
    super.key,
    required this.navigationShell,
  });

  /// [StatefulNavigationShell]
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green[400],
        backgroundColor: Colors.green[200],
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          for (final tab in _TopTab.values)
            NavigationDestination(
              icon: tab.icon,
              label: tab.label,
              tooltip: tab.label,
            ),
        ],
      ),
      body: navigationShell,
    );
  }
}

/// トップタブの一覧です。
enum _TopTab {
  /// トップ
  top(Icon(FontAwesomeIcons.house), 'ホーム'),

  /// sample2
  analysis(Icon(FontAwesomeIcons.chartSimple), '2'),

  /// sample3
  settings(Icon(FontAwesomeIcons.user), '3');

  const _TopTab(
    this.icon,
    this.label,
  );

  /// タブのアイコン
  final Widget icon;

  /// タブのラベル(長押し時に表示される)
  final String label;
}
