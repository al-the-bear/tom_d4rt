import 'package:flutter/material.dart';

/// Deep visual demo for OutlinedBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('OutlinedBorder Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 150, height: 60, decoration: ShapeDecoration(shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.blue), borderRadius: BorderRadius.circular(12))), child: Center(child: Text('RoundedRectangle'))), SizedBox(height: 16), Container(width: 150, height: 60, decoration: ShapeDecoration(shape: StadiumBorder(side: BorderSide(width: 2, color: Colors.green))), child: Center(child: Text('Stadium'))), SizedBox(height: 16), Container(width: 80, height: 80, decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(width: 2, color: Colors.orange))), child: Center(child: Text('Circle')))])));
}
