import 'package:flutter/material.dart';

/// Demonstrates Threshold curve - jumps from 0 to 1 at a threshold point.
dynamic build(BuildContext context) {
  const threshold = Threshold(0.5); // Jump at t=0.5

  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final threshVal = threshold.transform(t);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Threshold Curve', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: threshVal == 0 ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Icon(threshVal == 0 ? Icons.radio_button_off : Icons.check_circle, color: Colors.white, size: 50),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: Text('t=${t.toStringAsFixed(2)} → ${threshVal == 0 ? "OFF" : "ON"}', style: const TextStyle(fontFamily: 'monospace')),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: t),
          const SizedBox(height: 8),
          const Text('Threshold(0.5) = instant switch at 50%', style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      );
    },
  );
}
