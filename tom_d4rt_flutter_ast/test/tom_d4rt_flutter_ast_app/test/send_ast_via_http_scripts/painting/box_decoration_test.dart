// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxDecoration from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxDecoration test executing');

  // Test BoxDecoration with color
  final colorDeco = BoxDecoration(color: Colors.blue);
  print('BoxDecoration with color: ${colorDeco.color}');

  // Test BoxDecoration with borderRadius
  final roundedDeco = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(16.0),
  );
  print('BoxDecoration with borderRadius created');

  // Test BoxDecoration with border
  final borderDeco = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.black, width: 2.0),
  );
  print('BoxDecoration with border created');

  // Test BoxDecoration with boxShadow
  final shadowDeco = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: Offset(0.0, 4.0),
      ),
    ],
  );
  print('BoxDecoration with boxShadow created');

  // Test BoxDecoration with gradient
  final gradientDeco = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue, Colors.cyan],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12.0),
  );
  print('BoxDecoration with gradient created');

  // Test BoxDecoration with shape
  final circleDeco = BoxDecoration(
    color: Colors.orange,
    shape: BoxShape.circle,
  );
  print('BoxDecoration with shape: ${circleDeco.shape}');

  print('BoxDecoration test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 100.0,
        height: 40.0,
        decoration: colorDeco,
        child: Center(
          child: Text('color', style: TextStyle(color: Colors.white)),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 100.0,
        height: 40.0,
        decoration: roundedDeco,
        child: Center(
          child: Text('rounded', style: TextStyle(color: Colors.white)),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 100.0,
        height: 40.0,
        decoration: borderDeco,
        child: Center(child: Text('border')),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 100.0,
        height: 40.0,
        decoration: shadowDeco,
        child: Center(child: Text('shadow')),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 100.0,
        height: 40.0,
        decoration: gradientDeco,
        child: Center(
          child: Text('gradient', style: TextStyle(color: Colors.white)),
        ),
      ),
      SizedBox(height: 8.0),
      Container(width: 50.0, height: 50.0, decoration: circleDeco),
    ],
  );
}
