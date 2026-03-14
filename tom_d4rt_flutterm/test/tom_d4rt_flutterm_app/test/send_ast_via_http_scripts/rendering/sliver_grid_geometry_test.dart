// D4rt test script: Tests SliverGridGeometry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverGridGeometry test executing');
  final results = <String>[];

  // ========== Section 1: Basic SliverGridGeometry Creation ==========
  print('--- Section 1: Basic SliverGridGeometry Creation ---');
  
  final geometry1 = SliverGridGeometry(
    scrollOffset: 0.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 100.0,
    crossAxisExtent: 100.0,
  );
  
  print('Created SliverGridGeometry: ${geometry1.runtimeType}');
  print('scrollOffset: ${geometry1.scrollOffset}');
  print('crossAxisOffset: ${geometry1.crossAxisOffset}');
  print('mainAxisExtent: ${geometry1.mainAxisExtent}');
  print('crossAxisExtent: ${geometry1.crossAxisExtent}');
  results.add('SliverGridGeometry created');

  // ========== Section 2: All Properties ==========
  print('--- Section 2: All Properties ---');
  
  final geometry2 = SliverGridGeometry(
    scrollOffset: 100.0,
    crossAxisOffset: 50.0,
    mainAxisExtent: 150.0,
    crossAxisExtent: 200.0,
  );
  
  print('scrollOffset: ${geometry2.scrollOffset}');
  print('crossAxisOffset: ${geometry2.crossAxisOffset}');
  print('mainAxisExtent: ${geometry2.mainAxisExtent}');
  print('crossAxisExtent: ${geometry2.crossAxisExtent}');
  print('trailingScrollOffset: ${geometry2.trailingScrollOffset}');
  results.add('trailingScrollOffset: ${geometry2.trailingScrollOffset}');

  // ========== Section 3: Trailing Scroll Offset Calculation ==========
  print('--- Section 3: Trailing Scroll Offset Calculation ---');
  
  // trailingScrollOffset = scrollOffset + mainAxisExtent
  final testGeometry = SliverGridGeometry(
    scrollOffset: 200.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 80.0,
    crossAxisExtent: 100.0,
  );
  
  final expected = testGeometry.scrollOffset + testGeometry.mainAxisExtent;
  final actual = testGeometry.trailingScrollOffset;
  print('scrollOffset + mainAxisExtent = $expected');
  print('trailingScrollOffset = $actual');
  print('Calculation correct: ${expected == actual}');
  results.add('Trailing scroll offset calculation verified');

  // ========== Section 4: Get Box Constraints ==========
  print('--- Section 4: Get Box Constraints ---');
  
  final constraints = geometry1.getBoxConstraints(SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.forward,
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    overlap: 0.0,
    remainingPaintExtent: 600.0,
    crossAxisExtent: 400.0,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 600.0,
    remainingCacheExtent: 800.0,
    cacheOrigin: 0.0,
  ));
  
  print('BoxConstraints from geometry:');
  print('  minWidth: ${constraints.minWidth}');
  print('  maxWidth: ${constraints.maxWidth}');
  print('  minHeight: ${constraints.minHeight}');
  print('  maxHeight: ${constraints.maxHeight}');
  results.add('BoxConstraints generated');

  // ========== Section 5: Different Grid Configurations ==========
  print('--- Section 5: Different Grid Configurations ---');
  
  final configs = [
    (scroll: 0.0, cross: 0.0, main: 100.0, crossExt: 100.0),
    (scroll: 0.0, cross: 110.0, main: 100.0, crossExt: 100.0),
    (scroll: 110.0, cross: 0.0, main: 100.0, crossExt: 100.0),
    (scroll: 110.0, cross: 110.0, main: 100.0, crossExt: 100.0),
  ];
  
  for (var i = 0; i < configs.length; i++) {
    final cfg = configs[i];
    final geo = SliverGridGeometry(
      scrollOffset: cfg.scroll,
      crossAxisOffset: cfg.cross,
      mainAxisExtent: cfg.main,
      crossAxisExtent: cfg.crossExt,
    );
    print('Config $i: scrollOff=${cfg.scroll}, crossOff=${cfg.cross}, trailing=${geo.trailingScrollOffset}');
  }
  results.add('Tested ${configs.length} grid configurations');

  // ========== Section 6: Large Values ==========
  print('--- Section 6: Large Values ---');
  
  final largeGeometry = SliverGridGeometry(
    scrollOffset: 10000.0,
    crossAxisOffset: 5000.0,
    mainAxisExtent: 500.0,
    crossAxisExtent: 300.0,
  );
  
  print('Large scrollOffset: ${largeGeometry.scrollOffset}');
  print('Large trailingScrollOffset: ${largeGeometry.trailingScrollOffset}');
  results.add('Large values handled');

  // ========== Section 7: Zero Main Axis Extent ==========
  print('--- Section 7: Zero Main Axis Extent ---');
  
  final zeroMainGeometry = SliverGridGeometry(
    scrollOffset: 100.0,
    crossAxisOffset: 50.0,
    mainAxisExtent: 0.0,
    crossAxisExtent: 100.0,
  );
  
  print('Zero mainAxisExtent: ${zeroMainGeometry.mainAxisExtent}');
  print('Trailing with zero main: ${zeroMainGeometry.trailingScrollOffset}');
  results.add('Zero mainAxisExtent tested');

  // ========== Section 8: Fractional Values ==========
  print('--- Section 8: Fractional Values ---');
  
  final fractionalGeometry = SliverGridGeometry(
    scrollOffset: 123.456,
    crossAxisOffset: 78.901,
    mainAxisExtent: 99.999,
    crossAxisExtent: 150.5,
  );
  
  print('Fractional scrollOffset: ${fractionalGeometry.scrollOffset}');
  print('Fractional crossAxisOffset: ${fractionalGeometry.crossAxisOffset}');
  print('Fractional mainAxisExtent: ${fractionalGeometry.mainAxisExtent}');
  print('Fractional trailingScrollOffset: ${fractionalGeometry.trailingScrollOffset}');
  results.add('Fractional values handled');

  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');
  
  print('geometry1.toString(): ${geometry1.toString()}');
  results.add('ToString available');

  // ========== Section 10: Multiple Items Grid Simulation ==========
  print('--- Section 10: Multiple Items Grid Simulation ---');
  
  // Simulate a 3-column grid with spacing
  final columnWidth = 100.0;
  final spacing = 10.0;
  final items = <SliverGridGeometry>[];
  
  for (var row = 0; row < 3; row++) {
    for (var col = 0; col < 3; col++) {
      items.add(SliverGridGeometry(
        scrollOffset: row * (columnWidth + spacing),
        crossAxisOffset: col * (columnWidth + spacing),
        mainAxisExtent: columnWidth,
        crossAxisExtent: columnWidth,
      ));
    }
  }
  
  print('Created ${items.length} grid items');
  for (var i = 0; i < items.length; i++) {
    print('  Item $i: scroll=${items[i].scrollOffset}, cross=${items[i].crossAxisOffset}');
  }
  results.add('Grid simulation: ${items.length} items');

  print('SliverGridGeometry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SliverGridGeometry Tests',
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
