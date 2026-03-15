import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for MacOSScrollViewFlingVelocityTracker.
/// Shows macOS-specific fling velocity calculation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('macOS Velocity Tracker')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('macOS Scroll Fling Velocity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.laptop_mac, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('macOS Behavior', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Matches NSScrollView fling physics', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          _FeatureRow(text: 'Optimized for trackpad gestures'),
          _FeatureRow(text: 'Smooth momentum scrolling'),
          _FeatureRow(text: 'Matches native macOS feel'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Ensures Flutter scrolling feels native on macOS desktop.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        const Icon(Icons.check, color: Colors.blueGrey, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }
}
