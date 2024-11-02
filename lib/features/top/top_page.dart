import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/app_routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// トップページです。
class TopPage extends HookConsumerWidget {
  /// コンストラクタ
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
      ),
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('トップページ'),
            const Gap(16),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.room.path);
              },
              child: const Text('入室'),
            ),
          ],
        ),
      ),
    );
  }
}
