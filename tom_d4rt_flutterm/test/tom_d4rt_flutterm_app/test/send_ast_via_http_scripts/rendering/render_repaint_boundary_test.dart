import 'package:flutter/material.dart';

/// Deep visual demo for RenderRepaintBoundary
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RepaintBoundary')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Repaint Isolation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: Column(children: [
        Text('Without', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        _RepaintDemo(false),
      ])),
      SizedBox(width: 8),
      Expanded(child: Column(children: [
        Text('With Boundary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        _RepaintDemo(true),
      ])),
    ]),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Benefits:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Isolates repaint regions', style: TextStyle(fontSize: 11)),
        Text('• Creates compositing layer', style: TextStyle(fontSize: 11)),
        Text('• Enables toImage() capture', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _RepaintDemo extends StatelessWidget {
  final bool hasBoundary;
  const _RepaintDemo(this.hasBoundary);
  @override Widget build(BuildContext context) {
    Widget child = Container(height: 150, decoration: BoxDecoration(color: hasBoundary ? Colors.green.shade100 : Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Icon(hasBoundary ? Icons.layers : Icons.layers_clear, size: 48, color: hasBoundary ? Colors.green : Colors.red)));
    return hasBoundary ? RepaintBoundary(child: child) : child;
  }
}
