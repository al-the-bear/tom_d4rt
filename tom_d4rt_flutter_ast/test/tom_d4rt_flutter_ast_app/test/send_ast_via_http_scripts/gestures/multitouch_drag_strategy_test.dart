// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Tests MultitouchDragStrategy from gestures
// Deep Demo: Visual demonstration of multi-touch drag aggregation strategies
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SECTION 0: Snapshot of enum values (header data)
  // ============================================================
  final allValues = MultitouchDragStrategy.values;
  final strategyCount = allValues.length;
  final firstStrategy = allValues.first;
  final lastStrategy = allValues.last;

  // Each enum value gets a rich descriptor used through the demo.
  final strategyMeta = <Map<String, Object>>[
    {
      'value': MultitouchDragStrategy.latestPointer,
      'glyph': Icons.touch_app,
      'short': 'Latest',
      'subtitle': 'Track only the most recent finger',
      'paletteA': Color(0xFF1E88E5),
      'paletteB': Color(0xFF26C6DA),
      'paletteC': Color(0xFFB3E5FC),
      'tagline': 'One pointer wins — the newest active one steers the drag.',
      'longCopy':
          'When set to latestPointer, the recognizer ignores motion from any '
          'pointer that is not the most recently accepted. Older fingers are '
          'kept on record but contribute no delta. This is the historical '
          'Flutter behavior and the safe default for single-handed scrolling.',
      'aggregation': 'delta = motion(latest)',
      'whenToUse': 'Lists, scrollables, single-finger UX, low-noise drags.',
      'pitfall': 'Switching the active finger mid-drag can feel jumpy.',
      'fingers': <double>[0.0, 0.0, 1.0],
    },
    {
      'value': MultitouchDragStrategy.averageBoundaryPointers,
      'glyph': Icons.center_focus_strong,
      'short': 'Boundary Avg',
      'subtitle': 'Average the extreme pointers per axis',
      'paletteA': Color(0xFF6A1B9A),
      'paletteB': Color(0xFFAB47BC),
      'paletteC': Color(0xFFE1BEE7),
      'tagline':
          'The boundary fingers (min/max per axis) are averaged each frame.',
      'longCopy':
          'averageBoundaryPointers tracks every active pointer but only the '
          'two extremes per axis influence the resolved delta. The recognizer '
          'computes the mean of those boundary deltas inside one frame, '
          'producing a smooth motion that resists outliers in the middle.',
      'aggregation': 'delta = mean(min_axis, max_axis)',
      'whenToUse': 'Two-handed pan/zoom, maps, large canvas surfaces.',
      'pitfall': 'Requires per-frame batching; not ideal under heavy jank.',
      'fingers': <double>[1.0, 0.5, 1.0],
    },
    {
      'value': MultitouchDragStrategy.sumAllPointers,
      'glyph': Icons.merge_type,
      'short': 'Sum All',
      'subtitle': 'Sum the deltas of every active pointer',
      'paletteA': Color(0xFFE65100),
      'paletteB': Color(0xFFFF7043),
      'paletteC': Color(0xFFFFCCBC),
      'tagline': 'Every finger adds its delta — the surface flies fast.',
      'longCopy':
          'sumAllPointers adds together the per-frame motion of every accepted '
          'pointer. Two fingers moving together effectively double the drag '
          'speed; three fingers triple it. This matches certain accessibility '
          'gestures and "express" scrolling behaviors on web/desktop.',
      'aggregation': 'delta = Σ motion(pointer_i)',
      'whenToUse': 'Express scroll, accessibility multipliers, kiosk surfaces.',
      'pitfall':
          'Velocity is multiplicative — easy to overshoot on small screens.',
      'fingers': <double>[1.0, 1.0, 1.0],
    },
  ];

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final heroHeader = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D47A1),
          Color(0xFF512DA8),
          Color(0xFFAD1457),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF311B92).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white24, Colors.white10],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.25),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(Icons.fingerprint, size: 56.0, color: Colors.white),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MultitouchDragStrategy',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'How DragGestureRecognizer aggregates many fingers',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _heroChip('package:flutter/gestures.dart', Icons.inventory_2),
            _heroChip('$strategyCount values', Icons.list_alt),
            _heroChip('first: ${firstStrategy.name}', Icons.first_page),
            _heroChip('last: ${lastStrategy.name}', Icons.last_page),
            _heroChip('default: latestPointer', Icons.flag),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy diagram of how strategies plug into
  // DragGestureRecognizer
  // ============================================================
  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF7E57C2), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF7E57C2).withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF4527A0), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a multi-touch drag',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _anatomyNode(
              'Pointer events',
              'PointerDown/Move/Up reach the recognizer.',
              Icons.fiber_manual_record,
              Color(0xFF1E88E5),
            ),
            _anatomyArrow(Color(0xFF1E88E5)),
            _anatomyNode(
              'DragGestureRecognizer',
              'Filters pointers and accepts the gesture.',
              Icons.gesture,
              Color(0xFF8E24AA),
            ),
            _anatomyArrow(Color(0xFF8E24AA)),
            _anatomyNode(
              'Strategy',
              'latest / boundary-avg / sum decide delta.',
              Icons.tune,
              Color(0xFFD81B60),
            ),
            _anatomyArrow(Color(0xFFD81B60)),
            _anatomyNode(
              'onUpdate',
              'Final delta drives ScrollPosition.',
              Icons.swipe,
              Color(0xFFEF6C00),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepPurple.shade100, width: 1.0),
          ),
          child: Text(
            'The strategy is consulted inside _shouldTrackMoveEvent and '
            '_resolveLocalDeltaForMultitouch. It does not filter which '
            'pointers are accepted by the gesture arena — it only changes '
            'how their motion is combined into the drag delta you observe '
            'from onUpdate callbacks.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.deepPurple.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (one big card per enum entry)
  // ============================================================
  final perValueCards = <Widget>[];
  for (final meta in strategyMeta) {
    final value = meta['value'] as MultitouchDragStrategy;
    final glyph = meta['glyph'] as IconData;
    final paletteA = meta['paletteA'] as Color;
    final paletteB = meta['paletteB'] as Color;
    final paletteC = meta['paletteC'] as Color;
    final fingers = meta['fingers'] as List<double>;

    perValueCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [paletteA, paletteB],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: paletteA.withValues(alpha: 0.45),
              blurRadius: 18.0,
              offset: Offset(0.0, 10.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Icon(glyph, size: 36.0, color: Colors.white),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.name,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        meta['subtitle'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'index ${value.index}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meta['tagline'] as String,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 13.0,
                      color: paletteA,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    meta['longCopy'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              children: [
                Expanded(
                  child: _strategyMetricBlock(
                    'aggregation',
                    meta['aggregation'] as String,
                    Icons.functions,
                    paletteC,
                    paletteA,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _strategyMetricBlock(
                    'use it for',
                    meta['whenToUse'] as String,
                    Icons.check_circle,
                    paletteC,
                    paletteA,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _strategyMetricBlock(
              'watch out',
              meta['pitfall'] as String,
              Icons.warning_amber,
              paletteC,
              paletteA,
            ),
            SizedBox(height: 14.0),
            // Visual three-finger weighting strip
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Text(
                    'finger weights',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  for (var i = 0; i < fingers.length; i++) ...[
                    _fingerWeightBadge(i + 1, fingers[i]),
                    SizedBox(width: 6.0),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: "Recipes" — short snippets showing how to wire the
  // strategy into a recognizer.
  // ============================================================
  final recipesSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF80CBC4), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                color: Color(0xFF80CBC4),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeRecipe(
          '// Latest pointer (default scrollable behavior)',
          'final r = HorizontalDragGestureRecognizer()\n'
              '  ..multitouchDragStrategy = MultitouchDragStrategy.latestPointer;',
          Color(0xFF81D4FA),
        ),
        SizedBox(height: 12.0),
        _codeRecipe(
          '// Boundary average — smooth two-handed pan',
          'final r = PanGestureRecognizer()\n'
              '  ..multitouchDragStrategy =\n'
              '      MultitouchDragStrategy.averageBoundaryPointers;',
          Color(0xFFCE93D8),
        ),
        SizedBox(height: 12.0),
        _codeRecipe(
          '// Sum all — express scrolling',
          'final r = VerticalDragGestureRecognizer()\n'
              '  ..multitouchDragStrategy = MultitouchDragStrategy.sumAllPointers;',
          Color(0xFFFFAB91),
        ),
        SizedBox(height: 12.0),
        _codeRecipe(
          '// Switch dynamically based on a feature flag',
          'recognizer.multitouchDragStrategy = useExpress\n'
              '    ? MultitouchDragStrategy.sumAllPointers\n'
              '    : MultitouchDragStrategy.latestPointer;',
          Color(0xFFFFE082),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Multi-finger scenarios — visualize three fingers
  // with three different deltas and show what each strategy yields.
  // ============================================================
  final scenarioFingers = <Map<String, Object>>[
    {'label': 'F1', 'dx': 6.0, 'dy': 0.0, 'color': Color(0xFFEF5350)},
    {'label': 'F2', 'dx': 14.0, 'dy': 0.0, 'color': Color(0xFFAB47BC)},
    {'label': 'F3', 'dx': 22.0, 'dy': 0.0, 'color': Color(0xFF26A69A)},
  ];

  double latestOf(List<Map<String, Object>> fs) =>
      fs.last['dx'] as double; // last accepted
  double boundaryOf(List<Map<String, Object>> fs) {
    final dxs = fs.map((f) => f['dx'] as double).toList()..sort();
    return (dxs.first + dxs.last) / 2.0;
  }

  double sumOf(List<Map<String, Object>> fs) =>
      fs.fold<double>(0.0, (acc, f) => acc + (f['dx'] as double));

  final scenarioRows = <Map<String, Object>>[
    {
      'name': 'latestPointer',
      'value': latestOf(scenarioFingers),
      'palette': Color(0xFF1E88E5),
    },
    {
      'name': 'averageBoundaryPointers',
      'value': boundaryOf(scenarioFingers),
      'palette': Color(0xFF8E24AA),
    },
    {
      'name': 'sumAllPointers',
      'value': sumOf(scenarioFingers),
      'palette': Color(0xFFE65100),
    },
  ];

  final scenarioSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFFDE7), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFFFB74D), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFB74D).withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science, color: Color(0xFFE65100), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Scenario: three fingers moving right at different speeds',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Finger track
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFFCC80), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final f in scenarioFingers)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Container(
                        width: 26.0,
                        height: 26.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: f['color'] as Color,
                          boxShadow: [
                            BoxShadow(
                              color: (f['color'] as Color).withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 6.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            f['label'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: ((f['dx'] as double) / 30.0).clamp(
                              0.05,
                              1.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    f['color'] as Color,
                                    (f['color'] as Color).withValues(
                                      alpha: 0.6,
                                    ),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: (f['color'] as Color).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          'dx ${(f['dx'] as double).toStringAsFixed(1)}px',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: f['color'] as Color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        // Resolved deltas per strategy
        for (final row in scenarioRows)
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (row['palette'] as Color).withValues(alpha: 0.18),
                  (row['palette'] as Color).withValues(alpha: 0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: (row['palette'] as Color).withValues(alpha: 0.55),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: row['palette'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10.0),
                SizedBox(
                  width: 220.0,
                  child: Text(
                    row['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: row['palette'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor:
                          ((row['value'] as double) / sumOf(scenarioFingers))
                              .clamp(0.02, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: row['palette'] as Color,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: row['palette'] as Color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Δ ${(row['value'] as double).toStringAsFixed(1)}px',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pitfalls — anti-patterns and traps
  // ============================================================
  final pitfalls = <Map<String, Object>>[
    {
      'title': 'Express scroll on tiny viewport',
      'body':
          'sumAllPointers + small list = items fly past. Cap pointer count '
          'or downgrade to latestPointer on phones.',
      'icon': Icons.warning,
      'palette': Color(0xFFE53935),
    },
    {
      'title': 'Boundary jitter near rest',
      'body':
          'averageBoundaryPointers can ping-pong if two fingers oscillate at '
          'sub-pixel deltas. Combine with a velocity threshold.',
      'icon': Icons.show_chart,
      'palette': Color(0xFF8E24AA),
    },
    {
      'title': 'Switching strategy mid-drag',
      'body':
          'Mutating multitouchDragStrategy while a drag is active resets the '
          'internal pointer bookkeeping and produces a visible "snap".',
      'icon': Icons.swap_horiz,
      'palette': Color(0xFFEF6C00),
    },
    {
      'title': 'Mismatched recognizer pair',
      'body':
          'A horizontal recognizer with sumAllPointers next to a vertical one '
          'with latestPointer creates inconsistent gesture feel.',
      'icon': Icons.compare_arrows,
      'palette': Color(0xFF00838F),
    },
  ];

  final pitfallsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFEBEE), Color(0xFFFFF3E0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE57373), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFE57373).withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem, color: Color(0xFFC62828), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & anti-patterns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC62828),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final p in pitfalls)
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: (p['palette'] as Color).withValues(alpha: 0.5),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: (p['palette'] as Color).withValues(alpha: 0.18),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: (p['palette'] as Color).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    p['icon'] as IconData,
                    color: p['palette'] as Color,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                          color: p['palette'] as Color,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        p['body'] as String,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade800,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison table — at-a-glance row per strategy.
  // ============================================================
  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF311B92)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    child: Row(
      children: [
        _tableHeader('value', 200.0),
        _tableHeader('aggregation', 220.0),
        _tableHeader('best for', 220.0),
        _tableHeader('idx', 50.0),
      ],
    ),
  );

  final comparisonRows = <Widget>[];
  for (var i = 0; i < strategyMeta.length; i++) {
    final meta = strategyMeta[i];
    final value = meta['value'] as MultitouchDragStrategy;
    final paletteA = meta['paletteA'] as Color;
    final isAlt = i.isOdd;
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isAlt ? Color(0xFFF5F5F5) : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 200.0,
              child: Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: paletteA,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      value.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: paletteA,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            _tableCell(meta['aggregation'] as String, 220.0),
            _tableCell(meta['whenToUse'] as String, 220.0),
            SizedBox(
              width: 50.0,
              child: Text(
                '${value.index}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        comparisonHeader,
        ...comparisonRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Quick reference — flat chips and a tiny FAQ.
  // ============================================================
  final quickReferenceChips = <Widget>[
    _refChip('default = latestPointer', Color(0xFF1976D2)),
    _refChip('values: $strategyCount', Color(0xFF00897B)),
    _refChip('first.index = ${firstStrategy.index}', Color(0xFF6A1B9A)),
    _refChip('last.index = ${lastStrategy.index}', Color(0xFFD84315)),
    _refChip('lives in monodrag.dart', Color(0xFF455A64)),
    _refChip('used by *DragGestureRecognizer', Color(0xFF2E7D32)),
    _refChip('per-recognizer setting', Color(0xFFF9A825)),
    _refChip('does not affect arena', Color(0xFFAD1457)),
  ];

  final faq = <Map<String, String>>[
    {
      'q': 'Does the strategy change which pointers win the gesture arena?',
      'a':
          'No. Arena resolution is independent. The strategy only changes how '
          'accepted pointers contribute to the resolved drag delta.',
    },
    {
      'q': 'Can I switch the strategy after the recognizer is created?',
      'a':
          'Yes — multitouchDragStrategy is a normal mutable field. Avoid '
          'switching mid-drag because internal bookkeeping is reset.',
    },
    {
      'q': 'Why is averageBoundaryPointers buffered per frame?',
      'a':
          'It accumulates per-pointer move deltas in the same frame and '
          'resolves a smoothed delta on frame boundary, reducing jitter.',
    },
    {
      'q': 'Will sumAllPointers double a pinch with two fingers?',
      'a':
          'For drag axes, yes — both fingers add their deltas. Pinch is '
          'handled by ScaleGestureRecognizer, which is unrelated to this enum.',
    },
  ];

  final quickReferenceSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFE0F7FA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF26A69A), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF26A69A).withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flash_on, color: Color(0xFF00695C), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: quickReferenceChips,
        ),
        SizedBox(height: 16.0),
        Text(
          'FAQ',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
          ),
        ),
        SizedBox(height: 8.0),
        for (final entry in faq)
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFF26A69A).withValues(alpha: 0.4),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: Color(0xFF00695C),
                      size: 16.0,
                    ),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        entry['q']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                          color: Color(0xFF00695C),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    entry['a']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer — final stamp + animation strip.
  // ============================================================
  final ascii =
      '+----------------------------------------------------+\n'
      '|              MultitouchDragStrategy                |\n'
      '+----------------------------------------------------+\n'
      '|  latestPointer            -> motion(latest)        |\n'
      '|  averageBoundaryPointers  -> mean(min, max)/axis   |\n'
      '|  sumAllPointers           -> sigma(motion_i)       |\n'
      '+----------------------------------------------------+\n'
      '|  default = latestPointer   first.index = 0         |\n'
      '+----------------------------------------------------+';

  // A non-interactive "animation strip": three rows showing how a
  // resolved delta would look at a fixed AlwaysStoppedAnimation value
  // for each strategy. Pure visual — no real motion.
  final stripValues = <Map<String, Object>>[
    {
      'name': 'latestPointer',
      'animation': AlwaysStoppedAnimation<double>(0.33),
      'palette': Color(0xFF1E88E5),
    },
    {
      'name': 'averageBoundaryPointers',
      'animation': AlwaysStoppedAnimation<double>(0.66),
      'palette': Color(0xFF8E24AA),
    },
    {
      'name': 'sumAllPointers',
      'animation': AlwaysStoppedAnimation<double>(1.0),
      'palette': Color(0xFFE65100),
    },
  ];

  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF212121), Color(0xFF424242)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Color(0xFF80CBC4), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ASCII footer',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16.0,
                color: Color(0xFF80CBC4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF000000),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            ascii,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFF80CBC4),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'frozen-animation snapshot per strategy',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 8.0),
        for (final s in stripValues)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                SizedBox(
                  width: 220.0,
                  child: Text(
                    s['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: s['palette'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: _strategyAnimationStrip(
                    s['animation'] as Animation<double>,
                    s['palette'] as Color,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  (s['animation'] as Animation<double>)
                      .value
                      .toStringAsFixed(2),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer_off, size: 14.0, color: Color(0xFF80CBC4)),
              SizedBox(width: 6.0),
              Text(
                'Duration.zero — pure layout, no motion',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Color(0xFF80CBC4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Return the full layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            _sectionTitle('1. Anatomy of a multi-touch drag', Icons.account_tree),
            anatomyDiagram,
            _sectionTitle(
              '2. Strategy by strategy',
              Icons.style,
            ),
            ...perValueCards,
            _sectionTitle('3. Recipes', Icons.menu_book),
            recipesSection,
            _sectionTitle('4. Three-finger scenario', Icons.science),
            scenarioSection,
            _sectionTitle('5. Pitfalls', Icons.report_problem),
            pitfallsSection,
            _sectionTitle('6. Comparison table', Icons.table_chart),
            comparisonTable,
            _sectionTitle('7. Quick reference', Icons.flash_on),
            quickReferenceSection,
            _sectionTitle('8. ASCII footer', Icons.terminal),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionTitle(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 18.0, bottom: 6.0, left: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF6A1B9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6A1B9A).withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: Colors.white),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyNode(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(height: 6.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey.shade800,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.arrow_forward, color: color, size: 22.0),
  );
}

Widget _strategyMetricBlock(
  String label,
  String value,
  IconData icon,
  Color bg,
  Color fg,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: fg.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.0, color: fg),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: fg,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade900,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _fingerWeightBadge(int n, double weight) {
  final on = weight > 0.0;
  return Container(
    width: 56.0,
    padding: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: on
            ? [Colors.white, Colors.white.withValues(alpha: 0.7)]
            : [Colors.white24, Colors.white10],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: on ? 0.7 : 0.25),
        width: 1.0,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'F$n',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: on ? Colors.black87 : Colors.white70,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          weight.toStringAsFixed(2),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: on ? Colors.black54 : Colors.white54,
          ),
        ),
      ],
    ),
  );
}

Widget _codeRecipe(String comment, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B2730),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: accent,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _tableHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _tableCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: Colors.grey.shade800,
        height: 1.3,
      ),
    ),
  );
}

Widget _refChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.08)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _strategyAnimationStrip(Animation<double> animation, Color color) {
  return Container(
    height: 16.0,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: color.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: animation.value.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
      ),
    ),
  );
}
