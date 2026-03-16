import 'package:flutter/material.dart';

/// Deep visual demo for WidgetStateInputBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('WidgetStateInputBorder Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [TextField(decoration: InputDecoration(labelText: 'Default State', border: OutlineInputBorder())), SizedBox(height: 20), TextField(decoration: InputDecoration(labelText: 'Focused State', focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)))), SizedBox(height: 20), TextField(decoration: InputDecoration(labelText: 'Error State', errorText: 'Required field', errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)), focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 3)))), SizedBox(height: 20), TextField(enabled: false, decoration: InputDecoration(labelText: 'Disabled State', disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))))])));
}
