import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for BaseTapGestureRecognizer.
/// Shows base class for tap gesture recognizers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BaseTapGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Base Tap Recognition',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _TapPhase(phase: 'Down', desc: 'Touch begins', icon: Icons.arrow_downward, color: Colors.blue),
          _TapPhase(phase: 'Cancel', desc: 'Gesture cancelled', icon: Icons.cancel, color: Colors.orange),
          _TapPhase(phase: 'Up', desc: 'Touch ends', icon: Icons.arrow_upward, color: Colors.green),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subclasses:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• TapGestureRecognizer - single tap'),
                Text('• DoubleTapGestureRecognizer - double tap'),
                Text('• LongPressGestureRecognizer - long press'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TapPhase extends StatelessWidget {
  final String phase;
  final String desc;
  final IconData icon;
  final Color color;
  const _TapPhase({required this.phase, required this.desc, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Text(phase, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        const Spacer(),
        Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ]),
    );
  }
}
