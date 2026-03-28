// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ViewportNotificationMixin from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewportNotificationMixin test executing');
  print('=' * 50);

  // ViewportNotificationMixin tracks viewport depth
  print('ViewportNotificationMixin overview:');
  print('  - Mixin on Notification');
  print('  - Has depth property');
  print('  - Counts viewports traversed');
  print('  - Used by scroll notifications');

  // depth property
  print('\ndepth property:');
  print('  - int get depth => _depth');
  print('  - Starts at 0');
  print('  - Incremented by ViewportElementMixin');
  print('  - Read-only getter');

  // How depth works
  print('\nHow depth works:');
  print('  - Notification created in scrollable');
  print('  - Bubbles up through element tree');
  print('  - Each viewport increments _depth');
  print('  - Listener reads final depth');

  // Used by
  print('\nUsed by notifications:');
  print('  - ScrollNotification');
  print('  - ScrollStartNotification');
  print('  - ScrollUpdateNotification');
  print('  - ScrollEndNotification');
  print('  - OverscrollNotification');
  print('  - UserScrollNotification');

  // Filtering by depth
  print('\nFiltering by depth:');
  print('  NotificationListener<ScrollNotification>(');
  print('    onNotification: (notification) {');
  print('      if (notification.depth == 0) {');
  print('        // Handle only immediate child scroll');
  print('      }');
  print('      return false;');
  print('    },');
  print('  )');

  // Depth values meaning
  print('\nDepth values:');
  print('  - depth=0: immediate child viewport');
  print('  - depth=1: grandchild viewport');
  print('  - depth=2+: deeper nesting');
  print('  - Higher = more viewports crossed');

  // Implementation pattern
  print('\nImplementation:');
  print('  mixin ViewportNotificationMixin on Notification {');
  print('    int _depth = 0;');
  print('    int get depth => _depth;');
  print('  }');

  // Practical use
  print('\nPractical use:');
  print('  - Ignore nested scroll events');
  print('  - Track only direct child');
  print('  - Handle nested scrollviews');
  print('  - Proper event routing');

  print('\n' + '=' * 50);
  print('ViewportNotificationMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ViewportNotificationMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin on Notification'),
      Text('Property: depth (int)'),
      Text('Use: Track viewport traversal depth'),
    ],
  );
}
