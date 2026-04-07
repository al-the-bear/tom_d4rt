// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverOverlapAbsorberHandle
// Demonstrates SliverOverlapAbsorberHandle — the coordination object that
// carries overlap information between SliverOverlapAbsorber (which measures
// overlap in a header area) and SliverOverlapInjector (which injects
// compensating padding). The handle is typically obtained via
// NestedScrollView.sliverOverlapAbsorberHandleFor(context).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverOverlapAbsorberHandle Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.handshake,
      'title': 'What Is SliverOverlapAbsorberHandle?',
      'body': 'SliverOverlapAbsorberHandle is a ChangeNotifier that acts '
          'as a coordination bridge between a SliverOverlapAbsorber and one '
          'or more SliverOverlapInjectors. The absorber writes the overlap '
          'extent into the handle, and every injector listening to the '
          'handle reads it to inject compensating space.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.layers,
      'title': 'The Overlap Problem',
      'body': 'In a NestedScrollView, a SliverAppBar in the outer scroll '
          'view overlaps the inner scroll view during scrolling. Without '
          'compensation, content in the inner list hides behind the app '
          'bar. The handle communicates exactly how many pixels of overlap '
          'exist so the injector can add padding at the top of inner lists.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.settings_input_composite,
      'title': 'How It Works',
      'body': 'The absorber wraps the overlapping header sliver and '
          'measures how much of it extends into the inner scroll region. '
          'It writes that value (layoutExtent) to the handle. The injector, '
          'placed at the top of each inner scroll list, reads the handle '
          'and reserves that space so content does not sit behind the header.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.tab,
      'title': 'Multi-Tab Coordination',
      'body': 'In a tabbed NestedScrollView, each tab body has its own '
          'inner ScrollController. But they all share the same '
          'SliverOverlapAbsorberHandle so every tab body compensates '
          'equally for the outer header overlap. This keeps scrolling '
          'consistent across all tabs.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.15), accent.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorRows = <Map<String, String>>[
    {
      'field': 'SliverOverlapAbsorberHandle()',
      'desc': 'Creates a new handle. No parameters — it is basically a '
          'ChangeNotifier with a layoutExtent property.',
    },
    {
      'field': 'handle.layoutExtent',
      'desc': 'The number of pixels of overlap currently being absorbed. '
          'Written by SliverOverlapAbsorber, read by SliverOverlapInjector.',
    },
    {
      'field': 'handle.scrollExtent',
      'desc': 'The total scroll extent of the absorber\'s child sliver. '
          'Useful for computing how far the header can collapse.',
    },
    {
      'field': 'handle.addListener / removeListener',
      'desc': 'Standard ChangeNotifier API — injectors listen to the handle '
          'to know when the overlap changes and rebuild accordingly.',
    },
    {
      'field': 'handle.dispose()',
      'desc': 'Must be called when the handle is no longer needed. '
          'NestedScrollView manages this automatically for its internal handle.',
    },
    {
      'field': 'NestedScrollView.sliverOverlapAbsorberHandleFor(context)',
      'desc': 'Static method to obtain the handle from the NestedScrollView. '
          'Returns the handle the absorber/injector pair should use.',
    },
  ];

  final constructorWidgets = <Widget>[];
  for (var i = 0; i < constructorRows.length; i++) {
    final row = constructorRows[i];
    print('Constructor row ${i + 1}: ${row['field']}');
    constructorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                row['field']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Handle Basics — Diagram of the data flow
  // ============================================================
  print('=== Section 3: Handle Basics ===');

  // Build a visual "data-flow" diagram using containers
  Widget buildFlowBox(String label, Color bg, IconData icon) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: bg.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bg.withOpacity(0.4), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: bg, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: bg,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArrow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_downward, color: Colors.grey, size: 20),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  print('Building data-flow diagram');

  final dataFlowDiagram = Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.teal.withOpacity(0.25)),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        const Text(
          'Data Flow: Absorber → Handle → Injector',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 16),
        buildFlowBox(
          'SliverAppBar\n(header sliver)',
          Colors.deepOrange,
          Icons.web_asset,
        ),
        buildArrow('wrapped by'),
        buildFlowBox(
          'SliverOverlapAbsorber\n(measures overlap)',
          Colors.indigo,
          Icons.straighten,
        ),
        buildArrow('writes layoutExtent to'),
        buildFlowBox(
          'SliverOverlapAbsorberHandle\n(ChangeNotifier bridge)',
          Colors.teal,
          Icons.handshake,
        ),
        buildArrow('notifies'),
        buildFlowBox(
          'SliverOverlapInjector\n(injects top padding)',
          Colors.green,
          Icons.vertical_align_top,
        ),
        buildArrow('so content starts below'),
        buildFlowBox(
          'SliverList / SliverGrid\n(actual content)',
          Colors.blueGrey,
          Icons.list,
        ),
      ],
    ),
  );

  // properties panel
  final propertiesPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.withOpacity(0.08), Colors.cyan.withOpacity(0.04)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Handle Properties at a Glance',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 12),
        _soahRefRow('Type', 'ChangeNotifier subclass'),
        _soahRefRow('layoutExtent', 'Pixels of overlap being absorbed'),
        _soahRefRow('scrollExtent', 'Total scroll extent of the wrapped sliver'),
        _soahRefRow('Listeners', 'Injectors add themselves as listeners'),
        _soahRefRow('Disposal', 'NestedScrollView disposes automatically'),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: NestedScrollView Integration
  // ============================================================
  print('=== Section 4: NestedScrollView integration ===');

  // A real NestedScrollView with SliverOverlapAbsorber + SliverOverlapInjector
  final nestedDemo = SizedBox(
    height: 480,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverAppBar(
              title: const Text('Nested Header'),
              backgroundColor: Colors.teal.shade700,
              expandedHeight: 160,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade800, Colors.cyan.shade600],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.handshake, color: Colors.white70, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Handle coordinates this header\'s overlap',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(
        builder: (BuildContext ctx) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext childCtx, int index) {
                    final colors = [
                      Colors.teal.shade50,
                      Colors.cyan.shade50,
                      Colors.green.shade50,
                      Colors.amber.shade50,
                    ];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.teal.withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal.shade200,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'List Item ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Injector ensures this content starts '
                                  'below the pinned app bar.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 25,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  print('NestedScrollView demo built with header + injected body');

  // ============================================================
  // SECTION 5: Multi-Tab with shared handle
  // ============================================================
  print('=== Section 5: Multi-Tab demo ===');

  final tabCategories = <Map<String, dynamic>>[
    {
      'label': 'News',
      'icon': Icons.newspaper,
      'color': Colors.blue,
      'items': ['Breaking: Flutter 4 Released', 'Dart 3.8 Announced',
        'Material You Updates', 'DevTools Revamp', 'Wasm Support GA',
        'NestedScrollView Improvements', 'SliverOverlap Docs Updated',
        'Community Packages Surge', 'WebAssembly Perf Gains',
        'Hot Reload Gets Faster'],
    },
    {
      'label': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Colors.green,
      'items': ['Champions League Semi-Finals', 'Olympic Qualifiers',
        'Tennis Grand Slam Preview', 'F1 Season Opening', 'Rugby World Cup',
        'NBA Playoff Race', 'Cricket World Series', 'Golf Masters Preview',
        'Swimming Records Broken', 'Marathon Season Begins'],
    },
    {
      'label': 'Tech',
      'icon': Icons.computer,
      'color': Colors.deepPurple,
      'items': ['AI Code Assistants Evolve', 'Quantum Computing Milestone',
        'Foldable Phone Market Grows', 'Edge Computing Trends',
        'VR Workspace Adoption', 'Neural Interface Demos',
        'Open-Source LLM Advances', 'Chip Fabrication at 1nm',
        'Battery Tech Breakthrough', 'Privacy Regulations Update'],
    },
  ];

  final multiTabDemo = SizedBox(
    height: 500,
    child: DefaultTabController(
      length: tabCategories.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverAppBar(
                title: const Text('Multi-Tab Handle'),
                backgroundColor: Colors.teal.shade800,
                pinned: true,
                expandedHeight: 130,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: tabCategories.map((cat) {
                    return Tab(
                      icon: Icon(cat['icon'] as IconData),
                      text: cat['label'] as String,
                    );
                  }).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: tabCategories.map((cat) {
            return Builder(
              builder: (BuildContext ctx) {
                final items = cat['items'] as List<String>;
                final catColor = cat['color'] as Color;
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext childCtx, int index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: catColor.withOpacity(0.2),
                                ),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: catColor.withOpacity(0.15),
                                  child: Icon(
                                    cat['icon'] as IconData,
                                    color: catColor,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  items[index],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  'Category: ${cat['label']} — '
                                  'same handle ensures consistent padding',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: catColor.withOpacity(0.4),
                                ),
                              ),
                            );
                          },
                          childCount: items.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    ),
  );

  print('Multi-tab NestedScrollView demo: ${tabCategories.length} tabs sharing handle');

  // ============================================================
  // SECTION 6: Lifecycle — when handle values change
  // ============================================================
  print('=== Section 6: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Handle Created',
      'detail': 'NestedScrollView creates a SliverOverlapAbsorberHandle '
          'in initState and stores it as a member variable. '
          'layoutExtent and scrollExtent start at 0.0.',
      'icon': Icons.add_circle_outline,
      'color': Colors.blue,
    },
    {
      'step': '2',
      'title': 'Absorber Attaches',
      'detail': 'SliverOverlapAbsorber receives the handle as a constructor '
          'parameter. During performLayout, it measures the overlap of its '
          'child sliver and writes layoutExtent and scrollExtent to the handle.',
      'icon': Icons.link,
      'color': Colors.teal,
    },
    {
      'step': '3',
      'title': 'Injector Listens',
      'detail': 'SliverOverlapInjector adds itself as a listener to the '
          'handle. When layoutExtent changes, the injector marks itself for '
          'relayout and reads the current value to size its paint extent.',
      'icon': Icons.hearing,
      'color': Colors.purple,
    },
    {
      'step': '4',
      'title': 'User Scrolls',
      'detail': 'As the user scrolls, the app bar collapses. On each frame, '
          'the absorber recalculates the overlap and updates the handle. '
          'Listeners (injectors) are notified and rebuild, adjusting the '
          'compensating space in the inner scroll view.',
      'icon': Icons.swipe_vertical,
      'color': Colors.orange,
    },
    {
      'step': '5',
      'title': 'Tab Changes',
      'detail': 'When the user switches tabs, each tab body has its own '
          'SliverOverlapInjector but all of them listen to the SAME handle. '
          'The newly visible tab reads the current layoutExtent and '
          'compensates correctly from frame one.',
      'icon': Icons.tab,
      'color': Colors.deepPurple,
    },
    {
      'step': '6',
      'title': 'Handle Disposed',
      'detail': 'When the NestedScrollView is removed from the tree, it '
          'calls handle.dispose(). All listeners are released, preventing '
          'memory leaks. Custom handles need manual disposal.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final stepColor = step['color'] as Color;
    print('Lifecycle step ${step['step']}: ${step['title']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline column
              SizedBox(
                width: 48,
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: stepColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: stepColor, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          step['step'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: stepColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    if (i < lifecycleSteps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: stepColor.withOpacity(0.25),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: stepColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: stepColor.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            step['icon'] as IconData,
                            color: stepColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            step['title'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: stepColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        step['detail'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Patterns — common usage patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Basic NestedScrollView',
      'code': 'NestedScrollView(\n'
          '  headerSliverBuilder: (ctx, inner) => [\n'
          '    SliverOverlapAbsorber(\n'
          '      handle: NestedScrollView\n'
          '        .sliverOverlapAbsorberHandleFor(ctx),\n'
          '      sliver: SliverAppBar(...),\n'
          '    ),\n'
          '  ],\n'
          '  body: Builder(builder: (ctx) {\n'
          '    return CustomScrollView(slivers: [\n'
          '      SliverOverlapInjector(\n'
          '        handle: NestedScrollView\n'
          '          .sliverOverlapAbsorberHandleFor(ctx),\n'
          '      ),\n'
          '      SliverList(...),\n'
          '    ]);\n'
          '  }),\n'
          ')',
      'note': 'The most common pattern. The Builder is required to get the '
          'correct context that has access to the handle.',
      'icon': Icons.looks_one,
      'color': Colors.teal,
    },
    {
      'title': 'Custom Handle (Manual)',
      'code': 'final handle = SliverOverlapAbsorberHandle();\n'
          '// ...\n'
          'SliverOverlapAbsorber(\n'
          '  handle: handle,\n'
          '  sliver: mySliverHeader,\n'
          ')\n'
          '// ...\n'
          'SliverOverlapInjector(handle: handle)\n'
          '// ...\n'
          'handle.dispose(); // in State.dispose()',
      'note': 'Creating a handle manually outside NestedScrollView. You must '
          'remember to dispose it yourself in the State.dispose() method.',
      'icon': Icons.looks_two,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Listening for Changes',
      'code': 'handle.addListener(() {\n'
          '  print(\'Overlap: \${handle.layoutExtent}\');\n'
          '  print(\'Scroll: \${handle.scrollExtent}\');\n'
          '});\n'
          '// Remove in dispose:\n'
          '// handle.removeListener(callback);',
      'note': 'Since SliverOverlapAbsorberHandle extends ChangeNotifier, '
          'you can listen for overlap value changes to trigger custom behavior.',
      'icon': Icons.looks_3,
      'color': Colors.indigo,
    },
    {
      'title': 'Multiple Inner Lists',
      'code': 'TabBarView(\n'
          '  children: tabs.map((tab) {\n'
          '    return Builder(builder: (ctx) {\n'
          '      return CustomScrollView(slivers: [\n'
          '        SliverOverlapInjector(\n'
          '          handle: NestedScrollView\n'
          '            .sliverOverlapAbsorberHandleFor(ctx),\n'
          '        ),\n'
          '        SliverList(...),\n'
          '      ]);\n'
          '    });\n'
          '  }).toList(),\n'
          ')',
      'note': 'Each tab body gets its own injector but they all share the '
          'same handle. The Builder context is essential.',
      'icon': Icons.looks_4,
      'color': Colors.purple,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    final pColor = p['color'] as Color;
    print('Pattern ${i + 1}: ${p['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.25)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: pColor.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: pColor.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(p['icon'] as IconData, color: pColor, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                p['code'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey.shade800,
                  height: 1.45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 16, color: pColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      p['note'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.handshake,
      'text': 'SliverOverlapAbsorberHandle is a ChangeNotifier bridge '
          'carrying overlap extent data between absorber and injector.',
    },
    {
      'icon': Icons.straighten,
      'text': 'layoutExtent: how many pixels of overlap are being absorbed. '
          'scrollExtent: total scroll extent of the absorber child.',
    },
    {
      'icon': Icons.auto_awesome,
      'text': 'NestedScrollView creates and manages the handle automatically '
          '— retrieve it with sliverOverlapAbsorberHandleFor(context).',
    },
    {
      'icon': Icons.tab,
      'text': 'In multi-tab layouts, all TabBarView children share the '
          'same handle so overlap compensation is consistent.',
    },
    {
      'icon': Icons.build,
      'text': 'Use Builder to obtain the correct context inside '
          'headerSliverBuilder and inside each tab body.',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Custom (manually-created) handles must be disposed. '
          'NestedScrollView disposes its handle automatically.',
    },
    {
      'icon': Icons.architecture,
      'text': 'The absorber-handle-injector trio solves the clipping '
          'problem when headers overlap inner scroll regions.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverOverlapAbsorberHandle'),
        backgroundColor: Colors.teal.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.account_tree), text: 'Handle Basics'),
            Tab(icon: Icon(Icons.layers), text: 'Nested Scroll'),
            Tab(icon: Icon(Icons.tab), text: 'Multi-Tab'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverOverlapAbsorberHandle is the invisible coordination '
                  'object at the heart of NestedScrollView overlap management. '
                  'It carries the measured overlap value from the absorber '
                  '(in the header area) to every injector (in the body area).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Constructor
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The handle has a trivial constructor — no parameters. Its '
                  'power comes from being shared between absorber and injector. '
                  'Here are the key API members:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
            ],
          ),

          // Tab 3: Handle Basics
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The diagram below shows how data flows from the header '
                  'through the absorber, into the handle, and out through '
                  'the injector to protect content from being hidden.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              dataFlowDiagram,
              propertiesPanel,
            ],
          ),

          // Tab 4: NestedScrollView integration
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A live NestedScrollView with SliverOverlapAbsorber wrapping '
                  'the SliverAppBar and SliverOverlapInjector in the body. '
                  'Scroll to see the handle coordinate overlap compensation.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: nestedDemo,
                ),
              ),
            ],
          ),

          // Tab 5: Multi-Tab
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A tabbed NestedScrollView where News, Sports, and Tech '
                  'tabs all share the same SliverOverlapAbsorberHandle. '
                  'Switch tabs to verify that each gets correct padding.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: multiTabDemo,
                ),
              ),
            ],
          ),

          // Tab 6: Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Follow the lifecycle of a SliverOverlapAbsorberHandle from '
                  'creation through scroll events and tab changes to disposal.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),

          // Tab 7: Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common code patterns showing how to use '
                  'SliverOverlapAbsorberHandle in different scenarios.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.cyan.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about SliverOverlapAbsorberHandle and how '
                  'it fits into the NestedScrollView overlap system.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER: Reference row for property/value display
// ============================================================
Widget _soahRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
