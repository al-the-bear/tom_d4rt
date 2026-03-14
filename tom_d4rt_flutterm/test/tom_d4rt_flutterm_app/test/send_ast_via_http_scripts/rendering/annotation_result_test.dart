// D4rt test script: Tests AnnotationResult from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' show Offset;

dynamic build(BuildContext context) {
  print('AnnotationResult test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // Create empty AnnotationResult
  final emptyResult = AnnotationResult<String>();
  print('Created empty AnnotationResult<String>');
  print('Initial entries count: ${emptyResult.entries.length}');
  results.add('Empty result entries: ${emptyResult.entries.length}');

  // ========== Section 2: Adding Entries ==========
  print('--- Section 2: Adding Entries ---');

  final result = AnnotationResult<int>();

  // Add annotation entries manually via layer
  final layer1 = AnnotatedRegionLayer<int>(42, size: Size(100, 100));
  layer1.findAnnotations<int>(result, Offset(50, 50), onlyFirst: false);

  print('After adding via layer: ${result.entries.length} entries');
  results.add('Added entry via layer: ${result.entries.length} entries');

  // ========== Section 3: Accessing Entries ==========
  print('--- Section 3: Accessing Entries ---');

  if (result.entries.isNotEmpty) {
    final firstEntry = result.entries.first;
    print('First entry annotation: ${firstEntry.annotation}');
    print('First entry local position: ${firstEntry.localPosition}');
    results.add('First entry annotation: ${firstEntry.annotation}');
  }

  // ========== Section 4: Multiple Annotations ==========
  print('--- Section 4: Multiple Annotations ---');

  final multiResult = AnnotationResult<String>();

  // Create multiple layers and find annotations
  final container = ContainerLayer();
  final strLayer1 = AnnotatedRegionLayer<String>('first', size: Size(100, 100));
  final strLayer2 = AnnotatedRegionLayer<String>(
    'second',
    size: Size(100, 100),
  );

  container.append(strLayer1);
  container.append(strLayer2);

  // Find all string annotations at a point
  strLayer1.findAnnotations<String>(
    multiResult,
    Offset(50, 50),
    onlyFirst: false,
  );
  strLayer2.findAnnotations<String>(
    multiResult,
    Offset(50, 50),
    onlyFirst: false,
  );

  print('Multiple annotations found: ${multiResult.entries.length}');
  for (var entry in multiResult.entries) {
    print('  - ${entry.annotation}');
  }
  results.add('Multiple annotations: ${multiResult.entries.length}');

  // ========== Section 5: Typed Results ==========
  print('--- Section 5: Typed Results ---');

  // Test with different types
  final doubleResult = AnnotationResult<double>();
  final doubleLayer = AnnotatedRegionLayer<double>(3.14159, size: Size(50, 50));
  doubleLayer.findAnnotations<double>(
    doubleResult,
    Offset(25, 25),
    onlyFirst: false,
  );

  print('Double result entries: ${doubleResult.entries.length}');
  if (doubleResult.entries.isNotEmpty) {
    print('Double value: ${doubleResult.entries.first.annotation}');
    results.add('Double annotation: ${doubleResult.entries.first.annotation}');
  }

  // ========== Section 6: Entry Iteration ==========
  print('--- Section 6: Entry Iteration ---');

  final iterResult = AnnotationResult<int>();
  for (var i = 0; i < 3; i++) {
    final layer = AnnotatedRegionLayer<int>(i * 10, size: Size(100, 100));
    layer.findAnnotations<int>(iterResult, Offset(50, 50), onlyFirst: false);
  }

  print('Iterating ${iterResult.entries.length} entries:');
  final annotations = <int>[];
  for (var entry in iterResult.entries) {
    annotations.add(entry.annotation);
    print('  Annotation: ${entry.annotation}');
  }
  results.add('Iteration test: values=${annotations.join(", ")}');

  // ========== Section 7: OnlyFirst Flag ==========
  print('--- Section 7: OnlyFirst Flag ---');

  final onlyFirstResult = AnnotationResult<String>();
  final stopLayer = AnnotatedRegionLayer<String>(
    'stop-here',
    size: Size(100, 100),
  );

  final shouldStop = stopLayer.findAnnotations<String>(
    onlyFirstResult,
    Offset(50, 50),
    onlyFirst: true,
  );
  print('Should stop after first: $shouldStop');
  print('Entries in onlyFirst result: ${onlyFirstResult.entries.length}');
  results.add(
    'OnlyFirst result: $shouldStop, entries: ${onlyFirstResult.entries.length}',
  );

  print('AnnotationResult test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AnnotationResult Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
