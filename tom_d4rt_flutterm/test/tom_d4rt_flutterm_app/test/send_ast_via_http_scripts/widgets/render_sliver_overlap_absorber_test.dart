import 'package:flutter/material.dart';

/// Deep visual demo for RenderSliverOverlapAbsorber
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SliverOverlapAbsorber')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Overlap Absorber', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.layers, size: 48, color: Colors.orange),
        SizedBox(height: 12),
        Text('RenderSliverOverlapAbsorber', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        Text('Absorbs overlap from preceding slivers', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Property('handle', 'SliverOverlapAbsorberHandle'),
        _Property('layoutExtentOffsetCompensation', 'double'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used with NestedScrollView for coordinated scrolling', style: TextStyle(fontSize: 10))),
  ])));
}
class _Property extends StatelessWidget {
  final String name; final String type;
  const _Property(this.name, this.type);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(type, style: TextStyle(fontSize: 9, color: Colors.orange))]));
}
