import 'package:flutter/material.dart';

/// Deep visual demo for DecorationImagePainter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('DecorationImagePainter Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 150, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 48, color: Colors.grey), Text('DecorationImage', style: TextStyle(color: Colors.grey))]))), SizedBox(height: 20), Text('Paints images in BoxDecoration', style: TextStyle(color: Colors.grey))])));
}
