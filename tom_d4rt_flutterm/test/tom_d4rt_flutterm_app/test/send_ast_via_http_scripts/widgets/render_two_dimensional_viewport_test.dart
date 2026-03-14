// D4rt test script: Tests RenderTwoDimensionalViewport from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderTwoDimensionalViewport test executing');

  // RenderTwoDimensionalViewport - Viewport for 2D scrolling (horizontal + vertical)
  // Used by TwoDimensionalScrollView and TableView for grid-like layouts
  
  print('RenderTwoDimensionalViewport characteristics:');
  print('- Scrolls in two dimensions simultaneously');
  print('- Used for large grids and tables');
  print('- Efficient child management via delegate');
  print('- Supports infinite scrolling in both axes');
  
  // Child management
  print('\nChild management:');
  print('- TwoDimensionalChildDelegate: Provides children');
  print('- childDelegateBuilder: Builds children on demand');
  print('- Caches visible children only');
  print('- Manages ChildVicinity for 2D coords');
  
  // ChildVicinity
  print('\nChildVicinity (2D coordinates):');
  print('- xIndex: Column index');
  print('- yIndex: Row index');
  print('- Used to identify children in 2D space');
  
  // Properties
  print('\nKey properties:');
  print('- horizontalOffset: ViewportOffset for horizontal scroll');
  print('- verticalOffset: ViewportOffset for vertical scroll');
  print('- delegate: TwoDimensionalChildDelegate');
  print('- mainAxis: Primary scroll axis');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderTwoDimensionalViewport extends RenderObjectWithChildMixin');
  print('Base class for TableView, TreeView implementations');
  print('Works with TwoDimensionalScrollable');
  
  // Use cases
  print('\nUse cases:');
  print('- Large data grids');
  print('- Spreadsheet-like UIs');
  print('- Calendar views (month/week)');
  print('- Map tile viewers');

  print('\nRenderTwoDimensionalViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderTwoDimensionalViewport Tests'),
      Text('2D scrolling viewport'),
      Text('Grid and table layouts'),
      Text('Horizontal + vertical scroll'),
    ],
  );
}
