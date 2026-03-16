import 'package:flutter/material.dart';

/// Deep visual demo for sliver fill remaining with overscroll
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Fill + Overscroll')), body: CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Container(height: 200, margin: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('Header Content')))),
    SliverFillRemaining(hasScrollBody: false, fillOverscroll: true,
      child: Container(margin: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.expand, size: 48, color: Colors.green),
          Text('Fills remaining + overscroll', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Pull down to see expand', style: TextStyle(fontSize: 11)),
        ])))),
  ]));
}
