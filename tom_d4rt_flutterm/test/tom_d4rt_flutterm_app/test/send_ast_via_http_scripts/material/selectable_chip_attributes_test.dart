import 'package:flutter/material.dart';

/// Deep visual demo for SelectableChipAttributes mixin.
/// Shared attributes for selectable chip widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SelectableChipAttributes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Mixin for:', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ChipDemo('FilterChip', true),
                const SizedBox(width: 8),
                _ChipDemo('ChoiceChip', false),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Properties:', style: TextStyle(fontSize: 10)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: [
                _PropChip('selected'),
                _PropChip('onSelected'),
                _PropChip('showCheckmark'),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('selectedColor, checkmarkColor', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ChipDemo extends StatelessWidget {
  final String label;
  final bool selected;
  const _ChipDemo(this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) const Icon(Icons.check, size: 14, color: Colors.blue),
          if (selected) const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}

class _PropChip extends StatelessWidget {
  final String prop;
  const _PropChip(this.prop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Text(prop, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
    );
  }
}
