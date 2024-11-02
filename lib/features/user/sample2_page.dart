import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/location/provider/location_manager.dart';
import 'package:hub_of_talking/features/user/state/user_notifier.dart';

/// サンプル２ページです。
class Sample2Page extends HookConsumerWidget {
  /// コンストラクタ
  const Sample2Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userNotifierProvider);
    final locationManager = ref.watch(locationManagerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
      ),
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('プル２ページ'),
            const Gap(16),
            const Text('ここにコンテンツを配置してください'),
            Container(
              child: locationManager.when(
                data: (location) => Text('location: $location'),
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
