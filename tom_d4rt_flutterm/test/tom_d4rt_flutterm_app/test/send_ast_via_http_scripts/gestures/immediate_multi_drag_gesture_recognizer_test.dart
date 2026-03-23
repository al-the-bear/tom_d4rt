// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for ImmediateMultiDragGestureRecognizer.
/// Shows immediate multi-pointer drag without delay.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImmediateMultiDragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Immediate Multi-Drag',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.flash_on, size: 48, color: Colors.orange),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('No Delay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text('Drag recognized immediately on touch', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'Immediate',
                  icon: Icons.flash_on,
                  color: Colors.orange,
                  delay: '0ms',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ComparisonCard(
                  title: 'Delayed',
                  icon: Icons.timer,
                  color: Colors.grey,
                  delay: '~150ms',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Use for draggable items where immediate response is needed, like drag-and-drop.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String delay;
  const _ComparisonCard({required this.title, required this.icon, required this.color, required this.delay});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(children: [
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Text(delay, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
      ]),
    );
  }
}
