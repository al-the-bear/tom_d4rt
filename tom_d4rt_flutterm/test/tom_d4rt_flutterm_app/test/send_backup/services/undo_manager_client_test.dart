import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for UndoManagerClient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('UndoManagerClient')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Undo/Redo Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.lime.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.undo, size: 40, color: Colors.lime.shade700),
          SizedBox(width: 16),
          Icon(Icons.redo, size: 40, color: Colors.lime.shade700),
        ]),
        SizedBox(height: 12),
        Text('UndoManagerClient Interface', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _Method('undo()', 'Revert last action'),
        _Method('redo()', 'Reapply undone action'),
        _Method('canUndo', 'Check if undo available'),
        _Method('canRedo', 'Check if redo available'),
        _Method('handlePlatformUndo', 'Handle system undo request'),
      ]))),
    SizedBox(height: 8),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Platform undo/redo integration for text editing', style: TextStyle(fontSize: 10))),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 11, color: Colors.lime.shade800)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}
