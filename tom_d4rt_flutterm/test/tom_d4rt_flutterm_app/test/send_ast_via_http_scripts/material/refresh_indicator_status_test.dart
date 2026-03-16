import 'package:flutter/material.dart';

/// Deep visual demo for RefreshIndicatorMode enum.
/// Current mode of RefreshIndicator.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RefreshIndicatorMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ModeDemo('drag', Icons.arrow_downward, Colors.grey),
          const Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          _ModeDemo('armed', Icons.pause_circle, Colors.orange),
          const Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          _ModeDemo('refresh', Icons.sync, Colors.blue),
          const Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          _ModeDemo('done', Icons.check_circle, Colors.green),
        ],
      ),
      const SizedBox(height: 12),
      const Text('drag → armed → refresh → done', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _ModeDemo extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _ModeDemo(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 8, color: color)),
      ],
    );
  }
}
