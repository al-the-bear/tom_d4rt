import 'package:flutter/material.dart';

/// Deep visual demo for ResizeImageKey
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ResizeImageKey Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.photo_size_select_small, size: 48, color: Colors.indigo), SizedBox(height: 16), Text('ResizeImageKey', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Cache key for ResizeImage'), Text('width: int?'), Text('height: int?'), Text('policy: ResizeImagePolicy')]))])));
}
