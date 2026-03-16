import 'package:flutter/material.dart';

/// Deep visual demo for Colors
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Colors Demo')), body: SingleChildScrollView(padding: EdgeInsets.all(8), child: Wrap(spacing: 8, runSpacing: 8, children: [for (final c in [Colors.red, Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo, Colors.blue, Colors.lightBlue, Colors.cyan, Colors.teal, Colors.green, Colors.lightGreen, Colors.lime, Colors.yellow, Colors.amber, Colors.orange, Colors.deepOrange, Colors.brown, Colors.grey, Colors.blueGrey]) Container(width: 50, height: 50, color: c)])));
}
