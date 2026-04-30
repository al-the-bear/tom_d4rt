// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — ChildVicinity
// Demonstrates ChildVicinity — the immutable 2D coordinate class
// used to identify children in TwoDimensionalScrollView and its
// delegates. Covers properties, construction, equality, delegate
// integration, coordinate mapping strategies, and practical layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChildVicinity Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ChildVicinity?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.grid_on,
      'title': '2D Coordinate for Scroll Children',
      'body': 'ChildVicinity is a simple immutable class that holds '
          'two integer indices: xIndex (column) and yIndex (row). It '
          'uniquely identifies a child in a TwoDimensionalScrollView, '
          'much like how a single integer index identifies a child '
          'in a regular ListView.',
      'accent': Colors.red[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'From 1D to 2D Indexing',
      'body': 'In a ListView, child 5 means the 6th item. But in a '
          'TwoDimensionalScrollView, you need TWO indices: column and '
          'row. ChildVicinity(xIndex: 2, yIndex: 3) means column 2, '
          'row 3. This is the fundamental building block of 2D '
          'scrolling.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.extension,
      'title': 'Used by Delegates and Builders',
      'body': 'TwoDimensionalChildBuilderDelegate receives a '
          'ChildVicinity in its builder callback. Your builder '
          'function uses the xIndex and yIndex to determine what '
          'widget to display at that coordinate. The delegate also '
          'uses it for maxXIndex/maxYIndex boundary checks.',
      'accent': Colors.red[600]!,
    },
    {
      'icon': Icons.check_circle,
      'title': 'Comparable & Value Equality',
      'body': 'ChildVicinity implements Comparable<ChildVicinity>. '
          'Two vicinities with the same xIndex and yIndex are equal. '
          'Comparison sorts by yIndex first (row-major), then xIndex. '
          'This ordering matches typical reading order: left-to-right, '
          'top-to-bottom.',
      'accent': Colors.pink[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties & Construction
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'xIndex',
      'type': 'int',
      'icon': Icons.swap_horiz,
      'color': Colors.red[700]!,
      'description': 'The column index (horizontal position). Starts '
          'at 0 for the leftmost column. In a spreadsheet metaphor, '
          'this is the letter column (A=0, B=1, C=2). In a game '
          'board, this is the x-coordinate.',
    },
    {
      'name': 'yIndex',
      'type': 'int',
      'icon': Icons.swap_vert,
      'color': Colors.pink[700]!,
      'description': 'The row index (vertical position). Starts at 0 '
          'for the topmost row. In a spreadsheet, this is the numeric '
          'row (1=0, 2=1, 3=2). In a game board, this is the '
          'y-coordinate.',
    },
    {
      'name': 'constructor',
      'type': 'ChildVicinity({required int xIndex, required int yIndex})',
      'icon': Icons.build,
      'color': Colors.red[600]!,
      'description': 'Both parameters are required named parameters. '
          'There is no unnamed positional constructor. This makes the '
          'code self-documenting: ChildVicinity(xIndex: 2, yIndex: 5) '
          'clearly shows which dimension is which.',
    },
    {
      'name': 'operator ==',
      'type': 'bool',
      'icon': Icons.balance,
      'color': Colors.pink[600]!,
      'description': 'Value equality: two ChildVicinity instances are '
          'equal if and only if their xIndex and yIndex match. This '
          'means you can use ChildVicinity as a Map key or in a Set. '
          'The hashCode is also based on both indices.',
    },
    {
      'name': 'compareTo()',
      'type': 'int',
      'icon': Icons.sort,
      'color': Colors.red[800]!,
      'description': 'Compares first by yIndex (row), then by xIndex '
          '(column) for equal rows. This gives row-major ordering: '
          '(0,0), (1,0), (2,0), (0,1), (1,1), (2,1), etc. Matches '
          'how a reader scans a page.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: Visual Grid Coordinate System
  // ============================================================
  print('=== Section 3: Coordinate System ===');

  // 4x6 grid of coordinates
  const gridRows = 6;
  const gridCols = 4;

  final gridCells = <Map<String, dynamic>>[];
  for (var row = 0; row < gridRows; row++) {
    for (var col = 0; col < gridCols; col++) {
      final isHighlighted = (col == 2 && row == 3);
      final isOrigin = (col == 0 && row == 0);
      gridCells.add({
        'x': col,
        'y': row,
        'highlighted': isHighlighted,
        'origin': isOrigin,
        'color': isHighlighted
            ? Colors.red[600]!
            : isOrigin
                ? Colors.pink[600]!
                : Colors.grey[200]!,
        'textColor': (isHighlighted || isOrigin)
            ? Colors.white
            : Colors.grey[700]!,
      });
    }
  }

  print('  Prepared ${gridCells.length} grid cells');

  // ============================================================
  // SECTION 4: 1D vs 2D Indexing Comparison
  // ============================================================
  print('=== Section 4: 1D vs 2D ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Index Type',
      'oneD': 'Single int (index: 5)',
      'twoD': 'ChildVicinity(xIndex: 2, yIndex: 1)',
    },
    {
      'aspect': 'Widget',
      'oneD': 'ListView, GridView',
      'twoD': 'TwoDimensionalScrollView',
    },
    {
      'aspect': 'Delegate',
      'oneD': 'SliverChildDelegate',
      'twoD': 'TwoDimensionalChildDelegate',
    },
    {
      'aspect': 'Builder Signature',
      'oneD': '(context, index) → Widget',
      'twoD': '(context, vicinity) → Widget',
    },
    {
      'aspect': 'Scroll Direction',
      'oneD': 'One axis (vertical or horizontal)',
      'twoD': 'Both axes simultaneously',
    },
    {
      'aspect': 'Layout Example',
      'oneD': 'Chat messages, todo list',
      'twoD': 'Spreadsheet, game board',
    },
    {
      'aspect': 'Boundary',
      'oneD': 'childCount: 100',
      'twoD': 'maxXIndex: 9, maxYIndex: 49',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 5: Delegate Patterns
  // ============================================================
  print('=== Section 5: Delegates ===');

  final delegates = <Map<String, dynamic>>[
    {
      'name': 'TwoDimensionalChildBuilderDelegate',
      'icon': Icons.construction,
      'color': Colors.red[700]!,
      'description': 'Lazy builder delegate — creates children on '
          'demand as they scroll into view. The builder receives a '
          'ChildVicinity and returns a Widget. Set maxXIndex and '
          'maxYIndex to define grid boundaries. Ideal for large or '
          'infinite grids.',
      'code': 'TwoDimensionalChildBuilderDelegate(\n'
          '  maxXIndex: 9,\n'
          '  maxYIndex: 99,\n'
          '  builder: (context, vicinity) {\n'
          '    return Cell(\n'
          '      col: vicinity.xIndex,\n'
          '      row: vicinity.yIndex,\n'
          '    );\n'
          '  },\n'
          ')',
    },
    {
      'name': 'TwoDimensionalChildListDelegate',
      'icon': Icons.list,
      'color': Colors.pink[700]!,
      'description': 'Explicit list delegate — you provide a 2D list '
          'of widgets (List<List<Widget>>). The outer list represents '
          'rows, the inner list represents columns. The delegate maps '
          'ChildVicinity coordinates to list indices automatically.',
      'code': 'TwoDimensionalChildListDelegate(\n'
          '  children: [\n'
          '    [Cell(0,0), Cell(1,0), Cell(2,0)],\n'
          '    [Cell(0,1), Cell(1,1), Cell(2,1)],\n'
          '    [Cell(0,2), Cell(1,2), Cell(2,2)],\n'
          '  ],\n'
          ')',
    },
  ];

  print('  Prepared ${delegates.length} delegate patterns');

  // ============================================================
  // SECTION 6: Sort Order Visualization
  // ============================================================
  print('=== Section 6: Sort Order ===');

  // Show row-major ordering for a 3x4 grid
  final sortedCells = <Map<String, dynamic>>[];
  var sortIndex = 0;
  for (var row = 0; row < 4; row++) {
    for (var col = 0; col < 3; col++) {
      sortedCells.add({
        'x': col,
        'y': row,
        'sortOrder': sortIndex,
        'color': Color.lerp(Colors.red[300], Colors.pink[700],
            sortIndex / 11.0)!,
      });
      sortIndex++;
    }
  }

  print('  Prepared ${sortedCells.length} sorted cells');

  // ============================================================
  // SECTION 7: Practical Layout Examples
  // ============================================================
  print('=== Section 7: Layouts ===');

  final layouts = <Map<String, dynamic>>[
    {
      'name': 'Spreadsheet',
      'icon': Icons.table_chart,
      'color': Colors.red[700]!,
      'description': 'Each cell at (xIndex, yIndex) maps to a '
          'spreadsheet cell. Column headers at yIndex=0, row headers '
          'at xIndex=0. Cell A1 is (1,1), B1 is (2,1), A2 is (1,2). '
          'The ChildVicinity drives both content and formatting.',
      'cells': [
        {'label': '', 'x': 0, 'y': 0, 'header': true},
        {'label': 'A', 'x': 1, 'y': 0, 'header': true},
        {'label': 'B', 'x': 2, 'y': 0, 'header': true},
        {'label': 'C', 'x': 3, 'y': 0, 'header': true},
        {'label': '1', 'x': 0, 'y': 1, 'header': true},
        {'label': '100', 'x': 1, 'y': 1, 'header': false},
        {'label': '200', 'x': 2, 'y': 1, 'header': false},
        {'label': '300', 'x': 3, 'y': 1, 'header': false},
        {'label': '2', 'x': 0, 'y': 2, 'header': true},
        {'label': '150', 'x': 1, 'y': 2, 'header': false},
        {'label': '250', 'x': 2, 'y': 2, 'header': false},
        {'label': '350', 'x': 3, 'y': 2, 'header': false},
      ],
    },
    {
      'name': 'Chess Board',
      'icon': Icons.apps,
      'color': Colors.pink[700]!,
      'description': 'An 8x8 grid where xIndex maps to file (a-h) and '
          'yIndex maps to rank (8-1). The ChildVicinity determines '
          'both the square color (alternating light/dark) and what '
          'piece to display. (x+y) % 2 gives the checkerboard pattern.',
      'cells': [
        {'label': '', 'x': 0, 'y': 0, 'header': false},
        {'label': '', 'x': 1, 'y': 0, 'header': false},
        {'label': '', 'x': 2, 'y': 0, 'header': false},
        {'label': '', 'x': 3, 'y': 0, 'header': false},
        {'label': '', 'x': 0, 'y': 1, 'header': false},
        {'label': '', 'x': 1, 'y': 1, 'header': false},
        {'label': '', 'x': 2, 'y': 1, 'header': false},
        {'label': '', 'x': 3, 'y': 1, 'header': false},
        {'label': '', 'x': 0, 'y': 2, 'header': false},
        {'label': '', 'x': 1, 'y': 2, 'header': false},
        {'label': '', 'x': 2, 'y': 2, 'header': false},
        {'label': '', 'x': 3, 'y': 2, 'header': false},
      ],
    },
    {
      'name': 'Calendar Month View',
      'icon': Icons.calendar_today,
      'color': Colors.red[600]!,
      'description': 'xIndex 0-6 for days of the week (Mon-Sun), '
          'yIndex 0-5 for week rows. The builder uses ChildVicinity '
          'to compute the actual date. Some cells at the start and '
          'end of the month may be empty (outside the month range).',
      'cells': [
        {'label': 'Mon', 'x': 0, 'y': 0, 'header': true},
        {'label': 'Tue', 'x': 1, 'y': 0, 'header': true},
        {'label': 'Wed', 'x': 2, 'y': 0, 'header': true},
        {'label': 'Thu', 'x': 3, 'y': 0, 'header': true},
        {'label': '', 'x': 0, 'y': 1, 'header': false},
        {'label': '1', 'x': 1, 'y': 1, 'header': false},
        {'label': '2', 'x': 2, 'y': 1, 'header': false},
        {'label': '3', 'x': 3, 'y': 1, 'header': false},
        {'label': '4', 'x': 0, 'y': 2, 'header': false},
        {'label': '5', 'x': 1, 'y': 2, 'header': false},
        {'label': '6', 'x': 2, 'y': 2, 'header': false},
        {'label': '7', 'x': 3, 'y': 2, 'header': false},
      ],
    },
    {
      'name': 'Image Tile Gallery',
      'icon': Icons.photo_library,
      'color': Colors.pink[600]!,
      'description': 'A Pinterest-style layout where xIndex is the '
          'column and yIndex is the row. The builder computes a flat '
          'index as (yIndex * columnCount + xIndex) to map into a '
          'linear list of images. Variable-height tiles per column '
          'create the staggered effect.',
      'cells': [
        {'label': 'Img 0', 'x': 0, 'y': 0, 'header': false},
        {'label': 'Img 1', 'x': 1, 'y': 0, 'header': false},
        {'label': 'Img 2', 'x': 2, 'y': 0, 'header': false},
        {'label': 'Img 3', 'x': 3, 'y': 0, 'header': false},
        {'label': 'Img 4', 'x': 0, 'y': 1, 'header': false},
        {'label': 'Img 5', 'x': 1, 'y': 1, 'header': false},
        {'label': 'Img 6', 'x': 2, 'y': 1, 'header': false},
        {'label': 'Img 7', 'x': 3, 'y': 1, 'header': false},
        {'label': 'Img 8', 'x': 0, 'y': 2, 'header': false},
        {'label': 'Img 9', 'x': 1, 'y': 2, 'header': false},
        {'label': 'Img 10', 'x': 2, 'y': 2, 'header': false},
        {'label': 'Img 11', 'x': 3, 'y': 2, 'header': false},
      ],
    },
  ];

  print('  Prepared ${layouts.length} layout examples');

  // ============================================================
  // SECTION 8: Coordinate Arithmetic
  // ============================================================
  print('=== Section 8: Coordinate Arithmetic ===');

  final arithmeticCards = <Map<String, dynamic>>[
    {
      'title': 'Flat Index Conversion',
      'icon': Icons.transform,
      'color': Colors.red[700]!,
      'formula': 'flatIndex = yIndex * columnCount + xIndex',
      'reverse': 'xIndex = flatIndex % columnCount\n'
          'yIndex = flatIndex ~/ columnCount',
      'use': 'Converting between 1D lists and 2D grid positions',
    },
    {
      'title': 'Neighbor Detection',
      'icon': Icons.people,
      'color': Colors.pink[700]!,
      'formula': 'up = (xIndex, yIndex - 1)\n'
          'down = (xIndex, yIndex + 1)\n'
          'left = (xIndex - 1, yIndex)\n'
          'right = (xIndex + 1, yIndex)',
      'reverse': 'Check boundaries: x >= 0, y >= 0,\n'
          'x <= maxXIndex, y <= maxYIndex',
      'use': 'Finding adjacent cells in grid navigation or games',
    },
    {
      'title': 'Diagonal Neighbors',
      'icon': Icons.open_in_full,
      'color': Colors.red[600]!,
      'formula': 'topLeft = (xIndex-1, yIndex-1)\n'
          'topRight = (xIndex+1, yIndex-1)\n'
          'botLeft = (xIndex-1, yIndex+1)\n'
          'botRight = (xIndex+1, yIndex+1)',
      'reverse': '8 neighbors total (4 cardinal + 4 diagonal)\n'
          'Apply boundary checks for all 8',
      'use': 'Game boards, cellular automata, image processing grids',
    },
    {
      'title': 'Region Check',
      'icon': Icons.crop,
      'color': Colors.pink[600]!,
      'formula': 'isInRegion = xIndex >= minX && xIndex <= maxX\n'
          '          && yIndex >= minY && yIndex <= maxY',
      'reverse': 'Useful for: selection ranges, visible region,\n'
          'frozen panes in spreadsheets',
      'use': 'Determining if a cell falls within a rectangular region',
    },
  ];

  print('  Prepared ${arithmeticCards.length} arithmetic cards');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'xIndex Is Column, yIndex Is Row',
      'body': 'Don\'t confuse the order. x is horizontal (column), '
          'y is vertical (row). ChildVicinity(xIndex: 5, yIndex: 2) '
          'means column 5, row 2. Think of it like mathematical '
          'coordinates (x, y), not array indices [row][col].',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Comparison Is Row-Major',
      'body': 'compareTo sorts by yIndex first. This means (0,1) > '
          '(2,0) because row 1 > row 0. This matches reading order '
          'but differs from how you might expect a coordinate sort. '
          'Be aware when using ChildVicinity in sorted collections.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use as Map Keys',
      'body': 'ChildVicinity has proper hashCode and equality. You '
          'can use it as a key in Map<ChildVicinity, CellData> to '
          'store cell-specific data. This is cleaner than nested '
          'maps like Map<int, Map<int, CellData>>.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'maxXIndex Is Inclusive',
      'body': 'In TwoDimensionalChildBuilderDelegate, maxXIndex and '
          'maxYIndex are inclusive bounds. maxXIndex: 9 means columns '
          '0-9 (10 columns). The builder will be called with '
          'xIndex values from 0 through maxXIndex inclusive.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Return Null for Out-of-Bounds',
      'body': 'The builder can return null for coordinates that '
          'should have no child. In a calendar, cells before day 1 '
          'and after the last day return null. The framework skips '
          'null cells in layout and painting.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Frozen Rows/Columns Pattern',
      'body': 'For spreadsheet-like frozen headers, check the '
          'ChildVicinity in your builder: if yIndex == 0, render a '
          'column header; if xIndex == 0, render a row header; '
          'otherwise render a data cell. Frozen panes are just '
          'special ChildVicinity ranges.',
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
      title: Text('ChildVicinity'),
      backgroundColor: Colors.red[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[700]!, Colors.pink[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.grid_on, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ChildVicinity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Immutable 2D coordinate class for identifying children '
                  'in TwoDimensionalScrollView. Holds xIndex (column) and '
                  'yIndex (row) to pinpoint any cell in a two-dimensional '
                  'scrollable grid.',
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
          _cvHead('1', 'What is ChildVicinity?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _cvHead('2', 'Properties & Construction'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _cvDot(p['type'] as String, p['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Coordinate Grid ──
          _cvHead('3', 'Visual Coordinate System'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              // Axis labels
              Row(children: [
                SizedBox(width: 30),
                ...List.generate(
                    gridCols,
                    (col) => Expanded(
                          child: Center(
                            child: Text('x=$col',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[700])),
                          ),
                        )),
              ]),
              SizedBox(height: 4),
              // Grid rows
              ...List.generate(
                  gridRows,
                  (row) => Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(children: [
                          SizedBox(
                            width: 30,
                            child: Text('y=$row',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[700])),
                          ),
                          ...List.generate(
                              gridCols,
                              (col) {
                                final cell = gridCells[row * gridCols + col];
                                return Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(1),
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: cell['color'] as Color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '($col,$row)',
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: cell['textColor'] as Color,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ]),
                      )),
              SizedBox(height: 8),
              Row(children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.pink[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 4),
                Text('Origin (0,0)', style: TextStyle(fontSize: 9)),
                SizedBox(width: 12),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 4),
                Text('Highlighted (2,3)', style: TextStyle(fontSize: 9)),
              ]),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 4: 1D vs 2D ──
          _cvHead('4', '1D vs 2D Indexing'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 70,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('1D (ListView)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('2D (ChildVicinity)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['oneD'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['twoD'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.red[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Delegates ──
          _cvHead('5', 'Delegate Patterns'),
          SizedBox(height: 12),
          ...delegates.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
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
                        Icon(d['icon'] as IconData,
                            color: d['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(d['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(d['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(d['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.red[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Sort Order ──
          _cvHead('6', 'compareTo Sort Order'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Text('Row-Major Ordering (yIndex first, then xIndex)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey[800])),
              SizedBox(height: 8),
              ...List.generate(
                  4,
                  (row) => Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Row(
                            children: List.generate(3, (col) {
                          final idx = row * 3 + col;
                          final cell = sortedCells[idx];
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 4),
                              decoration: BoxDecoration(
                                color: cell['color'] as Color,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(children: [
                                Text('#${cell['sortOrder']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                Text(
                                    '(${cell['x']},${cell['y']})',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 9)),
                              ]),
                            ),
                          );
                        })),
                      )),
              SizedBox(height: 6),
              Text(
                'Sorted: #0(0,0) → #1(1,0) → #2(2,0) → #3(0,1) → '
                '#4(1,1) → ... → #11(2,3)',
                style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic),
              ),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Practical Layouts ──
          _cvHead('7', 'Practical Layout Examples'),
          SizedBox(height: 12),
          ...layouts.map((lay) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: lay['color'] as Color, width: 4),
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
                        Icon(lay['icon'] as IconData,
                            color: lay['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(lay['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(lay['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      // Mini grid for this layout
                      ...List.generate(
                          3,
                          (row) => Row(
                                children: List.generate(4, (col) {
                                  final cellIndex = row * 4 + col;
                                  final cells =
                                      lay['cells'] as List<Map<String, dynamic>>;
                                  if (cellIndex >= cells.length) {
                                    return Expanded(child: SizedBox());
                                  }
                                  final cell = cells[cellIndex];
                                  final isHeader =
                                      cell['header'] as bool;
                                  final isChess =
                                      lay['name'] == 'Chess Board';
                                  Color cellColor;
                                  if (isChess) {
                                    cellColor = ((cell['x'] as int) +
                                                    (cell['y'] as int)) %
                                                2 ==
                                            0
                                        ? Colors.brown[200]!
                                        : Colors.brown[600]!;
                                  } else {
                                    cellColor = isHeader
                                        ? (lay['color'] as Color)
                                            .withOpacity(0.15)
                                        : Colors.grey[100]!;
                                  }
                                  return Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(1),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6),
                                      decoration: BoxDecoration(
                                        color: cellColor,
                                        borderRadius:
                                            BorderRadius.circular(3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cell['label'] as String,
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: isHeader
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: isChess &&
                                                    !isHeader &&
                                                    ((cell['x'] as int) +
                                                                (cell['y']
                                                                    as int)) %
                                                            2 !=
                                                        0
                                                ? Colors.white
                                                : Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Arithmetic ──
          _cvHead('8', 'Coordinate Arithmetic'),
          SizedBox(height: 12),
          ...arithmeticCards.map((ac) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ac['color'] as Color, width: 4),
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
                        Icon(ac['icon'] as IconData,
                            color: ac['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(ac['title'] as String,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ac['formula'] as String,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: Colors.red[200],
                                    height: 1.4)),
                            SizedBox(height: 4),
                            Text(ac['reverse'] as String,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10,
                                    color: Colors.pink[200],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(ac['use'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _cvHead('9', 'Tips & Gotchas'),
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
          Center(
            child: Text(
              'End of ChildVicinity Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _cvHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[700],
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
// Helper: Dot badge
// ──────────────────────────────────────────────────────────
Widget _cvDot(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 140),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
