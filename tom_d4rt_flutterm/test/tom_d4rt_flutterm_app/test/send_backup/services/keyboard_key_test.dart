import 'package:flutter/material.dart';

/// Deep visual demo for KeyboardKey types
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Keyboard Keys')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Keyboard Key Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    _KeyCard('LogicalKeyboardKey', 'Language-independent', Colors.blue, 'keyA, enter, shift'),
    _KeyCard('PhysicalKeyboardKey', 'Hardware position', Colors.green, 'keyA positions to the same'),
    SizedBox(height: 16),
    Text('Common Keys:', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Wrap(spacing: 8, runSpacing: 8, children: [
      _Key('A'), _Key('Enter'), _Key('Shift'),
      _Key('Ctrl'), _Key('Alt'), _Key('Space'),
      _Key('Tab'), _Key('Esc'), _Key('←'),
    ]),
  ])));
}

class _KeyCard extends StatelessWidget {
  final String name; final String desc; final MaterialColor color; final String example;
  const _KeyCard(this.name, this.desc, this.color, this.example);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 12)),
      Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey)),
      SizedBox(height: 4),
      Text(example, style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: color)),
    ]));
}

class _Key extends StatelessWidget {
  final String label;
  const _Key(this.label);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade400)),
    child: Text(label, style: TextStyle(fontFamily: 'monospace', fontSize: 11)));
}
