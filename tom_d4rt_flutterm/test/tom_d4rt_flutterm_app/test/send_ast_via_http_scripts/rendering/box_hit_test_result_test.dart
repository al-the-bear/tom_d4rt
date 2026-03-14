// D4rt test script: Tests BoxHitTestResult from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Test RenderBox for hit testing
class SimpleRenderBox extends RenderBox {
  final String name;
  SimpleRenderBox(this.name);
  
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
  
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) => 'SimpleRenderBox($name)';
}

dynamic build(BuildContext context) {
  print('BoxHitTestResult test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');
  
  final hitResult = BoxHitTestResult();
  print('Created BoxHitTestResult');
  print('Initial path length: ${hitResult.path.length}');
  results.add('Initial path length: ${hitResult.path.length}');
  
  // ========== Section 2: Adding Entries ==========
  print('--- Section 2: Adding Entries ---');
  
  final box = SimpleRenderBox('test-box');
  box.layout(BoxConstraints.tight(Size(100, 100)));
  
  hitResult.add(BoxHitTestEntry(box, Offset(50, 50)));
  print('After adding entry, path length: ${hitResult.path.length}');
  results.add('Path length after add: ${hitResult.path.length}');
  
  // ========== Section 3: Path Iteration ==========
  print('--- Section 3: Path Iteration ---');
  
  final multiResult = BoxHitTestResult();
  final boxes = [
    SimpleRenderBox('box-1')..layout(BoxConstraints.tight(Size(100, 100))),
    SimpleRenderBox('box-2')..layout(BoxConstraints.tight(Size(100, 100))),
    SimpleRenderBox('box-3')..layout(BoxConstraints.tight(Size(100, 100))),
  ];
  
  for (var i = 0; i < boxes.length; i++) {
    multiResult.add(BoxHitTestEntry(boxes[i], Offset(10.0 * i, 10.0 * i)));
  }
  
  print('Added ${boxes.length} entries');
  print('Path contains:');
  for (final entry in multiResult.path) {
    if (entry is BoxHitTestEntry) {
      print('  - ${entry.target}: ${entry.localPosition}');
    }
  }
  results.add('Path iteration: ${multiResult.path.length} entries');
  
  // ========== Section 4: Using hitTest Method ==========
  print('--- Section 4: Using hitTest Method ---');
  
  final directResult = BoxHitTestResult();
  final targetBox = SimpleRenderBox('target');
  targetBox.layout(BoxConstraints.tight(Size(200, 150)));
  
  final hit = targetBox.hitTest(directResult, position: Offset(100, 75));
  print('Hit test returned: $hit');
  print('Direct result path: ${directResult.path.length}');
  results.add('Direct hitTest: hit=$hit, entries=${directResult.path.length}');
  
  // ========== Section 5: Transform Methods ==========
  print('--- Section 5: Transform Methods ---');
  
  final transformResult = BoxHitTestResult();
  final transformBox = SimpleRenderBox('transformed');
  transformBox.layout(BoxConstraints.tight(Size(100, 100)));
  
  // Push a transform onto the result
  final transform = Matrix4.identity()..translate(50.0, 50.0);
  
  transformResult.addWithPaintTransform(
    transform: transform,
    position: Offset(75, 75),
    hitTest: (BoxHitTestResult result, Offset position) {
      print('  Transformed position: $position');
      result.add(BoxHitTestEntry(transformBox, position));
      return true;
    },
  );
  
  print('Transform result path: ${transformResult.path.length}');
  results.add('Transform test: ${transformResult.path.length} entries');
  
  // ========== Section 6: Offset Transform ==========
  print('--- Section 6: Offset Transform ---');
  
  final offsetResult = BoxHitTestResult();
  final offsetBox = SimpleRenderBox('offset-box');
  offsetBox.layout(BoxConstraints.tight(Size(100, 100)));
  
  offsetResult.addWithPaintOffset(
    offset: Offset(20, 30),
    position: Offset(70, 80),
    hitTest: (BoxHitTestResult result, Offset position) {
      print('  Offset-adjusted position: $position');
      result.add(BoxHitTestEntry(offsetBox, position));
      return true;
    },
  );
  
  print('Offset result path: ${offsetResult.path.length}');
  results.add('Offset transform: ${offsetResult.path.length} entries');
  
  // ========== Section 7: Raw Offset ==========
  print('--- Section 7: Raw Offset Transform ---');
  
  final rawResult = BoxHitTestResult();
  final rawBox = SimpleRenderBox('raw-box');
  rawBox.layout(BoxConstraints.tight(Size(100, 100)));
  
  rawResult.addWithRawTransform(
    transform: Matrix4.identity(),
    position: Offset(50, 50),
    hitTest: (BoxHitTestResult result, Offset position) {
      result.add(BoxHitTestEntry(rawBox, position));
      return true;
    },
  );
  
  print('Raw transform result: ${rawResult.path.length}');
  results.add('Raw transform: ${rawResult.path.length} entries');
  
  // ========== Section 8: First Entry Access ==========
  print('--- Section 8: First Entry Access ---');
  
  final accessResult = BoxHitTestResult();
  final accessBox = SimpleRenderBox('access-box');
  accessBox.layout(BoxConstraints.tight(Size(50, 50)));
  accessBox.hitTest(accessResult, position: Offset(25, 25));
  
  if (accessResult.path.isNotEmpty) {
    final first = accessResult.path.first;
    print('First entry type: ${first.runtimeType}');
    if (first is BoxHitTestEntry) {
      print('First entry position: ${first.localPosition}');
      results.add('First entry position: ${first.localPosition}');
    }
  }

  print('BoxHitTestResult test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('BoxHitTestResult Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
