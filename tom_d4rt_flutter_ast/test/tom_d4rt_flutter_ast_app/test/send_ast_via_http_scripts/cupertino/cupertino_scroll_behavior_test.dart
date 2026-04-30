// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoScrollBehavior from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoScrollBehavior test executing');

  // ===== 1. Default constructor =====
  print('--- Default CupertinoScrollBehavior ---');
  final defaultBehavior = CupertinoScrollBehavior();
  print('  created: ${defaultBehavior.runtimeType}');

  // ===== 2. copyWith variations =====
  print('--- copyWith ---');
  final withScrollbars = defaultBehavior.copyWith(scrollbars: false);
  print('  copyWith(scrollbars: false) type: ${withScrollbars.runtimeType}');

  final withOverscroll = defaultBehavior.copyWith(
    overscroll: false,
  );
  print('  copyWith(overscroll: false) type: ${withOverscroll.runtimeType}');

  final combinedCopy = defaultBehavior.copyWith(
    scrollbars: true,
    overscroll: true,
  );
  print('  combined copyWith type: ${combinedCopy.runtimeType}');

  // ===== 3. Applied to a ScrollView =====
  print('--- Applied to ScrollView ---');
  final scrollItems = <Widget>[];
  for (var i = 0; i < 30; i++) {
    scrollItems.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Text('Scroll item $i'),
      ),
    );
  }

  // ===== 4. getScrollPhysics returns BouncingScrollPhysics =====
  print('--- getScrollPhysics ---');
  final physics = defaultBehavior.getScrollPhysics(context);
  print('  physics type: ${physics.runtimeType}');

  // ===== 5. Multiple scrollable areas with same behavior =====
  print('--- Multiple scrollable areas ---');
  final listView1 = ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      for (var i = 0; i < 5; i++)
        CupertinoListTile(title: Text('List 1 item $i')),
    ],
  );
  final listView2 = ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      for (var i = 0; i < 5; i++)
        CupertinoListTile(title: Text('List 2 item $i')),
    ],
  );
  print('  two list views created');

  // ===== 6. buildOverscrollIndicator =====
  print('--- buildOverscrollIndicator ---');
  final testChild = SizedBox(height: 100.0, child: Text('Test child'));
  final indicator = defaultBehavior.buildOverscrollIndicator(
    context,
    testChild,
    ScrollableDetails(
      direction: AxisDirection.down,
      controller: ScrollController(),
    ),
  );
  print('  overscroll indicator type: ${indicator.runtimeType}');

  print('CupertinoScrollBehavior test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ScrollBehavior')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ScrollBehavior Tests', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text('Default: ${defaultBehavior.runtimeType}'),
                    Text('Physics: ${physics.runtimeType}'),
                    Text('Indicator: ${indicator.runtimeType}'),
                  ],
                ),
              ),
              listView1,
              SizedBox(height: 8.0),
              listView2,
            ],
          ),
        ),
      ),
    ),
  );
}
