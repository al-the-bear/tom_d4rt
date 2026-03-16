import 'package:flutter/material.dart';

/// Deep visual demo for TapAndHorizontalDragGestureRecognizer.
/// Shows tap then horizontal-only drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapAndHorizontalDrag')),
    body: Center(child: _HorizDragDemo()),
  );
}

class _HorizDragDemo extends StatefulWidget {
  @override
  State<_HorizDragDemo> createState() => _HorizDragDemoState();
}

class _HorizDragDemoState extends State<_HorizDragDemo> {
  double _xPos = 0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap then drag horizontally', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        GestureDetector(
          onHorizontalDragStart: (_) => setState(() => _isDragging = true),
          onHorizontalDragUpdate: (d) => setState(() => _xPos = (_xPos + d.delta.dx).clamp(-100, 100)),
          onHorizontalDragEnd: (_) => setState(() => _isDragging = false),
          child: Container(
            width: 280, height: 80,
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.cyan, width: 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 120 + _xPos,
                  top: 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: _isDragging ? Colors.cyan : Colors.cyan.shade300,
                      shape: BoxShape.circle,
                      boxShadow: _isDragging ? [BoxShadow(color: Colors.cyan.withAlpha(100), blurRadius: 12)] : [],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.swap_horiz, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('X offset: \${_xPos.toInt()}', style: const TextStyle(fontSize: 14)),
        TextButton(onPressed: () => setState(() => _xPos = 0), child: const Text('Reset')),
        const SizedBox(height: 8),
        const Text('Vertical movement is ignored', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
