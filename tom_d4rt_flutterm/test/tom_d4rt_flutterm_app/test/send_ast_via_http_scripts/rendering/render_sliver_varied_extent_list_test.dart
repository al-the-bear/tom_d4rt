import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverVariedExtentList
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Varied Extent')), body: Column(children: [
    Container(padding: EdgeInsets.all(8), color: Colors.lime.shade50, child: Text('Items with different heights', style: TextStyle(fontWeight: FontWeight.bold))),
    Expanded(child: CustomScrollView(slivers: [
      SliverVariedExtentList(itemExtentBuilder: (i, _) => 50.0 + (i % 4) * 25, delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.lime.shade100, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text('Item ${i + 1} (height: ${50 + (i % 4) * 25})'))), childCount: 30)),
    ])),
  ]));
}
