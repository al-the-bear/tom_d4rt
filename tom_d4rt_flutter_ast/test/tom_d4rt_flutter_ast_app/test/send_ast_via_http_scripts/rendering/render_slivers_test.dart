// ignore_for_file: avoid_print
// D4rt test script: RenderSliver, RenderSliverGrid, RenderSliverList,
// RenderSliverOpacity, RenderSliverPadding, SliverGridDelegate,
// SliverGridParentData, RenderViewport (rendering, addtests1).
//
// RenderSliver is abstract; RenderSliverList and RenderSliverGrid need a
// RenderSliverBoxChildManager, which only an element of a sliver widget
// provides, so the script reaches those two through the CustomScrollView it
// builds and names them in type positions. The rest are constructed directly.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('=== slivers ===');
  final padding = RenderSliverPadding(padding: const EdgeInsets.all(4));
  print('sliver padding: ${padding.padding}');
  final opacity = RenderSliverOpacity(opacity: 0.5, sliver: padding);
  print('sliver opacity: ${opacity.opacity}');
  final RenderSliver child = opacity.child!;
  print('opacity child is padding: ${identical(child, padding)}');

  const SliverGridDelegate delegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
  );
  final layout = delegate.getLayout(
    const SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.idle,
      scrollOffset: 0,
      precedingScrollExtent: 0,
      overlap: 0,
      remainingPaintExtent: 600,
      crossAxisExtent: 300,
      crossAxisDirection: AxisDirection.right,
      viewportMainAxisExtent: 600,
      remainingCacheExtent: 600,
      cacheOrigin: 0,
    ),
  );
  print(
    'grid layout min child for 150: ${layout.getMinChildIndexForScrollOffset(150)}',
  );

  final gridData = SliverGridParentData()..crossAxisOffset = 100;
  print('grid parent data cross offset: ${gridData.crossAxisOffset}');

  final viewport = RenderViewport(
    crossAxisDirection: AxisDirection.right,
    offset: ViewportOffset.zero(),
    children: [RenderSliverPadding(padding: const EdgeInsets.all(2))],
  );
  print('viewport axis: ${viewport.axisDirection}');
  print('viewport has center: ${viewport.center != null}');
  print('viewport children: ${viewport.childCount}');

  // Type positions: the render objects the sliver widgets below create.
  final List<Type> sliverRenderTypes = [RenderSliverList, RenderSliverGrid];
  print('sliver render types: ${sliverRenderTypes.length}');
  return CustomScrollView(
    slivers: [
      SliverList.list(children: const [Text('one'), Text('two')]),
      SliverGrid.count(
        crossAxisCount: 2,
        children: const [Text('a'), Text('b')],
      ),
    ],
  );
}
