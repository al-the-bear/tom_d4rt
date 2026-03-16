import 'package:flutter/material.dart';

/// Deep visual demo for progress indicators.
/// CircularProgressIndicator, LinearProgressIndicator.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Progress Indicators', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(strokeWidth: 3, value: 0.7, backgroundColor: Colors.grey.shade200, color: Colors.blue),
                    const Text('70%', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('Circular', style: TextStyle(fontSize: 9)),
            ],
          ),
          const SizedBox(width: 32),
          Column(
            children: [
              Container(
                width: 100,
                height: 8,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.7,
                  child: Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4))),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Linear', style: TextStyle(fontSize: 9)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Determinate & indeterminate', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
