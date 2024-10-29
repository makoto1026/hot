import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// サンプル３ページです。
class Sample3Page extends HookConsumerWidget {
  /// コンストラクタ
  const Sample3Page({super.key});

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
            Text('サンプル３ページ'),
            Gap(16),
            Text('ここにコンテンツを配置してください'),
          ],
        ),
      ),
    );
  }
}
