import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../widget/close_button.dart';
import '../widget/cpu_gauge.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHover = ref.watch(isHoverProvider);

    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: MouseRegion(
        onEnter: (event) {
          ref.read(isHoverProvider.notifier).update((state) => true);
        },
        onExit: (event) {
          ref.read(isHoverProvider.notifier).update((state) => false);
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: CpuGauge(),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: WindowCloseButton(isHover),
            ),
          ],
        ),
      ),
    );
  }
}
