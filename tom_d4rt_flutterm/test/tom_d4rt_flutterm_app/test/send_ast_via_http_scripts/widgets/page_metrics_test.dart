// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PageMetrics from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageMetrics test executing');
  print('=' * 50);

  // === Test PageMetrics class ===
  print('\nPageMetrics provides PageView scroll metrics');

  // Create PageMetrics
  print('\n--- Testing creation ---');
  final metrics = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 500.0,
    viewportDimension: 400.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 1.0,
    devicePixelRatio: 2.0,
  );
  print('Created PageMetrics');
  print('metrics.runtimeType: ${metrics.runtimeType}');

  // Test inherited properties
  print('\n--- Testing inherited properties ---');
  print('minScrollExtent: ${metrics.minScrollExtent}');
  print('maxScrollExtent: ${metrics.maxScrollExtent}');
  print('pixels: ${metrics.pixels}');
  print('viewportDimension: ${metrics.viewportDimension}');
  print('axisDirection: ${metrics.axisDirection}');

  // Test viewportFraction
  print('\n--- Testing viewportFraction ---');
  print('viewportFraction: ${metrics.viewportFraction}');
  print('Fraction of viewport each page uses');

  // Test page calculation
  print('\n--- Testing page property ---');
  print('page: ${metrics.page}');
  print('Computed from pixels/viewportDimension*viewportFraction');

  // Test copyWith
  print('\n--- Testing copyWith ---');
  final copied = metrics.copyWith(pixels: 800.0);
  print('copied.pixels: ${copied.pixels}');
  print('copied.page: ${copied.page}');
  print('Original unchanged: ${metrics.pixels}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('metrics is FixedScrollMetrics: ${metrics is FixedScrollMetrics}');
  print('metrics is ScrollMetrics: ${metrics is ScrollMetrics}');

  // Test with fractional viewport
  print('\n--- Testing fractional viewport ---');
  final fractionalMetrics = PageMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 2000.0,
    pixels: 500.0,
    viewportDimension: 400.0,
    axisDirection: AxisDirection.right,
    viewportFraction: 0.8,
    devicePixelRatio: 2.0,
  );
  print('With viewportFraction: 0.8');
  print('page: ${fractionalMetrics.page}');

  print('\n' + '=' * 50);
  print('PageMetrics test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PageMetrics Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('page: ${metrics.page?.toStringAsFixed(2)}'),
      Text('viewportFraction: ${metrics.viewportFraction}'),
      Text('Extends: FixedScrollMetrics'),
    ],
  );
}
