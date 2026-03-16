import 'package:flutter/material.dart';

/// Deep visual demo for NetworkImageLoadException
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('NetworkImageLoadException Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.error_outline, size: 48, color: Colors.red), SizedBox(height: 16), Text('NetworkImageLoadException', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Thrown when network image fails'), Text('statusCode: int'), Text('uri: Uri')]))])));
}
