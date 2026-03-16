import 'package:flutter/material.dart';

/// Deep visual demo for RangeSliderValueIndicatorShape.
/// Shape showing values above RangeSlider thumbs.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeSliderValueIndicatorShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 24),
      Container(
        width: 200,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 40, right: 60, child: Container(height: 4, color: Colors.blue)),
            // Start indicator
            Positioned(left: 25, bottom: 40, child: _ValueIndicator('25')),
            // End indicator  
            Positioned(right: 45, bottom: 40, child: _ValueIndicator('75')),
            // Thumbs
            Positioned(left: 35, top: 28, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 55, top: 28, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('PaddleRangeSliderValueIndicatorShape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ValueIndicator extends StatelessWidget {
  final String value;
  const _ValueIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
      child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
