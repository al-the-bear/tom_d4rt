import 'package:flutter/material.dart';

/// Deep visual demo for RenderDecoratedSliver
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverAppBar(title: Text('Decorated Sliver'), pinned: true),
    DecoratedSliver(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.purple.shade200], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      sliver: SliverPadding(padding: EdgeInsets.all(16),
        sliver: SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withAlpha(200), borderRadius: BorderRadius.circular(8)),
          child: Text('Item $i', style: TextStyle(fontWeight: FontWeight.bold))), childCount: 15)))),
  ]));
}
