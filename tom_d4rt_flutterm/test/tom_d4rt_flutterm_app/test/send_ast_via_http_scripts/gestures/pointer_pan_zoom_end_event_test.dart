import 'package:flutter/material.dart';

/// Deep visual demo for PointerPanZoomEndEvent.
/// Shows when trackpad pan/zoom gesture ends.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerPanZoomEndEvent')),
    body: Center(child: _PanZoomEndDemo()),
  );
}

class _PanZoomEndDemo extends StatefulWidget {
  @override
  State<_PanZoomEndDemo> createState() => _PanZoomEndDemoState();
}

class _PanZoomEndDemoState extends State<_PanZoomEndDemo> {
  int _endCount = 0;
  String _status = 'Idle';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Use trackpad gesture (2-finger pan/zoom)', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerPanZoomStart: (_) => setState(() => _status = 'Pan/Zoom Started'),
          onPointerPanZoomUpdate: (_) => setState(() => _status = 'Pan/Zoom Active'),
          onPointerPanZoomEnd: (_) => setState(() {
            _status = 'Pan/Zoom Ended';
            _endCount++;
          }),
          child: Container(
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: _status.contains('Active') ? Colors.orange.shade100 : 
                     _status.contains('Ended') ? Colors.green.shade100 : Colors.grey.shade100,
              border: Border.all(color: Colors.blueGrey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_status.contains('Active') ? Icons.pan_tool : Icons.pan_tool_outlined, size: 40),
                const SizedBox(height: 8),
                Text(_status, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('End events received: \$_endCount', style: const TextStyle(fontSize: 14)),
        const Text('(Trackpad gestures only - not touch)', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
