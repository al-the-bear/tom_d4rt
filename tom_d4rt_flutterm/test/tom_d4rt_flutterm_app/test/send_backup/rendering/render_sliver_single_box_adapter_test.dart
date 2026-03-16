import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverSingleBoxAdapter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Single Box Adaptor')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Single Box to Sliver', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.pink.shade100, borderRadius: BorderRadius.circular(12)),
        child: Column(children: [Icon(Icons.widgets, size: 48, color: Colors.pink), SizedBox(height: 8), Text('SliverToBoxAdapter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('Wraps a single box widget', style: TextStyle(fontSize: 12))]))),
      SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Text('More items ${i + 1}')), childCount: 10)),
    ])),
  ])));
}
