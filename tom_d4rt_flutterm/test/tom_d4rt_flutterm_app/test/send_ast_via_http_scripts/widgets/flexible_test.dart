// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Flexible widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Flexible test executing');

  // Test basic Flexible with default flex
  final basicFlexible = Row(
    children: [
      Flexible(child: Container(height: 50.0, color: Colors.blue)),
      Container(width: 50.0, height: 50.0, color: Colors.red),
    ],
  );
  print('Basic Flexible created with default flex=1');

  // Test Flexible with custom flex value
  final customFlex = Row(
    children: [
      Flexible(flex: 2, child: Container(height: 50.0, color: Colors.green)),
      Flexible(flex: 1, child: Container(height: 50.0, color: Colors.orange)),
    ],
  );
  print('Flexible with flex=2 and flex=1 created');

  // Test Flexible with FlexFit.tight
  final tightFit = Row(
    children: [
      Flexible(
        fit: FlexFit.tight,
        child: Container(height: 50.0, color: Colors.purple),
      ),
      Container(width: 50.0, height: 50.0, color: Colors.pink),
    ],
  );
  print('Flexible with FlexFit.tight created');

  // Test Flexible with FlexFit.loose
  final looseFit = Row(
    children: [
      Flexible(
        fit: FlexFit.loose,
        child: Container(width: 80.0, height: 50.0, color: Colors.teal),
      ),
      Container(width: 50.0, height: 50.0, color: Colors.amber),
    ],
  );
  print('Flexible with FlexFit.loose created');

  // Test multiple Flexible widgets with different flex values
  final multipleFlexible = Row(
    children: [
      Flexible(flex: 1, child: Container(height: 50.0, color: Colors.red)),
      Flexible(flex: 2, child: Container(height: 50.0, color: Colors.green)),
      Flexible(flex: 3, child: Container(height: 50.0, color: Colors.blue)),
    ],
  );
  print('Multiple Flexible with flex=1,2,3 created');

  // Test Flexible in Column
  final columnFlexible = SizedBox(
    height: 150.0,
    child: Column(
      children: [
        Flexible(flex: 1, child: Container(width: 100.0, color: Colors.cyan)),
        Flexible(flex: 2, child: Container(width: 100.0, color: Colors.lime)),
      ],
    ),
  );
  print('Flexible in Column created');

  print('Flexible test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: 200.0, child: basicFlexible),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, child: customFlex),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, child: tightFit),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, child: looseFit),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, child: multipleFlexible),
      SizedBox(height: 8.0),
      columnFlexible,
    ],
  );
}
