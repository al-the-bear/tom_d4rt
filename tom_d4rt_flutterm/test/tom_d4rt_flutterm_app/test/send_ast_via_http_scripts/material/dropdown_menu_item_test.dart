import 'package:flutter/material.dart';

/// Deep visual demo for DropdownMenuItem - item in DropdownButton menu.
/// Shows menu item structure with value and child widget.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownMenuItem Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Column(
          children: [
            _MenuItem('Apple', '🍎', true),
            _MenuItem('Banana', '🍌', false),
            _MenuItem('Cherry', '🍒', false),
            _MenuItem('Date', '🌴', false),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('DropdownMenuItem<T>\nvalue: T, child: Widget', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  const _MenuItem(this.label, this.emoji, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: selected ? Colors.blue.shade50 : Colors.transparent,
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
