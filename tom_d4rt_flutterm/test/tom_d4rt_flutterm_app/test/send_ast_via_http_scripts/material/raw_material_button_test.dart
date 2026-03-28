// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawMaterialButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMaterialButton test executing');
  print('=' * 50);

  // RawMaterialButton overview
  print('RawMaterialButton overview:');
  print('  - Low-level material button');
  print('  - Base for elevated/text/outlined buttons');
  print('  - Deprecated: use ElevatedButton.styleFrom');

  // Test basic button
  print('\nTest basic RawMaterialButton:');
  final btn1 = RawMaterialButton(
    onPressed: () {},
    child: Text('Press Me'),
  );
  print('  Created: ${btn1.runtimeType}');
  print('  Has onPressed: ${btn1.onPressed != null}');
  print('  Enabled: ${btn1.enabled}');

  // Test disabled button
  print('\nTest disabled button:');
  final btn2 = RawMaterialButton(
    onPressed: null,
    child: Text('Disabled'),
  );
  print('  Enabled: ${btn2.enabled}');

  // Test button with elevation
  print('\nTest button elevation:');
  final btn3 = RawMaterialButton(
    onPressed: () {},
    elevation: 4.0,
    focusElevation: 6.0,
    hoverElevation: 8.0,
    highlightElevation: 12.0,
    disabledElevation: 0.0,
    child: Text('Elevated'),
  );
  print('  Elevation: ${btn3.elevation}');
  print('  FocusElevation: ${btn3.focusElevation}');
  print('  HoverElevation: ${btn3.hoverElevation}');
  print('  HighlightElevation: ${btn3.highlightElevation}');

  // Test button colors
  print('\nTest button colors:');
  final btn4 = RawMaterialButton(
    onPressed: () {},
    fillColor: Colors.blue,
    focusColor: Colors.lightBlue,
    hoverColor: Colors.blueAccent,
    splashColor: Colors.white,
    highlightColor: Colors.blueGrey,
    child: Text('Colored'),
  );
  print('  FillColor: ${btn4.fillColor}');
  print('  FocusColor: ${btn4.focusColor}');
  print('  HoverColor: ${btn4.hoverColor}');
  print('  SplashColor: ${btn4.splashColor}');

  // Test button shape
  print('\nTest button shape:');
  final btn5 = RawMaterialButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    clipBehavior: Clip.antiAlias,
    child: Text('Rounded'),
  );
  print('  Shape: ${btn5.shape}');
  print('  ClipBehavior: ${btn5.clipBehavior}');

  // Test button constraints
  print('\nTest button constraints:');
  final btn6 = RawMaterialButton(
    onPressed: () {},
    constraints: BoxConstraints(minWidth: 88, minHeight: 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    materialTapTargetSize: MaterialTapTargetSize.padded,
    child: Text('Constrained'),
  );
  print('  Constraints: ${btn6.constraints}');
  print('  TapTargetSize: ${btn6.materialTapTargetSize}');

  // Animation duration
  print('\nAnimation properties:');
  print('  AnimationDuration: ${btn1.animationDuration}');

  print('\n' + '=' * 50);
  print('RawMaterialButton test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawMaterialButton Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatefulWidget'),
      Text('Status: Deprecated'),
      btn1,
    ],
  );
}
