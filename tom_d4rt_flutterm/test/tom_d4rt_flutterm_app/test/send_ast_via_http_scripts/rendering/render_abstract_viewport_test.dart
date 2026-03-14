// D4rt test script: Tests RenderAbstractViewport from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAbstractViewport test executing');

  // ========== VIEWPORT CONCEPTS ==========
  print('--- RenderAbstractViewport Concepts ---');
  print('RenderAbstractViewport is the abstract base class for viewport render objects');
  print('It provides the interface for scrollable regions');
  print('Concrete implementations: RenderViewport, RenderShrinkWrappingViewport');

  // ========== SCROLL DIRECTION TESTS ==========
  print('--- Scroll Direction ---');
  print('AxisDirection.down: ${AxisDirection.down}');
  print('AxisDirection.up: ${AxisDirection.up}');
  print('AxisDirection.right: ${AxisDirection.right}');
  print('AxisDirection.left: ${AxisDirection.left}');

  // ========== VIEWPORT OFFSET TESTS ==========
  print('--- ViewportOffset Tests ---');

  // Create ScrollController to test viewport behavior
  final scrollController = ScrollController(initialScrollOffset: 100.0);
  print('ScrollController created with initialScrollOffset: ${scrollController.initialScrollOffset}');

  // ========== SINGLE CHILD SCROLL VIEW ==========
  print('--- SingleChildScrollView (uses RenderViewport concepts) ---');

  final verticalScroll = SingleChildScrollView(
    controller: scrollController,
    scrollDirection: Axis.vertical,
    child: Column(
      children: List.generate(20, (i) => Container(
        height: 50,
        color: i.isEven ? Colors.blue : Colors.green,
        child: Center(child: Text('Item $i')),
      )),
    ),
  );
  print('Created vertical SingleChildScrollView');
  print('  scrollDirection: Axis.vertical');

  final horizontalScroll = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(10, (i) => Container(
        width: 80,
        height: 60,
        color: i.isEven ? Colors.red : Colors.orange,
        child: Center(child: Text('H$i')),
      )),
    ),
  );
  print('Created horizontal SingleChildScrollView');
  print('  scrollDirection: Axis.horizontal');

  // ========== LIST VIEW (USES VIEWPORT) ==========
  print('--- ListView (uses RenderViewport) ---');

  final listView = SizedBox(
    height: 150,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => ListTile(
        title: Text('List Item $index'),
        leading: Icon(Icons.star),
      ),
    ),
  );
  print('Created ListView.builder with 50 items');
  print('  ListView uses RenderViewport internally');

  // ========== GRID VIEW (USES VIEWPORT) ==========
  print('--- GridView (uses RenderViewport) ---');

  final gridView = SizedBox(
    height: 150,
    child: GridView.count(
      crossAxisCount: 3,
      children: List.generate(12, (i) => Container(
        color: Colors.primaries[i % Colors.primaries.length],
        child: Center(child: Text('G$i')),
      )),
    ),
  );
  print('Created GridView.count with 3 columns');
  print('  crossAxisCount: 3');

  // ========== CUSTOM SCROLL VIEW ==========
  print('--- CustomScrollView (direct viewport access) ---');

  final customScroll = SizedBox(
    height: 200,
    child: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Sliver App Bar'),
          floating: true,
          flexibleSpace: Container(color: Colors.purple),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              height: 40,
              color: index.isEven ? Colors.cyan : Colors.teal,
              child: Center(child: Text('Sliver Item $index')),
            ),
            childCount: 15,
          ),
        ),
      ],
    ),
  );
  print('Created CustomScrollView with SliverAppBar and SliverList');

  // ========== CACHE EXTENT ==========
  print('--- Cache Extent ---');
  print('CacheExtentStyle.pixel: items cached by fixed pixel distance');
  print('CacheExtentStyle.viewport: items cached by viewport multiplier');
  print('Default cacheExtent is typically 250.0 logical pixels');

  // ========== VIEWPORT STATIC METHODS ==========
  print('--- RenderAbstractViewport Static Methods ---');
  print('RenderAbstractViewport.of(RenderObject): finds nearest viewport');
  print('Used for scroll-to-visible functionality');

  // ========== REVEALED OFFSET ==========
  print('--- RevealedOffset Class ---');
  final revealedOffset = RevealedOffset(offset: 100.0, rect: Rect.fromLTWH(0, 100, 50, 50));
  print('RevealedOffset: offset=${revealedOffset.offset}');
  print('  rect=${revealedOffset.rect}');

  // ========== SHRINK WRAPPING VIEWPORT ==========
  print('--- ShrinkWrappingViewport ---');
  print('Used when viewport should size itself to content');
  print('Common in nested scrollable scenarios');

  final shrinkWrap = SizedBox(
    height: 100,
    child: ListView(
      shrinkWrap: true,
      children: [
        Text('ShrinkWrap Item 1'),
        Text('ShrinkWrap Item 2'),
        Text('ShrinkWrap Item 3'),
      ],
    ),
  );
  print('Created shrinkWrap ListView');

  // ========== AXIS DIRECTION UTILITIES ==========
  print('--- Axis Direction Utilities ---');
  print('axisDirectionToAxis(AxisDirection.down): ${axisDirectionToAxis(AxisDirection.down)}');
  print('axisDirectionToAxis(AxisDirection.right): ${axisDirectionToAxis(AxisDirection.right)}');
  print('axisDirectionIsReversed(AxisDirection.up): ${axisDirectionIsReversed(AxisDirection.up)}');
  print('axisDirectionIsReversed(AxisDirection.down): ${axisDirectionIsReversed(AxisDirection.down)}');

  print('RenderAbstractViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbstractViewport Tests'),
      SizedBox(height: 8),
      SizedBox(height: 80, child: verticalScroll),
      SizedBox(height: 8),
      SizedBox(height: 60, child: horizontalScroll),
      SizedBox(height: 8),
      listView,
      SizedBox(height: 8),
      gridView,
      SizedBox(height: 8),
      Text('All Viewport tests passed'),
    ],
  );
}
