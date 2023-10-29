import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowCloseButton extends StatelessWidget {
  final bool show;
  const WindowCloseButton(this.show, {super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: FilledButton(
        onPressed: () {
          windowManager.close();
        },
        style: FilledButton.styleFrom(
          fixedSize: const Size(20, 20),
          minimumSize: const Size(20, 20),
          maximumSize: const Size(20, 20),
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.red,
        ),
        child: const Icon(Icons.close, size: 10),
      ),
    );
  }
}
