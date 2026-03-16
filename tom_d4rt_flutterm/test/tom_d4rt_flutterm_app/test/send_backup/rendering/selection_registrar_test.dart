import 'package:flutter/material.dart';

/// Deep visual demo for SelectionRegistrar
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Selection Registrar')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Selection Registration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _Step('1', 'SelectionContainer creates registrar'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _Step('2', 'Selectables register themselves'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _Step('3', 'Registrar manages selection state'),
        Icon(Icons.arrow_downward, color: Colors.indigo),
        _Step('4', 'Selection events dispatched'),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Coordinates text selection across multiple widgets', style: TextStyle(fontSize: 11))),
  ])));
}

class _Step extends StatelessWidget {
  final String num; final String text;
  const _Step(this.num, this.text);
  @override Widget build(BuildContext context) => Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(children: [CircleAvatar(radius: 12, backgroundColor: Colors.indigo, child: Text(num, style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 8), Text(text, style: TextStyle(fontWeight: FontWeight.bold))]));
}
