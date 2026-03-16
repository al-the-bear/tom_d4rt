import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverConstrainedCrossAxis
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Constrained Cross')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Cross Axis Constraint', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverConstrainedCrossAxis(maxExtent: 300,
        sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.teal.shade100, borderRadius: BorderRadius.circular(8)),
          child: Text('Constrained to 300px width', textAlign: TextAlign.center)), childCount: 8))),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Limits sliver cross-axis extent on wide screens', style: TextStyle(fontSize: 11))),
  ])));
}
