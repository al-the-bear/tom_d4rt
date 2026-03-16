import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for TextInputConfiguration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextInputConfiguration')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Input Configuration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: SingleChildScrollView(child: Column(children: [
      _Section('Input Types', [
        _TypeChip('text', Colors.blue), _TypeChip('multiline', Colors.green),
        _TypeChip('number', Colors.orange), _TypeChip('phone', Colors.red),
        _TypeChip('emailAddress', Colors.purple), _TypeChip('url', Colors.teal),
      ]),
      SizedBox(height: 12),
      _Section('Input Actions', [
        _TypeChip('done', Colors.blue), _TypeChip('go', Colors.green),
        _TypeChip('search', Colors.orange), _TypeChip('send', Colors.red),
        _TypeChip('next', Colors.purple), _TypeChip('newline', Colors.teal),
      ]),
      SizedBox(height: 12),
      _Section('Properties', [
        _Property('inputType', 'TextInputType'),
        _Property('inputAction', 'TextInputAction'),
        _Property('autocorrect', 'bool'),
        _Property('enableSuggestions', 'bool'),
        _Property('obscureText', 'bool'),
      ]),
    ]))),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Configure text input behavior and keyboard', style: TextStyle(fontSize: 10))),
  ])));
}

class _Section extends StatelessWidget {
  final String title; final List<Widget> children;
  const _Section(this.title, this.children);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(height: 8), Wrap(spacing: 4, runSpacing: 4, children: children)]));
}

class _TypeChip extends StatelessWidget {
  final String label; final MaterialColor color;
  const _TypeChip(this.label, this.color);
  @override Widget build(BuildContext context) => Chip(label: Text(label, style: TextStyle(fontSize: 9)), backgroundColor: color.shade100, visualDensity: VisualDensity.compact);
}

class _Property extends StatelessWidget {
  final String name; final String type;
  const _Property(this.name, this.type);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(bottom: 4),
    child: Row(children: [Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10)), Spacer(), Text(type, style: TextStyle(color: Colors.blueGrey, fontSize: 9))]));
}
