// D4rt test script: Tests SliverHitTestResult from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Test RenderSliver for hit testing
class TestRenderSliver extends RenderSliver {
  final String name;
  TestRenderSliver(this.name);

  @override
  void performLayout() {
    geometry = SliverGeometry(
      scrollExtent: 100.0,
      paintExtent: 100.0,
      maxPaintExtent: 100.0,
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'TestRenderSliver($name)';
}

dynamic build(BuildContext context) {
  print('SliverHitTestResult test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  final hitResult = SliverHitTestResult();
  print('Created SliverHitTestResult: ${hitResult.runtimeType}');
  print('Initial path length: ${hitResult.path.length}');
  results.add('SliverHitTestResult created');

  // ========== Section 2: Adding Entries ==========
  print('--- Section 2: Adding Entries ---');

  final sliver = TestRenderSliver('test-sliver');
  final entry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
  );

  hitResult.add(entry);
  print('After adding entry, path length: ${hitResult.path.length}');
  results.add('Path length after add: ${hitResult.path.length}');

  // ========== Section 3: Path Iteration ==========
  print('--- Section 3: Path Iteration ---');

  final multiResult = SliverHitTestResult();
  final slivers = [
    TestRenderSliver('sliver-1'),
    TestRenderSliver('sliver-2'),
    TestRenderSliver('sliver-3'),
  ];

  for (var i = 0; i < slivers.length; i++) {
    multiResult.add(
      SliverHitTestEntry(
        slivers[i],
        mainAxisPosition: 10.0 * i,
        crossAxisPosition: 5.0 * i,
      ),
    );
  }

  print('Added ${slivers.length} entries');
  print('Path contains:');
  for (final e in multiResult.path) {
    if (e is SliverHitTestEntry) {
      print(
        '  - ${e.target}: main=${e.mainAxisPosition}, cross=${e.crossAxisPosition}',
      );
    }
  }
  results.add('Path iteration: ${multiResult.path.length} entries');

  // ========== Section 4: HitTestResult Base Class ==========
  print('--- Section 4: HitTestResult Base Class ---');

  print('hitResult is HitTestResult: ${hitResult is HitTestResult}');
  results.add('Is HitTestResult: ${hitResult is HitTestResult}');

  // ========== Section 5: First Entry Access ==========
  print('--- Section 5: First Entry Access ---');

  if (hitResult.path.isNotEmpty) {
    final first = hitResult.path.first;
    print('First entry type: ${first.runtimeType}');
    if (first is SliverHitTestEntry) {
      print('First entry mainAxisPosition: ${first.mainAxisPosition}');
      print('First entry crossAxisPosition: ${first.crossAxisPosition}');
    }
  }
  results.add('First entry accessed');

  // ========== Section 6: Multiple Adds ==========
  print('--- Section 6: Multiple Adds ---');

  final accumulatedResult = SliverHitTestResult();

  for (var i = 0; i < 5; i++) {
    accumulatedResult.add(
      SliverHitTestEntry(
        TestRenderSliver('batch-$i'),
        mainAxisPosition: i * 20.0,
        crossAxisPosition: i * 10.0,
      ),
    );
    print('After add $i: path length = ${accumulatedResult.path.length}');
  }
  results.add('Accumulated 5 entries');

  // ========== Section 7: Empty Result Check ==========
  print('--- Section 7: Empty Result Check ---');

  final emptyResult = SliverHitTestResult();
  print('Empty result path.isEmpty: ${emptyResult.path.isEmpty}');
  print('Empty result path.length: ${emptyResult.path.length}');
  results.add('Empty result checked');

  // ========== Section 8: addWithAxisOffset ==========
  print('--- Section 8: addWithAxisOffset ---');

  final axisResult = SliverHitTestResult();
  final testSliver = TestRenderSliver('axis-test');

  axisResult.addWithAxisOffset(
    paintOffset: Offset(10, 20),
    mainAxisOffset: 5.0,
    crossAxisOffset: 2.5,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
    hitTest:
        (
          SliverHitTestResult result, {
          required double mainAxisPosition,
          required double crossAxisPosition,
        }) {
          print('  addWithAxisOffset callback:');
          print('    mainAxisPosition: $mainAxisPosition');
          print('    crossAxisPosition: $crossAxisPosition');
          result.add(
            SliverHitTestEntry(
              testSliver,
              mainAxisPosition: mainAxisPosition,
              crossAxisPosition: crossAxisPosition,
            ),
          );
          return true;
        },
  );

  print('After addWithAxisOffset, path length: ${axisResult.path.length}');
  results.add('addWithAxisOffset tested');

  // ========== Section 9: Wrap from BoxHitTestResult ==========
  print('--- Section 9: Wrap from BoxHitTestResult ---');

  final boxResult = BoxHitTestResult();
  final wrappedResult = SliverHitTestResult.wrap(boxResult);

  print('Wrapped SliverHitTestResult: ${wrappedResult.runtimeType}');
  print('Wrapped result path: ${wrappedResult.path.length}');
  results.add('Wrap from BoxHitTestResult tested');

  // ========== Section 10: Complex Scenario ==========
  print('--- Section 10: Complex Scenario ---');

  final complexResult = SliverHitTestResult();

  // Simulate a nested sliver structure
  final parentSliver = TestRenderSliver('parent');
  final child1 = TestRenderSliver('child-1');
  final child2 = TestRenderSliver('child-2');

  complexResult.add(
    SliverHitTestEntry(
      parentSliver,
      mainAxisPosition: 0.0,
      crossAxisPosition: 0.0,
    ),
  );
  complexResult.add(
    SliverHitTestEntry(child1, mainAxisPosition: 50.0, crossAxisPosition: 0.0),
  );
  complexResult.add(
    SliverHitTestEntry(child2, mainAxisPosition: 100.0, crossAxisPosition: 0.0),
  );

  print('Complex scenario path length: ${complexResult.path.length}');
  print('Hit test path (parent to child):');
  var index = 0;
  for (final e in complexResult.path) {
    if (e is SliverHitTestEntry) {
      print('  [$index] ${e.target}: main=${e.mainAxisPosition}');
      index++;
    }
  }
  results.add('Complex scenario: ${complexResult.path.length} entries');

  // ========== Section 11: Path as Iterable ==========
  print('--- Section 11: Path as Iterable ---');

  final iterableCount = complexResult.path
      .where((e) => e is SliverHitTestEntry)
      .length;
  print('SliverHitTestEntry count in path: $iterableCount');

  final mainAxisSum = complexResult.path
      .whereType<SliverHitTestEntry>()
      .fold<double>(0.0, (sum, e) => sum + e.mainAxisPosition);
  print('Sum of mainAxisPositions: $mainAxisSum');
  results.add('Path iterable operations tested');

  print('SliverHitTestResult test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverHitTestResult Tests',
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
