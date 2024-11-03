import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/components/common_widget/accept_button.dart';
import 'package:hub_of_talking/components/common_widget/automatic_focus_manager.dart';
import 'package:hub_of_talking/components/common_widget/image_picker.dart';
import 'package:hub_of_talking/components/common_widget/user_icon.dart';
import 'package:hub_of_talking/constants/app_routes.dart';
import 'package:hub_of_talking/features/login/provider/login.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new, []);
    final state = ref.watch(loginProvider);
    final nameController = useTextEditingController();
    final productController = useTextEditingController();
    final snsLinkController = useTextEditingController();

    final isInitialized = useState(false);

    if (!isInitialized.value) {
      // 初期化がまだ行われていない場合のみ、コントローラに初期値をセット
      state.maybeWhen(
        data: (state) {
          nameController.text = state.name;
          productController.text = state.product;
          snsLinkController.text = state.snsLink;
        },
        orElse: () {},
      );
      isInitialized.value = true;
    }

    Future<void> loginAnonymously() async {
      try {
        if (formKey.currentState?.validate() ?? false) {
          await ref.read(loginProvider.notifier).login();
          await context.push(AppRoutes.loginAccept.path);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      }
    }

    // `state`が更新された時にコントローラに初期値を設定
    useEffect(
      () {
        state.maybeWhen(
          data: (state) {
            nameController.text = state.name;
            productController.text = state.product;
            snsLinkController.text = state.snsLink;
          },
          orElse: () {},
        );
        return null; // `useEffect`のリターンは必ず`null`に設定
      },
      [state],
    );

    return AutomaticFocusManager(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            '登録',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    ImagePicker(
                      onSelected: ref.watch(loginProvider.notifier).setImage,
                      child: state.maybeWhen(
                        data: (data) {
                          if (data.thumbnail == '') {
                            return Assets.images.camera
                                .image(height: 100, width: 100);
                          }
                          return UserIcon(imageUrl: data.thumbnail);
                        },
                        orElse: () =>
                            Assets.images.camera.image(height: 100, width: 100),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      onChanged: ref.watch(loginProvider.notifier).setName,
                      decoration: const InputDecoration(
                        labelText: '名前',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onChanged: ref.watch(loginProvider.notifier).setSnsLink,
                      decoration: const InputDecoration(
                        labelText: 'SNSリンク',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      controller: snsLinkController,
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
                    const SizedBox(height: 30),
                    TextFormField(
                      onChanged: ref.watch(loginProvider.notifier).setProduct,
                      decoration: const InputDecoration(
                        labelText: 'ハッカソンで開発したプロダクト名',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      controller: productController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Product name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 60),
                    ref.watch(loginProvider).maybeWhen(
                          loading: () => const CircularProgressIndicator(),
                          orElse: () => const SizedBox.shrink(),
                          data: (state) => AcceptButton(
                            label: 'はじめる',
                            onPressed: loginAnonymously,
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
