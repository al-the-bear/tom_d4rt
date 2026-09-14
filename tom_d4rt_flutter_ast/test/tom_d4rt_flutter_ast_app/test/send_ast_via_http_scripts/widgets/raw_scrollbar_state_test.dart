// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — RawScrollbarState
// Demonstrates RawScrollbarState — the state class for RawScrollbar
// that manages scrollbar painting, thumb drag gestures, track taps,
// fade animations, and accessibility. Covers the ScrollbarPainter,
// visibility logic, gesture handling, theme integration, and
// practical scrollbar customization patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawScrollbarState Deep Demo executing');

  // ============================================================
  // SECTION 1: What is RawScrollbarState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'title': 'Scrollbar State Manager',
      'body': 'RawScrollbarState is the State class for RawScrollbar. '
          'It manages the ScrollbarPainter, fade animations, gesture '
          'recognizers for thumb drag and track tap, and coordinates '
          'with the ScrollController to reflect scroll position.',
      'accent': Colors.brown[700]!,
    },
    {
      'icon': Icons.brush,
      'title': 'ScrollbarPainter',
      'body': 'The scrollbarPainter property is the CustomPainter that '
          'actually renders the scrollbar track and thumb. The state '
          'creates it in initState() and updates it via '
          'updateScrollbarPainter() whenever metrics or theme change.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Fade Animation',
      'body': 'The scrollbar fades in when scroll activity begins and '
          'fades out after a configurable delay when scrolling stops. '
          'An AnimationController with CurvedAnimation drives the '
          'opacity. thumbVisibility overrides to always-visible.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.pan_tool,
      'title': 'Gesture Handling',
      'body': 'The state attaches gesture recognizers for thumb drag '
          '(to scroll by dragging the scrollbar) and track tap (to '
          'jump to a position). The enableGestures getter controls '
          'whether interactive scrollbar is active.',
      'accent': Colors.amber[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Lifecycle
  // ============================================================
  print('=== Section 2: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'initState()',
      'detail': 'Creates the ScrollbarPainter with initial configuration, '
          'sets up the AnimationController for fade animation, and '
          'resolves the ScrollController to listen to.',
      'icon': Icons.play_arrow,
      'color': Colors.brown[700]!,
    },
    {
      'step': 2,
      'title': 'didChangeDependencies()',
      'detail': 'Re-resolves the ScrollController (it may come from '
          'PrimaryScrollController), updates the scrollbar painter with '
          'current theme/metrics, and attaches scroll listeners.',
      'icon': Icons.sync,
      'color': Colors.amber[800]!,
    },
    {
      'step': 3,
      'title': 'updateScrollbarPainter()',
      'detail': 'Called by subclasses to update the painter with new '
          'colors, thickness, radius, and other visual properties. '
          'Scrollbar and CupertinoScrollbar call this with their '
          'respective theme values.',
      'icon': Icons.palette,
      'color': Colors.brown[600]!,
    },
    {
      'step': 4,
      'title': 'Scroll Notification',
      'detail': 'Handles ScrollUpdateNotification to update the painter\'s '
          'scroll metrics. Triggers fade-in animation when scrolling '
          'starts, schedules fade-out when scrolling ends.',
      'icon': Icons.notifications_active,
      'color': Colors.amber[700]!,
    },
    {
      'step': 5,
      'title': 'dispose()',
      'detail': 'Disposes the AnimationController, the ScrollbarPainter, '
          'removes scroll listeners, and cancels any pending fade-out '
          'timer. Cleans up all resources.',
      'icon': Icons.delete_outline,
      'color': Colors.brown[500]!,
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 3: Key Properties & Methods
  // ============================================================
  print('=== Section 3: API ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'name': 'scrollbarPainter',
      'type': 'ScrollbarPainter',
      'icon': Icons.brush,
      'color': Colors.brown[700]!,
      'description': 'The painter that renders the scrollbar. Created in '
          'initState and updated throughout the lifecycle. Subclasses '
          'configure it with theme-specific colors, thickness, and radius.',
    },
    {
      'name': 'showScrollbar',
      'type': 'bool (getter)',
      'icon': Icons.visibility,
      'color': Colors.amber[800]!,
      'description': 'Whether the scrollbar is always visible. Returns '
          'widget.thumbVisibility ?? false by default. Subclasses '
          'override this to depend on theme (e.g., Scrollbar reads '
          'ScrollbarThemeData.thumbVisibility).',
    },
    {
      'name': 'enableGestures',
      'type': 'bool (getter)',
      'icon': Icons.pan_tool,
      'color': Colors.brown[600]!,
      'description': 'Whether the scrollbar responds to drag and tap '
          'gestures. Returns widget.interactive ?? true by default. '
          'When false, the scrollbar is purely a visual indicator.',
    },
    {
      'name': 'updateScrollbarPainter',
      'type': 'void Function()',
      'icon': Icons.update,
      'color': Colors.amber[700]!,
      'description': 'Protected method that subclasses call to push new '
          'visual properties to the painter: color, trackColor, '
          'trackBorderColor, textDirection, thickness, radius, etc.',
    },
    {
      'name': 'handleThumbPress',
      'type': 'void Function()',
      'icon': Icons.touch_app,
      'color': Colors.brown[500]!,
      'description': 'Called when the user starts dragging the thumb. '
          'Begins scrollbar tracking — converts drag deltas to scroll '
          'position changes. Shows the scrollbar during the drag.',
    },
  ];

  print('  API entries: ${apiEntries.length}');

  // ============================================================
  // SECTION 4: Fade Animation Detail
  // ============================================================
  print('=== Section 4: Fade Animation ===');

  final fadePhases = <Map<String, dynamic>>[
    {
      'phase': 'Idle',
      'opacity': '0.0',
      'trigger': 'No scroll activity',
      'description': 'Scrollbar is invisible. The fade animation '
          'controller is at 0.0.',
      'color': Colors.grey[600]!,
    },
    {
      'phase': 'Scroll Start',
      'opacity': '0.0 → 1.0',
      'trigger': 'ScrollStartNotification',
      'description': 'Animation controller forward() runs over '
          'widget.fadeDuration. The scrollbar becomes visible.',
      'color': Colors.brown[700]!,
    },
    {
      'phase': 'Scrolling',
      'opacity': '1.0',
      'trigger': 'ScrollUpdateNotification',
      'description': 'Scrollbar stays fully visible while scroll events '
          'continue arriving. Painter updates position.',
      'color': Colors.amber[800]!,
    },
    {
      'phase': 'Scroll End',
      'opacity': '1.0 (waiting)',
      'trigger': 'ScrollEndNotification',
      'description': 'A timer starts (widget.timeToFade). Scrollbar '
          'stays visible during this delay.',
      'color': Colors.brown[600]!,
    },
    {
      'phase': 'Fade Out',
      'opacity': '1.0 → 0.0',
      'trigger': 'Timer fires',
      'description': 'After the delay, animation controller reverse() '
          'runs. Scrollbar fades away smoothly.',
      'color': Colors.grey[600]!,
    },
    {
      'phase': 'Always Visible',
      'opacity': '1.0 (locked)',
      'trigger': 'thumbVisibility: true',
      'description': 'Overrides the fade cycle entirely. The scrollbar '
          'is always visible at full opacity.',
      'color': Colors.amber[700]!,
    },
  ];

  print('  Fade phases: ${fadePhases.length}');

  // ============================================================
  // SECTION 5: Scrollbar Widget Hierarchy
  // ============================================================
  print('=== Section 5: Widget Hierarchy ===');

  final hierarchyRows = <Map<String, dynamic>>[
    {
      'widget': 'RawScrollbar',
      'state': 'RawScrollbarState',
      'platform': 'None (base)',
      'features': 'Core painting, gestures, fade',
    },
    {
      'widget': 'Scrollbar',
      'state': 'extends RawScrollbarState',
      'platform': 'Material',
      'features': 'Material theme, hover effects, track',
    },
    {
      'widget': 'CupertinoScrollbar',
      'state': 'extends RawScrollbarState',
      'platform': 'iOS / macOS',
      'features': 'Rounded thumb, thin track, iOS feel',
    },
  ];

  print('  Hierarchy rows: ${hierarchyRows.length}');

  // ============================================================
  // SECTION 6: Gesture Interactions
  // ============================================================
  print('=== Section 6: Gesture Interactions ===');

  final gestureDetails = <Map<String, dynamic>>[
    {
      'title': 'Thumb Drag',
      'description': 'Click/touch and drag the scrollbar thumb to scroll. '
          'The state converts the drag delta (in pixels) to a scroll '
          'position change based on the scrollbar-to-content ratio. '
          'The thumb follows the finger precisely.',
      'icon': Icons.drag_indicator,
      'color': Colors.brown[700]!,
    },
    {
      'title': 'Track Tap',
      'description': 'Tapping the scrollbar track (not the thumb) jumps '
          'the scroll position by one page in the tapped direction. '
          'This allows quick navigation through long content.',
      'icon': Icons.touch_app,
      'color': Colors.amber[800]!,
    },
    {
      'title': 'Hover Effects',
      'description': 'On desktop, hovering over the scrollbar enlarges '
          'the thumb and shows the track. This is handled by '
          'the Material Scrollbar subclass, not RawScrollbarState.',
      'icon': Icons.mouse,
      'color': Colors.brown[600]!,
    },
    {
      'title': 'Keyboard Scroll',
      'description': 'The scrollbar itself doesn\'t handle keyboard input, '
          'but it reflects position changes from keyboard scrolling '
          '(Page Up/Down, arrow keys) via the shared ScrollController.',
      'icon': Icons.keyboard,
      'color': Colors.amber[700]!,
    },
  ];

  print('  Gesture details: ${gestureDetails.length}');

  // ============================================================
  // SECTION 7: Customization Points
  // ============================================================
  print('=== Section 7: Customization ===');

  final customizationOptions = <Map<String, dynamic>>[
    {
      'property': 'thickness',
      'description': 'Width of the scrollbar thumb in physical pixels. '
          'Default varies by platform (Material ~8, Cupertino ~3).',
      'code': 'RawScrollbar(thickness: 10, ...)',
      'icon': Icons.line_weight,
      'color': Colors.brown[700]!,
    },
    {
      'property': 'radius',
      'description': 'Corner radius of the scrollbar thumb. Cupertino '
          'uses a fully rounded stadium shape.',
      'code': 'RawScrollbar(radius: Radius.circular(6), ...)',
      'icon': Icons.rounded_corner,
      'color': Colors.amber[800]!,
    },
    {
      'property': 'thumbColor',
      'description': 'The color of the scrollbar thumb. Can be '
          'semi-transparent for a subtle effect.',
      'code': 'RawScrollbar(\n  thumbColor: Colors.brown.withOpacity(0.6),\n  ...\n)',
      'icon': Icons.color_lens,
      'color': Colors.brown[600]!,
    },
    {
      'property': 'fadeDuration',
      'description': 'How long the fade-in/out animation takes. '
          'Default: 300ms. Set to Duration.zero for instant show/hide.',
      'code': 'RawScrollbar(\n  fadeDuration: Duration(milliseconds: 500),\n  ...\n)',
      'icon': Icons.timelapse,
      'color': Colors.amber[700]!,
    },
    {
      'property': 'timeToFade',
      'description': 'Delay after scroll ends before the fade-out begins. '
          'Default: 600ms. Longer values keep the scrollbar visible.',
      'code': 'RawScrollbar(\n  timeToFade: Duration(seconds: 1),\n  ...\n)',
      'icon': Icons.timer,
      'color': Colors.brown[500]!,
    },
    {
      'property': 'thumbVisibility',
      'description': 'When true, the scrollbar is always visible (no fading). '
          'Useful for desktop apps where scrollbar is a persistent UI element.',
      'code': 'RawScrollbar(thumbVisibility: true, ...)',
      'icon': Icons.visibility,
      'color': Colors.amber[600]!,
    },
  ];

  print('  Customization options: ${customizationOptions.length}');

  // ============================================================
  // SECTION 8: Scrollbar Showcase
  // ============================================================
  print('=== Section 8: Showcase ===');

  // Build sample list items for scrollbar demos
  final sampleItems = List.generate(20, (i) => {
        'title': 'Item ${i + 1}',
        'subtitle': 'Scroll to see the scrollbar in action',
        'color': [
          Colors.brown[100]!,
          Colors.amber[100]!,
          Colors.brown[50]!,
          Colors.amber[50]!,
        ][i % 4],
      });

  print('  Sample items: ${sampleItems.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown[800]!, Colors.amber[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.straighten, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'RawScrollbarState',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Manages scrollbar painting, fade animations, thumb drag, '
                'track tap, and accessibility — the engine behind every '
                'scrollbar in Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.brown[700]!),
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

        // ---- Section 2: Lifecycle ----
        _sectionHeader('2. Lifecycle', Icons.loop, Colors.amber[800]!),
        SizedBox(height: 10),
        ...lifecycleSteps.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: s['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${s['step']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['title'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace')),
                        SizedBox(height: 3),
                        Text(s['detail'] as String,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: API ----
        _sectionHeader('3. Key Properties & Methods', Icons.api, Colors.brown[700]!),
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
                        Text(a['name'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: a['color'] as Color)),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(a['type'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey[800])),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(a['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Fade Animation ----
        _sectionHeader('4. Fade Animation Phases', Icons.animation, Colors.amber[800]!),
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
                color: Colors.brown[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text('Phase', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('Opacity', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 3, child: Text('Trigger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(fadePhases.length, (i) {
                final p = fadePhases[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.brown[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(p['phase'] as String,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: p['color'] as Color)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(p['opacity'] as String,
                            style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(p['trigger'] as String,
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        SizedBox(height: 6),
        ...fadePhases.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: p['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('${p['phase']}: ${p['description']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Widget Hierarchy ----
        _sectionHeader('5. Scrollbar Widget Hierarchy', Icons.account_tree, Colors.brown[700]!),
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
                color: Colors.amber[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('Platform', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 4, child: Text('Features', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              ...List.generate(hierarchyRows.length, (i) {
                final h = hierarchyRows[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.amber[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(h['widget'] as String,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(h['platform'] as String, style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(h['features'] as String, style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Gesture Interactions ----
        _sectionHeader('6. Gesture Interactions', Icons.pan_tool, Colors.amber[800]!),
        SizedBox(height: 10),
        ...gestureDetails.map((g) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (g['color'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: g['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(g['icon'] as IconData, color: g['color'] as Color, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(g['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: g['color'] as Color)),
                          SizedBox(height: 4),
                          Text(g['description'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Customization ----
        _sectionHeader('7. Customization Points', Icons.settings, Colors.brown[700]!),
        SizedBox(height: 10),
        ...customizationOptions.map((o) => Padding(
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
                        Icon(o['icon'] as IconData, color: o['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(o['property'] as String,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: o['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(o['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(o['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Live Scrollbar Showcase ----
        _sectionHeader('8. Scrollbar Showcase', Icons.view_list, Colors.amber[800]!),
        SizedBox(height: 10),
        Text(
          'A list wrapped with RawScrollbar. In a real app, dragging '
          'the thumb or tapping the track scrolls the content:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          // Cluster G TODO #14 fix: thumbVisibility: true requires an
          // explicit ScrollController (PrimaryScrollController isn't
          // auto-inherited by ListView on desktop).
          child: Builder(
            builder: (ctx) {
              final scrollCtrl = ScrollController();
              return RawScrollbar(
                controller: scrollCtrl,
                thumbVisibility: true,
                thickness: 8,
                radius: Radius.circular(4),
                thumbColor: Colors.brown[400],
                child: ListView.builder(
                  controller: scrollCtrl,
                  itemCount: sampleItems.length,
              itemBuilder: (ctx, i) {
                final item = sampleItems[i];
                return Container(
                  color: item['color'] as Color,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.brown[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text('${i + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'] as String,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            Text(item['subtitle'] as String,
                                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
            },
          ),
        ),

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
              Icon(Icons.straighten, color: Colors.brown[600], size: 28),
              SizedBox(height: 6),
              Text(
                'RawScrollbarState: the invisible machinery behind every '
                'scrollbar — managing painters, fade animations, drag '
                'gestures, and scroll position coordination.',
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
