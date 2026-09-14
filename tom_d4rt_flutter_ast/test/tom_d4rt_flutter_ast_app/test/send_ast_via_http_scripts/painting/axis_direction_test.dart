// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// AxisDirection — Deep Demo
// -----------------------------------------------------------------------------
// `AxisDirection` is a four-valued enum from `package:flutter/painting.dart`
// (re-exported by `package:flutter/material.dart`) with values:
//
//   * AxisDirection.up    — origin at the bottom, growing upwards
//   * AxisDirection.right — origin at the left,   growing rightwards
//   * AxisDirection.down  — origin at the top,    growing downwards
//   * AxisDirection.left  — origin at the right,  growing leftwards
//
// The enum encodes both the axis (horizontal vs vertical) AND the visual
// growth direction along that axis.  This combined encoding is what allows
// scrolling widgets, slivers, lists and the layout pipeline to express things
// like "a vertical list whose newest item is at the bottom (down)" or
// "a vertical list whose newest item is at the top (up, reversed)" with one
// scalar value.
//
// Helper functions exposed by Flutter's painting library:
//
//   * flipAxisDirection(AxisDirection)            — opposite direction
//   * axisDirectionIsReversed(AxisDirection)      — true for up + left
//   * axisDirectionToAxis(AxisDirection)          — Axis.vertical | horizontal
//   * textDirectionToAxisDirection(TextDirection) — ltr → right, rtl → left
//
// This script paints those concepts:
//   * compass cards (CustomPainter) — one per direction, arrow rotated
//   * 4-up ListView grid, each list configured with the matching scrollDirection
//     and `reverse` flag derived from the AxisDirection
//   * an interactive flip demo using `flipAxisDirection`
//   * a CustomScrollView slivers demo, plus a NestedScrollView
//   * a per-direction `axisDirectionIsReversed` truth table
//   * a per-direction `axisDirectionToAxis` grouping
//   * an LTR vs RTL `textDirectionToAxisDirection` resolver
//   * scroll-position tracking with a `ScrollController`
//   * use-case recipes (chat, gallery, bookshelf, feed)
//   * decision card (when to choose each)
//   * reference table summarising every value and helper
//
// Harness contract:
//   * first non-comment line is the analyzer ignore directive
//   * imports stay restricted to `package:flutter/material.dart`
//   * one top-level `dynamic build(BuildContext context)` returning a
//     `MaterialApp` whose body is `Scaffold` → `SafeArea` →
//     `SingleChildScrollView` → `Column` of section cards
//   * no `main()`, no `runApp()`, no `testWidgets()`
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Section palettes — distinct triples per section, kept at file scope so the
// colour choices do not drift mid-section.
// -----------------------------------------------------------------------------
const Color _heroBg = Color(0xFFE8EAF6);
const Color _heroAccent = Color(0xFF283593);
const Color _heroInk = Color(0xFF101542);

const Color _compassBg = Color(0xFFFFF3E0);
const Color _compassAccent = Color(0xFFEF6C00);
const Color _compassInk = Color(0xFF6A2C00);

const Color _listsBg = Color(0xFFE0F2F1);
const Color _listsAccent = Color(0xFF00695C);
const Color _listsInk = Color(0xFF00332E);

const Color _flipBg = Color(0xFFF3E5F5);
const Color _flipAccent = Color(0xFF6A1B9A);
const Color _flipInk = Color(0xFF3A0050);

const Color _reversedBg = Color(0xFFE8F5E9);
const Color _reversedAccent = Color(0xFF2E7D32);
const Color _reversedInk = Color(0xFF1B3D1F);

const Color _toAxisBg = Color(0xFFFFFDE7);
const Color _toAxisAccent = Color(0xFFF9A825);
const Color _toAxisInk = Color(0xFF5C4400);

const Color _textDirBg = Color(0xFFFCE4EC);
const Color _textDirAccent = Color(0xFFAD1457);
const Color _textDirInk = Color(0xFF560027);

const Color _scrollPosBg = Color(0xFFEDE7F6);
const Color _scrollPosAccent = Color(0xFF4527A0);
const Color _scrollPosInk = Color(0xFF1A0E4D);

const Color _sliverBg = Color(0xFFE3F2FD);
const Color _sliverAccent = Color(0xFF1565C0);
const Color _sliverInk = Color(0xFF0D2E58);

const Color _nestedBg = Color(0xFFEFEBE9);
const Color _nestedAccent = Color(0xFF5D4037);
const Color _nestedInk = Color(0xFF2A1A14);

const Color _chatBg = Color(0xFFE0F7FA);
const Color _chatAccent = Color(0xFF00838F);
const Color _chatInk = Color(0xFF003844);

const Color _galleryBg = Color(0xFFFFEBEE);
const Color _galleryAccent = Color(0xFFC62828);
const Color _galleryInk = Color(0xFF6A0F12);

