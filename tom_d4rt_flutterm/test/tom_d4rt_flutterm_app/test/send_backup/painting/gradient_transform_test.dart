import 'package:flutter/material.dart';

/// Deep visual demo for GradientTransform
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('GradientTransform Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 100, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.green], transform: GradientRotation(0.5)))), SizedBox(height: 20), Container(width: 200, height: 100, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange, Colors.red], transform: GradientRotation(1.0)))), SizedBox(height: 20), Text('GradientRotation transforms gradient angle', style: TextStyle(color: Colors.grey))])));
}
