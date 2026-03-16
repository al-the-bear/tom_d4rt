import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverIgnorePointer
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Ignore Pointer')), body: Column(children: [
    Container(padding: EdgeInsets.all(12), color: Colors.orange.shade50, child: Text('SliverIgnorePointer: Blocks pointer events', style: TextStyle(fontWeight: FontWeight.bold))),
    Expanded(child: CustomScrollView(slivers: [
      SliverIgnorePointer(ignoring: true,
        sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
          child: Text('Ignored item ${i + 1}')), childCount: 5))),
      SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
        child: Text('Active item ${i + 1}')), childCount: 5)),
    ])),
  ]));
}
