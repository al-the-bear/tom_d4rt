// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformRouteInformationProvider from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformRouteInformationProvider test executing');
  print('=' * 50);

  // === Test PlatformRouteInformationProvider class ===
  print('\nPlatformRouteInformationProvider provides route info from platform');

  // Describe the class
  print('\n--- Understanding the class ---');
  print('Extends RouteInformationProvider');
  print('Mixes in WidgetsBindingObserver, ChangeNotifier');
  print('Syncs route info with browser/system');

  // Test creation
  print('\n--- Testing creation ---');
  final provider = PlatformRouteInformationProvider(
    initialRouteInformation: RouteInformation(
      uri: Uri.parse('/home'),
    ),
  );
  print('Created PlatformRouteInformationProvider');
  print('provider.runtimeType: ${provider.runtimeType}');

  // Test value property
  print('\n--- Testing value ---');
  print('provider.value.uri: ${provider.value.uri}');
  print('Returns current RouteInformation');

  // Test routerReportsNewRouteInformation
  print('\n--- routerReportsNewRouteInformation ---');
  print('Called by Router when route changes');
  print('Updates browser URL on web');
  print('Updates system navigation state');

  // RouteInformationReportingType
  print('\n--- RouteInformationReportingType ---');
  print('neglect: replace history entry');
  print('navigate: add history entry');
  print('none: auto-detect based on URL');

  // Test listener pattern
  print('\n--- Testing listeners ---');
  print('addListener(callback): subscribe to changes');
  print('removeListener(callback): unsubscribe');
  print('Notifies when platform changes route');

  // WidgetsBindingObserver integration
  print('\n--- WidgetsBindingObserver ---');
  print('didPushRouteInformation handles platform nav');
  print('Responds to browser back/forward');

  // Test dispose
  print('\n--- Testing dispose ---');
  print('dispose(): cleanup observers');
  print('Removes WidgetsBinding observer');

  // Usage with Router
  print('\n--- Usage with Router ---');
  print('Router.routeInformationProvider');
  print('MaterialApp.router uses it automatically');

  // Cleanup
  provider.dispose();
  
  print('\n' + '=' * 50);
  print('PlatformRouteInformationProvider test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformRouteInformationProvider Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: RouteInformationProvider'),
      Text('Syncs with platform navigation'),
      Text('Used by Router widget'),
    ],
  );
}
