// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =====================================================================
// VerticalMultiDragGestureRecognizer — Deep Visual Demonstration
// =====================================================================
// This file is a hand-authored, INSTRUCTIVE poster about the recognizer
// `VerticalMultiDragGestureRecognizer` from `package:flutter/gestures`.
//
// The recognizer differs from its single-pointer cousin
// `VerticalDragGestureRecognizer` in one fundamental way: it accepts
// MULTIPLE simultaneous vertical drags. Every time a finger is placed
// on the hit-tested region and the pointer's vertical motion exceeds
// the configured slop, the recognizer wins the arena for THAT pointer
// and asks the consumer (via `onStart`) to provide a brand new `Drag`
// object representing that single finger's contribution.
//
// Each `Drag` then receives:
//   * `update(DragUpdateDetails)` — every time the pointer moves
//   * `end(DragEndDetails)`       — when the user lifts the finger
//   * `cancel()`                  — when the recognizer loses arena
//
// This is the canonical building block for multi-thumb sliders,
// dual-finger rate controls, three-finger expand gestures, and any
// scenario where multiple fingers must drag along the vertical axis
// independently and concurrently.
//
// We CANNOT drive real pointer events in this interpreter context, so
// the demo VISUALLY DEPICTS what the recognizer does: pointer trails,
// slop thresholds, the per-pointer Drag contract, and arena interplay.
// =====================================================================

// ---------------------------------------------------------------------
// Color and gradient palette
// ---------------------------------------------------------------------

const Color _bg = Color(0xFF0E1A2D);
const Color _panel = Color(0xFF152540);
const Color _panelDeep = Color(0xFF0B162A);
const Color _ink = Color(0xFFE8F0FF);
const Color _inkSoft = Color(0xFFB7C5DA);
const Color _inkMuted = Color(0xFF7B8AA3);
const Color _accent = Color(0xFF7AD2FF);
const Color _accent2 = Color(0xFFB294FF);
const Color _accent3 = Color(0xFFFFD27A);
const Color _accent4 = Color(0xFFFF8FB1);
const Color _good = Color(0xFF4DE3A0);
const Color _bad = Color(0xFFFF7676);

const LinearGradient _headerGradA = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1B3D7A), Color(0xFF7AD2FF)],
);

const LinearGradient _headerGradB = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF4A2480), Color(0xFFB294FF)],
);

const LinearGradient _headerGradC = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF8A5A12), Color(0xFFFFD27A)],
);

const LinearGradient _headerGradD = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF7A1E48), Color(0xFFFF8FB1)],
);

const LinearGradient _headerGradE = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF134E3A), Color(0xFF4DE3A0)],
);

const LinearGradient _headerGradF = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1F2C4D), Color(0xFFB7C5DA)],
);

const LinearGradient _traceGradA = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0x00000000), Color(0xFF7AD2FF)],
);

const LinearGradient _traceGradB = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0x00000000), Color(0xFFB294FF)],
);

const LinearGradient _traceGradC = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0x00000000), Color(0xFFFFD27A)],
);

const LinearGradient _slopShade = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0x227AD2FF), Color(0x447AD2FF), Color(0x227AD2FF)],
);

const LinearGradient _arenaGrad = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[Color(0xFF0B162A), Color(0xFF152540), Color(0xFF0B162A)],
);

const LinearGradient _badgeGood = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF134E3A), Color(0xFF4DE3A0)],
);

const LinearGradient _badgeBad = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF7A1E1E), Color(0xFFFF7676)],
);

// ---------------------------------------------------------------------
// Shadows
// ---------------------------------------------------------------------

const List<BoxShadow> _shadowSoft = <BoxShadow>[
  BoxShadow(color: Color(0x66000000), blurRadius: 18, offset: Offset(0, 8)),
];

const List<BoxShadow> _shadowDeep = <BoxShadow>[
  BoxShadow(color: Color(0x88000000), blurRadius: 26, offset: Offset(0, 12)),
];

const List<BoxShadow> _shadowGlowA = <BoxShadow>[
  BoxShadow(color: Color(0x557AD2FF), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> _shadowGlowB = <BoxShadow>[
  BoxShadow(color: Color(0x55B294FF), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> _shadowGlowC = <BoxShadow>[
  BoxShadow(color: Color(0x55FFD27A), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> _shadowChip = <BoxShadow>[
  BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 4)),
];

const List<BoxShadow> _shadowInset = <BoxShadow>[
  BoxShadow(color: Color(0x22000000), blurRadius: 4, offset: Offset(0, 2)),
];

// ---------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------

Widget _gradientHeader(String title, String subtitle, LinearGradient g) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    decoration: BoxDecoration(
      gradient: g,
      borderRadius: BorderRadius.circular(18),
      boxShadow: _shadowDeep,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: _ink,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            color: _ink,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _prose(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
    child: Text(
      text,
      style: TextStyle(
        color: _inkSoft,
        fontSize: 13.5,
        height: 1.55,
      ),
    ),
  );
}

Widget _proseStrong(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        color: _ink,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _panelBox({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      boxShadow: _shadowSoft,
      border: Border.all(color: Color(0x227AD2FF), width: 1),
    ),
    child: child,
  );
}

Widget _deepBox({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      boxShadow: _shadowInset,
      border: Border.all(color: Color(0x33B294FF), width: 1),
    ),
    child: child,
  );
}

Widget _chip(String text, Color fg, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      boxShadow: _shadowChip,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _kvRow(String k, String v) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            k,
            style: TextStyle(
              color: _inkMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              color: _ink,
              fontSize: 12.5,
              height: 1.45,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text, Color dot) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 6, right: 10),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dot,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(color: dot.withValues(alpha: 0.5), blurRadius: 8),
            ],
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _inkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _arrow(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.arrow_forward_rounded, color: color, size: 22),
  );
}

Widget _arrowDown(Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Icon(Icons.arrow_downward_rounded, color: color, size: 22),
  );
}

Widget _section(Widget header, List<Widget> body) {
  return Padding(
    padding: EdgeInsets.only(bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        header,
        SizedBox(height: 14),
        ...body,
      ],
    ),
  );
}

