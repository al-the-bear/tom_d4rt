// ignore_for_file: avoid_print
// D4rt test script: Tests Card from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Card test executing');

  // Test basic Card
  final basic = Card(
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Basic Card')),
  );
  print('Basic Card created');

  // Test Card with elevation
  final elevated = Card(
    elevation: 8.0,
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Elevated Card')),
  );
  print('Card with elevation created');

  // Test Card with color
  final colored = Card(
    color: Colors.blue.shade100,
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Colored Card')),
  );
  print('Colored Card created');

  // Test Card with shape
  final rounded = Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Rounded Card')),
  );
  print('Rounded Card created');

  // Test Card with border
  final bordered = Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.blue, width: 2.0),
    ),
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Bordered Card')),
  );
  print('Bordered Card created');

  // Test Card with complex content
  final complex = Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Icon(Icons.image, size: 40.0, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'Card description text',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Complex Card created');

  print('Card test completed');

  return Container(
    padding: EdgeInsets.all(8.0),
    width: 250.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [basic, elevated, colored, rounded, bordered, complex],
    ),
  );
}
