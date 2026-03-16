import 'package:flutter/material.dart';

/// Deep visual demo for InlineSpan
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('InlineSpan Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [RichText(text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [TextSpan(text: 'This is '), TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: ' and '), TextSpan(text: 'colored', style: TextStyle(color: Colors.blue)), TextSpan(text: ' text.')])), SizedBox(height: 30), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('InlineSpan: TextSpan and WidgetSpan base', style: TextStyle(fontSize: 12)))])));
}
