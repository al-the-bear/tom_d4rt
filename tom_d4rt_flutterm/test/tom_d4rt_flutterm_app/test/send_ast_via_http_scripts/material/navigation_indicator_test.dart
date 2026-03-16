import 'package:flutter/material.dart';

/// Deep visual demo for NavigationIndicator widget.
/// Visual indicator on selected navigation destination.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavigationIndicator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _IndicatorDemo('Pill', 40, 20, 10),
          const SizedBox(width: 16),
          _IndicatorDemo('Circle', 32, 32, 16),
          const SizedBox(width: 16),
          _IndicatorDemo('Square', 32, 32, 4),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Shape animates on selection', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _IndicatorDemo extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final double radius;
  const _IndicatorDemo(this.label, this.width, this.height, this.radius);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(50),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            const Icon(Icons.home, size: 20, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
