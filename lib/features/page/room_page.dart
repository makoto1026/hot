import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_of_talking/features/room/widget/map_space.dart';

/// Roomページです。
class RoomPage extends StatelessWidget {
  /// コンストラクタ
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          context.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: const MapSpace(),
      ),
    );
  }
}
