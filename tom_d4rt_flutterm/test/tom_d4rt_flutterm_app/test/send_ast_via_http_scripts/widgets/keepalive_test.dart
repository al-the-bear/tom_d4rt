// ignore_for_file: avoid_print
// D4rt test script: Tests KeepAlive and AutomaticKeepAlive concepts from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeepAlive test executing');

  // AutomaticKeepAliveClientMixin requires mixin support which D4rt cannot do
  // KeepAlive is a ParentDataWidget used internally by the framework
  print('AutomaticKeepAliveClientMixin requires mixin - not available in D4rt');
  print('KeepAlive is a ParentDataWidget for internal Sliver keep-alive');

  // Demonstrate the concept with a PageView that preserves state
  // In Flutter, AutomaticKeepAlive wraps children automatically in PageView/TabBarView
  final pageView = SizedBox(
    height: 150.0,
    child: PageView(
      children: [
        Container(
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Page 0',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Text('(kept alive)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Page 1',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Text('(kept alive)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.orange,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Page 2',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Text('(kept alive)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('PageView with 3 pages created (uses AutomaticKeepAlive internally)');

  // KeepAlive widget is used within Sliver context
  // In D4rt, we can demonstrate via CustomScrollView + SliverList
  final sliverKeepAlive = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            height: 50.0,
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Sliver item $index (keep alive concept)',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('CustomScrollView with SliverList (keep alive concept) created');

  // TabBarView also uses AutomaticKeepAlive internally
  final tabKeepAlive = DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Keep 1'),
            Tab(text: 'Keep 2'),
            Tab(text: 'Keep 3'),
          ],
        ),
        SizedBox(
          height: 80.0,
          child: TabBarView(
            children: [
              Center(child: Text('Tab content 1 (kept alive)')),
              Center(child: Text('Tab content 2 (kept alive)')),
              Center(child: Text('Tab content 3 (kept alive)')),
            ],
          ),
        ),
      ],
    ),
  );
  print('TabBarView with 3 tabs created (uses AutomaticKeepAlive internally)');

  print('KeepAlive test completed');
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('KeepAlive / AutomaticKeepAlive Tests'),
          ),
          pageView,
          SizedBox(height: 8.0),
          sliverKeepAlive,
          SizedBox(height: 8.0),
          tabKeepAlive,
        ],
      ),
    ),
  );
}
