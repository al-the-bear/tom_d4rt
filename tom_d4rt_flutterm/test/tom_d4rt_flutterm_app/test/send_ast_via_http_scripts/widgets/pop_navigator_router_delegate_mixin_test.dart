// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopNavigatorRouterDelegateMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopNavigatorRouterDelegateMixin test executing');

  // PopNavigatorRouterDelegateMixin - Mixin for RouterDelegate to handle back button
  // Implements popRoute() by delegating to Navigator
  
  print('PopNavigatorRouterDelegateMixin purpose:');
  print('- Provides default popRoute() implementation');
  print('- Delegates to Navigator.maybePop()');
  print('- Handles Android back button in Router apps');
  print('- Simplifies RouterDelegate implementation');
  
  // popRoute implementation
  print('\npopRoute() implementation:');
  print('1. Called when system back button pressed');
  print('2. Finds Navigator using navigatorKey');
  print('3. Calls Navigator.maybePop()');
  print('4. Returns Future<bool> (true if popped)');
  
  // Required navigatorKey
  print('\nRequired navigatorKey:');
  print('- Must provide GlobalKey<NavigatorState>');
  print('- Used to access Navigator inside Router');
  print('- abstract T get navigatorKey');
  
  // Usage pattern
  print('\nUsage pattern:');
  print('class MyRouterDelegate extends RouterDelegate');
  print('    with PopNavigatorRouterDelegateMixin {');
  print('  final navigatorKey = GlobalKey<NavigatorState>();');
  print('}');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('PopNavigatorRouterDelegateMixin is mixin on RouterDelegate');
  print('Provides popRoute() implementation');
  print('Used with Router widget');
  
  // Use cases
  print('\nUse cases:');
  print('- Navigator 2.0 apps');
  print('- Deep linking support');
  print('- Web URL routing');
  print('- Custom back navigation');

  print('\nPopNavigatorRouterDelegateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopNavigatorRouterDelegateMixin Tests'),
      Text('Back button handling for Router'),
      Text('Delegates to Navigator.maybePop'),
      Text('Navigator 2.0 pattern'),
    ],
  );
}
