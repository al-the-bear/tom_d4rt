// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RootWidget from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootWidget test executing');
  print('=' * 50);

  // RootWidget is the widget at the root of the widget tree
  // Used by WidgetsBinding.attachRootWidget to bootstrap applications
  print('\nRootWidget Analysis:');
  print('  Type: class');
  print('  Extends: Widget');
  print('  Purpose: Root of the widget tree for bootstrapping');
  print('  Used by: WidgetsBinding.attachRootWidget, runApp');

  // Create RootWidget instances
  print('\nConstruction Tests:');
  
  final withChild = RootWidget(
    child: Container(color: Colors.blue),
  );
  print('  With child: ${withChild.runtimeType}');
  print('  Child type: ${withChild.child?.runtimeType}');

  final withDescription = RootWidget(
    child: SizedBox(),
    debugShortDescription: 'Test Root Widget',
  );
  print('  With description: ${withDescription.debugShortDescription}');

  final noChild = RootWidget();
  print('  Without child: ${noChild.child}');

  // Element creation
  print('\nElement Creation:');
  final element = withChild.createElement();
  print('  createElement() returns: ${element.runtimeType}');
  print('  Element is RootElement: ${element is RootElement}');

  // Key properties
  print('\nProperties:');
  print('  child: Widget? - the child widget');
  print('  debugShortDescription: String? - debug description');
  print('  key: Key? - inherited from Widget');

  // Methods
  print('\nMethods:');
  print('  createElement(): Creates RootElement');
  print('  attach(BuildOwner, [RootElement?]): Bootstrap widget tree');
  print('  toStringShort(): Uses debugShortDescription if set');

  // String representation
  print('\nString Representation:');
  print('  Default: ${withChild.toStringShort()}');
  print('  With description: ${withDescription.toStringShort()}');

  // Attach method (cannot fully test without BuildOwner)
  print('\nAttach Method:');
  print('  - Creates new element if none provided');
  print('  - Schedules update if element provided');
  print('  - Assigns owner and mounts element');

  print('\n' + '=' * 50);
  print('RootWidget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RootWidget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('RootWidget with child: ${withChild.child?.runtimeType}'),
      Text('Creates element: ${element.runtimeType}'),
      Text('Debug description: ${withDescription.debugShortDescription}'),
    ],
  );
}
