// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Expanded from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Expanded test executing');

  // Test basic Expanded in Row
  final rowWithExpanded = Row(
    children: [
      Container(width: 50.0, height: 40.0, color: Colors.red),
      Expanded(child: Container(height: 40.0, color: Colors.blue)),
      Container(width: 50.0, height: 40.0, color: Colors.green),
    ],
  );
  print('Row with Expanded created');

  // Test Expanded with flex
  final rowWithFlex = Row(
    children: [
      Expanded(flex: 1, child: Container(height: 40.0, color: Colors.orange)),
      Expanded(flex: 2, child: Container(height: 40.0, color: Colors.purple)),
      Expanded(flex: 1, child: Container(height: 40.0, color: Colors.teal)),
    ],
  );
  print('Row with flex ratios 1:2:1 created');

  // Test Expanded in Column
  final columnWithExpanded = Column(
    children: [
      Container(width: 100.0, height: 30.0, color: Colors.pink),
      Expanded(child: Container(width: 100.0, color: Colors.cyan)),
      Container(width: 100.0, height: 30.0, color: Colors.amber),
    ],
  );
  print('Column with Expanded created');

  // Test multiple Expanded with different flex values in Column
  final columnWithFlex = Column(
    children: [
      Expanded(flex: 1, child: Container(width: 80.0, color: Colors.indigo)),
      Expanded(flex: 3, child: Container(width: 80.0, color: Colors.lime)),
    ],
  );
  print('Column with flex ratios 1:3 created');

  print('Expanded test completed');

  return Container(
    padding: EdgeInsets.all(8.0),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Row with Expanded center:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        SizedBox(width: 250.0, child: rowWithExpanded),
        SizedBox(height: 12.0),
        Text(
          'Row with flex 1:2:1:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        SizedBox(width: 250.0, child: rowWithFlex),
        SizedBox(height: 12.0),
        Text(
          'Column with Expanded:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        SizedBox(height: 120.0, child: columnWithExpanded),
        SizedBox(height: 12.0),
        Text(
          'Column flex 1:3:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        SizedBox(height: 100.0, child: columnWithFlex),
      ],
    ),
  );
}
