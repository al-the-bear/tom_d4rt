import 'package:flutter/material.dart';

/// Demonstrates Curve - the base class for all animation curves.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Curve Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      SizedBox(
        height: 200, width: 280,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CurveDemo('linear', Curves.linear, Colors.grey),
            _CurveDemo('easeIn', Curves.easeIn, Colors.blue),
            _CurveDemo('easeOut', Curves.easeOut, Colors.green),
            _CurveDemo('bounce', Curves.bounceOut, Colors.orange),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('Transforms linear time to custom progress', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _CurveDemo extends StatelessWidget {
  final String name; final Curve curve; final Color color;
  const _CurveDemo(this.name, this.curve, this.color);
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 2),
    curve: curve,
    builder: (context, value, _) => Column(
      children: [
        Container(
          width: 50, height: 150,
          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
          child: Align(
            alignment: Alignment(0, 1 - 2 * value),
            child: Container(width: 20, height: 20, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}
