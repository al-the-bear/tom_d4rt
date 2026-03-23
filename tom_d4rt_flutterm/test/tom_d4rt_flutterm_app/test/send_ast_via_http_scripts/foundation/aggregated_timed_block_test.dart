// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for AggregatedTimedBlock - aggregates timing data.
/// Shows how multiple timing measurements are combined for profiling.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AggregatedTimedBlock Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aggregated Timing Visualization',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _TimingBar(label: 'Build Phase', duration: 45, color: Colors.blue),
          _TimingBar(label: 'Layout Phase', duration: 23, color: Colors.green),
          _TimingBar(label: 'Paint Phase', duration: 67, color: Colors.orange),
          _TimingBar(label: 'Composite', duration: 12, color: Colors.purple),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Total Aggregated: 147ms',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'AggregatedTimedBlock combines timing from multiple operations',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _TimingBar extends StatelessWidget {
  final String label;
  final int duration;
  final Color color;
  const _TimingBar({
    required this.label,
    required this.duration,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: duration / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '\${duration}ms',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
