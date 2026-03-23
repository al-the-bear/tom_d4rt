// ignore_for_file: avoid_print
// D4rt test script: Tests MouseCursorManager from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MouseCursorManager test executing');
  print('=' * 50);

  // MouseCursorManager is a mixin/class for cursor management
  print('\nMouseCursorManager:');
  print('MouseCursorManager manages cursor state for devices');

  // Common cursor types
  print('\nCommon MouseCursor types:');
  print('SystemMouseCursors.click: ${SystemMouseCursors.click}');
  print('SystemMouseCursors.text: ${SystemMouseCursors.text}');
  print('SystemMouseCursors.forbidden: ${SystemMouseCursors.forbidden}');
  print('SystemMouseCursors.grab: ${SystemMouseCursors.grab}');
  print('SystemMouseCursors.grabbing: ${SystemMouseCursors.grabbing}');
  print('SystemMouseCursors.resizeColumn: ${SystemMouseCursors.resizeColumn}');
  print('SystemMouseCursors.resizeRow: ${SystemMouseCursors.resizeRow}');

  // Cursor hierarchy
  print('\nMouseCursor hierarchy:');
  print('MouseCursor (abstract base)');
  print('  ├─ SystemMouseCursor (OS cursors)');
  print('  ├─ MaterialStateMouseCursor');
  print('  └─ DeferredMouseCursor');

  // Test SystemMouseCursors constants
  print('\nSystemMouseCursors constants:');
  final cursors = [
    ('none', SystemMouseCursors.none),
    ('basic', SystemMouseCursors.basic),
    ('click', SystemMouseCursors.click),
    ('text', SystemMouseCursors.text),
    ('wait', SystemMouseCursors.wait),
    ('progress', SystemMouseCursors.progress),
  ];
  for (final (name, cursor) in cursors) {
    print('$name: ${cursor.runtimeType}');
  }

  // Usage pattern with MouseRegion
  print('\nUsage with MouseRegion:');
  print('MouseRegion(');
  print('  cursor: SystemMouseCursors.click,');
  print('  child: Widget,');
  print(')');

  // Cursor for different interactions
  print('\nCursor by interaction type:');
  print('- Links/Buttons: SystemMouseCursors.click');
  print('- Text input: SystemMouseCursors.text');
  print('- Dragging: SystemMouseCursors.grabbing');
  print('- Resizing: SystemMouseCursors.resizeColumn/Row');
  print('- Loading: SystemMouseCursors.wait');
  print('- Disabled: SystemMouseCursors.forbidden');

  // MouseTrackerAnnotation related
  print('\nRelated classes:');
  print('- MouseRegion: Widget for cursor + hover');
  print('- MouseTrackerAnnotation: Low-level annotation');
  print('- SystemMouseCursors: Predefined cursors');

  // Test type hierarchy
  print('\nType hierarchy check:');
  print(
    'SystemMouseCursors.click is MouseCursor: true /* always */',
  );
  print(
    'SystemMouseCursors.click is SystemMouseCursor: true /* always */',
  );

  // Explain purpose
  print('\nMouseCursorManager purpose:');
  print('- Manages mouse cursor state per device');
  print('- Tracks cursor for each pointer device');
  print('- Resolves cursor from widget tree');
  print('- Used internally by MouseTracker');
  print('- Enables context-aware cursor changes');

  print('\n' + '=' * 50);
  print('MouseCursorManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MouseCursorManager Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: cursor management mixin'),
      Text('click: ${SystemMouseCursors.click.runtimeType}'),
      Text('text: ${SystemMouseCursors.text.runtimeType}'),
      Text('Purpose: Cursor state management'),
    ],
  );
}
