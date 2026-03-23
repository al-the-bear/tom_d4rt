// ignore_for_file: avoid_print
// D4rt test script: Tests Padding from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Padding test executing');

  // Test Padding with EdgeInsets.all
  final allPadding = Padding(
    padding: EdgeInsets.all(16.0),
    child: Container(
      color: Colors.blue,
      child: Text('all(16)', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Padding with EdgeInsets.all created');

  // Test Padding with EdgeInsets.symmetric
  final symmetricPadding = Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Container(
      color: Colors.green,
      child: Text('symmetric', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Padding with EdgeInsets.symmetric created');

  // Test Padding with EdgeInsets.only
  final onlyPadding = Padding(
    padding: EdgeInsets.only(left: 32.0, top: 8.0),
    child: Container(
      color: Colors.orange,
      child: Text('only left+top', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Padding with EdgeInsets.only created');

  // Test Padding with EdgeInsets.fromLTRB
  final ltrbPadding = Padding(
    padding: EdgeInsets.fromLTRB(8.0, 16.0, 24.0, 32.0),
    child: Container(
      color: Colors.purple,
      child: Text('fromLTRB', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Padding with EdgeInsets.fromLTRB created');

  print('Padding test completed');

  return Container(
    color: Colors.grey.shade300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(color: Colors.red.shade100, child: allPadding),
        SizedBox(height: 8.0),
        Container(color: Colors.green.shade100, child: symmetricPadding),
        SizedBox(height: 8.0),
        Container(color: Colors.orange.shade100, child: onlyPadding),
        SizedBox(height: 8.0),
        Container(color: Colors.purple.shade100, child: ltrbPadding),
      ],
    ),
  );
}
