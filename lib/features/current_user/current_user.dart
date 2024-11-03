import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

part 'current_user.g.dart';

@riverpod
class IsLogined extends _$IsLogined {
  @override
  bool build() {
    final currentUser = sp.Supabase.instance.client.auth.currentUser;

    return currentUser != null;
  }
}
