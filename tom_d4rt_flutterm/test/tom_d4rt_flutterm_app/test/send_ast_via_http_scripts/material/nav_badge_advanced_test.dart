import 'package:flutter/material.dart';

/// Deep visual demo for Navigation Badges.
/// Shows badge variants on navigation items.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Navigation Badges', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BadgeDemo(Icons.mail, '3', Colors.blue),
          const SizedBox(width: 24),
          _BadgeDemo(Icons.notifications, '99+', Colors.orange),
          const SizedBox(width: 24),
          _BadgeDemo(Icons.chat, '', Colors.green),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Count, overflow, dot indicator', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _BadgeDemo extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _BadgeDemo(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 32, color: color),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            constraints: BoxConstraints(minWidth: label.isEmpty ? 8 : 16, minHeight: label.isEmpty ? 8 : 16),
            padding: EdgeInsets.symmetric(horizontal: label.isEmpty ? 0 : 4),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: label.isNotEmpty ? Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))) : null,
          ),
        ),
      ],
    );
  }
}
