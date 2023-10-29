import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

import 'package:window_manager/window_manager.dart';

import '../providers.dart';

class CpuGauge extends ConsumerWidget {
  const CpuGauge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cpuUsage = ref.watch(cpuUsageProvider).value ?? 0;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 2,
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          windowManager.startDragging();
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    'CPU',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text('${(cpuUsage).toStringAsFixed(0)}%'),
                ],
              ),
            ),
            Positioned.fill(
              child: RadialGauge(
                valueBar: [
                  RadialValueBar(
                    value: cpuUsage,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.green,
                        Colors.yellow,
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                ],
                track: const RadialTrack(
                  color: Colors.white38,
                  start: 0,
                  end: 100,
                  trackStyle: TrackStyle(
                    secondaryRulerColor: Colors.white,
                    secondaryRulerPerInterval: 1,
                    rulersOffset: 0,
                    showLabel: false,
                  ),
                ),
                needlePointer: [
                  NeedlePointer(
                    value: cpuUsage,
                    color: Colors.red,
                    tailColor: Colors.black,
                    tailRadius: 8,
                    needleWidth: 4,
                    needleStyle: NeedleStyle.gaugeNeedle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
