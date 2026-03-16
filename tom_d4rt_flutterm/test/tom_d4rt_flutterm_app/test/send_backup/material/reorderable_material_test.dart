import 'package:flutter/material.dart';

/// Deep visual demo for reorderable Material widgets.
/// Drag-and-drop reordering in lists.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Reorderable Material', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _ReorderItem('Item 1', false),
            _ReorderItem('Item 2', true),
            _ReorderItem('Item 3', false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Long press to drag', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ReorderItem extends StatelessWidget {
  final String label;
  final bool dragging;
  const _ReorderItem(this.label, this.dragging);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dragging ? Colors.blue.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: dragging ? [BoxShadow(color: Colors.black26, blurRadius: 8)] : null,
      ),
      child: Row(
        children: [
          Icon(Icons.drag_handle, size: 18, color: Colors.grey.shade400),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
          if (dragging) const Spacer(),
          if (dragging) const Icon(Icons.unfold_more, size: 18, color: Colors.blue),
        ],
      ),
    );
  }
}
