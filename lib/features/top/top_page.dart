import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('トップページ'),
            Gap(16),
            Text('ここにコンテンツを配置してください'),
          ],
        ),
      ),
    );
  }
}
