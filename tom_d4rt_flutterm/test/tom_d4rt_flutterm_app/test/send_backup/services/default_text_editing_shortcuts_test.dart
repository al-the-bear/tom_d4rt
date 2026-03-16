import 'package:flutter/material.dart';

/// Deep visual demo for DefaultTextEditingShortcuts
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Text Shortcuts')), body: Padding(padding: EdgeInsets.all(8), child: Column(children: [
    Text('DefaultTextEditingShortcuts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    SizedBox(height: 8),
    Expanded(child: ListView(children: [
      _Shortcut('Ctrl+A', 'Select all'),
      _Shortcut('Ctrl+C', 'Copy'),
      _Shortcut('Ctrl+V', 'Paste'),
      _Shortcut('Ctrl+X', 'Cut'),
      _Shortcut('Ctrl+Z', 'Undo'),
      _Shortcut('Ctrl+Y', 'Redo'),
      _Shortcut('Ctrl+→', 'Word right'),
      _Shortcut('Ctrl+←', 'Word left'),
      _Shortcut('Home', 'Line start'),
      _Shortcut('End', 'Line end'),
    ])),
    Container(padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Standard text editing keyboard shortcuts', style: TextStyle(fontSize: 10))),
  ])));
}

class _Shortcut extends StatelessWidget {
  final String keys; final String action;
  const _Shortcut(this.keys, this.action);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
    child: Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)),
      child: Text(keys, style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold))), Spacer(), Text(action, style: TextStyle(fontSize: 10))]));
}
