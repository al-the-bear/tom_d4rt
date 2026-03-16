import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerExitEvent.
/// Shows cursor leaving a widget area.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerExitEvent')),
    body: Center(
      child: _HoverDemo(),
    ),
  );
}

class _HoverDemo extends StatefulWidget {
  @override
  State<_HoverDemo> createState() => _HoverDemoState();
}

class _HoverDemoState extends State<_HoverDemo> {
  bool _isHovering = false;
  int _exitCount = 0;
  String _lastExitPos = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Move cursor in and out of box', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (e) => setState(() {
            _isHovering = false;
            _exitCount++;
            _lastExitPos = '(\${e.position.dx.toInt()}, \${e.position.dy.toInt()})';
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              color: _isHovering ? Colors.green : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _isHovering ? Colors.green.shade700 : Colors.grey, width: 3),
            ),
            alignment: Alignment.center,
            child: Text(
              _isHovering ? 'HOVERING' : 'NOT HOVERING',
              style: TextStyle(fontWeight: FontWeight.bold, color: _isHovering ? Colors.white : Colors.black54),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Exit events: \$_exitCount', style: const TextStyle(fontSize: 14)),
        Text('Last exit position: \$_lastExitPos', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
