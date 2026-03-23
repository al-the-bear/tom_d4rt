// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for velocity in drag gestures.
/// Shows how velocity affects fling behavior.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Velocity in Drag')),
    body: Center(child: _VelocityDragDemo()),
  );
}

class _VelocityDragDemo extends StatefulWidget {
  @override
  State<_VelocityDragDemo> createState() => _VelocityDragDemoState();
}

class _VelocityDragDemoState extends State<_VelocityDragDemo> {
  double _xPos = 0;
  double _velocity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Drag and release to see velocity', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        GestureDetector(
          onHorizontalDragUpdate: (d) => setState(() => _xPos = (_xPos + d.delta.dx).clamp(-120, 120)),
          onHorizontalDragEnd: (d) => setState(() {
            _velocity = d.velocity.pixelsPerSecond.dx;
          }),
          child: Container(
            width: 300, height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 125 + _xPos,
                  top: 10,
                  child: Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _velocity.abs() > 1000 
                          ? [Colors.red, Colors.orange]
                          : [Colors.blue, Colors.cyan],
                      ),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.swipe, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _velocity.abs() > 1000 ? Colors.red.shade50 : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('Velocity: \${_velocity.toStringAsFixed(0)} px/s',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(_velocity.abs() > 1000 ? 'FLING!' : 'Normal drag', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        TextButton(onPressed: () => setState(() { _xPos = 0; _velocity = 0; }), child: const Text('Reset')),
      ],
    );
  }
}
