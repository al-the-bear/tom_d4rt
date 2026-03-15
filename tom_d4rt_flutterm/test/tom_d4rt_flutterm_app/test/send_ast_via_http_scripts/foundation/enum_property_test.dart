import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for EnumProperty - diagnostic property for enums.
/// Shows enum value formatting in debug output.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('EnumProperty Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enum Value Diagnostics',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _EnumDisplay(enumType: 'Axis', selected: 'horizontal', values: ['horizontal', 'vertical'], color: Colors.blue),
          const SizedBox(height: 12),
          _EnumDisplay(enumType: 'MainAxisAlignment', selected: 'center', values: ['start', 'end', 'center', 'spaceBetween', 'spaceAround', 'spaceEvenly'], color: Colors.green),
          const SizedBox(height: 12),
          _EnumDisplay(enumType: 'CrossAxisAlignment', selected: 'stretch', values: ['start', 'end', 'center', 'stretch', 'baseline'], color: Colors.orange),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('EnumProperty displays enum.name without the enum type prefix for cleaner output.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _EnumDisplay extends StatelessWidget {
  final String enumType;
  final String selected;
  final List<String> values;
  final Color color;
  const _EnumDisplay({required this.enumType, required this.selected, required this.values, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(enumType, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: values.map((v) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: v == selected ? color : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(v, style: TextStyle(fontSize: 11, color: v == selected ? Colors.white : Colors.black87)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
