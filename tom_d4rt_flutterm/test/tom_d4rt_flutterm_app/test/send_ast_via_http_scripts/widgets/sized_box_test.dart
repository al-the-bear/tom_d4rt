// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SizedBox from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SizedBox test executing');

  // Test SizedBox with width and height
  final sized = SizedBox(
    width: 100.0,
    height: 50.0,
    child: Container(color: Colors.blue),
  );
  print('SizedBox with width and height created');

  // Test SizedBox.expand
  final expanded = SizedBox.expand(child: Container(color: Colors.green));
  print('SizedBox.expand created');

  // Test SizedBox.shrink
  final shrunk = SizedBox.shrink(child: Container(color: Colors.red));
  print('SizedBox.shrink created: $shrunk');

  // Test SizedBox.square
  final square = SizedBox.square(
    dimension: 60.0,
    child: Container(color: Colors.orange),
  );
  print('SizedBox.square created');

  // Test SizedBox.fromSize
  final fromSize = SizedBox.fromSize(
    size: Size(80.0, 40.0),
    child: Container(color: Colors.purple),
  );
  print('SizedBox.fromSize created');

  // Test SizedBox as spacer (no child)
  final spacer = SizedBox(height: 20.0);
  print('SizedBox spacer created');

  print('SizedBox test completed');

  return Container(
    padding: EdgeInsets.all(8.0),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('width/height:', style: TextStyle(fontWeight: FontWeight.bold)),
        sized,
        spacer,
        Text('square:', style: TextStyle(fontWeight: FontWeight.bold)),
        square,
        spacer,
        Text('fromSize:', style: TextStyle(fontWeight: FontWeight.bold)),
        fromSize,
        spacer,
        Text(
          'expand (in constrained box):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 150.0, height: 50.0, child: expanded),
      ],
    ),
  );
}
