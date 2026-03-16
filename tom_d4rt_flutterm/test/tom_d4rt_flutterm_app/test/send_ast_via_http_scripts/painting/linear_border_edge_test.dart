import 'package:flutter/material.dart';

/// Deep visual demo for LinearBorderEdge
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LinearBorderEdge Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 60, decoration: ShapeDecoration(color: Colors.blue.shade50, shape: LinearBorder(side: BorderSide(width: 2, color: Colors.blue), bottom: LinearBorderEdge(size: 1, alignment: 0)))), SizedBox(height: 20), Container(width: 200, height: 60, decoration: ShapeDecoration(color: Colors.green.shade50, shape: LinearBorder(side: BorderSide(width: 2, color: Colors.green), bottom: LinearBorderEdge(size: 0.5, alignment: -1)))), SizedBox(height: 20), Text('LinearBorderEdge controls edge segments', style: TextStyle(color: Colors.grey))])));
}
