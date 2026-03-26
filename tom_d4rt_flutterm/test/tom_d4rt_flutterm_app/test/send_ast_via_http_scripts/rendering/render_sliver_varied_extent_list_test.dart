// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverVariedExtentList from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderSliverVariedExtentList test executing');
  print('=' * 50);

  // RenderSliverVariedExtentList is concrete
  print('\nRenderSliverVariedExtentList:');
  print('Extends: RenderSliverFixedExtentBoxAdaptor');
  print('Purpose: Sliver list where each child has a different extent');

  // Constructor
  print('\nConstructor:');
  print('  RenderSliverVariedExtentList({');
  print('    required RenderSliverBoxChildManager childManager,');
  print('    required ItemExtentBuilder itemExtentBuilder,');
  print('  })');

  // ItemExtentBuilder
  print('\nItemExtentBuilder:');
  print('  typedef ItemExtentBuilder =');
  print('    double Function(int index, SliverLayoutDimensions dimensions)');
  print('  Called for each item to determine its extent');
  print('  Can return different heights per index');

  // Key properties
  print('\nKey properties:');
  print('  itemExtentBuilder - The builder function for extents');
  print('  itemExtent - Always null (varied, not fixed)');

  // Advantage over SliverList
  print('\nAdvantage over RenderSliverList:');
  print('  SliverList: Lays out children to measure them');
  print('  VariedExtentList: Knows extents before layout');
  print('  Result: Can jump to any index without laying out all items');
  print('  Enables efficient scrollToIndex operations');

  // SliverLayoutDimensions
  print('\nSliverLayoutDimensions provides:');
  print('  scrollOffset - Current scroll position');
  print('  precedingScrollExtent - Extent before this sliver');
  print('  viewportMainAxisExtent - Viewport size');
  print('  crossAxisExtent - Available cross-axis space');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('SliverVariedExtentList.builder(');
  print('  itemExtentBuilder: (index, dimensions) {');
  print('    return index.isEven ? 50.0 : 100.0;');
  print('  },');
  print('  itemBuilder: (context, index) {');
  print('    return ListTile(title: Text("Item \$index"));');
  print('  },');
  print('  itemCount: 100,');
  print(');');

  // Comparison
  print('\nExtent list comparison:');
  print('  RenderSliverFixedExtentList: All items same height');
  print('  RenderSliverVariedExtentList: Each item different height');
  print('  Both know extent before layout (fast scrolling)');

  print('\n${'=' * 50}');
  print('RenderSliverVariedExtentList test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderSliverVariedExtentList Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: RenderSliverFixedExtentBoxAdaptor'),
      Text('Key: ItemExtentBuilder per item'),
      Text('Widget: SliverVariedExtentList'),
    ],
  );
}
