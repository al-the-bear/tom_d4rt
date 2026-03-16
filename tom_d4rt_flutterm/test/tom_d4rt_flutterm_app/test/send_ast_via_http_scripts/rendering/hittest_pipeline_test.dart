import 'package:flutter/material.dart';

/// Deep visual demo for hit test pipeline
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Hit Test Pipeline')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Hit Test Flow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Step(1, 'Pointer Down', 'Event received'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step(2, 'hitTest()', 'Walk render tree'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step(3, 'Build Path', 'Collect hit entries'),
        Icon(Icons.arrow_downward, color: Colors.purple),
        _Step(4, 'Dispatch', 'Send to targets'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Pipeline traverses from root to deepest hit render object, building a path of all boxes containing the point', style: TextStyle(fontSize: 11))),
  ])));
}

class _Step extends StatelessWidget {
  final int num; final String title; final String desc;
  const _Step(this.num, this.title, this.desc);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(8),
    child: Row(children: [CircleAvatar(radius: 14, backgroundColor: Colors.purple, child: Text('$num', style: TextStyle(color: Colors.white, fontSize: 12))), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 11))])]));
}
