import 'package:flutter/material.dart';

/// Deep visual demo for Gradient
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Gradient Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 100, decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue, Colors.purple, Colors.pink], stops: [0.0, 0.5, 1.0]))), SizedBox(height: 20), Container(width: 150, height: 150, decoration: BoxDecoration(gradient: RadialGradient(center: Alignment.center, radius: 0.8, colors: [Colors.white, Colors.blue]), shape: BoxShape.circle))])));
}
