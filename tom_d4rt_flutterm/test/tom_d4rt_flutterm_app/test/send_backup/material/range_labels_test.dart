import 'package:flutter/material.dart';

/// Deep visual demo for RangeLabels class.
/// Labels for start and end of RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeLabels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 40, right: 40, child: Container(height: 4, color: Colors.blue)),
            Positioned(left: 30, bottom: 30, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)), child: const Text('\${20}', style: TextStyle(color: Colors.white, fontSize: 10)))),
            Positioned(right: 30, bottom: 30, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)), child: const Text('\${80}', style: TextStyle(color: Colors.white, fontSize: 10)))),
            Positioned(left: 35, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 35, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('RangeLabels(start, end)', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
