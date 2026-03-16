import 'package:flutter/material.dart';

/// Deep visual demo for sliver render objects
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Sliver RenderObjects')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Sliver Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: _SliverCard('SliverList', 'Lazy list items', Colors.blue)),
      SliverToBoxAdapter(child: _SliverCard('SliverGrid', 'Lazy grid items', Colors.green)),
      SliverToBoxAdapter(child: _SliverCard('SliverAppBar', 'Collapsing header', Colors.orange)),
      SliverToBoxAdapter(child: _SliverCard('SliverPersistentHeader', 'Sticky header', Colors.purple)),
      SliverToBoxAdapter(child: _SliverCard('SliverFillRemaining', 'Fill remaining space', Colors.red)),
      SliverToBoxAdapter(child: _SliverCard('SliverPadding', 'Sliver with padding', Colors.teal)),
    ])),
  ])));
}

class _SliverCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _SliverCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.view_day, color: color), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 11)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
