import 'package:flutter/material.dart';

/// Deep visual demo for ThemeExtension
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ThemeExtension Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(16)), child: Column(children: [Icon(Icons.extension, size: 48, color: Colors.purple), SizedBox(height: 16), Text('ThemeExtension', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple)), SizedBox(height: 8), Text('Add custom theme properties', style: TextStyle(color: Colors.purple.shade700))])), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('Theme.of(context).extension<MyColors>()', style: TextStyle(fontFamily: 'monospace', fontSize: 12)))])));
}
