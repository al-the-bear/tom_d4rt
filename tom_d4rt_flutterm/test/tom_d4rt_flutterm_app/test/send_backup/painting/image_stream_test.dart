import 'package:flutter/material.dart';

/// Deep visual demo for ImageStream
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageStream Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image_search, size: 48, color: Colors.cyan), SizedBox(height: 16), Text('ImageStream', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Handle to an image resource'), Text('Supports multiple listeners'), Text('Async image loading')]))])));
}
