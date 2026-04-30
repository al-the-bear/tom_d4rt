// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UnderlineTabIndicator, TabBarIndicatorSize,
// TabAlignment, Tab widget advanced
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tab indicator test executing');

  // ========== UnderlineTabIndicator ==========
  print('--- UnderlineTabIndicator Tests ---');
  final indicator = UnderlineTabIndicator(
    borderSide: BorderSide(color: Colors.blue, width: 3.0),
    borderRadius: BorderRadius.circular(2.0),
    insets: EdgeInsets.symmetric(horizontal: 16.0),
  );
  print('UnderlineTabIndicator created: $indicator');
  print('  borderSide width: 3.0');

  // ========== TabBarIndicatorSize ==========
  print('--- TabBarIndicatorSize Tests ---');
  for (final size in TabBarIndicatorSize.values) {
    print('TabBarIndicatorSize: ${size.name}');
  }

  // ========== TabAlignment ==========
  print('--- TabAlignment Tests ---');
  for (final align in TabAlignment.values) {
    print('TabAlignment: ${align.name}');
  }

  // ========== Tab widget ==========
  print('--- Tab Tests ---');
  final tab1 = Tab(text: 'Tab 1', icon: Icon(Icons.home));
  print('Tab with text and icon created');

  final tab2 = Tab(text: 'Tab 2', iconMargin: EdgeInsets.only(bottom: 4.0));
  print('Tab with iconMargin created');

  final tab3 = Tab(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: 16),
        SizedBox(width: 4),
        Text('Custom'),
      ],
    ),
  );
  print('Tab with custom child created: $tab3');

  // ========== TabController ==========
  print('--- TabController (concepts) ---');
  print('TabController requires TickerProvider');
  print('DefaultTabController wraps TabBar and TabBarView');

  print('All tab indicator tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Indicator Test'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            tabs: [
              tab1,
              tab2,
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Page 1')),
            Center(child: Text('Page 2')),
            Center(child: Text('Page 3')),
          ],
        ),
      ),
    ),
  );
}
