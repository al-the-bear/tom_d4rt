// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Center from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Center test executing');

  // Test basic Center
  final basic = Center(
    child: Text('Centered Text', style: TextStyle(fontSize: 18.0)),
  );
  print('Basic Center created');

  // Test Center with widthFactor
  final withWidthFactor = Center(
    widthFactor: 2.0,
    child: Container(width: 50.0, height: 50.0, color: Colors.blue),
  );
  print('Center with widthFactor created');

  // Test Center with heightFactor
  final withHeightFactor = Center(
    heightFactor: 1.5,
    child: Container(width: 60.0, height: 40.0, color: Colors.green),
  );
  print('Center with heightFactor created');

  // Test Center with both factors
  final withBothFactors = Center(
    widthFactor: 3.0,
    heightFactor: 2.0,
    child: Container(width: 30.0, height: 30.0, color: Colors.orange),
  );
  print('Center with both factors created');

  print('Center test completed');

  return Container(
    width: 250.0,
    height: 300.0,
    color: Colors.grey.shade200,
    child: Column(
      children: [
        Container(height: 60.0, color: Colors.red.shade100, child: basic),
        Container(
          height: 80.0,
          color: Colors.blue.shade100,
          child: withWidthFactor,
        ),
        Container(
          height: 80.0,
          color: Colors.green.shade100,
          child: withHeightFactor,
        ),
        Container(
          height: 80.0,
          color: Colors.orange.shade100,
          child: withBothFactors,
        ),
      ],
    ),
  );
}
