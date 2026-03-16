import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverPersistentHeader
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverPersistentHeader(delegate: _HeaderDelegate('Persistent Header', Colors.indigo), pinned: false, floating: false),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Item ${i + 1}')), childCount: 30)),
  ]));
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title; final MaterialColor color;
  _HeaderDelegate(this.title, this.color);
  @override double get minExtent => 60;
  @override double get maxExtent => 120;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => Container(color: color, child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))));
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
