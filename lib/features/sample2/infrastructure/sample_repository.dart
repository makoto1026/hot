import 'package:flutter_sample/features/sample2/domain/sample.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class SampleRepository {
  /// サンプルです
  Future<Sample> fetchSamples();
}
