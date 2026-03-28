// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PerformanceOverlayOption from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlayOption test executing');
  print('=' * 50);

  // PerformanceOverlayOption enum overview
  print('PerformanceOverlayOption enum overview:');
  print('  - Performance overlay display options');
  print('  - Shows frame timing info');
  print('  - 4 values for graphs and checkerboard');

  // Enumerate all values
  print('\nPerformanceOverlayOption values:');
  for (final value in PerformanceOverlayOption.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('PerformanceOverlayOption has ${PerformanceOverlayOption.values.length} values');

  // Test displayRasterizerStatistics
  print('\nTest PerformanceOverlayOption.displayRasterizerStatistics:');
  final rasterizer = PerformanceOverlayOption.displayRasterizerStatistics;
  print('  Name: ${rasterizer.name}');
  print('  Shows: GPU rasterization stats');

  // Test visualizeRasterizerStatistics
  print('\nTest PerformanceOverlayOption.visualizeRasterizerStatistics:');
  final visualizeRaster = PerformanceOverlayOption.visualizeRasterizerStatistics;
  print('  Name: ${visualizeRaster.name}');
  print('  Shows: Visual graph of GPU');

  // Test displayEngineStatistics
  print('\nTest PerformanceOverlayOption.displayEngineStatistics:');
  final engine = PerformanceOverlayOption.displayEngineStatistics;
  print('  Name: ${engine.name}');
  print('  Shows: Engine frame times');

  // Test visualizeEngineStatistics
  print('\nTest PerformanceOverlayOption.visualizeEngineStatistics:');
  final visualizeEngine = PerformanceOverlayOption.visualizeEngineStatistics;
  print('  Name: ${visualizeEngine.name}');
  print('  Shows: Visual graph of engine');

  // First and last
  print('\nFirst and last:');
  print('  First: ${PerformanceOverlayOption.values.first}');
  print('  Last: ${PerformanceOverlayOption.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  PerformanceOverlay widget');
  print('  MaterialApp.showPerformanceOverlay');
  print('  Debug builds');

  // Performance debugging
  print('\nPerformance debugging:');
  print('  Identify jank frames');
  print('  GPU vs CPU bottlenecks');

  // Switch pattern
  print('\nSwitch pattern:');
  final option = PerformanceOverlayOption.displayRasterizerStatistics;
  switch (option) {
    case PerformanceOverlayOption.displayRasterizerStatistics:
      print('  Showing GPU stats');
      break;
    case PerformanceOverlayOption.visualizeRasterizerStatistics: 
      print('  Showing GPU graph');
      break;
    case PerformanceOverlayOption.displayEngineStatistics:
      print('  Showing engine stats');
      break;
    case PerformanceOverlayOption.visualizeEngineStatistics:
      print('  Showing engine graph');
      break;
  }

  print('\n' + '=' * 50);
  print('PerformanceOverlayOption test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PerformanceOverlayOption Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: 4 display/visualize options'),
      Text('Purpose: Performance debugging'),
    ],
  );
}
