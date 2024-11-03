import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/features/location/provider/location_auto_save.dart';
import 'package:hub_of_talking/features/room/widget/map_space.dart';

/// Roomページです。
class RoomPage extends HookConsumerWidget {
  /// コンストラクタ
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationAutoSaveProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          context.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: Stack(
          children: [
            const MapSpace(),
            Positioned(
              top: 60,
              right: 20,
              child: InkWell(
                onTap: () => context.pop(),
                child: const Image(
                  image: AssetImage('assets/images/exit.png'),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
