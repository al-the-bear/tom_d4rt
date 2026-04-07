// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ViewCollection
// Demonstrates ViewCollection, a widget that manages multiple FlutterViews.
// ViewCollection is the root-level widget for multi-view Flutter apps,
// hosting and coordinating the lifecycle of two or more independent views.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewCollection Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.collections,
      'title': 'What is ViewCollection?',
      'body': 'ViewCollection is a widget that groups multiple View '
          'widgets together. It serves as the root for multi-view '
          'Flutter applications where the framework manages more '
          'than one FlutterView simultaneously.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.view_carousel,
      'title': 'Multiple Rendering Surfaces',
      'body': 'Each View within a ViewCollection gets its own rendering '
          'pipeline. They are independently laid out, painted, and '
          'composited. This is fundamentally different from using '
          'multiple widgets within a single view.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.hub,
      'title': 'Centralized Management',
      'body': 'ViewCollection coordinates the lifecycle of all its views. '
          'When views are added or removed, the collection handles '
          'creation and disposal of the associated rendering resources. '
          'It ensures consistent frame scheduling.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.devices,
      'title': 'Multi-Window / Multi-Display',
      'body': 'The primary use case is multi-window or multi-display '
          'applications. Each window or display gets its own View '
          'inside the ViewCollection. Desktop apps can span multiple '
          'monitors with independent content.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
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
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'views',
      'type': 'List<Widget>',
      'desc': 'The list of View widgets managed by this collection. Each '
          'View wraps a FlutterView and establishes an independent '
          'rendering pipeline with its own build/layout/paint cycle.',
    },
    {
      'name': 'View',
      'type': 'Widget',
      'desc': 'An individual view within the collection. Wraps a single '
          'FlutterView and provides a MediaQuery, Directionality, '
          'and other essentials for its subtree.',
    },
    {
      'name': 'ViewAnchor',
      'type': 'Widget (related)',
      'desc': 'Associates a secondary view with a position in a primary '
          'view\u0027s widget tree. ViewAnchor effectively adds a '
          'view to the collection anchored at a specific widget.',
    },
    {
      'name': 'WidgetsBinding.instance.platformDispatcher',
      'type': 'PlatformDispatcher',
      'desc': 'Provides access to all available FlutterViews. '
          'ViewCollection typically iterates over the dispatcher\u0027s '
          'views to create one View widget per FlutterView.',
    },
    {
      'name': 'wrapWithDefaultView',
      'type': 'bool',
      'desc': 'In WidgetsApp/MaterialApp: if false, the app does not '
          'wrap its content in a default single view. Instead, '
          'the builder can return a ViewCollection for multi-view.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
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
  // SECTION 3: Adding Views
  // ============================================================
  print('=== Section 3: Adding Views ===');

  final addViewSteps = <Map<String, dynamic>>[
    {
      'step': '1. Enumerate FlutterViews',
      'desc': 'Query PlatformDispatcher.views to discover all available '
          'FlutterViews. Each represents a window, display, or '
          'rendering surface provided by the platform.',
      'icon': Icons.search,
      'color': Colors.teal,
    },
    {
      'step': '2. Create View Widgets',
      'desc': 'For each FlutterView, create a View widget. The View '
          'establishes an independent rendering pipeline bound '
          'to that specific FlutterView.',
      'icon': Icons.add_box,
      'color': Colors.blue,
    },
    {
      'step': '3. Assemble ViewCollection',
      'desc': 'Pass the list of View widgets to ViewCollection\u0027s '
          'views parameter. The collection becomes the root of '
          'the multi-view widget tree.',
      'icon': Icons.collections,
      'color': Colors.green,
    },
    {
      'step': '4. Listen for View Changes',
      'desc': 'Subscribe to PlatformDispatcher.onViewsChanged to detect '
          'when windows open or close. Rebuild the ViewCollection '
          'to add or remove corresponding View widgets.',
      'icon': Icons.notifications_active,
      'color': Colors.orange,
    },
    {
      'step': '5. Hot-Add New Views',
      'desc': 'When a new FlutterView appears (new window), add a View '
          'widget to the collection. The framework creates the '
          'rendering pipeline and starts painting the new view.',
      'icon': Icons.fiber_new,
      'color': Colors.purple,
    },
  ];

  final addViewWidgets = <Widget>[];
  for (var i = 0; i < addViewSteps.length; i++) {
    final av = addViewSteps[i];
    final avColor = av['color'] as Color;
    print('AddView ${i + 1}: ${av['step']}');
    addViewWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: avColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    av['icon'] as IconData,
                    color: avColor,
                    size: 18,
                  ),
                ),
                if (i < addViewSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: avColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: avColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: avColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      av['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: avColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      av['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Removing Views
  // ============================================================
  print('=== Section 4: Removing Views ===');

  final removeTopics = <Map<String, dynamic>>[
    {
      'title': 'Window Close Detection',
      'desc': 'When the platform closes a window, its FlutterView is '
          'removed from PlatformDispatcher.views. The '
          'onViewsChanged callback fires, triggering a rebuild.',
      'color': Colors.red,
    },
    {
      'title': 'Remove View Widget',
      'desc': 'Remove the corresponding View widget from the collection\u0027s '
          'views list during rebuild. The framework unmounts the View '
          'and disposes its rendering pipeline.',
      'color': Colors.orange,
    },
    {
      'title': 'Resource Cleanup',
      'desc': 'The framework automatically releases render objects, '
          'layers, and compositing resources. State objects in '
          'the removed view\u0027s subtree are disposed normally.',
      'color': Colors.teal,
    },
    {
      'title': 'Graceful Shutdown',
      'desc': 'Views can animate out before removal. Use a state variable '
          'to trigger an exit animation, then remove the View widget '
          'after the animation completes.',
      'color': Colors.blue,
    },
  ];

  final removeWidgets = <Widget>[];
  for (var i = 0; i < removeTopics.length; i++) {
    final rt = removeTopics[i];
    final rtColor = rt['color'] as Color;
    print('Remove ${i + 1}: ${rt['title']}');
    removeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: rtColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: rtColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: rtColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rt['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: rtColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rt['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 5: Lifecycle
  // ============================================================
  print('=== Section 5: Lifecycle ===');

  final lifecyclePhases = <Map<String, dynamic>>[
    {
      'phase': 'App Startup',
      'desc': 'The app creates a ViewCollection with one View per '
          'initial FlutterView. The framework initializes rendering '
          'pipelines for each view in the collection.',
      'icon': Icons.power_settings_new,
      'color': Colors.teal,
    },
    {
      'phase': 'View Added (Window Opens)',
      'desc': 'A new FlutterView appears (user opens new window). '
          'onViewsChanged fires. App rebuilds with an additional '
          'View in the collection. New rendering pipeline starts.',
      'icon': Icons.open_in_new,
      'color': Colors.green,
    },
    {
      'phase': 'Views Active',
      'desc': 'All views render independently. Each has its own frame '
          'schedule. User interacts with any view. State can be '
          'shared across views via inherited widgets above the '
          'ViewCollection.',
      'icon': Icons.play_circle,
      'color': Colors.blue,
    },
    {
      'phase': 'View Removed (Window Closes)',
      'desc': 'A FlutterView is removed. onViewsChanged fires. App '
          'removes the corresponding View. State objects dispose. '
          'Rendering resources release.',
      'icon': Icons.close,
      'color': Colors.orange,
    },
    {
      'phase': 'App Shutdown',
      'desc': 'All remaining views unmount. The ViewCollection disposes '
          'all child View widgets and their associated rendering '
          'pipelines. Final cleanup occurs.',
      'icon': Icons.power_off,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecyclePhases.length; i++) {
    final lp = lifecyclePhases[i];
    final lpColor = lp['color'] as Color;
    print('Lifecycle ${i + 1}: ${lp['phase']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lpColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    lp['icon'] as IconData,
                    color: lpColor,
                    size: 20,
                  ),
                ),
                if (i < lifecyclePhases.length - 1)
                  Container(
                    width: 2,
                    height: 28,
                    color: lpColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lpColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lpColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lp['phase'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: lpColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lp['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Layout
  // ============================================================
  print('=== Section 6: Layout ===');

  final layoutTopics = <Map<String, dynamic>>[
    {
      'title': 'Independent Layout',
      'desc': 'Each View in the collection is laid out independently. '
          'They do not share constraints. A phone-sized view and '
          'a tablet-sized view can coexist in one collection.',
      'color': Colors.teal,
    },
    {
      'title': 'View Size from FlutterView',
      'desc': 'Each View\u0027s size comes from the FlutterView\u0027s '
          'physicalSize and devicePixelRatio. The framework '
          'provides tight constraints matching the view dimensions '
          'to the View widget\u0027s child.',
      'color': Colors.blue,
    },
    {
      'title': 'No Z-Order Between Views',
      'desc': 'Views in a collection do not have a defined z-order '
          'relative to each other. The platform compositor decides '
          'visibility. In windowed mode, the window manager handles '
          'overlapping.',
      'color': Colors.orange,
    },
    {
      'title': 'Shared InheritedWidgets',
      'desc': 'InheritedWidgets placed above the ViewCollection are '
          'accessible from all views. This is how themes, locales, '
          'and app-wide state are shared across views.',
      'color': Colors.green,
    },
    {
      'title': 'Per-View MediaQuery',
      'desc': 'Each View establishes its own MediaQuery based on its '
          'FlutterView\u0027s properties. A view on a high-DPI '
          'display has different pixelRatio than one on a low-DPI '
          'display.',
      'color': Colors.purple,
    },
  ];

  final layoutWidgets = <Widget>[];
  for (var i = 0; i < layoutTopics.length; i++) {
    final lt = layoutTopics[i];
    final ltColor = lt['color'] as Color;
    print('Layout ${i + 1}: ${lt['title']}');
    layoutWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ltColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ltColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: ltColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ltColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ltColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    lt['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Multi-Window Desktop App',
      'desc': 'Each window gets its own View widget. ViewCollection at '
          'the root manages all windows. Windows can be opened and '
          'closed dynamically by adding/removing Views.',
      'icon': Icons.desktop_windows,
      'color': Colors.teal,
    },
    {
      'title': 'Multi-Display Kiosk',
      'desc': 'A kiosk with multiple screens. Each screen is a FlutterView. '
          'ViewCollection renders different content on each screen. '
          'Maps, menus, and information displays run independently.',
      'icon': Icons.connected_tv,
      'color': Colors.blue,
    },
    {
      'title': 'Primary + Companion View',
      'desc': 'A main editing view with a companion panel view. The '
          'editing view has the document; the companion shows '
          'properties or preview. Both share app state.',
      'icon': Icons.view_sidebar,
      'color': Colors.green,
    },
    {
      'title': 'Mirrored Views',
      'desc': 'Two views showing the same data with different layouts. '
          'A presenter view (full screen) and a controller view '
          '(with notes and controls) share one reactive state.',
      'icon': Icons.screen_share,
      'color': Colors.orange,
    },
    {
      'title': 'Embedded + Floating',
      'desc': 'An embedded Flutter view within a native app, plus '
          'floating overlay views using ViewAnchor. The collection '
          'manages both the embedded and anchored views.',
      'icon': Icons.picture_in_picture_alt,
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  p['icon'] as IconData,
                  color: pColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: pColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.collections,
      'text': 'ViewCollection groups multiple View widgets into a '
          'single root for multi-view Flutter applications.',
    },
    {
      'icon': Icons.view_carousel,
      'text': 'Each View runs an independent rendering pipeline '
          'with its own layout, paint, and compositing passes.',
    },
    {
      'icon': Icons.sync,
      'text': 'Views can be added and removed dynamically by '
          'listening to PlatformDispatcher.onViewsChanged.',
    },
    {
      'icon': Icons.share,
      'text': 'InheritedWidgets above the ViewCollection are shared '
          'across all views for common state and theming.',
    },
    {
      'icon': Icons.devices,
      'text': 'Primary use cases include multi-window desktop apps, '
          'multi-display kiosks, and embedded Flutter views.',
    },
    {
      'icon': Icons.memory,
      'text': 'Each view has its own MediaQuery, reflecting the '
          'properties of its specific FlutterView.',
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
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
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
                color: Colors.teal.shade800,
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
        title: const Text('ViewCollection'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.add_box), text: 'Adding'),
            Tab(icon: Icon(Icons.remove_circle), text: 'Removing'),
            Tab(icon: Icon(Icons.loop), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.grid_view), text: 'Layout'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
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
                  'ViewCollection: manage multiple Views for multi-window '
                  'and multi-display Flutter applications.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
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
                  'ViewCollection API and related multi-view widgets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
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
                  'How views are added to a ViewCollection dynamically.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...addViewWidgets,
            ],
          ),
          // Tab 4
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
                  'How views are removed and their resources cleaned up.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...removeWidgets,
            ],
          ),
          // Tab 5
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
                  'View lifecycle from app startup to shutdown.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),
          // Tab 6
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
                  'Layout independence across views in a collection.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...layoutWidgets,
            ],
          ),
          // Tab 7
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
                  'Common patterns for multi-view Flutter applications.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),
          // Tab 8
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
                  'Key takeaways about ViewCollection.',
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