const Color _bookshelfBg = Color(0xFFF1F8E9);
const Color _bookshelfAccent = Color(0xFF558B2F);
const Color _bookshelfInk = Color(0xFF1B3300);

const Color _feedBg = Color(0xFFE1F5FE);
const Color _feedAccent = Color(0xFF0277BD);
const Color _feedInk = Color(0xFF003c66);

const Color _decisionBg = Color(0xFFF9FBE7);
const Color _decisionAccent = Color(0xFF827717);
const Color _decisionInk = Color(0xFF3F4400);

const Color _refBg = Color(0xFFECEFF1);
const Color _refAccent = Color(0xFF455A64);
const Color _refInk = Color(0xFF263238);

// -----------------------------------------------------------------------------
// _CompassCardPainter — paints a small compass card with an arrow that points
// in the supplied AxisDirection, plus a faint axis line drawn perpendicular to
// the orthogonal axis so the viewer can see "this is the horizontal axis" or
// "this is the vertical axis" at a glance.
//
// We keep the painter parameter-light: the rotation is derived from the
// supplied AxisDirection, which makes calling sites short and self-documenting.
// -----------------------------------------------------------------------------
class _CompassCardPainter extends CustomPainter {
  const _CompassCardPainter({
    required this.direction,
    required this.accent,
    required this.muted,
  });

  final AxisDirection direction;
  final Color accent;
  final Color muted;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Background ring.
    final Paint ring = Paint()
      ..color = muted.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, size.shortestSide / 2 - 6, ring);

    // Faint axis line — horizontal for left/right, vertical for up/down.
    final Paint axisLine = Paint()
      ..color = muted.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final double half = size.shortestSide / 2 - 12;
    if (axisDirectionToAxis(direction) == Axis.horizontal) {
      canvas.drawLine(
        Offset(center.dx - half, center.dy),
        Offset(center.dx + half, center.dy),
        axisLine,
      );
    } else {
      canvas.drawLine(
        Offset(center.dx, center.dy - half),
        Offset(center.dx, center.dy + half),
        axisLine,
      );
    }

    // Arrow shaft + head, drawn pointing right then rotated to match the
    // requested AxisDirection.  AxisDirection.right is the canonical 0-rotation
    // pose; up = -90°, down = +90°, left = 180°.
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final double rotation = switch (direction) {
      AxisDirection.right => 0,
      AxisDirection.down => 1.5707963267948966, // pi / 2
      AxisDirection.left => 3.141592653589793, // pi
      AxisDirection.up => -1.5707963267948966, // -pi / 2
    };
    canvas.rotate(rotation);

    final Paint shaft = Paint()
      ..color = accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    final double shaftLen = half - 6;
    canvas.drawLine(
      Offset(-shaftLen + 4, 0),
      Offset(shaftLen - 6, 0),
      shaft,
    );

    final Paint head = Paint()
      ..color = accent
      ..style = PaintingStyle.fill;
    final Path arrowHead = Path()
      ..moveTo(shaftLen, 0)
      ..lineTo(shaftLen - 10, -7)
      ..lineTo(shaftLen - 10, 7)
      ..close();
    canvas.drawPath(arrowHead, head);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CompassCardPainter old) {
    return old.direction != direction ||
        old.accent != accent ||
        old.muted != muted;
  }
}

// -----------------------------------------------------------------------------
// _ReversedBadgePainter — paints a small "↺ reversed" or "↻ forward" glyph for
// the axisDirectionIsReversed truth-table card.
// -----------------------------------------------------------------------------
class _ReversedBadgePainter extends CustomPainter {
  const _ReversedBadgePainter({required this.reversed, required this.color});

  final bool reversed;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2 - 3;

    final Paint stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final Rect arc = Rect.fromCircle(center: center, radius: r);
    if (reversed) {
      canvas.drawArc(arc, 0.6, 4.5, false, stroke);
    } else {
      canvas.drawArc(arc, -0.6, -4.5, false, stroke);
    }

    // Tiny tick at the open end of the arc to suggest a directionality.
    final Paint dot = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + Offset(reversed ? -r : r, -r * 0.05), 3, dot);
  }

  @override
  bool shouldRepaint(covariant _ReversedBadgePainter old) {
    return old.reversed != reversed || old.color != color;
  }
}

// -----------------------------------------------------------------------------
// Helper widgets — kept at module scope because several sections reuse them.
// -----------------------------------------------------------------------------
Widget _sectionHeader(String number, String title, Color bg, Color ink) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: ink, width: 4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bodyText(String text, {Color color = Colors.black87}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: 13, height: 1.45),
    ),
  );
}

Widget _footerCaption(String text, Color ink) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
    child: Text(
      text,
      style: TextStyle(
        color: ink.withOpacity(0.75),
        fontSize: 11,
        fontStyle: FontStyle.italic,
        height: 1.4,
      ),
    ),
  );
}

// A small, single-line "directionLabel: value" chip used in many sections.
Widget _kvChip(String label, String value, Color ink) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: ink.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label ',
          style: TextStyle(
            color: ink,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ],
    ),
  );
}

