import 'package:flutter/material.dart';

/// Deep visual demo for TreeSliverIndentationType
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Indent Type')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('TreeSliverIndentationType', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _TypeCard('standard', 'Fixed indent per level', [0, 24, 48, 72], Colors.blue),
    _TypeCard('custom', 'Custom indent callback', [0, 16, 48, 64], Colors.green),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls tree node indentation style', style: TextStyle(fontSize: 11))),
  ])));
}

class _TypeCard extends StatelessWidget {
  final String name; final String desc; final List<int> indents; final MaterialColor color;
  const _TypeCard(this.name, this.desc, this.indents, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 14)),
      Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey)),
      SizedBox(height: 8),
      for (var i = 0; i < 4; i++)
        Container(margin: EdgeInsets.only(left: indents[i].toDouble(), bottom: 2), padding: EdgeInsets.all(4), decoration: BoxDecoration(color: color.shade100, borderRadius: BorderRadius.circular(2)),
          child: Text('Level $i', style: TextStyle(fontSize: 10))),
    ]));
}
