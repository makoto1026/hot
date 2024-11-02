import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/user/state/user_notifier.dart';

/// サンプル２ページです。
class Sample2Page extends HookConsumerWidget {
  /// コンストラクタ
  const Sample2Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
      ),
      backgroundColor: Colors.green[50],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('サンプル２ページ'),
            Gap(16),
            Text('ここにコンテンツを配置してください'),
          ],
        ),
      ),
    );
  }
}
