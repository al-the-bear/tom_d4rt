import 'package:flutter/material.dart';

/// Deep visual demo for Viewport rendering
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Viewport')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('RenderViewport', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(12)),
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Container(height: 80, margin: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)), child: Center(child: Text('Header')))),
        SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
          child: Text('Item ${i + 1}')), childCount: 20)),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Scrollable region containing slivers', style: TextStyle(fontSize: 11))),
  ])));
}
