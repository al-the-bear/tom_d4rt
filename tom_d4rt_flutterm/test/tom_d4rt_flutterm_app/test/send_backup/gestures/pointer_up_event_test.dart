import 'package:flutter/material.dart';

/// Deep visual demo for PointerUpEvent.
/// Shows when pointer is released.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerUpEvent')),
    body: Center(child: _UpDemo()),
  );
}

class _UpDemo extends StatefulWidget {
  @override
  State<_UpDemo> createState() => _UpDemoState();
}

class _UpDemoState extends State<_UpDemo> {
  bool _isPressed = false;
  int _upCount = 0;
  String _lastUpPos = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Press and release on the button', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        Listener(
          onPointerDown: (_) => setState(() => _isPressed = true),
          onPointerUp: (e) => setState(() {
            _isPressed = false;
            _upCount++;
            _lastUpPos = '(\${e.localPosition.dx.toInt()}, \${e.localPosition.dy.toInt()})';
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 180,
            height: 80,
            decoration: BoxDecoration(
              color: _isPressed ? Colors.blue.shade700 : Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _isPressed ? [] : [
                BoxShadow(color: Colors.blue.withAlpha(100), blurRadius: 8, offset: const Offset(0, 4))
              ],
            ),
            transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
            alignment: Alignment.center,
            child: Text(
              _isPressed ? 'PRESSED' : 'PRESS ME',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Text('PointerUp events: \$_upCount', style: const TextStyle(fontSize: 14)),
              Text('Last release at: \$_lastUpPos', style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