// =====================================================================
// SECTION 1 — Anatomy diagram (PointerDown → arena → onStart → Drag)
// =====================================================================

Widget _anatomyNode(String title, String subtitle, LinearGradient g, IconData icon) {
  return Container(
    width: 160,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: g,
      borderRadius: BorderRadius.circular(14),
      boxShadow: _shadowSoft,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: _ink, size: 22),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: _ink,
            fontSize: 11,
            height: 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _section1() {
  Widget header = _gradientHeader(
    '1. Anatomy of a vertical multi-drag',
    'PointerDownEvent → arena → onStart(Offset) → Drag(update/end/cancel)',
    _headerGradA,
  );

  Widget diagram = _panelBox(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _anatomyNode('PointerDown', 'A finger touches the screen at (x, y).', _headerGradA, Icons.touch_app_rounded),
          _arrow(_accent),
          _anatomyNode('Gesture arena', 'All candidate recognizers register interest for this pointer.', _headerGradF, Icons.sports_kabaddi_rounded),
          _arrow(_accent),
          _anatomyNode('Slop crossed', 'Vertical motion > kTouchSlop ⇒ recognizer claims the pointer.', _headerGradC, Icons.linear_scale_rounded),
          _arrow(_accent3),
          _anatomyNode('onStart(Offset)', 'You return a fresh `Drag` for THIS pointer (per-finger state).', _headerGradB, Icons.start_rounded),
          _arrow(_accent2),
          _anatomyNode('Drag.update', 'Per-pointer DragUpdateDetails stream until lift.', _headerGradE, Icons.swap_vert_rounded),
          _arrow(_good),
          _anatomyNode('Drag.end / cancel', 'Pointer lifts ⇒ end(DragEndDetails); arena loss ⇒ cancel().', _headerGradD, Icons.flag_rounded),
        ],
      ),
    ),
  );

  Widget legend = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseStrong('Per-pointer lifecycle'),
        _bullet('Each `PointerDownEvent` opens a fresh arena entry, independent from any other finger already on screen.', _accent),
        _bullet('VerticalMultiDragGestureRecognizer waits until the pointer drifts vertically beyond the slop before declaring victory.', _accent2),
        _bullet('The win-handler invokes your `onStart(Offset globalPosition)` callback, which MUST return a `Drag` (or `null` to decline).', _accent3),
        _bullet('That `Drag` is the per-finger state holder; it receives `update`, then either `end` or `cancel`, and is then discarded.', _good),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'VerticalMultiDragGestureRecognizer is the canonical multi-finger vertical drag '
      'building block. Unlike VerticalDragGestureRecognizer, which competes for ONE '
      'pointer at a time, this recognizer participates in the gesture arena for every '
      'pointer that lands on its hit-tested region — concurrently. The split between '
      '`onStart` (per-pointer lifecycle entry point) and the returned `Drag` (per-pointer '
      'data sink) is what makes truly independent multi-finger interaction possible.',
    ),
    diagram,
    SizedBox(height: 12),
    legend,
  ]);
}

// =====================================================================
// SECTION 2 — Multi-pointer trace gallery
// =====================================================================

