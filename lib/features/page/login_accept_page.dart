import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hub_of_talking/components/common_widget/accept_button.dart';
import 'package:hub_of_talking/components/common_widget/user_icon.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/login/provider/login.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';
import 'package:hub_of_talking/gen/fonts.gen.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

class LoginAcceptPage extends HookConsumerWidget {
  const LoginAcceptPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.value?.name == '')
              const Text(
                'unkown',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Text(
              state.value?.name ?? 'unkown',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Transform.translate(
                  offset: const Offset(0, 40),
                  child: Assets.images.man.image(
                    height: 180,
                    width: 180,
                  ),
                ),
                const UserIcon(
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/300px-Gull_portrait_ca_usa.jpg',
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              '${state.value?.name}さん\nいってらっしゃい!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 34,
            ),
            AcceptButton(
              label: 'さんかする',
              onPressed: () {
                context.push(AppRoutes.room.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
