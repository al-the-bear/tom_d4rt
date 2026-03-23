// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for TapDragStartDetails.
/// Shows drag start info in tap-drag sequence.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapDragStartDetails')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tap Drag Start Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Triggered when:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Pointer moves enough to start drag'),
                Text('(exceeds slop threshold)'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Timeline diagram
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text(
                  'Gesture Timeline',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _TimelineStep('Down', Colors.blue, true),
                    _TimelineLine(),
                    _TimelineStep('Start', Colors.green, true),
                    _TimelineLine(),
                    _TimelineStep('Update', Colors.orange, false),
                    _TimelineLine(),
                    _TimelineStep('End', Colors.red, false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Properties:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• globalPosition, localPosition'),
                Text('• kind, consecutiveTapCount'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TimelineStep extends StatelessWidget {
  final String label;
  final Color color;
  final bool highlighted;
  const _TimelineStep(this.label, this.color, this.highlighted);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: highlighted ? color : color.withAlpha(100),
            shape: BoxShape.circle,
            border: highlighted
                ? Border.all(color: color.withAlpha(200), width: 2)
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: highlighted ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _TimelineLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 2,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 20),
    ),
  );
}
