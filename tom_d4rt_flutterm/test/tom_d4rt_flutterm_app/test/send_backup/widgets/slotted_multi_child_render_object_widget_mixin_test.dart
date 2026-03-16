import 'package:flutter/material.dart';

/// Deep visual demo for SlottedMultiChildRenderObjectWidgetMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Slotted Widget Mixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Slotted Multi-Child Widget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.dashboard, size: 48, color: Colors.brown),
        SizedBox(height: 12),
        Text('SlottedMultiChildRenderObject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text('WidgetMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(height: 8),
        Text('Widget with named slot children', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('childForSlot', 'Get widget for slot'),
        _Feature('slots', 'Iterable of slot IDs'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Pairs with SlottedContainerRenderObjectMixin', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.widgets, size: 14, color: Colors.brown), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
