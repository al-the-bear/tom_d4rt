import 'package:flutter/material.dart';

/// Deep visual demo for Shapes
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Shapes Demo')), body: ListView(padding: EdgeInsets.all(16), children: [ListTile(leading: Container(width: 40, height: 40, decoration: ShapeDecoration(color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))), title: Text('RoundedRectangleBorder')), ListTile(leading: Container(width: 40, height: 40, decoration: ShapeDecoration(color: Colors.green, shape: CircleBorder())), title: Text('CircleBorder')), ListTile(leading: Container(width: 40, height: 40, decoration: ShapeDecoration(color: Colors.orange, shape: StadiumBorder())), title: Text('StadiumBorder')), ListTile(leading: Container(width: 40, height: 40, decoration: ShapeDecoration(color: Colors.purple, shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)))), title: Text('BeveledRectangleBorder'))]));
}
