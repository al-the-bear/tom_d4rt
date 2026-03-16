import 'package:flutter/material.dart';

/// Deep visual demo for sliver child delegates
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Delegates')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverChildDelegate Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _DelegateCard('SliverChildBuilderDelegate', 'Lazy builder callback', Colors.blue, 'childCount, builder'),
    _DelegateCard('SliverChildListDelegate', 'Explicit child list', Colors.green, 'children: [...]'),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Text('Usage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        SizedBox(height: 4),
        Text('SliverList(delegate: SliverChildBuilderDelegate((ctx, i) => ...))', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
      ])),
  ])));
}

class _DelegateCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final String params;
  const _DelegateCard(this.name, this.desc, this.color, this.params);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 12), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
      SizedBox(height: 4),
      Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey)),
      SizedBox(height: 8),
      Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Text(params, style: TextStyle(fontFamily: 'monospace', fontSize: 10))),
    ]));
}
