import 'package:flutter/material.dart';

/// Deep visual demo for TextStyle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextStyle Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('fontSize: 24', style: TextStyle(fontSize: 24)), Text('fontWeight: bold', style: TextStyle(fontWeight: FontWeight.bold)), Text('fontStyle: italic', style: TextStyle(fontStyle: FontStyle.italic)), Text('color: blue', style: TextStyle(color: Colors.blue)), Text('decoration: underline', style: TextStyle(decoration: TextDecoration.underline)), Text('letterSpacing: 4', style: TextStyle(letterSpacing: 4)), Text('wordSpacing: 10', style: TextStyle(wordSpacing: 10)), Text('height: 2.0 (line height)', style: TextStyle(height: 2.0)), Text('shadows', style: TextStyle(shadows: [Shadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 3)]))])));
}
