import 'package:flutter/material.dart';

/// Deep visual demo for RawChip widget.
/// Base class for all chip widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RawChip', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ChipDemo('Basic', false, false),
                const SizedBox(width: 8),
                _ChipDemo('Selected', true, false),
                const SizedBox(width: 8),
                _ChipDemo('Deletable', false, true),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Configurable base chip', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('avatar, label, deleteIcon', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ChipDemo extends StatelessWidget {
  final String label;
  final bool selected;
  final bool deletable;
  const _ChipDemo(this.label, this.selected, this.deletable);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: selected ? Colors.blue : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: selected ? Colors.white : Colors.black)),
          if (deletable) const SizedBox(width: 4),
          if (deletable) Icon(Icons.close, size: 14, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}
