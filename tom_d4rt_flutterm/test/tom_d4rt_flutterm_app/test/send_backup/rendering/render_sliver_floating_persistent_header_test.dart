import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFloatingPersistentHeader
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverAppBar(floating: true, expandedHeight: 150, flexibleSpace: FlexibleSpaceBar(title: Text('Floating Header'), background: Container(color: Colors.red.shade200))),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Item ${i + 1}')), childCount: 30)),
  ]));
}
