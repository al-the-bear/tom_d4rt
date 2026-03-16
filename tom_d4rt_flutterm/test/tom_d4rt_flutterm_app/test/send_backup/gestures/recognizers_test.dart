import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for gesture recognizers overview.
/// Shows common recognizers and their uses.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Gesture Recognizers')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Common Recognizers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _RecognizerCard('TapGestureRecognizer', 'Taps, double-taps', Icons.touch_app, Colors.blue),
        _RecognizerCard('LongPressGestureRecognizer', 'Press and hold', Icons.back_hand, Colors.orange),
        _RecognizerCard('PanGestureRecognizer', 'Drag in any direction', Icons.open_with, Colors.green),
        _RecognizerCard('ScaleGestureRecognizer', 'Pinch zoom/rotate', Icons.pinch, Colors.purple),
        _RecognizerCard('VerticalDragGestureRecognizer', 'Up/down drag only', Icons.swap_vert, Colors.teal),
        _RecognizerCard('HorizontalDragGestureRecognizer', 'Left/right drag only', Icons.swap_horiz, Colors.indigo),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('Use GestureDetector widget for easy integration', style: TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RecognizerCard extends StatelessWidget {
  final String name;
  final String desc;
  final IconData icon;
  final Color color;
  const _RecognizerCard(this.name, this.desc, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: CircleAvatar(backgroundColor: color.withAlpha(50), child: Icon(icon, color: color)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      subtitle: Text(desc, style: const TextStyle(fontSize: 12)),
    ),
  );
}
