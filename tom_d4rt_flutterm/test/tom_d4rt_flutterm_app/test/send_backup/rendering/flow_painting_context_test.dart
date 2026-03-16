import 'package:flutter/material.dart';

/// Deep visual demo for FlowPaintingContext
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlowPaintingContext')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flow Painting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(height: 150, decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: Flow(delegate: _DemoFlowDelegate(), children: [
        for (int i = 0; i < 5; i++) Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.primaries[i * 3], shape: BoxShape.circle))
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Context provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• size: Total layout size', style: TextStyle(fontSize: 11)),
        Text('• childCount: Number of children', style: TextStyle(fontSize: 11)),
        Text('• getChildSize(i): Child dimensions', style: TextStyle(fontSize: 11)),
        Text('• paintChild(i, transform): Draw child', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}

class _DemoFlowDelegate extends FlowDelegate {
  @override void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(i * 30.0, i * 20.0, 0));
    }
  }
  @override bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
