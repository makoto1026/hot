import 'package:hub_of_talking/features/user/domain/model/user.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class UserRepository {
  /// サンプルです
  Future<void> updateUser(User user);
  //TODO LoginRequestを消す
  Future<void> insertUser(User user);
  Future<List<User>> fetchUsers();
  Future<User> fetchUser(String id);
}
