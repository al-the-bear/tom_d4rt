import 'package:flutter/material.dart';

/// Deep visual demo for ShapeBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ShapeBorder Demo')), body: Center(child: Wrap(spacing: 16, runSpacing: 16, children: [Container(width: 80, height: 80, decoration: ShapeDecoration(color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))), Container(width: 80, height: 80, decoration: ShapeDecoration(color: Colors.green, shape: CircleBorder())), Container(width: 80, height: 80, decoration: ShapeDecoration(color: Colors.orange, shape: StadiumBorder())), Container(width: 80, height: 80, decoration: ShapeDecoration(color: Colors.purple, shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)))), Container(width: 80, height: 80, decoration: ShapeDecoration(color: Colors.red, shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))))])));
}