Widget _trace({
  required String label,
  required String pointerId,
  required double startDy,
  required double currentDy,
  required LinearGradient grad,
  required Color dot,
}) {
  double top = startDy < currentDy ? startDy : currentDy;
  double bottom = startDy < currentDy ? currentDy : startDy;
  double bandHeight = bottom - top;
  double dy = currentDy - startDy;

  return Container(
    width: 90,
    height: 220,
    margin: EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x227AD2FF)),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: 0,
          right: 0,
          child: Container(
            height: bandHeight,
            decoration: BoxDecoration(
              gradient: grad,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Positioned(
          top: startDy - 6,
          left: 32,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              border: Border.all(color: _ink, width: 2),
            ),
            child: Center(
              child: Text(
                'S',
                style: TextStyle(color: _bg, fontSize: 9, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        Positioned(
          top: currentDy - 6,
          left: 32,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: dot.withValues(alpha: 0.7),
              shape: BoxShape.circle,
              border: Border.all(color: _ink, width: 2),
            ),
            child: Center(
              child: Text(
                'E',
                style: TextStyle(color: _bg, fontSize: 9, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 6,
          child: Column(
            children: <Widget>[
              Text(
                pointerId,
                style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w700),
              ),
              Text(
                'Δdy ${dy.toStringAsFixed(0)}',
                style: TextStyle(color: _inkSoft, fontSize: 10),
              ),
              Text(
                label,
                style: TextStyle(color: _inkMuted, fontSize: 9),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _section2() {
  Widget header = _gradientHeader(
    '2. Multi-pointer trace gallery',
    'Three independent fingers — each with its own Drag, its own Δdy, its own velocity.',
    _headerGradB,
  );

  Widget gallery = _panelBox(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          _trace(label: 'down', pointerId: '#1', startDy: 30, currentDy: 170, grad: _traceGradA, dot: _accent),
          _trace(label: 'up', pointerId: '#2', startDy: 160, currentDy: 50, grad: _traceGradB, dot: _accent2),
          _trace(label: 'down (slow)', pointerId: '#3', startDy: 60, currentDy: 110, grad: _traceGradC, dot: _accent3),
          _trace(label: 'down (fast)', pointerId: '#4', startDy: 20, currentDy: 200, grad: _traceGradA, dot: _accent),
          _trace(label: 'up (slow)', pointerId: '#5', startDy: 180, currentDy: 130, grad: _traceGradB, dot: _accent2),
          _trace(label: 'down', pointerId: '#6', startDy: 90, currentDy: 195, grad: _traceGradC, dot: _accent3),
        ],
      ),
    ),
  );

  Widget readout = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseStrong('How to read these traces'),
        _bullet('Each vertical bar is ONE pointer\'s journey from touch-down (S) to current/release (E).', _accent),
        _bullet('Pointers #1, #4, and #6 dragged downward; #2 and #5 dragged upward; #3 barely crossed the slop.', _accent2),
        _bullet('A horizontal motion (across the screen) does NOT affect this recognizer until vertical slop is crossed.', _accent3),
        _bullet('All six fingers can be active concurrently — each receives its own `Drag` from `onStart`.', _good),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'A defining feature of VerticalMultiDragGestureRecognizer is that the per-pointer '
      'state never aliases. If three fingers are pressed, three separate `Drag` objects '
      'live in parallel — each receiving its own DragUpdateDetails with its own delta, '
      'velocity tracker, and timestamps. This is in stark contrast to a single-pointer '
      'drag recognizer, which would either ignore extra fingers or only track the most '
      'recent one. Use this when you genuinely need multiple fingers to push values '
      'around at the same time, such as a multi-thumb slider.',
    ),
    gallery,
    SizedBox(height: 12),
    readout,
  ]);
}

// =====================================================================
// SECTION 3 — Slop thresholds
// =====================================================================

Widget _slopBar({
  required String label,
  required double topSlop,
  required double bottomSlop,
  required double height,
  required Color tint,
}) {
  return Container(
    width: 110,
    height: height,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x33FFFFFF)),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: topSlop,
          child: Container(
            decoration: BoxDecoration(
              gradient: _slopShade,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: bottomSlop,
          child: Container(
            decoration: BoxDecoration(
              gradient: _slopShade,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
        ),
        Positioned(
          top: height / 2 - 1,
          left: 0,
          right: 0,
          child: Container(height: 2, color: tint),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 6,
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _section3() {
  Widget header = _gradientHeader(
    '3. Slop thresholds (kTouchSlop / kPanSlop)',
    'A pointer is not VERTICAL until it has drifted past the slop along the y-axis.',
    _headerGradC,
  );

  Widget visual = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _slopBar(label: 'kTouchSlop', topSlop: 50, bottomSlop: 50, height: 200, tint: _accent),
              _slopBar(label: 'kPanSlop', topSlop: 35, bottomSlop: 35, height: 200, tint: _accent2),
              _slopBar(label: 'effective y-slop', topSlop: 30, bottomSlop: 30, height: 200, tint: _accent3),
            ],
          ),
        ),
        SizedBox(height: 14),
        _proseStrong('Reading the bar'),
        _bullet('The shaded zones at top and bottom mark the "no-yet-vertical" region; pointers staying inside it never claim the arena.', _accent),
        _bullet('Once the pointer\'s |Δy| exceeds the slop, the recognizer accepts the pointer and `onStart` fires.', _accent2),
        _bullet('The recognizer respects `gestureSettings.touchSlop` if provided — useful for stylus or mouse with custom slop.', _accent3),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'Why slop matters here: a real fingertip wobbles by a few pixels merely from '
      'finger-pad compression. If the recognizer accepted a pointer at the very first '
      'pixel of motion, every tap would be misread as a drag. VerticalMultiDrag therefore '
      'inherits the slop machinery from `MultiDragGestureRecognizer`, requiring vertical '
      'movement greater than `kTouchSlop` (or whatever `gestureSettings` overrides it to) '
      'before declaring vertical intent and winning the arena.',
    ),
    visual,
  ]);
}

// =====================================================================
// SECTION 4 — Comparison vs single-pointer recognizers
// =====================================================================

Widget _compareCard({
  required String title,
  required String tag,
  required LinearGradient grad,
  required List<String> bullets,
  required List<Widget> illustration,
}) {
  return Container(
    width: 320,
    margin: EdgeInsets.only(right: 14),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      boxShadow: _shadowSoft,
      border: Border.all(color: Color(0x33B294FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: grad,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tag,
            style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(color: _ink, fontSize: 16, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 12),
        ...List<Widget>.generate(bullets.length, (int i) {
          List<Color> colors = <Color>[_accent, _accent2, _accent3, _good];
          return _bullet(bullets[i], colors[i % colors.length]);
        }),
        SizedBox(height: 12),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: _panelDeep,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0x227AD2FF)),
          ),
          padding: EdgeInsets.all(8),
          child: Stack(children: illustration),
        ),
      ],
    ),
  );
}

