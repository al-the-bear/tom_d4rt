// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SnapshotPainter
// Demonstrates the SnapshotPainter abstract class, which is used with
// SnapshotWidget to apply custom painting over a rasterized (cached) image
// of child widgets. This enables efficient visual effects like tinting,
// borders, overlays, and transformations on pre-rendered content.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnapshotPainter Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.camera,
      'title': 'What is SnapshotPainter?',
      'body': 'SnapshotPainter is an abstract class that works with '
          'SnapshotWidget. When a snapshot is active, the child widget tree '
          'is rasterized (drawn) into an image once, and SnapshotPainter\'s '
          'paintSnapshot method is called with that image on subsequent '
          'frames instead of rebuilding the entire child tree.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Benefits',
      'body': 'Rasterizing complex widget trees into a single image avoids '
          'the cost of laying out and painting dozens or hundreds of child '
          'widgets every frame. This is especially valuable during animations '
          'where only the snapshot effect changes, not the children.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.brush,
      'title': 'Custom Visual Effects',
      'body': 'By overriding paintSnapshot, you can apply any Canvas-level '
          'effect to the rasterized image: tinting, opacity changes, '
          'transforms (rotation, scale), filters, clipping, or drawing '
          'additional decorations around the captured content.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.architecture,
      'title': 'Painter Lifecycle',
      'body': 'SnapshotPainter extends ChangeNotifier. When the painter\'s '
          'state changes (e.g., tint color updates), call notifyListeners() '
          'to trigger a repaint. The shouldRepaint method determines if '
          'the snapshot image itself needs to be recaptured.',
      'accent': Colors.purple,
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
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
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
  // SECTION 2: API / Methods
  // ============================================================
  print('=== Section 2: API ===');

  final apiMethods = <Map<String, String>>[
    {
      'method': 'paint(context, offset, size, painter)',
      'returns': 'void',
      'desc': 'Called when the snapshot is NOT active or not available. '
          'Paints the child normally using PaintingContext. The default '
          'implementation simply delegates to context.paintChild.',
    },
    {
      'method': 'paintSnapshot(context, offset, size, image, sourceSize, pixelRatio)',
      'returns': 'void',
      'desc': 'Called when the snapshot IS active. Receives the rasterized '
          'ui.Image of the child tree. Override to apply visual effects '
          'like tinting, transforming, or decorating the cached image.',
    },
    {
      'method': 'shouldRepaint(oldPainter)',
      'returns': 'bool',
      'desc': 'Called when the painter is replaced. Return true if the new '
          'painter would produce different output than the old one. Similar '
          'to CustomPainter.shouldRepaint.',
    },
    {
      'method': 'addListener(listener)',
      'returns': 'void',
      'desc': 'Inherited from ChangeNotifier. Add a listener that is '
          'called when notifyListeners() is invoked. SnapshotWidget '
          'listens to trigger repaints.',
    },
    {
      'method': 'notifyListeners()',
      'returns': 'void',
      'desc': 'Call when the painter\'s visual state changes (e.g., tint '
          'color, opacity, border width). Triggers a repaint without '
          'recapturing the snapshot image.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiMethods.length; i++) {
    final m = apiMethods[i];
    print('API ${i + 1}: ${m['method']!.split('(')[0]}');
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      m['method']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
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
                    m['returns']!,
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
              m['desc']!,
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
  // SECTION 3: Basic — Conceptual pass-through
  // ============================================================
  print('=== Section 3: Basic ===');

  // Show the concept of snapshotting with a visual diagram
  final basicSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Child Widget Tree',
      'desc': 'A complex tree with dozens of widgets — columns, rows, '
          'images, text, icons, decorations. Normally repainted every frame.',
      'icon': Icons.account_tree,
      'color': Colors.blue,
    },
    {
      'step': '2',
      'label': 'Rasterize to Image',
      'desc': 'The entire child tree is painted once to an offscreen image '
          '(ui.Image). This captures the visual output as pixels.',
      'icon': Icons.camera_alt,
      'color': Colors.orange,
    },
    {
      'step': '3',
      'label': 'paintSnapshot Called',
      'desc': 'On subsequent frames, paintSnapshot receives this cached image. '
          'No need to rebuild or repaint the child tree.',
      'icon': Icons.brush,
      'color': Colors.green,
    },
    {
      'step': '4',
      'label': 'Apply Effects',
      'desc': 'Your custom SnapshotPainter can draw the image with '
          'modifications: tint, rotation, scale, opacity, borders.',
      'icon': Icons.auto_fix_high,
      'color': Colors.purple,
    },
  ];

  final basicCards = <Widget>[];
  for (var i = 0; i < basicSteps.length; i++) {
    final bs = basicSteps[i];
    final bColor = bs['color'] as Color;
    print('Step ${bs['step']}: ${bs['label']}');
    basicCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bColor.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  bs['step'] as String,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: bColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(bs['icon'] as IconData, color: bColor, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        bs['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: bColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bs['desc'] as String,
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

    // Arrow between steps
    if (i < basicSteps.length - 1) {
      basicCards.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Icon(
              Icons.arrow_downward,
              color: Colors.indigo.withOpacity(0.3),
              size: 20,
            ),
          ),
        ),
      );
    }
  }

  // ============================================================
  // SECTION 4: Tinting Example
  // ============================================================
  print('=== Section 4: Tinting ===');

  // Show various tint colors applied to content
  final tintColors = <Map<String, dynamic>>[
    {'name': 'No Tint (Original)', 'color': Colors.transparent, 'opacity': 0.0},
    {'name': 'Blue Tint', 'color': Colors.blue, 'opacity': 0.25},
    {'name': 'Amber Tint', 'color': Colors.amber, 'opacity': 0.3},
    {'name': 'Red Tint', 'color': Colors.red, 'opacity': 0.2},
    {'name': 'Green Tint', 'color': Colors.green, 'opacity': 0.2},
    {'name': 'Purple Overlay', 'color': Colors.purple, 'opacity': 0.35},
  ];

  final tintWidgets = <Widget>[];
  for (var i = 0; i < tintColors.length; i++) {
    final tc = tintColors[i];
    final tColor = tc['color'] as Color;
    final tOpacity = tc['opacity'] as double;
    print('Tint ${i + 1}: ${tc['name']}');
    tintWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tc['name'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: tColor == Colors.transparent
                    ? Colors.indigo
                    : tColor,
              ),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  // "Original" content being snapshotted
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade600,
                          Colors.blue.shade400,
                          Colors.cyan.shade300,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo, color: Colors.white.withOpacity(0.9)),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.music_note, color: Colors.white.withOpacity(0.9)),
                            Text(
                              'Music',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.video_library, color: Colors.white.withOpacity(0.9)),
                            Text(
                              'Video',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Tint overlay (simulates what paintSnapshot would do)
                  if (tOpacity > 0)
                    Container(
                      height: 80,
                      color: tColor.withOpacity(tOpacity),
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
  // SECTION 5: Border / Decoration Effects
  // ============================================================
  print('=== Section 5: Borders ===');

  final borderEffects = <Map<String, dynamic>>[
    {
      'name': 'Rounded Border',
      'desc': 'SnapshotPainter adds a rounded border around the cached '
          'image. Useful for card-like effects during transitions.',
      'borderColor': Colors.indigo,
      'borderWidth': 3.0,
      'borderRadius': 16.0,
      'shadow': false,
    },
    {
      'name': 'Shadow Effect',
      'desc': 'Draw a shadow behind the snapshot image. Simulates elevation '
          'changes during animations without repainting children.',
      'borderColor': Colors.transparent,
      'borderWidth': 0.0,
      'borderRadius': 12.0,
      'shadow': true,
    },
    {
      'name': 'Thick Colored Frame',
      'desc': 'A bold colored frame painted by paintSnapshot around the '
          'cached content. Great for focus/selection indicators.',
      'borderColor': Colors.deepOrange,
      'borderWidth': 5.0,
      'borderRadius': 8.0,
      'shadow': false,
    },
    {
      'name': 'Double Border',
      'desc': 'Outer and inner borders painted around the snapshot. '
          'Achieves complex frame effects without widget overhead.',
      'borderColor': Colors.teal,
      'borderWidth': 2.0,
      'borderRadius': 12.0,
      'shadow': false,
    },
  ];

  final borderCards = <Widget>[];
  for (var i = 0; i < borderEffects.length; i++) {
    final be = borderEffects[i];
    final beColor = be['borderColor'] as Color;
    final hasShadow = be['shadow'] as bool;
    final bWidth = be['borderWidth'] as double;
    final bRadius = be['borderRadius'] as double;
    print('Border ${i + 1}: ${be['name']}');
    borderCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              be['name'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: beColor == Colors.transparent
                    ? Colors.indigo
                    : beColor,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(bRadius),
                border: bWidth > 0
                    ? Border.all(color: beColor, width: bWidth)
                    : null,
                boxShadow: hasShadow
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  bRadius - (bWidth > 0 ? bWidth : 0),
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade700,
                        Colors.blue.shade500,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Snapshotted Content',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              be['desc'] as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: shouldRepaint Logic
  // ============================================================
  print('=== Section 6: shouldRepaint ===');

  final repaintScenarios = <Map<String, dynamic>>[
    {
      'scenario': 'Tint color changed',
      'result': 'true',
      'reason': 'The visual output differs because the overlay color is '
          'different. The snapshot image itself does not need to be '
          'recaptured, but paintSnapshot must be called again.',
      'icon': Icons.palette,
      'color': Colors.orange,
    },
    {
      'scenario': 'Same painter reused',
      'result': 'false',
      'reason': 'No visual change. Returning false skips the repaint entirely. '
          'This is an optimization — the framework can reuse the last frame.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'scenario': 'Border width changed',
      'result': 'true',
      'reason': 'The border around the snapshot image is thicker or thinner. '
          'Although the captured image is the same, the decoration differs.',
      'icon': Icons.border_style,
      'color': Colors.indigo,
    },
    {
      'scenario': 'Opacity threshold crossed',
      'result': 'true',
      'reason': 'The painter now draws the image at a different opacity. '
          'Even small opacity changes produce visible differences.',
      'icon': Icons.opacity,
      'color': Colors.purple,
    },
  ];

  final repaintWidgets = <Widget>[];
  for (var i = 0; i < repaintScenarios.length; i++) {
    final rs = repaintScenarios[i];
    final rColor = rs['color'] as Color;
    final isTrue = rs['result'] == 'true';
    print('Repaint ${i + 1}: ${rs['scenario']}');
    repaintWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: rColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: rColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(rs['icon'] as IconData, color: rColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        rs['scenario'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: rColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isTrue
                              ? Colors.red.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'returns ${rs['result']}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isTrue
                                ? Colors.red.shade700
                                : Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rs['reason'] as String,
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

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Page Transitions',
      'body': 'During a page transition, capture the outgoing page as a '
          'snapshot and animate it (scale, fade, rotate) without '
          'maintaining the entire widget tree of the old page.',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo,
    },
    {
      'title': 'Scroll Performance',
      'body': 'Complex list items can be snapshotted while scrolling fast. '
          'The user sees the cached image instead of re-rendering expensive '
          'widgets like charts or rich media layouts.',
      'icon': Icons.speed,
      'color': Colors.green,
    },
    {
      'title': 'Visual Feedback',
      'body': 'Apply a tint or border to a snapshot during drag operations, '
          'long presses, or focus changes. The visual feedback is cheap '
          'because it operates on a cached image.',
      'icon': Icons.touch_app,
      'color': Colors.orange,
    },
    {
      'title': 'Blur / Frosted Glass',
      'body': 'Capture content behind a panel, then paint the snapshot '
          'with a blur filter or reduced opacity to create frosted glass '
          'effects without using BackdropFilter.',
      'icon': Icons.blur_on,
      'color': Colors.blue,
    },
    {
      'title': 'Drag Preview',
      'body': 'When dragging a widget, use a snapshot as the drag feedback '
          'image. The original widget can be replaced while the snapshot '
          'follows the pointer, maintaining visual continuity.',
      'icon': Icons.drag_indicator,
      'color': Colors.purple,
    },
    {
      'title': 'Animation Freezing',
      'body': 'Freeze a widget tree at a specific frame while animating '
          'something else. The snapshot captures one moment, then you '
          'can animate the snapshot\'s position or opacity.',
      'icon': Icons.ac_unit,
      'color': Colors.cyan,
    },
  ];

  final useCaseCards = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('Use case ${i + 1}: ${uc['title']}');
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ucColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ucColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(uc['icon'] as IconData, color: ucColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ucColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uc['body'] as String,
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

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.camera,
      'text': 'SnapshotPainter is an abstract class that paints over a '
          'cached rasterized image of a child widget tree.',
    },
    {
      'icon': Icons.brush,
      'text': 'Override paintSnapshot to apply custom visual effects: tints, '
          'borders, transforms, opacity, and composite operations.',
    },
    {
      'icon': Icons.speed,
      'text': 'Major performance benefit: complex child trees are painted once '
          'to an image, then the image is reused on subsequent frames.',
    },
    {
      'icon': Icons.refresh,
      'text': 'Call notifyListeners() when the painter\'s visual state changes. '
          'Implement shouldRepaint to control when effects update.',
    },
    {
      'icon': Icons.widgets,
      'text': 'Works with SnapshotWidget. Set SnapshotWidget.painter to your '
          'custom SnapshotPainter subclass.',
    },
    {
      'icon': Icons.architecture,
      'text': 'Extends ChangeNotifier, so it follows the standard listener '
          'pattern. Dispose properly to avoid memory leaks.',
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
                color: Colors.indigo.shade700,
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
        title: const Text('SnapshotPainter'),
        backgroundColor: Colors.indigo.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.code), text: 'API'),
            Tab(icon: Icon(Icons.layers), text: 'Basic'),
            Tab(icon: Icon(Icons.palette), text: 'Tinting'),
            Tab(icon: Icon(Icons.border_style), text: 'Borders'),
            Tab(icon: Icon(Icons.refresh), text: 'Repaint'),
            Tab(icon: Icon(Icons.apps), text: 'Use Cases'),
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
                  'SnapshotPainter: an abstract class for painting custom '
                  'effects over a rasterized (cached) image of a child '
                  'widget tree, enabling efficient visual transformations.',
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
                  'Key methods of SnapshotPainter. The class extends '
                  'ChangeNotifier and provides paint/paintSnapshot hooks.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Basic
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
                  'How snapshotting works: widgets are rasterized to an '
                  'image, then the painter draws that image with effects.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...basicCards,
            ],
          ),

          // Tab 4: Tinting
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
                  'A common SnapshotPainter effect: applying a color tint '
                  'overlay to the cached image. Each example shows a '
                  'different tint color and opacity.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...tintWidgets,
            ],
          ),

          // Tab 5: Borders
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
                  'SnapshotPainter can draw borders, shadows, and frames '
                  'around the cached image for visual emphasis.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...borderCards,
            ],
          ),

          // Tab 6: shouldRepaint
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
                  'shouldRepaint controls whether the painter needs to '
                  'repaint when replaced. Return true when visual state '
                  'has changed.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...repaintWidgets,
            ],
          ),

          // Tab 7: Use Cases
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
                  'Real-world scenarios where SnapshotPainter provides '
                  'significant performance or visual benefits.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseCards,
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
                  'Key takeaways about SnapshotPainter.',
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
