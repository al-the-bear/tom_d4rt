import 'package:flutter/material.dart';

/// Deep visual demo for AutofillClient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Autofill Client')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('AutofillClient', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(Icons.auto_awesome, size: 48, color: Colors.cyan),
        SizedBox(height: 12),
        _Method('textInputConfiguration', 'Get autofill config'),
        _Method('autofill', 'Apply autofill value'),
        _Method('autofillId', 'Unique identifier'),
      ])),
    SizedBox(height: 16),
    Text('Autofill Hints:', style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Wrap(spacing: 8, runSpacing: 8, children: [
      _Hint('email'), _Hint('password'), _Hint('username'),
      _Hint('name'), _Hint('phone'), _Hint('address'),
    ]),
  ])));
}

class _Method extends StatelessWidget {
  final String name; final String desc;
  const _Method(this.name, this.desc);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.only(bottom: 4), padding: EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
    child: Row(children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}

class _Hint extends StatelessWidget {
  final String text;
  const _Hint(this.text);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade100, borderRadius: BorderRadius.circular(12)),
    child: Text(text, style: TextStyle(fontSize: 10)));
}
