import 'package:flutter/material.dart';

/// Deep visual demo for StarBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('StarBorder Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 100, height: 100, decoration: ShapeDecoration(color: Colors.amber, shape: StarBorder(points: 5, innerRadiusRatio: 0.4))), SizedBox(height: 20), Container(width: 100, height: 100, decoration: ShapeDecoration(color: Colors.blue, shape: StarBorder(points: 6, innerRadiusRatio: 0.5))), SizedBox(height: 20), Container(width: 100, height: 100, decoration: ShapeDecoration(color: Colors.purple, shape: StarBorder(points: 8, innerRadiusRatio: 0.6)))])));
}
