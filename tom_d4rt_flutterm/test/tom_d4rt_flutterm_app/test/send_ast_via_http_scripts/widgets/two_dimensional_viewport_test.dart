// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TwoDimensionalViewport
// Demonstrates TwoDimensionalViewport, the RenderObject-backed widget
// that performs 2D layout of children, managing creation, positioning,
// painting, and disposal of cells as they scroll into and out of view.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalViewport Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.view_quilt,
      'title': 'What is TwoDimensionalViewport?',
      'body': 'TwoDimensionalViewport is the lowest layer in the 2D '
          'scrolling stack. It is the actual RenderObject that '
          'determines which cells are visible, builds them via the '
          'delegate, positions them, and paints them.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.visibility,
      'title': 'Visible Region',
      'body': 'Given horizontal and vertical scroll offsets plus the '
          'viewport dimensions, the viewport computes a rectangular '
          'region. Only cells overlapping this region are built and '
          'rendered. Everything else is garbage collected.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.recycling,
      'title': 'Child Lifecycle',
      'body': 'As the user scrolls, new cells enter the visible region '
          'and old ones leave. The viewport creates new children on '
          'entry and disposes them on exit. This keeps memory constant '
          'regardless of total grid size.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.brush,
      'title': 'Paint and Composite',
      'body': 'The viewport paints children in a deterministic order. '
          'Each child is positioned at its layout offset. The '
          'viewport clips content that extends beyond its bounds '
          'based on the clipBehavior setting.',
      'accent': Colors.orange,
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
      'name': 'horizontalOffset',
      'type': 'ViewportOffset',
      'desc': 'The horizontal scroll position. The viewport reads '
          '.pixels to determine horizontal offset and listens for '
          'changes to trigger relayout.',
    },
    {
      'name': 'verticalOffset',
      'type': 'ViewportOffset',
      'desc': 'The vertical scroll position. Same as horizontalOffset '
          'but for the vertical axis. Together they define the '
          'visible rectangle in content space.',
    },
    {
      'name': 'delegate',
      'type': 'TwoDimensionalChildDelegate',
      'desc': 'Provides children (cells) for given ChildVicinity '
          'coordinates. The viewport calls the delegate to build '
          'cells that enter the visible region.',
    },
    {
      'name': 'mainAxis',
      'type': 'Axis',
      'desc': 'Primary axis for layout iteration. Axis.vertical means '
          'rows are laid out first, then columns within each row. '
          'Determines traversal order for the layout algorithm.',
    },
    {
      'name': 'cacheExtent',
      'type': 'double',
      'desc': 'Extra pixels around the viewport to pre-render. Cells '
          'within cacheExtent of the visible edge are kept alive '
          'even though they are not visible. Improves scroll smoothness.',
    },
    {
      'name': 'clipBehavior',
      'type': 'Clip',
      'desc': 'How to clip children that extend beyond the viewport '
          'boundaries: Clip.none (no clipping, possible overflow), '
          'Clip.hardEdge, Clip.antiAlias, or Clip.antiAliasWithSaveLayer.',
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
              ? Colors.deepPurple.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.25)),
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
                    color: Colors.deepPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade800,
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
  // SECTION 3: Cell Lifecycle
  // ============================================================
  print('=== Section 3: Cell Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1. Request Cell',
      'desc': 'During layout, the viewport determines cell (x,y) should '
          'be visible. It asks the delegate to build the widget for '
          'ChildVicinity(xIndex: x, yIndex: y).',
      'icon': Icons.add_box,
      'color': Colors.deepPurple,
    },
    {
      'step': '2. Build Widget',
      'desc': 'The delegate calls its builder function which returns a '
          'widget tree for the cell. This widget is inflated into '
          'an Element with a RenderBox.',
      'icon': Icons.build,
      'color': Colors.blue,
    },
    {
      'step': '3. Layout Cell',
      'desc': 'The viewport gives the cell RenderBox constraints '
          '(typically the cell size). The cell lays itself out. '
          'The viewport records the cell size and position.',
      'icon': Icons.square_foot,
      'color': Colors.green,
    },
    {
      'step': '4. Paint Cell',
      'desc': 'The viewport paints all visible cells at their calculated '
          'offsets relative to the viewport origin. Paint order '
          'follows the layout iteration order.',
      'icon': Icons.brush,
      'color': Colors.orange,
    },
    {
      'step': '5. Scroll Away',
      'desc': 'When the user scrolls and a cell exits the visible region '
          '(plus cache extent), the viewport marks it for disposal. '
          'The element is unmounted and the widget tree freed.',
      'icon': Icons.delete_sweep,
      'color': Colors.red,
    },
    {
      'step': '6. Garbage Collect',
      'desc': 'At the end of each layout pass, cells no longer in the '
          'visible+cache region are collected. Their RenderBoxes are '
          'removed and memory is freed.',
      'icon': Icons.recycling,
      'color': Colors.grey,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final ls = lifecycleSteps[i];
    final lsColor = ls['color'] as Color;
    print('Lifecycle ${i + 1}: ${ls['step']}');
    lifecycleWidgets.add(
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
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 18,
                  ),
                ),
                if (i < lifecycleSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ls['desc'] as String,
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
  // SECTION 4: Visible Region
  // ============================================================
  print('=== Section 4: Visible Region ===');

  // Build a visual representation of a viewport window over a grid
  final gridSize = 6;
  final viewportStartX = 1;
  final viewportEndX = 3;
  final viewportStartY = 1;
  final viewportEndY = 3;

  final gridRows = <Widget>[];
  for (var y = 0; y < gridSize; y++) {
    final cells = <Widget>[];
    for (var x = 0; x < gridSize; x++) {
      final isVisible = x >= viewportStartX && x <= viewportEndX &&
          y >= viewportStartY && y <= viewportEndY;
      final isCache = !isVisible &&
          x >= viewportStartX - 1 && x <= viewportEndX + 1 &&
          y >= viewportStartY - 1 && y <= viewportEndY + 1;
      Color bgColor;
      if (isVisible) {
        bgColor = Colors.deepPurple.withOpacity(0.2);
      } else if (isCache) {
        bgColor = Colors.deepPurple.withOpacity(0.08);
      } else {
        bgColor = Colors.grey.withOpacity(0.04);
      }
      cells.add(
        Container(
          width: 44,
          height: 34,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: isVisible
                  ? Colors.deepPurple.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.2),
              width: isVisible ? 1.5 : 0.5,
            ),
          ),
          child: Center(
            child: Text(
              '($x,$y)',
              style: TextStyle(
                fontSize: 9,
                color: isVisible
                    ? Colors.deepPurple.shade800
                    : (isCache ? Colors.deepPurple.shade400 : Colors.grey),
                fontWeight: isVisible ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }
    gridRows.add(Row(children: cells));
  }
  print('Built visible region grid: ${gridSize}x$gridSize');

  final regionExplanations = <Map<String, dynamic>>[
    {
      'label': 'Visible',
      'desc': 'Cells within the viewport bounds. Fully built, laid out, '
          'and painted. The user can see these.',
      'color': Colors.deepPurple.withOpacity(0.2),
      'border': Colors.deepPurple,
    },
    {
      'label': 'Cached',
      'desc': 'Cells within cacheExtent of the viewport. Built and laid '
          'out but not painted. Ready for immediate display on scroll.',
      'color': Colors.deepPurple.withOpacity(0.08),
      'border': Colors.grey,
    },
    {
      'label': 'Outside',
      'desc': 'Cells beyond the cache extent. Not built, no memory used. '
          'Will be created on demand when they enter the cache zone.',
      'color': Colors.grey.withOpacity(0.04),
      'border': Colors.grey,
    },
  ];

  final regionWidgets = <Widget>[];
  for (final re in regionExplanations) {
    regionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: re['color'] as Color,
                border: Border.all(color: re['border'] as Color),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    re['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    re['desc'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      height: 1.3,
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
  // SECTION 5: Paint Order
  // ============================================================
  print('=== Section 5: Paint Order ===');

  final paintTopics = <Map<String, dynamic>>[
    {
      'title': 'Row-Major Order (Axis.vertical)',
      'desc': 'When mainAxis is Axis.vertical, the viewport iterates by '
          'rows first. Within each row, cells are painted left-to-right. '
          'Later rows paint on top of earlier rows.',
      'diagram': 'Paint order:\n'
          '  Row 0: (0,0) \u2192 (1,0) \u2192 (2,0)\n'
          '  Row 1: (0,1) \u2192 (1,1) \u2192 (2,1)\n'
          '  Row 2: (0,2) \u2192 (1,2) \u2192 (2,2)\n'
          '\n'
          '  (2,2) is painted last = topmost',
      'color': Colors.deepPurple,
    },
    {
      'title': 'Column-Major Order (Axis.horizontal)',
      'desc': 'When mainAxis is Axis.horizontal, the viewport iterates by '
          'columns first. Within each column, cells are painted '
          'top-to-bottom. Later columns paint on top.',
      'diagram': 'Paint order:\n'
          '  Col 0: (0,0) \u2192 (0,1) \u2192 (0,2)\n'
          '  Col 1: (1,0) \u2192 (1,1) \u2192 (1,2)\n'
          '  Col 2: (2,0) \u2192 (2,1) \u2192 (2,2)\n'
          '\n'
          '  (2,2) is painted last = topmost',
      'color': Colors.blue,
    },
    {
      'title': 'Overlapping Cells',
      'desc': 'If cells overlap (negative margins, custom positioning), '
          'the paint order determines which cell appears on top. '
          'There is no z-index control within the viewport itself.',
      'diagram': 'If Cell A overlaps Cell B:\n'
          '  A painted first \u2192 B appears on top\n'
          '  B painted first \u2192 A appears on top\n'
          '\n'
          '  Control via mainAxis + cell ordering',
      'color': Colors.green,
    },
  ];

  final paintWidgets = <Widget>[];
  for (var i = 0; i < paintTopics.length; i++) {
    final pt = paintTopics[i];
    final ptColor = pt['color'] as Color;
    print('Paint ${i + 1}: ${pt['title']}');
    paintWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pt['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ptColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                pt['desc'] as String,
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
                  pt['diagram'] as String,
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
  // SECTION 6: Cache Extent
  // ============================================================
  print('=== Section 6: Cache ===');

  final cacheItems = <Map<String, dynamic>>[
    {
      'title': 'Default Cache',
      'desc': 'By default, the cache extent is 250 logical pixels '
          'in each direction. Cells within 250px of the visible '
          'edge are pre-built but not painted.',
      'metric': '250px default',
      'color': Colors.deepPurple,
    },
    {
      'title': 'Zero Cache',
      'desc': 'Setting cacheExtent to 0.0 means only strictly visible '
          'cells are built. Scrolling may stutter as new cells '
          'are built just-in-time.',
      'metric': 'Minimum memory, stuttery scroll',
      'color': Colors.red,
    },
    {
      'title': 'Large Cache',
      'desc': 'A large cache extent (1000+px) pre-builds many cells. '
          'Scrolling is buttery smooth but uses more memory and '
          'initial build time is longer.',
      'metric': 'Smooth scroll, more memory',
      'color': Colors.green,
    },
    {
      'title': 'Bidirectional Cache',
      'desc': 'Unlike 1D viewports with cache along one axis, the '
          '2D viewport caches in all four directions: left, right, '
          'top, and bottom of the visible region.',
      'metric': '4-directional pre-render',
      'color': Colors.blue,
    },
  ];

  final cacheWidgets = <Widget>[];
  for (var i = 0; i < cacheItems.length; i++) {
    final ci = cacheItems[i];
    final ciColor = ci['color'] as Color;
    print('Cache ${i + 1}: ${ci['title']}');
    cacheWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ciColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ciColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ci['title'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: ciColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ciColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ci['metric'] as String,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: ciColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ci['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Clip Behavior
  // ============================================================
  print('=== Section 7: Clip Behavior ===');

  final clipModes = <Map<String, dynamic>>[
    {
      'name': 'Clip.hardEdge',
      'desc': 'Sharp rectangular clip at the viewport boundary. '
          'Cheapest clip operation. Edges may show aliasing artifacts '
          'on diagonal content.',
      'cost': 'Low',
      'quality': 'Basic',
      'color': Colors.deepPurple,
    },
    {
      'name': 'Clip.antiAlias',
      'desc': 'Anti-aliased clip that smooths edges. Slightly more '
          'expensive than hardEdge but much better visual quality, '
          'especially for rounded viewport corners.',
      'cost': 'Medium',
      'quality': 'Good',
      'color': Colors.blue,
    },
    {
      'name': 'Clip.antiAliasWithSaveLayer',
      'desc': 'Highest quality clip with a separate layer for compositing. '
          'Needed when content has transparency that must not leak. '
          'Most expensive option.',
      'cost': 'High',
      'quality': 'Best',
      'color': Colors.green,
    },
    {
      'name': 'Clip.none',
      'desc': 'No clipping at all. Content can render outside the viewport '
          'boundary. Useful for debugging or when you know content '
          'will never overflow.',
      'cost': 'Zero',
      'quality': 'N/A',
      'color': Colors.red,
    },
  ];

  final clipWidgets = <Widget>[];
  for (var i = 0; i < clipModes.length; i++) {
    final cm = clipModes[i];
    final cmColor = cm['color'] as Color;
    print('Clip ${i + 1}: ${cm['name']}');
    clipWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cmColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cmColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: cmColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    cm['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cmColor,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Cost: ${cm['cost']}  Quality: ${cm['quality']}',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              cm['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
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
      'icon': Icons.view_quilt,
      'text': 'TwoDimensionalViewport is the render layer that performs '
          '2D layout, builds visible cells, and paints them.',
    },
    {
      'icon': Icons.recycling,
      'text': 'Cells are created on entry and disposed on exit. Memory '
          'usage is proportional to visible cells, not total grid size.',
    },
    {
      'icon': Icons.visibility,
      'text': 'The visible region is computed from scroll offsets plus '
          'viewport dimensions. Cache extent expands the built zone.',
    },
    {
      'icon': Icons.layers,
      'text': 'Paint order follows mainAxis iteration: row-major for '
          'Axis.vertical, column-major for Axis.horizontal.',
    },
    {
      'icon': Icons.content_cut,
      'text': 'clipBehavior controls edge treatment from no clipping '
          'to high-quality anti-aliased save layers.',
    },
    {
      'icon': Icons.architecture,
      'text': 'The viewport is built by TwoDimensionalScrollable through '
          'the viewportBuilder callback with both ViewportOffsets.',
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
          color: Colors.deepPurple.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepPurple.shade800,
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
        title: const Text('TwoDimensionalViewport'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.recycling), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.visibility), text: 'Visible'),
            Tab(icon: Icon(Icons.layers), text: 'Paint'),
            Tab(icon: Icon(Icons.cached), text: 'Cache'),
            Tab(icon: Icon(Icons.content_cut), text: 'Clipping'),
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TwoDimensionalViewport: the render layer that builds, '
                  'positions, paints, and recycles cells in 2D space.',
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor parameters and configuration.',
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How cells are created, laid out, painted, and disposed.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the viewport computes which cells to render.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.deepPurple.withOpacity(0.3),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(children: gridRows),
                ),
              ),
              ...regionWidgets,
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the order of cell painting is determined.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...paintWidgets,
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Cache extent: pre-rendering cells beyond the viewport.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...cacheWidgets,
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How content at viewport edges is clipped.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...clipWidgets,
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
                      Colors.deepPurple.withOpacity(0.12),
                      Colors.purple.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TwoDimensionalViewport.',
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
