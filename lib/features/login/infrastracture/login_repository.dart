import 'package:supabase_flutter/supabase_flutter.dart';

/// サンプルリポジトリの抽象クラスです。
/// このクラスから継承して、各認証リポジトリを作成します。
// ignore: one_member_abstracts
abstract class LoginRepository {
  Future<User> loginAnonymously();
}
