import 'package:flutter/material.dart';

/// Deep visual demo for FittedSizes
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('FittedSizes Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('applyBoxFit results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(width: 200, height: 150, decoration: BoxDecoration(border: Border.all(color: Colors.grey)), child: Stack(children: [Positioned.fill(child: Container(color: Colors.blue.withOpacity(0.2))), Center(child: Container(width: 100, height: 80, color: Colors.blue, child: Center(child: Text('Source', style: TextStyle(color: Colors.white)))))])), SizedBox(height: 16), Text('FittedSizes contains source and destination', style: TextStyle(color: Colors.grey, fontSize: 12))])));
}
