import 'package:flutter/material.dart';

/// Deep visual demo for RefreshIndicatorTriggerMode.
/// Controls when refresh is triggered.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RefreshIndicatorTriggerMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TriggerDemo('onEdge', 'From top only', Colors.blue),
          const SizedBox(width: 16),
          _TriggerDemo('anywhere', 'From any scroll', Colors.green),
        ],
      ),
      const SizedBox(height: 12),
      const Text('triggerMode property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _TriggerDemo extends StatelessWidget {
  final String mode;
  final String desc;
  final Color color;
  const _TriggerDemo(this.mode, this.desc, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withAlpha(30), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(mode, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: color)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    );
  }
}
