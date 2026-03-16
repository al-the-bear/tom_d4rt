import 'package:flutter/material.dart';

/// Deep visual demo for TextFieldTheme
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextFieldTheme Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [TextField(decoration: InputDecoration(labelText: 'Default TextField', border: OutlineInputBorder())), SizedBox(height: 20), Theme(data: Theme.of(context).copyWith(inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.blue.shade50, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.blue, width: 2)))), child: TextField(decoration: InputDecoration(labelText: 'Themed TextField', prefixIcon: Icon(Icons.search)))), SizedBox(height: 20), Theme(data: Theme.of(context).copyWith(inputDecorationTheme: InputDecorationTheme(border: UnderlineInputBorder(), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)))), child: TextField(decoration: InputDecoration(labelText: 'Underline Theme')))])));
}
