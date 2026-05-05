// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TapMoveDetails from gestures
// Deep Demo: Visual demonstration of TapMoveDetails — the payload delivered
// to TapGestureRecognizer.onTapMove callbacks. TapMoveDetails fires when a
// pointer that has triggered an onTapDown moves *within* the slop tolerance
// — i.e. movement small enough that the recognizer still considers the
// gesture a tap and has not yet handed it off to a drag recognizer.
//
// Constructor:
//   TapMoveDetails({
//     required PointerDeviceKind kind,
//     Offset globalPosition = Offset.zero,
//     Offset delta          = Offset.zero,
//     Offset? localPosition,
//   })
//
// Fields:
//   • globalPosition — absolute screen-coordinate location of the pointer
//   • localPosition  — defaults to globalPosition if not supplied
//   • kind           — PointerDeviceKind (touch / mouse / stylus / ...)
//   • delta          — incremental motion since the previous TapMoveDetails
//
// Lifecycle context:
//   pointer-down  →  TapDownDetails fires once
//   pointer-move  →  TapMoveDetails fires N times (within slop)
//   pointer-up    →  TapUpDetails  fires once  (tap completes)
//   …or, if the pointer escapes slop:
//   pointer-up    →  TapCancel + DragUpdateDetails takes over
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('TapMoveDetails Deep Demo executing');

  // ============================================================
  // Palette — teal / magenta / dark slate
  // ============================================================
  final slate = Color(0xFF334155);
  final slateDeep = Color(0xFF0F172A);
  final slateMid = Color(0xFF475569);
  final slateSoft = Color(0xFFE2E8F0);
  final slateMist = Color(0xFFF1F5F9);
  final teal = Color(0xFF0D9488);
  final tealDeep = Color(0xFF134E4A);
  final tealSoft = Color(0xFFCCFBF1);
  final magenta = Color(0xFFD946EF);
  final magentaDeep = Color(0xFF86198F);
  final magentaSoft = Color(0xFFFAE8FF);
  final amber = Color(0xFFF59E0B);
  final amberSoft = Color(0xFFFEF3C7);
  final indigo = Color(0xFF4F46E5);
  final indigoDeep = Color(0xFF312E81);
  final coral = Color(0xFFF87171);

  // ============================================================
  // Construct a canonical TapMoveDetails instance
  // ============================================================
  final tapMove = TapMoveDetails(
    kind: PointerDeviceKind.touch,
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(75.0, 125.0),
    delta: Offset(2.5, 1.5),
  );
  print('Canonical TapMoveDetails:');
  print('  kind           = ${tapMove.kind}');
  print('  globalPosition = ${tapMove.globalPosition}');
  print('  localPosition  = ${tapMove.localPosition}');
  print('  delta          = ${tapMove.delta}');

  // ============================================================
  // SECTION 1: Title banner — teal + magenta + dark slate
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, slate, magentaDeep, teal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.4, 0.75, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: magentaDeep.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.30),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.touch_app_outlined,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TapMoveDetails',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: tealSoft,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.0,
            ),
          ),
          child: Text(
            'Payload for GestureDetector.onTapMove — fires while a pointer '
            'that already triggered onTapDown wiggles within slop tolerance, '
            'before the gesture either completes (onTapUp) or escalates to '
            'a drag (onTapCancel + drag callbacks).',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _badge('pre-drag', tealSoft, tealDeep),
            _badge('within slop', magentaSoft, magentaDeep),
            _badge('TapGestureRecognizer', amberSoft, Color(0xFF92400E)),
            _badge('onTapMove', Colors.white, slateDeep),
          ],
        ),
      ],
    ),
  );
  print('Title banner ready');

  // ============================================================
  // SECTION 2: Anatomy — every field labelled
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyFields = [
    {
      'name': 'kind',
      'type': 'PointerDeviceKind (required)',
      'desc': 'The input device that produced the move event. Required '
          'because TapMoveDetails has no sensible default for the source.',
      'icon': Icons.devices_other,
      'color': amber,
      'value': '${tapMove.kind}',
    },
    {
      'name': 'globalPosition',
      'type': 'Offset = Offset.zero',
      'desc': 'Pointer location in absolute screen coordinates at the moment '
          'this move event was dispatched.',
      'icon': Icons.public,
      'color': teal,
      'value': '${tapMove.globalPosition}',
    },
    {
      'name': 'localPosition',
      'type': 'Offset? (defaults to globalPosition)',
      'desc': 'Pointer location translated into the listener\'s local box. '
          'When omitted the constructor copies globalPosition.',
      'icon': Icons.crop_free,
      'color': indigo,
      'value': '${tapMove.localPosition}',
    },
    {
      'name': 'delta',
      'type': 'Offset = Offset.zero',
      'desc': 'Incremental motion since the previous TapMoveDetails. '
          'Accumulating deltas reproduces the path inside slop.',
      'icon': Icons.trending_up,
      'color': magenta,
      'value': '${tapMove.delta}',
    },
  ];

  final anatomyCards = <Widget>[];
  for (final field in anatomyFields) {
    final color = field['color'] as Color;
    anatomyCards.add(
      Container(
        width: 250.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.10),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    field['icon'] as IconData,
                    color: color,
                    size: 22.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    field['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: slateDeep,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: slateDeep,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                field['type'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: tealSoft,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              field['desc'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: slateMid,
                height: 1.35,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: slateMist,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'value: ',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: slateMid,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      field['value'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: color,
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
    );
  }
  print('Anatomy cards built: ${anatomyCards.length}');

  // ============================================================
  // SECTION 3: Lifecycle diagram — Down → Move (× n) → Up / drag escalate
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycleSteps = [
    {
      'n': 1,
      'title': 'pointer-down',
      'sub': 'TapDownDetails',
      'desc': 'Pointer first contacts the screen inside the recognizer\'s '
          'hit-test region. The recognizer claims the pointer and emits '
          'onTapDown(TapDownDetails).',
      'icon': Icons.south,
      'color': teal,
    },
    {
      'n': 2,
      'title': 'pointer-move (within slop)',
      'sub': 'TapMoveDetails #1',
      'desc': 'Pointer wiggles by less than kTouchSlop (≈18 logical px). The '
          'recognizer still believes this is a tap and dispatches '
          'onTapMove(TapMoveDetails) — note delta is the *incremental* shift.',
      'icon': Icons.swap_horiz,
      'color': magenta,
    },
    {
      'n': 3,
      'title': 'pointer-move (within slop)',
      'sub': 'TapMoveDetails #2',
      'desc': 'Another tiny shift. delta is the diff since #1, NOT since '
          'the down event. globalPosition reflects the new absolute '
          'location. Many of these may fire in succession.',
      'icon': Icons.swap_horiz,
      'color': magenta,
    },
    {
      'n': 4,
      'title': 'pointer-move (within slop)',
      'sub': 'TapMoveDetails #3',
      'desc': 'Still inside the slop circle. The recognizer is still in '
          '"possible tap" state — no other recognizer has stolen the '
          'pointer in the gesture arena yet.',
      'icon': Icons.swap_horiz,
      'color': magenta,
    },
    {
      'n': 5,
      'title': 'pointer-up',
      'sub': 'TapUpDetails (HAPPY PATH)',
      'desc': 'Pointer is released while still within slop. The recognizer '
          'wins the arena and fires onTapUp(TapUpDetails) followed by '
          'onTap. The whole lifecycle was a successful tap.',
      'icon': Icons.north,
      'color': teal,
    },
    {
      'n': 6,
      'title': 'OR escape slop → escalate to drag',
      'sub': 'onTapCancel + DragUpdateDetails',
      'desc': 'If at any move the pointer moves *beyond* slop, the tap '
          'recognizer concedes the arena. onTapCancel fires and a drag '
          'recognizer (if present) takes over with DragUpdateDetails.',
      'icon': Icons.call_split,
      'color': coral,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    final color = step['color'] as Color;
    lifecycleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.22),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.06),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                '${step['n']}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(
              step['icon'] as IconData,
              color: color,
              size: 24.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: slateDeep,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      step['sub'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: slateMid,
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
  print('Lifecycle steps: ${lifecycleCards.length}');

  // ============================================================
  // SECTION 4: Slop tolerance visualization
  // ============================================================
  print('=== Section 4: Slop visualization ===');

  // Simulate a chain of TapMoveDetails inside slop, then one that escapes.
  final simulatedMoves = <TapMoveDetails>[
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(150.0, 250.0),
      localPosition: Offset(75.0, 125.0),
      delta: Offset(0.0, 0.0),
    ),
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(151.5, 250.5),
      localPosition: Offset(76.5, 125.5),
      delta: Offset(1.5, 0.5),
    ),
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(153.8, 252.1),
      localPosition: Offset(78.8, 127.1),
      delta: Offset(2.3, 1.6),
    ),
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(157.2, 254.4),
      localPosition: Offset(82.2, 129.4),
      delta: Offset(3.4, 2.3),
    ),
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(162.0, 257.5),
      localPosition: Offset(87.0, 132.5),
      delta: Offset(4.8, 3.1),
    ),
    TapMoveDetails(
      kind: PointerDeviceKind.touch,
      globalPosition: Offset(168.4, 261.0),
      localPosition: Offset(93.4, 136.0),
      delta: Offset(6.4, 3.5),
    ),
  ];

  final slopRows = <Widget>[];
  Offset accumulated = Offset.zero;
  for (var i = 0; i < simulatedMoves.length; i++) {
    final m = simulatedMoves[i];
    accumulated = accumulated + m.delta;
    final magnitude = accumulated.distance;
    // kTouchSlop on Flutter is 18.0 logical px.
    final inside = magnitude <= 18.0;
    final accent = inside ? teal : coral;
    slopRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: accent, width: 4.0),
            top: BorderSide(color: slateSoft, width: 1.0),
            right: BorderSide(color: slateSoft, width: 1.0),
            bottom: BorderSide(color: slateSoft, width: 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.10),
              blurRadius: 5.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '#${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _kvChip('global', '${m.globalPosition}', accent),
                      SizedBox(width: 6.0),
                      _kvChip('Δ', '${m.delta}', accent),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'cumulative distance from down: '
                    '${magnitude.toStringAsFixed(2)} px',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: slateMid,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                inside ? 'within slop ✓' : 'escaped slop ✗',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final slopCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateMist, Colors.white, magentaSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: slateSoft, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.adjust, color: slateDeep, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'kTouchSlop ≈ 18 logical px — '
                'kPrecisePointerHitSlop ≈ 1 logical px (mouse / stylus).',
                style: TextStyle(
                  fontSize: 13.5,
                  color: slateDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Each row sums delta to give cumulative distance from the down '
          'point. Once the magnitude exceeds the slop tolerance, the tap '
          'recognizer concedes the arena and onTapCancel fires.',
          style: TextStyle(
            fontSize: 12.0,
            color: slateMid,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
        SizedBox(height: 8.0),
        ...slopRows,
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.bolt, color: amber, size: 16.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Precise pointers (mouse / stylus) trip much sooner — '
                  'just 1 logical pixel. That is why drag-vs-tap behaves '
                  'differently with a mouse than with a finger.',
                  style: TextStyle(
                    color: tealSoft,
                    fontSize: 11.5,
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
  print('Slop card built; rows=${slopRows.length}');

  // ============================================================
  // SECTION 5: Comparison panel
  // ============================================================
  print('=== Section 5: Comparison panel ===');

  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: slateDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: [
        _hCell('field', 130.0),
        _hCell('TapDownDetails', 150.0),
        _hCell('TapMoveDetails', 150.0),
        _hCell('TapUpDetails', 150.0),
        _hCell('DragUpdateDetails', 170.0),
      ],
    ),
  );

  final comparisonRowsData = [
    [
      'kind',
      'PointerDeviceKind',
      'PointerDeviceKind (req)',
      'PointerDeviceKind',
      'PointerDeviceKind?',
    ],
    [
      'globalPosition',
      'Offset',
      'Offset',
      'Offset',
      'Offset',
    ],
    [
      'localPosition',
      'Offset (default = global)',
      'Offset (default = global)',
      'Offset (default = global)',
      'Offset (default = global)',
    ],
    [
      'delta',
      '— (no movement yet)',
      'Offset (incremental)',
      '—',
      'Offset (incremental)',
    ],
    [
      'primaryDelta',
      '—',
      '—',
      '—',
      'double? (axis)',
    ],
    [
      'sourceTimeStamp',
      '—',
      '—',
      '—',
      'Duration?',
    ],
    [
      'when fires',
      'pointer-down',
      'pre-drag move (within slop)',
      'pointer-up',
      'pointer-move post-arena',
    ],
    [
      'callback',
      'onTapDown',
      'onTapMove',
      'onTapUp',
      'onPan/HorizDragUpdate',
    ],
    [
      'recognizer',
      'TapGestureRecognizer',
      'TapGestureRecognizer',
      'TapGestureRecognizer',
      'Drag*GestureRecognizer',
    ],
  ];

  final comparisonBody = <Widget>[];
  for (var i = 0; i < comparisonRowsData.length; i++) {
    final row = comparisonRowsData[i];
    final stripe = i.isOdd ? slateSoft : Colors.white;
    comparisonBody.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(color: stripe),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dCell(row[0], 130.0, slateDeep, bold: true),
            _dCell(row[1], 150.0, slateMid),
            _dCell(row[2], 150.0, magentaDeep, bold: true),
            _dCell(row[3], 150.0, tealDeep),
            _dCell(row[4], 170.0, indigoDeep),
          ],
        ),
      ),
    );
  }

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: slateMid, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.12),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        comparisonHeader,
        ...comparisonBody,
      ],
    ),
  );
  print('Comparison table built');

  // ============================================================
  // SECTION 6: Multi-pointer scenario
  // ============================================================
  print('=== Section 6: Multi-pointer scenario ===');

  final multiPointers = <Map<String, Object>>[
    {
      'pid': 'pointer #1',
      'kind': PointerDeviceKind.touch,
      'kindLabel': 'touch (finger A)',
      'global': Offset(120.0, 200.0),
      'local': Offset(60.0, 80.0),
      'delta': Offset(1.2, 0.4),
      'state': 'within slop',
      'color': teal,
      'icon': Icons.fingerprint,
    },
    {
      'pid': 'pointer #2',
      'kind': PointerDeviceKind.touch,
      'kindLabel': 'touch (finger B)',
      'global': Offset(260.0, 320.0),
      'local': Offset(180.0, 200.0),
      'delta': Offset(0.6, 0.9),
      'state': 'within slop',
      'color': teal,
      'icon': Icons.fingerprint,
    },
    {
      'pid': 'pointer #3',
      'kind': PointerDeviceKind.mouse,
      'kindLabel': 'mouse (precise)',
      'global': Offset(420.0, 110.0),
      'local': Offset(80.0, 30.0),
      'delta': Offset(2.5, 1.0),
      'state': 'ESCAPED — mouse slop is 1 px',
      'color': coral,
      'icon': Icons.mouse,
    },
    {
      'pid': 'pointer #4',
      'kind': PointerDeviceKind.stylus,
      'kindLabel': 'stylus',
      'global': Offset(540.0, 240.0),
      'local': Offset(200.0, 90.0),
      'delta': Offset(0.4, 0.3),
      'state': 'within slop (stylus is precise)',
      'color': amber,
      'icon': Icons.edit,
    },
  ];

  final pointerCards = <Widget>[];
  for (final p in multiPointers) {
    final color = p['color'] as Color;
    pointerCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.28),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(p['icon'] as IconData, color: color, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['pid'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: slateDeep,
                        ),
                      ),
                      Text(
                        p['kindLabel'] as String,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: slateMid,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _kvLine('global', '${p['global']}', color),
            _kvLine('local', '${p['local']}', color),
            _kvLine('delta', '${p['delta']}', color),
            _kvLine('kind', '${p['kind']}', color),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                p['state'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Confirm we can construct each variant.
  for (final p in multiPointers) {
    final m = TapMoveDetails(
      kind: p['kind'] as PointerDeviceKind,
      globalPosition: p['global'] as Offset,
      localPosition: p['local'] as Offset,
      delta: p['delta'] as Offset,
    );
    print('Constructed pointer ${p['pid']}: ${m.kind} ${m.globalPosition}');
  }

  // ============================================================
  // SECTION 7: PointerDeviceKind family
  // ============================================================
  print('=== Section 7: PointerDeviceKind family ===');

  final kindFamily = [
    {
      'name': 'touch',
      'icon': Icons.touch_app,
      'color': teal,
      'desc': 'Finger on a touchscreen — slop ≈ 18 px so micro-wiggles still '
          'count as a tap.',
    },
    {
      'name': 'mouse',
      'icon': Icons.mouse,
      'color': indigo,
      'desc': 'Precise mouse cursor — slop ≈ 1 px so even tiny mouse jitter '
          'will escalate to drag.',
    },
    {
      'name': 'stylus',
      'icon': Icons.edit,
      'color': amber,
      'desc': 'Active pen — also precise; slop is small. Very rarely emits '
          'TapMoveDetails before escaping.',
    },
    {
      'name': 'trackpad',
      'icon': Icons.swipe,
      'color': coral,
      'desc': 'Trackpad gestures may translate as touch or scroll. Some '
          'platforms route tap-clicks through this kind.',
    },
    {
      'name': 'invertedStylus',
      'icon': Icons.swap_vert,
      'color': Color(0xFF8B5CF6),
      'desc': 'Pen flipped to eraser end — rare but supported by '
          'TapMoveDetails.kind.',
    },
    {
      'name': 'unknown',
      'icon': Icons.help_outline,
      'color': slateMid,
      'desc': 'Source not classifiable — fallback for unrecognised hardware.',
    },
  ];

  final kindCards = <Widget>[];
  for (final k in kindFamily) {
    final color = k['color'] as Color;
    kindCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.28),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(k['icon'] as IconData, color: color, size: 22.0),
                ),
                SizedBox(width: 10.0),
                Text(
                  'PointerDeviceKind',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: slateMid,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              '.${k['name']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              k['desc'] as String,
              style: TextStyle(
                fontSize: 11.5,
                color: slateMid,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Kind cards: ${kindCards.length}');

  // ============================================================
  // SECTION 8: Code block — onTapMove wiring
  // ============================================================
  print('=== Section 8: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: slateDeep,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tealDeep, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 5.0),
        ),
        BoxShadow(
          color: magentaDeep.withValues(alpha: 0.30),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: tealSoft, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'onTapMove — typical wiring',
              style: TextStyle(
                color: tealSoft,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _code('GestureDetector(', tealSoft),
        _code('  onTapDown: (TapDownDetails d) {', slateSoft),
        _code('    print(\'down @ \${d.globalPosition}\');',
            Color(0xFFFCD34D)),
        _code('  },', slateSoft),
        _code('  onTapMove: (TapMoveDetails m) {', slateSoft),
        _code('    // m.kind           — required PointerDeviceKind',
            Color(0xFF94A3B8)),
        _code('    // m.globalPosition — current screen-space pos',
            Color(0xFF94A3B8)),
        _code('    // m.localPosition  — relative to listener',
            Color(0xFF94A3B8)),
        _code('    // m.delta          — incremental shift', Color(0xFF94A3B8)),
        _code('    accumulator += m.delta;', Color(0xFF93C5FD)),
        _code('    if (accumulator.distance > kTouchSlop) {',
            Color(0xFF93C5FD)),
        _code('      // recognizer will call onTapCancel for us',
            Color(0xFF94A3B8)),
        _code('    }', slateSoft),
        _code('  },', slateSoft),
        _code('  onTapUp:    (TapUpDetails u) { /* commit */ },', slateSoft),
        _code('  onTapCancel:() { /* roll back */ },', slateSoft),
        _code('  child: child,', slateSoft),
        _code(');', tealSoft),
      ],
    ),
  );
  print('Code block built');

  // ============================================================
  // SECTION 9: Why TapMoveDetails exists — pre-drag micro-movement reporting
  // ============================================================
  print('=== Section 9: Why-it-exists card ===');

  final whyBullets = [
    {
      'title': 'Highlight-on-press feedback',
      'desc': 'Material InkWell uses pre-drag motion to drift the splash '
          'centre with the finger before the tap fires. Without TapMoveDetails '
          'the splash would freeze the moment onTapDown returned.',
      'icon': Icons.water_drop,
      'color': teal,
    },
    {
      'title': 'Pressure-aware tap targets',
      'desc': 'Custom widgets can show a "considering" preview that follows '
          'the pointer while the user decides. Once they release inside slop '
          'it commits; if they drift outside it cancels.',
      'icon': Icons.compass_calibration,
      'color': magenta,
    },
    {
      'title': 'Sub-pixel debouncing',
      'desc': 'Reading delta lets you ignore micro-jitter from imprecise '
          'sensors without paying for a full DragUpdateDetails pipeline.',
      'icon': Icons.tune,
      'color': indigo,
    },
    {
      'title': 'Hand-off to drag recognizers',
      'desc': 'When a tap recognizer sees it lose the arena (because the '
          'pointer escaped slop), the same incremental delta stream becomes '
          'the first DragUpdateDetails — TapMoveDetails is the bridge.',
      'icon': Icons.alt_route,
      'color': coral,
    },
    {
      'title': 'Hover-friendly UI on touch',
      'desc': 'Touch screens have no hover; TapMoveDetails simulates a '
          '"holding-and-aiming" hover state: while the finger is down, '
          'where exactly is it pointing right now?',
      'icon': Icons.center_focus_strong,
      'color': amber,
    },
  ];

  final whyCards = <Widget>[];
  for (final b in whyBullets) {
    final color = b['color'] as Color;
    whyCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(b['icon'] as IconData, color: color, size: 24.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: slateDeep,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    b['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: slateMid,
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
  print('Why-cards: ${whyCards.length}');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = [
    {
      'title': 'kind is required',
      'desc': 'Unlike TapDownDetails (where kind is named & nullable), '
          'TapMoveDetails demands a non-null PointerDeviceKind in the '
          'constructor. Forgetting it is a compile-time error.',
      'icon': Icons.error_outline,
      'color': coral,
    },
    {
      'title': 'delta is incremental, not cumulative',
      'desc': 'Each TapMoveDetails.delta is the shift since the *previous* '
          'TapMoveDetails. To get total displacement from the down event, '
          'you must accumulate the deltas yourself.',
      'icon': Icons.repeat,
      'color': amber,
    },
    {
      'title': 'onTapMove is a recent API',
      'desc': 'The hook landed in Flutter only with the introduction of '
          'TapMoveDetails — older codebases will not have it. Wrap usage '
          'with feature checks if you must support old SDKs.',
      'icon': Icons.history,
      'color': indigo,
    },
    {
      'title': 'Mouse + onTapMove is rare',
      'desc': 'Because mouse slop is 1 px, the sequence onTapDown → '
          'onTapMove → onTapUp almost never happens for a mouse — the '
          'gesture escalates to drag immediately on any motion.',
      'icon': Icons.mouse,
      'color': magenta,
    },
    {
      'title': 'Slop is reset per-down, not per-move',
      'desc': 'Cumulative slop is measured from the original pointer-down '
          'position, NOT from the most recent onTapMove. Don\'t reset your '
          'accumulator on every callback or you\'ll never detect drag.',
      'icon': Icons.refresh,
      'color': teal,
    },
    {
      'title': 'localPosition defaults to globalPosition',
      'desc': 'The constructor copies globalPosition into localPosition '
          'when localPosition is null. If you really need local coordinates '
          'you must pass them explicitly.',
      'icon': Icons.crop_free,
      'color': Color(0xFF8B5CF6),
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final color = fg['color'] as Color;
    footgunCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.08),
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(fg['icon'] as IconData, color: color, size: 24.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: slateDeep,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: slateMid,
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
  print('Footgun cards: ${footgunCards.length}');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapBullets = [
    'Carries kind (required), globalPosition, localPosition, delta.',
    'Fires from TapGestureRecognizer.onTapMove between onTapDown and '
        'onTapUp, while the pointer remains within slop tolerance.',
    'delta is incremental — each TapMoveDetails reports the shift since '
        'the previous one, NOT since onTapDown.',
    'Slop tolerance is roughly kTouchSlop ≈ 18 px for fingers, '
        'kPrecisePointerHitSlop ≈ 1 px for mouse and stylus.',
    'Once the cumulative shift escapes slop, onTapCancel fires and the '
        'pointer is handed to a drag recognizer (DragUpdateDetails).',
    'Use it for highlight-on-press, splash drift, and pre-drag aiming '
        'previews that need pointer position before the tap commits.',
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealSoft, magentaSoft, amberSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: tealDeep, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: magentaDeep.withValues(alpha: 0.20),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: tealDeep, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final bullet in recapBullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6.0, right: 10.0),
                  width: 9.0,
                  height: 9.0,
                  decoration: BoxDecoration(
                    color: magenta,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: magenta.withValues(alpha: 0.5),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: slateDeep,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Recap built');

  print('TapMoveDetails Deep Demo completed successfully');

  // ============================================================
  // Layout assembly
  // ============================================================
  return Container(
    color: slateMist,
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),

          _sectionHeader('1. Anatomy of TapMoveDetails', slateDeep, teal),
          Wrap(alignment: WrapAlignment.center, children: anatomyCards),
          SizedBox(height: 28.0),

          _sectionHeader('2. Lifecycle: Down → Move (×n) → Up / drag escalate',
              slateDeep, magenta),
          ...lifecycleCards,
          SizedBox(height: 28.0),

          _sectionHeader('3. Slop tolerance — kTouchSlop / kPrecisePointerHitSlop',
              slateDeep, indigo),
          slopCard,
          SizedBox(height: 28.0),

          _sectionHeader(
              '4. Comparison: TapDownDetails vs TapMoveDetails vs '
              'TapUpDetails vs DragUpdateDetails',
              slateDeep,
              slateMid),
          comparisonTable,
          SizedBox(height: 28.0),

          _sectionHeader('5. Multi-pointer scenario', slateDeep, teal),
          Wrap(alignment: WrapAlignment.center, children: pointerCards),
          SizedBox(height: 28.0),

          _sectionHeader('6. PointerDeviceKind family', slateDeep, indigo),
          Wrap(alignment: WrapAlignment.center, children: kindCards),
          SizedBox(height: 28.0),

          _sectionHeader('7. onTapMove callback signature', slateDeep,
              tealDeep),
          codeBlock,
          SizedBox(height: 28.0),

          _sectionHeader(
              '8. Why TapMoveDetails exists — pre-drag micro-movement '
              'reporting',
              slateDeep,
              magenta),
          Wrap(alignment: WrapAlignment.center, children: whyCards),
          SizedBox(height: 28.0),

          _sectionHeader('9. Footguns', slateDeep, coral),
          Wrap(alignment: WrapAlignment.center, children: footgunCards),
          SizedBox(height: 28.0),

          _sectionHeader('10. Recap', slateDeep, amber),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeader(String text, Color textColor, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 5.0),
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}

Widget _kvLine(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 56.0,
          child: Text(
            '$key:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF334155),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kvChip(String key, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Text(
      '$key=$value',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.5,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _badge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: fg.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: fg,
      ),
    ),
  );
}

Widget _hCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFCCFBF1),
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        fontFamily: 'monospace',
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _dCell(String text, double width, Color color, {bool bold = false}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'monospace',
        height: 1.35,
      ),
    ),
  );
}

Widget _code(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        color: color,
        height: 1.45,
      ),
    ),
  );
}
