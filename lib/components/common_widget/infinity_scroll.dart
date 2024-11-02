import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InfinityScroll extends HookWidget {
  const InfinityScroll({
    required this.scrollController,
    required this.child,
    required this.onLoad,
    super.key,
  });
  final Widget child;
  final ScrollController scrollController;
  final FutureOr<void> Function() onLoad;

  @override
  Widget build(BuildContext context) {
    final isLoading = useRef(false);
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollController.position.maxScrollExtent !=
            scrollNotification.metrics.extentBefore) {
          return false;
        }

        if (isLoading.value) {
          return false;
        }

        isLoading.value = true;

        final result = onLoad.call();

        if (result is Future) {
          result.then(
            (_) {
              isLoading.value = false;
            },
          );
        } else {
          isLoading.value = false;
        }
        return false;
      },
      child: child,
    );
  }
}
