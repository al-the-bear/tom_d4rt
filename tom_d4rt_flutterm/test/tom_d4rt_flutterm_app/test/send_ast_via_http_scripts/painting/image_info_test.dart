import 'package:flutter/material.dart';

/// Deep visual demo for ImageInfo
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageInfo Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.info, size: 48, color: Colors.purple), SizedBox(height: 16), Text('ImageInfo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Contains:', style: TextStyle(fontWeight: FontWeight.bold)), Text('image: ui.Image'), Text('scale: double'), Text('debugLabel: String?')]))])));
}
