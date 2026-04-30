// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DiagonalDragBehavior
// Demonstrates DiagonalDragBehavior — the enum that controls how
// diagonal drag gestures are resolved in two-dimensional scrolling
// surfaces. Covers all four values, weighted decomposition, the
// physics behind gesture splitting, and TwoDimensionalScrollView.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagonalDragBehavior Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DiagonalDragBehavior?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.open_with,
      'title': 'Two-Dimensional Scrolling',
      'body': 'DiagonalDragBehavior is an enum that specifies '
          'how a TwoDimensionalScrollView handles drag gestures '
          'that move diagonally — not purely horizontal or '
          'vertical. The default is "none", which locks '
          'scrolling to one axis at a time.',
      'accent': Colors.blue[800]!,
    },
    {
      'icon': Icons.gesture,
      'title': 'Gesture Decomposition',
      'body': 'When a user drags their finger diagonally, Flutter '
          'receives a single drag event. DiagonalDragBehavior '
          'tells the scroll view how to decompose that diagonal '
          'vector into horizontal and vertical components.',
      'accent': Colors.lightBlue[700]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Four Behavior Modes',
      'body': 'The enum offers four options: "none" (lock to first '
          'axis), "weightedEvent" (split each event by angle), '
          '"weightedContinuous" (smoothly blend axes over time), '
          'and "free" (allow unrestricted diagonal scrolling).',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.grid_view,
      'title': 'Table & Spreadsheet UIs',
      'body': 'DiagonalDragBehavior is essential for spreadsheet-style '
          'UIs where users naturally drag diagonally to navigate '
          'large grids. Without it, scrolling feels stuck to one '
          'axis and requires separate gestures for each direction.',
      'accent': Colors.lightBlue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: All Four Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'none',
      'fullName': 'DiagonalDragBehavior.none',
      'icon': Icons.block,
      'color': Colors.blue[800]!,
      'behavior': 'Lock to first axis',
      'description': 'The default behavior. Once the user begins '
          'dragging in one direction, scrolling is locked to '
          'that axis. All subsequent drag events only scroll '
          'horizontally or vertically, never both. This matches '
          'the familiar ListView/GridView behavior.',
      'useCase': 'Standard scrollable lists and grids where '
          'diagonal scrolling would be disorienting.',
    },
    {
      'name': 'weightedEvent',
      'fullName': 'DiagonalDragBehavior.weightedEvent',
      'icon': Icons.call_split,
      'color': Colors.lightBlue[700]!,
      'behavior': 'Split each drag event',
      'description': 'Each individual drag event is decomposed into '
          'horizontal and vertical components based on the angle '
          'of the drag. A 45° drag splits equally; a mostly-'
          'horizontal drag applies more to x. Each event is '
          'weighed independently — the decomposition can shift '
          'between events.',
      'useCase': 'Spreadsheets where occasional diagonal navigation '
          'is useful but axis-aligned drags should feel precise.',
    },
    {
      'name': 'weightedContinuous',
      'fullName': 'DiagonalDragBehavior.weightedContinuous',
      'icon': Icons.trending_up,
      'color': Colors.blue[700]!,
      'behavior': 'Smooth blended axes',
      'description': 'Similar to weightedEvent but uses continuous '
          'smoothing. Instead of each event independently '
          'determining its split, a running average of the '
          'drag angle determines the weighting. This produces '
          'smoother results for fast diagonal drags and reduces '
          'the jittery feel of per-event decomposition.',
      'useCase': 'Canvas or map views where smooth multi-axis '
          'panning is more important than axis precision.',
    },
    {
      'name': 'free',
      'fullName': 'DiagonalDragBehavior.free',
      'icon': Icons.open_with,
      'color': Colors.lightBlue[600]!,
      'behavior': 'Unrestricted diagonal',
      'description': 'Both axes receive the full drag delta. No '
          'decomposition or weighting is applied. Scrolling '
          'is completely free — the view moves exactly as the '
          'finger moves. This is the simplest and most '
          'intuitive for large zoomable or pannable surfaces.',
      'useCase': 'Map viewers, photo galleries, large dashboards '
          'where users expect direct manipulation panning.',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: How Decomposition Works
  // ============================================================
  print('=== Section 3: Decomposition ===');

  final decompositionSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Receive pointer event',
      'icon': Icons.touch_app,
      'color': Colors.blue[800]!,
      'detail': 'The GestureDetector receives an onPanUpdate event '
          'with a delta (dx, dy) representing how far the '
          'finger moved since the last frame. For a diagonal '
          'drag, both dx and dy are non-zero.',
    },
    {
      'step': 2,
      'label': 'Check DiagonalDragBehavior',
      'icon': Icons.rule,
      'color': Colors.lightBlue[700]!,
      'detail': 'TwoDimensionalScrollView reads its '
          'diagonalDragBehavior property. For "none", it '
          'checks which axis won the initial gesture contest '
          'and zeros out the other component.',
    },
    {
      'step': 3,
      'label': 'Apply weighting (if needed)',
      'icon': Icons.calculate,
      'color': Colors.blue[700]!,
      'detail': 'For weighted modes, the drag angle is calculated '
          '(atan2(dy, dx)). The angle determines how much '
          'of the total delta goes to each axis. A 30° drag '
          'gives ~87% to horizontal and ~50% to vertical. '
          'These percentages are applied as multipliers.',
    },
    {
      'step': 4,
      'label': 'Forward to scroll positions',
      'icon': Icons.swap_horiz,
      'color': Colors.lightBlue[600]!,
      'detail': 'The decomposed deltas are sent to the horizontal '
          'and vertical ScrollPositions respectively. Each '
          'position applies its own physics (clamping, '
          'bouncing) before updating. The view jumps to the '
          'new combined offset.',
    },
  ];

  print('  Prepared ${decompositionSteps.length} decomposition steps');

  // ============================================================
  // SECTION 4: Visual Angle Examples
  // ============================================================
  print('=== Section 4: Angle Examples ===');

  final angleExamples = <Map<String, dynamic>>[
    {
      'angle': '0° (pure horizontal)',
      'icon': Icons.arrow_forward,
      'color': Colors.blue[800]!,
      'hPct': '100%',
      'vPct': '0%',
      'desc': 'All behaviors identical — the full delta goes to '
          'horizontal scrolling. Vertical is untouched. This '
          'is the baseline all modes agree on.',
    },
    {
      'angle': '30° (mostly horizontal)',
      'icon': Icons.north_east,
      'color': Colors.lightBlue[700]!,
      'hPct': '~87%',
      'vPct': '~50%',
      'desc': 'Weighted modes give more to horizontal. The "none" '
          'mode locks to horizontal entirely and ignores the '
          'vertical component. "free" mode applies full delta '
          'to both axes.',
    },
    {
      'angle': '45° (perfect diagonal)',
      'icon': Icons.open_with,
      'color': Colors.blue[700]!,
      'hPct': '~71%',
      'vPct': '~71%',
      'desc': 'The symmetry point. Weighted modes split evenly. '
          '"none" mode picks whichever axis the gesture '
          'recognizer won first. "free" gives 100% to both.',
    },
    {
      'angle': '60° (mostly vertical)',
      'icon': Icons.north_east,
      'color': Colors.lightBlue[600]!,
      'hPct': '~50%',
      'vPct': '~87%',
      'desc': 'Weighted modes favor vertical. The horizontal '
          'component is attenuated. "none" mode would likely '
          'lock to vertical. "free" gives full delta to both.',
    },
    {
      'angle': '90° (pure vertical)',
      'icon': Icons.arrow_upward,
      'color': Colors.blue[900]!,
      'hPct': '0%',
      'vPct': '100%',
      'desc': 'All behaviors identical — the full delta goes to '
          'vertical scrolling. Horizontal is untouched. '
          'Mirror of the 0° case.',
    },
  ];

  print('  Prepared ${angleExamples.length} angle examples');

  // ============================================================
  // SECTION 5: Comparison Table
  // ============================================================
  print('=== Section 5: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Diagonal scroll',
      'none': 'No',
      'wEvent': 'Yes',
      'wCont': 'Yes',
      'free': 'Yes',
    },
    {
      'aspect': 'Axis locking',
      'none': 'Yes',
      'wEvent': 'No',
      'wCont': 'No',
      'free': 'No',
    },
    {
      'aspect': 'Per-event split',
      'none': 'N/A',
      'wEvent': 'Yes',
      'wCont': 'Smoothed',
      'free': 'N/A',
    },
    {
      'aspect': 'Smooth panning',
      'none': 'Worst',
      'wEvent': 'Good',
      'wCont': 'Best',
      'free': 'Direct',
    },
    {
      'aspect': 'Axis precision',
      'none': 'Best',
      'wEvent': 'Good',
      'wCont': 'Moderate',
      'free': 'N/A',
    },
    {
      'aspect': 'CPU overhead',
      'none': 'Minimal',
      'wEvent': 'Low',
      'wCont': 'Low',
      'free': 'Minimal',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 6: Usage with TwoDimensionalScrollView
  // ============================================================
  print('=== Section 6: Usage ===');

  final usageCards = <Map<String, dynamic>>[
    {
      'title': 'Setting via Constructor',
      'icon': Icons.build,
      'color': Colors.blue[800]!,
      'code': 'TwoDimensionalScrollView(\n'
          '  diagonalDragBehavior:\n'
          '    DiagonalDragBehavior.free,\n'
          '  delegate: myDelegate,\n'
          '  // ...\n'
          ')',
      'description': 'The simplest way. Pass the enum directly '
          'to the TwoDimensionalScrollView constructor. The '
          'scroll view handles decomposition internally.',
    },
    {
      'title': 'Conditional per Platform',
      'icon': Icons.phone_android,
      'color': Colors.lightBlue[700]!,
      'code': 'DiagonalDragBehavior\n'
          '  _pickBehavior() {\n'
          '  if (kIsWeb) return\n'
          '    DiagonalDragBehavior.free;\n'
          '  return DiagonalDragBehavior\n'
          '      .weightedContinuous;\n'
          '}',
      'description': 'Desktop/web users expect free panning with '
          'a mouse. Mobile users benefit from weighted modes '
          'that adapt to imprecise touch input.',
    },
    {
      'title': 'With TableView',
      'icon': Icons.table_chart,
      'color': Colors.blue[700]!,
      'code': 'TableView(\n'
          '  diagonalDragBehavior:\n'
          '    DiagonalDragBehavior\n'
          '        .weightedEvent,\n'
          '  columnCount: 20,\n'
          '  rowCount: 100,\n'
          '  // ...\n'
          ')',
      'description': 'TableView is a subclass of '
          'TwoDimensionalScrollView. WeightedEvent is ideal '
          'for spreadsheet-like UIs where precise column/row '
          'alignment matters but diagonal shortcuts help.',
    },
    {
      'title': 'Dynamic Switching',
      'icon': Icons.toggle_on,
      'color': Colors.lightBlue[600]!,
      'code': 'setState(() {\n'
          '  _behavior = isEditing\n'
          '    ? DiagonalDragBehavior\n'
          '        .none\n'
          '    : DiagonalDragBehavior\n'
          '        .free;\n'
          '});',
      'description': 'Switch behavior based on app state. During '
          'cell editing, lock to one axis to avoid accidental '
          'scrolling. In browse mode, allow free diagonal ',
    },
  ];

  print('  Prepared ${usageCards.length} usage cards');

  // ============================================================
  // SECTION 7: Common Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = <Map<String, dynamic>>[
    {
      'title': 'Using free on Touch Devices',
      'icon': Icons.warning_amber,
      'severity': 'warning',
      'color': Colors.amber[400]!,
      'body': 'Free mode passes full delta to both axes. On touch '
          'devices, imprecise finger movement creates jittery '
          'diagonal scrolling when the user intended to scroll '
          'vertically. Prefer weightedEvent or '
          'weightedContinuous on mobile.',
    },
    {
      'title': 'None Mode with Large Grids',
      'icon': Icons.warning_amber,
      'severity': 'warning',
      'color': Colors.amber[400]!,
      'body': 'If your grid is 50 columns by 1000 rows, "none" '
          'forces users to do two separate gestures (scroll '
          'right, then scroll down) to reach a diagonal cell. '
          'This is frustrating — use a weighted mode instead.',
    },
    {
      'title': 'Ignoring ScrollPhysics Interaction',
      'icon': Icons.lightbulb_outline,
      'severity': 'info',
      'color': Colors.blue[300]!,
      'body': 'Each axis has its own ScrollPhysics. When using '
          'weighted modes, the decomposed deltas interact with '
          'physics separately. Bouncing on one axis while the '
          'other is clamped can feel odd. Consider using the '
          'same physics on both axes.',
    },
    {
      'title': 'Testing All Modes',
      'icon': Icons.check_circle_outline,
      'severity': 'tip',
      'color': Colors.green[400]!,
      'body': 'Provide a debug toggle that lets QA testers switch '
          'between all four modes. What feels best depends on '
          'content density, screen size, and input device. '
          'Test on both touch and mouse.',
    },
  ];

  print('  Prepared ${pitfalls.length} pitfalls');

  // ============================================================
  // SECTION 8: Mode Selection Guidelines
  // ============================================================
  print('=== Section 8: Mode Selection ===');

  final modeGuidelines = <Map<String, dynamic>>[
    {
      'scenario': 'Simple list or grid',
      'recommended': 'none',
      'icon': Icons.view_list,
      'color': Colors.blue[800]!,
      'reason': 'Single-axis scrolling is all that\'s needed. '
          'Axis locking prevents accidental diagonal movement '
          'and feels natural for vertical feeds or horizontal '
          'carousels.',
    },
    {
      'scenario': 'Data table / spreadsheet',
      'recommended': 'weightedEvent',
      'icon': Icons.table_chart,
      'color': Colors.lightBlue[700]!,
      'reason': 'Users need to navigate rows and columns '
          'simultaneously but also need precision when scrolling '
          'along a single axis. Per-event weighting gives a '
          'good balance.',
    },
    {
      'scenario': 'Map or canvas',
      'recommended': 'free',
      'icon': Icons.map,
      'color': Colors.blue[700]!,
      'reason': 'Direct manipulation. Users expect the content to '
          'move exactly where they drag. No axis preference. '
          'Combined with zoom gestures for full pan-and-zoom.',
    },
    {
      'scenario': 'Dashboard with mixed content',
      'recommended': 'weightedContinuous',
      'icon': Icons.dashboard,
      'color': Colors.lightBlue[600]!,
      'reason': 'Smooth diagonal panning for exploring a large '
          'dashboard. Continuous weighting reduces jumpiness '
          'when dragging across different angles. Good for '
          'touch-heavy interfaces.',
    },
    {
      'scenario': 'Cross-platform app',
      'recommended': 'Conditional',
      'icon': Icons.devices,
      'color': Colors.blue[900]!,
      'reason': 'Use free mode on desktop (mouse is precise), '
          'weightedContinuous on mobile (smooths touch '
          'imprecision), and none on TV (D-pad is axis-aligned). '
          'Choose per platform for best UX.',
    },
  ];

  print('  Prepared ${modeGuidelines.length} mode guidelines');

  // ============================================================
  // SECTION 9: Tips & Summary
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Default is None',
      'body': 'If you don\'t specify diagonalDragBehavior, it '
          'defaults to DiagonalDragBehavior.none. This means '
          'TwoDimensionalScrollView acts like axis-locked '
          'scrolling by default. Explicitly set it when you '
          'want diagonal support.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Pair with ScrollPhysics',
      'body': 'For the best UX, match your DiagonalDragBehavior '
          'and ScrollPhysics. Free mode + BouncingScrollPhysics '
          'on both axes gives a natural iOS-like feel. Weighted '
          'modes + ClampingScrollPhysics gives an Android feel.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Performance with Free Mode',
      'body': 'Free mode updates both scroll positions on every '
          'frame. For very complex content (thousands of cells), '
          'this means double the layout work. Profile to ensure '
          'you maintain 60fps, or reduce visible cell count.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Fling Behavior Follows',
      'body': 'The chosen DiagonalDragBehavior also affects fling '
          'animations. In "none" mode, flings are single-axis. '
          'In "free" mode, flings are diagonal. Weighted modes '
          'decompose fling velocity the same way they decompose '
          'drag deltas.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Accessibility Note',
      'body': 'Screen readers and switch control use axis-aligned '
          'navigation. DiagonalDragBehavior only affects touch '
          'and mouse input — accessibility services always use '
          'single-axis scrolling regardless of this setting.',
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
      title: Text('DiagonalDragBehavior'),
      backgroundColor: Colors.blue[800],
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
                colors: [Colors.blue[800]!, Colors.lightBlue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.open_with, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DiagonalDragBehavior',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An enum that controls how diagonal drag gestures '
                  'are handled in TwoDimensionalScrollView — from '
                  'strict axis locking to free diagonal panning.',
                  style: TextStyle(
                    color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _dgHead('1', 'What is DiagonalDragBehavior?'),
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
                          color: card['accent'] as Color, width: 4)),
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

          // ── Section 2: Enum Values ──
          _dgHead('2', 'All Four Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ev['color'] as Color, width: 5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ev['icon'] as IconData,
                            color: ev['color'] as Color, size: 24),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ev['fullName'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: ev['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 4),
                      _dgTag(ev['behavior'] as String,
                          ev['color'] as Color),
                      SizedBox(height: 8),
                      Text(ev['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.35)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(children: [
                          Icon(Icons.lightbulb_outline,
                              size: 12,
                              color: Colors.blue[800]),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text('Use case: ${ev['useCase']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue[800],
                                    fontStyle: FontStyle.italic)),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Decomposition Steps ──
          _dgHead('3', 'How Decomposition Works'),
          SizedBox(height: 12),
          ...decompositionSteps.map((ds) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ds['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: ds['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ds['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(ds['icon'] as IconData,
                                  color: ds['color'] as Color,
                                  size: 14),
                              SizedBox(width: 4),
                              Text(ds['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ]),
                            SizedBox(height: 3),
                            Text(ds['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Angle Examples ──
          _dgHead('4', 'Angle-Based Decomposition'),
          SizedBox(height: 12),
          ...angleExamples.map((ae) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ae['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ae['icon'] as IconData,
                            color: ae['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ae['angle'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _dgTag('H: ${ae['hPct']}',
                            Colors.blue[700]!),
                        SizedBox(width: 4),
                        _dgTag('V: ${ae['vPct']}',
                            Colors.lightBlue[700]!),
                      ]),
                      SizedBox(height: 6),
                      Text(ae['desc'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Comparison Table ──
          _dgHead('5', 'Mode Comparison'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('Aspect',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      for (final h in [
                        'none',
                        'wEvent',
                        'wCont',
                        'free'
                      ])
                        Expanded(
                            flex: 2,
                            child: Text(h,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9))),
                    ],
                  ),
                ),
                ...comparisonRows.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final row = entry.value;
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 6, horizontal: 8),
                    color: idx.isEven ? Colors.grey[50] : Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(row['aspect'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                        for (final k in [
                          'none',
                          'wEvent',
                          'wCont',
                          'free'
                        ])
                          Expanded(
                              flex: 2,
                              child: Text(row[k] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[700]))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 6: Usage ──
          _dgHead('6', 'Usage Patterns'),
          SizedBox(height: 12),
          ...usageCards.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4)),
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
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(uc['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.lightBlue[300],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Pitfalls ──
          _dgHead('7', 'Common Pitfalls'),
          SizedBox(height: 12),
          ...pitfalls.map((p) {
            Color bgColor;
            Color borderColor;
            switch (p['severity']) {
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
                      Icon(p['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(p['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(p['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 8: Mode Selection ──
          _dgHead('8', 'Mode Selection Guide'),
          SizedBox(height: 12),
          ...modeGuidelines.map((mg) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: mg['color'] as Color, width: 4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(mg['icon'] as IconData,
                            color: mg['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(mg['scenario'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                        _dgTag(mg['recommended'] as String,
                            mg['color'] as Color),
                      ]),
                      SizedBox(height: 4),
                      Text(mg['reason'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dgHead('9', 'Tips & Summary'),
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
              'End of DiagonalDragBehavior Deep Demo',
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
Widget _dgHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blue[800],
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
// Helper: Small rounded tag/badge
// ──────────────────────────────────────────────────────────
Widget _dgTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
