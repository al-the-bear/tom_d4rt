import 'package:flutter/material.dart';

/// Deep visual demo for PaddleSliderValueIndicatorShape.
/// Paddle-shaped value indicator for Slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PaddleSliderValueIndicatorShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Track
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            // Active track
            Positioned(left: 0, right: 75, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            // Thumb
            Positioned(left: 115, child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            // Paddle indicator
            Positioned(
              left: 100,
              bottom: 35,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: const Text('65', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Displays value above thumb', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
