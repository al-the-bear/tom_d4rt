import 'package:flutter/material.dart';

/// Deep visual demo for persistent header show on screen config
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverPersistentHeader(pinned: true, delegate: _HeaderDelegate()),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => 
      Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: Text('Item $i')), childCount: 30)),
  ]));
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override double get minExtent => 60;
  @override double get maxExtent => 120;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);
    return Container(color: Color.lerp(Colors.blue.shade100, Colors.blue, progress),
      child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Persistent Header', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 - progress * 4)),
        if (progress < 0.5) Text('showOnScreenConfiguration controls reveal', style: TextStyle(fontSize: 11)),
      ])));
  }
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
