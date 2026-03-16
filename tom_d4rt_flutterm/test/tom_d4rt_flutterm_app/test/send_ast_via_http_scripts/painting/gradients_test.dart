import 'package:flutter/material.dart';

/// Deep visual demo for Gradients
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Gradients Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [Container(width: double.infinity, height: 80, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.green]))), SizedBox(height: 8), Text('LinearGradient'), SizedBox(height: 16), Container(width: double.infinity, height: 80, decoration: BoxDecoration(gradient: RadialGradient(colors: [Colors.yellow, Colors.orange, Colors.red]))), SizedBox(height: 8), Text('RadialGradient'), SizedBox(height: 16), Container(width: double.infinity, height: 80, decoration: BoxDecoration(gradient: SweepGradient(colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red]))), SizedBox(height: 8), Text('SweepGradient')])));
}
