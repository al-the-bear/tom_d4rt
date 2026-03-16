import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverEdgeInsetsPadding
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Padding')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Edge Insets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverPadding(padding: EdgeInsets.all(16),
        sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber)),
          child: Text('Padded sliver item ${i + 1}')), childCount: 8))),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Adds padding around sliver extent', style: TextStyle(fontSize: 11))),
  ])));
}
