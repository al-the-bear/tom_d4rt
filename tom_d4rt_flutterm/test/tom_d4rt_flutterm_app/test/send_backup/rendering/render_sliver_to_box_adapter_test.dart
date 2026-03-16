import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverToBoxAdapter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ToBoxAdapter')), body: CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Container(height: 150, margin: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text('Header via SliverToBoxAdapter', style: TextStyle(fontWeight: FontWeight.bold))))),
    SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Divider(thickness: 2))),
    SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Text('List item ${i + 1}')), childCount: 20)),
  ]));
}
