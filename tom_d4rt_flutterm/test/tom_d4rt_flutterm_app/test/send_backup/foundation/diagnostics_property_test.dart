import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticsProperty - property node for diagnostics.
/// Shows name-value pairs with formatting options.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticsProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Property Types & Display',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PropRow(type: 'StringProperty', name: 'title', value: '"Hello World"', color: Colors.green),
          _PropRow(type: 'IntProperty', name: 'count', value: '42', color: Colors.blue),
          _PropRow(type: 'DoubleProperty', name: 'opacity', value: '0.85', color: Colors.orange),
          _PropRow(type: 'FlagProperty', name: 'enabled', value: 'true', color: Colors.purple),
          _PropRow(type: 'EnumProperty', name: 'axis', value: 'Axis.horizontal', color: Colors.teal),
          _PropRow(type: 'ColorProperty', name: 'color', value: 'Color(0xFF2196F3)', color: Colors.pink),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display Options:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• level - visibility (hidden, info, warning)'),
                Text('• showName - whether to show property name'),
                Text('• defaultValue - value to hide if equal'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _PropRow extends StatelessWidget {
  final String type;
  final String name;
  final String value;
  final Color color;
  const _PropRow({required this.type, required this.name, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text(type, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Text('\$name: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace'))),
        ],
      ),
    );
  }
}
