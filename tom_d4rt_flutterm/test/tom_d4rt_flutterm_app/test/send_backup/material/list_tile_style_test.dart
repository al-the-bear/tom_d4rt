import 'package:flutter/material.dart';

/// Deep visual demo for ListTileStyle enum.
/// Controls the overall visual density of the ListTile.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ListTileStyle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _StylePreview('list', 'Standard list item', false),
      const SizedBox(height: 8),
      _StylePreview('drawer', 'Navigation drawer', true),
      const SizedBox(height: 12),
      const Text('Affects text size and padding', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _StylePreview extends StatelessWidget {
  final String style;
  final String desc;
  final bool isDrawer;
  const _StylePreview(this.style, this.desc, this.isDrawer);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(isDrawer ? 16 : 12),
      decoration: BoxDecoration(
        color: isDrawer ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(isDrawer ? 24 : 4),
      ),
      child: Row(
        children: [
          Icon(isDrawer ? Icons.inbox : Icons.list, size: isDrawer ? 24 : 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(style, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isDrawer ? 14 : 12)),
              Text(desc, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
