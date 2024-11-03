import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hub_of_talking/features/login/infrastracture/login_repository_provider.dart';
import 'package:hub_of_talking/features/login/provider/login_state.dart';
import 'package:hub_of_talking/features/user/domain/model/user.dart';
import 'package:hub_of_talking/features/user/infrastructure/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;
import 'package:uuid/v4.dart';

part 'login.g.dart';

@riverpod
class Login extends _$Login {
  late String? deviceId;
  Future<void> login() async {
    try {
      final authUser =
          await ref.read(loginRepositoryProvider).loginAnonymously();
      final user = User(
        id: authUser.id,
        displayName: state.requireValue.name,
        thumbnail: state.requireValue.thumbnail,
        snsUrl: state.requireValue.snsLink,
        product: state.requireValue.product,
        deviceId: deviceId!,
      );

      final userRepository = ref.read(userRepositoryProvider);

      if (deviceId == null) {
        await userRepository.insertUser(user);
      } else {
        await userRepository.updateUser(user);
      }
    } catch (e) {
      print('LoginNotifier: $e');
      return;
    }
  }

  void setName(String name) {
    state = AsyncValue.data(state.value!.copyWith(name: name));
  }

  void setSnsLink(String snsLink) {
    state = AsyncValue.data(state.value!.copyWith(snsLink: snsLink));
  }

  void setProduct(String product) {
    state = AsyncValue.data(state.value!.copyWith(product: product));
  }

  Future<void> setImage(File file) async {
    try {
      state = const AsyncValue.loading();
      final fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Supabaseにファイルをアップロード
      final response = await sp.Supabase.instance.client.storage
          .from('images')
          .upload(fileName, file);

      final publicUrl = sp.Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(fileName);

      state = AsyncValue.data(state.value!.copyWith(thumbnail: publicUrl));
    } catch (e) {
      print(e);
      state = AsyncValue.data(state.value!);
    }
  }

  @override
  Future<LoginState> build() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    final userRepository = ref.read(userRepositoryProvider);
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id; // AndroidのユニークID
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor; // iOSのユニークID
      }

      deviceId ??= UuidV4().generate();

      final user = await userRepository.fetchUserByDeviceId(deviceId!);

      return LoginState(
        name: user.displayName,
        snsLink: user.snsUrl,
        thumbnail: user.thumbnail,
        product: user.product,
      );
    } catch (e) {
      print(e);
      return const LoginState();
    }
  }
}
