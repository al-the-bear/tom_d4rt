import 'package:flutter/material.dart';

/// Deep visual demo for PaddleRangeSliderValueIndicatorShape.
/// Paddle-shaped value indicator for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PaddleRangeSliderValueIndicatorShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 24),
      Container(
        width: 200,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Track
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            // Active track
            Positioned(left: 50, right: 50, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            // Start paddle
            Positioned(left: 40, bottom: 30, child: _PaddleIndicator('20')),
            // End paddle
            Positioned(right: 40, bottom: 30, child: _PaddleIndicator('80')),
            // Thumbs
            Positioned(left: 45, top: 28, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 45, top: 28, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Paddle shape for range values', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _PaddleIndicator extends StatelessWidget {
  final String value;
  const _PaddleIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
      child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
