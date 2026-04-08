// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FixedExtentScrollController
// Demonstrates FixedExtentScrollController, a specialized
// ScrollController for scrollables with fixed-extent children
// (ListWheelScrollView, CupertinoPicker, NumberPicker).
// Covers selectedItem, jumpToItem, animateToItem, notifications,
// the fixed-extent ecosystem, and wheel-scroll UX patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FixedExtentScrollController Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FixedExtentScrollController?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'title': 'A ScrollController for Fixed-Extent Children',
      'body': 'FixedExtentScrollController extends ScrollController '
          'for scrollables where every child has the same size '
          '(extent). Unlike a regular ScrollController that works '
          'in pixels, this controller works in item indices — '
          'you select item 5, not pixel 250.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.rotate_90_degrees_cw,
      'title': 'Designed for ListWheelScrollView',
      'body': 'The primary consumer is ListWheelScrollView (and its '
          'wrappers: CupertinoPicker, CupertinoDatePicker). These '
          'widgets render children on a virtual cylinder, and '
          'FixedExtentScrollController navigates by item index.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.filter_center_focus,
      'title': 'selectedItem — The Key Property',
      'body': 'The most important property: selectedItem returns '
          'the index of the item currently centered in the viewport. '
          'It works both as a getter (read current selection) and '
          'as an initial value (constructor parameter).',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.navigation,
      'title': 'jumpToItem & animateToItem',
      'body': 'Instead of jumpTo(pixels) and animateTo(pixels), '
          'use jumpToItem(index) and animateToItem(index, ...). '
          'The controller calculates the pixel offset automatically '
          'based on the item extent.',
      'accent': Colors.deepPurple[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Constructor & Properties
  // ============================================================
  print('=== Section 2: Constructor & Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'initialItem',
      'type': 'int',
      'icon': Icons.looks_one,
      'color': Colors.indigo[600]!,
      'bgColor': Colors.indigo[50]!,
      'description': 'Constructor parameter: the item index to start '
          'at when the scrollable first builds. Defaults to 0 '
          '(first item). Does NOT animate — the scroll position '
          'jumps directly.',
      'example': 'FixedExtentScrollController(\n'
          '  initialItem: 5,  // start at 6th item\n'
          ')',
    },
    {
      'name': 'selectedItem',
      'type': 'int',
      'icon': Icons.filter_center_focus,
      'color': Colors.deepPurple[600]!,
      'bgColor': Colors.deepPurple[50]!,
      'description': 'Returns the index of the currently selected '
          '(centered) item. Can only be read while the controller '
          'is attached to a scroll view. Throws if not attached.',
      'example': 'final current = controller.selectedItem;\n'
          'print("Selected: \$current");',
    },
    {
      'name': 'jumpToItem(int)',
      'type': 'void',
      'icon': Icons.skip_next,
      'color': Colors.indigo[700]!,
      'bgColor': Colors.indigo[50]!,
      'description': 'Immediately jumps to the given item index '
          'without animation. The scroll position changes instantly. '
          'Equivalent to jumpTo(index * itemExtent) but index-based.',
      'example': 'controller.jumpToItem(10);  // instant jump',
    },
    {
      'name': 'animateToItem(int, ...)',
      'type': 'Future<void>',
      'icon': Icons.play_arrow,
      'color': Colors.deepPurple[700]!,
      'bgColor': Colors.deepPurple[50]!,
      'description': 'Smoothly scrolls to the given item with '
          'animation. Requires duration and optional curve. Returns '
          'a Future that completes when the animation finishes. '
          'Uses FixedExtentScrollPhysics for snapping.',
      'example': 'await controller.animateToItem(\n'
          '  10,\n'
          '  duration: Duration(milliseconds: 500),\n'
          '  curve: Curves.easeInOut,\n'
          ');',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: How Item Index Maps to Pixels
  // ============================================================
  print('=== Section 3: Index-to-Pixel Mapping ===');

  final mappings = <Map<String, dynamic>>[
    {
      'index': 0,
      'pixels': 0.0,
      'label': 'Item 0',
      'color': Colors.indigo[300]!,
      'fraction': 0.0,
    },
    {
      'index': 1,
      'pixels': 50.0,
      'label': 'Item 1',
      'color': Colors.indigo[400]!,
      'fraction': 0.1,
    },
    {
      'index': 5,
      'pixels': 250.0,
      'label': 'Item 5',
      'color': Colors.indigo[500]!,
      'fraction': 0.25,
    },
    {
      'index': 10,
      'pixels': 500.0,
      'label': 'Item 10',
      'color': Colors.deepPurple[500]!,
      'fraction': 0.5,
    },
    {
      'index': 15,
      'pixels': 750.0,
      'label': 'Item 15',
      'color': Colors.deepPurple[600]!,
      'fraction': 0.75,
    },
    {
      'index': 20,
      'pixels': 1000.0,
      'label': 'Item 20',
      'color': Colors.deepPurple[700]!,
      'fraction': 1.0,
    },
  ];

  print('  Assuming itemExtent = 50px for visualization');
  print('  Prepared ${mappings.length} index→pixel mappings');

  // ============================================================
  // SECTION 4: The Fixed-Extent Ecosystem
  // ============================================================
  print('=== Section 4: Fixed-Extent Ecosystem ===');

  final ecosystem = <Map<String, dynamic>>[
    {
      'name': 'FixedExtentScrollController',
      'icon': Icons.gamepad,
      'color': Colors.indigo[600]!,
      'role': 'Controller',
      'description': 'Navigates by item index. Provides selectedItem, '
          'jumpToItem, animateToItem. The subject of this demo.',
      'highlight': true,
    },
    {
      'name': 'FixedExtentScrollPhysics',
      'icon': Icons.local_attraction,
      'color': Colors.deepPurple[500]!,
      'role': 'Physics',
      'description': 'Snapping physics that always settles on an item '
          'boundary. Used automatically by ListWheelScrollView. '
          'Ensures the scroll never stops between items.',
      'highlight': false,
    },
    {
      'name': 'ListWheelScrollView',
      'icon': Icons.view_carousel,
      'color': Colors.indigo[500]!,
      'role': 'Widget',
      'description': 'Renders children on a 3D cylinder. Uses '
          'FixedExtentScrollController and FixedExtentScrollPhysics '
          'under the hood. The primary visual consumer.',
      'highlight': false,
    },
    {
      'name': 'CupertinoPicker',
      'icon': Icons.phone_iphone,
      'color': Colors.deepPurple[600]!,
      'role': 'Widget',
      'description': 'iOS-style picker built on ListWheelScrollView. '
          'Adds the selection highlight overlay and looping behavior. '
          'Takes FixedExtentScrollController.',
      'highlight': false,
    },
    {
      'name': 'FixedExtentMetrics',
      'icon': Icons.analytics,
      'color': Colors.indigo[700]!,
      'role': 'Metrics',
      'description': 'ScrollMetrics subclass that adds itemIndex. '
          'Available in scroll notifications when using this controller. '
          'Tells you which item is selected during scroll.',
      'highlight': false,
    },
    {
      'name': 'ListWheelChildDelegate',
      'icon': Icons.list,
      'color': Colors.deepPurple[700]!,
      'role': 'Delegate',
      'description': 'Provides children lazily. '
          'ListWheelChildBuilderDelegate builds on demand. '
          'ListWheelChildLoopingListDelegate wraps for infinite loop.',
      'highlight': false,
    },
  ];

  print('  Prepared ${ecosystem.length} ecosystem components');

  // ============================================================
  // SECTION 5: ListWheelScrollView Configuration
  // ============================================================
  print('=== Section 5: ListWheelScrollView Configuration ===');

  final lwsvConfigs = <Map<String, dynamic>>[
    {
      'name': 'itemExtent',
      'icon': Icons.height,
      'color': Colors.indigo[500]!,
      'description': 'Height of each child in logical pixels. Every '
          'child has exactly this height. The controller uses this '
          'to calculate pixel offsets from item indices.',
      'valueExample': '50.0',
    },
    {
      'name': 'diameterRatio',
      'icon': Icons.panorama_horizontal,
      'color': Colors.deepPurple[500]!,
      'description': 'Ratio of the wheel diameter to viewport height. '
          'Default 2.0 (cylinder diameter = 2× viewport). Larger '
          'values flatten the cylinder; smaller values curve more.',
      'valueExample': '2.0',
    },
    {
      'name': 'perspective',
      'icon': Icons.remove_red_eye,
      'color': Colors.indigo[600]!,
      'description': 'How much 3D perspective to apply (0.0–0.01). '
          'Default 0.003. Higher values increase the foreshortening '
          'effect. Zero looks flat.',
      'valueExample': '0.003',
    },
    {
      'name': 'offAxisFraction',
      'icon': Icons.pivot_table_chart,
      'color': Colors.deepPurple[600]!,
      'description': 'Horizontal offset of the wheel center '
          '(-0.5 to 0.5). Zero is centered. Positive moves the '
          'rotation axis right, creating a tilt effect.',
      'valueExample': '0.0',
    },
    {
      'name': 'squeeze',
      'icon': Icons.compress,
      'color': Colors.indigo[700]!,
      'description': 'How tightly children pack on the wheel. '
          'Default 1.0. Values >1 pack more children visibly; '
          'values <1 space them out.',
      'valueExample': '1.0',
    },
    {
      'name': 'useMagnifier',
      'icon': Icons.zoom_in,
      'color': Colors.deepPurple[700]!,
      'description': 'Whether to magnify the selected (center) item. '
          'Works with magnification property to enlarge the '
          'currently selected child.',
      'valueExample': 'true',
    },
  ];

  print('  Prepared ${lwsvConfigs.length} configuration options');

  // ============================================================
  // SECTION 6: Scroll Notifications
  // ============================================================
  print('=== Section 6: Scroll Notifications ===');

  final notifications = <Map<String, dynamic>>[
    {
      'name': 'ScrollStartNotification',
      'icon': Icons.play_circle,
      'color': Colors.indigo[400]!,
      'when': 'User begins scrolling (touch/fling start)',
      'detail': 'The metrics property provides FixedExtentMetrics '
          'with the initial itemIndex. Cast metrics to '
          'FixedExtentMetrics to access it.',
    },
    {
      'name': 'ScrollUpdateNotification',
      'icon': Icons.update,
      'color': Colors.indigo[500]!,
      'when': 'During scrolling (each frame)',
      'detail': 'Fires continuously as the scroll position changes. '
          'FixedExtentMetrics.itemIndex updates to the nearest '
          'item. Use for live preview of selected value.',
    },
    {
      'name': 'ScrollEndNotification',
      'icon': Icons.stop_circle,
      'color': Colors.deepPurple[500]!,
      'when': 'Scrolling settles on an item',
      'detail': 'Fires when the physics simulation finishes and '
          'the scroll has snapped to an item boundary. The '
          'itemIndex now reflects the final selection.',
    },
    {
      'name': 'FixedExtentMetrics',
      'icon': Icons.analytics,
      'color': Colors.deepPurple[600]!,
      'when': 'Available in all scroll notifications above',
      'detail': 'Extends FixedScrollMetrics with itemIndex (int). '
          'Access via notification.metrics as FixedExtentMetrics. '
          'The itemIndex is the currently centered item.',
    },
  ];

  print('  Prepared ${notifications.length} notification types');

  // ============================================================
  // SECTION 7: Regular ScrollController Comparison
  // ============================================================
  print('=== Section 7: Comparison with Regular ScrollController ===');

  final comparison = <Map<String, String>>[
    {
      'aspect': 'Unit of navigation',
      'fixed': 'Item indices (0, 1, 2...)',
      'regular': 'Pixels (0.0, 100.5, ...)',
    },
    {
      'aspect': 'Jump method',
      'fixed': 'jumpToItem(int index)',
      'regular': 'jumpTo(double offset)',
    },
    {
      'aspect': 'Animate method',
      'fixed': 'animateToItem(index, ...)',
      'regular': 'animateTo(offset, ...)',
    },
    {
      'aspect': 'Current position',
      'fixed': 'selectedItem → int',
      'regular': 'offset → double',
    },
    {
      'aspect': 'Physics',
      'fixed': 'FixedExtentScrollPhysics (snaps)',
      'regular': 'ClampingScrollPhysics / Bouncing',
    },
    {
      'aspect': 'Used with',
      'fixed': 'ListWheelScrollView, CupertinoPicker',
      'regular': 'ListView, GridView, CustomScrollView',
    },
    {
      'aspect': 'Scroll metrics',
      'fixed': 'FixedExtentMetrics (has itemIndex)',
      'regular': 'ScrollMetrics (pixels only)',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Time Picker',
      'icon': Icons.access_time,
      'color': Colors.indigo[600]!,
      'body': 'Three FixedExtentScrollControllers — one for hours, '
          'one for minutes, one for AM/PM. Each controls a separate '
          'ListWheelScrollView. Use onSelectedItemChanged to sync '
          'the displayed time.',
    },
    {
      'title': 'Slot Machine',
      'icon': Icons.casino,
      'color': Colors.deepPurple[600]!,
      'body': 'Multiple wheels with looping delegates. Call '
          'animateToItem with different durations for staggered '
          'stop effect. Use velocity curves for realistic spin-down.',
    },
    {
      'title': 'Unit Converter',
      'icon': Icons.swap_vert,
      'color': Colors.indigo[500]!,
      'body': 'Left wheel selects the "from" unit, right wheel '
          'selects the "to" unit. selectedItem maps to unit '
          'enum values. Conversion updates live during scroll.',
    },
    {
      'title': 'Programmatic Reset',
      'icon': Icons.restart_alt,
      'color': Colors.deepPurple[500]!,
      'body': 'A "Reset" button calls animateToItem(0, ...) to '
          'smoothly return to the first item. Or jumpToItem(0) '
          'for instant reset. Common in form clearing.',
    },
    {
      'title': 'Multi-Wheel Date Picker',
      'icon': Icons.calendar_month,
      'color': Colors.indigo[700]!,
      'body': 'Year, month, and day wheels — each with their own '
          'controller. When month changes, rebuild the day wheel '
          'with correct number of days and clamp the day controller '
          'if necessary.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'selectedItem Throws if Not Attached',
      'body': 'Reading controller.selectedItem before the controller '
          'is attached to a scrollable throws an assertion error. '
          'Check controller.hasClients before reading. Or use '
          'controller.initialItem as fallback.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use onSelectedItemChanged, Not NotificationListener',
      'body': 'ListWheelScrollView has an onSelectedItemChanged callback '
          'that fires whenever the centered item changes. This is '
          'simpler and more reliable than wrapping with a '
          'NotificationListener and extracting FixedExtentMetrics.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Dispose the Controller',
      'body': 'Like any ScrollController, you must dispose it in '
          'the State\'s dispose() method. Forgetting causes memory '
          'leaks and "controller used after dispose" errors.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Only One ScrollView Per Controller',
      'body': 'A FixedExtentScrollController can only be attached '
          'to one scrollable at a time. If you have multiple wheels, '
          'create a separate controller for each.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Looping Requires Special Delegate',
      'body': 'For infinite/looping scrolling (like a date wheel), '
          'use ListWheelChildLoopingListDelegate. The controller '
          'sees arbitrarily large indices — use selectedItem % count '
          'to get the actual data index.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'initialItem vs jumpToItem',
      'body': 'Set initialItem in the constructor for the starting '
          'position. Use jumpToItem only after the widget is built '
          'and the controller is attached. Calling jumpToItem in '
          'initState may fail.',
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
      title: Text('FixedExtentScrollController'),
      backgroundColor: Colors.indigo[700],
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
                colors: [Colors.indigo[700]!, Colors.deepPurple[600]!],
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
                  'FixedExtentScrollController',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Navigate wheel scrollables by item index '
                  'instead of pixel offset — built for '
                  'ListWheelScrollView and CupertinoPicker.',
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
          _header('1', 'What is FixedExtentScrollController?'),
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

          // ── Section 2: Properties ──
          _header('2', 'Constructor & Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: prop['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (prop['color'] as Color).withOpacity(0.4)),
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
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: prop['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(prop['icon'] as IconData,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('.${prop['name']}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: prop['color'] as Color)),
                              Text(prop['type'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(prop['example'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Index → Pixel Mapping ──
          _header('3', 'How Item Index Maps to Pixels'),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.indigo[200]!),
            ),
            child: Text(
              'pixelOffset = index × itemExtent\n'
              'Example: itemExtent = 50px → item 10 = 500px',
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.indigo[800],
                  height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          ...mappings.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (m['color'] as Color).withOpacity(0.3)),
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
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: m['color'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(m['label'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'index ${m['index']} → '
                          '${(m['pixels'] as double).toStringAsFixed(0)} px',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: Colors.grey[700]),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor:
                              ((m['fraction'] as double) + 0.02).clamp(0.02, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                (m['color'] as Color).withOpacity(0.5),
                                m['color'] as Color,
                              ]),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Ecosystem ──
          _header('4', 'The Fixed-Extent Ecosystem'),
          SizedBox(height: 12),
          ...ecosystem.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (e['highlight'] as bool)
                        ? (e['color'] as Color).withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (e['highlight'] as bool)
                          ? (e['color'] as Color).withOpacity(0.5)
                          : Colors.grey[200]!,
                      width: (e['highlight'] as bool) ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (e['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(e['icon'] as IconData,
                            color: e['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                child: Text(e['name'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: 'monospace')),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (e['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(e['role'] as String,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: e['color'] as Color)),
                              ),
                            ]),
                            SizedBox(height: 4),
                            Text(e['description'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: ListWheelScrollView Config ──
          _header('5', 'ListWheelScrollView Configuration'),
          SizedBox(height: 12),
          ...lwsvConfigs.map((cfg) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: cfg['color'] as Color, width: 4),
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
                        Icon(cfg['icon'] as IconData,
                            color: cfg['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Text('.${cfg['name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'monospace',
                                color: cfg['color'] as Color)),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(cfg['valueExample'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: Colors.grey[600])),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(cfg['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Notifications ──
          _header('6', 'Scroll Notifications'),
          SizedBox(height: 12),
          ...notifications.map((n) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: n['color'] as Color, width: 4),
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
                        Icon(n['icon'] as IconData,
                            color: n['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(n['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (n['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(n['when'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: n['color'] as Color,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 6),
                      Text(n['detail'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _header('7', 'vs Regular ScrollController'),
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _tableCell('Aspect', bold: true, white: true, flex: 2),
                  _tableCell('FixedExtent', bold: true, white: true, flex: 3),
                  _tableCell('Regular', bold: true, white: true, flex: 3),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tableCell(row['aspect']!, bold: true, flex: 2),
                      _tableCell(row['fixed']!, flex: 3),
                      _tableCell(row['regular']!, flex: 3),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _header('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
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
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _header('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FixedExtentScrollController Deep Demo',
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
Widget _header(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
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
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _tableCell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}
