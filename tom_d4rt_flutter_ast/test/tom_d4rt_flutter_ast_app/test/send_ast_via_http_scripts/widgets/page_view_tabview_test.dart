// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Carousel & Tab Atlas
// Theme: "Carousel & Tab Atlas" - a richly designed gallery exploring
// PageView and TabBarView in many configurations. Horizontal pages,
// vertical pages, viewportFraction variations, TabBar styles, nested
// page/tab combinations, indicator styles, snapping behavior and edge
// cases all live in bounded snapshots so the bridged interpreter has
// end-to-end coverage of the Flutter page/tab surface area.
import 'package:flutter/material.dart';

// ============================================================================
// ATLAS DATA - sample content rendered inside the various pages and tabs
// ============================================================================

const List<Map<String, dynamic>> _atlasPlaces = <Map<String, dynamic>>[
  <String, dynamic>{
    'name': 'Aurora Bay',
    'subtitle': 'Northern lights, glass-calm fjord',
    'tone': 0xFFE3F2FD,
    'accent': 0xFF1565C0,
    'glyph': 'A',
  },
  <String, dynamic>{
    'name': 'Brindle Mesa',
    'subtitle': 'Sun-baked red plateau',
    'tone': 0xFFFFF3E0,
    'accent': 0xFFE65100,
    'glyph': 'B',
  },
  <String, dynamic>{
    'name': 'Cobalt Cove',
    'subtitle': 'Deep blue tide pools',
    'tone': 0xFFE8EAF6,
    'accent': 0xFF303F9F,
    'glyph': 'C',
  },
  <String, dynamic>{
    'name': 'Driftwood Dunes',
    'subtitle': 'Whispering grass and warm sand',
    'tone': 0xFFFFF8E1,
    'accent': 0xFFFF8F00,
    'glyph': 'D',
  },
  <String, dynamic>{
    'name': 'Emerald Reach',
    'subtitle': 'Moss canopy, cedar mist',
    'tone': 0xFFE8F5E9,
    'accent': 0xFF2E7D32,
    'glyph': 'E',
  },
  <String, dynamic>{
    'name': 'Foxglove Falls',
    'subtitle': 'Wildflower cascade',
    'tone': 0xFFFCE4EC,
    'accent': 0xFFC2185B,
    'glyph': 'F',
  },
  <String, dynamic>{
    'name': 'Glacier Veil',
    'subtitle': 'Hanging ice and slow rivers',
    'tone': 0xFFE0F7FA,
    'accent': 0xFF006064,
    'glyph': 'G',
  },
  <String, dynamic>{
    'name': 'Hollyhock Hill',
    'subtitle': 'Quiet town, blossomed paths',
    'tone': 0xFFF3E5F5,
    'accent': 0xFF6A1B9A,
    'glyph': 'H',
  },
];

const List<String> _atlasTabLabels = <String>[
  'Overview',
  'Climate',
  'Trails',
  'Lodging',
  'Cuisine',
  'Stories',
];

