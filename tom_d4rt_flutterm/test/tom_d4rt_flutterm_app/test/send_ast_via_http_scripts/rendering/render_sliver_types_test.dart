import 'package:flutter/material.dart';

/// Deep visual demo for sliver render types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Types')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Render Classes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _TypeCard('RenderSliverList', 'Linear list', Colors.blue),
      _TypeCard('RenderSliverGrid', '2D grid', Colors.green),
      _TypeCard('RenderSliverBoxAdapter', 'Single box', Colors.orange),
      _TypeCard('RenderSliverPadding', 'Add padding', Colors.purple),
      _TypeCard('RenderSliverPersistentHeader', 'Sticky header', Colors.red),
      _TypeCard('RenderSliverFillViewport', 'Fullscreen pages', Colors.teal),
    ])),
  ])));
}

class _TypeCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _TypeCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.view_day, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
