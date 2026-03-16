import 'package:flutter/material.dart';

/// Deep visual demo for keyboard utility functions
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Keyboard Utils')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Keyboard Utilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: ListView(children: [
      _UtilCard('isControlCharacter', 'Check for Ctrl/Cmd pressed'),
      _UtilCard('isModifierPressed', 'Check any modifier key'),
      _UtilCard('characterToKeyboardKey', 'Character to key mapping'),
      _UtilCard('debugKeyLabel', 'Human-readable key name'),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Helper functions for keyboard handling', style: TextStyle(fontSize: 11))),
  ])));
}

class _UtilCard extends StatelessWidget {
  final String name; final String desc;
  const _UtilCard(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.build, color: Colors.red, size: 20), SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]))]));
}
