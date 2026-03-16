import 'package:flutter/material.dart';

/// Deep visual demo for TextPainting
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextPainting Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.text_fields, size: 48, color: Colors.blue), SizedBox(height: 16), Text('TextPainter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Layout and paint text'), Text('text: InlineSpan'), Text('textDirection: TextDirection'), Text('layout() then paint()')]))])));
}
