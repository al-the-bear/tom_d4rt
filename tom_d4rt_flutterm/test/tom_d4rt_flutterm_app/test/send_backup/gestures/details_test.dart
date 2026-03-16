import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for gesture detail classes.
/// Shows various gesture detail objects.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Gesture Details')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gesture Detail Classes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DetailCard(name: 'TapDownDetails', props: ['globalPosition', 'localPosition', 'kind']),
          _DetailCard(name: 'TapUpDetails', props: ['globalPosition', 'localPosition', 'kind']),
          _DetailCard(name: 'DragDownDetails', props: ['globalPosition', 'localPosition']),
          _DetailCard(name: 'DragStartDetails', props: ['globalPosition', 'localPosition', 'sourceTimeStamp']),
          _DetailCard(name: 'DragUpdateDetails', props: ['globalPosition', 'localPosition', 'delta', 'primaryDelta']),
          _DetailCard(name: 'DragEndDetails', props: ['velocity', 'primaryVelocity']),
          _DetailCard(name: 'ScaleStartDetails', props: ['focalPoint', 'localFocalPoint', 'pointerCount']),
          _DetailCard(name: 'ScaleUpdateDetails', props: ['focalPoint', 'scale', 'rotation']),
        ],
      ),
    ),
  );
}

class _DetailCard extends StatelessWidget {
  final String name;
  final List<String> props;
  const _DetailCard({required this.name, required this.props});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Wrap(spacing: 8, runSpacing: 4, children: props.map((p) => Chip(
            label: Text(p, style: const TextStyle(fontSize: 10)),
            visualDensity: VisualDensity.compact,
          )).toList()),
        ],
      ),
    );
  }
}
