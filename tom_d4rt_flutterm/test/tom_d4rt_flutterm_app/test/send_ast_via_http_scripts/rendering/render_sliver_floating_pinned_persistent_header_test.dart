import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFloatingPinnedPersistentHeader
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverAppBar(floating: true, pinned: true, expandedHeight: 180, flexibleSpace: FlexibleSpaceBar(title: Text('Floating + Pinned'), background: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.indigo, Colors.indigo.shade300]))))),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Scroll item ${i + 1}')), childCount: 30)),
  ]));
}
