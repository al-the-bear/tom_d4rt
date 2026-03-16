import 'package:flutter/material.dart';

/// Deep visual demo for PointerSignalEvent.
/// Shows the base class for scroll/scale signals.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerSignalEvent')),
    body: Center(child: _SignalDemo()),
  );
}

class _SignalDemo extends StatefulWidget {
  @override
  State<_SignalDemo> createState() => _SignalDemoState();
}

class _SignalDemoState extends State<_SignalDemo> {
  String _lastType = 'None';
  int _signalCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Scroll or pinch in the area below', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Listener(
          onPointerSignal: (e) => setState(() {
            _lastType = e.runtimeType.toString();
            _signalCount++;
          }),
          child: Container(
            width: 280, height: 180,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              border: Border.all(color: Colors.indigo, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sensors, size: 40, color: Colors.indigo),
                const SizedBox(height: 8),
                Text(_lastType, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Signals received: \$_signalCount'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: const Column(
            children: [
              Text('PointerSignalEvent subtypes:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• PointerScrollEvent', style: TextStyle(fontSize: 12)),
              Text('• PointerScaleEvent', style: TextStyle(fontSize: 12)),
              Text('• PointerScrollInertiaCancelEvent', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
