// D4rt test script: Tests SliverGridLayout from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Custom implementation of SliverGridLayout for testing
class TestSliverGridLayout extends SliverGridLayout {
  final int columns;
  final double tileWidth;
  final double tileHeight;
  final double spacing;

  TestSliverGridLayout({
    required this.columns,
    required this.tileWidth,
    required this.tileHeight,
    this.spacing = 0.0,
  });

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    final row = (scrollOffset / (tileHeight + spacing)).floor();
    return row * columns;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    final row = (scrollOffset / (tileHeight + spacing)).floor();
    return (row + 1) * columns - 1;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final row = index ~/ columns;
    final col = index % columns;
    return SliverGridGeometry(
      scrollOffset: row * (tileHeight + spacing),
      crossAxisOffset: col * (tileWidth + spacing),
      mainAxisExtent: tileHeight,
      crossAxisExtent: tileWidth,
    );
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    final rows = (childCount + columns - 1) ~/ columns;
    return rows * (tileHeight + spacing) - spacing;
  }
}

dynamic build(BuildContext context) {
  print('SliverGridLayout test executing');
  final results = <String>[];

  // ========== Section 1: SliverGridLayout is Abstract ==========
  print('--- Section 1: SliverGridLayout is Abstract ---');
  
  print('SliverGridLayout is an abstract class');
  print('It defines the interface for grid layouts');
  results.add('SliverGridLayout is abstract');

  // ========== Section 2: Custom Implementation ==========
  print('--- Section 2: Custom Implementation ---');
  
  final layout = TestSliverGridLayout(
    columns: 3,
    tileWidth: 100.0,
    tileHeight: 100.0,
    spacing: 10.0,
  );
  
  print('Created TestSliverGridLayout: ${layout.runtimeType}');
  print('Columns: ${layout.columns}');
  print('Tile size: ${layout.tileWidth} x ${layout.tileHeight}');
  print('Spacing: ${layout.spacing}');
  results.add('Custom layout: ${layout.columns} columns');

  // ========== Section 3: getMinChildIndexForScrollOffset ==========
  print('--- Section 3: getMinChildIndexForScrollOffset ---');
  
  final scrollOffsets = [0.0, 50.0, 110.0, 220.0, 500.0];
  
  for (final offset in scrollOffsets) {
    final minIndex = layout.getMinChildIndexForScrollOffset(offset);
    print('Scroll offset $offset -> minChildIndex: $minIndex');
  }
  results.add('getMinChildIndexForScrollOffset tested');

  // ========== Section 4: getMaxChildIndexForScrollOffset ==========
  print('--- Section 4: getMaxChildIndexForScrollOffset ---');
  
  for (final offset in scrollOffsets) {
    final maxIndex = layout.getMaxChildIndexForScrollOffset(offset);
    print('Scroll offset $offset -> maxChildIndex: $maxIndex');
  }
  results.add('getMaxChildIndexForScrollOffset tested');

  // ========== Section 5: getGeometryForChildIndex ==========
  print('--- Section 5: getGeometryForChildIndex ---');
  
  for (var i = 0; i < 9; i++) {
    final geometry = layout.getGeometryForChildIndex(i);
    print('Child $i: scroll=${geometry.scrollOffset}, cross=${geometry.crossAxisOffset}');
  }
  results.add('getGeometryForChildIndex tested');

  // ========== Section 6: computeMaxScrollOffset ==========
  print('--- Section 6: computeMaxScrollOffset ---');
  
  final childCounts = [1, 3, 4, 6, 9, 12];
  
  for (final count in childCounts) {
    final maxScroll = layout.computeMaxScrollOffset(count);
    print('$count children -> maxScrollOffset: $maxScroll');
  }
  results.add('computeMaxScrollOffset tested');

  // ========== Section 7: Different Grid Configurations ==========
  print('--- Section 7: Different Grid Configurations ---');
  
  final layout2Col = TestSliverGridLayout(
    columns: 2,
    tileWidth: 150.0,
    tileHeight: 150.0,
    spacing: 5.0,
  );
  print('2-column layout:');
  for (var i = 0; i < 6; i++) {
    final geo = layout2Col.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('2-column layout tested');
  
  final layout4Col = TestSliverGridLayout(
    columns: 4,
    tileWidth: 80.0,
    tileHeight: 80.0,
    spacing: 8.0,
  );
  print('4-column layout:');
  for (var i = 0; i < 8; i++) {
    final geo = layout4Col.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('4-column layout tested');

  // ========== Section 8: SliverGridDelegate Integration ==========
  print('--- Section 8: SliverGridDelegate Integration ---');
  
  // SliverGridDelegate creates SliverGridLayout
  final delegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
  );
  
  print('Delegate type: ${delegate.runtimeType}');
  print('Delegate crossAxisCount: ${delegate.crossAxisCount}');
  print('Delegate mainAxisSpacing: ${delegate.mainAxisSpacing}');
  print('Delegate crossAxisSpacing: ${delegate.crossAxisSpacing}');
  
  // Get layout from delegate
  final delegateLayout = delegate.getLayout(SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.idle,
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    overlap: 0.0,
    remainingPaintExtent: 600.0,
    crossAxisExtent: 360.0,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 600.0,
    remainingCacheExtent: 800.0,
    cacheOrigin: 0.0,
  ));
  
  print('Layout from delegate: ${delegateLayout.runtimeType}');
  results.add('SliverGridDelegate integration tested');

  // ========== Section 9: No Spacing Layout ==========
  print('--- Section 9: No Spacing Layout ---');
  
  final noSpacingLayout = TestSliverGridLayout(
    columns: 3,
    tileWidth: 100.0,
    tileHeight: 100.0,
    spacing: 0.0,
  );
  
  print('No spacing layout:');
  for (var i = 0; i < 6; i++) {
    final geo = noSpacingLayout.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('No spacing layout tested');

  // ========== Section 10: Type Checking ==========
  print('--- Section 10: Type Checking ---');
  
  print('layout is SliverGridLayout: ${layout is SliverGridLayout}');
  print('delegateLayout is SliverGridLayout: ${delegateLayout is SliverGridLayout}');
  results.add('Type checking verified');

  print('SliverGridLayout test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SliverGridLayout Tests',
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
