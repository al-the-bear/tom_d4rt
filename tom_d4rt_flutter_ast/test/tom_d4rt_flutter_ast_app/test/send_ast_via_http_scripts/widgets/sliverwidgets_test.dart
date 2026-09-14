// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Sliver Catalog Atelier from widgets
// Theme: "Sliver Catalog Atelier" - a curated gallery of sliver primitives
// used inside CustomScrollView viewports. Each section presents a single
// sliver class with a live bounded scroll demo, a recipe card, and a
// comparison panel so the bridged interpreter has end-to-end coverage of
// the Flutter sliver surface area.
import 'package:flutter/material.dart';

// ============================================================================
// CATALOG DATA - sample content rendered inside the various slivers
// ============================================================================

const List<String> _atelierPalettesLabels = <String>[
  'Ink Mist',
  'Brass Glow',
  'Verdant Loft',
  'Crimson Studio',
  'Cobalt Workshop',
  'Amber Studio',
  'Slate Atelier',
  'Lavender Press',
];

const List<Map<String, dynamic>> _atelierCatalog = <Map<String, dynamic>>[
  {
    'title': 'Folio I',
    'subtitle': 'Hand-pressed linen',
    'tone': 0xFFE3F2FD,
    'accent': 0xFF1565C0,
  },
  {
    'title': 'Folio II',
    'subtitle': 'Brushed walnut',
    'tone': 0xFFFFF3E0,
    'accent': 0xFFE65100,
  },
  {
    'title': 'Folio III',
    'subtitle': 'Cold-pressed cotton',
    'tone': 0xFFE8F5E9,
    'accent': 0xFF2E7D32,
  },
  {
    'title': 'Folio IV',
    'subtitle': 'Quarry marble',
    'tone': 0xFFFCE4EC,
    'accent': 0xFFC2185B,
  },
  {
    'title': 'Folio V',
    'subtitle': 'Riveted brass',
    'tone': 0xFFEDE7F6,
    'accent': 0xFF512DA8,
  },
  {
    'title': 'Folio VI',
    'subtitle': 'Antique parchment',
    'tone': 0xFFE0F7FA,
    'accent': 0xFF006064,
  },
  {
    'title': 'Folio VII',
    'subtitle': 'Tea-stained paper',
    'tone': 0xFFF3E5F5,
    'accent': 0xFF6A1B9A,
  },
  {
    'title': 'Folio VIII',
    'subtitle': 'Charcoal vellum',
    'tone': 0xFFECEFF1,
    'accent': 0xFF455A64,
  },
];

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('SliverWidgets atelier executing');

  // ==========================================================================
  // SECTION 1: SLIVERAPPBAR (pinned/floating/expandedHeight/flexibleSpace)
  // ==========================================================================
  final sliverAppBarDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        title: const Text('Atelier Loft'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: const Color(0xFFFFFFFF),
        pinned: true,
        floating: true,
        expandedHeight: 96.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Pinned • Floating',
            style: TextStyle(fontSize: 12.0, color: Color(0xFFFFFFFF)),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              height: 44.0,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                border: Border(
                  bottom: BorderSide(color: const Color(0xFFBBDEFB)),
                ),
              ),
              child: Text(
                'Atelier item ${index + 1}',
                style: const TextStyle(fontSize: 13.0, color: Color(0xFF0D47A1)),
              ),
            );
          },
          childCount: 8,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 2: SLIVERLIST WITH BUILDER DELEGATE
  // ==========================================================================
  final sliverListBuilderDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final Map<String, dynamic> entry =
                _atelierCatalog[index % _atelierCatalog.length];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(entry['tone'] as int),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Color(entry['accent'] as int),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 28.0,
                    height: 28.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(entry['accent'] as int),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          entry['title'] as String,
                          style: TextStyle(
                            color: Color(entry['accent'] as int),
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          entry['subtitle'] as String,
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
            );
          },
          childCount: 12,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 3: SLIVERLIST WITH LIST DELEGATE (static set of children)
  // ==========================================================================
  final sliverListListDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          _atelierTile('Ink Mist', 'Static delegate row 1', 0xFFECEFF1, 0xFF455A64),
          _atelierTile('Brass Glow', 'Static delegate row 2', 0xFFFFF8E1, 0xFFFF8F00),
          _atelierTile('Verdant Loft', 'Static delegate row 3', 0xFFE8F5E9, 0xFF2E7D32),
          _atelierTile('Crimson Studio', 'Static delegate row 4', 0xFFFCE4EC, 0xFFC2185B),
          _atelierTile('Cobalt Workshop', 'Static delegate row 5', 0xFFE3F2FD, 0xFF1565C0),
          _atelierTile('Amber Studio', 'Static delegate row 6', 0xFFFFF3E0, 0xFFE65100),
        ]),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 4: SLIVERFIXEDEXTENTLIST - uniform row height
  // ==========================================================================
  final sliverFixedExtentDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: 56.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFF7E57C2)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF512DA8),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      'FixedExtent row ${index + 1} • 56.0 dp',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF311B92),
                      ),
                    ),
                  ),
                  Text(
                    'extent=56',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF7E57C2),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 8,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 5: SLIVERGRID with SliverGridDelegateWithFixedCrossAxisCount
  // ==========================================================================
  final sliverGridFixedCountDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final Map<String, dynamic> entry =
                  _atelierCatalog[index % _atelierCatalog.length];
              return Container(
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
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Color(entry['accent'] as int),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      entry['title'] as String,
                      style: TextStyle(
                        color: Color(entry['accent'] as int),
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 9,
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 6: SLIVERGRID with SliverGridDelegateWithMaxCrossAxisExtent
  // ==========================================================================
  final sliverGridMaxExtentDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 110.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildListDelegate(<Widget>[
            _gridChip('Linen', 0xFFE3F2FD, 0xFF1565C0),
            _gridChip('Walnut', 0xFFFFF3E0, 0xFFE65100),
            _gridChip('Cotton', 0xFFE8F5E9, 0xFF2E7D32),
            _gridChip('Marble', 0xFFFCE4EC, 0xFFC2185B),
            _gridChip('Brass', 0xFFEDE7F6, 0xFF512DA8),
            _gridChip('Parchment', 0xFFE0F7FA, 0xFF006064),
            _gridChip('Vellum', 0xFFF3E5F5, 0xFF6A1B9A),
            _gridChip('Slate', 0xFFECEFF1, 0xFF455A64),
          ]),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 7: SLIVERTOBOXADAPTER - embed non-sliver widgets
  // ==========================================================================
  final sliverToBoxAdapterDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 64.0,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFE082)],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFFFB300)),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.bookmark, color: Color(0xFF6D4C41)),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'SliverToBoxAdapter wraps a single box widget so it can sit between slivers.',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF4E342E)),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              height: 36.0,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: index.isEven
                    ? const Color(0xFFFFF8E1)
                    : const Color(0xFFFFFDE7),
              ),
              child: Text(
                'Trailing list row ${index + 1}',
                style: const TextStyle(fontSize: 12.0, color: Color(0xFF6D4C41)),
              ),
            );
          },
          childCount: 4,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 8: SLIVERFILLREMAINING - claim leftover viewport space
  // ==========================================================================
  final sliverFillRemainingDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 48.0,
          color: const Color(0xFFE0F7FA),
          alignment: Alignment.center,
          child: const Text(
            'Header above SliverFillRemaining',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF006064)),
          ),
        ),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF80DEEA), Color(0xFF26C6DA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.expand, color: Color(0xFFFFFFFF), size: 28.0),
              SizedBox(height: 6.0),
              Text(
                'SliverFillRemaining',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Text(
                'Fills the rest of the viewport',
                style: TextStyle(color: Color(0xFFE0F7FA), fontSize: 11.0),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 9: SLIVERFILLVIEWPORT - one child per viewport page
  // ==========================================================================
  final sliverFillViewportDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverFillViewport(
        viewportFraction: 0.5,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final Map<String, dynamic> entry =
                _atelierCatalog[index % _atelierCatalog.length];
            return Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Color(entry['tone'] as int),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(entry['accent'] as int),
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    entry['title'] as String,
                    style: TextStyle(
                      color: Color(entry['accent'] as int),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'page ${index + 1}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 5,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 10: SLIVERPADDING - inset slivers
  // ==========================================================================
  final sliverPaddingDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            _atelierTile('Padded row 1', 'EdgeInsets.fromLTRB(24,12,24,12)', 0xFFF3E5F5, 0xFF6A1B9A),
            _atelierTile('Padded row 2', 'Inset on all sides', 0xFFEDE7F6, 0xFF512DA8),
            _atelierTile('Padded row 3', 'Outer SliverPadding wraps inner SliverList', 0xFFE8EAF6, 0xFF303F9F),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFEF9A9A)),
            ),
            child: const Text(
              'SliverPadding can wrap any sliver — list, grid, header, or adapter.',
              style: TextStyle(fontSize: 11.0, color: Color(0xFFB71C1C)),
            ),
          ),
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 11: SLIVERPERSISTENTHEADER (via SliverAppBar bridge)
  // SliverPersistentHeaderDelegate is abstract and cannot be subclassed in
  // the bridged interpreter, so we show the concept via SliverAppBar which
  // is the canonical built-in persistent header.
  // ==========================================================================
  final sliverPersistentHeaderDemo = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        floating: false,
        expandedHeight: 80.0,
        backgroundColor: const Color(0xFF455A64),
        foregroundColor: const Color(0xFFFFFFFF),
        title: const Text('Persistent Header'),
        flexibleSpace: const FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Text(
            'Stays visible while scrolling',
            style: TextStyle(fontSize: 11.0, color: Color(0xFFCFD8DC)),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              height: 40.0,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: index.isEven
                    ? const Color(0xFFECEFF1)
                    : const Color(0xFFCFD8DC),
              ),
              child: Text(
                'Row ${index + 1} below pinned header',
                style: const TextStyle(fontSize: 12.0, color: Color(0xFF263238)),
              ),
            );
          },
          childCount: 6,
        ),
      ),
    ],
  );

  print('SliverWidgets atelier sections assembled');

  // ==========================================================================
  // FINAL RETURN
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sliver Catalog Atelier',
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _heroHeader(),
              const SizedBox(height: 20.0),
              _conceptOverview(),
              const SizedBox(height: 20.0),
              _sectionPanel(
                number: 1,
                title: 'SliverAppBar',
                subtitle: 'Pinned • Floating • expandedHeight • flexibleSpace',
                bg: 0xFFE3F2FD,
                border: 0xFF1565C0,
                accent: 0xFF0D47A1,
                demo: sliverAppBarDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'pinned: true keeps the bar stuck at the top',
                  'floating: true makes it reappear on reverse scroll',
                  'expandedHeight gives FlexibleSpaceBar room to breathe',
                  'flexibleSpace renders a gradient background',
                ],
                comparison: const <List<String>>[
                  <String>['Flag', 'Effect'],
                  <String>['pinned', 'Stays visible'],
                  <String>['floating', 'Slides back in'],
                  <String>['snap', 'Snaps to a stop'],
                  <String>['expandedHeight', 'Max height'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 2,
                title: 'SliverList (BuilderDelegate)',
                subtitle: 'On-demand items via SliverChildBuilderDelegate',
                bg: 0xFFE8F5E9,
                border: 0xFF66BB6A,
                accent: 0xFF1B5E20,
                demo: sliverListBuilderDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'SliverChildBuilderDelegate((ctx, i) => widget, childCount: n)',
                  'Lazy build — only visible items are constructed',
                  'Combine with childCount for finite lists',
                  'Wrap children in Containers for visual separation',
                ],
                comparison: const <List<String>>[
                  <String>['Property', 'Purpose'],
                  <String>['builder', 'IndexedWidgetBuilder'],
                  <String>['childCount', 'Total items'],
                  <String>['addAutomaticKeepAlives', 'Preserve scrolled-off state'],
                  <String>['addRepaintBoundaries', 'Cheap repaints'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 3,
                title: 'SliverList (ListDelegate)',
                subtitle: 'Static set of children via SliverChildListDelegate',
                bg: 0xFFFFF3E0,
                border: 0xFFFFB74D,
                accent: 0xFFE65100,
                demo: sliverListListDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'SliverChildListDelegate(<Widget>[...])',
                  'Eager — all children built up front',
                  'Best for small finite groups (5-20 rows)',
                  'No builder needed; great for headers/footers',
                ],
                comparison: const <List<String>>[
                  <String>['Delegate', 'When to use'],
                  <String>['Builder', 'Large or infinite'],
                  <String>['List', 'Small static'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 4,
                title: 'SliverFixedExtentList',
                subtitle: 'Uniform itemExtent — faster layout than SliverList',
                bg: 0xFFEDE7F6,
                border: 0xFF9575CD,
                accent: 0xFF311B92,
                demo: sliverFixedExtentDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'itemExtent: 56.0 — fixed pixel height per row',
                  'Skips intrinsic measurement — faster than SliverList',
                  'Best when rows share an obvious uniform height',
                  'Pair with SliverChildBuilderDelegate for lazy build',
                ],
                comparison: const <List<String>>[
                  <String>['Sliver', 'Layout cost'],
                  <String>['SliverList', 'measures each child'],
                  <String>['SliverFixedExtentList', 'reuses itemExtent'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 5,
                title: 'SliverGrid (FixedCrossAxisCount)',
                subtitle: 'Fixed number of columns regardless of width',
                bg: 0xFFFCE4EC,
                border: 0xFFF06292,
                accent: 0xFFAD1457,
                demo: sliverGridFixedCountDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)',
                  'childAspectRatio shapes each cell',
                  'mainAxisSpacing and crossAxisSpacing control gutters',
                  'Wrap in SliverPadding for outer margins',
                ],
                comparison: const <List<String>>[
                  <String>['Field', 'Meaning'],
                  <String>['crossAxisCount', 'Columns'],
                  <String>['childAspectRatio', 'W:H ratio'],
                  <String>['mainAxisSpacing', 'Vertical gap'],
                  <String>['crossAxisSpacing', 'Horizontal gap'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 6,
                title: 'SliverGrid (MaxCrossAxisExtent)',
                subtitle: 'Column count adapts to available width',
                bg: 0xFFE0F7FA,
                border: 0xFF4DD0E1,
                accent: 0xFF006064,
                demo: sliverGridMaxExtentDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 110)',
                  'Computes column count from viewport width',
                  'Great for responsive layouts',
                  'Each cell is at most maxCrossAxisExtent wide',
                ],
                comparison: const <List<String>>[
                  <String>['Delegate', 'Behavior'],
                  <String>['FixedCrossAxisCount', 'Static columns'],
                  <String>['MaxCrossAxisExtent', 'Responsive columns'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 7,
                title: 'SliverToBoxAdapter',
                subtitle: 'Embed a regular widget inside a CustomScrollView',
                bg: 0xFFFFF8E1,
                border: 0xFFFFD54F,
                accent: 0xFF6D4C41,
                demo: sliverToBoxAdapterDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'Wraps exactly ONE non-sliver child',
                  'Useful for hero cards, banners, separators',
                  'Combine with SliverList for mixed layouts',
                  'Child is laid out at its intrinsic height',
                ],
                comparison: const <List<String>>[
                  <String>['Need', 'Use'],
                  <String>['Single widget', 'SliverToBoxAdapter'],
                  <String>['Multiple widgets', 'SliverList(ListDelegate)'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 8,
                title: 'SliverFillRemaining',
                subtitle: 'Fill the leftover space in the viewport',
                bg: 0xFFE0F2F1,
                border: 0xFF4DB6AC,
                accent: 0xFF00695C,
                demo: sliverFillRemainingDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'Place after other slivers to consume leftover height',
                  'hasScrollBody: false for static fill content',
                  'fillOverscroll: true to extend into overscroll',
                  'Perfect for empty states / full-bleed CTAs',
                ],
                comparison: const <List<String>>[
                  <String>['Flag', 'Effect'],
                  <String>['hasScrollBody', 'Treat child as scrollable'],
                  <String>['fillOverscroll', 'Stretches into bounce'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 9,
                title: 'SliverFillViewport',
                subtitle: 'Each child takes a fraction of the viewport',
                bg: 0xFFF3E5F5,
                border: 0xFFBA68C8,
                accent: 0xFF6A1B9A,
                demo: sliverFillViewportDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'viewportFraction: 0.5 → child fills half the viewport',
                  'Behaves like a snap-style carousel',
                  'Combine with SliverChildBuilderDelegate for lazy pages',
                  'Use viewportFraction: 1.0 for full-bleed pages',
                ],
                comparison: const <List<String>>[
                  <String>['viewportFraction', 'Layout'],
                  <String>['1.0', 'Full page per child'],
                  <String>['0.5', 'Two children per viewport'],
                  <String>['0.33', 'Triple-up cards'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 10,
                title: 'SliverPadding',
                subtitle: 'Inset slivers with EdgeInsets',
                bg: 0xFFE8EAF6,
                border: 0xFF7986CB,
                accent: 0xFF1A237E,
                demo: sliverPaddingDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'Wraps any sliver (list, grid, adapter, header)',
                  'EdgeInsets.fromLTRB(left, top, right, bottom)',
                  'Compose multiple SliverPaddings for layered insets',
                  'Useful for safe area / gutters in CustomScrollView',
                ],
                comparison: const <List<String>>[
                  <String>['EdgeInsets', 'Affects'],
                  <String>['top/bottom', 'Main axis'],
                  <String>['left/right', 'Cross axis'],
                ],
              ),
              const SizedBox(height: 16.0),
              _sectionPanel(
                number: 11,
                title: 'SliverPersistentHeader (via SliverAppBar)',
                subtitle:
                    'Bridged interpreter cannot subclass the delegate — SliverAppBar provides the canonical implementation',
                bg: 0xFFECEFF1,
                border: 0xFF78909C,
                accent: 0xFF263238,
                demo: sliverPersistentHeaderDemo,
                demoHeight: 280.0,
                recipe: const <String>[
                  'SliverPersistentHeaderDelegate is abstract — cannot subclass in D4rt',
                  'SliverAppBar internally wraps a SliverPersistentHeader',
                  'pinned + floating reproduce the standard delegate behavior',
                  'For custom headers use a compiled Flutter project',
                ],
                comparison: const <List<String>>[
                  <String>['API', 'Status'],
                  <String>['SliverPersistentHeader', 'needs custom delegate'],
                  <String>['SliverAppBar', 'works out of the box'],
                ],
              ),
              const SizedBox(height: 20.0),
              _glossaryPanel(),
              const SizedBox(height: 16.0),
              _epiloguePanel(),
              const SizedBox(height: 24.0),
              const Center(
                child: Text(
                  'Sliver Catalog Atelier • Deep Demo • Flutter Widgets',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
                ),
              ),
            ],
          ),
        ),
      ),
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
        colors: <Color>[Color(0xFF263238), Color(0xFF455A64)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
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
                Icons.view_agenda,
                color: Color(0xFFFFFFFF),
                size: 24.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'Sliver Catalog Atelier',
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
          'Deep Demo: a curated walk through every sliver primitive that the bridged interpreter supports inside a CustomScrollView viewport.',
          style: TextStyle(fontSize: 13.0, color: Color(0xFFCFD8DC)),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _heroChip('SliverAppBar'),
            _heroChip('SliverList'),
            _heroChip('SliverFixedExtentList'),
            _heroChip('SliverGrid'),
            _heroChip('SliverToBoxAdapter'),
            _heroChip('SliverFillRemaining'),
            _heroChip('SliverFillViewport'),
            _heroChip('SliverPadding'),
            _heroChip('SliverPersistentHeader'),
            _heroChip('CustomScrollView'),
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
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF455A64),
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
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Slivers are scrollable layout primitives that ONLY work inside a viewport. '
          'CustomScrollView is the canonical viewport. Each sliver class specializes in '
          'one layout pattern — lists, grids, headers, fill regions, padding, or single '
          'box adapters. The sections below host bounded CustomScrollViews so we can '
          'showcase every supported sliver side by side inside an outer SingleChildScrollView.',
          style: TextStyle(fontSize: 13.0, height: 1.5, color: Color(0xFF37474F)),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Key principle:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '  Sliver = "what gets scrolled"   •   Viewport = "the window that scrolls them"',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFF455A64),
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
                color: Color(accent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
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
        // ---- LIVE DEMO ----
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
        // ---- RECIPE CARD ----
        _recipeCard(recipe, accent),
        const SizedBox(height: 10.0),
        // ---- COMPARISON TABLE ----
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
      ],
    ),
  );
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
// GLOSSARY PANEL
// ============================================================================
Widget _glossaryPanel() {
  final List<Map<String, String>> entries = <Map<String, String>>[
    <String, String>{
      'term': 'Sliver',
      'def': 'Scrollable layout primitive. Lives inside a viewport.',
    },
    <String, String>{
      'term': 'Viewport',
      'def': 'The window that displays slivers — typically CustomScrollView.',
    },
    <String, String>{
      'term': 'Delegate',
      'def': 'Strategy object that supplies children to a sliver.',
    },
    <String, String>{
      'term': 'CustomScrollView',
      'def': 'The canonical Flutter widget for hosting slivers.',
    },
    <String, String>{
      'term': 'shrinkWrap',
      'def': 'CustomScrollView flag — measure children up front.',
    },
    <String, String>{
      'term': 'itemExtent',
      'def': 'Fixed per-child size to skip intrinsic measurement.',
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
              'Atelier Glossary',
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
                  width: 110.0,
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
    'SliverAppBar (pinned • floating • expandedHeight • flexibleSpace)',
    'SliverList with SliverChildBuilderDelegate',
    'SliverList with SliverChildListDelegate',
    'SliverFixedExtentList',
    'SliverGrid with SliverGridDelegateWithFixedCrossAxisCount',
    'SliverGrid with SliverGridDelegateWithMaxCrossAxisExtent',
    'SliverToBoxAdapter',
    'SliverFillRemaining',
    'SliverFillViewport',
    'SliverPadding',
    'SliverPersistentHeader (via SliverAppBar bridge)',
    'CustomScrollView host viewport (multiple bounded instances)',
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
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
          'Every sliver in the bridged surface area has a live demo, recipe card, and comparison table above. Below is the coverage manifest.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFFC8E6C9), height: 1.4),
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
            'Sliver Atelier Coverage: All Primitives Demonstrated ✓',
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

Widget _atelierTile(String title, String subtitle, int tone, int accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(tone),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(accent), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 8.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: Color(accent),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: Color(accent),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10.5, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _gridChip(String label, int tone, int accent) {
  return Container(
    decoration: BoxDecoration(
      color: Color(tone),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(accent), width: 1.0),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Color(accent),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.5,
            color: Color(accent),
          ),
        ),
      ],
    ),
  );
}
