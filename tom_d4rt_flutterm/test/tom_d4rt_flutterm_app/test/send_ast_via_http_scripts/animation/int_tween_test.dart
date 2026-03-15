import 'package:flutter/material.dart';

/// Demonstrates IntTween - interpolates between two integers.
dynamic build(BuildContext context) {
  final tween = IntTween(begin: 0, end: 100);

  return TweenAnimationBuilder<int>(
    tween: tween,
    duration: const Duration(seconds: 3),
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('IntTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          width: 120, height: 120,
          decoration: BoxDecoration(color: Colors.blue.shade100, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$value', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(value: value / 100, minHeight: 8),
        const SizedBox(height: 8),
        const Text('Returns whole numbers only', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    ),
  );
}
