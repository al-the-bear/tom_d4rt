// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollIncrementDetails from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollIncrementDetails test executing');
  print('=' * 50);

  // ScrollIncrementDetails holds info for increment calculation
  print('\nScrollIncrementDetails Analysis:');
  print('  Type: class');
  print('  Purpose: Details for ScrollIncrementCalculator');
  print('  Contains: increment type and scroll metrics');

  // Create mock metrics
  final metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 200.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 2.0,
  );

  // Create with line type
  print('\nConstruction with Line Type:');
  final lineDetails = ScrollIncrementDetails(
    type: ScrollIncrementType.line,
    metrics: metrics,
  );
  print('  Type: ${lineDetails.type}');
  print('  Metrics type: ${lineDetails.metrics.runtimeType}');
  print('  Pixels: ${lineDetails.metrics.pixels}');
  print('  Viewport: ${lineDetails.metrics.viewportDimension}');

  // Create with page type
  print('\nConstruction with Page Type:');
  final pageDetails = ScrollIncrementDetails(
    type: ScrollIncrementType.page,
    metrics: metrics,
  );
  print('  Type: ${pageDetails.type}');
  print('  Same metrics: ${pageDetails.metrics.pixels}');

  // Properties
  print('\nProperties:');
  print('  type: ScrollIncrementType');
  print('    - Indicates line or page scroll');
  print('  metrics: ScrollMetrics');
  print('    - Current scroll metrics');

  // ScrollIncrementCalculator typedef
  print('\nScrollIncrementCalculator:');
  print('  typedef ScrollIncrementCalculator =');
  print('    double Function(ScrollIncrementDetails details)');
  print('  Set on: Scrollable.incrementCalculator');

  // Default calculations
  print('\nDefault Calculations:');
  print('  Line: 50.0 logical pixels');
  print('  Page: 0.8 * viewportDimension');
  print('  For this metrics:');
  print('    Line default: 50.0');
  print('    Page default: ${0.8 * metrics.viewportDimension}');

  // Usage pattern
  print('\nUsage Pattern:');
  print('  ScrollAction uses ScrollIncrementDetails to:');
  print('  1. Check if custom incrementCalculator exists');
  print('  2. If yes, call it with details');
  print('  3. If no, use default calculation');

  print('\n' + '=' * 50);
  print('ScrollIncrementDetails test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollIncrementDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Line type: ${lineDetails.type}'),
      Text('Page type: ${pageDetails.type}'),
      Text('Viewport: ${metrics.viewportDimension}'),
    ],
  );
}
