// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TableRowInkWell from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableRowInkWell test executing');
  print('=' * 50);

  // TableRowInkWell overview
  print('TableRowInkWell overview:');
  print('  - InkWell for DataTable rows');
  print('  - Spans full row width');
  print('  - Extends InkResponse');

  // Test basic TableRowInkWell
  print('\nTest basic TableRowInkWell:');
  final ink1 = TableRowInkWell(
    onTap: () {},
    child: Text('Row Content'),
  );
  print('  Created: ${ink1.runtimeType}');
  print('  Has onTap: ${ink1.onTap != null}');

  // Test with callbacks
  print('\nTest callbacks:');
  final ink2 = TableRowInkWell(
    onTap: () {},
    onDoubleTap: () {},
    onLongPress: () {},
    onHighlightChanged: (v) {},
    child: Text('Interactive Row'),
  );
  print('  Has onTap: ${ink2.onTap != null}');
  print('  Has onDoubleTap: ${ink2.onDoubleTap != null}');
  print('  Has onLongPress: ${ink2.onLongPress != null}');

  // Test overlay colors
  print('\nTest overlay colors via overlayColor:');
  final ink3 = TableRowInkWell(
    onTap: () {},
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return Colors.blue.withAlpha(50);
      if (states.contains(WidgetState.hovered)) return Colors.blue.withAlpha(12);
      return Colors.transparent;
    }),
    child: Text('Colored Row'),
  );
  print('  overlayColor: ${ink3.overlayColor}');
  print('  Responds to pressed/hovered states');

  // Test overlay color
  print('\nTest overlay color:');
  final ink4 = TableRowInkWell(
    onTap: () {},
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return Colors.blue.withAlpha(50);
      return null;
    }),
    child: Text('Overlay Row'),
  );
  print('  Has overlayColor: ${ink4.overlayColor != null}');

  // Usage in DataTable
  print('\nUsage in DataTable:');
  print('  DataTable uses TableRowInkWell internally');
  print('  Wraps each DataRow for tap handling');
  print('  Provides row-level ink effects');

  // Splash behavior
  print('\nSplash behavior:');
  print('  - Rectangular splash');
  print('  - Contained to row bounds');
  print('  - Fades on release');

  // Focus and hover
  print('\nFocus and hover:');
  print('  canRequestFocus: ${ink1.canRequestFocus}');
  print('  mouseCursor adjustable');
  print('  Keyboard accessible');

  print('\n' + '=' * 50);
  print('TableRowInkWell test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableRowInkWell Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: InkResponse subclass'),
      Text('Purpose: DataTable row taps'),
    ],
  );
}