Widget _section4() {
  Widget header = _gradientHeader(
    '4. VerticalMulti vs VerticalDrag',
    'Concurrent fingers vs. one-at-a-time semantics — pick the right tool.',
    _headerGradD,
  );

  List<Widget> singleIllust = <Widget>[
    Positioned(
      left: 40,
      top: 10,
      bottom: 10,
      child: Container(width: 4, decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(2))),
    ),
    Positioned(
      left: 24,
      top: 4,
      child: Container(
        width: 22, height: 22,
        decoration: BoxDecoration(color: _accent, shape: BoxShape.circle, boxShadow: _shadowGlowA),
      ),
    ),
    Positioned(
      left: 100,
      top: 10,
      bottom: 10,
      child: Container(width: 4, decoration: BoxDecoration(color: _inkMuted, borderRadius: BorderRadius.circular(2))),
    ),
    Positioned(
      left: 86,
      top: 4,
      child: Container(
        width: 22, height: 22,
        decoration: BoxDecoration(color: _inkMuted, shape: BoxShape.circle),
      ),
    ),
    Positioned(
      right: 12,
      top: 30,
      child: Text(
        '#2 ignored\n(only #1 wins)',
        style: TextStyle(color: _bad, fontSize: 11, fontWeight: FontWeight.w700, height: 1.3),
      ),
    ),
  ];

  List<Widget> multiIllust = <Widget>[
    Positioned(
      left: 30,
      top: 10,
      bottom: 10,
      child: Container(width: 4, decoration: BoxDecoration(gradient: _traceGradA)),
    ),
    Positioned(left: 14, top: 4, child: Container(width: 22, height: 22, decoration: BoxDecoration(color: _accent, shape: BoxShape.circle, boxShadow: _shadowGlowA))),
    Positioned(
      left: 100,
      top: 10,
      bottom: 10,
      child: Container(width: 4, decoration: BoxDecoration(gradient: _traceGradB)),
    ),
    Positioned(left: 86, top: 4, child: Container(width: 22, height: 22, decoration: BoxDecoration(color: _accent2, shape: BoxShape.circle, boxShadow: _shadowGlowB))),
    Positioned(
      left: 170,
      top: 10,
      bottom: 10,
      child: Container(width: 4, decoration: BoxDecoration(gradient: _traceGradC)),
    ),
    Positioned(left: 154, top: 4, child: Container(width: 22, height: 22, decoration: BoxDecoration(color: _accent3, shape: BoxShape.circle, boxShadow: _shadowGlowC))),
    Positioned(
      right: 12,
      top: 30,
      child: Text(
        '#1 #2 #3 all\nactive in parallel',
        style: TextStyle(color: _good, fontSize: 11, fontWeight: FontWeight.w700, height: 1.3),
      ),
    ),
  ];

  Widget cards = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        _compareCard(
          title: 'VerticalDragGestureRecognizer',
          tag: 'SINGLE-POINTER',
          grad: _headerGradF,
          bullets: <String>[
            'Tracks ONE pointer at a time (the first to cross slop).',
            'Other fingers are ignored or rejected by the arena.',
            'API: onStart, onUpdate, onEnd — flat callbacks, no per-pointer Drag.',
            'Right tool for: single-thumb vertical sliders, list scroll proxies.',
          ],
          illustration: singleIllust,
        ),
        _compareCard(
          title: 'VerticalMultiDragGestureRecognizer',
          tag: 'MULTI-POINTER',
          grad: _headerGradB,
          bullets: <String>[
            'Tracks every pointer concurrently; each gets its own Drag.',
            'onStart(Offset) is invoked once per pointer that wins the arena.',
            'API: onStart only — Drag itself owns update/end/cancel.',
            'Right tool for: dual-finger rate controls, multi-thumb sliders, mission-control gestures.',
          ],
          illustration: multiIllust,
        ),
        _compareCard(
          title: 'ImmediateMultiDragGestureRecognizer',
          tag: 'AXIS-AGNOSTIC',
          grad: _headerGradE,
          bullets: <String>[
            'Multi-pointer too, but accepts on first move regardless of axis.',
            'Will compete with vertical/horizontal cousins for arena ownership.',
            'Useful when you do not want to wait for slop or care about direction.',
            'Avoid in vertical-only scenarios — too eager.',
          ],
          illustration: multiIllust,
        ),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'The single-pointer VerticalDragGestureRecognizer is the right answer for 90% of '
      'vertical drags — it is what `Scrollable` uses internally. But there is an entire '
      'class of UI where two or three fingers must each be tracked independently, and '
      'where the arena cannot be allowed to pick a single winner. That is the niche of '
      'VerticalMultiDragGestureRecognizer: it returns a fresh `Drag` per pointer instead '
      'of multiplexing one onUpdate stream.',
    ),
    cards,
  ]);
}

// =====================================================================
// SECTION 5 — Drag contract diagram (timeline)
// =====================================================================

Widget _timelineStep({
  required String label,
  required String body,
  required Color color,
  required IconData icon,
  bool last = false,
}) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 14),
                ],
              ),
              child: Icon(icon, color: _bg, size: 20),
            ),
            if (!last)
              Expanded(
                child: Container(
                  width: 3,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  color: color.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
        SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 18, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _section5() {
  Widget header = _gradientHeader(
    '5. The Drag contract for ONE pointer',
    'onStart returns a Drag — that Drag receives update, then either end or cancel.',
    _headerGradE,
  );

  Widget timeline = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _timelineStep(
          label: 't0  PointerDownEvent',
          body: 'The finger lands on the hit-tested area. The arena begins; the recognizer registers itself for THIS pointer.',
          color: _accent,
          icon: Icons.touch_app_rounded,
        ),
        _timelineStep(
          label: 't1  Slop crossed (vertical)',
          body: 'The pointer has moved more than `kTouchSlop` along y. The recognizer claims the pointer and sweeps it.',
          color: _accent3,
          icon: Icons.trending_up_rounded,
        ),
        _timelineStep(
          label: 't2  onStart(Offset globalPosition)',
          body: 'You return a brand new `Drag` instance dedicated to this finger. State (initial position, accumulated dy) lives inside that Drag.',
          color: _accent2,
          icon: Icons.start_rounded,
        ),
        _timelineStep(
          label: 't3..tN  drag.update(DragUpdateDetails)',
          body: 'For every pointer-move that survives slop, the Drag receives DragUpdateDetails(delta, primaryDelta, globalPosition, sourceTimeStamp).',
          color: _good,
          icon: Icons.swap_vert_rounded,
        ),
        _timelineStep(
          label: 't_end  drag.end(DragEndDetails)',
          body: 'PointerUp arrives ⇒ end is called with the velocity tracker\'s primaryVelocity (vertical px/s). Use this for fling animations.',
          color: _accent4,
          icon: Icons.flag_rounded,
        ),
        _timelineStep(
          last: true,
          label: 't_cancel  drag.cancel()',
          body: 'Alternative terminus: the recognizer lost the arena (e.g. an outer scroll won), or the engine cancelled the pointer. State must be rolled back.',
          color: _bad,
          icon: Icons.cancel_rounded,
        ),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'The `Drag` interface is small but exact: three methods (update, end, cancel) and '
      'a discipline that the recognizer enforces. The recognizer guarantees that a Drag '
      'returned by `onStart` will receive exactly one terminating call — either `end` or '
      '`cancel`, never both, never neither. That is your contract for safely accumulating '
      'per-pointer state without leaks.',
    ),
    timeline,
  ]);
}

// =====================================================================
// SECTION 6 — Practical recipe gallery
// =====================================================================

