import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DragGestureRecognizer.
/// Shows base class for drag detection.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DragGestureRecognizer')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Drag Gesture Recognition',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DragType(type: 'Vertical', icon: Icons.swap_vert, color: Colors.blue),
          _DragType(type: 'Horizontal', icon: Icons.swap_horiz, color: Colors.green),
          _DragType(type: 'Pan (Both)', icon: Icons.open_with, color: Colors.purple),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• onDown - initial touch'),
                Text('• onStart - drag begins'),
                Text('• onUpdate - drag moves'),
                Text('• onEnd - drag completes'),
                Text('• onCancel - drag cancelled'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _DragType extends StatelessWidget {
  final String type;
  final IconData icon;
  final Color color;
  const _DragType({required this.type, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Text('\$type Drag', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ]),
    );
  }
}
