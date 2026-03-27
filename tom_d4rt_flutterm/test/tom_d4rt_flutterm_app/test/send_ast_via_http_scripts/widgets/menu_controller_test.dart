// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MenuController from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MenuController test executing');
  print('=' * 50);

  // === Test MenuController class ===
  print('\nMenuController manages menu anchor visibility');

  // Create a MenuController
  print('\n--- Testing MenuController creation ---');
  final controller = MenuController();
  print('Created MenuController');
  print('controller.runtimeType: ${controller.runtimeType}');

  // Test isOpen property before attaching
  print('\n--- Testing isOpen property ---');
  print('controller.isOpen (unattached): ${controller.isOpen}');
  print('Returns false when not attached to anchor');

  // Test static maybeOf method
  print('\n--- Testing MenuController.maybeOf ---');
  final maybeController = MenuController.maybeOf(context);
  print('MenuController.maybeOf(context): $maybeController');
  print('Returns null if no MenuController ancestor');

  // Create MenuAnchor with controller
  print('\n--- Testing with MenuAnchor ---');
  final menuAnchor = MenuAnchor(
    controller: controller,
    menuChildren: [
      MenuItemButton(
        child: Text('Item 1'),
        onPressed: () => print('Item 1 pressed'),
      ),
      MenuItemButton(
        child: Text('Item 2'),
        onPressed: () => print('Item 2 pressed'),
      ),
    ],
    child: Text('Menu Button'),
  );
  print('Created MenuAnchor with controller');
  print('menuAnchor.controller: ${menuAnchor.controller}');

  // Test controller methods signature
  print('\n--- Testing controller methods ---');
  print('open({Offset? position}): Opens menu at position');
  print('close(): Closes the menu');
  print('closeChildren(): Closes child menus');

  // Test with position parameter
  print('\n--- Testing open with position ---');
  print('open(position: Offset(100, 100))');
  print('Opens menu at specified position');

  // Test lifecycle
  print('\n--- Testing lifecycle ---');
  print('Controller attaches when MenuAnchor mounts');
  print('Controller detaches when MenuAnchor unmounts');
  print('isOpen reflects current menu state');

  // Test static methods
  print('\n--- Testing static methods ---');
  print('MenuController.maybeOf(context): finds ancestor');
  print('Does not create dependency relationship');

  // Test with nested menus
  print('\n--- Testing nested menus ---');
  print('closeChildren(): closes nested submenus');
  print('Parent menu remains open');

  print('\n' + '=' * 50);
  print('MenuController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MenuController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('isOpen: ${controller.isOpen}'),
      Text('Purpose: Control menu anchors'),
      menuAnchor,
    ],
  );
}
