// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — FixedScrollMetrics
// Demonstrates FixedScrollMetrics — an immutable snapshot of scroll
// position metrics. Covers construction, properties, derived extents,
// comparison with live ScrollMetrics, use in notifications, and
// practical patterns for scroll state analysis.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FixedScrollMetrics Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FixedScrollMetrics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.camera_alt,
      'title': 'An Immutable Scroll Snapshot',
      'body': 'FixedScrollMetrics is a concrete, immutable '
          'implementation of ScrollMetrics. It captures the exact '
          'state of a scroll position at one moment in time — pixel '
          'offset, viewport size, content bounds — and freezes it. '
          'Once created, its values never change.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.lock,
      'title': 'Why Immutable Matters',
      'body': 'Live ScrollPosition changes constantly during '
          'scrolling. If you read metrics asynchronously (e.g. in '
          'a notification handler that does async work), the values '
          'might have changed by the time you use them. '
          'FixedScrollMetrics guarantees consistency.',
      'accent': Colors.lime[800]!,
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Used Inside Notifications',
      'body': 'ScrollNotification carries a FixedScrollMetrics '
          'object, not a live ScrollPosition. This ensures every '
          'listener in the notification chain sees identical scroll '
          'state, even if the scroll position changes between '
          'listener calls.',
      'accent': Colors.green[800]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Common for Comparisons',
      'body': 'FixedScrollMetrics is ideal for saving "before" and '
          '"after" states. Compare two snapshots to determine how '
          'far the user scrolled, whether they crossed a threshold, '
          'or whether they reached the edge of the content.',
      'accent': Colors.lightGreen[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Core Properties
  // ============================================================
  print('=== Section 2: Core Properties ===');

  final coreProps = <Map<String, dynamic>>[
    {
      'name': 'minScrollExtent',
      'type': 'double',
      'icon': Icons.vertical_align_top,
      'color': Colors.green[700]!,
      'description': 'The minimum scroll offset. Usually 0.0 for '
          'standard lists. Negative values are possible if the '
          'physics allows over-scroll at the start.',
      'example': '0.0 (typical)',
    },
    {
      'name': 'maxScrollExtent',
      'type': 'double',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.lime[800]!,
      'description': 'The maximum scroll offset. This is '
          'contentHeight - viewportHeight for vertical scrolling. '
          'If content fits in the viewport, this is 0.0 (no scroll '
          'needed).',
      'example': '2340.0 (content extends 2340 beyond viewport)',
    },
    {
      'name': 'pixels',
      'type': 'double',
      'icon': Icons.straighten,
      'color': Colors.green[800]!,
      'description': 'The current scroll offset in logical pixels. '
          'At rest, this is between minScrollExtent and '
          'maxScrollExtent. During over-scroll, it can go beyond '
          'these bounds.',
      'example': '150.0 (scrolled 150 pixels from top)',
    },
    {
      'name': 'viewportDimension',
      'type': 'double',
      'icon': Icons.crop,
      'color': Colors.lightGreen[700]!,
      'description': 'The size of the viewport along the scroll axis '
          'in logical pixels. For a vertical list, this is the '
          'height of the visible area.',
      'example': '600.0 (viewport shows 600px at a time)',
    },
    {
      'name': 'axisDirection',
      'type': 'AxisDirection',
      'icon': Icons.swap_vert,
      'color': Colors.green[600]!,
      'description': 'Which direction content scrolls. Determines '
          'the scroll axis. AxisDirection.down is the most common '
          '(vertical scrolling with content going downward).',
      'example': 'AxisDirection.down',
    },
    {
      'name': 'devicePixelRatio',
      'type': 'double',
      'icon': Icons.aspect_ratio,
      'color': Colors.lime[700]!,
      'description': 'The number of device pixels per logical pixel. '
          'Inherited from the device. Typically 2.0 or 3.0 on '
          'high-DPI screens. Used for sub-pixel precision.',
      'example': '3.0 (iPhone retina)',
    },
  ];

  print('  Prepared ${coreProps.length} core properties');

  // ============================================================
  // SECTION 3: Derived Extents
  // ============================================================
  print('=== Section 3: Derived Extents ===');

  // Simulate a scroll scenario to show calculated extents
  final scrollScenarios = <Map<String, dynamic>>[
    {
      'label': 'At top',
      'pixels': 0.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.vertical_align_top,
      'color': Colors.green[700]!,
    },
    {
      'label': 'Scrolled 400px',
      'pixels': 400.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.unfold_more,
      'color': Colors.lime[800]!,
    },
    {
      'label': 'Half-way',
      'pixels': 1000.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.swap_vert,
      'color': Colors.green[800]!,
    },
    {
      'label': 'Near bottom',
      'pixels': 1800.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.vertical_align_bottom,
      'color': Colors.lightGreen[700]!,
    },
    {
      'label': 'At bottom',
      'pixels': 2000.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.arrow_downward,
      'color': Colors.green[900]!,
    },
    {
      'label': 'Over-scroll top',
      'pixels': -50.0,
      'min': 0.0,
      'max': 2000.0,
      'viewport': 600.0,
      'icon': Icons.arrow_upward,
      'color': Colors.red[400]!,
    },
  ];

  for (final s in scrollScenarios) {
    final px = s['pixels'] as double;
    final mn = s['min'] as double;
    final mx = s['max'] as double;
    final vp = s['viewport'] as double;
    final before = (px - mn).clamp(0.0, double.infinity);
    final after = (mx - px).clamp(0.0, double.infinity);
    final inside = vp;
    final total = before + inside + after;
    final progress = mx > mn ? ((px - mn) / (mx - mn) * 100) : 0.0;
    print('  ${s['label']}: extentBefore=${before.toStringAsFixed(0)}, '
        'extentInside=${inside.toStringAsFixed(0)}, '
        'extentAfter=${after.toStringAsFixed(0)}, '
        'total=${total.toStringAsFixed(0)}, '
        'progress=${progress.toStringAsFixed(1)}%');
  }

  // ============================================================
  // SECTION 4: Creating FixedScrollMetrics
  // ============================================================
  print('=== Section 4: Construction ===');

  final constructionMethods = <Map<String, dynamic>>[
    {
      'name': 'Direct Constructor',
      'icon': Icons.build,
      'color': Colors.green[700]!,
      'description': 'Create with explicit values: '
          'FixedScrollMetrics(minScrollExtent: 0, '
          'maxScrollExtent: 2000, pixels: 500, '
          'viewportDimension: 600, axisDirection: '
          'AxisDirection.down, devicePixelRatio: 1.0). '
          'Every parameter is required.',
      'useCase': 'Testing, simulation, or creating mock states.',
    },
    {
      'name': 'ScrollPosition.copyWith()',
      'icon': Icons.content_copy,
      'color': Colors.lime[800]!,
      'description': 'Create a modified snapshot from a live scroll '
          'position. Override specific values while keeping the rest '
          'from the original. Returns a FixedScrollMetrics instance.',
      'useCase': 'Creating hypothetical states from real positions. '
          '"What if the user scrolled 100 more pixels?"',
    },
    {
      'name': 'From ScrollNotification.metrics',
      'icon': Icons.notifications,
      'color': Colors.green[800]!,
      'description': 'ScrollNotification.metrics is already a '
          'FixedScrollMetrics instance. You get it automatically '
          'when listening to scroll notifications. No creation needed.',
      'useCase': 'Most common way to receive FixedScrollMetrics. '
          'NotificationListener<ScrollNotification>.',
    },
  ];

  print('  Prepared ${constructionMethods.length} construction methods');

  // ============================================================
  // SECTION 5: Visual Scroll State Diagram
  // ============================================================
  print('=== Section 5: Visual Diagram ===');

  // This section builds a visual representation of the scroll
  // content model: what extentBefore, extentInside, and
  // extentAfter mean relative to pixel offset and content

  final diagramParts = <Map<String, dynamic>>[
    {
      'label': 'extentBefore',
      'icon': Icons.arrow_upward,
      'color': Colors.grey[600]!,
      'bgColor': Colors.grey[200]!,
      'description': 'Content above the viewport. '
          'Equals pixels - minScrollExtent. '
          'This is what has been scrolled past.',
      'fraction': 0.25,
    },
    {
      'label': 'extentInside (viewport)',
      'icon': Icons.crop,
      'color': Colors.green[700]!,
      'bgColor': Colors.green[100]!,
      'description': 'The visible portion. '
          'Equals viewportDimension. '
          'This is what the user can see right now.',
      'fraction': 0.35,
    },
    {
      'label': 'extentAfter',
      'icon': Icons.arrow_downward,
      'color': Colors.grey[600]!,
      'bgColor': Colors.grey[200]!,
      'description': 'Content below the viewport. '
          'Equals maxScrollExtent - pixels. '
          'This is what remains to scroll.',
      'fraction': 0.40,
    },
  ];

  print('  Prepared ${diagramParts.length} diagram segments');

  // ============================================================
  // SECTION 6: Comparison — Fixed vs Live Metrics
  // ============================================================
  print('=== Section 6: Fixed vs Live ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Mutability',
      'fixed': 'Immutable — values never change',
      'live': 'Mutable — values update continuously',
    },
    {
      'aspect': 'Source',
      'fixed': 'Created from snapshot or notification',
      'live': 'The actual ScrollPosition object',
    },
    {
      'aspect': 'Thread safety',
      'fixed': 'Safe to read from any context',
      'live': 'Must read during build/notification',
    },
    {
      'aspect': 'Listeners',
      'fixed': 'None — no change notifications',
      'live': 'Notifies on every scroll change',
    },
    {
      'aspect': 'Memory',
      'fixed': 'Lightweight snapshot object',
      'live': 'Full position with physics, activity',
    },
    {
      'aspect': 'Typical use',
      'fixed': 'Notification handlers, logging, analytics',
      'live': 'Build methods, controllers, animations',
    },
    {
      'aspect': 'Stored in',
      'fixed': 'ScrollNotification.metrics',
      'live': 'ScrollController.position',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 7: Notification Pattern
  // ============================================================
  print('=== Section 7: Notification Patterns ===');

  final notificationPatterns = <Map<String, dynamic>>[
    {
      'name': 'Scroll Progress Tracking',
      'icon': Icons.linear_scale,
      'color': Colors.green[700]!,
      'description': 'Listen for ScrollNotification and compute '
          'scroll progress from metrics. Calculate percentage: '
          '(metrics.pixels - metrics.minScrollExtent) / '
          '(metrics.maxScrollExtent - metrics.minScrollExtent). '
          'Use for progress bars, "scroll to top" buttons.',
    },
    {
      'name': 'Infinite Scroll / Load More',
      'icon': Icons.all_inclusive,
      'color': Colors.lime[800]!,
      'description': 'Check if metrics.extentAfter is below a '
          'threshold (e.g. < 200 pixels remaining). If so, trigger '
          'data loading. Because metrics is immutable, you can '
          'safely pass it to async loading functions.',
    },
    {
      'name': 'Scroll Direction Detection',
      'icon': Icons.swap_vert,
      'color': Colors.green[800]!,
      'description': 'Store the previous metrics snapshot. Compare '
          'current.pixels with previous.pixels. If increasing, '
          'user scrolls down. If decreasing, scrolls up. The '
          'immutability of both snapshots makes this reliable.',
    },
    {
      'name': 'Parallax Effect Calculation',
      'icon': Icons.layers,
      'color': Colors.lightGreen[700]!,
      'description': 'Use metrics.pixels divided by '
          'metrics.maxScrollExtent to get a 0.0–1.0 ratio. '
          'Apply this to background offset, opacity, or scale '
          'for parallax layers. Each notification gives exact '
          'pixel state for smooth parallax.',
    },
    {
      'name': 'Snapping to Section',
      'icon': Icons.view_agenda,
      'color': Colors.green[900]!,
      'description': 'After scroll ends (ScrollEndNotification), '
          'examine metrics.pixels to determine which content '
          'section is most visible. Animate to the nearest '
          'section boundary. The frozen metrics ensure the '
          'decision is based on the actual stop position.',
    },
  ];

  print('  Prepared ${notificationPatterns.length} notification patterns');

  // ============================================================
  // SECTION 8: Practical Scenarios
  // ============================================================
  print('=== Section 8: Practical Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Scroll-Aware App Bar',
      'icon': Icons.web_asset,
      'color': Colors.green[700]!,
      'description': 'Use FixedScrollMetrics to drive AppBar title '
          'opacity and elevation. At pixels == 0: fully transparent, '
          'no elevation. At pixels > 100: fully opaque, elevated. '
          'Interpolate between for smooth transitions.',
    },
    {
      'title': 'Content Length Analytics',
      'icon': Icons.analytics,
      'color': Colors.lime[800]!,
      'description': 'Log maxScrollExtent + viewportDimension to get '
          'the total content height. Compare with pixels to compute '
          'read depth. Send analytics events at 25%, 50%, 75%, '
          'and 100% scroll depth.',
    },
    {
      'title': 'Pull-to-Refresh Detection',
      'icon': Icons.refresh,
      'color': Colors.green[800]!,
      'description': 'When metrics.pixels goes below '
          'metrics.minScrollExtent (over-scroll at top), the user '
          'is pulling down. The amount of over-scroll is '
          'minScrollExtent - pixels. Use this to trigger refresh.',
    },
    {
      'title': 'Viewport Overlap Calculation',
      'icon': Icons.filter_none,
      'color': Colors.lightGreen[700]!,
      'description': 'Given two items at known scroll offsets, check '
          'whether they fall within the current viewport window: '
          '[pixels, pixels + viewportDimension]. Items outside '
          'this range are off-screen.',
    },
  ];

  print('  Prepared ${scenarios.length} practical scenarios');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Prefer Notifications Over Position',
      'body': 'For most read-only scroll monitoring, use '
          'NotificationListener<ScrollNotification> which gives you '
          'FixedScrollMetrics automatically. Only use ScrollController.'
          'position when you need to control the scroll.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'maxScrollExtent Can Be 0.0',
      'body': 'If the content fits entirely within the viewport, '
          'maxScrollExtent is 0.0 (there is nothing to scroll). '
          'Always guard division by (max - min) to avoid dividing '
          'by zero when computing scroll percentage.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use copyWith for "What If" Scenarios',
      'body': 'To simulate how the scroll state would look at a '
          'different offset, use metrics.copyWith(pixels: newValue). '
          'This creates a new FixedScrollMetrics without touching '
          'the real scroll position.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Over-scroll Values',
      'body': 'On iOS (BouncingScrollPhysics), pixels can be '
          'negative or exceed maxScrollExtent during bounce. '
          'ExtentBefore and extentAfter clamp to 0 in these cases. '
          'Check outOfRange for a quick boolean check.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'devicePixelRatio Is Informational',
      'body': 'The devicePixelRatio in FixedScrollMetrics is the '
          'value at snapshot time. It does not affect scroll offset '
          'calculations (which are in logical pixels). Useful for '
          'sub-pixel rendering decisions.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Comparing Two Snapshots',
      'body': 'Store a previous FixedScrollMetrics and compare with '
          'the current one in a notification. Delta = current.pixels '
          '- previous.pixels. This reliably shows distance scrolled '
          'between two events.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('FixedScrollMetrics'),
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.lime[800]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.camera_alt, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FixedScrollMetrics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An immutable snapshot of scroll position data. '
                  'Captures minScrollExtent, maxScrollExtent, pixels, '
                  'viewportDimension, and axisDirection at one moment. '
                  'Used in ScrollNotification and for safe '
                  'asynchronous scroll state analysis.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _fxHead('1', 'What is FixedScrollMetrics?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Core Properties ──
          _fxHead('2', 'Core Properties'),
          SizedBox(height: 12),
          ...coreProps.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: prop['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(prop['icon'] as IconData,
                            color: prop['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(prop['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: prop['color'] as Color)),
                        ),
                        _fxBadge(
                            prop['type'] as String, Colors.grey[500]!),
                      ]),
                      SizedBox(height: 6),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                            'Example: ${prop['example']}',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Colors.green[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Derived Extents Table ──
          _fxHead('3', 'Derived Extents by Position'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Position',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 1,
                      child: Text('pixels',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 1,
                      child: Text('Before',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 1,
                      child: Text('Inside',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 1,
                      child: Text('After',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 1,
                      child: Text('Progress',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...scrollScenarios.asMap().entries.map((entry) {
                final idx = entry.key;
                final s = entry.value;
                final px = s['pixels'] as double;
                final mn = s['min'] as double;
                final mx = s['max'] as double;
                final vp = s['viewport'] as double;
                final before = (px - mn).clamp(0.0, double.infinity);
                final after = (mx - px).clamp(0.0, double.infinity);
                final progress = mx > mn
                    ? ((px - mn) / (mx - mn) * 100)
                    : 0.0;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(children: [
                            Icon(s['icon'] as IconData,
                                color: s['color'] as Color,
                                size: 12),
                            SizedBox(width: 3),
                            Text(s['label'] as String,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold)),
                          ])),
                      Expanded(
                          flex: 1,
                          child: Text(px.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace'))),
                      Expanded(
                          flex: 1,
                          child: Text(before.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[600]))),
                      Expanded(
                          flex: 1,
                          child: Text(vp.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                  color: Colors.green[700]))),
                      Expanded(
                          flex: 1,
                          child: Text(after.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[600]))),
                      Expanded(
                          flex: 1,
                          child: Text(
                              '${progress.toStringAsFixed(0)}%',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                  color: Colors.green[800]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 4: Construction ──
          _fxHead('4', 'Creating FixedScrollMetrics'),
          SizedBox(height: 12),
          ...constructionMethods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.lime[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(m['useCase'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.lime[900],
                                fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Visual Diagram ──
          _fxHead('5', 'Scroll Content Model'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                Text('Content Layout Along Scroll Axis',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey[800])),
                SizedBox(height: 12),
                ...diagramParts.map((part) {
                  final fraction = part['fraction'] as double;
                  return Container(
                    width: double.infinity,
                    height: 80 * fraction + 40,
                    margin: EdgeInsets.only(bottom: 2),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: part['bgColor'] as Color,
                      border: Border.all(
                          color: (part['color'] as Color)
                              .withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(children: [
                      Icon(part['icon'] as IconData,
                          color: part['color'] as Color, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(part['label'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: part['color'] as Color)),
                            SizedBox(height: 2),
                            Text(part['description'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                    height: 1.2)),
                          ],
                        ),
                      ),
                      Text('${(fraction * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: part['color'] as Color)),
                    ]),
                  );
                }),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Total content = extentBefore + extentInside + '
                    'extentAfter\n'
                    'pixels = minScrollExtent + extentBefore\n'
                    'outOfRange = pixels < min || pixels > max',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.green[900],
                        height: 1.5),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 6: Comparison Table ──
          _fxHead('6', 'Fixed vs Live Metrics'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('FixedScrollMetrics',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('ScrollPosition (live)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 3,
                          child: Text(row['fixed'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['live'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.orange[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Notification Patterns ──
          _fxHead('7', 'Notification Usage Patterns'),
          SizedBox(height: 12),
          ...notificationPatterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Practical Scenarios ──
          _fxHead('8', 'Practical Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(s['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _fxHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of FixedScrollMetrics Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _fxHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small badge/tag
// ──────────────────────────────────────────────────────────
Widget _fxBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
