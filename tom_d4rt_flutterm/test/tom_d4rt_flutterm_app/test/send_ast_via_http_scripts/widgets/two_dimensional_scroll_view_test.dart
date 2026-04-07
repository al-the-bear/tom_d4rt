// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TwoDimensionalScrollView
// Demonstrates TwoDimensionalScrollView, the abstract base class for
// scrolling widgets that scroll content in both the horizontal and
// vertical axis simultaneously (spreadsheets, grids, game maps, etc.).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalScrollView Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.grid_on,
      'title': 'What is TwoDimensionalScrollView?',
      'body': 'TwoDimensionalScrollView is the abstract base for widgets '
          'that allow scrolling along both the horizontal and vertical '
          'axes at the same time. Unlike ListView (vertical only) or '
          'SingleChildScrollView (one axis at a time), this enables '
          'true 2D navigation like spreadsheets.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.open_with,
      'title': 'Why Two Dimensions?',
      'body': 'Many real-world UIs need simultaneous X+Y scrolling: '
          'data grids with hundreds of columns and rows, tile-based '
          'game worlds, calendar month views with time slots, '
          'seating charts, and image galleries with infinite canvas.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.memory,
      'title': 'Lazy Rendering',
      'body': 'Like ListView and GridView, TwoDimensionalScrollView only '
          'builds and renders the cells currently visible in the '
          'viewport. A 10,000 x 10,000 grid uses the same memory '
          'as the ~20 visible cells.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.architecture,
      'title': 'Architecture',
      'body': 'TwoDimensionalScrollView creates a TwoDimensionalScrollable '
          '(manages two ScrollPositions) which hosts a '
          'TwoDimensionalViewport (performs the 2D layout). You '
          'typically use a concrete subclass or compose your own.',
      'accent': Colors.deepPurple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'verticalDetails',
      'type': 'ScrollableDetails',
      'desc': 'Configuration for the vertical scrolling axis. Includes '
          'the ScrollController, scroll direction, physics, and '
          'decoration. Controls how vertical scrolling behaves.',
    },
    {
      'name': 'horizontalDetails',
      'type': 'ScrollableDetails',
      'desc': 'Configuration for the horizontal scrolling axis. Same '
          'structure as verticalDetails but for the horizontal '
          'dimension. Both axes are controlled independently.',
    },
    {
      'name': 'diagonalDragBehavior',
      'type': 'DiagonalDragBehavior',
      'desc': 'How diagonal drag gestures are interpreted: none (lock to '
          'first axis), free (true 2D panning), '
          'weightedEvent/weightedContinuous (prefer dominant axis).',
    },
    {
      'name': 'delegate',
      'type': 'TwoDimensionalChildDelegate',
      'desc': 'Provides children for the 2D viewport. Can be a builder '
          'delegate (lazy, for large grids) or a list delegate '
          '(fixed set of children with known positions).',
    },
    {
      'name': 'mainAxis',
      'type': 'Axis',
      'desc': 'The primary axis for the 2D layout. Determines which '
          'direction is laid out first: Axis.vertical means rows '
          'first, Axis.horizontal means columns first.',
    },
    {
      'name': 'cacheExtent',
      'type': 'double?',
      'desc': 'How many pixels beyond the viewport to pre-render. '
          'Higher values mean smoother scrolling but more memory '
          'usage. Applies to both axes simultaneously.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    final isEvenRow = i.isEven;
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isEvenRow
              ? Colors.orange.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange.withOpacity(0.25)),
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
                    color: Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
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
  // SECTION 3: Grid Visualizations
  // ============================================================
  print('=== Section 3: Grid Patterns ===');

  // Spreadsheet-style grid
  final spreadsheetRows = <Widget>[];
  final colHeaders = ['', 'A', 'B', 'C', 'D', 'E'];
  for (var row = 0; row < 8; row++) {
    final cells = <Widget>[];
    for (var col = 0; col < colHeaders.length; col++) {
      final isHeader = row == 0 || col == 0;
      String text;
      if (row == 0 && col == 0) {
        text = '';
      } else if (row == 0) {
        text = colHeaders[col];
      } else if (col == 0) {
        text = '$row';
      } else {
        text = '${colHeaders[col]}$row';
      }
      cells.add(
        Container(
          width: 52,
          height: 32,
          decoration: BoxDecoration(
            color: isHeader
                ? Colors.orange.withOpacity(0.12)
                : (row.isEven
                    ? Colors.grey.withOpacity(0.04)
                    : Colors.white),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader
                    ? Colors.orange.shade800
                    : Colors.grey.shade700,
              ),
            ),
          ),
        ),
      );
    }
    spreadsheetRows.add(Row(children: cells));
  }
  print('Built spreadsheet grid: 8 rows x 6 cols');

  // Calendar month grid
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final calendarRows = <Widget>[];
  // Header row
  calendarRows.add(
    Row(
      children: weekDays
          .map((d) => Container(
                width: 42,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    d,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ))
          .toList(),
    ),
  );
  // Day rows (April 2026 starts on Wednesday)
  final dayNums = [
    [0, 0, 1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10, 11, 12],
    [13, 14, 15, 16, 17, 18, 19],
    [20, 21, 22, 23, 24, 25, 26],
    [27, 28, 29, 30, 0, 0, 0],
  ];
  for (final week in dayNums) {
    calendarRows.add(
      Row(
        children: week.map((d) {
          final isToday = d == 7;
          return Container(
            width: 42,
            height: 34,
            decoration: BoxDecoration(
              color: isToday
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.transparent,
              border: Border.all(
                color: Colors.grey.withOpacity(0.15),
                width: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                d > 0 ? '$d' : '',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  color: isToday
                      ? Colors.blue.shade800
                      : Colors.grey.shade700,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  print('Built calendar grid: April 2026');

  // Periodic table fragment
  final elements = <Map<String, dynamic>>[
    {'sym': 'H', 'num': 1, 'color': Colors.red},
    {'sym': 'He', 'num': 2, 'color': Colors.purple},
    {'sym': 'Li', 'num': 3, 'color': Colors.orange},
    {'sym': 'Be', 'num': 4, 'color': Colors.amber},
    {'sym': 'B', 'num': 5, 'color': Colors.green},
    {'sym': 'C', 'num': 6, 'color': Colors.teal},
    {'sym': 'N', 'num': 7, 'color': Colors.blue},
    {'sym': 'O', 'num': 8, 'color': Colors.blue},
    {'sym': 'F', 'num': 9, 'color': Colors.cyan},
    {'sym': 'Ne', 'num': 10, 'color': Colors.purple},
  ];
  final elementWidgets = <Widget>[];
  for (final el in elements) {
    final elColor = el['color'] as Color;
    elementWidgets.add(
      Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: elColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: elColor.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${el['num']}',
              style: TextStyle(fontSize: 8, color: elColor),
            ),
            Text(
              el['sym'] as String,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: elColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built periodic table fragment: 10 elements');

  // ============================================================
  // SECTION 4: Diagonal Drag Behavior
  // ============================================================
  print('=== Section 4: Diagonal Drag ===');

  final dragModes = <Map<String, dynamic>>[
    {
      'mode': 'none',
      'desc': 'Diagonal drags are decomposed into their horizontal and '
          'vertical components. Each axis scrolls independently. '
          'A diagonal gesture scrolls the dominant axis only.',
      'visual': 'First touch direction locks scrolling axis',
      'icon': Icons.lock,
      'color': Colors.red,
    },
    {
      'mode': 'free',
      'desc': 'True 2D panning. A diagonal drag moves both axes '
          'simultaneously with no constraints. Ideal for maps, '
          'game worlds, and canvas-style interfaces.',
      'visual': 'Free movement in any direction',
      'icon': Icons.open_with,
      'color': Colors.green,
    },
    {
      'mode': 'weightedEvent',
      'desc': 'Each pointer event is independently routed to the axis '
          'with greater delta. Fast diagonal drags can alternate '
          'between axes per event. Balanced but jittery.',
      'visual': 'Per-event axis weighting',
      'icon': Icons.balance,
      'color': Colors.blue,
    },
    {
      'mode': 'weightedContinuous',
      'desc': 'Like weightedEvent, but once an axis is chosen it '
          'continues until the gesture changes direction enough. '
          'Smoother than weightedEvent for typical use.',
      'visual': 'Continuous axis weighting with momentum',
      'icon': Icons.trending_flat,
      'color': Colors.purple,
    },
  ];

  final dragWidgets = <Widget>[];
  for (var i = 0; i < dragModes.length; i++) {
    final dm = dragModes[i];
    final dmColor = dm['color'] as Color;
    print('Drag mode ${i + 1}: ${dm['mode']}');

    // Build a small directional diagram
    final arrows = <Widget>[];
    if (dm['mode'] == 'none') {
      arrows.addAll([
        Icon(Icons.arrow_upward, size: 16, color: dmColor),
        Icon(Icons.arrow_downward, size: 16, color: dmColor),
        Icon(Icons.arrow_back, size: 16, color: dmColor.withOpacity(0.3)),
        Icon(Icons.arrow_forward, size: 16, color: dmColor.withOpacity(0.3)),
      ]);
    } else if (dm['mode'] == 'free') {
      arrows.addAll([
        Icon(Icons.arrow_upward, size: 16, color: dmColor),
        Icon(Icons.arrow_downward, size: 16, color: dmColor),
        Icon(Icons.arrow_back, size: 16, color: dmColor),
        Icon(Icons.arrow_forward, size: 16, color: dmColor),
      ]);
    } else {
      arrows.addAll([
        Icon(Icons.arrow_upward, size: 16, color: dmColor),
        Icon(Icons.arrow_downward, size: 16, color: dmColor.withOpacity(0.7)),
        Icon(Icons.arrow_back, size: 16, color: dmColor.withOpacity(0.5)),
        Icon(Icons.arrow_forward, size: 16, color: dmColor.withOpacity(0.5)),
      ]);
    }

    dragWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: dmColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dmColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: dmColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: arrows,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(dm['icon'] as IconData, size: 18, color: dmColor),
                        const SizedBox(width: 6),
                        Text(
                          dm['mode'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: dmColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dm['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: dmColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        dm['visual'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: dmColor,
                        ),
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
  // SECTION 5: Delegates
  // ============================================================
  print('=== Section 5: Delegates ===');

  final delegateTypes = <Map<String, dynamic>>[
    {
      'name': 'TwoDimensionalChildBuilderDelegate',
      'desc': 'Lazily builds children on demand using a builder callback. '
          'Ideal for large or infinite grids where creating all '
          'children upfront is impractical.',
      'pros': ['Lazy — builds only visible cells',
               'Works with infinite grids',
               'Low memory footprint'],
      'cons': ['Must specify maxXIndex/maxYIndex for finite grids',
               'Builder called on each layout pass'],
      'code': 'TwoDimensionalChildBuilderDelegate(\n'
          '  maxXIndex: 99,\n'
          '  maxYIndex: 999,\n'
          '  builder: (ctx, vicinity) {\n'
          '    return Container(\n'
          '      child: Text("R\${vicinity.yIndex} C\${vicinity.xIndex}"),\n'
          '    );\n'
          '  },\n'
          ')',
      'color': Colors.orange,
    },
    {
      'name': 'TwoDimensionalChildListDelegate',
      'desc': 'Provides a fixed 2D list of prebuilt children. Simpler '
          'to use when the grid is small and all cells are known '
          'upfront. Less flexible but more predictable.',
      'pros': ['Simple API — just a List<List<Widget>>',
               'All children created once',
               'Easy to reason about'],
      'cons': ['All children in memory at once',
               'Not suitable for large grids'],
      'code': 'TwoDimensionalChildListDelegate(\n'
          '  children: [\n'
          '    [Cell(0,0), Cell(0,1), Cell(0,2)],\n'
          '    [Cell(1,0), Cell(1,1), Cell(1,2)],\n'
          '    [Cell(2,0), Cell(2,1), Cell(2,2)],\n'
          '  ],\n'
          ')',
      'color': Colors.blue,
    },
  ];

  final delegateWidgets = <Widget>[];
  for (var i = 0; i < delegateTypes.length; i++) {
    final dt = delegateTypes[i];
    final dtColor = dt['color'] as Color;
    final pros = dt['pros'] as List<String>;
    final cons = dt['cons'] as List<String>;
    print('Delegate ${i + 1}: ${dt['name']}');
    delegateWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: dtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dt['name'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dtColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Advantages',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...pros.map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '\u2713 ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      p,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Limitations',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...cons.map((c) => Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '\u2717 ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      c,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  dt['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.4,
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
  // SECTION 6: Layout Concepts
  // ============================================================
  print('=== Section 6: Layout ===');

  final layoutTopics = <Map<String, dynamic>>[
    {
      'title': 'ChildVicinity',
      'desc': 'Each cell in a 2D grid is identified by a ChildVicinity '
          'containing xIndex and yIndex. This replaces the linear '
          'index used in 1D scrollables.',
      'diagram': '(0,0) (1,0) (2,0) (3,0)\n'
          '(0,1) (1,1) (2,1) (3,1)\n'
          '(0,2) (1,2) (2,2) (3,2)',
      'color': Colors.orange,
    },
    {
      'title': 'Main Axis',
      'desc': 'The mainAxis determines which direction is iterated first. '
          'Axis.vertical: iterate rows, lay out cells left-to-right. '
          'Axis.horizontal: iterate columns, lay out cells top-to-bottom.',
      'diagram': 'Axis.vertical:     Axis.horizontal:\n'
          'Row 0: [C C C C]   Col 0: [C]\n'
          'Row 1: [C C C C]          [C]\n'
          'Row 2: [C C C C]          [C]',
      'color': Colors.blue,
    },
    {
      'title': 'Viewport Extent',
      'desc': 'The 2D viewport has both a horizontal and vertical extent. '
          'Cells outside the visible extent plus cacheExtent are '
          'garbage collected. This ensures constant memory usage.',
      'diagram': '+---visible---+  cache\n'
          '|  [C][C][C]  | [c][c]\n'
          '|  [C][C][C]  | [c][c]\n'
          '+-------------+\n'
          '   [c][c][c]    [c][c]  <- cached',
      'color': Colors.green,
    },
  ];

  final layoutWidgets = <Widget>[];
  for (var i = 0; i < layoutTopics.length; i++) {
    final lt = layoutTopics[i];
    final ltColor = lt['color'] as Color;
    print('Layout ${i + 1}: ${lt['title']}');
    layoutWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ltColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ltColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lt['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ltColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                lt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  lt['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
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
  // SECTION 7: Comparisons
  // ============================================================
  print('=== Section 7: Comparisons ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'widget': 'TwoDimensionalScrollView',
      'axes': '2 (H+V simultaneously)',
      'lazy': 'Yes — builds visible cells only',
      'use': 'Spreadsheets, data grids, tile maps',
      'icon': Icons.grid_on,
      'color': Colors.orange,
    },
    {
      'widget': 'GridView',
      'axes': '1 (scrolls one axis)',
      'lazy': 'Yes — builds visible items',
      'use': 'Photo galleries, product grids, icon grids',
      'icon': Icons.grid_view,
      'color': Colors.blue,
    },
    {
      'widget': 'SingleChildScrollView',
      'axes': '1 (or nested for 2)',
      'lazy': 'No — renders all content',
      'use': 'Forms, small content, text blocks',
      'icon': Icons.vertical_align_center,
      'color': Colors.green,
    },
    {
      'widget': 'InteractiveViewer',
      'axes': '2 (pan + zoom)',
      'lazy': 'No — all content always built',
      'use': 'Zoomable images, diagrams, maps',
      'icon': Icons.zoom_in,
      'color': Colors.purple,
    },
    {
      'widget': 'CustomScrollView',
      'axes': '1 (multiple slivers)',
      'lazy': 'Yes — via slivers',
      'use': 'Complex scroll layouts, headers, mixed lists',
      'icon': Icons.view_agenda,
      'color': Colors.teal,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final c = comparisons[i];
    final cColor = c['color'] as Color;
    final isMain = i == 0;
    print('Compare ${i + 1}: ${c['widget']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMain
              ? cColor.withOpacity(0.1)
              : cColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: cColor.withOpacity(isMain ? 0.4 : 0.2),
            width: isMain ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                c['icon'] as IconData,
                color: cColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['widget'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Axes: ${c['axes']}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'Lazy: ${c['lazy']}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    c['use'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
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
      'icon': Icons.grid_on,
      'text': 'TwoDimensionalScrollView enables true simultaneous '
          'horizontal and vertical scrolling for data-heavy UIs.',
    },
    {
      'icon': Icons.memory,
      'text': 'Only visible cells are rendered. A million-cell grid '
          'uses the same memory as the ~20 visible cells.',
    },
    {
      'icon': Icons.open_with,
      'text': 'Four diagonal drag behaviors control whether gestures '
          'lock, pan freely, or weight toward dominant axis.',
    },
    {
      'icon': Icons.build,
      'text': 'Builder delegates lazily create cells on demand. List '
          'delegates provide all cells upfront for small grids.',
    },
    {
      'icon': Icons.architecture,
      'text': 'Composed of TwoDimensionalScrollable (input handling) and '
          'TwoDimensionalViewport (2D layout and painting).',
    },
    {
      'icon': Icons.compare,
      'text': 'Unlike GridView (1D scrolling) or InteractiveViewer '
          '(no lazy rendering), this combines lazy building with 2D scroll.',
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
          color: Colors.orange.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.orange.shade800,
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
        title: const Text('TwoDimensionalScrollView'),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.grid_on), text: 'Grids'),
            Tab(icon: Icon(Icons.open_with), text: 'Diagonal'),
            Tab(icon: Icon(Icons.build), text: 'Delegates'),
            Tab(icon: Icon(Icons.view_quilt), text: 'Layout'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1 — Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TwoDimensionalScrollView: the base class for widgets '
                  'that scroll content along both axes simultaneously.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2 — API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor parameters and configuration options.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3 — Grid Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Visual examples of 2D grid patterns.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              // Spreadsheet
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spreadsheet Grid',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(children: spreadsheetRows),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A classic 2D scrollable use case: rows and columns '
                      'that scroll both horizontally and vertically.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              // Calendar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calendar Month View',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(children: calendarRows),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Time-slot calendars with many weeks/hours benefit '
                      'from 2D scrolling: days on X, hours on Y.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              // Periodic table
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Periodic Table Fragment',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(children: elementWidgets),
                    const SizedBox(height: 4),
                    Text(
                      'The periodic table is a naturally 2D layout: '
                      'groups on X, periods on Y. Large datasets need '
                      '2D scroll for exploration.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Tab 4 — Diagonal Drag
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'DiagonalDragBehavior controls how diagonal gestures '
                  'are mapped to the two scroll axes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...dragWidgets,
            ],
          ),
          // Tab 5 — Delegates
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Two delegate strategies for providing children '
                  'to the 2D viewport.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...delegateWidgets,
            ],
          ),
          // Tab 6 — Layout
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How cells are identified, ordered, and rendered.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...layoutWidgets,
            ],
          ),
          // Tab 7 — Comparisons
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How TwoDimensionalScrollView compares to other '
                  'scrollable widgets in Flutter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
            ],
          ),
          // Tab 8 — Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withOpacity(0.12),
                      Colors.deepOrange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TwoDimensionalScrollView.',
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
