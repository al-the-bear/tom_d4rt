import 'package:flutter/material.dart';

/// Deep visual demo for RootElementMixin
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RootElementMixin')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Root Element Mixin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.account_tree, size: 48, color: Colors.green),
        SizedBox(height: 12),
        Text('RootElementMixin', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Mixin for root elements in widget tree', style: TextStyle(fontSize: 11, color: Colors.grey)),
        SizedBox(height: 16),
        _Feature('scheduleWarmUpFrame', 'Schedule initial frame'),
        _Feature('buildScope', 'Manage build scope'),
        _Feature('owner', 'BuildOwner reference'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Used by RenderObjectToWidgetElement', style: TextStyle(fontSize: 10))),
  ])));
}
class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Icon(Icons.code, size: 14, color: Colors.green), SizedBox(width: 8), Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}
