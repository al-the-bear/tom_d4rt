import 'package:flutter/material.dart';

/// Deep visual demo for RectangularSliderValueIndicatorShape.
/// Rectangular value indicator for Slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RectangularSliderValueIndicatorShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 20),
      Container(
        width: 200,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, color: Colors.grey.shade300),
            Positioned(left: 0, right: 70, child: Container(height: 4, color: Colors.blue)),
            // Rectangular indicator
            Positioned(
              right: 58,
              bottom: 35,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
                child: const Text('65%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned(right: 65, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('Sharp-edged tooltip styling', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
