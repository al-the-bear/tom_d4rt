import 'package:flutter/material.dart';

/// Deep visual demo for ImageStreamCompleterHandle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageStreamCompleterHandle Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.linked_camera, size: 48, color: Colors.deepOrange), SizedBox(height: 16), Text('ImageStreamCompleterHandle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Keeps completer alive'), Text('dispose() releases reference')]))])));
}
