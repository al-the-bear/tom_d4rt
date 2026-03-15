import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for GestureDisposition enum.
/// Shows gesture arena outcomes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('GestureDisposition')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gesture Disposition',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DispositionCard(
            value: 'accepted',
            icon: Icons.check_circle,
            color: Colors.green,
            desc: 'Gesture wins the arena and receives events',
          ),
          _DispositionCard(
            value: 'rejected',
            icon: Icons.cancel,
            color: Colors.red,
            desc: 'Gesture loses and stops receiving events',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              children: [
                Text('Gesture Arena', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Multiple recognizers compete for the same pointer. Only one can win.', style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _DispositionCard extends StatelessWidget {
  final String value;
  final IconData icon;
  final Color color;
  final String desc;
  const _DispositionCard({required this.value, required this.icon, required this.color, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
      child: Row(children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ]),
    );
  }
}
