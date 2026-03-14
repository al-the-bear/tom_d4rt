// D4rt test script: Tests SliverGridRegularTileLayout from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverGridRegularTileLayout test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic Creation ---');
  
  final layout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );
  
  print('Created SliverGridRegularTileLayout: ${layout.runtimeType}');
  print('crossAxisCount: ${layout.crossAxisCount}');
  print('mainAxisStride: ${layout.mainAxisStride}');
  print('crossAxisStride: ${layout.crossAxisStride}');
  print('childMainAxisExtent: ${layout.childMainAxisExtent}');
  print('childCrossAxisExtent: ${layout.childCrossAxisExtent}');
  print('reverseCrossAxis: ${layout.reverseCrossAxis}');
  results.add('SliverGridRegularTileLayout created');

  // ========== Section 2: Type Checking ==========
  print('--- Section 2: Type Checking ---');
  
  print('layout is SliverGridLayout: ${layout is SliverGridLayout}');
  results.add('Is SliverGridLayout: ${layout is SliverGridLayout}');

  // ========== Section 3: getMinChildIndexForScrollOffset ==========
  print('--- Section 3: getMinChildIndexForScrollOffset ---');
  
  final scrollOffsets = [0.0, 50.0, 110.0, 220.0, 330.0, 500.0];
  
  for (final offset in scrollOffsets) {
    final minIndex = layout.getMinChildIndexForScrollOffset(offset);
    print('Scroll $offset -> minChildIndex: $minIndex');
  }
  results.add('getMinChildIndexForScrollOffset tested');

  // ========== Section 4: getMaxChildIndexForScrollOffset ==========
  print('--- Section 4: getMaxChildIndexForScrollOffset ---');
  
  for (final offset in scrollOffsets) {
    final maxIndex = layout.getMaxChildIndexForScrollOffset(offset);
    print('Scroll $offset -> maxChildIndex: $maxIndex');
  }
  results.add('getMaxChildIndexForScrollOffset tested');

  // ========== Section 5: getGeometryForChildIndex ==========
  print('--- Section 5: getGeometryForChildIndex ---');
  
  for (var i = 0; i < 9; i++) {
    final geometry = layout.getGeometryForChildIndex(i);
    final row = i ~/ 3;
    final col = i % 3;
    print('Child $i (row=$row, col=$col): scroll=${geometry.scrollOffset}, cross=${geometry.crossAxisOffset}');
  }
  results.add('getGeometryForChildIndex tested for 9 items');

  // ========== Section 6: computeMaxScrollOffset ==========
  print('--- Section 6: computeMaxScrollOffset ---');
  
  final childCounts = [1, 3, 4, 6, 9, 10, 12, 15];
  
  for (final count in childCounts) {
    final maxScroll = layout.computeMaxScrollOffset(count);
    final rows = (count + 2) ~/ 3;
    print('$count children ($rows rows) -> maxScrollOffset: $maxScroll');
  }
  results.add('computeMaxScrollOffset tested');

  // ========== Section 7: Different Column Counts ==========
  print('--- Section 7: Different Column Counts ---');
  
  final layout2Col = SliverGridRegularTileLayout(
    crossAxisCount: 2,
    mainAxisStride: 120.0,
    crossAxisStride: 160.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 150.0,
    reverseCrossAxis: false,
  );
  
  print('2-column layout:');
  for (var i = 0; i < 6; i++) {
    final geo = layout2Col.getGeometryForChildIndex(i);
    print('  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}');
  }
  results.add('2-column layout tested');
  
  final layout4Col = SliverGridRegularTileLayout(
    crossAxisCount: 4,
    mainAxisStride: 85.0,
    crossAxisStride: 85.0,
    childMainAxisExtent: 80.0,
    childCrossAxisExtent: 80.0,
    reverseCrossAxis: false,
  );
  
  print('4-column layout:');
  for (var i = 0; i < 8; i++) {
    final geo = layout4Col.getGeometryForChildIndex(i);
    print('  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}');
  }
  results.add('4-column layout tested');

  // ========== Section 8: Reverse Cross Axis ==========
  print('--- Section 8: Reverse Cross Axis ---');
  
  final reversedLayout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: true,
  );
  
  print('Reversed cross axis layout:');
  for (var i = 0; i < 6; i++) {
    final normal = layout.getGeometryForChildIndex(i);
    final reversed = reversedLayout.getGeometryForChildIndex(i);
    print('  Item $i: normal cross=${normal.crossAxisOffset}, reversed cross=${reversed.crossAxisOffset}');
  }
  results.add('Reverse cross axis tested');

  // ========== Section 9: No Spacing (Stride equals Extent) ==========
  print('--- Section 9: No Spacing ---');
  
  final noSpacingLayout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 100.0,
    crossAxisStride: 100.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );
  
  print('No spacing layout (stride == extent):');
  for (var i = 0; i < 6; i++) {
    final geo = noSpacingLayout.getGeometryForChildIndex(i);
    print('  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}');
  }
  results.add('No spacing layout tested');

  // ========== Section 10: Large Spacing ==========
  print('--- Section 10: Large Spacing ---');
  
  final largeSpacingLayout = SliverGridRegularTileLayout(
    crossAxisCount: 2,
    mainAxisStride: 200.0,  // 100 spacing
    crossAxisStride: 200.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );
  
  print('Large spacing layout (100px spacing):');
  for (var i = 0; i < 4; i++) {
    final geo = largeSpacingLayout.getGeometryForChildIndex(i);
    print('  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}');
  }
  print('Max scroll for 4 items: ${largeSpacingLayout.computeMaxScrollOffset(4)}');
  results.add('Large spacing layout tested');

  // ========== Section 11: Single Column ==========
  print('--- Section 11: Single Column ---');
  
  final singleColLayout = SliverGridRegularTileLayout(
    crossAxisCount: 1,
    mainAxisStride: 110.0,
    crossAxisStride: 300.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 300.0,
    reverseCrossAxis: false,
  );
  
  print('Single column layout:');
  for (var i = 0; i < 5; i++) {
    final geo = singleColLayout.getGeometryForChildIndex(i);
    print('  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}');
  }
  results.add('Single column layout tested');

  print('SliverGridRegularTileLayout test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SliverGridRegularTileLayout Tests',
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
