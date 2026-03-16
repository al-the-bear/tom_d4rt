import 'package:flutter/material.dart';

/// Deep visual demo for ResizeImage
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ResizeImage Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.photo_size_select_large, size: 48, color: Colors.teal), SizedBox(height: 16), Text('ResizeImage', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Wraps ImageProvider to resize'), Text('width: int?, height: int?'), Text('Reduces memory usage')]))])));
}
