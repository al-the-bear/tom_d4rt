import 'package:flutter/material.dart';

/// Deep visual demo for LinearBorder
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('LinearBorder Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [OutlinedButton(style: OutlinedButton.styleFrom(shape: LinearBorder(side: BorderSide(width: 2), bottom: LinearBorderEdge())), onPressed: () {}, child: Text('Bottom only')), SizedBox(height: 16), OutlinedButton(style: OutlinedButton.styleFrom(shape: LinearBorder(side: BorderSide(width: 2), start: LinearBorderEdge(), end: LinearBorderEdge())), onPressed: () {}, child: Text('Sides only')), SizedBox(height: 16), OutlinedButton(style: OutlinedButton.styleFrom(shape: LinearBorder.bottom(side: BorderSide(width: 2))), onPressed: () {}, child: Text('LinearBorder.bottom'))])));
}
