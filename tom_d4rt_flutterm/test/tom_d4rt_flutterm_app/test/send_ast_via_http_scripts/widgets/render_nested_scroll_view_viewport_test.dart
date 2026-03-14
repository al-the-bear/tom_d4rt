// D4rt test script: Tests RenderNestedScrollViewViewport through NestedScrollView widget
// RenderNestedScrollViewViewport is the internal render object used by NestedScrollView
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderNestedScrollViewViewport test executing');

  // NestedScrollView creates RenderNestedScrollViewViewport internally
  // We test via the widget API as direct instantiation requires complex setup

  // Track scroll position
  final outerController = ScrollController();
  final innerScrollKey = GlobalKey();

  // Variation 1: Basic NestedScrollView with floating SliverAppBar
  final widget1 = NestedScrollView(
    controller: outerController,
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Floating Header'),
        floating: true,
        forceElevated: innerBoxIsScrolled,
        expandedHeight: 120.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    ],
    body: Builder(
      builder: (context) {
        // Access NestedScrollView internals
        final parentController = PrimaryScrollController.maybeOf(context);
        print('NestedScrollView parent controller: $parentController');
        return ListView.builder(
          key: innerScrollKey,
          itemCount: 20,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
            leading: CircleAvatar(child: Text('$index')),
          ),
        );
      },
    ),
  );
  print('NestedScrollView (floating) created');

  // Variation 2: NestedScrollView with pinned SliverAppBar
  final widget2 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Pinned Header'),
        pinned: true,
        expandedHeight: 150.0,
        backgroundColor: Colors.teal,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Expanded', style: TextStyle(fontSize: 12)),
          background: Container(color: Colors.teal.shade300),
          collapseMode: CollapseMode.parallax,
        ),
      ),
    ],
    body: ListView(
      children: List.generate(
        15,
        (i) => Container(
          height: 60,
          color: i.isEven ? Colors.grey.shade200 : Colors.grey.shade100,
          child: Center(child: Text('Content $i')),
        ),
      ),
    ),
  );
  print('NestedScrollView (pinned) created');

  // Variation 3: NestedScrollView with multiple slivers
  final widget3 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Multi-Sliver'),
        floating: true,
        snap: true,
        backgroundColor: Colors.deepOrange,
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80,
          color: Colors.orange.shade200,
          child: Center(
            child: Text(
              'Secondary Header Section',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: _SliverPersistentHeaderDelegate(
          minHeight: 40,
          maxHeight: 60,
          child: Container(
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text('Persistent Sub-header'),
          ),
        ),
      ),
    ],
    body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(4),
        child: Center(child: Text('Grid $index')),
      ),
    ),
  );
  print('NestedScrollView (multi-sliver) created');

  // Variation 4: NestedScrollView with SliverOverlapAbsorber/Injector
  final widget4 = NestedScrollView(
    floatHeaderSlivers: true,
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          title: Text('Overlap Absorber'),
          floating: true,
          snap: true,
          pinned: false,
          expandedHeight: 100,
          forceElevated: innerBoxIsScrolled,
        ),
      ),
    ],
    body: Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ListTile(title: Text('Overlap Item $index')),
                childCount: 25,
              ),
            ),
          ],
        );
      },
    ),
  );
  print('NestedScrollView (overlap absorber) created');

  // Test scroll physics interaction
  print('Testing scroll physics...');
  // NestedScrollView with custom physics
  final _ = NestedScrollView(
    physics: BouncingScrollPhysics(),
    headerSliverBuilder: (context, _) => [
      SliverAppBar(title: Text('Bouncing'), floating: true),
    ],
    body: ListView(children: [Container(height: 200, color: Colors.cyan)]),
  );
  print('BouncingScrollPhysics applied');

  print('RenderNestedScrollViewViewport test completed');

  // ========== RETURN WIDGET ==========
  return DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        title: Text('RenderNestedScrollViewViewport'),
        bottom: TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: 'Floating'),
            Tab(text: 'Pinned'),
            Tab(text: 'Multi-Sliver'),
            Tab(text: 'Overlap'),
          ],
        ),
      ),
      body: TabBarView(children: [widget1, widget2, widget3, widget4]),
    ),
  );
}

// Helper delegate for SliverPersistentHeader
class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
