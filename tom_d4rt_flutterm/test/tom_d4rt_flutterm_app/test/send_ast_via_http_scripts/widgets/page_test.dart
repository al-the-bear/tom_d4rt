// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Page from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Page test executing');
  print('=' * 50);

  // === Test Page abstract class ===
  print('\nPage defines route configuration for Navigator 2.0');

  // Describe Page
  print('\n--- Understanding Page ---');
  print('Abstract class extending RouteSettings');
  print('Creates Route via createRoute method');
  print('Used with Navigator.pages for declarative nav');

  // Test via MaterialPage
  print('\n--- Testing via MaterialPage ---');
  final page = MaterialPage(
    key: ValueKey('home'),
    name: 'home',
    child: Text('Home content'),
  );
  print('Created MaterialPage');
  print('page.key: ${page.key}');
  print('page.name: ${page.name}');

  // Test canPop property
  print('\n--- Testing canPop ---');
  print('page.canPop: ${page.canPop}');
  print('Default: true, can be popped');
  print('Set to false to block pop');

  // Test restorationId
  print('\n--- Testing restorationId ---');
  final pageWithRestore = MaterialPage(
    key: ValueKey('restorable'),
    restorationId: 'my-page',
    child: Text('Restorable'),
  );
  print('restorationId: ${pageWithRestore.restorationId}');
  print('Enables state restoration');

  // Test canUpdate
  print('\n--- Testing canUpdate ---');
  final page1 = MaterialPage(key: ValueKey('a'), child: Text('A'));
  final page2 = MaterialPage(key: ValueKey('a'), child: Text('B'));
  final page3 = MaterialPage(key: ValueKey('b'), child: Text('C'));
  print('page1.canUpdate(page2): ${page1.canUpdate(page2)}');
  print('page1.canUpdate(page3): ${page1.canUpdate(page3)}');
  print('Same key = can update');

  // Test createRoute
  print('\n--- Testing createRoute ---');
  print('Route<T> createRoute(BuildContext context)');
  print('Creates Route from page configuration');
  print('MaterialPage creates MaterialPageRoute');

  // Test onPopInvoked
  print('\n--- Testing onPopInvoked ---');
  print('Called after pop is handled');
  print('didPop: true if actually popped');

  print('\n' + '=' * 50);
  print('Page test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Page Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('key: ${page.key}'),
      Text('canPop: ${page.canPop}'),
      Text('canUpdate works: ${page1.canUpdate(page2)}'),
    ],
  );
}