Widget _recipeIllustration1() {
  // Dual-finger rate slider: two vertical bars + value readout
  return Container(
    height: 140,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x227AD2FF)),
    ),
    padding: EdgeInsets.all(10),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 24,
          top: 10,
          bottom: 10,
          child: Container(width: 6, decoration: BoxDecoration(color: Color(0x33FFFFFF), borderRadius: BorderRadius.circular(3))),
        ),
        Positioned(
          left: 20, top: 30,
          child: Container(
            width: 14, height: 14,
            decoration: BoxDecoration(color: _accent, shape: BoxShape.circle, boxShadow: _shadowGlowA),
          ),
        ),
        Positioned(
          right: 24,
          top: 10,
          bottom: 10,
          child: Container(width: 6, decoration: BoxDecoration(color: Color(0x33FFFFFF), borderRadius: BorderRadius.circular(3))),
        ),
        Positioned(
          right: 20, top: 80,
          child: Container(
            width: 14, height: 14,
            decoration: BoxDecoration(color: _accent2, shape: BoxShape.circle, boxShadow: _shadowGlowB),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Rate L: 0.72', style: TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text('Rate R: 0.31', style: TextStyle(color: _accent2, fontSize: 13, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('two fingers, two Drags', style: TextStyle(color: _inkMuted, fontSize: 10)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeIllustration2() {
  // Three-thumb chord controller
  return Container(
    height: 140,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x33B294FF)),
    ),
    padding: EdgeInsets.all(10),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 30, right: 30, top: 60,
          child: Container(height: 2, color: Color(0x44FFFFFF)),
        ),
        Positioned(left: 30, top: 30, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: _accent, shape: BoxShape.circle, boxShadow: _shadowGlowA))),
        Positioned(left: 30 + 90, top: 80, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: _accent2, shape: BoxShape.circle, boxShadow: _shadowGlowB))),
        Positioned(right: 30, top: 50, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: _accent3, shape: BoxShape.circle, boxShadow: _shadowGlowC))),
        Positioned(
          left: 0, right: 0, bottom: 8,
          child: Center(
            child: Text('chord: C / E♭ / G  (3 thumbs)', style: TextStyle(color: _ink, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeIllustration3() {
  // Multi-finger expandable shelf
  // C8: shelves (18+22+30+38) + 3 margins of 4 + SizedBox(4) + caption ≈ 142 px,
  // which overflows the previous 140-padding(20) = 120 px usable area by ~22 px.
  // Bump the box to 170 so the four shelves and the caption fit cleanly.
  return Container(
    height: 170,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x33FFD27A)),
    ),
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(height: 18, margin: EdgeInsets.only(bottom: 4), decoration: BoxDecoration(gradient: _headerGradC, borderRadius: BorderRadius.circular(4))),
        Container(height: 22, margin: EdgeInsets.only(bottom: 4), decoration: BoxDecoration(gradient: _headerGradB, borderRadius: BorderRadius.circular(4))),
        Container(height: 30, margin: EdgeInsets.only(bottom: 4), decoration: BoxDecoration(gradient: _headerGradA, borderRadius: BorderRadius.circular(4))),
        Container(height: 38, decoration: BoxDecoration(gradient: _headerGradE, borderRadius: BorderRadius.circular(4))),
        SizedBox(height: 4),
        Text('3-finger pull → shelves expand', style: TextStyle(color: _accent3, fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

Widget _recipeIllustration4() {
  // 2-finger vertical zoom (pinch-replacement)
  return Container(
    height: 140,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x33FF8FB1)),
    ),
    padding: EdgeInsets.all(10),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 0, right: 0, top: 0, bottom: 0,
          child: Center(
            child: Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                gradient: _headerGradD,
                borderRadius: BorderRadius.circular(12),
                boxShadow: _shadowSoft,
              ),
            ),
          ),
        ),
        Positioned(left: 16, top: 12, child: Container(width: 14, height: 14, decoration: BoxDecoration(color: _accent, shape: BoxShape.circle, boxShadow: _shadowGlowA))),
        Positioned(right: 16, bottom: 12, child: Container(width: 14, height: 14, decoration: BoxDecoration(color: _accent2, shape: BoxShape.circle, boxShadow: _shadowGlowB))),
        Positioned(
          left: 0, right: 0, bottom: 6,
          child: Center(
            child: Text('two fingers move apart vertically → zoom', style: TextStyle(color: _accent4, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required String useCase,
  required String detail,
  required LinearGradient grad,
  required Widget illustration,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      boxShadow: _shadowSoft,
      border: Border.all(color: Color(0x227AD2FF)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: grad,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(useCase,
                    style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w800)),
              ),
              SizedBox(height: 10),
              Text(title, style: TextStyle(color: _ink, fontSize: 16, fontWeight: FontWeight.w800)),
              SizedBox(height: 8),
              Text(detail, style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5)),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(flex: 2, child: illustration),
      ],
    ),
  );
}

Widget _section6() {
  Widget header = _gradientHeader(
    '6. Practical recipe gallery',
    'Four real-world UIs that genuinely benefit from concurrent vertical drags.',
    _headerGradD,
  );

  return _section(header, <Widget>[
    _prose(
      'Concurrency-aware vertical drag is rarer than ordinary drag, but when you need '
      'it, nothing else fits. The recipes below illustrate where this recognizer truly '
      'shines: each finger represents an independent value or actor, and forcing them '
      'through a single-pointer pipeline would either drop information or introduce '
      'awkward modal switches.',
    ),
    _recipeCard(
      title: 'Dual-finger rate slider',
      useCase: 'AUDIO MIXER',
      detail:
          'Left thumb sets channel-L gain, right thumb sets channel-R gain. Both fingers must move freely at the same time, '
          'each writing into its own observable. Each finger\'s `Drag.update` adjusts only its own channel; lifting one finger does not freeze the other.',
      grad: _headerGradA,
      illustration: _recipeIllustration1(),
    ),
    _recipeCard(
      title: 'Three-thumb chord controller',
      useCase: 'MUSIC TOY',
      detail:
          'Three vertical thumbs select pitches; sliding them up/down transposes each. With VerticalMultiDrag you can move all three thumbs '
          'simultaneously to slur a chord. A single-pointer recognizer would require sequential adjustment — not musical at all.',
      grad: _headerGradB,
      illustration: _recipeIllustration2(),
    ),
    _recipeCard(
      title: 'Multi-finger expandable shelf',
      useCase: 'MISSION CONTROL',
      detail:
          'Three fingers swipe down to expand a stack of shelves. Each finger pulls its own shelf, so the gesture feels like '
          'pulling open a set of independent drawers. Each `Drag` mutates one drawer\'s extent; no global coordination needed.',
      grad: _headerGradC,
      illustration: _recipeIllustration3(),
    ),
    _recipeCard(
      title: 'Two-finger vertical zoom',
      useCase: 'IMAGE EDITOR',
      detail:
          'On devices without pinch, two fingers moving apart vertically zoom in and moving toward each other zoom out. '
          'Tracking each finger\'s dy independently lets you compute relative spread without resorting to a Scale recognizer.',
      grad: _headerGradD,
      illustration: _recipeIllustration4(),
    ),
  ]);
}

