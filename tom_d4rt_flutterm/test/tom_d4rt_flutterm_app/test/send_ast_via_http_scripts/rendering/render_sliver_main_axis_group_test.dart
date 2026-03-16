import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverMainAxisGroup
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MainAxis Group')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Main Axis Sliver Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverMainAxisGroup(slivers: [
        SliverToBoxAdapter(child: Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(8)), child: Text('Group Header', style: TextStyle(fontWeight: FontWeight.bold)))),
        SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(4)),
          child: Text('Group item ${i + 1}')), childCount: 5)),
      ]),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Groups slivers along main axis', style: TextStyle(fontSize: 11))),
  ])));
}
