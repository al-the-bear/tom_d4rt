import 'package:flutter/material.dart';

/// Deep visual demo for PlaceholderDimensions
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('PlaceholderDimensions Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.crop_din, size: 48, color: Colors.brown), SizedBox(height: 16), Text('PlaceholderDimensions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Inline placeholder sizing'), Text('size: Size'), Text('alignment: PlaceholderAlignment'), Text('baselineOffset: double?')]))])));
}
