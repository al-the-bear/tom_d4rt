import 'package:flutter/material.dart';

/// Deep visual demo for OneFrameImageStreamCompleter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('OneFrameImageStreamCompleter Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 48, color: Colors.blue), SizedBox(height: 16), Text('OneFrameImageStreamCompleter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('For static images'), Text('PNG, JPEG, etc.'), Text('Single frame only')]))])));
}
