import 'package:flutter/material.dart';

/// Deep visual demo for floating header snap behavior
dynamic build(BuildContext context) {
  return Scaffold(body: CustomScrollView(slivers: [
    SliverAppBar(title: Text('Snap Config'), floating: true, snap: true, expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(background: Container(color: Colors.blue.shade100, child: Center(child: Text('Pull to expand', style: TextStyle(color: Colors.blue)))))),
    SliverToBoxAdapter(child: Container(padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('FloatingHeaderSnapConfiguration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• curve: Animation curve', style: TextStyle(fontSize: 11)),
            Text('• duration: Snap duration', style: TextStyle(fontSize: 11)),
          ])),
      ]))),
    SliverList(delegate: SliverChildBuilderDelegate((ctx, i) => ListTile(title: Text('Item $i')), childCount: 30)),
  ]));
}
