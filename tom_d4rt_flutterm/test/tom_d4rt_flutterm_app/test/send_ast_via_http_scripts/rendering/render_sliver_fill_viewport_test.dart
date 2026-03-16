import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverFillViewport
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fill Viewport')), body: CustomScrollView(slivers: [
    SliverFillViewport(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(16), decoration: BoxDecoration(color: [Colors.red, Colors.green, Colors.blue, Colors.orange][i % 4].shade100, borderRadius: BorderRadius.circular(16)),
      child: Center(child: Text('Page ${i + 1}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)))), childCount: 4)),
  ]));
}
