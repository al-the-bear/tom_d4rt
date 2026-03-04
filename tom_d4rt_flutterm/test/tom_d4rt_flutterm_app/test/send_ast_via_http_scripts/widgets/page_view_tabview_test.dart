// D4rt test script: Tests PageView, PageController, TabBarView, TabBar advanced,
// TabController, DefaultTabController, PageScrollPhysics, PageStorageKey
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageView and TabView test executing');

  // ========== PageController ==========
  print('--- PageController Tests ---');
  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0,
  );
  print('PageController created');
  print('  initialPage: ${pageController.initialPage}');
  print('  keepPage: ${pageController.keepPage}');
  print('  viewportFraction: ${pageController.viewportFraction}');

  // ========== PageView ==========
  print('--- PageView Tests ---');
  final pageView = PageView(
    controller: pageController,
    scrollDirection: Axis.horizontal,
    reverse: false,
    physics: PageScrollPhysics(),
    pageSnapping: true,
    onPageChanged: (page) => print('  Page changed: $page'),
    padEnds: true,
    clipBehavior: Clip.hardEdge,
    allowImplicitScrolling: false,
    children: [
      Container(color: Colors.red, child: Center(child: Text('Page 1'))),
      Container(color: Colors.green, child: Center(child: Text('Page 2'))),
      Container(color: Colors.blue, child: Center(child: Text('Page 3'))),
    ],
  );
  print('PageView created');

  // ========== PageView.builder ==========
  print('--- PageView.builder Tests ---');
  final pageViewBuilder = PageView.builder(
    controller: PageController(initialPage: 0, viewportFraction: 0.85),
    itemCount: 10,
    itemBuilder: (context, index) => Card(
      margin: EdgeInsets.all(16),
      child: Center(child: Text('Page $index')),
    ),
    onPageChanged: (page) => print('  Builder page: $page'),
  );
  print('PageView.builder created');

  // ========== PageView.custom ==========
  print('--- PageView.custom Tests ---');
  final pageViewCustom = PageView.custom(
    controller: PageController(),
    childrenDelegate: SliverChildBuilderDelegate(
      (context, index) => Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(child: Text('Custom $index')),
      ),
      childCount: 5,
    ),
  );
  print('PageView.custom created');

  // ========== PageScrollPhysics ==========
  print('--- PageScrollPhysics Tests ---');
  final pagePhysics = PageScrollPhysics(parent: BouncingScrollPhysics());
  print('PageScrollPhysics created');

  // ========== PageStorageKey ==========
  print('--- PageStorageKey Tests ---');
  final storageKey = PageStorageKey<String>('myPage');
  print('PageStorageKey created: value=${storageKey.value}');

  // ========== DefaultTabController ==========
  print('--- DefaultTabController Tests ---');
  final tabScaffold = DefaultTabController(
    length: 3,
    initialIndex: 0,
    animationDuration: Duration(milliseconds: 300),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Tabs'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Tab 1', icon: Icon(Icons.home)),
            Tab(text: 'Tab 2', icon: Icon(Icons.search)),
            Tab(text: 'Tab 3', icon: Icon(Icons.settings)),
          ],
          isScrollable: false,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(2),
            insets: EdgeInsets.symmetric(horizontal: 16),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelPadding: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.zero,
          overlayColor: WidgetStateProperty.all(Colors.white24),
          splashBorderRadius: BorderRadius.circular(8),
          dividerColor: Colors.transparent,
          dividerHeight: 0,
          tabAlignment: TabAlignment.fill,
          onTap: (index) => print('  Tab tapped: $index'),
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(child: Text('Content 1')),
          Center(child: Text('Content 2')),
          Center(child: Text('Content 3')),
        ],
      ),
    ),
  );
  print('DefaultTabController with TabBar and TabBarView created');

  // ========== Tab widget ==========
  print('--- Tab Tests ---');
  final tab1 = Tab(text: 'Text Tab');
  final tab2 = Tab(icon: Icon(Icons.star));
  final tab3 = Tab(text: 'Both', icon: Icon(Icons.favorite), iconMargin: EdgeInsets.only(bottom: 4));
  final tab4 = Tab(child: Row(children: [Icon(Icons.info), SizedBox(width: 4), Text('Custom')]));
  print('Tab widgets created: 4 variants');

  // ========== UnderlineTabIndicator ==========
  print('--- UnderlineTabIndicator Tests ---');
  final indicator = UnderlineTabIndicator(
    borderSide: BorderSide(width: 3, color: Colors.blue),
    borderRadius: BorderRadius.circular(2),
    insets: EdgeInsets.symmetric(horizontal: 16),
  );
  print('UnderlineTabIndicator created');

  // ========== TabBarIndicatorSize ==========
  print('--- TabBarIndicatorSize Tests ---');
  print('  TabBarIndicatorSize.tab: ${TabBarIndicatorSize.tab}');
  print('  TabBarIndicatorSize.label: ${TabBarIndicatorSize.label}');

  // ========== TabAlignment ==========
  print('--- TabAlignment Tests ---');
  for (final alignment in TabAlignment.values) {
    print('  TabAlignment.$alignment');
  }

  print('All page view / tab view tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: tabScaffold,
  );
}
