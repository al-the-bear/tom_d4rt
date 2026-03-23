// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MouseTrackerAnnotation from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MouseTrackerAnnotation test executing');
  print('=' * 50);

  // Create MouseTrackerAnnotation
  final annotation = MouseTrackerAnnotation(
    onEnter: (event) => print('Mouse entered'),
    onExit: (event) => print('Mouse exited'),
    cursor: SystemMouseCursors.click,
  );
  print('\nMouseTrackerAnnotation created:');
  print('runtimeType: ${annotation.runtimeType}');

  // Properties
  print('\nMouseTrackerAnnotation properties:');
  print('cursor: ${annotation.cursor}');
  print('onEnter: ${annotation.onEnter != null}');
  print('onExit: ${annotation.onExit != null}');
  print('validForMouseTracker: ${annotation.validForMouseTracker}');

  // Callback types
  print('\nCallback types:');
  print('onEnter: PointerEnterEventListener');
  print('onExit: PointerExitEventListener');
  print('onHover: PointerHoverEventListener');

  // Different cursor annotations
  print('\nDifferent cursor examples:');
  final clickAnnotation = MouseTrackerAnnotation(
    cursor: SystemMouseCursors.click,
  );
  final textAnnotation = MouseTrackerAnnotation(
    cursor: SystemMouseCursors.text,
  );
  print('Link cursor: ${clickAnnotation.cursor}');
  print('Text cursor: ${textAnnotation.cursor}');

  // No cursor change
  print('\nNo cursor change:');
  final noCursorChange = MouseTrackerAnnotation(
    cursor: MouseCursor.defer,
  );
  print('cursor: ${noCursorChange.cursor}');
  print('MouseCursor.defer: Inherit from ancestor');

  // Usage in rendering
  print('\nUsage in rendering:');
  print('- Added to Layer during paint');
  print('- MouseTracker collects annotations');
  print('- Triggers callbacks on pointer events');
  print('- Updates cursor from annotations');

  // MouseRegion widget
  print('\nMouseRegion widget (high-level):');
  print('MouseRegion(');
  print('  onEnter: (event) {},');
  print('  onExit: (event) {},');
  print('  onHover: (event) {},');
  print('  cursor: SystemMouseCursors.click,');
  print('  child: widget,');
  print(')');

  // Type hierarchy
  print('\nType hierarchy:');
  print('MouseTrackerAnnotation (low-level)');
  print('  \u2514\u2500 Used by MouseRegion widget');

  // Explain purpose
  print('\nMouseTrackerAnnotation purpose:');
  print('- Low-level mouse tracking annotation');
  print('- onEnter/onExit: Enter/leave region');
  print('- onHover: Pointer movement in region');
  print('- cursor: MouseCursor for region');
  print('- Used with RenderMouseRegion');

  print('\n' + '=' * 50);
  print('MouseTrackerAnnotation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MouseTrackerAnnotation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${annotation.runtimeType}'),
      Text('cursor: ${annotation.cursor}'),
      Text('Has callbacks: true'),
      Text('Purpose: Mouse tracking'),
    ],
  );
}
