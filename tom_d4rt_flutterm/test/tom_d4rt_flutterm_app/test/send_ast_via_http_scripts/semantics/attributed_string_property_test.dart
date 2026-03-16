import 'package:flutter/material.dart';

/// Deep visual demo for AttributedStringProperty in semantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AttributedStringProperty')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Attributed String', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        RichText(text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [
          TextSpan(text: 'Hello '),
          TextSpan(text: 'World', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          TextSpan(text: '!'),
        ])),
        SizedBox(height: 12),
        Text('String with attributes at specific ranges', style: TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Common Attributes:', style: TextStyle(fontWeight: FontWeight.bold)),
        _AttrRow('SpellOut', 'Spell letter by letter'),
        _AttrRow('Locale', 'Language for TTS'),
        _AttrRow('Link', 'Clickable URL'),
      ])),
    Spacer(),
    Text('Used for accessibility label annotations', style: TextStyle(color: Colors.grey)),
  ])));
}

class _AttrRow extends StatelessWidget {
  final String name; final String desc;
  const _AttrRow(this.name, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))), SizedBox(width: 8), Text(desc, style: TextStyle(fontSize: 11))]));
}
