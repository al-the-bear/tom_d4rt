import 'package:flutter/material.dart';

/// Deep visual demo for TabBar widget.
/// Material tab bar for navigation between views.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TabBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(color: Colors.blue, borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TabItem(Icons.photo, 'Photos', true),
            _TabItem(Icons.music_note, 'Music', false),
            _TabItem(Icons.videocam, 'Videos', false),
          ],
        ),
      ),
      Container(
        width: 210,
        height: 60,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8))),
        child: const Center(child: Text('Tab content', style: TextStyle(color: Colors.grey, fontSize: 11))),
      ),
      const SizedBox(height: 12),
      const Text('tabs, controller, indicator, labelColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _TabItem(this.icon, this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: selected ? const Border(bottom: BorderSide(color: Colors.white, width: 2)) : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? Colors.white : Colors.white54, size: 18),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: selected ? Colors.white : Colors.white54, fontSize: 9)),
        ],
      ),
    );
  }
}
