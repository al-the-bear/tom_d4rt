// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RouteAware from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


// D4rt bridge workaround: bridged RouteAware cannot be used as mixin
mixin _RouteAwareShim {
  void didPopNext() {}
  void didPush() {}
  void didPop() {}
  void didPushNext() {}
}

// Example implementation of RouteAware
class TestRouteAware with _RouteAwareShim {
  List<String> events = [];

  @override
  void didPopNext() {
    events.add('didPopNext');
  }

  @override
  void didPush() {
    events.add('didPush');
  }

  @override
  void didPop() {
    events.add('didPop');
  }

  @override
  void didPushNext() {
    events.add('didPushNext');
  }
}

dynamic build(BuildContext context) {
  print('RouteAware test executing');
  print('=' * 50);

  // RouteAware is a mixin for widgets aware of their current Route
  print('\nRouteAware Analysis:');
  print('  Type: abstract mixin class');
  print('  Purpose: Interface for route-aware widgets');
  print('  Used with: RouteObserver');

  // Create test implementation
  print('\nTest Implementation:');
  final routeAware = TestRouteAware();
  print('  Created TestRouteAware: ${routeAware.runtimeType}');
  print('  Is RouteAware: ${routeAware is RouteAware}');

  // Test all callback methods
  print('\nCallback Methods:');
  
  routeAware.didPush();
  print('  didPush() - Called when current route is pushed');
  print('  Events so far: ${routeAware.events}');

  routeAware.didPushNext();
  print('  didPushNext() - Called when new route pushed on top');
  print('  Events so far: ${routeAware.events}');

  routeAware.didPopNext();
  print('  didPopNext() - Called when top route popped, current shows');
  print('  Events so far: ${routeAware.events}');

  routeAware.didPop();
  print('  didPop() - Called when current route popped');
  print('  Events so far: ${routeAware.events}');

  // All events recorded
  print('\nAll Events Recorded:');
  for (var i = 0; i < routeAware.events.length; i++) {
    print('  ${i + 1}. ${routeAware.events[i]}');
  }

  // Usage pattern with RouteObserver
  print('\nUsage Pattern:');
  print('  1. Create RouteObserver<PageRoute> as navigator observer');
  print('  2. Subscribe widget in didChangeDependencies');
  print('  3. Unsubscribe in dispose');
  print('  4. React to route changes in callbacks');

  print('\n' + '=' * 50);
  print('RouteAware test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RouteAware Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Implementation: ${routeAware.runtimeType}'),
      Text('Events count: ${routeAware.events.length}'),
      Text('Events: ${routeAware.events.join(", ")}'),
    ],
  );
}
