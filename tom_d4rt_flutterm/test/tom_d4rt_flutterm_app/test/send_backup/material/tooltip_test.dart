import 'package:flutter/material.dart';

/// Deep visual demo for Tooltip widget.
/// Informational popup on long press or hover.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Tooltip', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TooltipDemo('Simple', 'Help text', null),
          const SizedBox(width: 24),
          _TooltipDemo('Rich', 'More info', Icons.info),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const Text('Positions:', style: TextStyle(fontSize: 10)),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PositionDemo('above'),
                _PositionDemo('below'),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('message, preferBelow, waitDuration', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _TooltipDemo extends StatelessWidget {
  final String label;
  final String message;
  final IconData? icon;
  const _TooltipDemo(this.label, this.message, this.icon);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)),
              child: icon != null ? Icon(icon, color: Colors.blue, size: 18) : const Icon(Icons.touch_app, color: Colors.blue, size: 18),
            ),
            Positioned(
              top: -25,
              left: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 9)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class _PositionDemo extends StatelessWidget {
  final String position;
  const _PositionDemo(this.position);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Text(position, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
    );
  }
}