// =====================================================================
// SECTION 7 — Arena interaction diagram
// =====================================================================

Widget _arenaParticipant({
  required String name,
  required String stance,
  required Color color,
  required bool winner,
}) {
  return Container(
    width: 200,
    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: winner ? color.withValues(alpha: 0.18) : _panelDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: winner ? color : Color(0x33FFFFFF), width: winner ? 2 : 1),
      boxShadow: winner
          ? <BoxShadow>[BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 18)]
          : _shadowChip,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10, height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                name,
                style: TextStyle(color: _ink, fontSize: 13, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (winner)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: _badgeGood,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('WIN', style: TextStyle(color: _ink, fontSize: 9, fontWeight: FontWeight.w800)),
              ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          stance,
          style: TextStyle(color: _inkSoft, fontSize: 11, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _section7() {
  Widget header = _gradientHeader(
    '7. Inside the gesture arena',
    'Multiple recognizers compete for one pointer; this one declares interest only after vertical slop.',
    _headerGradF,
  );

  Widget arenaPanel = Container(
    decoration: BoxDecoration(
      gradient: _arenaGrad,
      borderRadius: BorderRadius.circular(16),
      boxShadow: _shadowDeep,
      border: Border.all(color: Color(0x33B294FF)),
    ),
    padding: EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pointer #7  —  arena participants',
          style: TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            _arenaParticipant(
              name: 'TapGestureRecognizer',
              stance: 'Holds pointer until movement excludes a tap.',
              color: _inkMuted,
              winner: false,
            ),
            _arenaParticipant(
              name: 'HorizontalDragRecognizer',
              stance: 'Loses immediately — motion is along y, not x.',
              color: _bad,
              winner: false,
            ),
            _arenaParticipant(
              name: 'VerticalDragRecognizer',
              stance: 'Eligible, but is single-pointer; would conflict with multi.',
              color: _accent,
              winner: false,
            ),
            _arenaParticipant(
              name: 'VerticalMultiDragRecognizer',
              stance: 'Sweeps the pointer once |Δy| > kTouchSlop.',
              color: _good,
              winner: true,
            ),
            _arenaParticipant(
              name: 'LongPressGestureRecognizer',
              stance: 'Loses when motion exceeds tap-slop before timeout.',
              color: _inkMuted,
              winner: false,
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0x114DE3A0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0x554DE3A0)),
          ),
          child: Text(
            'Once VerticalMultiDrag SWEEPS the pointer it claims exclusive ownership: '
            'all other candidates receive `rejectGesture(pointer)`. The Drag\'s update '
            'stream begins; remaining motion flows only into your callback.',
            style: TextStyle(color: _good, fontSize: 12.5, height: 1.5, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'Because Flutter has no global gesture handler, every PointerDown opens a fresh '
      'arena that each recognizer in the hit-test region may join. VerticalMultiDrag '
      'enters the arena IMMEDIATELY on PointerDown but does not declare victory until '
      'vertical slop is crossed. If a competing recognizer accepts first (e.g. a '
      'parent ScrollView wins because the user is dragging down on a scrollable '
      'background), the multi-drag is rejected for that pointer and the pending '
      '`onStart` is never called.',
    ),
    arenaPanel,
  ]);
}

// =====================================================================
// SECTION 8 — Footgun panel
// =====================================================================

Widget _footgunCard({
  required String title,
  required String mistake,
  required String fix,
  required LinearGradient grad,
  required Widget visual,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      boxShadow: _shadowSoft,
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(gradient: _badgeBad, borderRadius: BorderRadius.circular(8)),
              child: Text('FOOTGUN',
                  style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w800)),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(gradient: grad, borderRadius: BorderRadius.circular(8)),
                child: Text(title,
                    style: TextStyle(color: _ink, fontSize: 13, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Mistake',
                      style: TextStyle(color: _bad, fontSize: 11, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text(mistake, style: TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5)),
                  SizedBox(height: 10),
                  Text('Fix',
                      style: TextStyle(color: _good, fontSize: 11, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text(fix, style: TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5)),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(flex: 2, child: visual),
          ],
        ),
      ],
    ),
  );
}

Widget _footVisual1() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.cancel_rounded, color: _bad, size: 14),
            SizedBox(width: 6),
            Text('onStart returned null', style: TextStyle(color: _bad, fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
        SizedBox(height: 6),
        Text('finger stays alive but dangles\nno per-pointer state created',
            style: TextStyle(color: _inkSoft, fontSize: 10, height: 1.4)),
        SizedBox(height: 8),
        Container(height: 4, color: _bad),
      ],
    ),
  );
}

Widget _footVisual2() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_rounded, color: _accent3, size: 14),
            SizedBox(width: 6),
            Text('Drag escapes scope', style: TextStyle(color: _accent3, fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
        SizedBox(height: 6),
        Text('Drag survives recognizer disposal\n→ leaks; updates routed nowhere',
            style: TextStyle(color: _inkSoft, fontSize: 10, height: 1.4)),
      ],
    ),
  );
}

