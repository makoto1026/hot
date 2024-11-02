import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumee/presentation/common_widget/rounded_button.dart';
import 'package:sumee/presentation/router/router.dart';
import 'package:sumee/presentation/theme/color_theme.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 121, bottom: 242),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  'SUMEE',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 320,
                child: RoundedButton(
                  text: '電話番号ログイン',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: ColorTheme.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.phoneNumberInput.path,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
