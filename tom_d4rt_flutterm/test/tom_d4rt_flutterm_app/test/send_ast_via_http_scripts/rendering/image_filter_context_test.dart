import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageFilter layer context
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageFilter Context')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Filter Layer Context', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Stack(children: [
      Positioned.fill(child: Container(color: Colors.blue.shade100, child: Center(child: Icon(Icons.image, size: 80, color: Colors.blue)))),
      Positioned(top: 40, left: 40, right: 40, bottom: 40, child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white)),
          child: Center(child: Text('Filtered Area', style: TextStyle(fontWeight: FontWeight.bold)))))),
    ])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Context provides:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• hints: LayerPaintingContext hints', style: TextStyle(fontSize: 11)),
        Text('• paintBounds: Clip rectangle', style: TextStyle(fontSize: 11)),
      ])),
  ])));
}
