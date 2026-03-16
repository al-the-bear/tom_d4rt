import 'package:flutter/material.dart';

/// Deep visual demo for ImageSizeInfo
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageSizeInfo Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.photo_size_select_large, size: 48, color: Colors.teal), SizedBox(height: 16), Text('ImageSizeInfo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Debug info:', style: TextStyle(fontWeight: FontWeight.bold)), Text('source: String'), Text('displaySize: Size'), Text('imageSize: Size')]))])));
}
