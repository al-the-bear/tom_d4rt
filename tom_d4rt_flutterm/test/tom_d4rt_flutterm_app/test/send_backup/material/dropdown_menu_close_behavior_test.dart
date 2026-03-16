import 'package:flutter/material.dart';

/// Deep visual demo for DropdownMenuCloseBehavior - when menu closes.
/// Shows different closing behaviors.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DropdownMenu Close Behavior', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BehaviorCard('onItemSelected', Icons.touch_app, 'Close on selection'),
          const SizedBox(width: 12),
          _BehaviorCard('onOutsideTap', Icons.touch_app_outlined, 'Close on outside tap'),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Control menu dismissal behavior', style: TextStyle(fontSize: 11)),
      ),
    ],
  );
}

class _BehaviorCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String desc;
  const _BehaviorCard(this.label, this.icon, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 8), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
