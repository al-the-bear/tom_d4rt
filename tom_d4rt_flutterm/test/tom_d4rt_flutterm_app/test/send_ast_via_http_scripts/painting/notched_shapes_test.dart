import 'package:flutter/material.dart';

/// Deep visual demo for NotchedShapes
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Notched Shapes Demo')), floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)), floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, bottomNavigationBar: BottomAppBar(shape: CircularNotchedRectangle(), notchMargin: 8, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [IconButton(icon: Icon(Icons.home), onPressed: () {}), SizedBox(width: 48), IconButton(icon: Icon(Icons.person), onPressed: () {})])));
}
