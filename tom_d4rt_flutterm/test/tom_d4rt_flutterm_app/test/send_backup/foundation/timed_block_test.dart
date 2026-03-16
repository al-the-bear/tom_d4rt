import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for TimedBlock - timing measurement block.
/// Shows measuring execution time of code blocks.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TimedBlock Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timed Block Measurement',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _TimingRow(name: 'build', duration: 12.4, color: Colors.green),
          _TimingRow(name: 'layout', duration: 8.2, color: Colors.blue),
          _TimingRow(name: 'paint', duration: 15.7, color: Colors.orange),
          _TimingRow(name: 'compositing', duration: 3.1, color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Timeline.startSync("name");', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                Text('// code to measure', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey)),
                Text('Timeline.finishSync();', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('TimedBlock records the duration and can be aggregated for analysis.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _TimingRow extends StatelessWidget {
  final String name;
  final double duration;
  final Color color;
  const _TimingRow({required this.name, required this.duration, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(Icons.timer, color: color, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          child: Text('\${duration.toStringAsFixed(1)} ms', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