// A small rendered list configured from an AxisDirection.  Used by the lists
// section, the use-case recipes, and the flip demo.  We translate the
// AxisDirection into the two `ListView` knobs:
//   scrollDirection: axisDirectionToAxis(...)
//   reverse:         axisDirectionIsReversed(...)
Widget _directionalListPreview({
  required AxisDirection direction,
  required Color accent,
  required Color ink,
  required int itemCount,
  double width = 140,
  double height = 140,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: ink.withOpacity(0.4)),
    ),
    clipBehavior: Clip.antiAlias,
    child: ListView.builder(
      scrollDirection: axisDirectionToAxis(direction),
      reverse: axisDirectionIsReversed(direction),
      itemCount: itemCount,
      padding: const EdgeInsets.all(6),
      itemBuilder: (BuildContext context, int i) {
        final bool horizontal =
            axisDirectionToAxis(direction) == Axis.horizontal;
        return Container(
          width: horizontal ? 32 : null,
          height: horizontal ? null : 32,
          margin: horizontal
              ? const EdgeInsets.symmetric(horizontal: 3)
              : const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.18 + (i % 5) * 0.10),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: accent.withOpacity(0.5)),
          ),
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      },
    ),
  );
}

String _directionLabel(AxisDirection d) {
  return switch (d) {
    AxisDirection.up => 'AxisDirection.up',
    AxisDirection.right => 'AxisDirection.right',
    AxisDirection.down => 'AxisDirection.down',
    AxisDirection.left => 'AxisDirection.left',
  };
}

