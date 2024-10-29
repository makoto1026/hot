import 'package:collection/collection.dart';

/// Flavor名
const _flavor = String.fromEnvironment('FLAVOR');

/// アプリの環境を表す定数
enum AppEnv {
  /// 本番環境
  prd('prd'),

  /// ステージング
  stg('stg'),

  /// 開発環境
  dev('dev');

  const AppEnv(this.name);

  /// Flavor名
  final String name;
}

/// アプリのEnv
final appEnv = AppEnv.values.firstWhereOrNull(
      (item) => _flavor == item.name,
    ) ??
    AppEnv.dev;

/// アプリの環境の拡張クラス
extension AppEnvExtension on AppEnv {
  /// 本番環境かどうか
  bool get isPrd => this == AppEnv.prd;

  /// ステージング環境かどうか
  bool get isStg => this == AppEnv.stg;

  /// 開発環境かどうか
  bool get isDev => this == AppEnv.dev;

  /// デバッグ用のラベル
  String get debugLabel => switch (this) {
        AppEnv.prd => '',
        AppEnv.stg => 'stg',
        AppEnv.dev => 'dev',
      };
}
