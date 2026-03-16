import 'package:flutter/material.dart';

/// Demonstrates StepTween - interpolates integers, always rounding down.
dynamic build(BuildContext context) {
  final tween = StepTween(begin: 0, end: 5);

  return TweenAnimationBuilder<int>(
    tween: tween,
    duration: const Duration(seconds: 3),
    builder: (context, value, _) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('StepTween Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i <= 5; i++)
              Container(
                width: 40, height: 40, margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i <= value ? Colors.teal : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('$i', style: TextStyle(color: i <= value ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
          child: Text('Current step: $value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        const Text('Always rounds DOWN (floor)', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    ),
  );
}