const List<IconData> _atlasTabIcons = <IconData>[
  Icons.public,
  Icons.cloud,
  Icons.terrain,
  Icons.hotel,
  Icons.restaurant,
  Icons.menu_book,
];

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('Carousel & Tab Atlas executing');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 20.0),
            _conceptOverview(),
            const SizedBox(height: 20.0),
            _sectionPanel(
              number: 1,
              title: 'Horizontal PageView',
              subtitle:
                  'Default scrollDirection: Axis.horizontal with snapping pages',
              bg: 0xFFE3F2FD,
              border: 0xFF64B5F6,
              accent: 0xFF1565C0,
              demo: _horizontalPageViewDemo(),
              demoHeight: 220.0,
              recipe: const <String>[
                'PageView(children: [...]) renders a horizontal page strip',
                'Each child fills the entire viewport by default',
                'pageSnapping: true snaps to the nearest page on release',
                'Use a PageController to control initialPage and viewportFraction',
              ],
              comparison: const <List<String>>[
                <String>['Property', 'Effect'],
                <String>['scrollDirection', 'Axis.horizontal vs vertical'],
                <String>['pageSnapping', 'Snap vs free-scroll'],
                <String>['viewportFraction', 'Fraction of viewport per page'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 2,
              title: 'Vertical PageView',
              subtitle: 'scrollDirection: Axis.vertical for top-to-bottom pages',
              bg: 0xFFFFF3E0,
              border: 0xFFFFB74D,
              accent: 0xFFE65100,
              demo: _verticalPageViewDemo(),
              demoHeight: 260.0,
              recipe: const <String>[
                'Set scrollDirection: Axis.vertical for vertical pages',
                'Pages now stack top-to-bottom inside the viewport',
                'PageController works identically across both axes',
                'Use SizedBox to constrain height when nested in Column',
              ],
              comparison: const <List<String>>[
                <String>['Axis', 'Layout'],
                <String>['horizontal', 'left-right strip'],
                <String>['vertical', 'top-bottom stack'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 3,
              title: 'PageController Initial Page',
              subtitle:
                  'initialPage controls which page is shown on first build',
              bg: 0xFFE8F5E9,
              border: 0xFF81C784,
              accent: 0xFF2E7D32,
              demo: _initialPageDemo(),
              demoHeight: 240.0,
              recipe: const <String>[
                'PageController(initialPage: N) starts on page N',
                'Useful for deep-linking into a specific page',
                'keepPage: true preserves the page after rebuilds',
                'Three snapshots show initialPage 0, 1, 2 side by side',
              ],
              comparison: const <List<String>>[
                <String>['Field', 'Default'],
                <String>['initialPage', '0'],
                <String>['keepPage', 'true'],
                <String>['viewportFraction', '1.0'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 4,
              title: 'viewportFraction Carousel',
              subtitle:
                  'viewportFraction < 1.0 shows neighbouring pages',
              bg: 0xFFFCE4EC,
              border: 0xFFF06292,
              accent: 0xFFC2185B,
              demo: _viewportFractionDemo(),
              demoHeight: 280.0,
              recipe: const <String>[
                'viewportFraction: 0.8 leaves 10% of each neighbour visible',
                'viewportFraction: 0.5 shows two pages at once',
                'Combine with padEnds: false to align first/last pages',
                'Classic carousel pattern — peek at upcoming content',
              ],
              comparison: const <List<String>>[
                <String>['Fraction', 'Visual'],
                <String>['1.0', 'Full-page snap'],
                <String>['0.85', 'Peek at neighbours'],
                <String>['0.5', 'Two pages visible'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 5,
              title: 'PageView.builder',
              subtitle: 'Lazy item builder for large/infinite page sets',
              bg: 0xFFEDE7F6,
              border: 0xFF9575CD,
              accent: 0xFF512DA8,
              demo: _pageViewBuilderDemo(),
              demoHeight: 240.0,
              recipe: const <String>[
                'PageView.builder(itemCount, itemBuilder) builds pages on demand',
                'Children are only constructed when scrolled into view',
                'Pass itemCount: null for unbounded scrolling',
                'Use any builder pattern — even mapped from a list',
              ],
              comparison: const <List<String>>[
                <String>['Constructor', 'When'],
                <String>['PageView(children:)', 'Small static set'],
                <String>['PageView.builder', 'Large/dynamic set'],
                <String>['PageView.custom', 'Custom child delegate'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 6,
              title: 'PageView.custom',
              subtitle:
                  'Plug in SliverChildBuilderDelegate or other child delegates',
              bg: 0xFFE0F7FA,
              border: 0xFF4DD0E1,
              accent: 0xFF00838F,
              demo: _pageViewCustomDemo(),
              demoHeight: 240.0,
              recipe: const <String>[
                'PageView.custom(childrenDelegate: ...) for full control',
                'Reuse SliverChildBuilderDelegate / SliverChildListDelegate',
                'Hook addAutomaticKeepAlives, addRepaintBoundaries, etc.',
                'Best for advanced pagination, keep-alive, or instrumentation',
              ],
              comparison: const <List<String>>[
                <String>['Delegate', 'Behaviour'],
                <String>['ChildListDelegate', 'Static set of children'],
                <String>['ChildBuilderDelegate', 'Lazy item builder'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 7,
              title: 'DefaultTabController + TabBarView',
              subtitle: 'The canonical tab pattern — controller is implicit',
              bg: 0xFFFFFDE7,
              border: 0xFFFFD54F,
              accent: 0xFFF57F17,
              demo: _defaultTabControllerDemo(),
              demoHeight: 320.0,
              recipe: const <String>[
                'Wrap your widget tree in DefaultTabController(length: N)',
                'TabBar and TabBarView look up the controller automatically',
                'length must equal the number of tabs AND views',
                'initialIndex pre-selects a tab',
              ],
              comparison: const <List<String>>[
                <String>['Widget', 'Role'],
                <String>['DefaultTabController', 'Implicit controller scope'],
                <String>['TabBar', 'Selector strip'],
                <String>['TabBarView', 'Content viewport'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 8,
              title: 'TabBar Indicator Styles',
              subtitle:
                  'UnderlineTabIndicator, BoxDecoration indicator, and label sizing',
              bg: 0xFFE0F2F1,
              border: 0xFF4DB6AC,
              accent: 0xFF00695C,
              demo: _tabIndicatorStylesDemo(),
              demoHeight: 360.0,
              recipe: const <String>[
                'UnderlineTabIndicator(borderSide, insets, borderRadius)',
                'BoxDecoration indicator for filled/pill style',
                'indicatorSize: TabBarIndicatorSize.tab vs .label',
                'indicatorWeight controls underline thickness',
              ],
              comparison: const <List<String>>[
                <String>['IndicatorSize', 'Width'],
                <String>['tab', 'Spans the whole tab cell'],
                <String>['label', 'Hugs the label text'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 9,
              title: 'Scrollable TabBar',
              subtitle: 'isScrollable: true allows many tabs to overflow',
              bg: 0xFFF1F8E9,
              border: 0xFF9CCC65,
              accent: 0xFF558B2F,
              demo: _scrollableTabBarDemo(),
              demoHeight: 320.0,
              recipe: const <String>[
                'isScrollable: true lets the TabBar scroll horizontally',
                'tabAlignment: TabAlignment.start aligns to the leading edge',
                'labelPadding can be tightened for dense tab strips',
                'Ideal for category pickers with many entries',
              ],
              comparison: const <List<String>>[
                <String>['TabAlignment', 'When'],
                <String>['fill', 'Fixed tabs only'],
                <String>['start', 'Scrollable tabs'],
                <String>['center', 'Centered scrollable'],
                <String>['startOffset', 'With offset gap'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 10,
              title: 'Tab Widget Variations',
              subtitle: 'Text-only, icon-only, both, and fully custom tabs',
              bg: 0xFFF3E5F5,
              border: 0xFFBA68C8,
              accent: 0xFF6A1B9A,
              demo: _tabVariationsDemo(),
              demoHeight: 360.0,
              recipe: const <String>[
                'Tab(text: ...) for label-only tabs',
                'Tab(icon: ...) for icon-only tabs',
                'Tab(text: ..., icon: ...) stacks icon above label',
                'Tab(child: ...) lets you supply any widget',
              ],
              comparison: const <List<String>>[
                <String>['Constructor', 'Result'],
                <String>['Tab(text:)', 'Label only'],
                <String>['Tab(icon:)', 'Icon only'],
                <String>['Tab(text:, icon:)', 'Stacked'],
                <String>['Tab(child:)', 'Custom row'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 11,
              title: 'Nested PageView in TabBarView',
              subtitle:
                  'A horizontal carousel living inside one tab content slot',
              bg: 0xFFECEFF1,
              border: 0xFF78909C,
              accent: 0xFF263238,
              demo: _nestedPageInTabDemo(),
              demoHeight: 380.0,
              recipe: const <String>[
                'TabBarView children can host PageView or any widget',
                'Use SizedBox heights when nesting to avoid unbounded constraints',
                'Combine outer tabs with inner carousels for rich navigation',
                'Each tab can host its own controller and physics',
              ],
              comparison: const <List<String>>[
                <String>['Outer', 'Inner'],
                <String>['TabBarView', 'PageView'],
                <String>['PageView', 'TabBarView'],
                <String>['TabBarView', 'TabBarView (nested)'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 12,
              title: 'PageView Scroll Physics',
              subtitle: 'PageScrollPhysics, BouncingScrollPhysics, Never...',
              bg: 0xFFFBE9E7,
              border: 0xFFFF8A65,
              accent: 0xFFD84315,
              demo: _physicsDemo(),
              demoHeight: 260.0,
              recipe: const <String>[
                'PageScrollPhysics() is the snapping default',
                'BouncingScrollPhysics() for iOS-style elastic edges',
                'ClampingScrollPhysics() for Android edge clamping',
                'NeverScrollableScrollPhysics() to lock interaction',
              ],
              comparison: const <List<String>>[
                <String>['Physics', 'Effect'],
                <String>['Page', 'Snaps per page'],
                <String>['Bouncing', 'Elastic overscroll'],
                <String>['Clamping', 'Hard edge clamp'],
                <String>['Never', 'No user scrolling'],
              ],
            ),
            const SizedBox(height: 20.0),
            _featureMatrix(),
            const SizedBox(height: 16.0),
            _glossaryPanel(),
            const SizedBox(height: 16.0),
            _epiloguePanel(),
            const SizedBox(height: 24.0),
            const Center(
              child: Text(
                'Carousel & Tab Atlas • Deep Demo • Flutter Widgets',
                style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 DEMO: Horizontal PageView
// ============================================================================
Widget _horizontalPageViewDemo() {
  return PageView(
    controller: PageController(initialPage: 0, viewportFraction: 1.0),
    scrollDirection: Axis.horizontal,
    physics: const PageScrollPhysics(),
    pageSnapping: true,
    children: <Widget>[
      _atlasPagePanel(_atlasPlaces[0], 'page 1 of 3'),
      _atlasPagePanel(_atlasPlaces[1], 'page 2 of 3'),
      _atlasPagePanel(_atlasPlaces[2], 'page 3 of 3'),
    ],
  );
}

// ============================================================================
// SECTION 2 DEMO: Vertical PageView
// ============================================================================
Widget _verticalPageViewDemo() {
  return PageView(
    controller: PageController(initialPage: 0),
    scrollDirection: Axis.vertical,
    physics: const PageScrollPhysics(),
    pageSnapping: true,
    children: <Widget>[
      _atlasPagePanel(_atlasPlaces[3], 'vertical 1 of 3'),
      _atlasPagePanel(_atlasPlaces[4], 'vertical 2 of 3'),
      _atlasPagePanel(_atlasPlaces[5], 'vertical 3 of 3'),
    ],
  );
}

// ============================================================================
// SECTION 3 DEMO: initialPage snapshots (0, 1, 2)
// ============================================================================
Widget _initialPageDemo() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(child: _initialPageColumn(0)),
      const SizedBox(width: 8.0),
      Expanded(child: _initialPageColumn(1)),
      const SizedBox(width: 8.0),
      Expanded(child: _initialPageColumn(2)),
    ],
  );
}

Widget _initialPageColumn(int initialPage) {
  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2E7D32),
          borderRadius: BorderRadius.circular(6.0),
        ),
        alignment: Alignment.center,
        child: Text(
          'initialPage: $initialPage',
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 6.0),
      SizedBox(
        height: 170.0,
        child: PageView(
          controller: PageController(initialPage: initialPage),
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            _miniPagePanel(_atlasPlaces[0]),
            _miniPagePanel(_atlasPlaces[1]),
            _miniPagePanel(_atlasPlaces[2]),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 4 DEMO: viewportFraction variations
// ============================================================================
Widget _viewportFractionDemo() {
  return Column(
    children: <Widget>[
      _viewportFractionRow(1.0),
      const SizedBox(height: 8.0),
      _viewportFractionRow(0.85),
      const SizedBox(height: 8.0),
      _viewportFractionRow(0.5),
    ],
  );
}

Widget _viewportFractionRow(double fraction) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFF8BBD0)),
    ),
    padding: const EdgeInsets.all(6.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            'fraction\n$fraction',
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFFC2185B),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: SizedBox(
            height: 60.0,
            child: PageView.builder(
              controller: PageController(
                initialPage: 0,
                viewportFraction: fraction,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return _carouselCard(
                  _atlasPlaces[index % _atlasPlaces.length],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 DEMO: PageView.builder
// ============================================================================
Widget _pageViewBuilderDemo() {
  return PageView.builder(
    controller: PageController(initialPage: 0, viewportFraction: 0.9),
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      final Map<String, dynamic> entry =
          _atlasPlaces[index % _atlasPlaces.length];
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Color(entry['tone'] as int),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Color(entry['accent'] as int),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(entry['accent'] as int),
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: Text(
                entry['glyph'] as String,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              entry['name'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color(entry['accent'] as int),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'builder index $index',
              style: const TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// ============================================================================
// SECTION 6 DEMO: PageView.custom with SliverChildBuilderDelegate
// ============================================================================
Widget _pageViewCustomDemo() {
  return PageView.custom(
    controller: PageController(initialPage: 0, viewportFraction: 0.85),
    physics: const NeverScrollableScrollPhysics(),
    childrenDelegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final Map<String, dynamic> entry =
            _atlasPlaces[(index + 3) % _atlasPlaces.length];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(entry['tone'] as int),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Color(entry['accent'] as int),
              width: 1.2,
            ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.layers,
                    color: Color(entry['accent'] as int),
                    size: 18.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'custom #$index',
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                entry['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Color(entry['accent'] as int),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                entry['subtitle'] as String,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        );
      },
      childCount: 5,
    ),
  );
}

// ============================================================================
// SECTION 7 DEMO: DefaultTabController + TabBarView
// ============================================================================
Widget _defaultTabControllerDemo() {
  return DefaultTabController(
    length: 3,
    initialIndex: 0,
    child: Column(
      children: <Widget>[
        Container(
          color: const Color(0xFFF57F17),
          child: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Overview', icon: Icon(Icons.public)),
              Tab(text: 'Climate', icon: Icon(Icons.cloud)),
              Tab(text: 'Trails', icon: Icon(Icons.terrain)),
            ],
            labelColor: Color(0xFFFFFFFF),
            unselectedLabelColor: Color(0xCCFFFFFF),
            indicatorColor: Color(0xFFFFFFFF),
            indicatorWeight: 3.0,
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFFFFDE7),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _tabContentPanel(
                  _atlasPlaces[0],
                  'Headline overview of the region with culture and geography notes.',
                ),
                _tabContentPanel(
                  _atlasPlaces[1],
                  'Climate snapshot: precipitation, wind, temperature ranges.',
                ),
                _tabContentPanel(
                  _atlasPlaces[2],
                  'Trail catalog: hiking corridors, day loops, expert routes.',
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 DEMO: TabBar Indicator Styles
// ============================================================================
Widget _tabIndicatorStylesDemo() {
  return Column(
    children: <Widget>[
      _tabIndicatorVariant(
        title: 'UnderlineTabIndicator',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(text: 'Coast'),
            Tab(text: 'Forest'),
            Tab(text: 'Peaks'),
          ],
          labelColor: Color(0xFF00695C),
          unselectedLabelColor: Color(0xFF80CBC4),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFF00695C)),
            insets: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      _tabIndicatorVariant(
        title: 'BoxDecoration pill indicator',
        bar: TabBar(
          tabs: const <Widget>[
            Tab(text: 'Coast'),
            Tab(text: 'Forest'),
            Tab(text: 'Peaks'),
          ],
          labelColor: const Color(0xFFFFFFFF),
          unselectedLabelColor: const Color(0xFF00695C),
          indicator: BoxDecoration(
            color: const Color(0xFF00695C),
            borderRadius: BorderRadius.circular(20.0),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      const SizedBox(height: 8.0),
      _tabIndicatorVariant(
        title: 'indicatorSize: label (hugs text)',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(text: 'Coast'),
            Tab(text: 'Forest'),
            Tab(text: 'Peaks'),
          ],
          labelColor: Color(0xFF00695C),
          unselectedLabelColor: Color(0xFF80CBC4),
          indicatorColor: Color(0xFF00695C),
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      const SizedBox(height: 8.0),
      _tabIndicatorVariant(
        title: 'Thick weight indicator',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(text: 'Coast'),
            Tab(text: 'Forest'),
            Tab(text: 'Peaks'),
          ],
          labelColor: Color(0xFF00695C),
          unselectedLabelColor: Color(0xFF80CBC4),
          indicatorColor: Color(0xFF004D40),
          indicatorWeight: 6.0,
        ),
      ),
    ],
  );
}

Widget _tabIndicatorVariant({required String title, required TabBar bar}) {
  return DefaultTabController(
    length: 3,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFB2DFDB)),
      ),
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10.5,
                fontFamily: 'monospace',
                color: Color(0xFF00695C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bar,
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 9 DEMO: Scrollable TabBar
// ============================================================================
Widget _scrollableTabBarDemo() {
  return DefaultTabController(
    length: _atlasTabLabels.length,
    initialIndex: 0,
    child: Column(
      children: <Widget>[
        Container(
          color: const Color(0xFF558B2F),
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: const Color(0xFFFFFFFF),
            unselectedLabelColor: const Color(0xCCFFFFFF),
            indicatorColor: const Color(0xFFFFFFFF),
            indicatorWeight: 3.0,
            labelPadding: const EdgeInsets.symmetric(horizontal: 14.0),
            tabs: <Widget>[
              for (int i = 0; i < _atlasTabLabels.length; i++)
                Tab(text: _atlasTabLabels[i], icon: Icon(_atlasTabIcons[i])),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFF1F8E9),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                for (int i = 0; i < _atlasTabLabels.length; i++)
                  _tabContentPanel(
                    _atlasPlaces[i % _atlasPlaces.length],
                    'Scrollable tab #${i + 1}: ${_atlasTabLabels[i]}',
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 DEMO: Tab Variations
// ============================================================================
Widget _tabVariationsDemo() {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #123, P2): wrap inner
  // Column in SingleChildScrollView so the 4 variant rows cannot overflow
  // the bounded SizedBox(height: demoHeight) constraint from _sectionPanel.
  // The Tab(child: Row(...)) variant grows ~14 px above the nominal demo
  // height and triggers the RenderFlex overflow assertion in fixed mode.
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _tabVariationRow(
          title: 'Tab(text:)',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(text: 'One'),
            Tab(text: 'Two'),
            Tab(text: 'Three'),
          ],
          labelColor: Color(0xFF6A1B9A),
          unselectedLabelColor: Color(0xFFBA68C8),
          indicatorColor: Color(0xFF6A1B9A),
        ),
      ),
      const SizedBox(height: 8.0),
      _tabVariationRow(
        title: 'Tab(icon:)',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.settings)),
          ],
          labelColor: Color(0xFF6A1B9A),
          unselectedLabelColor: Color(0xFFBA68C8),
          indicatorColor: Color(0xFF6A1B9A),
        ),
      ),
      const SizedBox(height: 8.0),
      _tabVariationRow(
        title: 'Tab(text:, icon:)',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(text: 'Home', icon: Icon(Icons.home)),
            Tab(text: 'Search', icon: Icon(Icons.search)),
            Tab(text: 'Settings', icon: Icon(Icons.settings)),
          ],
          labelColor: Color(0xFF6A1B9A),
          unselectedLabelColor: Color(0xFFBA68C8),
          indicatorColor: Color(0xFF6A1B9A),
        ),
      ),
      const SizedBox(height: 8.0),
      _tabVariationRow(
        title: 'Tab(child: Row(...))',
        bar: const TabBar(
          tabs: <Widget>[
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, size: 14.0),
                  SizedBox(width: 4.0),
                  Text('Featured'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.bolt, size: 14.0),
                  SizedBox(width: 4.0),
                  Text('Trending'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.history, size: 14.0),
                  SizedBox(width: 4.0),
                  Text('Recent'),
                ],
              ),
            ),
          ],
          labelColor: Color(0xFF6A1B9A),
          unselectedLabelColor: Color(0xFFBA68C8),
          indicatorColor: Color(0xFF6A1B9A),
        ),
      ),
    ],
    ),
  );
}

Widget _tabVariationRow({required String title, required TabBar bar}) {
  return DefaultTabController(
    length: 3,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFCE93D8)),
      ),
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10.5,
                fontFamily: 'monospace',
                color: Color(0xFF6A1B9A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bar,
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 11 DEMO: Nested PageView in TabBarView
// ============================================================================
Widget _nestedPageInTabDemo() {
  return DefaultTabController(
    length: 3,
    initialIndex: 0,
    child: Column(
      children: <Widget>[
        Container(
          color: const Color(0xFF263238),
          child: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Carousel A'),
              Tab(text: 'Carousel B'),
              Tab(text: 'Carousel C'),
            ],
            labelColor: Color(0xFFFFFFFF),
            unselectedLabelColor: Color(0xCCFFFFFF),
            indicatorColor: Color(0xFFFFFFFF),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFECEFF1),
            padding: const EdgeInsets.all(6.0),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _nestedCarousel(0, 0xFF1565C0),
                _nestedCarousel(2, 0xFF2E7D32),
                _nestedCarousel(4, 0xFFE65100),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _nestedCarousel(int startIndex, int accent) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.view_carousel, color: Color(accent), size: 16.0),
            const SizedBox(width: 6.0),
            Text(
              'Inner PageView (starting at $startIndex)',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(accent),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.85),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return _carouselCard(
              _atlasPlaces[(startIndex + index) % _atlasPlaces.length],
            );
          },
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 12 DEMO: Physics
// ============================================================================
Widget _physicsDemo() {
  return Column(
    children: <Widget>[
      _physicsRow('PageScrollPhysics', const PageScrollPhysics(), 0xFFFF8A65),
      const SizedBox(height: 6.0),
      _physicsRow(
        'BouncingScrollPhysics',
        const BouncingScrollPhysics(),
        0xFFD84315,
      ),
      const SizedBox(height: 6.0),
      _physicsRow(
        'ClampingScrollPhysics',
        const ClampingScrollPhysics(),
        0xFFBF360C,
      ),
      const SizedBox(height: 6.0),
      _physicsRow(
        'NeverScrollableScrollPhysics',
        const NeverScrollableScrollPhysics(),
        0xFF8D6E63,
      ),
    ],
  );
}

Widget _physicsRow(String label, ScrollPhysics physics, int accent) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(accent).withOpacity(0.5)),
    ),
    padding: const EdgeInsets.all(6.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(accent),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: SizedBox(
            height: 44.0,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.6),
              physics: physics,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> entry =
                    _atlasPlaces[index % _atlasPlaces.length];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    color: Color(entry['tone'] as int),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: Color(entry['accent'] as int),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    entry['glyph'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(entry['accent'] as int),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================
Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF512DA8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331A237E),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.view_carousel,
                color: Color(0xFFFFFFFF),
                size: 24.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'Carousel & Tab Atlas',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Deep Demo: a richly designed gallery exploring PageView and TabBarView in many configurations — horizontal pages, vertical pages, viewportFraction carousels, TabBar indicator styles, nested page/tab compositions and physics variants.',
          style: TextStyle(fontSize: 13.0, color: Color(0xFFD1C4E9), height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _heroChip('PageView'),
            _heroChip('PageController'),
            _heroChip('viewportFraction'),
            _heroChip('PageView.builder'),
            _heroChip('PageView.custom'),
            _heroChip('TabBar'),
            _heroChip('TabBarView'),
            _heroChip('DefaultTabController'),
            _heroChip('UnderlineTabIndicator'),
            _heroChip('TabAlignment'),
            _heroChip('PageScrollPhysics'),
            _heroChip('NeverScrollableScrollPhysics'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================
Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF512DA8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.architecture,
                color: Color(0xFFFFFFFF),
                size: 18.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'PageView and TabBarView are the two primary "paged" navigation primitives '
          'in Flutter. PageView turns a flat list of children into a horizontally or '
          'vertically scrollable strip of full-viewport pages, while TabBarView pairs '
          'a TabBar selector with synchronized content panels. Both are driven by '
          'controllers (PageController and TabController) and accept the same family '
          'of ScrollPhysics. The sections below host bounded snapshots of each '
          'configuration so we can showcase every supported variation side by side.',
          style: TextStyle(fontSize: 13.0, height: 1.5, color: Color(0xFF37474F)),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Key principle:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '  PageView = "swipe between full pages"   •   TabBarView = "switch between named tabs"',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFF1A237E),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION PANEL
// ============================================================================
Widget _sectionPanel({
  required int number,
  required String title,
  required String subtitle,
  required int bg,
  required int border,
  required int accent,
  required Widget demo,
  required double demoHeight,
  required List<String> recipe,
  required List<List<String>> comparison,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(bg),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(border), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(border).withOpacity(0.2),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(accent),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(accent).withOpacity(0.4),
                    blurRadius: 6.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(accent),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(border).withOpacity(0.6)),
          ),
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: demoHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: demo,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        _recipeCard(recipe, accent),
        const SizedBox(height: 10.0),
        _comparisonTable(comparison, accent, border),
      ],
    ),
  );
}

// ============================================================================
// RECIPE CARD
// ============================================================================
Widget _recipeCard(List<String> lines, int accent) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Color(accent), size: 16.0),
            const SizedBox(width: 6.0),
            Text(
              'Recipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Color(accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (final String line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '• ',
                  style: TextStyle(color: Color(accent), fontSize: 12.0),
                ),
                Expanded(
                  child: Text(
                    line,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF424242),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            _recipeCodeFor(lines.isNotEmpty ? lines.first : ''),
            style: const TextStyle(
              color: Color(0xFFB2DFDB),
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

String _recipeCodeFor(String firstLine) {
  if (firstLine.startsWith('PageView(')) {
    return 'PageView(\n  controller: PageController(),\n  children: [...],\n);';
  }
  if (firstLine.contains('scrollDirection: Axis.vertical')) {
    return 'PageView(\n  scrollDirection: Axis.vertical,\n  children: [...],\n);';
  }
  if (firstLine.contains('initialPage: N')) {
    return 'PageController(initialPage: N);';
  }
  if (firstLine.contains('viewportFraction: 0.8')) {
    return 'PageController(viewportFraction: 0.85);';
  }
  if (firstLine.startsWith('PageView.builder')) {
    return 'PageView.builder(\n  itemCount: n,\n  itemBuilder: (ctx, i) => ...,\n);';
  }
  if (firstLine.startsWith('PageView.custom')) {
    return 'PageView.custom(\n  childrenDelegate: ...,\n);';
  }
  if (firstLine.contains('DefaultTabController')) {
    return 'DefaultTabController(\n  length: 3,\n  child: ...,\n);';
  }
  if (firstLine.contains('UnderlineTabIndicator')) {
    return 'UnderlineTabIndicator(\n  borderSide: BorderSide(...),\n);';
  }
  if (firstLine.contains('isScrollable: true')) {
    return 'TabBar(\n  isScrollable: true,\n  tabAlignment: TabAlignment.start,\n);';
  }
  if (firstLine.contains('Tab(text:')) {
    return 'Tab(text: \'Label\');';
  }
  if (firstLine.contains('TabBarView children')) {
    return 'TabBarView(\n  children: [PageView(...), ...],\n);';
  }
  if (firstLine.contains('PageScrollPhysics')) {
    return 'PageView(\n  physics: PageScrollPhysics(),\n);';
  }
  return '// example code snippet';
}

// ============================================================================
// COMPARISON TABLE
// ============================================================================
Widget _comparisonTable(List<List<String>> rows, int accent, int border) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.compare_arrows, color: Color(accent), size: 14.0),
            const SizedBox(width: 6.0),
            Text(
              'Comparison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Color(accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? Color(border).withOpacity(0.18)
                  : (i.isEven
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFFF5F5F5)),
              borderRadius: BorderRadius.circular(4.0),
            ),
            margin: const EdgeInsets.only(bottom: 2.0),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < rows[i].length; c++)
                  Expanded(
                    child: Text(
                      rows[i][c],
                      style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: c == 0 ? 'monospace' : null,
                        fontWeight: i == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: i == 0
                            ? Color(accent)
                            : const Color(0xFF424242),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// FEATURE MATRIX (PageView vs TabBarView)
// ============================================================================
Widget _featureMatrix() {
  final List<List<String>> rows = <List<String>>[
    <String>['Feature', 'PageView', 'TabBarView'],
    <String>['Controller', 'PageController', 'TabController'],
    <String>['Scope', 'Independent', 'Tied to TabBar'],
    <String>['Snapping', 'pageSnapping flag', 'Always per-tab'],
    <String>['Axis', 'horizontal / vertical', 'horizontal only'],
    <String>['viewportFraction', 'Yes (< 1.0 carousels)', 'No (always full)'],
    <String>['Lazy builder', 'PageView.builder', 'Children list only'],
    <String>['Custom delegate', 'PageView.custom', 'Not available'],
    <String>['Physics', 'Any ScrollPhysics', 'Any ScrollPhysics'],
    <String>['Indicator', 'External (Dots/etc.)', 'Built-in TabBar'],
    <String>['Keyboard nav', 'Manual', 'Built-in'],
    <String>['Restoration', 'PageStorageKey', 'Restoration ID'],
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF9FA8DA), width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x223F51B5),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.table_chart, color: Color(0xFF1A237E), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Feature Matrix: PageView vs TabBarView',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            margin: const EdgeInsets.only(bottom: 3.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? const Color(0xFFE8EAF6)
                  : (i.isEven
                      ? const Color(0xFFFAFAFA)
                      : const Color(0xFFFFFFFF)),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: i == 0
                    ? const Color(0xFF9FA8DA)
                    : const Color(0xFFEEEEEE),
              ),
            ),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < rows[i].length; c++)
                  Expanded(
                    flex: c == 0 ? 3 : 4,
                    child: Text(
                      rows[i][c],
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: c == 0 ? 'monospace' : null,
                        fontWeight: i == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: i == 0
                            ? const Color(0xFF1A237E)
                            : const Color(0xFF424242),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// GLOSSARY PANEL
// ============================================================================
Widget _glossaryPanel() {
  final List<Map<String, String>> entries = <Map<String, String>>[
    <String, String>{
      'term': 'Page',
      'def':
          'One child of a PageView — typically occupies the full viewport.',
    },
    <String, String>{
      'term': 'Viewport',
      'def':
          'The window in which pages or tabs are visible. Defined by the host SizedBox.',
    },
    <String, String>{
      'term': 'PageController',
      'def':
          'Controls a PageView. Holds initialPage, viewportFraction, keepPage.',
    },
    <String, String>{
      'term': 'viewportFraction',
      'def':
          'Fraction of the viewport each page occupies. < 1.0 reveals neighbours.',
    },
    <String, String>{
      'term': 'Tab',
      'def':
          'A single selector cell in a TabBar. May host text, an icon, or both.',
    },
    <String, String>{
      'term': 'TabBar',
      'def':
          'The horizontal selector strip; emits index changes to its TabController.',
    },
    <String, String>{
      'term': 'TabBarView',
      'def':
          'The synchronized content viewport that follows the selected tab.',
    },
    <String, String>{
      'term': 'TabController',
      'def':
          'Implicit via DefaultTabController or explicit when you need callbacks.',
    },
    <String, String>{
      'term': 'Indicator',
      'def':
          'The visual marker showing which tab is selected (underline, pill, box).',
    },
    <String, String>{
      'term': 'TabAlignment',
      'def':
          'How tab cells are laid out in the bar: fill, start, center, startOffset.',
    },
    <String, String>{
      'term': 'PageScrollPhysics',
      'def':
          'Default snapping physics for PageView — locks to page boundaries.',
    },
    <String, String>{
      'term': 'pageSnapping',
      'def':
          'When true, scrolling settles to the nearest page on release.',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFEE58), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.menu_book, color: Color(0xFFF57F17), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Atlas Glossary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF57F17),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, String> entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Text(
                    entry['term'] ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry['def'] ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF5D4037),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE PANEL
// ============================================================================
Widget _epiloguePanel() {
  final List<String> achievements = <String>[
    'PageView (horizontal & vertical)',
    'PageController (initialPage, viewportFraction, keepPage)',
    'PageView.builder lazy item builder',
    'PageView.custom with SliverChildBuilderDelegate',
    'viewportFraction carousels (1.0 / 0.85 / 0.5)',
    'DefaultTabController + TabBar + TabBarView',
    'UnderlineTabIndicator and BoxDecoration indicators',
    'TabBarIndicatorSize.tab vs TabBarIndicatorSize.label',
    'Scrollable TabBar with TabAlignment.start',
    'Tab variations (text, icon, both, custom child)',
    'Nested PageView inside TabBarView',
    'ScrollPhysics variants (Page, Bouncing, Clamping, Never)',
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF388E3C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x331B5E20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.verified, color: Color(0xFFFFFFFF), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Epilogue • Coverage Manifest',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Every PageView and TabBarView configuration supported by the bridged interpreter has a live demo, a recipe card, and a comparison table above. Below is the coverage manifest.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFFC8E6C9),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        for (final String item in achievements)
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFFA5D6A7),
                  size: 14.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Carousel & Tab Atlas Coverage: All Page & Tab Primitives Demonstrated',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SMALL BUILDING BLOCKS
// ============================================================================

Widget _atlasPagePanel(Map<String, dynamic> entry, String tag) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(entry['tone'] as int),
          const Color(0xFFFFFFFF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: Color(entry['accent'] as int),
        width: 1.4,
      ),
    ),
    padding: const EdgeInsets.all(14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 48.0,
              height: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(entry['accent'] as int),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Text(
                entry['glyph'] as String,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    entry['name'] as String,
                    style: TextStyle(
                      color: Color(entry['accent'] as int),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          entry['subtitle'] as String,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF424242),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _miniPagePanel(Map<String, dynamic> entry) {
  return Container(
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: Color(entry['tone'] as int),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Color(entry['accent'] as int),
        width: 1.0,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(entry['accent'] as int),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            entry['glyph'] as String,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          entry['name'] as String,
          style: TextStyle(
            color: Color(entry['accent'] as int),
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );
}

Widget _carouselCard(Map<String, dynamic> entry) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: Color(entry['tone'] as int),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Color(entry['accent'] as int),
        width: 1.0,
      ),
    ),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(entry['accent'] as int),
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: Text(
            entry['glyph'] as String,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Flexible(
          child: Text(
            entry['name'] as String,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(entry['accent'] as int),
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tabContentPanel(Map<String, dynamic> entry, String summary) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(entry['accent'] as int).withOpacity(0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(entry['accent'] as int),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                entry['glyph'] as String,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                entry['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Color(entry['accent'] as int),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          summary,
          style: const TextStyle(
            fontSize: 11.5,
            color: Color(0xFF424242),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}
