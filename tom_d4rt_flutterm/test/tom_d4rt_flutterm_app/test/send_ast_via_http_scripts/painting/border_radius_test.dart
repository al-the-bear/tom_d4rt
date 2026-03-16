// D4rt test script: Tests BorderRadius from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderRadius test executing');

  // Test BorderRadius.circular
  final circular = BorderRadius.circular(16.0);
  print('BorderRadius.circular(16): topLeft=${circular.topLeft.x}');

  // Test BorderRadius.all
  final all = BorderRadius.all(Radius.circular(12.0));
  print('BorderRadius.all: ${all.topLeft.x}');

  // Test BorderRadius.only
  final only = BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(10.0),
    bottomLeft: Radius.circular(5.0),
    bottomRight: Radius.circular(15.0),
  );
  print(
    'BorderRadius.only: tl=${only.topLeft.x}, tr=${only.topRight.x}, bl=${only.bottomLeft.x}, br=${only.bottomRight.x}',
  );

  // Test BorderRadius.vertical
  final vertical = BorderRadius.vertical(
    top: Radius.circular(25.0),
    bottom: Radius.circular(10.0),
  );
  print(
    'BorderRadius.vertical: top=${vertical.topLeft.x}, bottom=${vertical.bottomLeft.x}',
  );

  // Test BorderRadius.horizontal
  final horizontal = BorderRadius.horizontal(
    left: Radius.circular(15.0),
    right: Radius.circular(30.0),
  );
  print(
    'BorderRadius.horizontal: left=${horizontal.topLeft.x}, right=${horizontal.topRight.x}',
  );

  // Test BorderRadius.zero
  final zero = BorderRadius.zero;
  print('BorderRadius.zero: ${zero.topLeft.x}');

  print('BorderRadius test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 150.0,
        height: 50.0,
        decoration: BoxDecoration(color: Colors.blue, borderRadius: circular),
        child: Center(
          child: Text('circular', style: TextStyle(color: Colors.white)),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 150.0,
        height: 50.0,
        decoration: BoxDecoration(color: Colors.green, borderRadius: only),
        child: Center(
          child: Text('only', style: TextStyle(color: Colors.white)),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        width: 150.0,
        height: 50.0,
        decoration: BoxDecoration(color: Colors.orange, borderRadius: vertical),
        child: Center(
          child: Text('vertical', style: TextStyle(color: Colors.white)),
        ),
      ),
    ],
  );
}
