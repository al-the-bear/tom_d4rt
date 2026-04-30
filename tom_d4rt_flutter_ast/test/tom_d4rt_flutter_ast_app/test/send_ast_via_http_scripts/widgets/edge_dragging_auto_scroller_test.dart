// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — EdgeDraggingAutoScroller
// Demonstrates EdgeDraggingAutoScroller — a utility that triggers
// automatic scrolling when a drag gesture enters the edges of a
// scrollable area. Used by ReorderableListView, text selection,
// and custom drag-and-drop implementations.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EdgeDraggingAutoScroller Deep Demo executing');

  // ============================================================
  // SECTION 1: What is EdgeDraggingAutoScroller?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_vert,
      'title': 'Auto-Scroll on Drag Near Edges',
      'body': 'EdgeDraggingAutoScroller watches for drag pointer '
          'positions near the edges of a scrollable widget. When the '
          'pointer enters an edge zone, the scrollable automatically '
          'scrolls in that direction. The closer to the edge, the '
          'faster it scrolls.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Essential for Drag-and-Drop',
      'body': 'When dragging an item in a long list, users need the '
          'list to scroll so they can reach items beyond the visible '
          'area. EdgeDraggingAutoScroller provides this behavior. '
          'Flutter uses it internally in ReorderableListView and '
          'text selection.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Variable Velocity',
      'body': 'The scroll speed is not constant — it scales with how '
          'close the pointer is to the edge. Barely entering the edge '
          'zone scrolls slowly; dragging right to the boundary scrolls '
          'fastest. This gives users fine-grained control.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.widgets,
      'title': 'Works with Any Scrollable',
      'body': 'Can be attached to ListView, GridView, CustomScrollView, '
          'SingleChildScrollView, or any other Scrollable widget. The '
          'auto-scroller only needs a reference to the ScrollableState '
          'to drive scrolling.',
      'accent': Colors.cyan[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'scrollable',
      'type': 'ScrollableState',
      'icon': Icons.view_list,
      'color': Colors.teal[700]!,
      'description': 'The ScrollableState to auto-scroll. Obtained via '
          'Scrollable.of(context) or a GlobalKey<ScrollableState>. The '
          'auto-scroller calls scrollable.position.moveTo() to animate '
          'scrolling as the pointer approaches edges.',
    },
    {
      'name': 'velocityScalar',
      'type': 'double',
      'icon': Icons.speed,
      'color': Colors.cyan[700]!,
      'description': 'A multiplier for scroll speed. Default is 10.0. '
          'Higher values make edge scrolling faster. The actual pixels '
          'per second = velocityScalar * overscrollFraction. Typical '
          'range: 5.0 (gentle) to 20.0 (fast).',
    },
    {
      'name': 'onScrollViewScrolled',
      'type': 'VoidCallback?',
      'icon': Icons.notifications_active,
      'color': Colors.teal[600]!,
      'description': 'A callback invoked every time the auto-scroller '
          'moves the scroll position. Useful for updating drag '
          'feedback positions during auto-scroll, since the items '
          'under the pointer change as the view scrolls.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: Edge Detection Zones
  // ============================================================
  print('=== Section 3: Edge Detection ===');

  final edgeZones = <Map<String, dynamic>>[
    {
      'zone': 'Top Edge Zone',
      'icon': Icons.vertical_align_top,
      'color': Colors.teal[700]!,
      'description': 'A region at the top of the scrollable viewport. '
          'When the drag pointer enters this zone, the auto-scroller '
          'scrolls upward. The zone width is typically determined by '
          'the mediaQueryPadding or a fraction of the viewport.',
      'scrollDir': 'Scrolls content DOWN (reveals items above)',
    },
    {
      'zone': 'Bottom Edge Zone',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.cyan[700]!,
      'description': 'A region at the bottom of the scrollable viewport. '
          'Pointer in this zone triggers downward auto-scrolling. '
          'Combined with the top zone, provides full vertical '
          'auto-scroll capability.',
      'scrollDir': 'Scrolls content UP (reveals items below)',
    },
    {
      'zone': 'Left Edge Zone',
      'icon': Icons.chevron_left,
      'color': Colors.teal[600]!,
      'description': 'For horizontal scrollables, a region at the left '
          'edge. Entering triggers leftward auto-scrolling. Only active '
          'when the scrollable has a horizontal scroll axis.',
      'scrollDir': 'Scrolls content RIGHT (reveals items to the left)',
    },
    {
      'zone': 'Right Edge Zone',
      'icon': Icons.chevron_right,
      'color': Colors.cyan[600]!,
      'description': 'For horizontal scrollables, a region at the right '
          'edge. Entering triggers rightward auto-scrolling. The edge '
          'detection zone size is the same as the other edges.',
      'scrollDir': 'Scrolls content LEFT (reveals items to the right)',
    },
  ];

  print('  Prepared ${edgeZones.length} edge zones');

  // ============================================================
  // SECTION 4: Velocity Curve
  // ============================================================
  print('=== Section 4: Velocity Curve ===');

  final velocitySteps = <Map<String, dynamic>>[
    {'distance': 'Far from edge', 'fraction': 0.0, 'speed': 'No scroll'},
    {'distance': 'Entering zone', 'fraction': 0.1, 'speed': 'Very slow'},
    {'distance': '25% into zone', 'fraction': 0.25, 'speed': 'Slow'},
    {'distance': '50% into zone', 'fraction': 0.5, 'speed': 'Medium'},
    {'distance': '75% into zone', 'fraction': 0.75, 'speed': 'Fast'},
    {'distance': 'At edge', 'fraction': 1.0, 'speed': 'Maximum'},
  ];

  print('  Prepared ${velocitySteps.length} velocity steps');

  // ============================================================
  // SECTION 5: Common Use Cases
  // ============================================================
  print('=== Section 5: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'name': 'ReorderableListView',
      'icon': Icons.reorder,
      'color': Colors.teal[700]!,
      'description': 'Flutter\'s ReorderableListView uses '
          'EdgeDraggingAutoScroller internally. When you long-press '
          'an item and drag it toward the top or bottom edge, the '
          'list auto-scrolls so you can reorder items beyond the '
          'visible viewport.',
      'detail': 'Internal usage — no setup needed. The auto-scroller '
          'is created in ReorderableListView\'s State and connected '
          'to the list\'s ScrollController.',
    },
    {
      'name': 'Text Selection',
      'icon': Icons.select_all,
      'color': Colors.cyan[700]!,
      'description': 'When selecting text in a scrollable text field '
          '(like a large TextFormField), dragging the selection handle '
          'to the edge triggers auto-scrolling. The text field scrolls '
          'to reveal more text as you extend the selection.',
      'detail': 'Used by EditableText and RenderEditable during '
          'selection drag gestures. Connected to the text scrollable.',
    },
    {
      'name': 'Custom Drag-and-Drop',
      'icon': Icons.drag_indicator,
      'color': Colors.teal[600]!,
      'description': 'Building a custom drag-and-drop interface? '
          'Create an EdgeDraggingAutoScroller and call startAutoScrollIfNecessary() '
          'with the drag pointer position. The scroller handles the rest — '
          'scrolling when near edges, stopping when not.',
      'detail': 'Instantiate in initState(), dispose in dispose(). '
          'Call startAutoScrollIfNecessary(event) on pointer move events.',
    },
    {
      'name': 'Canvas / Drawing Apps',
      'icon': Icons.draw,
      'color': Colors.cyan[600]!,
      'description': 'Drawing or painting on a large scrollable canvas. '
          'When the user draws near the viewport edge while in draw '
          'mode, auto-scroll to reveal more canvas area without '
          'lifting the pen.',
      'detail': 'Attach to the canvas ScrollView. Trigger auto-scroll '
          'on pointer move during active drawing gestures only.',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Setup',
      'color': Colors.teal[700]!,
      'code': 'class _MyState extends State<MyWidget> {\n'
          '  late EdgeDraggingAutoScroller _autoScroller;\n'
          '  final _scrollKey =\n'
          '      GlobalKey<ScrollableState>();\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    // Create after first frame when\n'
          '    // scrollable is available\n'
          '    WidgetsBinding.instance\n'
          '        .addPostFrameCallback((_) {\n'
          '      _autoScroller = EdgeDraggingAutoScroller(\n'
          '        _scrollKey.currentState!,\n'
          '        velocityScalar: 10.0,\n'
          '      );\n'
          '    });\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Triggering on Drag',
      'color': Colors.cyan[700]!,
      'code': '// In your drag handler:\n'
          'void onDragUpdate(DragUpdateDetails details) {\n'
          '  // Update drag position\n'
          '  setState(() {\n'
          '    _dragPosition = details.globalPosition;\n'
          '  });\n'
          '\n'
          '  // Trigger auto-scroll check\n'
          '  _autoScroller\n'
          '      .startAutoScrollIfNecessary(\n'
          '    Rect.fromCenter(\n'
          '      center: details.globalPosition,\n'
          '      width: 20,\n'
          '      height: 20,\n'
          '    ),\n'
          '  );\n'
          '}\n'
          '\n'
          'void onDragEnd(DragEndDetails details) {\n'
          '  _autoScroller.stopAutoScroll();\n'
          '}',
    },
    {
      'title': 'With Scroll Callback',
      'color': Colors.teal[600]!,
      'code': '// Track when auto-scroll updates position\n'
          '_autoScroller = EdgeDraggingAutoScroller(\n'
          '  scrollableState,\n'
          '  velocityScalar: 15.0,\n'
          '  onScrollViewScrolled: () {\n'
          '    // Called on each auto-scroll frame\n'
          '    // Update feedback widget position\n'
          '    _updateDragFeedback();\n'
          '  },\n'
          ');\n'
          '\n'
          'void _updateDragFeedback() {\n'
          '  // Recalculate which item is under\n'
          '  // the drag pointer since the view\n'
          '  // has scrolled\n'
          '  final hitItem = _findItemAt(\n'
          '    _dragPosition,\n'
          '  );\n'
          '  setState(() => _hoverItem = hitItem);\n'
          '}',
    },
    {
      'title': 'Custom Edge Threshold',
      'color': Colors.cyan[600]!,
      'code': '// Control the edge detection zone size\n'
          '// by providing a custom Rect that represents\n'
          '// the "hot zone" around the pointer.\n'
          '\n'
          '// Larger rect = triggers auto-scroll earlier\n'
          '_autoScroller.startAutoScrollIfNecessary(\n'
          '  Rect.fromCenter(\n'
          '    center: pointerPosition,\n'
          '    width: 80,  // Wide hot zone\n'
          '    height: 80, // Tall hot zone\n'
          '  ),\n'
          ');\n'
          '\n'
          '// Smaller rect = must be very close to edge\n'
          '_autoScroller.startAutoScrollIfNecessary(\n'
          '  Rect.fromCenter(\n'
          '    center: pointerPosition,\n'
          '    width: 1,   // Tight hot zone\n'
          '    height: 1,\n'
          '  ),\n'
          ');',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Scroll Speed Scaling
  // ============================================================
  print('=== Section 7: Speed Scaling ===');

  final scalingExamples = <Map<String, dynamic>>[
    {
      'velocityScalar': 5.0,
      'label': 'Gentle',
      'color': Colors.teal[300]!,
      'description': 'Slow auto-scroll. Good for precision work like '
          'text selection where overshooting is undesirable.',
    },
    {
      'velocityScalar': 10.0,
      'label': 'Default',
      'color': Colors.teal[500]!,
      'description': 'The default speed. Balanced for general use — '
          'list reordering, moderate-length lists.',
    },
    {
      'velocityScalar': 15.0,
      'label': 'Faster',
      'color': Colors.teal[700]!,
      'description': 'Quicker scrolling for long lists. Users can '
          'traverse more content per second.',
    },
    {
      'velocityScalar': 20.0,
      'label': 'Maximum',
      'color': Colors.teal[900]!,
      'description': 'Very fast scrolling. Suitable for very long '
          'lists (hundreds of items) where speed matters more than '
          'precision.',
    },
  ];

  print('  Prepared ${scalingExamples.length} scaling examples');

  // ============================================================
  // SECTION 8: Comparison
  // ============================================================
  print('=== Section 8: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Type',
      'edge': 'Utility class',
      'scrollPhysics': 'Physics configuration',
      'controller': 'Programmatic scrolling',
    },
    {
      'aspect': 'Trigger',
      'edge': 'Pointer near viewport edge',
      'scrollPhysics': 'User scroll gesture',
      'controller': 'Code calls animateTo/jumpTo',
    },
    {
      'aspect': 'Speed',
      'edge': 'Variable (distance to edge)',
      'scrollPhysics': 'User velocity + physics sim',
      'controller': 'Duration-based animation',
    },
    {
      'aspect': 'Use Case',
      'edge': 'Drag-and-drop, selection',
      'scrollPhysics': 'Normal scrolling behavior',
      'controller': 'Programmatic navigation',
    },
    {
      'aspect': 'Built-in',
      'edge': 'In ReorderableListView',
      'scrollPhysics': 'In all scrollables',
      'controller': 'User creates controller',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Call stopAutoScroll on Drag End',
      'body': 'Always call stopAutoScroll() when the drag gesture ends. '
          'Otherwise, auto-scrolling may continue after the user lifts '
          'their finger. This is the most common mistake when using '
          'EdgeDraggingAutoScroller manually.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'ScrollableState Must Be Available',
      'body': 'The EdgeDraggingAutoScroller requires a mounted '
          'ScrollableState. Create it in initState\'s post-frame '
          'callback or in didChangeDependencies, not in the '
          'constructor. The scrollable must be in the widget tree.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Rect Size Matters',
      'body': 'The Rect you pass to startAutoScrollIfNecessary defines '
          'the drag "hot zone." A larger rect means auto-scrolling '
          'triggers earlier (when the pointer is farther from the edge). '
          'A 1x1 rect requires the pointer to be exactly at the edge.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Performance: Frame Budget',
      'body': 'Auto-scrolling runs on every animation frame (60/120 fps). '
          'Keep onScrollViewScrolled lightweight — avoid expensive '
          'rebuilds in the callback. Use it to update positions, not '
          'to trigger complex setState calls.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine with Listener for Global Position',
      'body': 'Use a Listener widget to get the global pointer position '
          'during drag events. Pass that position to '
          'startAutoScrollIfNecessary(). The Listener captures pointer '
          'events even when the pointer is over different children.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Works with NestedScrollView',
      'body': 'EdgeDraggingAutoScroller works with NestedScrollView, '
          'but attach it to the correct inner or outer scrollable. '
          'For the outer scroll view, use the outer ScrollableState. '
          'For a specific sliver, use that sliver\'s scrollable.',
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
      title: Text('EdgeDraggingAutoScroller'),
      backgroundColor: Colors.teal[700],
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
                colors: [Colors.teal[700]!, Colors.cyan[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.swap_vert, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'EdgeDraggingAutoScroller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Automatically scrolls a scrollable widget when a drag '
                  'pointer enters the edge zones. Speed scales with proximity '
                  'to the edge. Used by ReorderableListView, text selection, '
                  'and custom drag-and-drop systems.',
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
          _edHead('1', 'What is EdgeDraggingAutoScroller?'),
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
          _edHead('2', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
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
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _edBadge(p['type'] as String, p['color'] as Color),
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

          // ── Section 3: Edge Detection Zones ──
          _edHead('3', 'Edge Detection Zones'),
          SizedBox(height: 12),
          // Visual viewport diagram
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
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
              Text('Viewport Edge Zones',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.grey[800])),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  // Top edge
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: Text('TOP EDGE ZONE ↑ scroll up',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800])),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[50],
                      child: Row(children: [
                        Container(
                          width: 36,
                          color: Colors.cyan[50],
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Center(
                              child: Text('LEFT',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan[700])),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.drag_indicator,
                                    color: Colors.grey[400], size: 30),
                                SizedBox(height: 4),
                                Text('Content Area',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 11)),
                                Text('(no auto-scroll)',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 9)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          color: Colors.cyan[50],
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Center(
                              child: Text('RIGHT',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan[700])),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: Center(
                      child: Text('BOTTOM EDGE ZONE ↓ scroll down',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800])),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
          SizedBox(height: 12),
          ...edgeZones.map((ez) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ez['color'] as Color, width: 4),
                    ),
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
                        Icon(ez['icon'] as IconData,
                            color: ez['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Text(ez['zone'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ]),
                      SizedBox(height: 4),
                      Text(ez['description'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                              (ez['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(ez['scrollDir'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: ez['color'] as Color)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Velocity Curve ──
          _edHead('4', 'Velocity Curve'),
          SizedBox(height: 8),
          Text(
            'Scroll speed increases as the pointer moves closer to the '
            'viewport edge. The fraction represents how deep into the '
            'edge zone the pointer has entered.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
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
            child: Column(
              children: velocitySteps.map((vs) {
                final fraction = vs['fraction'] as double;
                return Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(children: [
                    SizedBox(
                        width: 80,
                        child: Text(vs['distance'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[700]))),
                    SizedBox(width: 6),
                    Expanded(
                      child: Stack(children: [
                        Container(
                          height: 22,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: fraction > 0 ? fraction : 0.02,
                          child: Container(
                            height: 22,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.teal[300]!,
                                  Colors.teal[700]!,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                        width: 60,
                        child: Text(vs['speed'] as String,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700]))),
                  ]),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 5: Use Cases ──
          _edHead('5', 'Common Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
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
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(uc['detail'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.teal[800])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _edHead('6', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Speed Scaling ──
          _edHead('7', 'Scroll Speed Scaling'),
          SizedBox(height: 12),
          ...scalingExamples.map((se) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: se['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(children: [
                    Container(
                      width: 50,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (se['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('${se['velocityScalar']}',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: se['color'] as Color)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(se['label'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          SizedBox(height: 2),
                          Text(se['description'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  height: 1.3)),
                        ],
                      ),
                    ),
                  ]),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Comparison ──
          _edHead('8', 'Auto-Scroll Approaches Compared'),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 55,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('EdgeDragging...',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('ScrollPhysics',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('ScrollController',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 55,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['edge'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.teal[700]))),
                      Expanded(
                          child: Text(r['scrollPhysics'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['controller'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[700]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _edHead('9', 'Tips & Gotchas'),
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
              'End of EdgeDraggingAutoScroller Deep Demo',
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
Widget _edHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.teal[700],
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
// Helper: Badge for types
// ──────────────────────────────────────────────────────────
Widget _edBadge(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 140),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
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
