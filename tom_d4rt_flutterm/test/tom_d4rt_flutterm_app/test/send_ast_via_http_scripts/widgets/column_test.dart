// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Column from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Column test executing');

  // Test basic Column
  final basicColumn = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 60.0, height: 30.0, color: Colors.red),
      Container(width: 60.0, height: 30.0, color: Colors.green),
      Container(width: 60.0, height: 30.0, color: Colors.blue),
    ],
  );
  print('Basic Column created with 3 children');

  // Test Column with mainAxisAlignment
  final centeredColumn = Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 50.0, height: 25.0, color: Colors.orange),
      Container(width: 50.0, height: 25.0, color: Colors.purple),
    ],
  );
  print('Centered Column created');

  // Test Column with crossAxisAlignment
  final startAlignedColumn = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(width: 80.0, height: 20.0, color: Colors.teal),
      Container(width: 50.0, height: 20.0, color: Colors.cyan),
      Container(width: 100.0, height: 20.0, color: Colors.pink),
    ],
  );
  print('CrossAxisAlignment.start Column created');

  final endAlignedColumn = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(width: 80.0, height: 20.0, color: Colors.amber),
      Container(width: 50.0, height: 20.0, color: Colors.lime),
      Container(width: 100.0, height: 20.0, color: Colors.indigo),
    ],
  );
  print('CrossAxisAlignment.end Column created');

  // Test Column with spacing using SizedBox
  final spacedColumn = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 40.0, height: 25.0, color: Colors.deepOrange),
      SizedBox(height: 10.0),
      Container(width: 40.0, height: 25.0, color: Colors.deepPurple),
      SizedBox(height: 10.0),
      Container(width: 40.0, height: 25.0, color: Colors.brown),
    ],
  );
  print('Spaced Column created');

  print('Column test completed');

  return Container(
    padding: EdgeInsets.all(8.0),
    color: Colors.grey.shade200,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Basic',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
              ),
              basicColumn,
            ],
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Start',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
              ),
              startAlignedColumn,
            ],
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'End',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
              ),
              endAlignedColumn,
            ],
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Spaced',
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
              ),
              spacedColumn,
            ],
          ),
        ),
      ],
    ),
  );
}
