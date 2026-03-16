import 'package:flutter/material.dart';

/// Deep visual demo for MaterialScrollBehavior.
/// Defines scroll physics and decorations for Material.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialScrollBehavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PlatformScroll('Android', Icons.android, 'Glow', Colors.green),
          const SizedBox(width: 16),
          _PlatformScroll('iOS', Icons.phone_iphone, 'Bounce', Colors.blue),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Customizable via ScrollConfiguration', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}

class _PlatformScroll extends StatelessWidget {
  final String platform;
  final IconData icon;
  final String effect;
  final Color color;
  const _PlatformScroll(this.platform, this.icon, this.effect, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(platform, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 11)),
          Text(effect, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}
