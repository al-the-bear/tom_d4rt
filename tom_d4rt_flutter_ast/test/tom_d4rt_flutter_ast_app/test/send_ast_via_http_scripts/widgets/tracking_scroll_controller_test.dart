// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TrackingScrollController
// Demonstrates TrackingScrollController — a ScrollController that
// tracks and unifies access to the most recently used scroll
// position across multiple ScrollView children (e.g., TabBarView
// pages). Covers position tracking, initialScrollOffset propagation,
// and real-world TabBarView / PageView use cases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TrackingScrollController Deep Demo executing');

  // ============================================================
  // SECTION 1: What is TrackingScrollController?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.track_changes,
      'title': 'Multi-Position Tracker',
      'body': 'TrackingScrollController extends ScrollController and '
          'tracks the most recently interacted ScrollPosition when '
          'multiple scrollable children share the same controller. '
          'It remembers which tab or page the user scrolled last.',
      'accent': Colors.indigo[800]!,
    },
    {
      'icon': Icons.tab,
      'title': 'TabBarView Integration',
      'body': 'The primary use case is TabBarView, where each tab has '
          'its own scrollable list. TrackingScrollController provides '
          'a unified initialScrollOffset and remembers the most '
          'recently scrolled position across all tabs.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'mostRecentlyUpdatedPosition',
      'body': 'The key property: returns the ScrollPosition that was '
          'most recently updated by user scrolling. Returns null if '
          'no position has been scrolled yet. Other controllers only '
          'expose positions as a raw list.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.restart_alt,
      'title': 'Shared Initial Offset',
      'body': 'When a new tab attaches to the controller, it receives '
          'the initialScrollOffset. All tabs start at the same '
          'position, which makes the experience consistent when '
          'switching between tabs.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'mostRecentlyUpdatedPosition',
      'type': 'ScrollPosition?',
      'description': 'Returns the ScrollPosition that was most recently '
          'interacted with by the user. If no scrolling occurred, '
          'returns null. Use to read pixel offset of the active tab.',
      'icon': Icons.gps_fixed,
      'color': Colors.indigo[800]!,
    },
    {
      'name': 'initialScrollOffset',
      'type': 'double',
      'description': 'The initial scroll offset applied to newly '
          'attached scroll positions. Set in the constructor. '
          'All scrollable children start at this offset.',
      'icon': Icons.vertical_align_top,
      'color': Colors.teal[700]!,
    },
    {
      'name': 'positions',
      'type': 'Iterable<ScrollPosition>',
      'description': 'Inherited from ScrollController. Returns all '
          'currently attached positions. For a TabBarView, typically '
          'one or two positions are attached at a time.',
      'icon': Icons.list,
      'color': Colors.indigo[700]!,
    },
    {
      'name': 'offset',
      'type': 'double',
      'description': 'Returns the offset of the most recently updated '
          'position. Throws if no position has been attached yet. '
          'Prefer checking positions.isNotEmpty first.',
      'icon': Icons.straighten,
      'color': Colors.teal[600]!,
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 3: ScrollController Comparison
  // ============================================================
  print('=== Section 3: Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'feature': 'Multiple positions',
      'tracking': 'Designed for it — tracks most recent',
      'standard': 'Supports but no tracking',
    },
    {
      'feature': 'offset getter',
      'tracking': 'Returns most recent position offset',
      'standard': 'Asserts single position attached',
    },
    {
      'feature': 'animateTo / jumpTo',
      'tracking': 'Acts on most recent position',
      'standard': 'Requires single position',
    },
    {
      'feature': 'TabBarView',
      'tracking': 'Ideal — one controller for all tabs',
      'standard': 'Needs per-tab controllers',
    },
    {
      'feature': 'Memory',
      'tracking': 'Same as ScrollController',
      'standard': 'Same',
    },
    {
      'feature': 'keepScrollOffset',
      'tracking': 'Supported, applied per position',
      'standard': 'Supported, single position',
    },
  ];

  print('  Comparison rows: ${comparison.length}');

  // ============================================================
  // SECTION 4: Position Lifecycle
  // ============================================================
  print('=== Section 4: Position Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Attach',
      'detail': 'ScrollView creates a ScrollPosition and calls '
          'controller.attach(position). The position receives '
          'initialScrollOffset from the controller.',
      'icon': Icons.link,
      'color': Colors.indigo[800]!,
    },
    {
      'step': '2',
      'title': 'Scroll / Update',
      'detail': 'As the user scrolls, position.pixels updates. '
          'TrackingScrollController marks this position as '
          'mostRecentlyUpdatedPosition.',
      'icon': Icons.swipe,
      'color': Colors.teal[700]!,
    },
    {
      'step': '3',
      'title': 'Tab Switch',
      'detail': 'When the user switches tabs, the old position may '
          'detach and a new one attaches. The most-recent tracking '
          'updates accordingly.',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo[700]!,
    },
    {
      'step': '4',
      'title': 'Detach',
      'detail': 'When a scrollable is disposed, its position detaches '
          'from the controller. If the detached position was the '
          'most recent, mostRecentlyUpdatedPosition is cleared.',
      'icon': Icons.link_off,
      'color': Colors.teal[600]!,
    },
    {
      'step': '5',
      'title': 'Dispose',
      'detail': 'Disposing the controller detaches all remaining '
          'positions. Always call dispose() in your State.dispose '
          'to avoid leaks.',
      'icon': Icons.delete_forever,
      'color': Colors.indigo[600]!,
    },
  ];

  print('  Lifecycle steps: ${lifecycleSteps.length}');

  // ============================================================
  // SECTION 5: Usage Patterns
  // ============================================================
  print('=== Section 5: Usage Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'TabBarView with Shared Controller',
      'description': 'Most common pattern. Create one '
          'TrackingScrollController and pass it to the ListView '
          'in each tab page.',
      'code': 'final _tsc = TrackingScrollController();\n\n'
          'TabBarView(\n'
          '  children: [\n'
          '    ListView(\n'
          '      controller: _tsc,\n'
          '      children: page1Items,\n'
          '    ),\n'
          '    ListView(\n'
          '      controller: _tsc,\n'
          '      children: page2Items,\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.indigo[800]!,
    },
    {
      'title': 'Reading Current Scroll Offset',
      'description': 'Check the most recent position offset for '
          'scroll-dependent UI like "back to top" buttons.',
      'code': 'final pos =\n'
          '    _tsc.mostRecentlyUpdatedPosition;\n'
          'if (pos != null && pos.pixels > 500) {\n'
          '  showBackToTopButton();\n'
          '}',
      'color': Colors.teal[700]!,
    },
    {
      'title': 'With initialScrollOffset',
      'description': 'Start all tabs at a specific scroll position. '
          'Useful for restoring state after app restart.',
      'code': 'final _tsc = TrackingScrollController(\n'
          '  initialScrollOffset: 200,\n'
          ');',
      'color': Colors.indigo[700]!,
    },
    {
      'title': 'Listening for Changes',
      'description': 'Use addListener to respond to scroll changes '
          'across any attached position.',
      'code': '_tsc.addListener(() {\n'
          '  final pos =\n'
          '      _tsc.mostRecentlyUpdatedPosition;\n'
          '  if (pos != null) {\n'
          '    print(\'Offset: \${pos.pixels}\');\n'
          '  }\n'
          '});',
      'color': Colors.teal[600]!,
    },
  ];

  print('  Usage patterns: ${patterns.length}');

  // ============================================================
  // SECTION 6: Edge Cases & Caveats
  // ============================================================
  print('=== Section 6: Edge Cases ===');

  final edgeCases = <Map<String, dynamic>>[
    {
      'title': 'offset Throws When No Position',
      'detail': 'Calling .offset before any scrollable attaches throws '
          'a StateError. Check positions.isNotEmpty first.',
      'icon': Icons.warning_amber,
      'color': Colors.orange[800]!,
    },
    {
      'title': 'Not for Independent Scrolling',
      'detail': 'If tabs need independent scroll positions, use '
          'separate ScrollControllers. The tracking controller '
          'shares initialScrollOffset across all positions.',
      'icon': Icons.warning_amber,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Position Count Varies',
      'detail': 'During tab transitions, two positions may be '
          'attached briefly. Don\'t assume exactly one position.',
      'icon': Icons.info_outline,
      'color': Colors.blue[700]!,
    },
    {
      'title': 'dispose Before Detach',
      'detail': 'Always dispose the controller AFTER the scrollable '
          'widgets are disposed. Usually this means disposing in '
          'the State that created it.',
      'icon': Icons.warning_amber,
      'color': Colors.orange[600]!,
    },
  ];

  print('  Edge cases: ${edgeCases.length}');

  // ============================================================
  // SECTION 7: Best Practices
  // ============================================================
  print('=== Section 7: Best Practices ===');

  final bestPractices = <Map<String, dynamic>>[
    {
      'title': 'One Controller per Tab Group',
      'detail': 'Create a single TrackingScrollController for each '
          'tab group. Don\'t share across unrelated tab bars.',
      'icon': Icons.rule,
      'color': Colors.indigo[800]!,
    },
    {
      'title': 'Check mostRecentlyUpdatedPosition',
      'detail': 'Always null-check the position. It\'s null before '
          'any scrolling occurs and may become null after detach.',
      'icon': Icons.check_circle_outline,
      'color': Colors.teal[700]!,
    },
    {
      'title': 'Combine with AutomaticKeepAlive',
      'detail': 'Use AutomaticKeepAliveClientMixin in tab pages to '
          'preserve scroll state. The controller tracks the '
          'position but pages still need to stay alive.',
      'icon': Icons.bookmark,
      'color': Colors.indigo[700]!,
    },
    {
      'title': 'Don\'t Use for Single ScrollView',
      'detail': 'For a single scrollable, use ScrollController. '
          'TrackingScrollController\'s overhead isn\'t justified '
          'without multiple attached positions.',
      'icon': Icons.cancel_outlined,
      'color': Colors.teal[600]!,
    },
  ];

  print('  Best practices: ${bestPractices.length}');

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
              colors: [Colors.indigo[800]!, Colors.teal[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.track_changes, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('TrackingScrollController',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'A ScrollController that unifies access to the most '
                'recently scrolled position — ideal for TabBarView '
                'and multi-scrollable layouts.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.indigo[800]!),
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
        _sectionHeader('2. API Surface', Icons.api, Colors.teal[700]!),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(a['icon'] as IconData, color: a['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(a['name'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: a['color'] as Color)),
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
                          SizedBox(height: 4),
                          Text(a['description'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Comparison Table ----
        _sectionHeader('3. Tracking vs Standard', Icons.compare_arrows, Colors.indigo[800]!),
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
                color: Colors.indigo[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('TrackingScroll', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('ScrollController', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(comparison.length, (i) {
                final c = comparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.indigo[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(c['feature'] as String,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                      Expanded(flex: 3, child: Text(c['tracking'] as String,
                          style: TextStyle(fontSize: 11))),
                      Expanded(flex: 3, child: Text(c['standard'] as String,
                          style: TextStyle(fontSize: 11))),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Position Lifecycle ----
        _sectionHeader('4. Position Lifecycle', Icons.timeline, Colors.teal[700]!),
        SizedBox(height: 10),
        ...lifecycleSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(s['step'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(s['icon'] as IconData, color: s['color'] as Color, size: 18),
                              SizedBox(width: 6),
                              Text(s['title'] as String,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: s['color'] as Color)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(s['detail'] as String, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Usage Patterns ----
        _sectionHeader('5. Usage Patterns', Icons.code, Colors.indigo[800]!),
        SizedBox(height: 10),
        ...patterns.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 12),
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
                    Text(p['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: p['color'] as Color)),
                    SizedBox(height: 4),
                    Text(p['description'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(p['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.tealAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Edge Cases ----
        _sectionHeader('6. Edge Cases', Icons.warning_amber, Colors.orange[800]!),
        SizedBox(height: 10),
        ...edgeCases.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (e['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: e['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(e['icon'] as IconData, color: e['color'] as Color, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(e['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Best Practices ----
        _sectionHeader('7. Best Practices', Icons.tips_and_updates, Colors.teal[700]!),
        SizedBox(height: 10),
        ...bestPractices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
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
                      width: 34,
                      height: 34,
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
                          SizedBox(height: 3),
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
              Icon(Icons.track_changes, color: Colors.indigo[600], size: 28),
              SizedBox(height: 6),
              Text(
                'TrackingScrollController: unified scroll tracking '
                'across multiple scrollable children — the missing '
                'link for TabBarView scroll state management.',
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
