import 'package:hub_of_talking/features/user/domain/user.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class UserRepository {
  /// サンプルです
  Future<User> fetchUsers();
  Stream<List<User>> all();
}
