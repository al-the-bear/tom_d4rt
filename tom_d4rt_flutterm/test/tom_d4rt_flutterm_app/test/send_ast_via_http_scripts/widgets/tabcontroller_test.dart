// ignore_for_file: avoid_print
// D4rt test script: Tests TabController via DefaultTabController from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabController test executing');

  // TabController requires a TickerProvider (vsync), so it cannot be
  // constructed standalone in D4rt. Use DefaultTabController instead.
  print('TabController requires TickerProvider - use DefaultTabController');

  // Test DefaultTabController with TabBar and TabBarView
  final tabWidget1 = DefaultTabController(
    length: 3,
    child: Builder(
      builder: (innerContext) {
        final controller = DefaultTabController.of(innerContext);
        print('DefaultTabController.of(context) accessed');
        print('TabController length: ${controller.length}');
        print('TabController index: ${controller.index}');
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Tab 1', icon: Icon(Icons.home)),
                Tab(text: 'Tab 2', icon: Icon(Icons.star)),
                Tab(text: 'Tab 3', icon: Icon(Icons.settings)),
              ],
            ),
            SizedBox(
              height: 100.0,
              child: TabBarView(
                children: [
                  Center(child: Text('Content 1')),
                  Center(child: Text('Content 2')),
                  Center(child: Text('Content 3')),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
  print('DefaultTabController(length: 3) with TabBar + TabBarView created');

  // Test DefaultTabController with initialIndex
  final tabWidget2 = DefaultTabController(
    length: 4,
    initialIndex: 2,
    child: Builder(
      builder: (innerContext) {
        final controller = DefaultTabController.of(innerContext);
        print('DefaultTabController(length: 4, initialIndex: 2) accessed');
        print('TabController index: ${controller.index}');
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(text: 'A'),
                Tab(text: 'B'),
                Tab(text: 'C'),
                Tab(text: 'D'),
              ],
            ),
            SizedBox(
              height: 80.0,
              child: TabBarView(
                children: [
                  Center(child: Text('Panel A')),
                  Center(child: Text('Panel B')),
                  Center(child: Text('Panel C')),
                  Center(child: Text('Panel D')),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
  print('DefaultTabController(length: 4, initialIndex: 2) created');

  // Test Tab widget individually
  final tab1 = Tab(text: 'Simple Tab');
  print('Tab(text: Simple Tab) created');

  final tab2 = Tab(icon: Icon(Icons.favorite), text: 'Fav');
  print('Tab(icon: favorite, text: Fav) created');

  final tab3 = Tab(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(Icons.info), SizedBox(width: 4.0), Text('Custom')],
    ),
  );
  print('Tab with custom child created');

  print('TabController test completed');
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Text('TabController Tests'),
          SizedBox(height: 8.0),
          tabWidget1,
          SizedBox(height: 16.0),
          tabWidget2,
        ],
      ),
    ),
  );
}
