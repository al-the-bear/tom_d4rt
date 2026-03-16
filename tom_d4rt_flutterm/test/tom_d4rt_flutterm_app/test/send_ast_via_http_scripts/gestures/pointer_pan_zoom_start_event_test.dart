import 'package:flutter/material.dart';

/// Deep visual demo for PointerPanZoomStartEvent.
/// Shows when trackpad pan/zoom gesture starts.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerPanZoomStartEvent')),
    body: Center(child: _PanZoomStartDemo()),
  );
}

class _PanZoomStartDemo extends StatefulWidget {
  @override
  State<_PanZoomStartDemo> createState() => _PanZoomStartDemoState();
}

class _PanZoomStartDemoState extends State<_PanZoomStartDemo> {
  int _startCount = 0;
  bool _isActive = false;
  String _startPosition = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Begin a trackpad gesture here', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerPanZoomStart: (e) => setState(() {
            _isActive = true;
            _startCount++;
            _startPosition = '(\${e.position.dx.toInt()}, \${e.position.dy.toInt()})';
          }),
          onPointerPanZoomEnd: (_) => setState(() => _isActive = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: _isActive ? Colors.blue.shade200 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _isActive ? [BoxShadow(color: Colors.blue.withAlpha(100), blurRadius: 15)] : [],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_isActive ? Icons.touch_app : Icons.touch_app_outlined, 
                  size: 48, color: _isActive ? Colors.white : Colors.grey),
                const SizedBox(height: 8),
                Text(_isActive ? 'GESTURE STARTED' : 'Waiting...',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _isActive ? Colors.white : Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Start events: \$_startCount', style: const TextStyle(fontSize: 14)),
        Text('Last start position: \$_startPosition'),
      ],
    );
  }
}
