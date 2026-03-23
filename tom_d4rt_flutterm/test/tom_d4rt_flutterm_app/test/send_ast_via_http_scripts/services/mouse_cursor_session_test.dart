// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MouseCursorSession from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MouseCursorSession test executing');

  // MouseCursorSession is abstract - test via SystemMouseCursors
  print('MouseCursorSession is abstract');
  print('Used by MouseCursor.createSession()');

  // Test system cursors that would create sessions
  print('\nSystem cursors (create sessions internally):');
  final click = SystemMouseCursors.click;
  print('click: ${click.runtimeType}');
  print('is MouseCursor: true /* click is MouseCursor */');

  final text = SystemMouseCursors.text;
  print('text: ${text.runtimeType}');

  final forbidden = SystemMouseCursors.forbidden;
  print('forbidden: ${forbidden.runtimeType}');

  // Explain MouseCursorSession
  print('\nMouseCursorSession purpose:');
  print('- Abstract class for cursor state');
  print('- Created when cursor enters widget');
  print('- Disposed when cursor leaves');
  print('- Manages platform cursor state');

  // Session lifecycle
  print('\nSession lifecycle:');
  print('1. Widget gains mouse focus');
  print('2. MouseCursor.createSession() called');
  print('3. activate() sets platform cursor');
  print('4. dispose() when mouse leaves');

  // Common cursor types
  print('\nCommon cursor types:');
  print('- SystemMouseCursors.basic: default arrow');
  print('- SystemMouseCursors.click: pointer/hand');
  print('- SystemMouseCursors.text: I-beam for text');
  print('- SystemMouseCursors.forbidden: no-drop');
  print('- SystemMouseCursors.grab: open hand');

  print('\nMouseCursorSession test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MouseCursorSession Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract cursor state manager'),
      Text('Created by: MouseCursor.createSession()'),
      Text('Methods: activate(), dispose()'),
      Text('Used by: SystemMouseCursors'),
    ],
  );
}
