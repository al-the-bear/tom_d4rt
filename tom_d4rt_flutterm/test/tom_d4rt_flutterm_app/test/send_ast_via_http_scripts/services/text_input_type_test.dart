import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Deep visual demo for TextInputType
dynamic build(BuildContext context) {
  final types = [
    (TextInputType.text, 'text', 'Standard text input', Colors.blue),
    (TextInputType.multiline, 'multiline', 'Multi-line text', Colors.green),
    (TextInputType.number, 'number', 'Numeric keypad', Colors.orange),
    (TextInputType.phone, 'phone', 'Phone dial pad', Colors.red),
    (TextInputType.emailAddress, 'emailAddress', 'Email keyboard', Colors.purple),
    (TextInputType.url, 'url', 'URL keyboard', Colors.teal),
    (TextInputType.visiblePassword, 'visiblePassword', 'Visible pw input', Colors.pink),
    (TextInputType.name, 'name', 'Name input', Colors.indigo),
    (TextInputType.streetAddress, 'streetAddress', 'Address input', Colors.brown),
  ];
  return Scaffold(appBar: AppBar(title: Text('TextInputType')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Keyboard Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 8),
    Expanded(child: ListView.builder(itemCount: types.length, itemBuilder: (_, i) {
      final (type, name, desc, color) = types[i];
      return Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: (color as MaterialColor).shade50, borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Container(width: 110, child: Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 10))),
          Expanded(child: Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey))),
          Text('signed: ${type.signed}', style: TextStyle(fontSize: 8, color: Colors.grey)),
        ]));
    })),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Control software keyboard appearance', style: TextStyle(fontSize: 10))),
  ])));
}
