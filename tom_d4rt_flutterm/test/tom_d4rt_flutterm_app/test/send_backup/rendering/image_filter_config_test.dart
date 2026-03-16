import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageFilter configuration
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageFilter Config')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Image Filter Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, children: [
      _FilterCard('Blur', ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
      _FilterCard('Dilate', ImageFilter.dilate(radiusX: 2, radiusY: 2)),
      _FilterCard('Erode', ImageFilter.erode(radiusX: 2, radiusY: 2)),
      _FilterCard('Matrix', ImageFilter.matrix(Matrix4.rotationZ(0.1).storage)),
    ])),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('ImageFilter applies post-processing effects to rendered content', style: TextStyle(fontSize: 11))),
  ])));
}

class _FilterCard extends StatelessWidget {
  final String name; final ImageFilter filter;
  const _FilterCard(this.name, this.filter);
  @override Widget build(BuildContext context) => Column(children: [
    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8),
      child: ImageFiltered(imageFilter: filter, child: Container(color: Colors.blue, child: Center(child: Icon(Icons.star, color: Colors.yellow, size: 40)))))),
    SizedBox(height: 4),
    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
  ]);
}
