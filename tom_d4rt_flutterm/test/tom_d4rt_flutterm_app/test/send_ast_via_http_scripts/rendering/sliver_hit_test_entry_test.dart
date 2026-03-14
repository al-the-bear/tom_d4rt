// D4rt test script: Tests SliverHitTestEntry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Test RenderSliver for hit testing
class TestRenderSliver extends RenderSliver {
  @override
  void performLayout() {
    geometry = SliverGeometry(
      scrollExtent: 100.0,
      paintExtent: 100.0,
      maxPaintExtent: 100.0,
    );
  }
}

dynamic build(BuildContext context) {
  print('SliverHitTestEntry test executing');
  final results = <String>[];

  // ========== Section 1: Create Test RenderSliver ==========
  print('--- Section 1: Create Test RenderSliver ---');

  final sliver = TestRenderSliver();
  print('Created TestRenderSliver: ${sliver.runtimeType}');
  results.add('TestRenderSliver created');

  // ========== Section 2: Create SliverHitTestEntry ==========
  print('--- Section 2: Create SliverHitTestEntry ---');

  final entry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
  );

  print('Created SliverHitTestEntry: ${entry.runtimeType}');
  print('Target: ${entry.target.runtimeType}');
  print('mainAxisPosition: ${entry.mainAxisPosition}');
  print('crossAxisPosition: ${entry.crossAxisPosition}');
  results.add('SliverHitTestEntry created');

  // ========== Section 3: Target Property ==========
  print('--- Section 3: Target Property ---');

  print('entry.target: ${entry.target}');
  print('entry.target is RenderSliver: ${entry.target is RenderSliver}');
  print('entry.target runtimeType: ${entry.target.runtimeType}');
  results.add('Target is RenderSliver: ${entry.target is RenderSliver}');

  // ========== Section 4: Position Properties ==========
  print('--- Section 4: Position Properties ---');

  print('mainAxisPosition: ${entry.mainAxisPosition}');
  print('crossAxisPosition: ${entry.crossAxisPosition}');

  // Create entries with different positions
  final positions = [
    (main: 0.0, cross: 0.0),
    (main: 50.0, cross: 25.0),
    (main: 100.0, cross: 50.0),
    (main: 25.5, cross: 12.75),
  ];

  for (final pos in positions) {
    final testEntry = SliverHitTestEntry(
      sliver,
      mainAxisPosition: pos.main,
      crossAxisPosition: pos.cross,
    );
    print(
      'Entry at (${pos.main}, ${pos.cross}): main=${testEntry.mainAxisPosition}, cross=${testEntry.crossAxisPosition}',
    );
  }
  results.add('Tested ${positions.length} positions');

  // ========== Section 5: HitTestEntry Base Class ==========
  print('--- Section 5: HitTestEntry Base Class ---');

  print('entry is HitTestEntry: ${entry is HitTestEntry}');
  results.add('Is HitTestEntry: ${entry is HitTestEntry}');

  // ========== Section 6: Multiple Entries ==========
  print('--- Section 6: Multiple Entries ---');

  final slivers = [TestRenderSliver(), TestRenderSliver(), TestRenderSliver()];

  final entries = <SliverHitTestEntry>[];
  for (var i = 0; i < slivers.length; i++) {
    entries.add(
      SliverHitTestEntry(
        slivers[i],
        mainAxisPosition: i * 30.0,
        crossAxisPosition: i * 15.0,
      ),
    );
  }

  print('Created ${entries.length} SliverHitTestEntries');
  for (var i = 0; i < entries.length; i++) {
    print(
      '  Entry $i: main=${entries[i].mainAxisPosition}, cross=${entries[i].crossAxisPosition}',
    );
  }
  results.add('Multiple entries: ${entries.length}');

  // ========== Section 7: ToString ==========
  print('--- Section 7: ToString ---');

  print('entry.toString(): ${entry.toString()}');
  results.add('ToString available');

  // ========== Section 8: Negative Positions ==========
  print('--- Section 8: Negative Positions ---');

  final negEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: -10.0,
    crossAxisPosition: -5.0,
  );

  print('Negative positions entry:');
  print('  mainAxisPosition: ${negEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${negEntry.crossAxisPosition}');
  results.add('Negative positions handled');

  // ========== Section 9: Large Positions ==========
  print('--- Section 9: Large Positions ---');

  final largeEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 10000.0,
    crossAxisPosition: 5000.0,
  );

  print('Large positions entry:');
  print('  mainAxisPosition: ${largeEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${largeEntry.crossAxisPosition}');
  results.add('Large positions handled');

  // ========== Section 10: Zero Positions ==========
  print('--- Section 10: Zero Positions ---');

  final zeroEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 0.0,
    crossAxisPosition: 0.0,
  );

  print('Zero positions entry:');
  print('  mainAxisPosition: ${zeroEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${zeroEntry.crossAxisPosition}');
  results.add('Zero positions handled');

  // ========== Section 11: Entry Collection ==========
  print('--- Section 11: Entry Collection ---');

  final result = SliverHitTestResult();
  result.add(entry);

  print('Added entry to SliverHitTestResult');
  print('Result path length: ${result.path.length}');

  final firstInPath = result.path.first;
  print('First entry in path: ${firstInPath.runtimeType}');

  if (firstInPath is SliverHitTestEntry) {
    print('First entry mainAxisPosition: ${firstInPath.mainAxisPosition}');
    print('First entry crossAxisPosition: ${firstInPath.crossAxisPosition}');
  }
  results.add('Entry added to result path');

  print('SliverHitTestEntry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverHitTestEntry Tests',
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
