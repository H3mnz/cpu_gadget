import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const Size size = Size(150, 150);

class WindowService {
  WindowService._();

  static Future<void> init() async {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: size,
      maximumSize: size,
      minimumSize: size,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      title: 'CPU Gadget',
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await Future.wait(
        [
          windowManager.setMinimizable(false),
          windowManager.setMaximizable(false),
          windowManager.setAsFrameless(),
          windowManager.show(),
        ],
      );
    });
  }
}
