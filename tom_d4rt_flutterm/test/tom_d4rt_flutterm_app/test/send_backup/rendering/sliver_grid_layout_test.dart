import 'package:flutter/material.dart';

/// Deep visual demo for SliverGridLayout
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Grid Layout')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('SliverGridLayout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Text('Abstract interface for grid layouts', style: TextStyle(fontSize: 12, color: Colors.grey)),
    SizedBox(height: 16),
    _LayoutCard('SliverGridRegularTileLayout', 'Fixed size tiles', Colors.blue),
    _LayoutCard('SliverGridDelegateWithFixedCrossAxisCount', 'Fixed column count', Colors.green),
    _LayoutCard('SliverGridDelegateWithMaxCrossAxisExtent', 'Max tile width', Colors.orange),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Methods: getMinChildExtent, getMaxChildExtent, getGeometryForChildIndex', style: TextStyle(fontFamily: 'monospace', fontSize: 9))),
  ])));
}

class _LayoutCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color;
  const _LayoutCard(this.name, this.desc, this.color);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.grid_view, color: color), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
