import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverCrossAxisGroup
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CrossAxis Group')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Cross Axis Grouping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverCrossAxisGroup(slivers: [
        SliverConstrainedCrossAxis(maxExtent: 150, sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(2), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)),
          child: Text('A$i', textAlign: TextAlign.center)), childCount: 10))),
        SliverConstrainedCrossAxis(maxExtent: 150, sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(2), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
          child: Text('B$i', textAlign: TextAlign.center)), childCount: 10))),
      ]),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Places multiple slivers side-by-side', style: TextStyle(fontSize: 11))),
  ])));
}
