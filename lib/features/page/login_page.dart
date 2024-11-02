import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:hub_of_talking/features/login/provider/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseModel;

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, []);
    final user = ref.watch(loginProvider);

    Future<void> loginAnonymously() async {
      try {
        if (formKey.currentState?.validate() ?? false) {
          ref.read(loginProvider.notifier).login();
        }

        await context.push(AppRoutes.room.path);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: ref.watch(loginProvider.notifier).setName,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: ref.watch(loginProvider.notifier).setProduct,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Product name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Image URL cannot be empty';
                  }
                  const urlPattern =
                      r'(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?';
                  if (!RegExp(urlPattern).hasMatch(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: ref.watch(loginProvider.notifier).setSnsLink,
                decoration: const InputDecoration(labelText: 'SNS Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'SNS Link cannot be empty';
                  }
                  const urlPattern =
                      r'(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?';
                  if (!RegExp(urlPattern).hasMatch(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginAnonymously,
                child: const Text('Sign in Anonymously'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}