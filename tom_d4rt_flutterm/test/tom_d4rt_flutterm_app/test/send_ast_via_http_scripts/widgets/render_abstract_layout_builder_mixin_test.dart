import 'package:flutter/material.dart';

/// Deep visual demo for RenderAbstractLayoutBuilderMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LayoutBuilder Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Abstract Layout Builder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.grid_on, size: 48, color: Colors.purple),
        SizedBox(height: 12),
        Text('RenderAbstractLayoutBuilder', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Mixin for layout builder render objects', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('rebuildIfNecessary', 'Rebuild when needed'),
        _Feature('updateCallback', 'Update builder callback'),
        _Feature('layoutChild', 'Layout the child widget'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by LayoutBuilder and SliverLayoutBuilder', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.settings, size: 14, color: Colors.purple), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
