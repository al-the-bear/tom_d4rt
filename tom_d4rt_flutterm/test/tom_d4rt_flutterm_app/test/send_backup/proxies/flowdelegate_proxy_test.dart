import 'package:flutter/material.dart';

/// Deep visual demo for FlowDelegate proxy pattern
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlowDelegate Proxy')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flow Layout Pattern', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 16),
    Container(height: 200, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: Flow(delegate: _StackDelegate(), children: [
        for (int i = 0; i < 5; i++) Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.primaries[i * 2], borderRadius: BorderRadius.circular(8)), child: Center(child: Text('${i + 1}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('FlowDelegate methods:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• getSize(constraints) → Size', style: TextStyle(fontSize: 11)),
        Text('• getConstraintsForChild(i, constraints)', style: TextStyle(fontSize: 11)),
        Text('• paintChildren(context) - transform & paint', style: TextStyle(fontSize: 11)),
        Text('• shouldRelayout(oldDelegate) → bool', style: TextStyle(fontSize: 11)),
        Text('• shouldRepaint(oldDelegate) → bool', style: TextStyle(fontSize: 11)),
      ]))
  ])));
}

class _StackDelegate extends FlowDelegate {
  @override void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(i * 25.0, i * 25.0, 0));
    }
  }
  @override bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
