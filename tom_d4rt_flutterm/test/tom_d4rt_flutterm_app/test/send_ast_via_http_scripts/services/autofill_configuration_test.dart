import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for AutofillConfiguration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AutofillConfiguration')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Autofill Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: SingleChildScrollView(child: Column(children: [
      _ConfigSection('Basic Properties', [
        _Property('uniqueIdentifier', 'String', 'Unique ID for field'),
        _Property('autofillHints', 'List<String>', 'Hints like email, name'),
        _Property('hintText', 'String?', 'Placeholder text'),
      ]),
      SizedBox(height: 12),
      _ConfigSection('Common Hints', [
        _HintChip(AutofillHints.email, Colors.blue),
        _HintChip(AutofillHints.name, Colors.green),
        _HintChip(AutofillHints.password, Colors.red),
        _HintChip(AutofillHints.username, Colors.orange),
        _HintChip(AutofillHints.telephoneNumber, Colors.purple),
      ]),
    ]))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Enable system autofill for form fields', style: TextStyle(fontSize: 10))),
  ])));
}

class _ConfigSection extends StatelessWidget {
  final String title; final List<Widget> children;
  const _ConfigSection(this.title, this.children);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(height: 8), ...children]));
}

class _Property extends StatelessWidget {
  final String name; final String type; final String desc;
  const _Property(this.name, this.type, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(type, style: TextStyle(color: Colors.purple, fontSize: 9))]));
}

class _HintChip extends StatelessWidget {
  final String hint; final MaterialColor color;
  const _HintChip(this.hint, this.color);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Chip(label: Text(hint.split('.').last, style: TextStyle(fontSize: 10)), backgroundColor: color.shade100, visualDensity: VisualDensity.compact));
}
