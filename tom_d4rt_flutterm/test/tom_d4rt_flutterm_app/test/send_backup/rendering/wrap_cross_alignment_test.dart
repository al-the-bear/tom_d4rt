import 'package:flutter/material.dart';

/// Deep visual demo for WrapCrossAlignment enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Cross Alignment')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('WrapCrossAlignment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _CrossDemo('start', WrapCrossAlignment.start, Colors.blue),
    _CrossDemo('end', WrapCrossAlignment.end, Colors.green),
    _CrossDemo('center', WrapCrossAlignment.center, Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Aligns children within their run (row/column)', style: TextStyle(fontSize: 11))),
  ])));
}

class _CrossDemo extends StatelessWidget {
  final String name; final WrapCrossAlignment align; final MaterialColor color;
  const _CrossDemo(this.name, this.align, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      SizedBox(width: 60, child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11))),
      Expanded(child: Container(height: 50, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: color), borderRadius: BorderRadius.circular(4)),
        child: Wrap(crossAxisAlignment: align, children: [
          Container(width: 30, height: 20, margin: EdgeInsets.all(2), color: color.shade200),
          Container(width: 30, height: 35, margin: EdgeInsets.all(2), color: color.shade200),
          Container(width: 30, height: 25, margin: EdgeInsets.all(2), color: color.shade200),
        ]))),
    ]));
}
