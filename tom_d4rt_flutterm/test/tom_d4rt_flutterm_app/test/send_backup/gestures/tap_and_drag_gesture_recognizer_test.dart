import 'package:flutter/material.dart';

/// Deep visual demo for TapAndDragGestureRecognizer.
/// Shows combined tap-then-drag gestures.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapAndDragGestureRecognizer')),
    body: Center(child: _TapDragDemo()),
  );
}

class _TapDragDemo extends StatefulWidget {
  @override
  State<_TapDragDemo> createState() => _TapDragDemoState();
}

class _TapDragDemoState extends State<_TapDragDemo> {
  String _state = 'Idle';
  Offset _pos = const Offset(140, 100);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap then drag (like text selection)', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onTapDown: (d) => setState(() => _state = 'Tap Down'),
          onTap: () => setState(() => _state = 'Tapped'),
          onPanStart: (d) => setState(() {
            _state = 'Dragging';
            _pos = d.localPosition;
          }),
          onPanUpdate: (d) => setState(() => _pos = d.localPosition),
          onPanEnd: (_) => setState(() => _state = 'Drag Ended'),
          child: Container(
            width: 280, height: 200,
            decoration: BoxDecoration(
              color: _state == 'Dragging' ? Colors.orange.shade100 : Colors.grey.shade100,
              border: Border.all(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: _pos.dx - 20,
                  top: _pos.dy - 20,
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.orange.withAlpha(100), blurRadius: 8)],
                    ),
                    child: const Icon(Icons.touch_app, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('State: \$_state', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        const Text('Combines TapGestureRecognizer + DragGestureRecognizer', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
