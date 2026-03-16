import 'package:flutter/material.dart';

/// Deep visual demo for DeletableChipAttributes - interface for deletable chips.
/// Shows onDeleted callback and deleteIcon customization.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DeletableChipAttributes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          Chip(
            label: const Text('With Delete'),
            deleteIcon: const Icon(Icons.close, size: 18),
            onDeleted: () {},
          ),
          Chip(
            label: const Text('Custom Icon'),
            deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.red),
            onDeleted: () {},
          ),
          Chip(
            label: const Text('No Delete'),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Text('Interface Properties:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            Text('• onDeleted: VoidCallback?', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('• deleteIcon: Widget?', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('• deleteIconColor: Color?', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
            Text('• deleteButtonTooltipMessage: String?', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}
