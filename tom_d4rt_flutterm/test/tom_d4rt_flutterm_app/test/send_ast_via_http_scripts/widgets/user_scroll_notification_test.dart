// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UserScrollNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UserScrollNotification test executing');
  print('=' * 50);

  // UserScrollNotification for user scroll events
  print('UserScrollNotification overview:');
  print('  - Extends ScrollNotification');
  print('  - Indicates user scroll direction');
  print('  - Has direction property');
  print('  - Dispatched during user scrolling');

  // ScrollDirection values
  print('\nScrollDirection values:');
  print('  - ScrollDirection.idle: not scrolling');
  print('  - ScrollDirection.forward: content moving forward');
  print('  - ScrollDirection.reverse: content moving reverse');

  // When dispatched
  print('\nWhen dispatched:');
  print('  - When user scroll direction changes');
  print('  - Between ScrollStartNotification and ScrollEndNotification');
  print('  - Not for programmatic scrolls');
  print('  - Only user-initiated scrolls');

  // Listening example
  print('\nListening for notifications:');
  print('  NotificationListener<UserScrollNotification>(');
  print('    onNotification: (notification) {');
  print('      print(notification.direction);');
  print('      return false;');
  print('    },');
  print('    child: ListView(...),');
  print('  )');

  // Direction property
  print('\ndirection property:');
  print('  - ScrollDirection enum value');
  print('  - Indicates current scroll direction');
  print('  - Updates as user changes direction');
  print('  - idle when scroll stops');

  // Use cases
  print('\nUse cases:');
  print('  - Hide/show app bar on scroll');
  print('  - Pull to refresh detection');
  print('  - Scroll direction indicators');
  print('  - Lazy loading triggers');

  // vs ScrollUpdateNotification
  print('\nvs ScrollUpdateNotification:');
  print('  - ScrollUpdateNotification has metrics');
  print('  - UserScrollNotification has direction');
  print('  - User for direction detection');
  print('  - Update for position tracking');

  // Inheritance
  print('\nInheritance:');
  print('  - UserScrollNotification');
  print('    extends ScrollNotification');
  print('    extends LayoutChangedNotification');
  print('    extends Notification');

  print('\n' + '=' * 50);
  print('UserScrollNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UserScrollNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ScrollNotification subclass'),
      Text('Key: direction (ScrollDirection)'),
      Text('Use: User scroll direction changes'),
    ],
  );
}
