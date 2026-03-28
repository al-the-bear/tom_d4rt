// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ViewportElementMixin from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewportElementMixin test executing');
  print('=' * 50);

  // ViewportElementMixin for notification depth
  print('ViewportElementMixin overview:');
  print('  - Mixin on NotifiableElementMixin');
  print('  - Tracks notification viewport depth');
  print('  - Used by viewport elements');
  print('  - For nested viewport counting');

  // Purpose
  print('\nPurpose:');
  print('  - Increments notification depth');
  print('  - Used with ViewportNotificationMixin');
  print('  - Helps identify notification source');
  print('  - For nested scrollable handling');

  // onNotification method
  print('\nonNotification method:');
  print('  - Overrides NotifiableElementMixin');
  print('  - Checks for ViewportNotificationMixin');
  print('  - Increments depth if present');
  print('  - Calls super.onNotification');

  // Implementation
  print('\nImplementation:');
  print('  mixin ViewportElementMixin on NotifiableElementMixin {');
  print('    @override');
  print('    bool onNotification(Notification notification) {');
  print('      if (notification is ViewportNotificationMixin) {');
  print('        notification._depth += 1;');
  print('      }');
  print('      return super.onNotification(notification);');
  print('    }');
  print('  }');

  // Used by
  print('\nUsed by:');
  print('  - _ScrollableElement');
  print('  - _ViewportElement');
  print('  - Viewport-like elements');
  print('  - Nested scrollable widgets');

  // Depth tracking
  print('\nDepth tracking:');
  print('  - depth=0: first viewport');
  print('  - depth=1: nested viewport');
  print('  - And so on for deeper nesting');
  print('  - Read via notification.depth');

  // Relationship
  print('\nRelationship with other mixins:');
  print('  - NotifiableElementMixin: base');
  print('  - ViewportElementMixin: adds depth');
  print('  - ViewportNotificationMixin: tracks depth');
  print('  - All work together for scrolling');

  // Why needed
  print('\nWhy needed:');
  print('  - Differentiate scroll sources');
  print('  - Handle nested scrollviews');
  print('  - Proper notification routing');
  print('  - Avoid double-handling');

  print('\n' + '=' * 50);
  print('ViewportElementMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ViewportElementMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin on NotifiableElementMixin'),
      Text('Purpose: Track viewport notification depth'),
      Text('Method: onNotification()'),
    ],
  );
}
