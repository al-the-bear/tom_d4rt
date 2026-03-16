import 'package:flutter/material.dart';

/// Deep visual demo for TextSelection
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextSelection Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [TextField(decoration: InputDecoration(labelText: 'Select text here', border: OutlineInputBorder()), controller: TextEditingController(text: 'Select some of this text')), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('TextSelection properties:', style: TextStyle(fontWeight: FontWeight.bold)), Text('baseOffset: int'), Text('extentOffset: int'), Text('isCollapsed: bool')]))])));
}