Widget _footVisual3() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(8),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 8, top: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(4)),
            child: Text('VertDrag', style: TextStyle(color: _bg, fontSize: 9, fontWeight: FontWeight.w800)),
          ),
        ),
        Positioned(
          right: 8, top: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: _accent2, borderRadius: BorderRadius.circular(4)),
            child: Text('VertMulti', style: TextStyle(color: _bg, fontSize: 9, fontWeight: FontWeight.w800)),
          ),
        ),
        Positioned(
          left: 0, right: 0, top: 50,
          child: Center(
            child: Icon(Icons.flash_on_rounded, color: _bad, size: 28),
          ),
        ),
        Positioned(
          left: 0, right: 0, bottom: 6,
          child: Center(
            child: Text('arena conflict', style: TextStyle(color: _bad, fontSize: 11, fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    ),
  );
}

Widget _footVisual4() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.timeline_rounded, color: _accent4, size: 14),
            SizedBox(width: 6),
            Text('horizontal phase', style: TextStyle(color: _accent4, fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
        SizedBox(height: 6),
        Container(height: 3, color: _accent),
        SizedBox(height: 4),
        Text('finger drifted x first → arena\nmay reject before vertical slop', style: TextStyle(color: _inkSoft, fontSize: 10, height: 1.4)),
      ],
    ),
  );
}

Widget _footVisual5() {
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _panelDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x44FF7676)),
    ),
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.dynamic_form_rounded, color: _accent2, size: 14),
            SizedBox(width: 6),
            Text('shared mutable state', style: TextStyle(color: _accent2, fontSize: 11, fontWeight: FontWeight.w700)),
          ],
        ),
        SizedBox(height: 6),
        Text('two Drags writing one variable\n→ jitter & lost updates',
            style: TextStyle(color: _inkSoft, fontSize: 10, height: 1.4)),
      ],
    ),
  );
}

Widget _section8() {
  Widget header = _gradientHeader(
    '8. Footguns and how to avoid them',
    'The places where multi-finger vertical drag misbehaves most often.',
    _headerGradD,
  );

  return _section(header, <Widget>[
    _prose(
      'Multi-pointer recognizers are unforgiving in a way single-pointer ones are not. '
      'Because the lifetime of each `Drag` is independent, errors in one pointer\'s '
      'state machine do not crash the others — they just leak silently. The footguns '
      'below come from real Flutter codebases; treat them as your checklist before '
      'shipping a multi-finger gesture.',
    ),
    _footgunCard(
      title: 'Returning null from onStart without intent',
      mistake:
          'Returning null from onStart tells the recognizer to drop this pointer. If you only meant to gate on a condition, '
          'you have just produced a "sticky" finger that no longer animates anything but is also not released until the user lifts.',
      fix:
          'Always return a real Drag. If you want to ignore a pointer for some reason, return a no-op Drag that throws away updates rather than null, '
          'OR explicitly never set up the recognizer in that situation.',
      grad: _headerGradD,
      visual: _footVisual1(),
    ),
    _footgunCard(
      title: 'Letting the Drag outlive the recognizer',
      mistake:
          'Storing the Drag in a long-lived map without removing it on `end`/`cancel` leaks per-pointer state. Worse, dispatching `update` to a stale Drag '
          'after the recognizer was disposed is a silent no-op — bugs are invisible until you read the velocity tracker.',
      fix:
          'Remove the Drag from any external collection inside its `end` and `cancel` methods. Treat the Drag as the canonical owner of its row of state.',
      grad: _headerGradD,
      visual: _footVisual2(),
    ),
    _footgunCard(
      title: 'Mixing VerticalDrag and VerticalMultiDrag in one scope',
      mistake:
          'Both recognizers want vertical pointers and both will sweep on slop. Whichever wins the arena first will starve the other, '
          'producing erratic behaviour where a single finger sometimes triggers single-drag and sometimes triggers multi-drag.',
      fix:
          'Pick exactly one. If you need a single-pointer fallback alongside multi-pointer, configure them to coexist via a custom GestureFactory and disambiguate by pointer count.',
      grad: _headerGradD,
      visual: _footVisual3(),
    ),
    _footgunCard(
      title: 'Assuming horizontal motion is ignored before slop',
      mistake:
          'It is tempting to think VerticalMultiDrag completely ignores x-axis motion. In fact the recognizer only commits AFTER y-slop is crossed; '
          'a long horizontal-leaning drag can be claimed by HorizontalDrag first, leaving the vertical-multi recognizer to receive `cancel`.',
      fix:
          'If you want vertical-only no matter what, override the slop or compete more aggressively (e.g. with a custom MultiDragPointerState). Otherwise, design '
          'your UI so the user cannot easily start with horizontal motion.',
      grad: _headerGradD,
      visual: _footVisual4(),
    ),
    _footgunCard(
      title: 'Sharing mutable state between fingers',
      mistake:
          'Routing every Drag\'s update into the SAME variable defeats the entire point of the multi recognizer. Updates from finger #2 will overwrite '
          'updates from finger #1 in the same frame, producing visible jitter and lost gestures.',
      fix:
          'Each Drag owns its own state. Use a Map<Drag, Position> or store the position on the Drag implementation itself; never funnel two pointers into one slot.',
      grad: _headerGradD,
      visual: _footVisual5(),
    ),
  ]);
}

// =====================================================================
// SECTION 9 — API summary table
// =====================================================================

