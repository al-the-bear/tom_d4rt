// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — StretchingOverscrollIndicator
// Demonstrates StretchingOverscrollIndicator, the widget that provides
// the rubber-band stretch effect when users scroll past the edge of a
// scrollable. This is the default overscroll visual on Android 12+,
// replacing GlowingOverscrollIndicator with a physically deforming effect.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchingOverscrollIndicator Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.expand,
      'title': 'What is StretchingOverscrollIndicator?',
      'body': 'A widget that produces the rubber-band stretch visual '
          'when users overscroll a scrollable. Rather than painting '
          'a glow overlay, it applies a matrix transform that deforms '
          'the content, making it look like the viewport stretches.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.layers,
      'title': 'Where It Lives',
      'body': 'StretchingOverscrollIndicator wraps the scroll view\'s '
          'viewport. It listens to OverscrollNotification and '
          'ScrollUpdateNotification to compute how much stretch to '
          'apply. The deformation animates back when released.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Default Behavior',
      'body': 'On Android 12+ (API 31), MaterialScrollBehavior.build'
          'OverscrollIndicator() returns this widget automatically. '
          'On older Android, GlowingOverscrollIndicator is used. '
          'iOS uses BouncingScrollPhysics with no indicator.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.transform,
      'title': 'How Stretch Works',
      'body': 'The widget applies a scale transform along the scroll axis. '
          'The stretch amount is proportional to the overscroll distance. '
          'Content near the overscroll edge spreads apart, content far '
          'away barely moves — simulating a pulled rubber sheet.',
      'accent': Colors.deepOrange,
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
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
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
  // SECTION 2: API / Properties
  // ============================================================
  print('=== Section 2: API ===');

  final apiRows = <Map<String, String>>[
    {
      'param': 'axisDirection',
      'type': 'AxisDirection',
      'desc': 'The direction of the scroll axis. AxisDirection.down for '
          'vertical lists, AxisDirection.right for horizontal. The '
          'stretch is applied along this axis.',
    },
    {
      'param': 'clipBehavior',
      'type': 'Clip',
      'desc': 'How the stretched content is clipped. Defaults to '
          'Clip.hardEdge. Set Clip.none to let stretched content '
          'overflow its bounds (useful for shadows/decorations).',
    },
    {
      'param': 'notificationPredicate',
      'type': 'ScrollNotificationPredicate',
      'desc': 'Determines which ScrollNotifications trigger the stretch. '
          'Defaults to defaultScrollNotificationPredicate (depth == 0). '
          'Customize for nested scroll views.',
    },
    {
      'param': 'child',
      'type': 'Widget',
      'desc': 'The scrollable content to wrap. Typically, ScrollBehavior '
          'wraps the viewport with this indicator automatically — '
          'you rarely construct it directly.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiRows.length; i++) {
    final row = apiRows[i];
    print('API ${i + 1}: ${row['param']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
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
                    color: Colors.indigo.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
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
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
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
  // SECTION 3: Vertical Stretch Demo
  // ============================================================
  print('=== Section 3: Vertical ===');

  // Simulated vertical overscroll stages
  final vertStages = <Map<String, dynamic>>[
    {
      'label': 'Normal Scroll',
      'desc': 'Content within bounds. No stretch transform applied.',
      'stretch': 0.0,
      'color': Colors.grey,
    },
    {
      'label': 'Top Overscroll',
      'desc': 'User pulls down past the top edge. Items near the top '
          'spread apart while items below barely move.',
      'stretch': 0.12,
      'color': Colors.indigo,
    },
    {
      'label': 'Bottom Overscroll',
      'desc': 'User pushes up past the bottom edge. Items near the '
          'bottom spread apart. Symmetrical to top overscroll.',
      'stretch': 0.12,
      'color': Colors.blue,
    },
    {
      'label': 'Release & Snap Back',
      'desc': 'When released, the stretch animates back to zero. The '
          'snap-back uses a spring curve for a natural feel.',
      'stretch': 0.0,
      'color': Colors.green,
    },
  ];

  final vertWidgets = <Widget>[];
  for (var i = 0; i < vertStages.length; i++) {
    final vs = vertStages[i];
    final vsColor = vs['color'] as Color;
    final pct = vs['stretch'] as double;
    print('Vertical ${i + 1}: ${vs['label']}');

    // Visual: show item bars with spacing proportional to stretch
    final bars = <Widget>[];
    for (var j = 0; j < 5; j++) {
      final extra = pct * 8.0 * (i == 1 ? (4 - j).toDouble() : j.toDouble());
      if (j > 0) bars.add(SizedBox(height: 3 + extra));
      bars.add(
        Container(
          height: 14,
          decoration: BoxDecoration(
            color: vsColor.withOpacity(0.12 + j * 0.04),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      );
    }

    vertWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: vsColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: vsColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: vsColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: vsColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        vs['label'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: vsColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    vs['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 55,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.04),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.12)),
              ),
              child: Column(children: bars),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Horizontal Stretch
  // ============================================================
  print('=== Section 4: Horizontal ===');

  final horizCases = <Map<String, dynamic>>[
    {
      'label': 'Horizontal ListView',
      'desc': 'A horizontal list with AxisDirection.right. Stretch '
          'appears on lead/trail edges when overscrolling horizontally.',
      'direction': 'AxisDirection.right',
      'icon': Icons.view_column,
      'color': Colors.indigo,
    },
    {
      'label': 'RTL Horizontal',
      'desc': 'In right-to-left layouts, AxisDirection.left is used. '
          'The stretch mirrors — left edge stretches on forward scroll, '
          'right edge on reverse.',
      'direction': 'AxisDirection.left',
      'icon': Icons.format_textdirection_r_to_l,
      'color': Colors.purple,
    },
    {
      'label': 'PageView Stretch',
      'desc': 'PageView wraps its children in a horizontal scrollable. '
          'At the first and last pages, StretchingOverscrollIndicator '
          'provides edge feedback.',
      'direction': 'AxisDirection.right',
      'icon': Icons.auto_stories,
      'color': Colors.teal,
    },
  ];

  final horizWidgets = <Widget>[];
  for (var i = 0; i < horizCases.length; i++) {
    final hc = horizCases[i];
    final hcColor = hc['color'] as Color;
    print('Horizontal ${i + 1}: ${hc['label']}');

    // Visual: horizontal bar squares representing cards
    final hBars = <Widget>[];
    for (var j = 0; j < 4; j++) {
      if (j > 0) hBars.add(const SizedBox(width: 4));
      hBars.add(
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: hcColor.withOpacity(0.1 + j * 0.06),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '${j + 1}',
              style: TextStyle(fontSize: 10, color: hcColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    horizWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: hcColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hcColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(hc['icon'] as IconData, color: hcColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hc['label'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: hcColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: hcColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    hc['direction'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: hcColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.04),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.12)),
              ),
              child: Row(children: hBars),
            ),
            const SizedBox(height: 6),
            Text(
              hc['desc'] as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Clip Behavior
  // ============================================================
  print('=== Section 5: Clip ===');

  final clipModes = <Map<String, dynamic>>[
    {
      'mode': 'Clip.hardEdge',
      'desc': 'The default. Stretched content is clipped at the viewport '
          'boundary. Fast — no anti-aliasing at the clip edge. '
          'Most common choice for performance.',
      'icon': Icons.crop_square,
      'color': Colors.indigo,
      'overflow': false,
    },
    {
      'mode': 'Clip.antiAlias',
      'desc': 'Like hardEdge but with smooth anti-aliased edges. '
          'Slightly more expensive but looks better if the clip '
          'edge is visible.',
      'icon': Icons.crop,
      'color': Colors.blue,
      'overflow': false,
    },
    {
      'mode': 'Clip.none',
      'desc': 'No clipping. Stretched content overflows its bounds. '
          'Useful when items have shadows or decorations that should '
          'extend beyond the viewport during stretch.',
      'icon': Icons.crop_free,
      'color': Colors.orange,
      'overflow': true,
    },
  ];

  final clipWidgets = <Widget>[];
  for (var i = 0; i < clipModes.length; i++) {
    final cm = clipModes[i];
    final cmColor = cm['color'] as Color;
    print('Clip ${i + 1}: ${cm['mode']}');

    // Visual: simulated viewport with/without overflow
    final showOverflow = cm['overflow'] as bool;
    clipWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cmColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cmColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(cm['icon'] as IconData, color: cmColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        cm['mode'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: cmColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cm['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Mini viewport visualization
            Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: cmColor.withOpacity(0.4),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                clipBehavior: showOverflow ? Clip.none : Clip.hardEdge,
                children: [
                  Positioned(
                    top: 4,
                    left: 4,
                    right: 4,
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: cmColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    left: 4,
                    right: 4,
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: cmColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 44,
                    left: 4,
                    right: 4,
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: cmColor.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  if (showOverflow)
                    Positioned(
                      top: 64,
                      left: 4,
                      right: 4,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: const Center(
                          child: Text(
                            'overflow',
                            style: TextStyle(fontSize: 7, color: Colors.red),
                          ),
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
  // SECTION 6: ScrollBehavior Integration
  // ============================================================
  print('=== Section 6: ScrollBehavior ===');

  final behaviorPatterns = <Map<String, dynamic>>[
    {
      'title': 'MaterialApp Default (Android 12+)',
      'code': 'MaterialApp(\n'
          '  // Automatically uses\n'
          '  // StretchingOverscrollIndicator\n'
          '  // when platform is Android 12+\n'
          ')',
      'desc': 'Nothing to configure. MaterialScrollBehavior checks '
          'the platform version and returns the stretch indicator.',
      'color': Colors.green,
    },
    {
      'title': 'Force Stretch on All Platforms',
      'code': 'class AlwaysStretch extends MaterialScrollBehavior {\n'
          '  @override\n'
          '  Widget buildOverscrollIndicator(\n'
          '    BuildContext ctx,\n'
          '    Widget child,\n'
          '    ScrollableDetails details,\n'
          '  ) {\n'
          '    return StretchingOverscrollIndicator(\n'
          '      axisDirection: details.direction,\n'
          '      child: child,\n'
          '    );\n'
          '  }\n'
          '}',
      'desc': 'Override buildOverscrollIndicator to always return '
          'StretchingOverscrollIndicator, even on older Android.',
      'color': Colors.indigo,
    },
    {
      'title': 'Disable for a Specific View',
      'code': 'ScrollConfiguration(\n'
          '  behavior: ScrollConfiguration.of(context)\n'
          '    .copyWith(overscroll: false),\n'
          '  child: ListView(...),\n'
          ')',
      'desc': 'Remove the overscroll indicator for a single scroll view '
          'while keeping the global behavior unchanged.',
      'color': Colors.orange,
    },
    {
      'title': 'Direct Construction',
      'code': 'StretchingOverscrollIndicator(\n'
          '  axisDirection: AxisDirection.down,\n'
          '  clipBehavior: Clip.none,\n'
          '  child: Viewport(...),\n'
          ')',
      'desc': 'Directly wrap a viewport — rarely needed, but useful when '
          'building custom scroll views from scratch.',
      'color': Colors.purple,
    },
  ];

  final behaviorWidgets = <Widget>[];
  for (var i = 0; i < behaviorPatterns.length; i++) {
    final bp = behaviorPatterns[i];
    final bpColor = bp['color'] as Color;
    print('Behavior ${i + 1}: ${bp['title']}');
    behaviorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: bpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bpColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: bpColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: bpColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bp['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: bpColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bpColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  bp['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: bpColor,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                bp['desc'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Nested Scroll Notification
  // ============================================================
  print('=== Section 7: Nested ===');

  final nestedTopics = <Map<String, dynamic>>[
    {
      'title': 'Default Predicate (depth == 0)',
      'desc': 'Only the outermost scrollable triggers the stretch. '
          'Inner scrollables (e.g., a list inside a tab view) send '
          'notifications at depth > 0, which are ignored.',
      'icon': Icons.filter_1,
      'color': Colors.indigo,
    },
    {
      'title': 'Custom Predicate',
      'desc': 'Override notificationPredicate to listen to a specific '
          'nested scroll depth. For example, (n) => n.depth == 1 '
          'makes the indicator respond to the first nested scrollable.',
      'icon': Icons.filter_2,
      'color': Colors.blue,
    },
    {
      'title': 'Multiple Indicators',
      'desc': 'Each scrollable can have its own indicator. A NestedScrollView '
          'with a header sliver uses the outer indicator for the header '
          'and inner indicators for tab content.',
      'icon': Icons.layers,
      'color': Colors.purple,
    },
    {
      'title': 'Notification Bubbling',
      'desc': 'OverscrollNotification and ScrollUpdateNotification bubble '
          'up the widget tree. The notificationPredicate filters only '
          'the relevant ones. Unmatched notifications pass through.',
      'icon': Icons.bubble_chart,
      'color': Colors.teal,
    },
  ];

  final nestedWidgets = <Widget>[];
  for (var i = 0; i < nestedTopics.length; i++) {
    final nt = nestedTopics[i];
    final ntColor = nt['color'] as Color;
    print('Nested ${i + 1}: ${nt['title']}');
    nestedWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ntColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ntColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ntColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(nt['icon'] as IconData, color: ntColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nt['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ntColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nt['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
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

  // Nesting diagram
  final nestingDiagram = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.03),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Scroll Notification Depth',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 10),
        // depth 0
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'depth: 0',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Outer ScrollView',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // depth 1
              Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'depth: 1',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Inner ListView',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // depth 2
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.purple.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'depth: 2',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Deeply Nested GridView',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
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
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.expand,
      'text': 'StretchingOverscrollIndicator applies a rubber-sheet '
          'deformation to scroll content when overscrolling.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'Default on Android 12+ via MaterialScrollBehavior. '
          'Replaces GlowingOverscrollIndicator automatically.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'Works in both vertical and horizontal orientations. '
          'The axisDirection property controls the stretch axis.',
    },
    {
      'icon': Icons.crop,
      'text': 'clipBehavior controls whether stretched content is clipped. '
          'Use Clip.none for items with shadows or decorations.',
    },
    {
      'icon': Icons.layers,
      'text': 'notificationPredicate filters which nested scrollable '
          'triggers the stretch. Default: outermost only (depth 0).',
    },
    {
      'icon': Icons.settings,
      'text': 'Override ScrollBehavior.buildOverscrollIndicator() to '
          'force stretch on all platforms or disable it.',
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
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo,
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
        title: const Text('StretchingOverscrollIndicator'),
        backgroundColor: Colors.indigo,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.swap_vert), text: 'Vertical'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Horizontal'),
            Tab(icon: Icon(Icons.crop), text: 'Clip'),
            Tab(icon: Icon(Icons.settings), text: 'Behavior'),
            Tab(icon: Icon(Icons.layers), text: 'Nested'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'StretchingOverscrollIndicator: the rubber-band overscroll '
                  'widget that deforms content on Android 12+.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor properties of StretchingOverscrollIndicator.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Vertical
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the stretch effect progresses during vertical '
                  'overscroll: from normal to stretched to snap-back.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...vertWidgets,
            ],
          ),

          // Tab 4: Horizontal
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Stretch on horizontal scrollables — lists, page '
                  'views, and RTL layouts.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...horizWidgets,
            ],
          ),

          // Tab 5: Clip
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How clipBehavior affects stretched content rendering.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...clipWidgets,
            ],
          ),

          // Tab 6: Behavior
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ScrollBehavior integration patterns for controlling '
                  'when and where stretch is used.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...behaviorWidgets,
            ],
          ),

          // Tab 7: Nested
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Handling stretch indicators in nested scroll views '
                  'using notification predicates.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...nestedWidgets,
              nestingDiagram,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about StretchingOverscrollIndicator.',
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
