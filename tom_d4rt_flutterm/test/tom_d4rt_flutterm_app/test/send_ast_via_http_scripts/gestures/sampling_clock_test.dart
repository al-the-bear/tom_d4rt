import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for SamplingClock.
/// Shows time source for event resampling.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('SamplingClock')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sampling Clock', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.access_time, color: Colors.deepPurple), SizedBox(width: 8),
                  Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('Provides timestamps for PointerEventResampler to synchronize '
                  'touch events with display refresh.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('API:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• now() → DateTime'),
                Text('  Returns current time'),
                SizedBox(height: 8),
                Text('• fromSystemTime(systemTime) → Duration'),
                Text('  Converts system time to sample time'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'Used internally by Flutter framework for touch prediction and latency reduction',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    ),
  );
}
