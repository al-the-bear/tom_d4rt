import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PercentProperty - percentage value diagnostic.
/// Shows values formatted as percentages (0.5 → 50%).
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PercentProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Percentage Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PercentBar(name: 'opacity', value: 0.85, color: Colors.blue),
          _PercentBar(name: 'progress', value: 0.42, color: Colors.green),
          _PercentBar(name: 'volume', value: 0.7, color: Colors.orange),
          _PercentBar(name: 'brightness', value: 1.0, color: Colors.amber),
          _PercentBar(name: 'saturation', value: 0.5, color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Format:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• 0.0 → 0%', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('• 0.5 → 50%', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                Text('• 1.0 → 100%', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _PercentBar extends StatelessWidget {
  final String name;
  final double value;
  final Color color;
  const _PercentBar({required this.name, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(width: 50, child: Text('\${(value * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color))),
      ]),
    );
  }
}
