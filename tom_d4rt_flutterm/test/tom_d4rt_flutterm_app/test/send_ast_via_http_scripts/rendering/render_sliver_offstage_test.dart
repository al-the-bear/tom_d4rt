import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverOffstage
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver Offstage')), body: _SliverOffstageDemo());
}

class _SliverOffstageDemo extends StatefulWidget {
  @override State<_SliverOffstageDemo> createState() => _SliverOffstageDemoState();
}

class _SliverOffstageDemoState extends State<_SliverOffstageDemo> {
  bool _offstage = false;
  @override Widget build(BuildContext context) => Column(children: [
    Padding(padding: EdgeInsets.all(8), child: ElevatedButton(onPressed: () => setState(() => _offstage = !_offstage), child: Text(_offstage ? 'Show Sliver' : 'Hide Sliver'))),
    Expanded(child: CustomScrollView(slivers: [
      SliverOffstage(offstage: _offstage,
        sliver: SliverToBoxAdapter(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(12)),
          child: Center(child: Text('Hidden Sliver', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))))),
      SliverList(delegate: SliverChildBuilderDelegate((_, i) => Container(margin: EdgeInsets.all(4), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
        child: Text('Item ${i + 1}')), childCount: 10)),
    ])),
  ]);
}
