import 'package:flutter/material.dart';

/// Deep visual demo for RangeSliderThumbShape.
/// Abstract class for range slider thumb shapes.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RangeSliderThumbShape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ThumbDemo('Circle', 20, 20, 10),
          const SizedBox(width: 16),
          _ThumbDemo('Large', 28, 28, 14),
          const SizedBox(width: 16),
          _ThumbDemo('Square', 16, 16, 2),
        ],
      ),
      const SizedBox(height: 12),
      const Text('RoundRangeSliderThumbShape', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ThumbDemo extends StatelessWidget {
  final String label;
  final double w;
  final double h;
  final double r;
  const _ThumbDemo(this.label, this.w, this.h, this.r);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(r),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}
