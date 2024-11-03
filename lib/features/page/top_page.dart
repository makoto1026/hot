import 'package:flutter/material.dart';
import 'package:hub_of_talking/components/common_widget/accept_button.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';
import 'package:hub_of_talking/gen/fonts.gen.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

/// トップページです。
class TopPage extends HookConsumerWidget {
  /// コンストラクタ
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hub Of Talking',
              style: TextStyle(
                fontFamily: FontFamily.anonymousPro,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.5,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'HOT',
              style: TextStyle(
                fontFamily: FontFamily.dhurjati,
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: ColorTheme.orange,
                letterSpacing: 10,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Assets.images.campfire.image(
              height: 180,
              width: 180,
            ),
            const SizedBox(
              height: 34,
            ),
            AcceptButton(
              label: 'はじめる',
              onPressed: () {
                context.push(AppRoutes.login.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
