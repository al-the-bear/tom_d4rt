import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  final maskRaster = 1 << PerformanceOverlayOption.displayRasterizerStatistics.index;
  final maskEngine = 1 << PerformanceOverlayOption.displayEngineStatistics.index;
  final layer = PerformanceOverlayLayer(
    overlayRect: const Rect.fromLTWH(0, 0, 300, 120),
    optionsMask: maskRaster | maskEngine,
  );

  layer.overlayRect = const Rect.fromLTWH(10, 20, 320, 100);

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('PerformanceOverlayLayer Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        width: 240,
        height: 20,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFFEF5350)]),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(height: 8),
      Text('type=${layer.runtimeType}'),
      Text('overlayRect=${layer.overlayRect}'),
      Text('optionsMask=${layer.optionsMask}'),
    ],
  );
}