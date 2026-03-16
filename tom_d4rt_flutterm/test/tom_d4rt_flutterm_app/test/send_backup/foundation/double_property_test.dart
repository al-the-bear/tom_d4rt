import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DoubleProperty - diagnostic property for doubles.
/// Shows number formatting, units, and display options.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DoubleProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Double Value Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DoubleCard(name: 'width', value: 200.0, unit: 'px', color: Colors.blue),
          _DoubleCard(name: 'opacity', value: 0.85, unit: '', color: Colors.purple),
          _DoubleCard(name: 'rotation', value: 45.0, unit: '°', color: Colors.orange),
          _DoubleCard(name: 'fontSize', value: 16.0, unit: 'sp', color: Colors.green),
          _DoubleCard(name: 'elevation', value: 4.0, unit: 'dp', color: Colors.teal),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Options:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• unit - suffix for display'),
                Text('• defaultValue - skip if equal'),
                Text('• tooltip - hover description'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _DoubleCard extends StatelessWidget {
  final String name;
  final double value;
  final String unit;
  final Color color;
  const _DoubleCard({required this.name, required this.value, required this.unit, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text('\$value\$unit', style: const TextStyle(color: Colors.white, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }
}
