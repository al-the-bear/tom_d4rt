import 'package:flutter/material.dart';

/// Deep visual demo for SlottedContainerRenderObjectMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SlottedContainer')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Slotted Container Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.view_module, size: 48, color: Colors.deepOrange),
        SizedBox(height: 12),
        Text('SlottedContainerRenderObjectMixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(height: 8),
        Text('Named slots for child render objects', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('childForSlot', 'Get child by slot'),
        _Feature('slots', 'Available slot IDs'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used for widgets with predefined child slots', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.extension, size: 14, color: Colors.deepOrange), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
