// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouteInformation from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RouteInformation test executing');
  print('=' * 50);

  // RouteInformation holds URI and state for routing
  print('\nRouteInformation Analysis:');
  print('  Type: class');
  print('  Purpose: Holds route URI and optional state');
  print('  Used by: Router, RouteInformationProvider');

  // Create with URI
  print('\nConstruction with URI:');
  final withUri = RouteInformation(uri: Uri.parse('/home/dashboard'));
  print('  URI: \${withUri.uri}');
  print('  Path: \${withUri.uri.path}');
  print('  State: \${withUri.state}');

  // Create with complex URI
  print('\nConstruction with Complex URI:');
  final complexUri = RouteInformation(
    uri: Uri.parse('/products?category=electronics&sort=price'),
    state: {'scrollPosition': 100.0},
  );
  print('  URI: \${complexUri.uri}');
  print('  Path: \${complexUri.uri.path}');
  print('  Query: \${complexUri.uri.query}');
  print('  Query params: \${complexUri.uri.queryParameters}');
  print('  State: \${complexUri.state}');

  // URI with fragment
  print('\nURI with Fragment:');
  final withFragment = RouteInformation(
    uri: Uri.parse('/docs#section-2'),
  );
  print('  URI: \${withFragment.uri}');
  print('  Fragment: \${withFragment.uri.fragment}');

  // Simple path
  print('\nSimple Path:');
  final simple = RouteInformation(uri: Uri.parse('/'));
  print('  Root path URI: \${simple.uri}');
  print('  Path: \${simple.uri.path}');

  // State types
  print('\nState Property:');
  print('  - Can hold any serializable object');
  print('  - Persisted for state restoration');
  print('  - On web: stored in browser history');
  final withMapState = RouteInformation(
    uri: Uri.parse('/settings'),
    state: {'theme': 'dark', 'language': 'en'},
  );
  print('  Map state: \${withMapState.state}');

  // Properties summary
  print('\nProperties:');
  print('  uri: Uri - the route location');
  print('  state: Object? - serializable state data');
  print('  location (deprecated): String');

  print('\n' + '=' * 50);
  print('RouteInformation test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RouteInformation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Simple URI: \${withUri.uri.path}'),
      Text('Complex path: \${complexUri.uri.path}'),
      Text('With state: \${complexUri.state != null}'),
    ],
  );
}
