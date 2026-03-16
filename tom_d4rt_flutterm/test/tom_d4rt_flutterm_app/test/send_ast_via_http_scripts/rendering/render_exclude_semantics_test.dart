import 'package:flutter/material.dart';

/// Deep visual demo for RenderExcludeSemantics
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Exclude Semantics')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Semantics Exclusion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Row(children: [
      Expanded(child: _SemanticBox('Included', true, Colors.green)),
      SizedBox(width: 8),
      Expanded(child: ExcludeSemantics(child: _SemanticBox('Excluded', false, Colors.orange))),
    ]),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Use cases:', style: TextStyle(fontWeight: FontWeight.bold)),
        _UseCase('Decorative images'),
        _UseCase('Duplicate content'),
        _UseCase('Off-screen elements'),
        _UseCase('Loading placeholders'),
      ])),
  ])));
}

class _SemanticBox extends StatelessWidget {
  final String label; final bool included; final MaterialColor color;
  const _SemanticBox(this.label, this.included, this.color);
  @override Widget build(BuildContext context) => Container(height: 150, decoration: BoxDecoration(color: color.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
    child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(included ? Icons.accessibility : Icons.accessibility_new, color: color, size: 40), Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)), Text(included ? 'Screen reader sees this' : 'Hidden from screen reader', style: TextStyle(fontSize: 10, color: Colors.grey))])));
}

class _UseCase extends StatelessWidget {
  final String text;
  const _UseCase(this.text);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 2), child: Row(children: [Icon(Icons.check_circle, size: 14, color: Colors.grey), SizedBox(width: 8), Text(text, style: TextStyle(fontSize: 11))]));
}
