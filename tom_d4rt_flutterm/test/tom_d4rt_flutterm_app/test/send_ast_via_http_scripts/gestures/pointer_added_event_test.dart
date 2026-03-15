import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerAddedEvent.
/// Shows when a new pointer is detected.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerAddedEvent')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Added Event',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.add_circle, size: 48, color: Colors.green),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Pointer Detected', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
                      child: const Text('ADDED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          _EventTimeline(events: ['added', 'hover', 'down', 'move', 'up', 'removed'], current: 0),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Dispatched when a pointer (mouse, stylus) enters the coordinate space. Not all devices send this.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _EventTimeline extends StatelessWidget {
  final List<String> events;
  final int current;
  const _EventTimeline({required this.events, required this.current});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (int i = 0; i < events.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: i == current ? Colors.green : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(events[i], style: TextStyle(fontSize: 11, color: i == current ? Colors.white : Colors.grey)),
          ),
          if (i < events.length - 1) Container(width: 20, height: 2, color: Colors.grey.shade300),
        ],
      ]),
    );
  }
}