Widget _apiRow(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: TextStyle(color: _accent, fontSize: 12.5, fontWeight: FontWeight.w800, fontFamily: 'monospace'),
          ),
        ),
        SizedBox(
          width: 160,
          child: Text(
            type,
            style: TextStyle(color: _accent2, fontSize: 11.5, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: _inkSoft, fontSize: 12, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _section9() {
  Widget header = _gradientHeader(
    '9. API surface at a glance',
    'The constructor is small; the contract is large.',
    _headerGradF,
  );

  // Try to construct the recognizer in a guarded manner just to confirm
  // its presence in the bridge. We do NOT drive it with pointer events.
  String constructed = 'unknown';
  try {
    VerticalMultiDragGestureRecognizer probe = VerticalMultiDragGestureRecognizer();
    constructed = 'Constructed ✓  (kind=${probe.runtimeType})';
  } catch (_) {
    constructed = 'Construction skipped';
  }

  Widget table = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _apiRow('onStart', 'Drag? Function(Offset position)',
            'Called once per pointer once vertical slop is crossed. Return a fresh Drag for that pointer or null to decline.'),
        _apiRow('gestureSettings', 'DeviceGestureSettings?',
            'Per-device override for slop and other thresholds. Honoured by the underlying MultiDragPointerState.'),
        _apiRow('supportedDevices', 'Set<PointerDeviceKind>?',
            'Restrict to touch only, or include stylus/mouse. Default: all device kinds that produce Down/Up events.'),
        _apiRow('debugDescription', 'String',
            'Returns "vertical multidrag" — used by Flutter\'s gesture debugger.'),
        _apiRow('addAllowedPointer', 'void Function(PointerDownEvent)',
            'Internal: called by the framework when a hit-tested pointer is allowed. Sets up per-pointer state.'),
        _apiRow('createNewPointerState', 'MultiDragPointerState',
            'Internal hook overridden by the vertical variant to enforce y-axis slop.'),
        _apiRow('Drag.update', 'void Function(DragUpdateDetails)',
            'Per-pointer update stream. delta and primaryDelta are vertical only post-slop.'),
        _apiRow('Drag.end', 'void Function(DragEndDetails)',
            'Per-pointer terminal callback when the user lifts. primaryVelocity is the vertical fling velocity.'),
        _apiRow('Drag.cancel', 'void Function()',
            'Per-pointer terminal callback when arena loss or engine cancel occurs. Roll back per-pointer state.'),
      ],
    ),
  );

  Widget badge = _panelBox(
    child: Row(
      children: <Widget>[
        Icon(Icons.verified_rounded, color: _good, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            constructed,
            style: TextStyle(color: _ink, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(gradient: _badgeGood, borderRadius: BorderRadius.circular(8)),
          child: Text('BRIDGED', style: TextStyle(color: _ink, fontSize: 11, fontWeight: FontWeight.w800)),
        ),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'The class itself adds almost nothing to its parent `MultiDragGestureRecognizer` '
      'beyond the y-axis slop policy. The interesting machinery lives in the `Drag` '
      'objects you return: that is where per-pointer state, velocity tracking, and any '
      'animation hooks accumulate. Treat the table below as a checklist when wiring '
      'this recognizer into a custom RawGestureDetector configuration.',
    ),
    badge,
    SizedBox(height: 12),
    table,
  ]);
}

// =====================================================================
// SECTION 10 — Closing summary
// =====================================================================

Widget _section10() {
  Widget header = _gradientHeader(
    '10. When to reach for VerticalMultiDrag',
    'A short decision flow for the next time you face a multi-finger vertical UI.',
    _headerGradE,
  );

  Widget flow = _panelBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseStrong('Step 1 — Is concurrency real?'),
        _bullet('If only ONE finger ever drives the value, use VerticalDragGestureRecognizer instead.', _accent),
        _bullet('If TWO or more fingers each control distinct values concurrently, continue.', _good),
        SizedBox(height: 12),
        _proseStrong('Step 2 — Is the axis truly vertical?'),
        _bullet('If users may drag in any direction, prefer ImmediateMultiDragGestureRecognizer or PanGestureRecognizer.', _accent2),
        _bullet('If you want vertical-only with slop, you are in the right place.', _good),
        SizedBox(height: 12),
        _proseStrong('Step 3 — Per-pointer state ownership'),
        _bullet('Design your Drag implementation as the SOLE owner of per-pointer state. Map<int, T> is also fine but more error-prone.', _accent3),
        _bullet('Always implement update, end, cancel — never leave any of them empty unless you really mean it.', _good),
        SizedBox(height: 12),
        _proseStrong('Step 4 — Test under arena pressure'),
        _bullet('Wrap the gesture region inside a Scrollable to ensure your multi-drag wins the arena correctly.', _accent4),
        _bullet('Test with 3+ simultaneous fingers; many bugs only appear when two pointers cross the slop in the same frame.', _good),
      ],
    ),
  );

  return _section(header, <Widget>[
    _prose(
      'Multi-finger vertical drag is a specialist tool. Used in the right place it '
      'unlocks UIs that feel impossibly direct; used in the wrong place it duplicates '
      'work that PanGestureRecognizer or VerticalDragGestureRecognizer already do for '
      'free. The flow above keeps you on the right side of that line.',
    ),
    flow,
  ]);
}

// =====================================================================
// build()
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _panelDeep,
        title: Text(
          'VerticalMultiDragGestureRecognizer',
          style: TextStyle(
            color: _ink,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: _headerGradA),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Hero summary card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: _headerGradA,
                borderRadius: BorderRadius.circular(20),
                boxShadow: _shadowDeep,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'package:flutter/gestures',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      _chip('multi-pointer', _bg, _accent),
                      SizedBox(width: 6),
                      _chip('y-axis', _bg, _accent2),
                      SizedBox(width: 6),
                      _chip('per-pointer Drag', _bg, _accent3),
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    'A recognizer that accepts MULTIPLE simultaneous vertical drags.',
                    style: TextStyle(color: _ink, fontSize: 18, fontWeight: FontWeight.w800, height: 1.3),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'For each pointer that crosses the vertical slop, the recognizer fires `onStart` and asks for a fresh `Drag` object that owns the per-finger update / end / cancel lifecycle. This is the canonical building block for multi-thumb sliders, dual-finger rate controls, and other UIs where multiple fingers must move along the y-axis at the same time.',
                    style: TextStyle(color: _ink, fontSize: 13.5, height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _section1(),
            _section2(),
            _section3(),
            _section4(),
            _section5(),
            _section6(),
            _section7(),
            _section8(),
            _section9(),
            _section10(),
            // Footer
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: _headerGradF,
                borderRadius: BorderRadius.circular(16),
                boxShadow: _shadowSoft,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'End of demonstration',
                    style: TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Hand-authored visual guide to VerticalMultiDragGestureRecognizer. '
                    'Per-pointer Drag objects, vertical slop arena, real-world recipes, footguns.',
                    style: TextStyle(color: _ink, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
