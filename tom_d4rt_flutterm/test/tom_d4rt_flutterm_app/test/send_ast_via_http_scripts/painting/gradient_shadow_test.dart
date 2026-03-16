import 'package:flutter/material.dart';

/// Deep visual demo for GradientShadow
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Gradient with Shadow Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 200, height: 120, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.purple]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 20, offset: Offset(0, 10))])), SizedBox(height: 30), Container(width: 150, height: 150, decoration: BoxDecoration(gradient: RadialGradient(colors: [Colors.orange, Colors.red]), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.4), blurRadius: 20, spreadRadius: 5)]))])));
}
