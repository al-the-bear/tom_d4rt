import 'package:flutter/material.dart';

/// Deep visual demo for DataTableThemeData - theme data for DataTable.
/// Shows configurable styling properties.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataTableThemeData', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ThemeProperty('headingRowColor', Colors.purple.shade200),
                _ThemeProperty('dataRowColor', Colors.purple.shade50),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Key Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            const SizedBox(height: 4),
            const Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                Chip(label: Text('columnSpacing', style: TextStyle(fontSize: 9)), padding: EdgeInsets.zero),
                Chip(label: Text('horizontalMargin', style: TextStyle(fontSize: 9)), padding: EdgeInsets.zero),
                Chip(label: Text('checkboxHorizontalMargin', style: TextStyle(fontSize: 9)), padding: EdgeInsets.zero),
                Chip(label: Text('dividerThickness', style: TextStyle(fontSize: 9)), padding: EdgeInsets.zero),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class _ThemeProperty extends StatelessWidget {
  final String name;
  final Color color;
  const _ThemeProperty(this.name, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 60, height: 20, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
