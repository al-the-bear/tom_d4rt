// ignore_for_file: avoid_print
// D4rt test script: Tests SliverFixedExtentList, SliverFillViewport, SliverPersistentHeader from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverWidgets test executing');

  // Test SliverFixedExtentList
  final fixedExtentSliver = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Fixed extent item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverFixedExtentList(itemExtent: 50.0, childCount: 5) created');

  // Test SliverFixedExtentList with different extent
  final fixedExtent2 = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFixedExtentList(
        itemExtent: 80.0,
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('B', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text('C', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverFixedExtentList(itemExtent: 80.0) with ListDelegate created');

  // Test SliverFillViewport
  final fillViewport = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFillViewport(
        viewportFraction: 1.0,
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Fill Viewport 1',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            color: Colors.purple,
            child: Center(
              child: Text(
                'Fill Viewport 2',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverFillViewport(viewportFraction: 1.0) with 2 children created');

  // Test SliverFillViewport with partial fraction
  final fillViewportPartial = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFillViewport(
        viewportFraction: 0.5,
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: EdgeInsets.all(4.0),
            color: Colors.teal,
            child: Center(child: Text('Half $index')),
          );
        }, childCount: 4),
      ),
    ],
  );
  print('SliverFillViewport(viewportFraction: 0.5) created');

  // SliverPersistentHeader requires a SliverPersistentHeaderDelegate
  // which is abstract and cannot be subclassed in D4rt
  print(
    'SliverPersistentHeader requires SliverPersistentHeaderDelegate (abstract)',
  );
  print(
    'Cannot subclass delegate in D4rt - showing SliverAppBar as alternative',
  );

  // SliverAppBar internally uses SliverPersistentHeader
  final persistentConcept = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverAppBar(
        title: Text('Persistent Header Concept'),
        backgroundColor: Colors.indigo,
        expandedHeight: 80.0,
        floating: true,
        pinned: true,
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: Icon(Icons.label),
            title: Text('Item below header $index'),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverAppBar (uses SliverPersistentHeader internally) created');

  // Test SliverFillRemaining in combination
  final fillRemaining = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.amber,
          child: Center(child: Text('Header content')),
        ),
      ),
      SliverFillRemaining(
        child: Container(
          color: Colors.grey,
          child: Center(child: Text('Fill remaining space')),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverFillRemaining created');

  print('SliverWidgets test completed');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Sliver Widgets Tests'),
        SizedBox(height: 4.0),
        SizedBox(height: 260.0, child: fixedExtentSliver),
        SizedBox(height: 4.0),
        SizedBox(height: 250.0, child: fixedExtent2),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: fillViewport),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: fillViewportPartial),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: persistentConcept),
        SizedBox(height: 4.0),
        SizedBox(height: 150.0, child: fillRemaining),
      ],
    ),
  );
}
