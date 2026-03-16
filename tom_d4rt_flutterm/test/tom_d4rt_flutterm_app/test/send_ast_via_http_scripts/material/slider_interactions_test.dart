import 'package:flutter/material.dart';

/// Deep visual demo for Slider interactions.
/// Touch and drag interaction behaviors.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Slider Interactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Column(
        children: [
          _InteractionDemo('Tap Track', Icons.touch_app, Colors.blue),
          const SizedBox(height: 8),
          _InteractionDemo('Drag Thumb', Icons.pan_tool, Colors.green),
          const SizedBox(height: 8),
          _InteractionDemo('Press & Hold', Icons.radio_button_checked, Colors.orange),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            Positioned(left: 0, right: 80, child: Container(height: 4, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)))),
            Positioned(
              right: 75,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.blue.withAlpha(75), blurRadius: 8, spreadRadius: 4)]),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('allowedInteraction property', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _InteractionDemo extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _InteractionDemo(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}
