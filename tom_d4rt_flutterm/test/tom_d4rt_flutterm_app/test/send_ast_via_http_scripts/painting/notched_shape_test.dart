import 'package:flutter/material.dart';

/// Deep visual demo for NotchedShape
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('NotchedShape Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.content_cut, size: 48, color: Colors.teal), SizedBox(height: 16), Text('NotchedShape', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Interface for shapes with notch'), Text('getOuterPath(Rect, Rect?)'), Text('Used by BottomAppBar')]))])));
}
