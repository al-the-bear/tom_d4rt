import 'package:flutter/material.dart';

/// Deep visual demo for MergeableMaterialItem.
/// Base class for items in MergeableMaterial.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MergeableMaterialItem', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _MaterialSlice('MaterialSlice', 'Content widget', Colors.blue),
            Container(height: 8, color: Colors.grey.shade200),
            _MaterialSlice('MaterialGap', 'Divider space', Colors.orange),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('MaterialSlice or MaterialGap', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _MaterialSlice extends StatelessWidget {
  final String type;
  final String desc;
  final Color color;
  const _MaterialSlice(this.type, this.desc, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withAlpha(30)),
      child: Column(
        children: [
          Text(type, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
          Text(desc, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
