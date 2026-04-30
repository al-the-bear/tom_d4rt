// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — View
// Demonstrates the View widget, which wraps a single FlutterView,
// establishing an independent rendering pipeline with its own
// build, layout, paint, and compositing phases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('View Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.tv,
      'title': 'What is View?',
      'body': 'View is the widget that wraps a FlutterView — the '
          'platform-provided rendering surface. Every pixel Flutter '
          'draws goes through a FlutterView. The View widget binds '
          'a widget subtree to a specific rendering target.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.layers,
      'title': 'Rendering Pipeline',
      'body': 'Each View establishes its own complete rendering pipeline: '
          'build phase (widget to element), layout phase (element to '
          'render object sizing), paint phase (render object to layer '
          'tree), and compositing (layer tree to display).',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.crop_square,
      'title': 'MediaQuery Boundary',
      'body': 'View reads physical size, device pixel ratio, padding, '
          'and view insets from its FlutterView and provides them '
          'to descendants via MediaQuery. Each View is a media '
          'query boundary for its subtree.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.foundation,
      'title': 'Single-View vs Multi-View',
      'body': 'Traditional Flutter apps have one implicit View wrapping '
          'the entire app. Multi-view apps (via ViewCollection) have '
          'multiple View widgets, each rendering to a different '
          'FlutterView.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
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
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
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
      'name': 'view',
      'type': 'FlutterView',
      'desc': 'The rendering surface this View targets. Obtained from '
          'PlatformDispatcher.views or via View.of(context). Provides '
          'physical size, pixel ratio, and platform-specific metrics.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget subtree rendered into this View. The child '
          'receives constraints based on the FlutterView\u0027s physical '
          'size divided by the device pixel ratio.',
    },
    {
      'name': 'View.of(context)',
      'type': 'FlutterView',
      'desc': 'Static method to obtain the FlutterView from the nearest '
          'ancestor View widget. Returns the rendering surface for '
          'the given BuildContext.',
    },
    {
      'name': 'View.maybeOf(context)',
      'type': 'FlutterView?',
      'desc': 'Nullable version of View.of(). Returns null if no View '
          'ancestor exists. Useful for code that may run in contexts '
          'without a View (like pre-rendering).',
    },
    {
      'name': 'deprecation',
      'type': 'Note',
      'desc': 'WidgetsBinding.instance.window was the old way to access '
          'the single FlutterView. It\u0027s deprecated in favor of '
          'View.of(context) which correctly handles multi-view apps.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.25)),
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
                    color: Colors.indigo.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
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
  // SECTION 3: FlutterView Properties
  // ============================================================
  print('=== Section 3: FlutterView ===');

  final viewProps = <Map<String, dynamic>>[
    {
      'prop': 'physicalSize',
      'desc': 'The physical dimensions of the rendering surface '
          'in device pixels. A 1920x1080 display reports '
          'Size(1920, 1080) regardless of pixel ratio.',
      'icon': Icons.photo_size_select_large,
      'color': Colors.indigo,
    },
    {
      'prop': 'devicePixelRatio',
      'desc': 'The number of device pixels per logical pixel. '
          'A ratio of 2.0 means the display renders at twice '
          'the resolution of the logical coordinate system.',
      'icon': Icons.hd,
      'color': Colors.blue,
    },
    {
      'prop': 'viewInsets',
      'desc': 'Areas of the view obscured by system UI like the '
          'on-screen keyboard. Expressed as physical pixels from '
          'each edge. Drives MediaQuery.viewInsets.',
      'icon': Icons.keyboard,
      'color': Colors.green,
    },
    {
      'prop': 'viewPadding',
      'desc': 'Physical pixel padding from system UI that may '
          'overlap content (status bar, navigation bar). '
          'Persists even when a keyboard is shown.',
      'icon': Icons.padding,
      'color': Colors.orange,
    },
    {
      'prop': 'padding',
      'desc': 'The padding that remains after accounting for '
          'viewInsets. When the keyboard is showing, the '
          'bottom padding is reduced since viewInsets covers it.',
      'icon': Icons.crop_free,
      'color': Colors.purple,
    },
    {
      'prop': 'systemGestureInsets',
      'desc': 'Areas where the system handles gestures (swipe '
          'from edge). Flutter should avoid placing interactive '
          'content in these inset areas.',
      'icon': Icons.swipe,
      'color': Colors.red,
    },
  ];

  final viewPropWidgets = <Widget>[];
  for (var i = 0; i < viewProps.length; i++) {
    final vp = viewProps[i];
    final vpColor = vp['color'] as Color;
    print('ViewProp ${i + 1}: ${vp['prop']}');
    viewPropWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: vpColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    vp['icon'] as IconData,
                    color: vpColor,
                    size: 18,
                  ),
                ),
                if (i < viewProps.length - 1)
                  Container(
                    width: 2,
                    height: 20,
                    color: vpColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: vpColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: vpColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vp['prop'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: vpColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vp['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Rendering Pipeline
  // ============================================================
  print('=== Section 4: Pipeline ===');

  final pipelineSteps = <Map<String, dynamic>>[
    {
      'step': '1. Widget Build',
      'desc': 'The framework calls build() on widgets in this View\u0027s '
          'subtree. Elements are created or updated. Build phase '
          'only runs for dirty widgets marked during setState.',
      'color': Colors.indigo,
    },
    {
      'step': '2. Layout',
      'desc': 'Constraints flow down from the View\u0027s root render '
          'object. Each render object sizes itself and positions '
          'its children. The View\u0027s root gets tight constraints '
          'from the FlutterView\u0027s logical size.',
      'color': Colors.blue,
    },
    {
      'step': '3. Compositing Bits',
      'desc': 'The framework updates compositing needs. Render objects '
          'that require their own compositing layer (transforms, '
          'opacity) are marked. This prepares the paint phase.',
      'color': Colors.green,
    },
    {
      'step': '4. Paint',
      'desc': 'Render objects paint into a layer tree. Each paints '
          'relative to its parent\u0027s coordinate space. The '
          'result is a tree of Layer objects representing the '
          'visual output.',
      'color': Colors.orange,
    },
    {
      'step': '5. Compositing',
      'desc': 'The layer tree is flattened and sent to the engine\u0027s '
          'compositor. The compositor combines layers and sends '
          'the final frame to the platform\u0027s rendering system.',
      'color': Colors.purple,
    },
    {
      'step': '6. Rasterization',
      'desc': 'The engine rasterizes the composited frame onto the '
          'FlutterView\u0027s rendering surface via Skia or Impeller. '
          'The pixels appear on screen. Frame timing is tracked.',
      'color': Colors.red,
    },
  ];

  final pipelineWidgets = <Widget>[];
  for (var i = 0; i < pipelineSteps.length; i++) {
    final ps = pipelineSteps[i];
    final psColor = ps['color'] as Color;
    print('Pipeline ${i + 1}: ${ps['step']}');
    pipelineWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: psColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: psColor,
                      ),
                    ),
                  ),
                ),
                if (i < pipelineSteps.length - 1)
                  Container(
                    width: 2,
                    height: 22,
                    color: psColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: psColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: psColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ps['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: psColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ps['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: MediaQuery
  // ============================================================
  print('=== Section 5: MediaQuery ===');

  final mqTopics = <Map<String, dynamic>>[
    {
      'title': 'View-Scoped MediaQuery',
      'desc': 'Each View creates a MediaQuery for its subtree based on '
          'the FlutterView\u0027s properties. In multi-view apps, '
          'different views may have different MediaQuery values '
          '(e.g., different sizes or pixel ratios).',
      'color': Colors.indigo,
    },
    {
      'title': 'Size Adaptation',
      'desc': 'MediaQuery.of(context).size returns the logical size '
          'of the current View. Responsive layouts use this to adapt. '
          'In multi-view, each view adapts independently to its size.',
      'color': Colors.blue,
    },
    {
      'title': 'Safe Area',
      'desc': 'MediaQuery.of(context).padding represents safe area '
          'insets from the View\u0027s FlutterView. Views on different '
          'displays may have different safe areas (notch, rounded '
          'corners, navigation bars).',
      'color': Colors.green,
    },
    {
      'title': 'Keyboard Insets',
      'desc': 'MediaQuery.of(context).viewInsets reports keyboard '
          'overlap for this View. When the on-screen keyboard appears '
          'on one view, only that view\u0027s viewInsets change — '
          'other views in the collection are unaffected.',
      'color': Colors.orange,
    },
    {
      'title': 'Display Features',
      'desc': 'MediaQuery.of(context).displayFeatures lists physical '
          'display features like hinges and cutouts for this View\u0027s '
          'display. A foldable device may report a hinge feature.',
      'color': Colors.purple,
    },
  ];

  final mqWidgets = <Widget>[];
  for (var i = 0; i < mqTopics.length; i++) {
    final mq = mqTopics[i];
    final mqColor = mq['color'] as Color;
    print('MediaQuery ${i + 1}: ${mq['title']}');
    mqWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: mqColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mqColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: mqColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: mqColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mq['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: mqColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mq['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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
  // SECTION 6: Migration
  // ============================================================
  print('=== Section 6: Migration ===');

  final migrationRows = <Map<String, String>>[
    {
      'old': 'WidgetsBinding.instance.window',
      'new_': 'View.of(context)',
      'notes': 'Primary migration path. Replaces global singleton '
          'access with context-aware view lookup.',
    },
    {
      'old': 'window.physicalSize',
      'new_': 'View.of(context).physicalSize',
      'notes': 'Access the rendering surface\u0027s physical size '
          'through the nearest View ancestor.',
    },
    {
      'old': 'window.devicePixelRatio',
      'new_': 'View.of(context).devicePixelRatio',
      'notes': 'Per-view pixel ratio. Critical for multi-display '
          'setups where displays differ.',
    },
    {
      'old': 'window.padding',
      'new_': 'View.of(context).padding',
      'notes': 'Per-view system padding. Each window may have '
          'different safe area insets.',
    },
    {
      'old': 'window.viewInsets',
      'new_': 'View.of(context).viewInsets',
      'notes': 'Per-view keyboard and system UI insets. Only the '
          'focused view receives keyboard insets.',
    },
    {
      'old': 'MediaQueryData.fromWindow(window)',
      'new_': 'MediaQuery.of(context)',
      'notes': 'No manual construction needed. View widget creates '
          'MediaQuery automatically for its subtree.',
    },
  ];

  final migrationWidgets = <Widget>[];
  for (var i = 0; i < migrationRows.length; i++) {
    final mr = migrationRows[i];
    print('Migration ${i + 1}: ${mr['old']}');
    migrationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.04)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.close, color: Colors.red, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    mr['old']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.check, color: Colors.green, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    mr['new_']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              mr['notes']!,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Single App View',
      'desc': 'MaterialApp wraps content in a single View by default. '
          'This is the standard pattern for mobile apps. The '
          'implicit View targets the default FlutterView.',
      'icon': Icons.phone_android,
      'color': Colors.indigo,
    },
    {
      'title': 'Multi-View via ViewCollection',
      'desc': 'Disable wrapWithDefaultView and return a ViewCollection '
          'from the app builder. Each FlutterView from the platform '
          'dispatcher gets a View widget in the collection.',
      'icon': Icons.desktop_windows,
      'color': Colors.blue,
    },
    {
      'title': 'View + Inherited State',
      'desc': 'Place shared state providers above the View (or '
          'ViewCollection). State changes rebuild only the affected '
          'subtrees within specific views, not all views.',
      'icon': Icons.account_tree,
      'color': Colors.green,
    },
    {
      'title': 'View.of for Conditional Logic',
      'desc': 'Use View.of(context) to access FlutterView properties '
          'for conditional rendering. Different content for different '
          'pixel ratios, sizes, or display features.',
      'icon': Icons.rule,
      'color': Colors.orange,
    },
    {
      'title': 'View + ViewAnchor Overlay',
      'desc': 'Within a View, use ViewAnchor to attach secondary views '
          'for floating UI. The secondary views anchor to positions '
          'in the primary View\u0027s widget tree.',
      'icon': Icons.picture_in_picture,
      'color': Colors.purple,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    final pColor = p['color'] as Color;
    print('Pattern ${i + 1}: ${p['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  p['icon'] as IconData,
                  color: pColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: pColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.tv,
      'text': 'View wraps a FlutterView, establishing a complete '
          'rendering pipeline: build, layout, paint, compositing.',
    },
    {
      'icon': Icons.crop_square,
      'text': 'Provides MediaQuery to descendants based on the '
          'FlutterView\u0027s physical properties.',
    },
    {
      'icon': Icons.devices,
      'text': 'Enables multi-view apps via ViewCollection. Each View '
          'renders to a different display or window.',
    },
    {
      'icon': Icons.update,
      'text': 'View.of(context) replaces the deprecated '
          'WidgetsBinding.instance.window for accessing view properties.',
    },
    {
      'icon': Icons.foundation,
      'text': 'Every Flutter app has at least one View, typically '
          'created implicitly by MaterialApp or CupertinoApp.',
    },
    {
      'icon': Icons.layers,
      'text': 'Part of the multi-view architecture alongside '
          'ViewCollection and ViewAnchor.',
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
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
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
                color: Colors.indigo.shade800,
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
        title: const Text('View'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.tv), text: 'FlutterView'),
            Tab(icon: Icon(Icons.sync), text: 'Pipeline'),
            Tab(icon: Icon(Icons.crop_square), text: 'MediaQuery'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Migration'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
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
                  'View: the widget that wraps a FlutterView rendering '
                  'surface and establishes a rendering pipeline.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
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
                  'View API, static methods, and migration notes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
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
                  'FlutterView properties that define the rendering surface.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...viewPropWidgets,
            ],
          ),
          // Tab 4
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
                  'The six-phase rendering pipeline within a View.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...pipelineWidgets,
            ],
          ),
          // Tab 5
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
                  'View-scoped MediaQuery and per-view metrics.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...mqWidgets,
            ],
          ),
          // Tab 6
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
                  'Migrating from deprecated window to View.of(context).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...migrationWidgets,
            ],
          ),
          // Tab 7
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
                  'Common patterns for working with the View widget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),
          // Tab 8
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
                  'Key takeaways about the View widget.',
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
