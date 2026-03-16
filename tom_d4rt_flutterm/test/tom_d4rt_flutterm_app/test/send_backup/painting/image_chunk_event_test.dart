import 'package:flutter/material.dart';

/// Deep visual demo for ImageChunkEvent
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageChunkEvent Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.download, size: 48, color: Colors.orange), SizedBox(height: 16), Text('ImageChunkEvent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Progress tracking:', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 8), LinearProgressIndicator(value: 0.7), SizedBox(height: 8), Text('cumulativeBytesLoaded: 700KB'), Text('expectedTotalBytes: 1000KB')]))])));
}
