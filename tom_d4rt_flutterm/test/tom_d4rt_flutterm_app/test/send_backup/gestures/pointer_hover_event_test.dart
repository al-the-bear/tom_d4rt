import 'package:flutter/material.dart';

/// Deep visual demo for PointerHoverEvent.
/// Shows real-time cursor tracking without pressing.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerHoverEvent')),
    body: Center(child: _HoverTracker()),
  );
}

class _HoverTracker extends StatefulWidget {
  @override
  State<_HoverTracker> createState() => _HoverTrackerState();
}

class _HoverTrackerState extends State<_HoverTracker> {
  Offset _position = Offset.zero;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Hover over the area below'),
        const SizedBox(height: 16),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          onHover: (e) => setState(() => _position = e.localPosition),
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                if (_isHovering)
                  Positioned(
                    left: _position.dx - 10,
                    top: _position.dy - 10,
                    child: Container(
                      width: 20, height: 20,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                Center(child: Text(_isHovering 
                  ? 'X: \${_position.dx.toInt()}, Y: \${_position.dy.toInt()}'
                  : 'Hover to track',
                  style: const TextStyle(fontSize: 16),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('PointerHoverEvent fires continuously while cursor moves', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
