// D4rt test script: Tests SliverLayoutDimensions from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLayoutDimensions test executing');
  final results = <String>[];

  // ========== Section 1: Basic SliverLayoutDimensions Creation ==========
  print('--- Section 1: Basic SliverLayoutDimensions Creation ---');

  final dimensions1 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  print('Created SliverLayoutDimensions: ${dimensions1.runtimeType}');
  print('scrollOffset: ${dimensions1.scrollOffset}');
  print('precedingScrollExtent: ${dimensions1.precedingScrollExtent}');
  print('viewportMainAxisExtent: ${dimensions1.viewportMainAxisExtent}');
  print('crossAxisExtent: ${dimensions1.crossAxisExtent}');
  results.add('Basic creation: scrollOffset=100.0');

  // ========== Section 2: Zero Values ==========
  print('--- Section 2: Zero Values ---');

  final zeroDimensions = SliverLayoutDimensions(
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    viewportMainAxisExtent: 0.0,
    crossAxisExtent: 0.0,
  );
  print('Zero dimensions scrollOffset: ${zeroDimensions.scrollOffset}');
  print(
    'Zero dimensions precedingScrollExtent: ${zeroDimensions.precedingScrollExtent}',
  );
  print(
    'Zero dimensions viewportMainAxisExtent: ${zeroDimensions.viewportMainAxisExtent}',
  );
  print('Zero dimensions crossAxisExtent: ${zeroDimensions.crossAxisExtent}');
  results.add('Zero values tested');

  // ========== Section 3: Large Values ==========
  print('--- Section 3: Large Values ---');

  final largeDimensions = SliverLayoutDimensions(
    scrollOffset: 10000.0,
    precedingScrollExtent: 5000.0,
    viewportMainAxisExtent: 2000.0,
    crossAxisExtent: 1500.0,
  );
  print('Large scrollOffset: ${largeDimensions.scrollOffset}');
  print(
    'Large precedingScrollExtent: ${largeDimensions.precedingScrollExtent}',
  );
  print(
    'Large viewportMainAxisExtent: ${largeDimensions.viewportMainAxisExtent}',
  );
  print('Large crossAxisExtent: ${largeDimensions.crossAxisExtent}');
  results.add('Large values: scrollOffset=10000.0');

  // ========== Section 4: Various Scroll Offsets ==========
  print('--- Section 4: Various Scroll Offsets ---');

  final scrollOffsets = [0.0, 50.0, 100.0, 250.0, 500.0, 1000.0];
  for (final offset in scrollOffsets) {
    final dims = SliverLayoutDimensions(
      scrollOffset: offset,
      precedingScrollExtent: 0.0,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: 400.0,
    );
    print('Dimensions with scrollOffset $offset: ${dims.scrollOffset}');
  }
  results.add('Tested ${scrollOffsets.length} scroll offsets');

  // ========== Section 5: Various Preceding Scroll Extents ==========
  print('--- Section 5: Various Preceding Scroll Extents ---');

  final precedingExtents = [0.0, 100.0, 200.0, 500.0, 1000.0];
  for (final extent in precedingExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: extent,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: 400.0,
    );
    print(
      'Dimensions with precedingScrollExtent $extent: ${dims.precedingScrollExtent}',
    );
  }
  results.add('Tested ${precedingExtents.length} preceding extents');

  // ========== Section 6: Various Viewport Main Axis Extents ==========
  print('--- Section 6: Various Viewport Main Axis Extents ---');

  final viewportExtents = [100.0, 300.0, 600.0, 800.0, 1200.0];
  for (final extent in viewportExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: 50.0,
      viewportMainAxisExtent: extent,
      crossAxisExtent: 400.0,
    );
    print(
      'Dimensions with viewportMainAxisExtent $extent: ${dims.viewportMainAxisExtent}',
    );
  }
  results.add('Tested ${viewportExtents.length} viewport extents');

  // ========== Section 7: Various Cross Axis Extents ==========
  print('--- Section 7: Various Cross Axis Extents ---');

  final crossAxisExtents = [200.0, 300.0, 400.0, 500.0, 800.0];
  for (final extent in crossAxisExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: 50.0,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: extent,
    );
    print('Dimensions with crossAxisExtent $extent: ${dims.crossAxisExtent}');
  }
  results.add('Tested ${crossAxisExtents.length} cross axis extents');

  // ========== Section 8: Equality Comparison ==========
  print('--- Section 8: Equality Comparison ---');

  final dims1 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  final dims2 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  final dims3 = SliverLayoutDimensions(
    scrollOffset: 200.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  print('dims1 == dims2: ${dims1 == dims2}');
  print('dims1 == dims3: ${dims1 == dims3}');
  print(
    'dims1.hashCode == dims2.hashCode: ${dims1.hashCode == dims2.hashCode}',
  );
  results.add('Equality: same=${dims1 == dims2}, different=${dims1 == dims3}');

  // ========== Section 9: Runtime Type Check ==========
  print('--- Section 9: Runtime Type Check ---');

  print('dimensions1.runtimeType: ${dimensions1.runtimeType}');
  print('Is SliverLayoutDimensions: ${dimensions1 is SliverLayoutDimensions}');
  results.add('Runtime type verified');

  print('SliverLayoutDimensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLayoutDimensions Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
