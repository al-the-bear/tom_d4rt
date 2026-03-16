import 'package:flutter/material.dart';

/// Deep visual demo for InlineSpanSemanticsInformation
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('InlineSpanSemanticsInformation Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.accessibility, size: 48, color: Colors.purple), SizedBox(height: 16), Text('InlineSpanSemanticsInformation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Semantics for text spans'), Text('text: String'), Text('isPlaceholder: bool'), Text('semanticsLabel: String?')]))])));
}
