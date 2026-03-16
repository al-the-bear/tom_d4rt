import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for SystemContextMenuClient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SystemContextMenuClient')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('System Context Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.menu, size: 48, color: Colors.deepPurple),
        SizedBox(height: 12),
        Text('SystemContextMenuController', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _Feature('show()', 'Display system context menu'),
        _Feature('hide()', 'Hide system context menu'),
        _Feature('targetAnchor', 'Menu anchor position'),
        SizedBox(height: 12),
        Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(children: [
            Text('Common Menu Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            SizedBox(height: 4),
            Wrap(spacing: 4, runSpacing: 4, children: [
              _MenuChip('Copy'), _MenuChip('Cut'), _MenuChip('Paste'), _MenuChip('Select All'),
            ]),
          ])),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Native system context menu integration', style: TextStyle(fontSize: 10))),
  ])));
}

class _Feature extends StatelessWidget {
  final String name; final String desc;
  const _Feature(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey))]));
}

class _MenuChip extends StatelessWidget {
  final String label;
  const _MenuChip(this.label);
  @override Widget build(BuildContext context) => Chip(label: Text(label, style: TextStyle(fontSize: 9)), backgroundColor: Colors.deepPurple.shade100, visualDensity: VisualDensity.compact);
}
