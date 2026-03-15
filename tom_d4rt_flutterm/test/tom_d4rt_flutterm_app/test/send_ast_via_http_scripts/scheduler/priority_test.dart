import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Widget _bar(String label, int value, Color color) {
  final height = (value / 5000).clamp(0.08, 1.0) * 90;
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: height.toDouble(), width: 32, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6))),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
        Text('$value', style: const TextStyle(fontSize: 10)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  final idle = Priority.idle;
  final animation = Priority.animation;
  final touch = Priority.touch;
  final boostedIdle = idle + 500;
  final loweredTouch = touch - 1500;

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Scheduler Priority Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bar('idle', idle.value, Colors.grey),
              _bar('anim', animation.value, Colors.blue),
              _bar('touch', touch.value, Colors.green),
              _bar('idle+500', boostedIdle.value, Colors.orange),
              _bar('touch-1500', loweredTouch.value, Colors.red),
            ],
          ),
        ),
      ],
    ),
  );
}