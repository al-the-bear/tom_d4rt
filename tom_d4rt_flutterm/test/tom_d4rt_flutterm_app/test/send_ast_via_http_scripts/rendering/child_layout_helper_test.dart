// D4rt test script: Tests ChildLayoutHelper from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Helper RenderBox for testing layout
class LayoutTestBox extends RenderBox {
  Size? _requestedSize;
  
  LayoutTestBox({Size? requestedSize}) : _requestedSize = requestedSize;
  
  @override
  void performLayout() {
    size = _requestedSize ?? constraints.biggest;
  }
  
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _requestedSize ?? constraints.biggest;
  }
  
  @override
  double computeMinIntrinsicWidth(double height) => _requestedSize?.width ?? 0;
  
  @override
  double computeMaxIntrinsicWidth(double height) => _requestedSize?.width ?? double.infinity;
  
  @override
  double computeMinIntrinsicHeight(double width) => _requestedSize?.height ?? 0;
  
  @override
  double computeMaxIntrinsicHeight(double width) => _requestedSize?.height ?? double.infinity;
}

dynamic build(BuildContext context) {
  print('ChildLayoutHelper test executing');
  final results = <String>[];

  // ========== Section 1: DryLayoutChild ==========
  print('--- Section 1: DryLayoutChild ---');
  
  final child1 = LayoutTestBox(requestedSize: Size(100, 50));
  final constraints1 = BoxConstraints(maxWidth: 200, maxHeight: 100);
  
  final drySize = ChildLayoutHelper.dryLayoutChild(child1, constraints1);
  print('Dry layout size: $drySize');
  results.add('Dry layout: $drySize');
  
  // ========== Section 2: LayoutChild ==========
  print('--- Section 2: LayoutChild ---');
  
  final child2 = LayoutTestBox(requestedSize: Size(80, 60));
  final constraints2 = BoxConstraints.tight(Size(150, 100));
  
  final layoutSize = ChildLayoutHelper.layoutChild(child2, constraints2);
  print('Layout child size: $layoutSize');
  print('Child hasSize: ${child2.hasSize}');
  results.add('Layout child: $layoutSize');
  
  // ========== Section 3: Constrained Layout ==========
  print('--- Section 3: Constrained Layout ---');
  
  // Test with tight constraints
  final tightChild = LayoutTestBox(requestedSize: Size(200, 200));
  final tightConstraints = BoxConstraints.tight(Size(50, 50));
  
  final tightSize = ChildLayoutHelper.layoutChild(tightChild, tightConstraints);
  print('Tight constrained size: $tightSize');
  results.add('Tight constraints: $tightSize');
  
  // ========== Section 4: Loose Constraints ==========
  print('--- Section 4: Loose Constraints ---');
  
  final looseChild = LayoutTestBox(requestedSize: Size(75, 75));
  final looseConstraints = BoxConstraints.loose(Size(200, 200));
  
  final looseSize = ChildLayoutHelper.layoutChild(looseChild, looseConstraints);
  print('Loose constrained size: $looseSize');
  results.add('Loose constraints: $looseSize');
  
  // ========== Section 5: Expanding Constraints ==========
  print('--- Section 5: Expanding Constraints ---');
  
  final expandChild = LayoutTestBox(); // Will take biggest
  final expandConstraints = BoxConstraints.expand(width: 300, height: 200);
  
  final expandSize = ChildLayoutHelper.layoutChild(expandChild, expandConstraints);
  print('Expand constrained size: $expandSize');
  results.add('Expand constraints: $expandSize');
  
  // ========== Section 6: Min/Max Constraints ==========
  print('--- Section 6: Min/Max Constraints ---');
  
  final minMaxChild = LayoutTestBox(requestedSize: Size(100, 100));
  final minMaxConstraints = BoxConstraints(
    minWidth: 50,
    maxWidth: 150,
    minHeight: 40,
    maxHeight: 120,
  );
  
  final minMaxSize = ChildLayoutHelper.layoutChild(minMaxChild, minMaxConstraints);
  print('Min/Max constrained size: $minMaxSize');
  results.add('Min/Max: $minMaxSize');
  
  // ========== Section 7: Dry Layout Comparison ==========
  print('--- Section 7: Dry Layout Comparison ---');
  
  final compChild = LayoutTestBox(requestedSize: Size(80, 60));
  final compConstraints = BoxConstraints(maxWidth: 100, maxHeight: 80);
  
  final dryResult = ChildLayoutHelper.dryLayoutChild(compChild, compConstraints);
  final layoutResult = ChildLayoutHelper.layoutChild(compChild, compConstraints);
  
  print('Dry result: $dryResult');
  print('Layout result: $layoutResult');
  print('Results match: ${dryResult == layoutResult}');
  results.add('Dry vs Layout match: ${dryResult == layoutResult}');
  
  // ========== Section 8: Zero Constraints ==========
  print('--- Section 8: Zero Constraints ---');
  
  final zeroChild = LayoutTestBox(requestedSize: Size(0, 0));
  final zeroConstraints = BoxConstraints.tight(Size.zero);
  
  final zeroSize = ChildLayoutHelper.layoutChild(zeroChild, zeroConstraints);
  print('Zero constrained size: $zeroSize');
  results.add('Zero constraints: $zeroSize');
  
  // ========== Section 9: Multiple Children ==========
  print('--- Section 9: Multiple Children ---');
  
  final children = [
    LayoutTestBox(requestedSize: Size(50, 30)),
    LayoutTestBox(requestedSize: Size(60, 40)),
    LayoutTestBox(requestedSize: Size(70, 50)),
  ];
  
  final childConstraints = BoxConstraints.loose(Size(100, 100));
  var totalHeight = 0.0;
  
  for (var i = 0; i < children.length; i++) {
    final childSize = ChildLayoutHelper.layoutChild(children[i], childConstraints);
    print('Child $i size: $childSize');
    totalHeight += childSize.height;
  }
  
  results.add('Total height of ${children.length} children: $totalHeight');

  print('ChildLayoutHelper test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ChildLayoutHelper Tests',
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
