import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFixedExtentBoxAdaptor
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fixed Extent')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Fixed Extent List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverFixedExtentList(itemExtent: 60, delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.pink.shade100, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text('Fixed 60px item ${i + 1}'))), childCount: 20)),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('itemExtent enables O(1) scroll position calculation', style: TextStyle(fontSize: 11))),
  ])));
}
