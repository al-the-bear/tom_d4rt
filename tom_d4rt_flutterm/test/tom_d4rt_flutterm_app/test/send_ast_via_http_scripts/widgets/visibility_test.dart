// ignore_for_file: avoid_print
// D4rt test script: Tests Visibility from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Visibility test executing');

  // Test Visibility visible
  final visibleWidget = Visibility(
    visible: true,
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Visible', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility(visible=true) created');

  // Test Visibility invisible (default behavior - collapses)
  final invisibleWidget = Visibility(
    visible: false,
    child: Container(
      color: Colors.red,
      height: 60.0,
      child: Center(
        child: Text('Invisible', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility(visible=false) created - collapses space');

  // Test Visibility invisible with maintainSize
  final maintainSizeWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    child: Container(
      color: Colors.green,
      height: 60.0,
      child: Center(
        child: Text('Maintain size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with maintainSize=true created - space preserved');

  // Test Visibility with replacement
  final replacementWidget = Visibility(
    visible: false,
    replacement: Container(
      color: Colors.grey,
      height: 60.0,
      child: Center(
        child: Text(
          'Replacement widget',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
    child: Container(
      color: Colors.orange,
      height: 60.0,
      child: Center(
        child: Text('Original widget', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with replacement created');

  // Test Visibility with maintainAnimation only
  final maintainAnimWidget = Visibility(
    visible: false,
    maintainAnimation: true,
    maintainState: true,
    child: Container(
      color: Colors.purple,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain animation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainAnimation=true, maintainState=true created');

  // Test Visibility with maintainState only
  final maintainStateWidget = Visibility(
    visible: false,
    maintainState: true,
    child: Container(
      color: Colors.teal,
      height: 60.0,
      child: Center(
        child: Text('Maintain state', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with maintainState=true created');

  // Test Visibility with maintainInteractivity
  final maintainInteractWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    maintainInteractivity: true,
    child: Container(
      color: Colors.indigo,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain interactivity',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainInteractivity=true created');

  // Test Visibility with maintainSemantics
  final maintainSemanticsWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    maintainSemantics: true,
    child: Container(
      color: Colors.brown,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain semantics',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainSemantics=true created');

  print('Visibility test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Visibility Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Visible:', style: TextStyle(fontWeight: FontWeight.bold)),
        visibleWidget,
        SizedBox(height: 8.0),
        Text(
          'Invisible (collapses):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: invisibleWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'Invisible (maintainSize):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainSizeWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'Invisible with replacement:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        replacementWidget,
        SizedBox(height: 8.0),
        Text(
          'MaintainAnimation:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainAnimWidget,
        ),
        SizedBox(height: 8.0),
        Text('MaintainState:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainStateWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'MaintainInteractivity:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainInteractWidget,
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• visible=false collapses by default'),
        Text('• maintainSize keeps space occupied'),
        Text('• maintainState preserves widget state'),
        Text('• maintainAnimation keeps animations running'),
        Text('• replacement shows alternative widget'),
      ],
    ),
  );
}
