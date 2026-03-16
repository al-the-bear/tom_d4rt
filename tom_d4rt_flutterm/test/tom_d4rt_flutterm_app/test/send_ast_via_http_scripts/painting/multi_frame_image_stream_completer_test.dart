import 'package:flutter/material.dart';

/// Deep visual demo for MultiFrameImageStreamCompleter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MultiFrameImageStreamCompleter Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.gif_box, size: 48, color: Colors.pink), SizedBox(height: 16), Text('MultiFrameImageStreamCompleter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('For animated images'), Text('GIF, APNG, WebP'), Text('Handles frame timing')]))])));
}
