import 'package:flutter/material.dart';

/// Deep visual demo for TextMagnifier
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextMagnifier Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [Text('Text Magnifier', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), SizedBox(height: 20), Text('Long press and drag on the TextField below to see the magnifier in action.', style: TextStyle(color: Colors.grey)), SizedBox(height: 20), TextField(decoration: InputDecoration(labelText: 'Long press to magnify', hintText: 'Select text to see magnifier', border: OutlineInputBorder()), maxLines: 3, controller: TextEditingController(text: 'This is sample text. Try selecting it to see the text magnifier appear above your selection.')), SizedBox(height: 20), Text('The magnifier helps with precise text selection', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic))])));
}
