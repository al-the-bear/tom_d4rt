import 'package:flutter/material.dart';

/// Deep visual demo for TransformProperty
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TransformProperty Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.transform, size: 48, color: Colors.purple), SizedBox(height: 16), Text('TransformProperty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Debug property for Matrix4'), Text('Used in diagnostics'), Text('Formats matrix for display')]))])));
}