// =============================================================================
// build — entry point invoked by the harness.
// =============================================================================
dynamic build(BuildContext context) {
  print('=== AxisDirection Deep Demo ===');
  print('Hand-painted compass cards, four-up ListView grid, flip demo, '
      'sliver demo, NestedScrollView, scroll-position tracking, '
      'and use-case recipes for chat/gallery/bookshelf/feed.');

  // ===========================================================================
  // SECTION 1 — HERO
  // ---------------------------------------------------------------------------
  // The hero card states the goal.  AxisDirection encodes both an `Axis`
  // (horizontal vs vertical) and a sign (forward vs reversed) in a single
  // four-valued enum.  The hero shows the four directions side-by-side using
  // the compass painter so the rest of the file can refer back to a known
  // visual baseline.
  // ===========================================================================
  final hero = Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _heroBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _heroAccent.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: _heroAccent.withOpacity(0.12),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _heroAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.compass_calibration,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'AxisDirection — a four-valued enum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: _heroInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '`AxisDirection` is the painting-layer enum that pairs an axis '
          '(horizontal or vertical) with a growth sign (forward or reversed). '
          'It is the value behind every scroll view, sliver and viewport: it '
          'tells the layout pipeline where to anchor children and which way '
          'the scroll position should grow.',
          style: TextStyle(color: _heroInk, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 8),
        const Text(
          'The four values — up, right, down, left — encode both axis and '
          'reversal in a single scalar.  `Axis`, by contrast, only encodes '
          'the axis itself; `axisDirectionToAxis` projects from the richer '
          'enum to the simpler one.',
          style: TextStyle(color: _heroInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: AxisDirection.values.map((AxisDirection d) {
            return Column(
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: CustomPaint(
                    painter: _CompassCardPainter(
                      direction: d,
                      accent: _heroAccent,
                      muted: _heroInk,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  d.name,
                  style: TextStyle(
                    color: _heroInk,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 — COMPASS CARDS PER VALUE
  // ---------------------------------------------------------------------------
  // One card per AxisDirection value, painted at a larger size so the arrow
  // and faint axis line are clearly visible.  Each card carries a short
  // caption explaining the canonical interpretation.
  // ===========================================================================
  final captions = <AxisDirection, String>{
    AxisDirection.up:
        'Origin at the bottom; children grow upward.  Common for stacked '
        'reverse lists where the most recent item should hug the bottom.',
    AxisDirection.right:
        'Origin at the left; children grow to the right.  This is the LTR '
        'forward direction and the canonical "rotation = 0" pose for the '
        'compass painter.',
    AxisDirection.down:
        'Origin at the top; children grow downward.  This is the default for '
        'a vertical `ListView` and matches normal reading order.',
    AxisDirection.left:
        'Origin at the right; children grow to the left.  This is what '
        '`textDirectionToAxisDirection(rtl)` returns and how RTL forward '
        'lists are encoded.',
  };

  final compassSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: AxisDirection.values.map((AxisDirection d) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _compassBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _compassAccent.withOpacity(0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CustomPaint(
                  painter: _CompassCardPainter(
                    direction: d,
                    accent: _compassAccent,
                    muted: _compassInk,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _directionLabel(d),
                      style: TextStyle(
                        color: _compassInk,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      captions[d]!,
                      style: TextStyle(
                        color: _compassInk,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _kvChip('axis',
                            axisDirectionToAxis(d).name, _compassInk),
                        _kvChip('reversed',
                            axisDirectionIsReversed(d).toString(), _compassInk),
                        _kvChip('flip',
                            flipAxisDirection(d).name, _compassInk),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ===========================================================================
  // SECTION 3 — FOUR LISTS, ONE PER DIRECTION
  // ---------------------------------------------------------------------------
  // Four `ListView` widgets laid out in a 2×2 grid, each driven by a different
  // AxisDirection.  We deliberately use the helper to derive scrollDirection
  // and reverse, demonstrating that a single AxisDirection cleanly maps onto
  // both ListView knobs.
  // ===========================================================================
  Widget listsCell(AxisDirection d) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            d.name,
            style: TextStyle(
              color: _listsInk,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          _directionalListPreview(
            direction: d,
            accent: _listsAccent,
            ink: _listsInk,
            itemCount: 30,
          ),
        ],
      ),
    );
  }

  final listsSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _listsBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _listsAccent.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Four ListViews, one per AxisDirection',
          style: TextStyle(
            color: _listsAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'scrollDirection ← axisDirectionToAxis(d), '
          'reverse ← axisDirectionIsReversed(d).  Scroll each preview to feel '
          'how the items grow.',
          style: TextStyle(color: _listsInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            listsCell(AxisDirection.up),
            listsCell(AxisDirection.right),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            listsCell(AxisDirection.down),
            listsCell(AxisDirection.left),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 — INTERACTIVE FLIP DEMO
  // ---------------------------------------------------------------------------
  // A `StatefulBuilder` holds a single AxisDirection.  A "Flip" button calls
  // `flipAxisDirection` and re-renders both the compass card and the list
  // preview, demonstrating that the helper is a true involution
  // (flip(flip(x)) == x).
  // ===========================================================================
  final flipSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _flipBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _flipAccent.withOpacity(0.4)),
    ),
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        AxisDirection current = AxisDirection.down;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'flipAxisDirection — interactive',
                  style: TextStyle(
                    color: _flipAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Click "Flip" to swap to the opposite AxisDirection. '
                  'Notice that flipping twice always returns the original.',
                  style: TextStyle(
                    color: _flipInk,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CustomPaint(
                        painter: _CompassCardPainter(
                          direction: current,
                          accent: _flipAccent,
                          muted: _flipInk,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'current = ${_directionLabel(current)}',
                            style: TextStyle(
                              color: _flipInk,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'flipped = '
                            '${_directionLabel(flipAxisDirection(current))}',
                            style: TextStyle(
                              color: _flipInk,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  setLocal(() {
                                    current = flipAxisDirection(current);
                                  });
                                },
                                icon: const Icon(Icons.swap_horiz),
                                label: const Text('Flip'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _flipAccent,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              for (final AxisDirection d
                                  in AxisDirection.values)
                                OutlinedButton(
                                  onPressed: () {
                                    setLocal(() => current = d);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: _flipAccent,
                                    side: BorderSide(color: _flipAccent),
                                  ),
                                  child: Text(d.name),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: _directionalListPreview(
                    direction: current,
                    accent: _flipAccent,
                    ink: _flipInk,
                    itemCount: 25,
                    width: 220,
                    height: 120,
                  ),
                ),
              ],
            );
          },
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 5 — axisDirectionIsReversed TRUTH TABLE
  // ---------------------------------------------------------------------------
  // For each value, we show the boolean returned by axisDirectionIsReversed
  // alongside a glyph drawn by `_ReversedBadgePainter`.  This gives a quick
  // mental hook: "up and left are reversed; right and down are forward".
  // ===========================================================================
  final reversedSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _reversedBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _reversedAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'axisDirectionIsReversed — truth table',
          style: TextStyle(
            color: _reversedAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Returns true for AxisDirection.up and AxisDirection.left, false '
          'for AxisDirection.right and AxisDirection.down.  This is the '
          'value `ListView.reverse` should be set to when configuring a list '
          'from an AxisDirection.',
          style: TextStyle(
            color: _reversedInk,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: AxisDirection.values.map((AxisDirection d) {
            final bool rev = axisDirectionIsReversed(d);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CustomPaint(
                      painter: _ReversedBadgePainter(
                        reversed: rev,
                        color: _reversedAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 130,
                    child: Text(
                      _directionLabel(d),
                      style: TextStyle(
                        color: _reversedInk,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    'reversed = $rev',
                    style: TextStyle(
                      color: rev ? _reversedAccent : _reversedInk,
                      fontWeight:
                          rev ? FontWeight.bold : FontWeight.normal,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 — axisDirectionToAxis GROUPING
  // ---------------------------------------------------------------------------
  // Groups the four AxisDirection values by the Axis they project to: up/down
  // both project to Axis.vertical, right/left both to Axis.horizontal.
  // ===========================================================================
  final verticalDirs = AxisDirection.values
      .where((AxisDirection d) => axisDirectionToAxis(d) == Axis.vertical)
      .toList();
  final horizontalDirs = AxisDirection.values
      .where((AxisDirection d) => axisDirectionToAxis(d) == Axis.horizontal)
      .toList();

  Widget axisGroupCard(String label, List<AxisDirection> dirs) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _toAxisAccent.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: _toAxisAccent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dirs.map((AxisDirection d) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _toAxisBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _toAxisAccent),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CustomPaint(
                          painter: _CompassCardPainter(
                            direction: d,
                            accent: _toAxisAccent,
                            muted: _toAxisInk,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        d.name,
                        style: TextStyle(
                          color: _toAxisInk,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  final toAxisSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _toAxisBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _toAxisAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'axisDirectionToAxis — projection to Axis',
          style: TextStyle(
            color: _toAxisAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Drops the sign and keeps only the axis.  Useful when feeding a '
          '`Flex`, `Wrap`, or `ListView.scrollDirection` that does not care '
          'about reversal — only orientation.',
          style: TextStyle(color: _toAxisInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            axisGroupCard('Axis.vertical', verticalDirs),
            axisGroupCard('Axis.horizontal', horizontalDirs),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — textDirectionToAxisDirection
  // ---------------------------------------------------------------------------
  // A short demo of how a writing-system TextDirection becomes a horizontal
  // AxisDirection.  LTR → right, RTL → left.  We render a `Directionality`
  // wrapper around a tiny row of children to make the effect visible.
  // ===========================================================================
  Widget textDirCard(TextDirection td) {
    final AxisDirection ad = textDirectionToAxisDirection(td);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _textDirAccent.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextDirection.${td.name}',
              style: TextStyle(
                color: _textDirAccent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '→ ${_directionLabel(ad)}',
              style: TextStyle(
                color: _textDirInk,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 56,
              child: Directionality(
                textDirection: td,
                child: Row(
                  children: List<Widget>.generate(5, (int i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _textDirAccent
                              .withOpacity(0.20 + i * 0.12),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _textDirAccent),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: _textDirAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 60,
              height: 60,
              child: CustomPaint(
                painter: _CompassCardPainter(
                  direction: ad,
                  accent: _textDirAccent,
                  muted: _textDirInk,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final textDirSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _textDirBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _textDirAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'textDirectionToAxisDirection',
          style: TextStyle(
            color: _textDirAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Bridges from TextDirection (writing-system reading order) to a '
          'horizontal AxisDirection.  Most lists and rows derive their '
          'forward direction this way under the hood.',
          style: TextStyle(color: _textDirInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            textDirCard(TextDirection.ltr),
            textDirCard(TextDirection.rtl),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — SCROLL POSITION TRACKING
  // ---------------------------------------------------------------------------
  // A small ListView wired to a ScrollController.  We listen to the controller
  // and rebuild a label showing the current pixels offset.  We use
  // AxisDirection.down to keep the demo familiar; the section's prose explains
  // how the same idea generalises to any AxisDirection.
  // ===========================================================================
  final scrollPosSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _scrollPosBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _scrollPosAccent.withOpacity(0.4)),
    ),
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final ScrollController controller = ScrollController();
        double pixels = 0.0;
        const AxisDirection direction = AxisDirection.down;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            controller.addListener(() {
              if (controller.hasClients) {
                final double p = controller.position.pixels;
                if ((p - pixels).abs() > 0.5) {
                  setLocal(() => pixels = p);
                }
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scroll position (AxisDirection.down)',
                  style: TextStyle(
                    color: _scrollPosAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A ScrollController surfaces the pixel offset along the '
                  'AxisDirection of the underlying viewport.  When the '
                  'direction is reversed, pixels still grow from 0 at the '
                  'origin — which is the visual end for up and left.',
                  style: TextStyle(
                    color: _scrollPosInk,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _scrollPosInk.withOpacity(0.5)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ListView.builder(
                        controller: controller,
                        scrollDirection: axisDirectionToAxis(direction),
                        reverse: axisDirectionIsReversed(direction),
                        itemCount: 60,
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _scrollPosAccent.withOpacity(
                                  0.15 + (i % 6) * 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'item $i',
                              style: TextStyle(
                                color: _scrollPosInk,
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _kvChip('axis',
                              axisDirectionToAxis(direction).name,
                              _scrollPosInk),
                          const SizedBox(height: 4),
                          _kvChip('reversed',
                              axisDirectionIsReversed(direction).toString(),
                              _scrollPosInk),
                          const SizedBox(height: 4),
                          _kvChip('flip',
                              flipAxisDirection(direction).name,
                              _scrollPosInk),
                          const SizedBox(height: 8),
                          Text(
                            'pixels = ${pixels.toStringAsFixed(1)}',
                            style: TextStyle(
                              color: _scrollPosAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ),
  );

  // ===========================================================================
  // SECTION 9 — CUSTOMSCROLLVIEW + SLIVERS
  // ---------------------------------------------------------------------------
  // CustomScrollView consumes a single AxisDirection-shaped scrollDirection
  // (Axis) plus a `reverse` boolean, exactly like ListView.  We show two
  // example viewports — one for AxisDirection.down with a pinned SliverAppBar,
  // and one for AxisDirection.right with floating headers between groups.
  // ===========================================================================
  Widget sliverViewport(AxisDirection direction) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _sliverInk.withOpacity(0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomScrollView(
        scrollDirection: axisDirectionToAxis(direction),
        reverse: axisDirectionIsReversed(direction),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(6),
              color: _sliverAccent.withOpacity(0.25),
              child: Text(
                'header (${direction.name})',
                style: TextStyle(
                  color: _sliverInk,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int i) {
                final bool horizontal =
                    axisDirectionToAxis(direction) == Axis.horizontal;
                return Container(
                  width: horizontal ? 60 : null,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _sliverAccent.withOpacity(0.12 + (i % 5) * 0.10),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'sliver $i',
                    style: TextStyle(
                      color: _sliverInk,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                );
              },
              childCount: 18,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(6),
              color: _sliverAccent.withOpacity(0.18),
              child: Text(
                'footer',
                style: TextStyle(
                  color: _sliverInk,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final sliverSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _sliverBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _sliverAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CustomScrollView slivers per AxisDirection',
          style: TextStyle(
            color: _sliverAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Slivers also live inside an AxisDirection-shaped viewport.  The '
          'same helpers translate the enum into scrollDirection + reverse.',
          style: TextStyle(color: _sliverInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  AxisDirection.down.name,
                  style: TextStyle(
                    color: _sliverInk,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                sliverViewport(AxisDirection.down),
              ],
            ),
            Column(
              children: [
                Text(
                  AxisDirection.right.name,
                  style: TextStyle(
                    color: _sliverInk,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                sliverViewport(AxisDirection.right),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — NESTEDSCROLLVIEW
  // ---------------------------------------------------------------------------
  // NestedScrollView is the canonical "outer + inner" scrolling pattern.  Its
  // outer scroll axis is fixed to AxisDirection.down — this section explains
  // why and shows a small live example.
  // ===========================================================================
  final nestedSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _nestedBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _nestedAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NestedScrollView (outer = AxisDirection.down)',
          style: TextStyle(
            color: _nestedAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A NestedScrollView pins its outer viewport to AxisDirection.down '
          'so the SliverAppBar collapses while the inner viewport keeps '
          'scrolling.  The inner viewport may be any AxisDirection.',
          style: TextStyle(color: _nestedInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 10),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _nestedInk.withOpacity(0.4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext c, bool inner) => <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: _nestedAccent.withOpacity(0.18),
                  child: Text(
                    'outer header (down)',
                    style: TextStyle(
                      color: _nestedInk,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            body: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  dense: true,
                  title: Text(
                    'inner item $i',
                    style: TextStyle(
                      color: _nestedInk,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 — RECIPE: CHAT (down-reversed for newest-on-bottom)
  // ---------------------------------------------------------------------------
  // Most chat UIs need new messages at the visual bottom but want to load
  // history at the top.  The classic trick: scrollDirection vertical, reverse
  // = true.  Translated: AxisDirection.up.
  // ===========================================================================
  final chatSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _chatBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _chatAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe: chat (AxisDirection.up)',
          style: TextStyle(
            color: _chatAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Chat apps use a reversed vertical viewport so the newest message '
          'is at the bottom and `index 0` is the latest.  Encoded as '
          'AxisDirection.up — vertical + reversed.',
          style: TextStyle(color: _chatInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _chatInk.withOpacity(0.4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.builder(
                scrollDirection:
                    axisDirectionToAxis(AxisDirection.up),
                reverse: axisDirectionIsReversed(AxisDirection.up),
                itemCount: 30,
                padding: const EdgeInsets.all(6),
                itemBuilder: (BuildContext context, int i) {
                  final bool me = i.isOdd;
                  return Align(
                    alignment:
                        me ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: me
                            ? _chatAccent.withOpacity(0.85)
                            : _chatAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        me ? 'me #$i' : 'them #$i',
                        style: TextStyle(
                          color: me ? Colors.white : _chatInk,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kvChip('direction', 'up', _chatInk),
                  const SizedBox(height: 4),
                  _kvChip('axis',
                      axisDirectionToAxis(AxisDirection.up).name,
                      _chatInk),
                  const SizedBox(height: 4),
                  _kvChip('reversed',
                      axisDirectionIsReversed(AxisDirection.up).toString(),
                      _chatInk),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 — RECIPE: GALLERY (right)
  // ---------------------------------------------------------------------------
  // Horizontal gallery scrolling, LTR forward.  AxisDirection.right.
  // ===========================================================================
  final gallerySection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _galleryBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _galleryAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe: gallery (AxisDirection.right)',
          style: TextStyle(
            color: _galleryAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Photo or product galleries use a horizontal LTR viewport. '
          'Encoded as AxisDirection.right — horizontal + forward.',
          style: TextStyle(color: _galleryInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection:
                axisDirectionToAxis(AxisDirection.right),
            reverse: axisDirectionIsReversed(AxisDirection.right),
            itemCount: 16,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                width: 100,
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _galleryAccent.withOpacity(0.15 + (i % 5) * 0.10),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _galleryAccent),
                ),
                alignment: Alignment.center,
                child: Text(
                  'photo $i',
                  style: TextStyle(
                    color: _galleryInk,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 — RECIPE: BOOKSHELF (down)
  // ---------------------------------------------------------------------------
  // Default vertical reading list.  AxisDirection.down.
  // ===========================================================================
  final bookshelfSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _bookshelfBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _bookshelfAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe: bookshelf (AxisDirection.down)',
          style: TextStyle(
            color: _bookshelfAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Top-down book or chapter list — the default for most content. '
          'Encoded as AxisDirection.down — vertical + forward.',
          style: TextStyle(
            color: _bookshelfInk,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _bookshelfInk.withOpacity(0.4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            scrollDirection:
                axisDirectionToAxis(AxisDirection.down),
            reverse: axisDirectionIsReversed(AxisDirection.down),
            itemCount: 24,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _bookshelfAccent
                            .withOpacity(0.20 + (i % 5) * 0.10),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: _bookshelfAccent),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Chapter ${i + 1}',
                      style: TextStyle(
                        color: _bookshelfInk,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 — RECIPE: FEED (down with refresh-on-top)
  // ---------------------------------------------------------------------------
  // A standard social feed: AxisDirection.down with a pull-to-refresh placed
  // at index 0.  We do not wire RefreshIndicator here (it requires a Material
  // ancestor and would expand the scope), but we describe the affordance.
  // ===========================================================================
  final feedSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _feedBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _feedAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe: feed (AxisDirection.down)',
          style: TextStyle(
            color: _feedAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A typical news/social feed runs top-to-bottom but distinguishes '
          '"newer" (above) and "older" (below).  Encoded as '
          'AxisDirection.down with a refresh affordance at the start edge.',
          style: TextStyle(color: _feedInk, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _feedInk.withOpacity(0.4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 22,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  color: _feedAccent.withOpacity(0.15),
                  child: Row(
                    children: [
                      Icon(Icons.refresh, color: _feedAccent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'pull to refresh',
                        style: TextStyle(
                          color: _feedInk,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _feedAccent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'post $i — preview line',
                    style: TextStyle(color: _feedInk, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 — DECISION CARD
  // ---------------------------------------------------------------------------
  // Quick guidance: which AxisDirection to choose for which scenario, with a
  // brief note about screen-reader semantics (which usually follow reading
  // order, not painted order).
  // ===========================================================================
  final decisionRows = <Map<String, String>>[
    {
      'direction': 'AxisDirection.down',
      'use_for':
          'Default vertical content (articles, settings, file lists, etc.)',
    },
    {
      'direction': 'AxisDirection.right',
      'use_for':
          'Horizontal LTR carousels: galleries, tabs, story strips.',
    },
    {
      'direction': 'AxisDirection.up',
      'use_for':
          'Reversed vertical: chat where the newest message hugs the bottom.',
    },
    {
      'direction': 'AxisDirection.left',
      'use_for':
          'RTL forward horizontal viewports — usually derived via '
          'textDirectionToAxisDirection rather than hard-coded.',
    },
  ];

  final decisionSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _decisionBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _decisionAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decision card — when to pick each value',
          style: TextStyle(
            color: _decisionAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        ...decisionRows.map((Map<String, String> r) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: _decisionAccent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    r['direction']!,
                    style: TextStyle(
                      color: _decisionInk,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    r['use_for']!,
                    style: TextStyle(
                      color: _decisionInk,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        Text(
          'Accessibility note: regardless of the painted AxisDirection, '
          'screen-reader traversal follows logical (semantic) order, not '
          'visual order.  AxisDirection.up does not invert the announcement '
          'sequence — it only flips the painting.',
          style: TextStyle(
            color: _decisionInk,
            fontSize: 11,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 16 — REFERENCE TABLE
  // ---------------------------------------------------------------------------
  // A single, dense table summarising every value and helper return value.
  // ===========================================================================
  final referenceRows = AxisDirection.values.map((AxisDirection d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CustomPaint(
              painter: _CompassCardPainter(
                direction: d,
                accent: _refAccent,
                muted: _refInk,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: Text(
              _directionLabel(d),
              style: TextStyle(
                color: _refInk,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              'axis = ${axisDirectionToAxis(d).name}',
              style: TextStyle(
                color: _refInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'rev = ${axisDirectionIsReversed(d)}',
              style: TextStyle(
                color: _refInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'flip = ${flipAxisDirection(d).name}',
              style: TextStyle(
                color: _refInk,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final referenceSection = Container(
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 24),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _refBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _refAccent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference — every value & helper',
          style: TextStyle(
            color: _refAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'enum: AxisDirection { up, right, down, left }',
          style: TextStyle(
            color: _refInk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 6),
        ...referenceRows,
        const SizedBox(height: 6),
        Text(
          'helpers:',
          style: TextStyle(
            color: _refInk,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        Text(
          '  flipAxisDirection(AxisDirection)            → AxisDirection',
          style: TextStyle(
            color: _refInk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        Text(
          '  axisDirectionIsReversed(AxisDirection)      → bool',
          style: TextStyle(
            color: _refInk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        Text(
          '  axisDirectionToAxis(AxisDirection)          → Axis',
          style: TextStyle(
            color: _refInk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        Text(
          '  textDirectionToAxisDirection(TextDirection) → AxisDirection',
          style: TextStyle(
            color: _refInk,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // Compose the body.
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              _sectionHeader('2', 'Compass cards per AxisDirection',
                  _compassBg, _compassInk),
              _bodyText(
                'Each card pairs a hand-painted arrow with the matching '
                'enum value, plus a faint axis line that highlights '
                'horizontal vs vertical orientation.',
                color: _compassInk,
              ),
              compassSection,
              _footerCaption(
                'Tip: rotation = right(0), down(+90°), left(180°), up(-90°).',
                _compassInk,
              ),
              _sectionHeader('3', 'Four ListViews — one per direction',
                  _listsBg, _listsInk),
              listsSection,
              _footerCaption(
                'Each preview is a real ListView.builder configured from a '
                'single AxisDirection via the helpers.',
                _listsInk,
              ),
              _sectionHeader('4', 'flipAxisDirection — interactive',
                  _flipBg, _flipInk),
              flipSection,
              _footerCaption(
                'flip(flip(x)) == x for every AxisDirection — the helper is '
                'an involution.',
                _flipInk,
              ),
              _sectionHeader('5', 'axisDirectionIsReversed — truth table',
                  _reversedBg, _reversedInk),
              reversedSection,
              _footerCaption(
                'Reversal is shared between AxisDirection.up and '
                'AxisDirection.left — both grow opposite to the natural '
                'reading order.',
                _reversedInk,
              ),
              _sectionHeader('6', 'axisDirectionToAxis — projection',
                  _toAxisBg, _toAxisInk),
              toAxisSection,
              _footerCaption(
                'Use this when you only care about orientation — for '
                'example when configuring a Flex.',
                _toAxisInk,
              ),
              _sectionHeader('7', 'textDirectionToAxisDirection',
                  _textDirBg, _textDirInk),
              textDirSection,
              _footerCaption(
                'This is how a Directionality ancestor turns into a '
                'horizontal AxisDirection at layout time.',
                _textDirInk,
              ),
              _sectionHeader('8', 'ScrollController + AxisDirection',
                  _scrollPosBg, _scrollPosInk),
              scrollPosSection,
              _footerCaption(
                'pixels grow from 0 at the origin edge, regardless of '
                'whether that edge is visually top or bottom.',
                _scrollPosInk,
              ),
              _sectionHeader('9', 'CustomScrollView slivers',
                  _sliverBg, _sliverInk),
              sliverSection,
              _footerCaption(
                'Slivers honour the same scrollDirection + reverse pair '
                'derived from AxisDirection.',
                _sliverInk,
              ),
              _sectionHeader('10', 'NestedScrollView',
                  _nestedBg, _nestedInk),
              nestedSection,
              _footerCaption(
                'Outer is fixed AxisDirection.down; inner viewport may be '
                'any AxisDirection.',
                _nestedInk,
              ),
              _sectionHeader('11', 'Recipe: chat (up)', _chatBg, _chatInk),
              chatSection,
              _footerCaption(
                'AxisDirection.up keeps the newest message at the bottom '
                'with index 0 = latest.',
                _chatInk,
              ),
              _sectionHeader('12', 'Recipe: gallery (right)',
                  _galleryBg, _galleryInk),
              gallerySection,
              _footerCaption(
                'AxisDirection.right is the canonical horizontal LTR '
                'forward viewport.',
                _galleryInk,
              ),
              _sectionHeader('13', 'Recipe: bookshelf (down)',
                  _bookshelfBg, _bookshelfInk),
              bookshelfSection,
              _footerCaption(
                'AxisDirection.down is the most common direction — the '
                'default for vertical ListView.',
                _bookshelfInk,
              ),
              _sectionHeader('14', 'Recipe: feed (down + refresh)',
                  _feedBg, _feedInk),
              feedSection,
              _footerCaption(
                'Refresh affordance lives at the start edge of the '
                'AxisDirection — visual top for AxisDirection.down.',
                _feedInk,
              ),
              _sectionHeader('15', 'Decision card',
                  _decisionBg, _decisionInk),
              decisionSection,
              _sectionHeader('16', 'Reference table',
                  _refBg, _refInk),
              referenceSection,
            ],
          ),
        ),
      ),
    ),
  );
}
