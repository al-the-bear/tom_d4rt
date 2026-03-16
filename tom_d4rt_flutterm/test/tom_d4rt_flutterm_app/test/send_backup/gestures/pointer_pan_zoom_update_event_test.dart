import 'package:flutter/material.dart';

/// Deep visual demo for PointerPanZoomUpdateEvent.
/// Shows real-time trackpad pan/zoom updates.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerPanZoomUpdateEvent')),
    body: Center(child: _PanZoomUpdateDemo()),
  );
}

class _PanZoomUpdateDemo extends StatefulWidget {
  @override
  State<_PanZoomUpdateDemo> createState() => _PanZoomUpdateDemoState();
}

class _PanZoomUpdateDemoState extends State<_PanZoomUpdateDemo> {
  Offset _pan = Offset.zero;
  double _scale = 1.0;
  int _updateCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Trackpad pan/zoom gesture updates', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerPanZoomStart: (_) => setState(() {
            _pan = Offset.zero;
            _scale = 1.0;
            _updateCount = 0;
          }),
          onPointerPanZoomUpdate: (e) => setState(() {
            _pan = e.pan;
            _scale = e.scale;
            _updateCount++;
          }),
          child: Container(
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Transform.translate(
              offset: _pan * 0.3,
              child: Transform.scale(
                scale: _scale.clamp(0.5, 2.0),
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.open_with, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Pan: (\${_pan.dx.toStringAsFixed(1)}, \${_pan.dy.toStringAsFixed(1)})'),
        Text('Scale: \${_scale.toStringAsFixed(2)}'),
        Text('Updates: \$_updateCount'),
      ],
    );
  }
}
