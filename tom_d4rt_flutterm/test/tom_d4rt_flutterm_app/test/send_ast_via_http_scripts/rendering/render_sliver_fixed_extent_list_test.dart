import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFixedExtentList
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fixed Extent List')), body: Column(children: [
    Container(padding: EdgeInsets.all(8), color: Colors.deepPurple.shade50, child: Text('SliverFixedExtentList = performance optimized', style: TextStyle(fontWeight: FontWeight.bold))),
    Expanded(child: CustomScrollView(slivers: [
      SliverFixedExtentList(itemExtent: 50, delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1), decoration: BoxDecoration(color: Colors.deepPurple.shade100, borderRadius: BorderRadius.circular(4)),
        child: Row(children: [SizedBox(width: 8), CircleAvatar(radius: 16, backgroundColor: Colors.deepPurple, child: Text('${i + 1}', style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 8), Text('Item ${i + 1}')])), childCount: 50)),
    ])),
  ]));
}
