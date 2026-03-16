import 'package:flutter/material.dart';

/// Deep visual demo for PlaceholderSpan
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PlaceholderSpan Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [RichText(text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [TextSpan(text: 'Text with '), WidgetSpan(child: Container(width: 24, height: 24, color: Colors.blue)), TextSpan(text: ' inline widget')])), SizedBox(height: 30), Text('WidgetSpan extends PlaceholderSpan', style: TextStyle(color: Colors.grey))])));
}
