import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for IOSScrollViewFlingVelocityTracker.
/// Shows iOS-specific fling velocity calculation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('iOS Velocity Tracker')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('iOS Scroll Fling Velocity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.phone_iphone, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('iOS Behavior', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Matches UIScrollView fling physics', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          _FeatureRow(text: 'Uses weighted average of recent samples'),
          _FeatureRow(text: 'Considers only last few samples for velocity'),
          _FeatureRow(text: 'Matched to native iOS scroll behavior'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('Ensures Flutter scrolling feels native on iOS devices.', style: TextStyle(fontSize: 12)),
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
        const Icon(Icons.check, color: Colors.blue, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ]),
    );
  }
}
