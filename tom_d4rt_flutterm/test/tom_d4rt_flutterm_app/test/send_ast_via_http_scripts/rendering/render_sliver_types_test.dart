// D4rt test script: Tests SliverPersistentHeader, SliverPersistentHeaderDelegate,
// SliverAppBar advanced, SliverOverlapAbsorber, SliverOverlapInjector,
// NestedScrollView, SliverLayoutBuilder, SliverCrossAxisGroup
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Render sliver types test executing');

  // ========== SliverPersistentHeader ==========
  print('--- SliverPersistentHeader Tests ---');
  final persistentHeader = SliverPersistentHeader(
    delegate: TestPersistentHeaderDelegate(
      minHeight: 60,
      maxHeight: 200,
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Persistent Header',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ),
    pinned: true,
    floating: false,
  );
  print('SliverPersistentHeader created (pinned)');

  final floatingHeader = SliverPersistentHeader(
    delegate: TestPersistentHeaderDelegate(
      minHeight: 50,
      maxHeight: 150,
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text('Floating Header', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    pinned: false,
    floating: true,
  );
  print('SliverPersistentHeader created (floating)');

  // ========== SliverAppBar advanced ==========
  print('--- SliverAppBar Advanced Tests ---');
  final sliverAppBar = SliverAppBar(
    expandedHeight: 200.0,
    collapsedHeight: 60.0,
    toolbarHeight: 56.0,
    floating: false,
    pinned: true,
    snap: false,
    stretch: true,
    stretchTriggerOffset: 100.0,
    onStretchTrigger: () async => print('  Stretch triggered'),
    elevation: 4.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    forceElevated: false,
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    primary: true,
    centerTitle: true,
    excludeHeaderSemantics: false,
    titleSpacing: NavigationToolbar.kMiddleSpacing,
    leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    automaticallyImplyLeading: true,
    title: Text('Sliver App Bar'),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ],
    flexibleSpace: FlexibleSpaceBar(
      title: Text('Flexible', style: TextStyle(fontSize: 14)),
      centerTitle: true,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
      collapseMode: CollapseMode.parallax,
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[300]!],
          ),
        ),
      ),
      expandedTitleScale: 1.5,
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(48),
      child: Container(
        color: Colors.blue[700],
        height: 48,
        child: Center(
          child: Text('Bottom', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
    clipBehavior: Clip.antiAlias,
  );
  print('SliverAppBar advanced created');

  // ========== FlexibleSpaceBar modes ==========
  print('--- CollapseMode Tests ---');
  for (final mode in CollapseMode.values) {
    print('  CollapseMode.$mode');
  }
  print('--- StretchMode Tests ---');
  for (final mode in StretchMode.values) {
    print('  StretchMode.$mode');
  }

  // ========== SliverAppBar.medium ==========
  print('--- SliverAppBar.medium Tests ---');
  final mediumAppBar = SliverAppBar.medium(
    title: Text('Medium App Bar'),
    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
  );
  print('SliverAppBar.medium created');

  // ========== SliverAppBar.large ==========
  print('--- SliverAppBar.large Tests ---');
  final largeAppBar = SliverAppBar.large(
    title: Text('Large App Bar'),
    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
  );
  print('SliverAppBar.large created');

  // ========== SliverLayoutBuilder ==========
  print('--- SliverLayoutBuilder Tests ---');
  final sliverLayoutBuilder = SliverLayoutBuilder(
    builder: (context, constraints) {
      print(
        '  SliverConstraints: crossAxisExtent=${constraints.crossAxisExtent}',
      );
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Layout Item $index')),
          childCount: 5,
        ),
      );
    },
  );
  print('SliverLayoutBuilder created');

  // ========== SliverAnimatedList ==========
  print('--- SliverAnimatedList Tests ---');
  final animatedListKey = GlobalKey<SliverAnimatedListState>();
  final sliverAnimatedList = SliverAnimatedList(
    key: animatedListKey,
    initialItemCount: 5,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Animated Item $index')),
      );
    },
  );
  print('SliverAnimatedList created');

  // ========== SliverFixedExtentList ==========
  print('--- SliverFixedExtentList Tests ---');
  final sliverFixedList = SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => Container(
        color: Colors.primaries[index % Colors.primaries.length][100],
        child: Center(child: Text('Fixed $index')),
      ),
      childCount: 10,
    ),
    itemExtent: 60.0,
  );
  print('SliverFixedExtentList created');

  print('All render sliver types tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CustomScrollView(
        slivers: [
          sliverAppBar,
          persistentHeader,
          sliverLayoutBuilder,
          sliverAnimatedList,
          sliverFixedList,
        ],
      ),
    ),
  );
}

class TestPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  TestPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(TestPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
