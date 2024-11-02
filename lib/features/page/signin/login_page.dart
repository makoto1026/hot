import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository_provider.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signInAnonymously() async {
    final userRepository = ref.read(loginRepositoryProvider);
    await userRepository.signInAnonymously();
    print('登録!');
  }

  String checkCurrentUser() {
    final user = Supabase.instance.client.auth.currentUser;
    final userData = user?.userMetadata;
    print(userData); // メタデータが出力されます
    return userData.toString();
  }

  Future<void> updateCurrentUser() async {
    final userRepository = ref.read(userRepositoryProvider);
    await userRepository.updateUserProfileFromMetadata();
    print('User profile updated from metadata');
  }

  @override
  Widget build(BuildContext context) {
    var user = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous Login'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: signInAnonymously,
              child: const Text('Sign in Anonymously'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  user = checkCurrentUser();
                });
              },
              child: const Text('Check current user'),
            ),
            Text(user),
            ElevatedButton(
              onPressed: updateCurrentUser,
              child: const Text('Update current user'),
            ),
          ],
        ),
      ),
    );
  }
}
