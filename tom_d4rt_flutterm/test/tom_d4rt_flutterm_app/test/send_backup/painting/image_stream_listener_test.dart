import 'package:flutter/material.dart';

/// Deep visual demo for ImageStreamListener
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageStreamListener Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.hearing, size: 48, color: Colors.blue), SizedBox(height: 16), Text('ImageStreamListener', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Callbacks:', style: TextStyle(fontWeight: FontWeight.bold)), Text('onImage: ImageListener'), Text('onChunk: ImageChunkListener?'), Text('onError: ImageErrorListener?')]))])));
}
