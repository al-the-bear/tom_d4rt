// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TrackingScrollController from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TrackingScrollController test executing');
  print('=' * 50);

  // TrackingScrollController extends ScrollController
  print('TrackingScrollController overview:');
  print('  - Extends ScrollController');
  print('  - Tracks multiple scroll positions');
  print('  - Returns most recently active position');
  print('  - Used with multiple scrollables');

  // Constructor
  print('\nConstructor parameters:');
  print('  - initialScrollOffset: double (default 0.0)');
  print('  - keepScrollOffset: bool (default true)');
  print('  - debugLabel: String? (optional)');
  final controller = TrackingScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
    debugLabel: 'test',
  );
  print('  Created controller: $controller');

  // Position tracking
  print('\nPosition tracking:');
  print('  - Tracks all attached positions');
  print('  - mostRecentlyUpdatedPosition getter');
  print('  - Shows position with recent user interaction');
  print('  - Falls back to any attached position');

  // Use case
  print('\nPrimary use case (TabBarView):');
  print('  - Multiple pages with scrollable content');
  print('  - Each page has own scroll position');
  print('  - Controller determines active tab');
  print('  - mostRecentlyUpdatedPosition shows active');

  // Difference from ScrollController
  print('\nDifference from ScrollController:');
  print('  - ScrollController: single position');
  print('  - TrackingScrollController: multiple positions');
  print('  - Tracks didUpdateScrollPositionBy calls');
  print('  - Remembers last user-scrolled position');

  // Key getter
  print('\nmostRecentlyUpdatedPosition behavior:');
  print('  - Returns position user scrolled');
  print('  - null if no positions attached');
  print('  - Updates on scroll events');
  print('  - Useful for determining active view');

  // Attach/detach
  print('\nPosition attach/detach:');
  print('  - createScrollPosition() creates new');
  print('  - attach() adds to tracked positions');
  print('  - detach() removes from tracking');
  print('  - Lifecycle follows ScrollController');

  // Page persistence
  print('\nPage position persistence:');
  print('  - keepScrollOffset saves position');
  print('  - PageStorage used for persistence');
  print('  - Survives page navigation');
  print('  - Restores on return to page');
  
  // Clean up
  controller.dispose();

  print('\n' + '=' * 50);
  print('TrackingScrollController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TrackingScrollController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ScrollController subclass'),
      Text('Key: mostRecentlyUpdatedPosition'),
      Text('Use: Multi-page scroll tracking'),
    ],
  );
}
