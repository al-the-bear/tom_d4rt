import 'package:flutter/material.dart';

/// Deep visual demo for MaterialBannerClosedReason enum.
/// Indicates why a MaterialBanner was closed.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialBannerClosedReason', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      _ReasonRow(Icons.touch_app, 'dismiss', 'User tapped action', Colors.blue),
      const SizedBox(height: 8),
      _ReasonRow(Icons.swap_horiz, 'swipe', 'User swiped away', Colors.orange),
      const SizedBox(height: 8),
      _ReasonRow(Icons.code, 'hide', 'hideCurrentBanner()', Colors.green),
      const SizedBox(height: 8),
      _ReasonRow(Icons.delete, 'remove', 'removeCurrentBanner()', Colors.red),
      const SizedBox(height: 12),
      const Text('Returned by ScaffoldMessenger', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ReasonRow extends StatelessWidget {
  final IconData icon;
  final String reason;
  final String desc;
  final Color color;
  const _ReasonRow(this.icon, this.reason, this.desc, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reason, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
              Text(desc, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
