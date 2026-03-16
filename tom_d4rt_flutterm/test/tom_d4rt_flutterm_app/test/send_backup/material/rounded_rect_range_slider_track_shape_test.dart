import 'package:flutter/material.dart';

/// Deep visual demo for RoundedRectRangeSliderTrackShape.
/// Default rounded track shape for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundedRectRangeSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 50, right: 50, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            Positioned(left: 45, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 45, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Default RangeSlider track', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
