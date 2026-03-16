import 'package:flutter/material.dart';

/// Deep visual demo for RectangularRangeSliderValueIndicatorShape.
/// Rectangular value indicator for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RectangularRangeSliderValueIndicatorShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 24),
      Container(
        width: 200,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, color: Colors.grey.shade300),
            Positioned(left: 40, right: 60, child: Container(height: 4, color: Colors.blue)),
            // Rectangular indicators
            Positioned(left: 28, bottom: 35, child: _RectIndicator('20')),
            Positioned(right: 48, bottom: 35, child: _RectIndicator('80')),
            Positioned(left: 35, top: 28, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 55, top: 28, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('Rectangular tooltip shape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _RectIndicator extends StatelessWidget {
  final String value;
  const _RectIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
      child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
