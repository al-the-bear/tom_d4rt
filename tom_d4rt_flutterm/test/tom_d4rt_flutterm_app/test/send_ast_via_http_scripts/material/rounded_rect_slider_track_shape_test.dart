import 'package:flutter/material.dart';

/// Deep visual demo for RoundedRectSliderTrackShape.
/// Default rounded track shape for Slider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundedRectSliderTrackShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 0, right: 80, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            Positioned(right: 75, child: Container(width: 18, height: 18, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Default Slider track shape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
