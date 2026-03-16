import 'package:flutter/material.dart';

/// Deep visual demo for RangeSliderTickMarkShape.
/// Shape of tick marks on RangeSlider track.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeSliderTickMarkShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            for (var i = 0; i < 5; i++)
              Positioned(
                left: 20 + i * 40.0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: (i >= 1 && i <= 3) ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: (i >= 1 && i <= 3) ? Colors.blue : Colors.grey.shade400),
                  ),
                ),
              ),
            Positioned(left: 55, right: 95, child: Container(height: 4, color: Colors.blue)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('RoundRangeSliderTickMarkShape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
