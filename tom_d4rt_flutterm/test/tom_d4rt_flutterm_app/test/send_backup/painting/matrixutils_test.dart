import 'package:flutter/material.dart';

/// Deep visual demo for MatrixUtilsAdv
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('MatrixUtils Advanced Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 100, height: 100, decoration: BoxDecoration(border: Border.all(color: Colors.grey)), child: Transform(transform: Matrix4.skewX(0.2), alignment: Alignment.center, child: Container(color: Colors.blue.withOpacity(0.7), child: Center(child: Text('Skew', style: TextStyle(color: Colors.white)))))), SizedBox(height: 20), Text('Matrix transformations applied to widgets', style: TextStyle(color: Colors.grey))])));
}
