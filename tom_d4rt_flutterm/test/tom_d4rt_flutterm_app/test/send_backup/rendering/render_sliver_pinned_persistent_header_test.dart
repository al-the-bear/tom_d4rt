import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverPinnedPersistentHeader
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverPersistentHeader(delegate: _PinnedDelegate('Pinned Header', Colors.red), pinned: true),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('Item ${i + 1}')), childCount: 30)),
  ]));
}

class _PinnedDelegate extends SliverPersistentHeaderDelegate {
  final String title; final MaterialColor color;
  _PinnedDelegate(this.title, this.color);
  @override double get minExtent => 60;
  @override double get maxExtent => 150;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double progress = shrinkOffset / (maxExtent - minExtent);
    return Container(decoration: BoxDecoration(color: color, boxShadow: [if (progress > 0) BoxShadow(color: Colors.black26, blurRadius: 4)]),
      child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20 - 4 * progress))));
  }
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
