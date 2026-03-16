import 'package:flutter/material.dart';

/// Deep visual demo for RectangularRangeSliderTrackShape.
/// Rectangular track for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RectangularRangeSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 6, color: Colors.grey.shade300),
            Positioned(left: 50, right: 50, child: Container(height: 6, color: Colors.blue)),
            Positioned(left: 45, child: Container(width: 18, height: 18, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            Positioned(right: 45, child: Container(width: 18, height: 18, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('No rounded corners on track', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
