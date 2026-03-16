import 'package:flutter/material.dart';

/// Deep visual demo for RenderMouseRegion
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MouseRegion')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Mouse Tracking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: _MouseDemo()),
  ])));
}

class _MouseDemo extends StatefulWidget {
  @override State<_MouseDemo> createState() => _MouseDemoState();
}

class _MouseDemoState extends State<_MouseDemo> {
  bool _hovering = false;
  @override Widget build(BuildContext context) => Column(children: [
    Expanded(child: MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(duration: Duration(milliseconds: 200), decoration: BoxDecoration(color: _hovering ? Colors.blue.shade100 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: _hovering ? Colors.blue : Colors.grey, width: 2)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(_hovering ? Icons.mouse : Icons.mouse_outlined, size: 64, color: _hovering ? Colors.blue : Colors.grey),
          SizedBox(height: 8),
          Text(_hovering ? 'Hovering!' : 'Hover me', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: _hovering ? Colors.blue : Colors.grey)),
        ]))))),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Tracks mouse enter/exit/hover events', style: TextStyle(fontSize: 11))),
  ]);
}
