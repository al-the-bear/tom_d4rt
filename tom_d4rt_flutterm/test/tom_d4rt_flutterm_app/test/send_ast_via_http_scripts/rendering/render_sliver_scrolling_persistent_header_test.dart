import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverScrollingPersistentHeader
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverPersistentHeader(delegate: _ScrollingDelegate('Scrolling Header', Colors.green), pinned: false, floating: false),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Scroll to see header disappear - Item ${i + 1}')), childCount: 30)),
  ]));
}

class _ScrollingDelegate extends SliverPersistentHeaderDelegate {
  final String title; final MaterialColor color;
  _ScrollingDelegate(this.title, this.color);
  @override double get minExtent => 60;
  @override double get maxExtent => 120;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => Container(color: color, child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))));
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
