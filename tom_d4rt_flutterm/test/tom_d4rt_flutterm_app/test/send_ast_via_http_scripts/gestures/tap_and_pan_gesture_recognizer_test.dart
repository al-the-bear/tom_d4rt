import 'package:flutter/material.dart';

/// Deep visual demo for TapAndPanGestureRecognizer.
/// Shows tap then free-form drag.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TapAndPanGestureRecognizer')),
    body: Center(child: _TapPanDemo()),
  );
}

class _TapPanDemo extends StatefulWidget {
  @override
  State<_TapPanDemo> createState() => _TapPanDemoState();
}

class _TapPanDemoState extends State<_TapPanDemo> {
  Offset _offset = Offset.zero;
  bool _isDragging = false;
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap or drag the circle', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => _tapCount++),
          onPanStart: (_) => setState(() => _isDragging = true),
          onPanUpdate: (d) => setState(() => _offset += d.delta),
          onPanEnd: (_) => setState(() => _isDragging = false),
          child: Container(
            width: 280, height: 200,
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 110 + _offset.dx,
                  top: 70 + _offset.dy,
                  child: Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.purple, Colors.purple.shade800],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.purple.withAlpha(_isDragging ? 150 : 80), blurRadius: _isDragging ? 16 : 8)],
                    ),
                    alignment: Alignment.center,
                    child: Text('\$_tapCount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(label: Text('Taps: \$_tapCount')),
            const SizedBox(width: 8),
            Chip(label: Text('Offset: (\${_offset.dx.toInt()}, \${_offset.dy.toInt()})')),
          ],
        ),
        TextButton(onPressed: () => setState(() { _offset = Offset.zero; _tapCount = 0; }), child: const Text('Reset')),
      ],
    );
  }
}
