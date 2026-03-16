import 'package:flutter/material.dart';

/// Deep visual demo for CrossAxisAlignment enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CrossAxisAlignment')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Cross Axis Alignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 12),
    Expanded(child: ListView(children: [
      _AlignDemo(CrossAxisAlignment.start, 'start'),
      _AlignDemo(CrossAxisAlignment.end, 'end'),
      _AlignDemo(CrossAxisAlignment.center, 'center'),
      _AlignDemo(CrossAxisAlignment.stretch, 'stretch'),
      _AlignDemo(CrossAxisAlignment.baseline, 'baseline'),
    ])),
  ])));
}

class _AlignDemo extends StatelessWidget {
  final CrossAxisAlignment align; final String name;
  const _AlignDemo(this.align, this.name);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 4),
      Container(height: 60, decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(crossAxisAlignment: align == CrossAxisAlignment.baseline ? CrossAxisAlignment.center : align,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(width: 40, height: 40, color: Colors.blue),
            SizedBox(width: 8),
            Container(width: 40, height: 25, color: Colors.orange),
            SizedBox(width: 8),
            Container(width: 40, height: 50, color: Colors.green),
          ])),
    ]));
}
