// ignore_for_file: avoid_print
// D4rt deep demo: NestedScrollViewState — coordinated dual-controller scroll management
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Denim / Chambray ──────────────────────────────────────
  const deepDenim = Color(0xFF1A237E);
  const denim = Color(0xFF283593);
  const chambray = Color(0xFF3949AB);
  const softDenim = Color(0xFF5C6BC0);
  const lightChambray = Color(0xFF7986CB);
  const paleDenim = Color(0xFFE8EAF6);
  const whiteDenim = Color(0xFFF5F6FC);
  const darkNavy = Color(0xFF0D1042);
  const accentAmber = Color(0xFFFF8F00);
  const accentTeal = Color(0xFF00897B);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkNavy)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkNavy)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('NestedScrollViewState deep demo executing');
  print('=' * 60);

  print('\n--- What is NestedScrollViewState ---');
  print('The State object for NestedScrollView widget');
  print('Extends State<NestedScrollView>');
  print('Manages two coordinated scroll controllers');
  print('  innerController — controls body scrolling');
  print('  outerController — controls header sliver scrolling');

  print('\n--- Scroll coordination ---');
  print('When outer scroll reaches max extent, inner takes over');
  print('Uses NestedScrollCoordinator internally');
  print('SliverOverlapAbsorber/Injector handle overlap');

  print('\n--- Lifecycle ---');
  print('initState: creates coordinator');
  print('didChangeDependencies: sets parent controller');
  print('didUpdateWidget: handles widget config changes');
  print('dispose: cleans up coordinator and controllers');

  print('\n${'=' * 60}');
  print('NestedScrollViewState deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepDenim, denim, chambray],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.swap_vert, size: 28, color: paleDenim),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NestedScrollViewState',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('State<NestedScrollView> — coordinates dual-controller scrolling for headers and body',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('State', chambray, Colors.white),
                tag('innerController', softDenim, darkNavy),
                tag('outerController', lightChambray, darkNavy),
                tag('Coordinator', paleDenim, darkNavy),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NestedScrollViewState',
            'The State object that manages NestedScrollView\'s scrolling',
            deepDenim, Colors.white),
        noteBox(
          'NestedScrollViewState is the State for NestedScrollView. It '
          'exposes two scroll controllers — innerController for the body '
          'content and outerController for the header slivers. These '
          'controllers are coordinated so that when the outer scroll '
          'reaches its maximum extent, scrolling seamlessly transfers to '
          'the inner body. This coordination is managed by an internal '
          'NestedScrollCoordinator.',
          denim,
          whiteDenim,
        ),
        dataRow('Extends', 'State<NestedScrollView>', denim),
        dataRow('Inner controller', 'ScrollController — body scroll', deepDenim),
        dataRow('Outer controller', 'ScrollController — header scroll', chambray),
        dataRow('Coordinator', 'NestedScrollCoordinator (internal)', softDenim),
        dataRow('Defined in', 'widgets/nested_scroll_view.dart', darkNavy),
        const SizedBox(height: 14),

        // ── 3. Dual controller architecture ──────────────────────────
        sectionBanner('2 \u00b7 Dual Controller Architecture',
            'Two controllers, one coordinated experience',
            denim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightChambray),
          ),
          child: Column(
            children: [
              // Outer controller
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentAmber.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentAmber, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.vertical_align_top, size: 20,
                            color: accentAmber),
                        const SizedBox(width: 8),
                        Text('outerController',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'monospace',
                                color: accentAmber)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Controls the header slivers region',
                        style: TextStyle(fontSize: 12, color: darkNavy)),
                    const SizedBox(height: 4),
                    Text('Scrolls: SliverAppBar, SliverList headers, etc.',
                        style: TextStyle(fontSize: 11, color: softDenim)),
                    Text('Range: 0 → maxScrollExtent of header region',
                        style: TextStyle(fontSize: 11, color: softDenim)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Icon(Icons.sync_alt, size: 20, color: chambray),
                    Text('Coordinator handoff',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: chambray)),
                  ],
                ),
              ),
              // Inner controller
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentTeal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentTeal, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.vertical_align_bottom, size: 20,
                            color: accentTeal),
                        const SizedBox(width: 8),
                        Text('innerController',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'monospace',
                                color: accentTeal)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Controls the body content region',
                        style: TextStyle(fontSize: 12, color: darkNavy)),
                    const SizedBox(height: 4),
                    Text('Scrolls: body ListView, GridView, CustomScrollView',
                        style: TextStyle(fontSize: 11, color: softDenim)),
                    Text('Range: 0 → maxScrollExtent of body content',
                        style: TextStyle(fontSize: 11, color: softDenim)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Visual: NestedScrollView structure ────────────────────
        sectionBanner('3 \u00b7 Visual: NestedScrollView Structure',
            'What the widget tree looks like',
            chambray, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Root container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepDenim.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepDenim, width: 2),
                ),
                child: Column(
                  children: [
                    Text('NestedScrollView',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'monospace',
                            color: deepDenim)),
                    const SizedBox(height: 8),
                    // Header slivers
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentAmber),
                      ),
                      child: Column(
                        children: [
                          Text('headerSliverBuilder',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: accentAmber)),
                          const SizedBox(height: 4),
                          for (final sliver in [
                            'SliverAppBar',
                            'SliverPersistentHeader',
                            'SliverToBoxAdapter',
                          ])
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: accentAmber.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(sliver,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'monospace',
                                      color: darkNavy)),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Body
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentTeal.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentTeal),
                      ),
                      child: Column(
                        children: [
                          Text('body',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: accentTeal)),
                          const SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: accentTeal.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('ListView / GridView / CustomScrollView',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: darkNavy)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Live demo: NestedScrollView with SliverAppBar ─────────
        sectionBanner('4 \u00b7 Live Demo: NestedScrollView With SliverAppBar',
            'Classic collapsing header pattern using NestedScrollView',
            deepDenim, Colors.white),
        SizedBox(
          height: 350,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext innerContext, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 140,
                    pinned: true,
                    backgroundColor: denim,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Collapsing Header',
                          style: TextStyle(fontSize: 14)),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [deepDenim, chambray],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Icon(Icons.layers,
                              size: 50,
                              color: Colors.white.withValues(alpha: 0.3)),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  final isEven = index % 2 == 0;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isEven ? paleDenim : whiteDenim,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isEven ? denim : softDenim,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text('${index + 1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Body item ${index + 1}',
                            style: TextStyle(
                                fontSize: 13, color: darkNavy)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        noteBox(
          'The SliverAppBar collapses as you scroll. The header is managed '
          'by outerController and the ListView body by innerController. '
          'NestedScrollViewState coordinates the handoff between them.',
          denim,
          paleDenim,
        ),
        const SizedBox(height: 14),

        // ── 6. State lifecycle ───────────────────────────────────────
        sectionBanner('5 \u00b7 State Lifecycle',
            'How NestedScrollViewState initializes and disposes',
            denim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final phase in [
                (1, 'initState()', 'Creates the NestedScrollCoordinator, '
                    'sets up inner and outer scroll controllers',
                    accentTeal),
                (2, 'didChangeDependencies()', 'Sets the parent scroll '
                    'controller from the widget configuration. Called after initState.',
                    denim),
                (3, 'build()', 'Constructs the CustomScrollView with header '
                    'slivers and body. Wraps body in SliverFillRemaining.',
                    chambray),
                (4, 'didUpdateWidget()', 'When NestedScrollView config changes, '
                    'updates the coordinator with new controller/physics.',
                    softDenim),
                (5, 'dispose()', 'Disposes the scroll coordinator and both '
                    'controllers. Cleans up all scroll position listeners.',
                    deepDenim),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: phase.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: phase.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: phase.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${phase.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(phase.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: darkNavy)),
                            Text(phase.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Live demo: tabs with nested scrolling ─────────────────
        sectionBanner('6 \u00b7 Live Demo: Tabbed NestedScrollView',
            'Multiple tabs sharing one NestedScrollView',
            chambray, Colors.white),
        SizedBox(
          height: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext innerContext, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 100,
                      floating: true,
                      pinned: true,
                      backgroundColor: chambray,
                      title: Text('Tabbed View',
                          style: TextStyle(fontSize: 14)),
                      bottom: TabBar(
                        indicatorColor: accentAmber,
                        labelColor: Colors.white,
                        unselectedLabelColor:
                            Colors.white.withValues(alpha: 0.6),
                        tabs: [
                          Tab(text: 'Alpha'),
                          Tab(text: 'Beta'),
                          Tab(text: 'Gamma'),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    for (final tab in [
                      ('Alpha', accentAmber, Icons.star),
                      ('Beta', accentTeal, Icons.favorite),
                      ('Gamma', softDenim, Icons.diamond),
                    ])
                      ListView.builder(
                        itemCount: 20,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: tab.$2.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(6),
                              border: Border(
                                  left: BorderSide(
                                      color: tab.$2, width: 3)),
                            ),
                            child: Row(
                              children: [
                                Icon(tab.$3, size: 18, color: tab.$2),
                                const SizedBox(width: 8),
                                Text('${tab.$1} item ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: darkNavy)),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        noteBox(
          'The most common pattern: tabs inside a NestedScrollView. '
          'The SliverAppBar and TabBar are header slivers managed by '
          'outerController. Each tab\'s body list uses innerController. '
          'NestedScrollViewState coordinates the pinned TabBar with body scrolling.',
          chambray,
          paleDenim,
        ),
        const SizedBox(height: 14),

        // ── 8. Scroll handover mechanics ─────────────────────────────
        sectionBanner('7 \u00b7 Scroll Handover Mechanics',
            'How outer-to-inner scrolling transition works',
            deepDenim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                ('User drags down', 'Outer controller scrolls first — '
                    'header slivers collapse', accentAmber, Icons.swipe_down),
                ('Outer hits max', 'Header fully collapsed. Coordinator '
                    'detects boundary reached.', chambray, Icons.horizontal_rule),
                ('Inner takes over', 'Body content starts scrolling. '
                    'innerController now active.', accentTeal, Icons.swipe_up),
                ('User drags up', 'Inner scrolls back to zero first. '
                    'Then outer expands headers.', softDenim, Icons.undo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(step.$4, size: 20, color: step.$3),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkNavy)),
                            Text(step.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. SliverOverlapAbsorber / Injector ──────────────────────
        sectionBanner('8 \u00b7 SliverOverlapAbsorber & Injector',
            'How overlap is managed in nested scrolling',
            denim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentAmber),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.filter_none, size: 24,
                              color: accentAmber),
                          const SizedBox(height: 4),
                          Text('SliverOverlap\nAbsorber',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: accentAmber)),
                          const SizedBox(height: 4),
                          Text('Placed in header.\nAbsorbs the overlap\nof pinned slivers.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Icon(Icons.arrow_forward, size: 18,
                            color: chambray),
                        Text('handle',
                            style: TextStyle(
                                fontSize: 8, color: chambray)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentTeal.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentTeal),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.input, size: 24,
                              color: accentTeal),
                          const SizedBox(height: 4),
                          Text('SliverOverlap\nInjector',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: accentTeal)),
                          const SizedBox(height: 4),
                          Text('Placed in body.\nInjects space to\navoid header overlap.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'When a SliverAppBar is pinned, it overlaps the body content. '
                'SliverOverlapAbsorber wraps the app bar in the header to measure '
                'overlap. SliverOverlapInjector in the body adds padding equal to '
                'the absorbed overlap. The handle is obtained from '
                'NestedScrollView.sliverOverlapAbsorberHandleFor(context).',
                denim,
                paleDenim,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. floatHeaderSlivers vs pinned ─────────────────────────
        sectionBanner('9 \u00b7 floatHeaderSlivers Property',
            'Controlling header behavior during scroll',
            chambray, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.push_pin, size: 24, color: accentTeal),
                      const SizedBox(height: 4),
                      Text('floatHeaderSlivers:\nfalse (default)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentTeal)),
                      const SizedBox(height: 4),
                      Text('Headers scroll away\nnormally and stay\ncollapsed until user\nscrolls back to top.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkNavy)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentAmber.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentAmber, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swap_vert, size: 24, color: accentAmber),
                      const SizedBox(height: 4),
                      Text('floatHeaderSlivers:\ntrue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentAmber)),
                      const SizedBox(height: 4),
                      Text('Headers reappear as\nsoon as user scrolls\nup, even in the\nmiddle of the list.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkNavy)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Live demo: floating header ───────────────────────────
        sectionBanner('10 \u00b7 Live Demo: Floating Header Slivers',
            'Headers that reappear on scroll-up',
            deepDenim, Colors.white),
        SizedBox(
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext innerContext, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 80,
                    floating: true,
                    snap: true,
                    backgroundColor: deepDenim,
                    title: Row(
                      children: [
                        Icon(Icons.cloud, size: 18, color: paleDenim),
                        const SizedBox(width: 8),
                        Text('Floating Header',
                            style: TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                itemCount: 25,
                padding: const EdgeInsets.all(6),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: index % 3 == 0
                          ? denim.withValues(alpha: 0.06)
                          : index % 3 == 1
                              ? chambray.withValues(alpha: 0.06)
                              : softDenim.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Floating item ${index + 1}',
                        style: TextStyle(
                            fontSize: 12, color: darkNavy)),
                  );
                },
              ),
            ),
          ),
        ),
        noteBox(
          'With floatHeaderSlivers: true, the header snaps back into view '
          'when the user scrolls up slightly, even from mid-list. The State '
          'object coordinates this behavior through the scroll coordinator.',
          deepDenim,
          whiteDenim,
        ),
        const SizedBox(height: 14),

        // ── 12. innerBoxIsScrolled callback param ────────────────────
        sectionBanner('11 \u00b7 innerBoxIsScrolled Parameter',
            'Knowing when the body has scrolled',
            denim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: denim.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: denim.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'headerSliverBuilder: (\n'
                    '  BuildContext context,\n'
                    '  bool innerBoxIsScrolled,\n'
                    ') { ... }',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepDenim)),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentTeal.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentTeal),
                      ),
                      child: Column(
                        children: [
                          Text('false',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace',
                                  color: accentTeal)),
                          Text('Body is at top\nNo body scrolling',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentAmber.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentAmber),
                      ),
                      child: Column(
                        children: [
                          Text('true',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace',
                                  color: accentAmber)),
                          Text('Body has scrolled\nUseful for shadow/elevation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'innerBoxIsScrolled tells the header builder whether the body '
                'content has been scrolled. Common use: show elevation on the '
                'SliverAppBar when body is scrolled to give a shadow effect. '
                'Access via SliverAppBar\'s forceElevated property.',
                denim,
                paleDenim,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Common mistakes ──────────────────────────────────────
        sectionBanner('12 \u00b7 Common Mistakes',
            'Pitfalls when using NestedScrollView',
            chambray, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final mistake in [
                ('Forgetting SliverOverlapInjector',
                    'Body content overlaps pinned header. Always pair '
                    'SliverOverlapAbsorber in header with SliverOverlapInjector in body.',
                    Icons.warning_amber, accentAmber),
                ('Using ScrollController on body',
                    'Body\'s scroll controller is managed by the State. '
                    'Don\'t provide your own — use innerController instead.',
                    Icons.error_outline, Color(0xFFE53935)),
                ('Non-sliver children in header',
                    'headerSliverBuilder must return Sliver widgets only. '
                    'Wrap non-slivers in SliverToBoxAdapter.',
                    Icons.block, softDenim),
                ('Mixing scrollDirection',
                    'NestedScrollView only supports vertical scrolling. '
                    'For horizontal, use a different approach.',
                    Icons.swap_horiz, chambray),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: mistake.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: mistake.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(mistake.$3, size: 20, color: mistake.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mistake.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkNavy)),
                            Text(mistake.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Accessing the state ──────────────────────────────────
        sectionBanner('13 \u00b7 Accessing NestedScrollViewState',
            'How to programmatically access the state',
            deepDenim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: deepDenim.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepDenim.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Using a GlobalKey\n'
                    'final key = GlobalKey<NestedScrollViewState>();\n'
                    '\n'
                    'NestedScrollView(key: key, ...)\n'
                    '\n'
                    '// Access controllers\n'
                    'key.currentState!.innerController\n'
                    'key.currentState!.outerController',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepDenim)),
              ),
              noteBox(
                'A GlobalKey<NestedScrollViewState> gives access to both '
                'controllers. Use innerController.animateTo() or '
                'outerController.jumpTo() for programmatic scrolling.',
                deepDenim,
                paleDenim,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Class hierarchy ──────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Inheritance chain', denim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteDenim,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 State<NestedScrollView>', softDenim),
                ('    \u2514\u2500 NestedScrollViewState', denim),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: level.$1.contains('NestedScrollViewState')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepDenim, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepDenim, denim],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'State<NestedScrollView> — manages coordinated dual-axis scrolling',
                'Exposes innerController (body) and outerController (header)',
                'Internal coordinator handles seamless scroll handover',
                'Header slivers collapse first, then body scrolls',
                'SliverOverlapAbsorber/Injector prevent content overlap',
                'floatHeaderSlivers=true makes headers reappear on scroll up',
                'innerBoxIsScrolled callback param for header visual changes',
                'Tab + NestedScrollView is the classic collapsing header pattern',
                'Access via GlobalKey<NestedScrollViewState>',
                'Only supports vertical scroll direction',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightChambray,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
