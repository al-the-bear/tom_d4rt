import 'package:flutter/material.dart';

/// Deep visual demo for Matrix4
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Matrix4 Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Transform(transform: Matrix4.identity()..scale(1.5), child: Container(width: 60, height: 60, color: Colors.blue, child: Center(child: Text('Scale', style: TextStyle(color: Colors.white, fontSize: 10))))), SizedBox(height: 30), Transform(transform: Matrix4.identity()..rotateZ(0.3), child: Container(width: 60, height: 60, color: Colors.green, child: Center(child: Text('Rotate', style: TextStyle(color: Colors.white, fontSize: 10))))), SizedBox(height: 30), Transform(transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(0.5), child: Container(width: 60, height: 60, color: Colors.orange, child: Center(child: Text('3D', style: TextStyle(color: Colors.white, fontSize: 10)))))])));
}
