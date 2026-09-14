// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — SnapshotController
// Demonstrates SnapshotController — a ChangeNotifier that controls
// when a SnapshotWidget rasterizes its child into an offscreen
// image for performance. Covers the allowSnapshotting property,
// listener pattern, performance implications, and the relationship
// between SnapshotWidget and RepaintBoundary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnapshotController Deep Demo executing');

  // ============================================================
  // SECTION 1: What is SnapshotController?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.camera_alt,
      'title': 'Widget Rasterization Controller',
      'body': 'SnapshotController extends ChangeNotifier and controls '
          'whether a SnapshotWidget rasterizes its child subtree into '
          'an offscreen image. When snapshotting is active, the child '
          'is painted once into a bitmap and reused for subsequent frames.',
      'accent': Colors.green[800]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Optimization',
      'body': 'Rasterizing complex widget subtrees into bitmaps avoids '
          'repeated layout and painting. Useful for scrolling lists '
          'with expensive children, complex decorations, or subtrees '
          'that don\'t change often.',
      'accent': Colors.blueGrey[700]!,
    },
    {
      'icon': Icons.notifications,
      'title': 'ChangeNotifier Pattern',
      'body': 'As a ChangeNotifier, SnapshotController notifies its '
          'listeners when allowSnapshotting changes. SnapshotWidget '
          'listens to the controller and decides whether to repaint '
          'from the cached image or rebuild the child live.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Dynamic Toggle',
      'body': 'You can toggle snapshotting on/off at runtime. Turn it '
          'on during animations or scrolling for smooth performance, '
          'then turn it off when the user interacts with the child '
          'and needs live updates.',
      'accent': Colors.blueGrey[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'allowSnapshotting',
      'type': 'bool (getter/setter)',
      'description': 'When true, the SnapshotWidget captures the child '
          'into a raster image. When false, the child is painted live. '
          'Setting this notifies all listeners.',
      'default': 'false',
      'icon': Icons.toggle_on,
      'color': Colors.green[800]!,
    },
    {
      'name': 'SnapshotController()',
      'type': 'Constructor',
      'description': 'Creates a new controller. Optional parameter '
          'allowSnapshotting sets the initial state. Extends '
          'ChangeNotifier so it inherits addListener, removeListener, '
          'dispose, and notifyListeners.',
      'default': 'allowSnapshotting: false',
      'icon': Icons.build,
      'color': Colors.blueGrey[700]!,
    },
    {
      'name': 'clear()',
      'type': 'void',
      'description': 'Clears any cached snapshot image. The next paint '
          'cycle will recapture the child if allowSnapshotting is '
          'true. Call this if the child content has changed while '
          'snapshotting was active.',
      'default': 'N/A',
      'icon': Icons.cleaning_services,
      'color': Colors.green[700]!,
    },
    {
      'name': 'addListener / removeListener',
      'type': 'void (inherited)',
      'description': 'Register/unregister callbacks invoked when '
          'allowSnapshotting changes. SnapshotWidget uses these '
          'internally. You can also listen for state-tracking.',
      'default': 'N/A',
      'icon': Icons.hearing,
      'color': Colors.blueGrey[600]!,
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 3: SnapshotWidget Integration
  // ============================================================
  print('=== Section 3: SnapshotWidget ===');

  final controller = SnapshotController(allowSnapshotting: false);
  print('  Controller created: allowSnapshotting=${controller.allowSnapshotting}');

  final snapshotWidgetInfo = <Map<String, dynamic>>[
    {
      'title': 'SnapshotWidget Constructor',
      'code': 'SnapshotWidget(\n'
          '  controller: snapshotController,\n'
          '  child: ComplexWidget(),\n'
          ')',
      'description': 'Wraps a child widget. When the controller\'s '
          'allowSnapshotting is true, the child is captured to '
          'a raster image for efficient repainting.',
    },
    {
      'title': 'With Custom Painter',
      'code': 'SnapshotWidget(\n'
          '  controller: snapshotController,\n'
          '  painter: SnapshotPainter(),  // optional\n'
          '  child: ComplexWidget(),\n'
          ')',
      'description': 'The optional painter parameter allows custom '
          'pre- and post-processing of the snapshot image, such '
          'as applying blur or color filters.',
    },
  ];

  // Sample widgets showing snapshot concept
  final sampleWidgets = <Map<String, dynamic>>[
    {'label': 'Complex Card', 'icon': Icons.credit_card, 'color': Colors.green[400]!},
    {'label': 'Image Gallery', 'icon': Icons.photo_library, 'color': Colors.blueGrey[400]!},
    {'label': 'Data Chart', 'icon': Icons.bar_chart, 'color': Colors.green[300]!},
    {'label': 'Rich List Tile', 'icon': Icons.list_alt, 'color': Colors.blueGrey[300]!},
  ];

  print('  Snapshot widget info: ${snapshotWidgetInfo.length}');

  // ============================================================
  // SECTION 4: When to Snapshot
  // ============================================================
  print('=== Section 4: When to Snapshot ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Scrolling Complex Lists',
      'description': 'List items with shadows, gradients, and images '
          'can be snapshotted during scrolling to avoid re-rasterizing '
          'each frame. Toggle off when the list is idle.',
      'icon': Icons.view_list,
      'benefit': 'Smoother 60fps scrolling',
      'color': Colors.green[800]!,
    },
    {
      'title': 'During Page Transitions',
      'description': 'Snapshot the outgoing page during a route transition '
          'to avoid rebuilding its widget tree while the animation '
          'plays. The user won\'t notice since it\'s leaving.',
      'icon': Icons.swap_horiz,
      'benefit': 'Faster route animations',
      'color': Colors.blueGrey[700]!,
    },
    {
      'title': 'Behind Modal Overlays',
      'description': 'When a dialog or bottom sheet covers the page, '
          'snapshot the background. It saves painting resources since '
          'the user can\'t interact with it anyway.',
      'icon': Icons.layers,
      'benefit': 'Reduced GPU usage',
      'color': Colors.green[700]!,
    },
    {
      'title': 'Static Dashboard Panels',
      'description': 'Dashboard widgets that update infrequently (charts, '
          'stat cards) can be snapshotted between data refreshes. '
          'Clear the snapshot when new data arrives.',
      'icon': Icons.dashboard,
      'benefit': 'Less layout/paint work',
      'color': Colors.blueGrey[600]!,
    },
    {
      'title': 'Tab Switching',
      'description': 'Snapshot inactive tabs so they paint cheaply when '
          'visible in the tab bar transition. Only the active tab '
          'needs live painting.',
      'icon': Icons.tab,
      'benefit': 'Instant tab previews',
      'color': Colors.green[600]!,
    },
  ];

  print('  Scenarios: ${scenarios.length}');

  // ============================================================
  // SECTION 5: Snapshot vs RepaintBoundary
  // ============================================================
  print('=== Section 5: Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'feature': 'Caching',
      'snapshot': 'Explicit: you control when',
      'boundary': 'Automatic: Flutter decides',
    },
    {
      'feature': 'Toggle',
      'snapshot': 'allowSnapshotting on/off',
      'boundary': 'Always active',
    },
    {
      'feature': 'Clear Cache',
      'snapshot': 'clear() method',
      'boundary': 'markNeedsPaint()',
    },
    {
      'feature': 'Custom Painting',
      'snapshot': 'SnapshotPainter callback',
      'boundary': 'Not available',
    },
    {
      'feature': 'Memory Cost',
      'snapshot': 'Only when active',
      'boundary': 'Always (separate layer)',
    },
    {
      'feature': 'Best Use',
      'snapshot': 'Dynamic performance tuning',
      'boundary': 'Isolation from parent',
    },
  ];

  print('  Comparison rows: ${comparison.length}');

  // ============================================================
  // SECTION 6: Implementation Pattern
  // ============================================================
  print('=== Section 6: Implementation ===');

  final implCode = '''class OptimizedList extends StatefulWidget {
  const OptimizedList({super.key});
  @override
  State<OptimizedList> createState() =>
      _OptimizedListState();
}

class _OptimizedListState
    extends State<OptimizedList> {
  final _controller = SnapshotController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    // Snapshot during scroll for performance
    final scrolling =
        _scroll.position.isScrollingNotifier.value;
    if (scrolling != _controller.allowSnapshotting) {
      _controller.allowSnapshotting = scrolling;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scroll,
      itemBuilder: (ctx, i) => SnapshotWidget(
        controller: _controller,
        child: ExpensiveListTile(index: i),
      ),
    );
  }
}''';

  print('  Implementation code rendered');

  // ============================================================
  // SECTION 7: SnapshotPainter
  // ============================================================
  print('=== Section 7: SnapshotPainter ===');

  final painterInfo = <Map<String, dynamic>>[
    {
      'name': 'paint',
      'description': 'Called to paint the snapshot. Receives the '
          'PaintingContext and Offset, plus the size and the '
          'cached image handle. Override to add filters, overlays, '
          'or modifications to the snapshot.',
      'icon': Icons.brush,
      'color': Colors.green[800]!,
    },
    {
      'name': 'paintSnapshot',
      'description': 'Called instead of the default painting when a '
          'snapshot is available. Use to apply transformations '
          'like blur, color grading, or opacity changes.',
      'icon': Icons.filter,
      'color': Colors.blueGrey[700]!,
    },
    {
      'name': 'shouldRepaint',
      'description': 'Return true when the painter\'s parameters change. '
          'Similar to CustomPainter.shouldRepaint. Controls whether '
          'the snapshot layer is repainted.',
      'icon': Icons.refresh,
      'color': Colors.green[700]!,
    },
  ];

  print('  Painter methods: ${painterInfo.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Dispose the Controller',
      'detail': 'Always dispose the SnapshotController in your State\'s '
          'dispose method. It extends ChangeNotifier, so forgetting '
          'to dispose leaks listeners and memory.',
      'icon': Icons.delete_sweep,
      'color': Colors.green[800]!,
    },
    {
      'title': 'Call clear() After Content Changes',
      'detail': 'If the child content changes while snapshotting is active, '
          'the cached image becomes stale. Call clear() to force a '
          'recapture on the next paint cycle.',
      'icon': Icons.cleaning_services,
      'color': Colors.blueGrey[700]!,
    },
    {
      'title': 'Don\'t Snapshot Interactive Children',
      'detail': 'Snapshotted children can\'t update visually (hover, press '
          'states). Only snapshot when the child doesn\'t need to '
          'respond to gestures or state changes.',
      'icon': Icons.touch_app,
      'color': Colors.green[700]!,
    },
    {
      'title': 'Monitor Memory Usage',
      'detail': 'Each snapshot allocates a raster image in GPU memory. '
          'Snapshotting many large widgets simultaneously can increase '
          'memory pressure. Profile with DevTools.',
      'icon': Icons.memory,
      'color': Colors.blueGrey[600]!,
    },
    {
      'title': 'Combine with RepaintBoundary',
      'detail': 'For maximum control, wrap a SnapshotWidget in a '
          'RepaintBoundary. This isolates the snapshot from parent '
          'repaints while giving you toggle control.',
      'icon': Icons.layers,
      'color': Colors.green[600]!,
    },
  ];

  print('  Best practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[800]!, Colors.blueGrey[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.camera_alt, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'SnapshotController',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Controls when a SnapshotWidget rasterizes its child into '
                'a cached bitmap — toggling between live painting and '
                'high-performance cached rendering.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.green[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: API ----
        _sectionHeader('2. API Surface', Icons.api, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...apiEntries.map((a) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(a['icon'] as IconData, color: a['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(a['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: a['color'] as Color)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(a['type'] as String,
                              style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(a['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Default: ',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: (a['color'] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(a['default'] as String,
                              style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: a['color'] as Color)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: SnapshotWidget Visual ----
        _sectionHeader('3. SnapshotWidget Integration', Icons.widgets, Colors.green[800]!),
        SizedBox(height: 10),
        ...snapshotWidgetInfo.map((info) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green[800])),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(info['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                    SizedBox(height: 4),
                    Text(info['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),
        SizedBox(height: 10),
        Text(
          'Example of widgets that benefit from snapshotting during scroll:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sampleWidgets.map((w) => Container(
                width: 140,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (w['color'] as Color).withValues(alpha: 0.4)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6, offset: Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (w['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(w['icon'] as IconData, color: w['color'] as Color, size: 24),
                    ),
                    SizedBox(height: 8),
                    Text(w['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              )).toList(),
        ),

        SizedBox(height: 20),

        // ---- Section 4: When to Snapshot ----
        _sectionHeader('4. When to Snapshot', Icons.timer, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...scenarios.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (s['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: s['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(s['icon'] as IconData, color: s['color'] as Color, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(s['title'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (s['color'] as Color).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(s['benefit'] as String,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: s['color'] as Color)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(s['description'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Comparison Table ----
        _sectionHeader('5. Snapshot vs RepaintBoundary', Icons.compare_arrows, Colors.green[800]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.green[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('SnapshotWidget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('RepaintBoundary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(comparison.length, (i) {
                final c = comparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.green[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(c['feature'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(c['snapshot'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(c['boundary'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Implementation Pattern ----
        _sectionHeader('6. Implementation Pattern', Icons.code, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        Text(
          'A scroll-aware list that snapshots items during scrolling '
          'and releases the cache when the scroll stops:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(implCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
        ),

        SizedBox(height: 20),

        // ---- Section 7: SnapshotPainter ----
        _sectionHeader('7. SnapshotPainter Methods', Icons.brush, Colors.green[800]!),
        SizedBox(height: 10),
        ...painterInfo.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: p['color'] as Color)),
                          SizedBox(height: 3),
                          Text(p['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Colors.blueGrey[700]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 4),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.camera_alt, color: Colors.green[600], size: 28),
              SizedBox(height: 6),
              Text(
                'SnapshotController: dynamically toggle between live '
                'painting and cached rasterization for optimal '
                'scroll and animation performance.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
