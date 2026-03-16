import 'package:flutter/material.dart';

/// Deep visual demo for FlowParentData
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FlowParentData')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Flow Child Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _FlowChild(0, Offset(0, 0)),
          _FlowChild(1, Offset(30, 20)),
          _FlowChild(2, Offset(60, 40)),
        ]),
        SizedBox(height: 12),
        Text('Children store their own transform', style: TextStyle(fontSize: 12)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('FlowParentData contains:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• offset: Offset (from BoxParentData)', style: TextStyle(fontSize: 11)),
        Text('• Used by Flow widget for positioning', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
  ])));
}

class _FlowChild extends StatelessWidget {
  final int index; final Offset offset;
  const _FlowChild(this.index, this.offset);
  @override Widget build(BuildContext context) => Transform.translate(offset: offset,
    child: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.orange.shade300, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('$index', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))));
}
