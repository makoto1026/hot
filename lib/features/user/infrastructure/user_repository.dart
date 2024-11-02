import 'package:hub_of_talking/features/login/domain/model/login_request.dart';
import 'package:hub_of_talking/features/user/domain/user.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class UserRepository {
  /// サンプルです
  Future<void> updateUser({required User user});
  //TODO LoginRequestを消す
  Future<void> insertUser({required LoginRequest loginRequest});
  Future<List<User>> fetchUsers();
}
