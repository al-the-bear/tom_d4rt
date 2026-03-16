import 'package:flutter/material.dart';

/// Deep visual demo for RoundRangeSliderTickMarkShape.
/// Default circular tick marks for RangeSlider.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RoundRangeSliderTickMarkShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 50, right: 50, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            // Tick marks
            for (var i = 0; i < 5; i++)
              Positioned(
                left: 20 + i * 40.0,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: (i >= 1 && i <= 3) ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            Positioned(left: 45, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
            Positioned(right: 45, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('tickMarkRadius property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
