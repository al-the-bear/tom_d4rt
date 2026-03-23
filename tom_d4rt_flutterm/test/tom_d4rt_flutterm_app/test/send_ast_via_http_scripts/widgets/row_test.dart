// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Row from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Row test executing');

  // Test basic Row
  final basicRow = Row(
    children: [
      Container(width: 40.0, height: 40.0, color: Colors.red),
      Container(width: 40.0, height: 40.0, color: Colors.green),
      Container(width: 40.0, height: 40.0, color: Colors.blue),
    ],
  );
  print('Basic Row created with 3 children');

  // Test Row with mainAxisAlignment
  final centeredRow = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 30.0, height: 30.0, color: Colors.orange),
      Container(width: 30.0, height: 30.0, color: Colors.purple),
    ],
  );
  print('Centered Row created');

  // Test Row with mainAxisAlignment.spaceBetween
  final spaceBetweenRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(width: 25.0, height: 25.0, color: Colors.teal),
      Container(width: 25.0, height: 25.0, color: Colors.cyan),
      Container(width: 25.0, height: 25.0, color: Colors.pink),
    ],
  );
  print('SpaceBetween Row created');

  // Test Row with mainAxisAlignment.spaceEvenly
  final spaceEvenlyRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(width: 20.0, height: 20.0, color: Colors.amber),
      Container(width: 20.0, height: 20.0, color: Colors.lime),
    ],
  );
  print('SpaceEvenly Row created');

  // Test Row with crossAxisAlignment
  final crossAlignedRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(width: 30.0, height: 60.0, color: Colors.indigo),
      Container(width: 30.0, height: 30.0, color: Colors.brown),
      Container(width: 30.0, height: 45.0, color: Colors.grey),
    ],
  );
  print('CrossAxisAlignment.start Row created');

  // Test Row with mainAxisSize
  final minRow = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 40.0, height: 40.0, color: Colors.deepOrange),
      Container(width: 40.0, height: 40.0, color: Colors.deepPurple),
    ],
  );
  print('MainAxisSize.min Row created');

  print('Row test completed');

  return Container(
    width: 280.0,
    padding: EdgeInsets.all(8.0),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicRow,
        SizedBox(height: 8.0),
        Text('Center:', style: TextStyle(fontWeight: FontWeight.bold)),
        centeredRow,
        SizedBox(height: 8.0),
        Text('SpaceBetween:', style: TextStyle(fontWeight: FontWeight.bold)),
        spaceBetweenRow,
        SizedBox(height: 8.0),
        Text('SpaceEvenly:', style: TextStyle(fontWeight: FontWeight.bold)),
        spaceEvenlyRow,
        SizedBox(height: 8.0),
        Text('CrossAxis start:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(height: 70.0, child: crossAlignedRow),
        SizedBox(height: 8.0),
        Text(
          'MainAxisSize.min:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        minRow,
      ],
    ),
  );
}
