import 'package:flutter/material.dart';

/// Deep visual demo for RenderPointerListener
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Pointer Listener')), body: _PointerListenerDemo());
}

class _PointerListenerDemo extends StatefulWidget {
  @override State<_PointerListenerDemo> createState() => _PointerListenerDemoState();
}

class _PointerListenerDemoState extends State<_PointerListenerDemo> {
  String _event = 'Tap anywhere';
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Pointer Events', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Listener(
      onPointerDown: (e) => setState(() => _event = 'Down: ${e.position.dx.toInt()},${e.position.dy.toInt()}'),
      onPointerMove: (e) => setState(() => _event = 'Move: ${e.position.dx.toInt()},${e.position.dy.toInt()}'),
      onPointerUp: (e) => setState(() => _event = 'Up: ${e.position.dx.toInt()},${e.position.dy.toInt()}'),
      child: Container(decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.cyan)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.touch_app, size: 64, color: Colors.cyan), SizedBox(height: 16), Text(_event, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]))))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Raw pointer events before gesture recognition', style: TextStyle(fontSize: 11))),
  ]));
}
