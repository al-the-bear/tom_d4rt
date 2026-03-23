// ignore_for_file: avoid_print
// D4rt test script: Tests ElevatedButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ElevatedButton test executing');

  // Test basic ElevatedButton
  final basic = ElevatedButton(
    onPressed: () {
      print('Basic button pressed');
    },
    child: Text('Basic Button'),
  );
  print('Basic ElevatedButton created');

  // Test ElevatedButton with icon
  final withIcon = ElevatedButton.icon(
    onPressed: () {
      print('Icon button pressed');
    },
    icon: Icon(Icons.send),
    label: Text('Send'),
  );
  print('ElevatedButton.icon created');

  // Test ElevatedButton with style
  final styled = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    ),
    child: Text('Styled Button'),
  );
  print('Styled ElevatedButton created');

  // Test disabled ElevatedButton
  final disabled = ElevatedButton(onPressed: null, child: Text('Disabled'));
  print('Disabled ElevatedButton created');

  // Test ElevatedButton with custom shape
  final rounded = ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    child: Text('Rounded'),
  );
  print('Rounded ElevatedButton created');

  print('ElevatedButton test completed');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        basic,
        SizedBox(height: 12.0),
        withIcon,
        SizedBox(height: 12.0),
        styled,
        SizedBox(height: 12.0),
        disabled,
        SizedBox(height: 12.0),
        rounded,
      ],
    ),
  );
}
