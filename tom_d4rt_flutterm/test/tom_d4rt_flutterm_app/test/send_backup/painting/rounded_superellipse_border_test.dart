import 'package:flutter/material.dart';

/// Deep visual demo for SuperellipseBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Superellipse Border Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 150, height: 100, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)), child: Center(child: Text('Rounded', style: TextStyle(color: Colors.white)))), SizedBox(height: 20), Container(width: 150, height: 100, decoration: ShapeDecoration(color: Colors.purple, shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40))), child: Center(child: Text('Continuous', style: TextStyle(color: Colors.white)))), SizedBox(height: 20), Text('ContinuousRectangleBorder for superellipse', style: TextStyle(color: Colors.grey, fontSize: 12))])));
}
