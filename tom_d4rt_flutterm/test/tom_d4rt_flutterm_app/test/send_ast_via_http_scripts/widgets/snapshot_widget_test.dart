// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SnapshotWidget
// Demonstrates SnapshotWidget, which rasterizes its child tree into an image
// and delegates painting to a SnapshotPainter. This enables efficient visual
// effects on complex widget trees by caching the rendered output as pixels.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnapshotWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.camera_alt,
      'title': 'What is SnapshotWidget?',
      'body': 'SnapshotWidget is the widget-level entry point for Flutter\'s '
          'snapshotting system. It wraps a child widget tree, captures its '
          'visual output as a rasterized image (ui.Image), and hands that '
          'image to a SnapshotPainter for custom rendering.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.layers,
      'title': 'How It Works',
      'body': 'When snapshotting is active, the child tree is painted once '
          'to an offscreen surface. On subsequent frames, the cached image '
          'is drawn by the SnapshotPainter instead of repainting the '
          'entire subtree. The child tree stays in the widget and element '
          'tree but its paint is redirected.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.speed,
      'title': 'When to Use',
      'body': 'SnapshotWidget shines when a complex child tree needs to '
          'animate but its content does not change during the animation. '
          'Page transitions, drawer overlays, and drag previews are '
          'ideal use cases.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Limitations',
      'body': 'Platform views, texture widgets, and certain render objects '
          'cannot be rasterized. SnapshotWidget may fall back to normal '
          'painting in those cases depending on the SnapshotMode.',
      'accent': Colors.orange,
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
  // SECTION 2: Constructor / Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final propRows = <Map<String, String>>[
    {
      'param': 'painter',
      'type': 'SnapshotPainter',
      'desc': 'The painter that handles rendering. Its paintSnapshot method '
          'is called with the cached image. Its paint method is called when '
          'snapshotting is not active.',
    },
    {
      'param': 'mode',
      'type': 'SnapshotMode',
      'desc': 'Controls snapshot behavior. SnapshotMode.normal tries to '
          'snapshot and falls back to normal paint on failure. '
          'SnapshotMode.forced always snapshots (throws on failure). '
          'SnapshotMode.permissive skips un-rasterizable children.',
    },
    {
      'param': 'autoresize',
      'type': 'bool',
      'desc': 'When true (default), the snapshot is automatically '
          'recaptured when the child changes size. When false, the old '
          'image is stretched to the new size.',
    },
    {
      'param': 'child',
      'type': 'Widget',
      'desc': 'The widget tree to snapshot. Can be any widget — the '
          'entire subtree is rasterized as one image.',
    },
    {
      'param': 'controller',
      'type': 'SnapshotController',
      'desc': 'Controls when snapshotting is active. Call '
          'controller.allowSnapshotting = true/false to toggle.',
    },
  ];

  final propWidgets = <Widget>[];
  for (var i = 0; i < propRows.length; i++) {
    final row = propRows[i];
    print('Prop ${i + 1}: ${row['param']}');
    propWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
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
                    color: Colors.teal.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
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
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
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
  // SECTION 3: Basic Snapshot Demo
  // ============================================================
  print('=== Section 3: Basic ===');

  // Simulated snapshot of a complex card
  final basicCards = <Widget>[];
  final simStates = <Map<String, dynamic>>[
    {
      'label': 'Child Tree (Normal Paint)',
      'desc': 'When snapshotting is inactive, the child tree is painted '
          'normally. Every widget in the tree runs its paint method.',
      'isSnapshot': false,
      'color': Colors.teal,
    },
    {
      'label': 'Snapshot Active (Cached Image)',
      'desc': 'When snapshotting is active, the cached image is drawn. '
          'The visual output looks identical but the painting cost is '
          'just one drawImage call.',
      'isSnapshot': true,
      'color': Colors.blue,
    },
  ];

  for (var i = 0; i < simStates.length; i++) {
    final ss = simStates[i];
    final ssColor = ss['color'] as Color;
    print('State ${i + 1}: ${ss['label']}');
    basicCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  ss['isSnapshot'] as bool ? Icons.camera : Icons.widgets,
                  color: ssColor,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  ss['label'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ssColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // The "content" card that would be snapshotted
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ssColor.withOpacity(0.3),
                  width: ss['isSnapshot'] as bool ? 2.0 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ssColor.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ssColor, ssColor.withOpacity(0.6)],
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(Icons.person, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Complex Card Content',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.95),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '12 nested widgets',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (ss['isSnapshot'] as bool)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'CACHED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 8,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: ssColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.star, color: ssColor, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ss['desc'] as String,
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
  // SECTION 4: SnapshotMode
  // ============================================================
  print('=== Section 4: SnapshotMode ===');

  final modes = <Map<String, dynamic>>[
    {
      'name': 'SnapshotMode.normal',
      'behavior': 'Attempts to snapshot. If the child tree contains widgets '
          'that cannot be rasterized (e.g., platform views), falls back to '
          'normal painting transparently. No error thrown.',
      'icon': Icons.auto_mode,
      'color': Colors.teal,
      'fallback': 'Yes — silent',
    },
    {
      'name': 'SnapshotMode.forced',
      'behavior': 'Always captures a snapshot. If the child tree cannot be '
          'rasterized, throws an exception. Use when you need to guarantee '
          'the performance benefit of snapshotting.',
      'icon': Icons.lock,
      'color': Colors.red,
      'fallback': 'No — throws',
    },
    {
      'name': 'SnapshotMode.permissive',
      'behavior': 'Captures what it can, skips what it cannot. '
          'Un-rasterizable children are drawn directly on top of the '
          'snapshot. Useful when most of the tree is cacheable.',
      'icon': Icons.tune,
      'color': Colors.purple,
      'fallback': 'Partial — skips',
    },
  ];

  final modeWidgets = <Widget>[];
  for (var i = 0; i < modes.length; i++) {
    final m = modes[i];
    final mColor = m['color'] as Color;
    print('Mode ${i + 1}: ${m['name']}');
    modeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: mColor.withOpacity(0.04),
          border: Border.all(color: mColor.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: mColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(m['icon'] as IconData, color: mColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['name'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: mColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: mColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'Fallback: ${m['fallback']}',
                            style: TextStyle(
                              fontSize: 10,
                              color: mColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                m['behavior'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Auto-resize Behavior
  // ============================================================
  print('=== Section 5: Autoresize ===');

  final resizeCases = <Map<String, dynamic>>[
    {
      'title': 'autoresize: true (default)',
      'desc': 'When the child changes size, the snapshot is automatically '
          'recaptured at the new dimensions. This adds a one-frame cost '
          'but produces pixel-perfect output.',
      'visual': 'Fresh capture at new size',
      'icon': Icons.aspect_ratio,
      'color': Colors.teal,
    },
    {
      'title': 'autoresize: false',
      'desc': 'The old snapshot image is stretched to fill the new size. '
          'No recapture cost, but the image may look blurry or distorted '
          'if the size change is significant.',
      'visual': 'Stretched old image',
      'icon': Icons.photo_size_select_large,
      'color': Colors.orange,
    },
  ];

  final resizeWidgets = <Widget>[];
  for (var i = 0; i < resizeCases.length; i++) {
    final rc = resizeCases[i];
    final rcColor = rc['color'] as Color;
    print('Resize ${i + 1}: ${rc['title']}');

    // Visual comparison
    final isAutoResize = i == 0;
    resizeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: rcColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rcColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(rc['icon'] as IconData, color: rcColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    rc['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: rcColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Before/after size change
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: rcColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: rcColor.withOpacity(0.3)),
                      ),
                      child: Center(
                        child: Text(
                          'Original\n200x60',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: rcColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.arrow_forward,
                      color: rcColor.withOpacity(0.5),
                      size: 18,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: rcColor.withOpacity(isAutoResize ? 0.1 : 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: rcColor.withOpacity(0.3),
                          style: isAutoResize
                              ? BorderStyle.solid
                              : BorderStyle.none,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          isAutoResize
                              ? 'Recaptured\n320x80 (crisp)'
                              : 'Stretched\n320x80 (blurry)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: rcColor,
                            fontStyle: isAutoResize
                                ? FontStyle.normal
                                : FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                rc['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Painter Integration
  // ============================================================
  print('=== Section 6: Painter Integration ===');

  final integrationFlow = <Map<String, dynamic>>[
    {
      'label': 'Create Painter',
      'code': 'final painter = MySnapshotPainter(\n  tintColor: Colors.blue,\n);',
      'note': 'Subclass SnapshotPainter. Store visual parameters.',
      'color': Colors.teal,
    },
    {
      'label': 'Wrap with SnapshotWidget',
      'code': 'SnapshotWidget(\n  painter: painter,\n  child: complexContent,\n)',
      'note': 'Pass the painter to SnapshotWidget. The child is rasterized.',
      'color': Colors.blue,
    },
    {
      'label': 'paintSnapshot receives image',
      'code': 'void paintSnapshot(\n  context, offset, size,\n  image, sourceSize, pixelRatio,\n) {\n  context.canvas.drawImage(image, offset, Paint());\n}',
      'note': 'Your painter gets the cached image. Draw it with effects.',
      'color': Colors.purple,
    },
    {
      'label': 'Update painter state',
      'code': 'painter.tintColor = Colors.red;\n// notifyListeners() called internally',
      'note': 'Change visual state. notifyListeners triggers repaint.',
      'color': Colors.orange,
    },
  ];

  final integrationCards = <Widget>[];
  for (var i = 0; i < integrationFlow.length; i++) {
    final ifo = integrationFlow[i];
    final ifColor = ifo['color'] as Color;
    print('Integration ${i + 1}: ${ifo['label']}');
    integrationCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: ifColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ifColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ifColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ifColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ifo['label'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ifColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ifColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ifo['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: ifColor,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ifo['note'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Performance Simulation
  // ============================================================
  print('=== Section 7: Performance ===');

  // Show a visual comparison of paint costs
  final perfComparisons = <Map<String, dynamic>>[
    {
      'title': 'Without Snapshot',
      'widgets': 47,
      'paintMs': '8.2ms',
      'desc': 'Complex card with avatar, gradient, 3 text fields, 5 icons, '
          'action buttons. All 47 widgets repainted every frame during '
          'animation.',
      'color': Colors.red,
      'barWidth': 0.82,
    },
    {
      'title': 'With Snapshot',
      'widgets': 1,
      'paintMs': '0.4ms',
      'desc': 'Same visual output. One drawImage call. The 47 widgets '
          'were painted once to the cache. 20x faster paint on each '
          'subsequent frame.',
      'color': Colors.green,
      'barWidth': 0.04,
    },
  ];

  final perfWidgets = <Widget>[];
  for (var i = 0; i < perfComparisons.length; i++) {
    final pc = perfComparisons[i];
    final pcColor = pc['color'] as Color;
    print('Perf ${i + 1}: ${pc['title']}');
    perfWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pcColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pcColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  pc['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: pcColor,
                  ),
                ),
                const Spacer(),
                Text(
                  '${pc['widgets']} widget paints',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Paint time bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: pc['barWidth'] as double,
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: pcColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  pc['paintMs'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: pcColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              pc['desc'] as String,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.camera_alt,
      'text': 'SnapshotWidget captures its child tree as a rasterized image '
          'and delegates painting to a SnapshotPainter.',
    },
    {
      'icon': Icons.auto_mode,
      'text': 'SnapshotMode.normal (fallback), .forced (throw on failure), '
          'and .permissive (skip un-rasterizable) control behavior.',
    },
    {
      'icon': Icons.aspect_ratio,
      'text': 'autoresize: true recaptures when the child resizes. '
          'false stretches the cached image (faster but may blur).',
    },
    {
      'icon': Icons.speed,
      'text': 'Dramatic paint performance improvement for complex trees. '
          'One drawImage call replaces dozens of widget paints.',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Platform views and texture widgets cannot be rasterized. '
          'Use permissive mode to handle mixed content gracefully.',
    },
    {
      'icon': Icons.architecture,
      'text': 'SnapshotWidget + SnapshotPainter form a pair. The widget '
          'manages capture, the painter handles rendering effects.',
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
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal.shade700,
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
        title: const Text('SnapshotWidget'),
        backgroundColor: Colors.teal.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Properties'),
            Tab(icon: Icon(Icons.camera_alt), text: 'Basic'),
            Tab(icon: Icon(Icons.auto_mode), text: 'Mode'),
            Tab(icon: Icon(Icons.aspect_ratio), text: 'Resize'),
            Tab(icon: Icon(Icons.link), text: 'Integration'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
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
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SnapshotWidget: capture a complex child tree as a '
                  'rasterized image for efficient re-rendering with '
                  'custom visual effects via SnapshotPainter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Properties
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor properties of SnapshotWidget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...propWidgets,
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
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The same complex card painted in two modes: normal '
                  'widget painting vs cached snapshot painting.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...basicCards,
            ],
          ),

          // Tab 4: Mode
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SnapshotMode controls how the widget handles content '
                  'that cannot be rasterized.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...modeWidgets,
            ],
          ),

          // Tab 5: Resize
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How autoresize affects snapshot quality when the '
                  'child widget changes dimensions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...resizeWidgets,
            ],
          ),

          // Tab 6: Integration
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How SnapshotWidget and SnapshotPainter work together '
                  'in practice, step by step.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...integrationCards,
            ],
          ),

          // Tab 7: Performance
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Paint cost comparison: complex tree vs cached snapshot.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...perfWidgets,
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
                      Colors.teal.withOpacity(0.12),
                      Colors.green.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about SnapshotWidget.',
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
