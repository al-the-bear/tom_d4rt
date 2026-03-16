import 'package:flutter/material.dart';

/// Deep visual demo for Tab widget.
/// Single tab in a TabBar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Tab', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TabDemo('Text Only', null, 'Home'),
          const SizedBox(width: 12),
          _TabDemo('Icon Only', Icons.search, null),
          const SizedBox(width: 12),
          _TabDemo('Both', Icons.person, 'Profile'),
        ],
      ),
      const SizedBox(height: 12),
      const Text('text, icon, iconMargin, height', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TabDemo extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? text;
  const _TabDemo(this.label, this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, color: Colors.blue, size: 20),
              if (icon != null && text != null) const SizedBox(height: 4),
              if (text != null) Text(text!, style: const TextStyle(color: Colors.blue, fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
