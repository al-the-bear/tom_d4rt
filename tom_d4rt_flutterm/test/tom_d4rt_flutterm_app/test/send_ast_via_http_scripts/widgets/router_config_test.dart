// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouterConfig from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Minimal RouterDelegate for testing
class TestRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  @override
  Widget build(BuildContext context) => Container();

  @override
  Future<bool> popRoute() async => true;

  @override
  Future<void> setNewRoutePath(String configuration) async {}
}

dynamic build(BuildContext context) {
  print('RouterConfig test executing');
  print('=' * 50);

  // RouterConfig bundles all delegates needed for Router widget
  print('\nRouterConfig Analysis:');
  print('  Type: class (generic)');
  print('  Purpose: Bundle delegates for Router configuration');
  print('  Generic: RouterConfig<T> where T is route configuration type');

  // Create minimal RouterConfig
  print('\nConstruction with Required Delegate:');
  final routerDelegate = TestRouterDelegate();
  final config = RouterConfig<String>(
    routerDelegate: routerDelegate,
  );
  print('  Created RouterConfig<String>');
  print('  routerDelegate: ${config.routerDelegate.runtimeType}');
  print('  routeInformationProvider: ${config.routeInformationProvider}');
  print('  routeInformationParser: ${config.routeInformationParser}');
  print('  backButtonDispatcher: ${config.backButtonDispatcher}');

  // Properties explanation
  print('\nProperties:');
  print('  routerDelegate: RouterDelegate<T> (required)');
  print('    - Builds widget based on route configuration');
  print('  routeInformationProvider: RouteInformationProvider?');
  print('    - Provides route information (URL, etc.)');
  print('  routeInformationParser: RouteInformationParser<T>?');
  print('    - Parses RouteInformation into configuration T');
  print('  backButtonDispatcher: BackButtonDispatcher?');
  print('    - Handles back button presses');

  // Constraints
  print('\nConstraints:');
  print('  - routerDelegate is required');
  print('  - routeInformationProvider and routeInformationParser');
  print('    must both be null or both be non-null');

  // Usage with Router widget
  print('\nUsage with Router Widget:');
  print('  Router(');
  print('    routerDelegate: config.routerDelegate,');
  print('    routeInformationProvider: config.routeInformationProvider,');
  print('    routeInformationParser: config.routeInformationParser,');
  print('    backButtonDispatcher: config.backButtonDispatcher,');
  print('  )');
  print('  Or: Router.withConfig(config: config)');

  // Type information
  print('\nType Information:');
  print('  Config type: ${config.runtimeType}');
  print('  Delegate type: ${config.routerDelegate.runtimeType}');

  print('\n' + '=' * 50);
  print('RouterConfig test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RouterConfig Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${config.runtimeType}'),
      Text('Has delegate: ${config.routerDelegate != null}'),
      Text('Has provider: ${config.routeInformationProvider != null}'),
      Text('Has parser: ${config.routeInformationParser != null}'),
    ],
  );
}
