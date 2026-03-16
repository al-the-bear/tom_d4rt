import 'package:flutter/material.dart';

/// Deep visual demo for PopupMenuEntry abstract class.
/// Base class for popup menu items.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PopupMenuEntry<T>', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _EntryType('PopupMenuItem', 'Standard item', Colors.blue),
            const SizedBox(height: 8),
            _EntryType('CheckedPopupMenuItem', 'With checkbox', Colors.green),
            const SizedBox(height: 8),
            _EntryType('PopupMenuDivider', 'Separator', Colors.orange),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Abstract: represents, handleTap', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _EntryType extends StatelessWidget {
  final String name;
  final String desc;
  final Color color;
  const _EntryType(this.name, this.desc, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              Text(desc, style: const TextStyle(fontSize: 8, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
