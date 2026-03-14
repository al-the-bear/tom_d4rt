// D4rt test script: Tests BoxHitTestEntry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Simple test RenderBox for hit testing
class TestRenderBox extends RenderBox {
  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (size.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}

dynamic build(BuildContext context) {
  print('BoxHitTestEntry test executing');
  final results = <String>[];

  // ========== Section 1: Create Test RenderBox ==========
  print('--- Section 1: Create Test RenderBox ---');

  final renderBox = TestRenderBox();
  // Simulate layout
  renderBox.layout(BoxConstraints.tight(Size(200, 100)));

  print('Created TestRenderBox with size: ${renderBox.size}');
  results.add('RenderBox size: ${renderBox.size}');

  // ========== Section 2: Create BoxHitTestEntry ==========
  print('--- Section 2: Create BoxHitTestEntry ---');

  final localPosition = Offset(50, 30);
  final entry = BoxHitTestEntry(renderBox, localPosition);

  print('Created BoxHitTestEntry');
  print('Entry target: ${entry.target.runtimeType}');
  print('Entry localPosition: ${entry.localPosition}');
  results.add('Entry localPosition: ${entry.localPosition}');

  // ========== Section 3: Target Properties ==========
  print('--- Section 3: Target Properties ---');

  // Access the target (RenderBox)
  final target = entry.target;
  print('Target type: ${target.runtimeType}');
  print('Target is RenderBox: ${target is RenderBox}');
  results.add('Target is RenderBox: ${target is RenderBox}');

  // ========== Section 4: Local Position ==========
  print('--- Section 4: Local Position ---');

  // Test different local positions
  final positions = [Offset(0, 0), Offset(100, 50), Offset(199, 99)];

  for (final pos in positions) {
    final testEntry = BoxHitTestEntry(renderBox, pos);
    print('Entry at $pos: localPosition=${testEntry.localPosition}');
  }
  results.add('Tested ${positions.length} positions');

  // ========== Section 5: Hit Test Via RenderBox ==========
  print('--- Section 5: Hit Test Via RenderBox ---');

  final hitResult = BoxHitTestResult();
  final hitPosition = Offset(75, 25);

  final wasHit = renderBox.hitTest(hitResult, position: hitPosition);
  print('Hit test at $hitPosition: $wasHit');
  print('Result path length: ${hitResult.path.length}');

  if (hitResult.path.isNotEmpty) {
    final firstEntry = hitResult.path.first;
    print('First entry in path: ${firstEntry.runtimeType}');
    if (firstEntry is BoxHitTestEntry) {
      print('BoxHitTestEntry localPosition: ${firstEntry.localPosition}');
      results.add('Hit test entry position: ${firstEntry.localPosition}');
    }
  }

  // ========== Section 6: Outside Hit Test ==========
  print('--- Section 6: Outside Hit Test ---');

  final outsideResult = BoxHitTestResult();
  final outsidePosition = Offset(300, 200); // Outside the box

  final outsideHit = renderBox.hitTest(
    outsideResult,
    position: outsidePosition,
  );
  print('Hit test outside box at $outsidePosition: $outsideHit');
  print('Outside result path length: ${outsideResult.path.length}');
  results.add('Outside hit test: $outsideHit');

  // ========== Section 7: Entry ToString ==========
  print('--- Section 7: Entry ToString ---');

  final stringEntry = BoxHitTestEntry(renderBox, Offset(10, 20));
  final entryString = stringEntry.toString();
  print('Entry toString: $entryString');
  results.add('Entry has toString: ${entryString.isNotEmpty}');

  // ========== Section 8: Multiple Entries ==========
  print('--- Section 8: Multiple Entries ---');

  final multiResult = BoxHitTestResult();

  // Create multiple boxes
  final box1 = TestRenderBox()..layout(BoxConstraints.tight(Size(100, 100)));
  final box2 = TestRenderBox()..layout(BoxConstraints.tight(Size(100, 100)));

  box1.hitTest(multiResult, position: Offset(50, 50));
  box2.hitTest(multiResult, position: Offset(50, 50));

  print('Multiple hit test path length: ${multiResult.path.length}');
  var boxEntryCount = 0;
  for (final e in multiResult.path) {
    if (e is BoxHitTestEntry) {
      boxEntryCount++;
      print('  BoxHitTestEntry #$boxEntryCount: ${e.localPosition}');
    }
  }
  results.add('Multiple entries: $boxEntryCount BoxHitTestEntries');

  print('BoxHitTestEntry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BoxHitTestEntry Tests',
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
