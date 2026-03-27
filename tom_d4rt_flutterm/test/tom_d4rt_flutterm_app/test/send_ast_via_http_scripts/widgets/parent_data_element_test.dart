// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ParentDataElement from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ParentDataElement test executing');
  print('=' * 50);

  // === Test ParentDataElement class ===
  print('\nParentDataElement manages ParentDataWidget');

  // Describe ParentDataElement
  print('\n--- Understanding ParentDataElement ---');
  print('Element for ParentDataWidget<T>');
  print('Applies parent data to RenderObject');
  print('Generic over ParentData type T');

  // Test via Positioned in Stack
  print('\n--- Testing via Positioned ---');
  final stack = Stack(
    children: [
      Positioned(
        left: 10,
        top: 20,
        child: Container(width: 50, height: 50, color: Colors.red),
      ),
      Positioned(
        right: 10,
        bottom: 20,
        child: Container(width: 50, height: 50, color: Colors.blue),
      ),
    ],
  );
  print('Created Stack with Positioned children');
  print('Positioned creates ParentDataElement');

  // Test via Flexible in Row/Column
  print('\n--- Testing via Flexible ---');
  final row = Row(
    children: [
      Flexible(
        flex: 2,
        child: Text('Flex 2'),
      ),
      Flexible(
        flex: 1,
        child: Text('Flex 1'),
      ),
    ],
  );
  print('Created Row with Flexible children');
  print('Flexible creates ParentDataElement<FlexParentData>');

  // Key method: applyWidgetOutOfTurn
  print('\n--- Key method: applyWidgetOutOfTurn ---');
  print('applyWidgetOutOfTurn(ParentDataWidget<T> newWidget)');
  print('Updates parent data without rebuild');
  print('Used by AutomaticKeepAlive');

  // debugParentDataType
  print('\n--- Testing debugParentDataType ---');
  print('Type get debugParentDataType');
  print('Returns T, the ParentData type');
  print('Only available in debug mode');

  // notifyClients
  print('\n--- Testing notifyClients ---');
  print('Called when widget updates');
  print('Applies new parent data to RenderObject');

  // Inheritance
  print('\n--- Testing inheritance ---');
  print('Extends ProxyElement');
  print('Used by ParentDataWidget.createElement()');

  print('\n' + '=' * 50);
  print('ParentDataElement test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ParentDataElement Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: ProxyElement'),
      Text('Generic: ParentDataElement<T>'),
      SizedBox(height: 80, child: stack),
    ],
  );
}
