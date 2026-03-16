import 'package:flutter/material.dart';

/// Deep visual demo for Durations - Material 3 standard durations.
/// Shows predefined animation duration constants.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Durations (Material 3)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _DurationBar('short1', 50, Colors.purple.shade200),
            _DurationBar('short2', 100, Colors.purple.shade300),
            _DurationBar('short3', 150, Colors.purple.shade400),
            _DurationBar('short4', 200, Colors.purple.shade500),
            _DurationBar('medium1', 250, Colors.purple.shade600),
            _DurationBar('medium2', 300, Colors.purple.shade700),
            _DurationBar('medium3', 350, Colors.purple.shade800),
            _DurationBar('medium4', 400, Colors.purple.shade900),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Standard durations for consistent timing', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DurationBar extends StatelessWidget {
  final String name;
  final int ms;
  final Color color;
  const _DurationBar(this.name, this.ms, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(name, style: const TextStyle(fontSize: 10, fontFamily: 'monospace'))),
          Expanded(
            child: Container(
              height: 14,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ms / 400,
                child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
              ),
            ),
          ),
          SizedBox(width: 40, child: Text('${ms}ms', style: const TextStyle(fontSize: 9), textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
