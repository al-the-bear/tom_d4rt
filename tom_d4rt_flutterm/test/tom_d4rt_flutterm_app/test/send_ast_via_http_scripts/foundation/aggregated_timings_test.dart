import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for AggregatedTimings - collection of timing statistics.
/// Displays timing data with min, max, average, and count metrics.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AggregatedTimings Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timing Statistics Dashboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatCard(title: 'Min', value: '12ms', icon: Icons.arrow_downward, color: Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(title: 'Max', value: '89ms', icon: Icons.arrow_upward, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatCard(title: 'Average', value: '34ms', icon: Icons.trending_flat, color: Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(title: 'Count', value: '156', icon: Icons.numbers, color: Colors.purple)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber),
                SizedBox(width: 8),
                Expanded(child: Text('AggregatedTimings provides statistical analysis of performance data')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: TextStyle(color: color.withValues(alpha: 0.8))),
        ],
      ),
    );
  }
}
