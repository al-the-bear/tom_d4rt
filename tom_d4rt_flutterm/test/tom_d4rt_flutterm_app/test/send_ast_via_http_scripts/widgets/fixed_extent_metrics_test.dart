// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FixedExtentMetrics
// Demonstrates FixedExtentMetrics — a ScrollMetrics subclass that adds
// itemIndex tracking for fixed-extent scroll views. Covers purpose,
// class hierarchy, properties, relationship with ListWheelScrollView,
// scroll physics integration, real-world patterns, and comparison with
// regular ScrollMetrics.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FixedExtentMetrics Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FixedExtentMetrics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'title': 'Scroll Metrics + Item Index',
      'body': 'FixedExtentMetrics extends FixedScrollMetrics to add '
          'an itemIndex property. It tells you which item is '
          'currently centered in a FixedExtentScrollView — '
          'typically a ListWheelScrollView or CupertinoPicker. '
          'Regular ScrollMetrics only know pixel offsets; '
          'FixedExtentMetrics also know the snapped item index.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.view_carousel,
      'title': 'Used by ListWheelScrollView',
      'body': 'When a ListWheelScrollView reports its scroll '
          'position, it sends FixedExtentMetrics as part of '
          'ScrollNotification. This lets listeners know both the '
          'pixel offset AND which item is selected, without '
          'having to calculate index from pixels manually.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.pin_drop,
      'title': 'Snap-to-Item Awareness',
      'body': 'Because items have a fixed extent (height), the '
          'scroll knows exactly which item index the viewport is '
          '"snapped" to. Even during scrolling, itemIndex reports '
          'the nearest whole item. This is critical for wheel-style '
          'pickers where selection must be discrete.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.developer_board,
      'title': 'Immutable Snapshot',
      'body': 'Like all ScrollMetrics, a FixedExtentMetrics '
          'instance is an immutable snapshot of the scroll state '
          'at a point in time. You receive it in notifications and '
          'can safely store or compare it — it won\'t change. '
          'The next scroll event produces a new snapshot.',
      'accent': Colors.orange[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'name': 'ScrollMetrics (mixin)',
      'depth': 0,
      'color': Colors.grey[600]!,
      'icon': Icons.waves,
      'isSubject': false,
      'description': 'Base mixin defining minScrollExtent, '
          'maxScrollExtent, pixels, viewportDimension, etc. '
          'All scroll metrics implement this.',
    },
    {
      'name': 'FixedScrollMetrics',
      'depth': 1,
      'color': Colors.orange[600]!,
      'icon': Icons.photo_size_select_small,
      'isSubject': false,
      'description': 'Immutable implementation of ScrollMetrics. '
          'Holds a frozen snapshot of scroll state. Used as a '
          'base for FixedExtentMetrics and in '
          'ScrollNotification.metrics.',
    },
    {
      'name': 'FixedExtentMetrics',
      'depth': 2,
      'color': Colors.deepOrange[700]!,
      'icon': Icons.straighten,
      'isSubject': true,
      'description': 'Extends FixedScrollMetrics to add itemIndex '
          '— the index of the item currently centered in the '
          'viewport. THIS IS THE DEMO SUBJECT.',
    },
    {
      'name': 'ScrollPosition',
      'depth': 1,
      'color': Colors.grey[500]!,
      'icon': Icons.gps_fixed,
      'isSubject': false,
      'description': 'Mutable scroll position (implements '
          'ScrollMetrics). FixedExtentScrollController.selectedItem '
          'is derived from the position, not from metrics directly.',
    },
    {
      'name': 'FixedExtentScrollController',
      'depth': 0,
      'color': Colors.orange[700]!,
      'icon': Icons.tune,
      'isSubject': false,
      'description': 'Controller for fixed-extent scroll views. '
          'Has initialItem, selectedItem, animateToItem(), '
          'jumpToItem(). Creates FixedExtentMetrics internally.',
    },
  ];

  print('  Prepared ${hierarchy.length} hierarchy entries');

  // ============================================================
  // SECTION 3: FixedExtentMetrics Properties
  // ============================================================
  print('=== Section 3: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'itemIndex',
      'type': 'int',
      'icon': Icons.tag,
      'color': Colors.deepOrange[700]!,
      'description': 'The index of the item currently closest to the '
          'center of the viewport. This is the primary addition '
          'that FixedExtentMetrics provides over FixedScrollMetrics. '
          'Calculated as (pixels / itemExtent).round().',
      'unique': true,
    },
    {
      'name': 'pixels',
      'type': 'double',
      'icon': Icons.swap_vert,
      'color': Colors.orange[600]!,
      'description': 'The current scroll offset in pixels. Inherited '
          'from ScrollMetrics. In a ListWheelScrollView, '
          'pixels = itemIndex * itemExtent when snapped. During '
          'scrolling it can be anywhere between items.',
      'unique': false,
    },
    {
      'name': 'minScrollExtent',
      'type': 'double',
      'icon': Icons.vertical_align_top,
      'color': Colors.orange[500]!,
      'description': 'The minimum scroll offset (typically 0.0). '
          'Inherited from ScrollMetrics. Going below this means '
          'overscroll at the top of the list.',
      'unique': false,
    },
    {
      'name': 'maxScrollExtent',
      'type': 'double',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.orange[500]!,
      'description': 'Maximum scroll offset: (itemCount - 1) * '
          'itemExtent. Inherited from ScrollMetrics. Going above '
          'this means overscroll at the bottom.',
      'unique': false,
    },
    {
      'name': 'viewportDimension',
      'type': 'double',
      'icon': Icons.aspect_ratio,
      'color': Colors.deepOrange[500]!,
      'description': 'The visible height of the scroll viewport. '
          'Inherited from ScrollMetrics. A taller viewport shows '
          'more items above and below the selected one.',
      'unique': false,
    },
    {
      'name': 'axisDirection',
      'type': 'AxisDirection',
      'icon': Icons.compass_calibration,
      'color': Colors.orange[600]!,
      'description': 'Scroll direction axis. Typically '
          'AxisDirection.down for vertical wheel pickers. '
          'Inherited from ScrollMetrics.',
      'unique': false,
    },
    {
      'name': 'devicePixelRatio',
      'type': 'double',
      'icon': Icons.hd,
      'color': Colors.orange[500]!,
      'description': 'The number of logical pixels per physical '
          'pixel. Inherited from ScrollMetrics. Used for precise '
          'rendering calculations.',
      'unique': false,
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 4: How itemIndex Is Calculated
  // ============================================================
  print('=== Section 4: itemIndex Calculation ===');

  final itemExtent = 50.0;
  final exampleOffsets = <double>[0, 25, 50, 75, 100, 125, 149, 150, 200];
  final indexCalculations = <Map<String, dynamic>>[];

  for (final offset in exampleOffsets) {
    final rawIndex = offset / itemExtent;
    final roundedIndex = rawIndex.round();
    indexCalculations.add({
      'offset': offset,
      'rawIndex': rawIndex,
      'roundedIndex': roundedIndex,
      'isSnapped': offset % itemExtent == 0,
    });
    print('  offset=$offset → raw=${rawIndex.toStringAsFixed(2)} '
        '→ index=$roundedIndex');
  }

  // ============================================================
  // SECTION 5: Scroll Notification Flow
  // ============================================================
  print('=== Section 5: Notification Flow ===');

  final notifFlow = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'User scrolls',
      'icon': Icons.touch_app,
      'color': Colors.deepOrange[600]!,
      'detail': 'User flicks or drags the ListWheelScrollView. '
          'The gesture is received by the scroll physics.',
    },
    {
      'step': 2,
      'label': 'Position updates',
      'icon': Icons.gps_fixed,
      'color': Colors.orange[600]!,
      'detail': 'The underlying _FixedExtentScrollPosition updates '
          'its pixels value based on the gesture delta.',
    },
    {
      'step': 3,
      'label': 'Metrics created',
      'icon': Icons.straighten,
      'color': Colors.deepOrange[700]!,
      'detail': 'The position creates a FixedExtentMetrics snapshot '
          'with the current itemIndex calculated from pixels / '
          'itemExtent. This is the key step.',
    },
    {
      'step': 4,
      'label': 'Notification sent',
      'icon': Icons.notifications_active,
      'color': Colors.orange[700]!,
      'detail': 'A ScrollNotification (UserScrollNotification, '
          'ScrollUpdateNotification, etc.) is dispatched up the '
          'widget tree with the FixedExtentMetrics attached.',
    },
    {
      'step': 5,
      'label': 'Listener receives',
      'icon': Icons.hearing,
      'color': Colors.deepOrange[500]!,
      'detail': 'NotificationListener<ScrollNotification> catches '
          'it. Cast notification.metrics to FixedExtentMetrics '
          'to read the itemIndex.',
    },
    {
      'step': 6,
      'label': 'Snap settles',
      'icon': Icons.check_circle,
      'color': Colors.orange[500]!,
      'detail': 'FixedExtentScrollPhysics makes the scroll snap to '
          'the nearest item. Final notification has '
          'itemIndex == selectedItem on the controller.',
    },
  ];

  print('  Prepared ${notifFlow.length} flow steps');

  // ============================================================
  // SECTION 6: Comparison — FixedExtentMetrics vs ScrollMetrics
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'aspect': 'Class',
      'fixed': 'FixedExtentMetrics',
      'regular': 'FixedScrollMetrics',
    },
    {
      'aspect': 'itemIndex property',
      'fixed': 'Yes ✓',
      'regular': 'No ✗',
    },
    {
      'aspect': 'Used by',
      'fixed': 'ListWheelScrollView',
      'regular': 'ListView, GridView, etc.',
    },
    {
      'aspect': 'Snap behavior',
      'fixed': 'Snaps to items',
      'regular': 'Free-scroll (usually)',
    },
    {
      'aspect': 'Item extent',
      'fixed': 'Fixed (all same height)',
      'regular': 'Variable (any height)',
    },
    {
      'aspect': 'Selection model',
      'fixed': 'Discrete (one item)',
      'regular': 'Continuous (pixel offset)',
    },
    {
      'aspect': 'Typical use case',
      'fixed': 'Pickers, wheels, slots',
      'regular': 'Content lists, grids',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 7: Using FixedExtentMetrics in Practice
  // ============================================================
  print('=== Section 7: Practical Usage ===');

  final usagePatterns = <Map<String, dynamic>>[
    {
      'name': 'Reading itemIndex from Notification',
      'icon': Icons.notifications,
      'color': Colors.deepOrange[700]!,
      'description': 'In a NotificationListener<ScrollNotification>, '
          'check if notification.metrics is FixedExtentMetrics. '
          'If so, cast it and read .itemIndex to know what item '
          'is selected without maintaining separate state.',
      'code': 'final metrics = notification.metrics;\n'
          'if (metrics is FixedExtentMetrics) {\n'
          '  final index = metrics.itemIndex;\n'
          '}',
    },
    {
      'name': 'CupertinoPicker Integration',
      'icon': Icons.av_timer,
      'color': Colors.orange[600]!,
      'description': 'CupertinoPicker wraps ListWheelScrollView '
          'internally. Its onSelectedItemChanged callback gives you '
          'the index directly, but if you use NotificationListener '
          'instead, you receive FixedExtentMetrics.',
      'code': 'CupertinoPicker(\n'
          '  itemExtent: 40,\n'
          '  onSelectedItemChanged: (index) { },\n'
          '  children: items,\n'
          ')',
    },
    {
      'name': 'Custom Wheel with Visual Feedback',
      'icon': Icons.tune,
      'color': Colors.deepOrange[600]!,
      'description': 'Build a custom ListWheelScrollView that '
          'highlights the selected item differently. Use '
          'NotificationListener to get FixedExtentMetrics.itemIndex '
          'and rebuild decorations around the selected child.',
      'code': 'ListWheelScrollView.useDelegate(\n'
          '  itemExtent: 50,\n'
          '  controller: fixedExtentController,\n'
          '  childDelegate: delegate,\n'
          ')',
    },
    {
      'name': 'Multi-Wheel Picker (Date/Time)',
      'icon': Icons.calendar_today,
      'color': Colors.orange[700]!,
      'description': 'Date/time pickers use multiple ListWheelScrollViews '
          'side by side — each emitting FixedExtentMetrics. '
          'Coordinating them: when hours wheel changes, validate '
          'and potentially adjust minutes wheel.',
      'code': 'Row(children: [\n'
          '  hourWheel, // emits FixedExtentMetrics\n'
          '  minuteWheel, // emits FixedExtentMetrics\n'
          '])',
    },
  ];

  print('  Prepared ${usagePatterns.length} usage patterns');

  // ============================================================
  // SECTION 8: Real-World Example Scenarios
  // ============================================================
  print('=== Section 8: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'iOS-Style Picker',
      'icon': Icons.phone_iphone,
      'color': Colors.deepOrange[700]!,
      'description': 'Cupertino date/time picker uses '
          'ListWheelScrollView. Each drum (hour, minute, AM/PM) '
          'independently reports FixedExtentMetrics. The parent '
          'reads itemIndex from each to compose the full DateTime.',
    },
    {
      'name': 'Number Spinner',
      'icon': Icons.add_circle_outline,
      'color': Colors.orange[600]!,
      'description': 'A compact number selector that scrolls through '
          'values 0–99. itemIndex directly maps to the numeric '
          'value. When snapped, the parent reads '
          'FixedExtentMetrics.itemIndex as the selected number.',
    },
    {
      'name': 'Slot Machine Animation',
      'icon': Icons.casino,
      'color': Colors.deepOrange[600]!,
      'description': 'Three ListWheelScrollViews side by side '
          'spinning to show random results. animateToItem() is '
          'called with different durations for a staggered stop. '
          'FixedExtentMetrics tells when each reel has settled.',
    },
    {
      'name': 'Musical Scale Selector',
      'icon': Icons.music_note,
      'color': Colors.orange[700]!,
      'description': 'A wheel displaying musical notes (C, D, E...). '
          'As the user scrolls, FixedExtentMetrics.itemIndex '
          'maps to a note. The app plays the note when itemIndex '
          'changes — audio feedback driven by scroll metrics.',
    },
    {
      'name': 'Font Size Chooser',
      'icon': Icons.format_size,
      'color': Colors.deepOrange[500]!,
      'description': 'A wheel of font sizes (8, 10, 12, 14...). '
          'itemIndex maps to a size array. Preview text updates '
          'live as the wheel spins. The fixed item extent ensures '
          'uniform wheel spacing for every font size option.',
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Always Check Type Before Casting',
      'body': 'Not every ScrollNotification carries '
          'FixedExtentMetrics. A PageView emits regular '
          'FixedScrollMetrics. Always use "is FixedExtentMetrics" '
          'before casting to avoid runtime errors.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'itemIndex Can Be Negative During Overscroll',
      'body': 'When the user over-scrolls past the first item, '
          'pixels goes negative and itemIndex can be negative. '
          'Similarly, over-scrolling past the last item gives '
          'an index > itemCount - 1. Always clamp.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Controller.selectedItem for Final Value',
      'body': 'During scrolling, itemIndex changes rapidly. For '
          'the final confirmed value, read the controller\'s '
          'selectedItem property after scrolling has settled '
          '(e.g., in onSelectedItemChanged callback or after '
          'animation completes).',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Only Works with Fixed Item Extents',
      'body': 'FixedExtentMetrics assumes all items have the same '
          'height (itemExtent). If you need variable heights, '
          'you cannot use ListWheelScrollView or '
          'FixedExtentMetrics — use a regular ListView instead.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine with FixedExtentScrollPhysics',
      'body': 'FixedExtentScrollPhysics ensures the scroll always '
          'snaps to an item boundary. Without it, the scroll can '
          'stop between items and itemIndex would be the nearest '
          'round — but the visual wouldn\'t match.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'itemIndex == (pixels / itemExtent).round()',
      'body': 'The formula is straightforward. If you know the '
          'itemExtent you can verify itemIndex manually. This is '
          'also useful when working with raw pixel offsets from '
          'scroll controllers.',
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
      title: Text('FixedExtentMetrics'),
      backgroundColor: Colors.deepOrange[700],
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
                colors: [Colors.deepOrange[700]!, Colors.orange[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.straighten, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FixedExtentMetrics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Scroll metrics that know which item is selected. '
                  'Extends FixedScrollMetrics with an itemIndex '
                  'property for ListWheelScrollView, CupertinoPicker, '
                  'and other fixed-extent scroll views.',
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
          _extHead('1', 'What is FixedExtentMetrics?'),
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

          // ── Section 2: Hierarchy ──
          _extHead('2', 'Class Hierarchy'),
          SizedBox(height: 12),
          ...hierarchy.map((h) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: (h['depth'] as int) * 20.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: h['isSubject'] == true
                          ? Colors.orange[50]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                            color: h['color'] as Color, width: 4),
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
                          Icon(h['icon'] as IconData,
                              color: h['color'] as Color, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(h['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                    color: h['color'] as Color)),
                          ),
                          if (h['isSubject'] == true)
                            _extBadge(
                                'THIS DEMO', Colors.deepOrange[800]!),
                        ]),
                        SizedBox(height: 4),
                        Text(h['description'] as String,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.3)),
                      ],
                    ),
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Properties ──
          _extHead('3', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: prop['unique'] == true
                        ? Colors.orange[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: prop['color'] as Color, width: 4),
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
                        Icon(prop['icon'] as IconData,
                            color: prop['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(prop['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: prop['color'] as Color)),
                        ),
                        _extBadge(
                            prop['type'] as String, Colors.grey[500]!),
                        if (prop['unique'] == true) ...[
                          SizedBox(width: 4),
                          _extBadge('UNIQUE', Colors.deepOrange[700]!),
                        ],
                      ]),
                      SizedBox(height: 4),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: itemIndex Calculation ──
          _extHead('4', 'How itemIndex Is Calculated'),
          SizedBox(height: 8),
          Text(
            'itemExtent = ${itemExtent.toInt()} px — '
            'index = (offset / $itemExtent).round()',
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'monospace'),
          ),
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
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.deepOrange[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Offset (px)',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 2,
                      child: Text('Raw Index',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 2,
                      child: Text('itemIndex',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                  Expanded(
                      flex: 1,
                      child: Text('Snap?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11))),
                ]),
              ),
              ...indexCalculations.asMap().entries.map((entry) {
                final idx = entry.key;
                final calc = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                  color: calc['isSnapped'] == true
                      ? Colors.orange[50]
                      : (idx.isEven ? Colors.grey[50] : Colors.white),
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                            (calc['offset'] as double)
                                .toInt()
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12))),
                    Expanded(
                        flex: 2,
                        child: Text(
                            (calc['rawIndex'] as double)
                                .toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600]))),
                    Expanded(
                        flex: 2,
                        child: Text(
                            (calc['roundedIndex'] as int).toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange[700]))),
                    Expanded(
                        flex: 1,
                        child: Text(
                            calc['isSnapped'] == true ? '✓' : '',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[600]))),
                  ]),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Notification Flow ──
          _extHead('5', 'Scroll Notification Flow'),
          SizedBox(height: 12),
          ...notifFlow.map((nf) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: nf['color'] as Color, width: 4),
                    ),
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
                          color: nf['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${nf['step']}',
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
                              Icon(nf['icon'] as IconData,
                                  color: nf['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Text(nf['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ]),
                            SizedBox(height: 4),
                            Text(nf['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
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

          // ── Section 6: Comparison Table ──
          _extHead('6', 'FixedExtentMetrics vs ScrollMetrics'),
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
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
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
                      child: Text('FixedExtentMetrics',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Regular ScrollMetrics',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
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
                                  color: Colors.deepOrange[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['regular'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Usage Patterns ──
          _extHead('7', 'Practical Usage Patterns'),
          SizedBox(height: 12),
          ...usagePatterns.map((up) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: up['color'] as Color, width: 4),
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
                        Icon(up['icon'] as IconData,
                            color: up['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(up['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(up['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(up['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.deepOrange[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Scenarios ──
          _extHead('8', 'Real-World Scenarios'),
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
                          child: Text(s['name'] as String,
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
          _extHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FixedExtentMetrics Deep Demo',
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
Widget _extHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.deepOrange[700],
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
// Helper: Small label/tag badge
// ──────────────────────────────────────────────────────────
Widget _extBadge(String text, Color color) {
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
