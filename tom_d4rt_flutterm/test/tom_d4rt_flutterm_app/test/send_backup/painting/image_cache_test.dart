import 'package:flutter/material.dart';

/// Deep visual demo for ImageCache
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageCache Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.storage, size: 48, color: Colors.green), SizedBox(height: 16), Text('ImageCache', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)), Text('putIfAbsent()'), Text('evict()'), Text('clear()'), Text('clearLiveImages()')]))])));
}
