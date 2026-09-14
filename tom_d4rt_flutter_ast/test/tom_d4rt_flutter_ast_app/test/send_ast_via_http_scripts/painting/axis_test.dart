// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// Axis (painting) — Deep Demo
// -----------------------------------------------------------------------------
// `Axis` is one of the smallest yet most pervasive types in Flutter.  It is a
// two-value enum exposed from `package:flutter/painting.dart` (re-exported by
// `widgets.dart` and `material.dart`):
//
//   enum Axis {
//     horizontal,
//     vertical,
//   }
//
// Alongside the enum the painting library ships a single tiny helper
//
//   Axis flipAxis(Axis direction);
//
// which turns `horizontal` into `vertical` and vice versa.  These two pieces
// constitute the public API surface examined here.  Despite that minimal
// surface area, `Axis` parameterises a remarkable share of Flutter layout: it
// is the one-bit input that decides whether a list scrolls left-right or
// up-down, whether a wrap flows in rows or columns, whether a `Stepper` lays
// its steps inline or stacked, and whether a `ToggleButtons` group runs
// across or down.  This file deliberately does NOT cover `AxisDirection` (the
// 4-valued cousin that adds a sign).  A sibling demo `axis_direction_test.dart`
// owns that material.  Here we focus on `Axis` itself plus the widgets it
// configures.
//
// Harness contract recap
// ----------------------
//   * the first non-comment line is the analyzer ignore directive,
//   * imports stay restricted to `package:flutter/material.dart`,
//   * a single top-level `dynamic build(BuildContext context)` returns a
//     `MaterialApp` whose body is a `Scaffold` → `SafeArea` →
//     `SingleChildScrollView` → `Column` of section cards,
//   * no `main()`, no `runApp()`, no `testWidgets()`,
//   * each interactive section runs inside a `StatefulBuilder` so that the
//     section's local state stays inside the section.
//
// Each section paints a card-style container with a distinct palette so that
// scrolling the harness produces an obvious vertical rhythm.  Educational
// prose explains *when* to reach for each `Axis` value and *which* widgets
// accept it.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Distinct section palettes.  We use a small constant table per section so the
// colour choices do not drift mid-section and so reviewers can see at a glance
// which colours belong to which scenario.
// -----------------------------------------------------------------------------
const Color _enumBg = Color(0xFFE8F5E9);
const Color _enumAccent = Color(0xFF2E7D32);
const Color _enumInk = Color(0xFF173B19);

const Color _flipBg = Color(0xFFFFF3E0);
const Color _flipAccent = Color(0xFFE65100);
const Color _flipInk = Color(0xFF5C2400);

const Color _listBg = Color(0xFFF3E5F5);
const Color _listAccent = Color(0xFF6A1B9A);
const Color _listInk = Color(0xFF2E0A47);

const Color _gridBg = Color(0xFFE0F7FA);
const Color _gridAccent = Color(0xFF00838F);
const Color _gridInk = Color(0xFF003844);

const Color _pageBg = Color(0xFFEDE7F6);
const Color _pageAccent = Color(0xFF4527A0);
const Color _pageInk = Color(0xFF1A0E4D);

const Color _stepperBg = Color(0xFFFCE4EC);
const Color _stepperAccent = Color(0xFFAD1457);
const Color _stepperInk = Color(0xFF560027);

const Color _toggleBg = Color(0xFFE8EAF6);
const Color _toggleAccent = Color(0xFF283593);
const Color _toggleInk = Color(0xFF101542);

const Color _reorderBg = Color(0xFFE0F2F1);
const Color _reorderAccent = Color(0xFF00695C);
const Color _reorderInk = Color(0xFF002B26);

const Color _wrapBg = Color(0xFFFFF8E1);
const Color _wrapAccent = Color(0xFFF57F17);
const Color _wrapInk = Color(0xFF5C3A00);

const Color _flexBg = Color(0xFFEFEBE9);
const Color _flexAccent = Color(0xFF4E342E);
const Color _flexInk = Color(0xFF1F0F0A);

const Color _viewportBg = Color(0xFFE1F5FE);
const Color _viewportAccent = Color(0xFF0277BD);
const Color _viewportInk = Color(0xFF002F4E);

const Color _decisionBg = Color(0xFFF1F8E9);
const Color _decisionAccent = Color(0xFF33691E);
const Color _decisionInk = Color(0xFF1B3300);

const Color _refBg = Color(0xFFECEFF1);
const Color _refAccent = Color(0xFF37474F);
const Color _refInk = Color(0xFF1B262C);

// -----------------------------------------------------------------------------
// _AxisLinePainter — a tiny custom painter that draws a labelled axis line
// running either horizontally or vertically through the centre of the canvas.
// We use it in the per-value section to give the reader an immediate visual
// of what `Axis.horizontal` and `Axis.vertical` actually orient.
// -----------------------------------------------------------------------------
class _AxisLinePainter extends CustomPainter {
  const _AxisLinePainter({required this.axis, required this.color});

  final Axis axis;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final Paint dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint guidePaint = Paint()
      ..color = color.withOpacity(0.18)
      ..strokeWidth = 1.0;

    // Background guide grid.
    const double step = 16.0;
    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), guidePaint);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), guidePaint);
    }

    if (axis == Axis.horizontal) {
      final double midY = size.height / 2.0;
      canvas.drawLine(
        Offset(8, midY),
        Offset(size.width - 8, midY),
        linePaint,
      );
      // Arrow head right.
      final Path arrow = Path()
        ..moveTo(size.width - 8, midY)
        ..lineTo(size.width - 18, midY - 8)
        ..lineTo(size.width - 18, midY + 8)
        ..close();
      canvas.drawPath(arrow, dotPaint);
      canvas.drawCircle(Offset(8, midY), 4, dotPaint);
    } else {
      final double midX = size.width / 2.0;
      canvas.drawLine(
        Offset(midX, 8),
        Offset(midX, size.height - 8),
        linePaint,
      );
      final Path arrow = Path()
        ..moveTo(midX, size.height - 8)
        ..lineTo(midX - 8, size.height - 18)
        ..lineTo(midX + 8, size.height - 18)
        ..close();
      canvas.drawPath(arrow, dotPaint);
      canvas.drawCircle(Offset(midX, 8), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_AxisLinePainter oldDelegate) {
    return oldDelegate.axis != axis || oldDelegate.color != color;
  }
}

// -----------------------------------------------------------------------------
// _FlipDiagramPainter — visualises the action of `flipAxis` with a labelled
// pair of arrows: one along the input axis, one along the output axis, joined
// by a curved "flip" arc.
// -----------------------------------------------------------------------------
class _FlipDiagramPainter extends CustomPainter {
  const _FlipDiagramPainter({required this.from});

  final Axis from;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint inputPaint = Paint()
      ..color = const Color(0xFFE65100)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final Paint outputPaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final Paint arcPaint = Paint()
      ..color = const Color(0xFF6A1B9A).withOpacity(0.6)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    const double half = 60.0;

    // Draw input axis.
    if (from == Axis.horizontal) {
      canvas.drawLine(
        Offset(center.dx - half, center.dy - 30),
        Offset(center.dx + half, center.dy - 30),
        inputPaint,
      );
    } else {
      canvas.drawLine(
        Offset(center.dx - 30, center.dy - half),
        Offset(center.dx - 30, center.dy + half),
        inputPaint,
      );
    }

    // Draw output (flipped) axis.
    if (from == Axis.horizontal) {
      canvas.drawLine(
        Offset(center.dx + 30, center.dy - half),
        Offset(center.dx + 30, center.dy + half),
        outputPaint,
      );
    } else {
      canvas.drawLine(
        Offset(center.dx - half, center.dy + 30),
        Offset(center.dx + half, center.dy + 30),
        outputPaint,
      );
    }

    // Curved arrow connecting input → output.
    final Path arc = Path();
    if (from == Axis.horizontal) {
      arc.moveTo(center.dx, center.dy - 30);
      arc.quadraticBezierTo(
        center.dx + 50,
        center.dy - 30,
        center.dx + 30,
        center.dy,
      );
    } else {
      arc.moveTo(center.dx - 30, center.dy);
      arc.quadraticBezierTo(
        center.dx - 30,
        center.dy + 50,
        center.dx,
        center.dy + 30,
      );
    }
    canvas.drawPath(arc, arcPaint);
  }

  @override
  bool shouldRepaint(_FlipDiagramPainter oldDelegate) {
    return oldDelegate.from != from;
  }
}

// -----------------------------------------------------------------------------
// _CompassPainter — simple compass illustrating which Axis maps to which on
// screen.  Used in the reference card.
// -----------------------------------------------------------------------------
class _CompassPainter extends CustomPainter {
  const _CompassPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2 - 6;

    final Paint ring = Paint()
      ..color = const Color(0xFF455A64)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(center, radius, ring);

    final Paint hPaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Paint vPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(center.dx - radius + 4, center.dy),
      Offset(center.dx + radius - 4, center.dy),
      hPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius + 4),
      Offset(center.dx, center.dy + radius - 4),
      vPaint,
    );

    canvas.drawCircle(center, 3, Paint()..color = const Color(0xFF263238));
  }

  @override
  bool shouldRepaint(_CompassPainter oldDelegate) => false;
}

// =============================================================================
// build — main entry point for the harness.  Each section is wrapped in a
// helper to keep this function reasonably navigable.
// =============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Axis Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _heroSection(),
              const SizedBox(height: 18),
              _enumValuesSection(),
              const SizedBox(height: 18),
              _flipAxisSection(),
              const SizedBox(height: 18),
              _listViewSection(),
              const SizedBox(height: 18),
              _gridViewSection(),
              const SizedBox(height: 18),
              _pageViewSection(),
              const SizedBox(height: 18),
              _stepperSection(),
              const SizedBox(height: 18),
              _toggleButtonsSection(),
              const SizedBox(height: 18),
              _reorderableSection(),
              const SizedBox(height: 18),
              _wrapSection(),
              const SizedBox(height: 18),
              _flexCousinsSection(),
              const SizedBox(height: 18),
              _viewportNoteSection(),
              const SizedBox(height: 18),
              _decisionSection(),
              const SizedBox(height: 18),
              _referenceCardSection(),
              const SizedBox(height: 24),
              _footerSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: hero header.
// -----------------------------------------------------------------------------
Widget _heroSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 44,
                height: 44,
                child: CustomPaint(painter: const _CompassPainter()),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Axis',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'package:flutter/painting.dart',
                    style: TextStyle(fontSize: 13, color: Color(0xFFBBDEFB)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'A two-value orientation enum — `horizontal` and `vertical` — '
          'plus the helper `flipAxis` that toggles between them.  '
          'Despite the tiny surface, Axis configures scrolling lists, grids, '
          'pages, steppers, toggles, reorderables, wraps, and viewports.',
          style: TextStyle(fontSize: 14, color: Colors.white, height: 1.45),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _heroChip('enum', Colors.white24),
            _heroChip('horizontal', Colors.white24),
            _heroChip('vertical', Colors.white24),
            _heroChip('flipAxis()', Colors.white24),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 1: enum values — hand-painted axis lines for each value.
// -----------------------------------------------------------------------------
Widget _enumValuesSection() {
  return _sectionShell(
    bg: _enumBg,
    accent: _enumAccent,
    ink: _enumInk,
    title: '1. Enum values',
    subtitle: 'Axis.horizontal and Axis.vertical visualised.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The `Axis` enum has only two members.  In painter terms, '
          '`Axis.horizontal` runs left-to-right, parallel to the screen '
          'width, while `Axis.vertical` runs top-to-bottom, parallel to '
          'the screen height.  The painters below draw a labelled arrow '
          'along each axis on top of a faint grid for orientation.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(child: _axisCard(Axis.horizontal, _enumAccent)),
            const SizedBox(width: 12),
            Expanded(child: _axisCard(Axis.vertical, _enumAccent)),
          ],
        ),
        const SizedBox(height: 14),
        _kvRow('Axis.values.length', '2'),
        _kvRow('Axis.horizontal.index', '0'),
        _kvRow('Axis.vertical.index', '1'),
        _kvRow('Axis.values', '[horizontal, vertical]'),
      ],
    ),
  );
}

Widget _axisCard(Axis axis, Color accent) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          axis == Axis.horizontal ? 'Axis.horizontal' : 'Axis.vertical',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 110,
          child: CustomPaint(
            painter: _AxisLinePainter(axis: axis, color: accent),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          axis == Axis.horizontal
              ? 'Used for left-to-right flow: ListView side-scrollers, '
                    'horizontal toggles, page carousels.'
              : 'Used for top-to-bottom flow: standard ListView, '
                    'vertical Stepper, ToggleButtons columns.',
          style: const TextStyle(fontSize: 11, height: 1.4),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 2: flipAxis helper — interactive toggle.
// -----------------------------------------------------------------------------
Widget _flipAxisSection() {
  return _sectionShell(
    bg: _flipBg,
    accent: _flipAccent,
    ink: _flipInk,
    title: '2. flipAxis() helper',
    subtitle: 'Toggles Axis.horizontal ↔ Axis.vertical.',
    body: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _FlipAxisInner(setState: setState);
      },
    ),
  );
}

class _FlipAxisInner extends StatefulWidget {
  const _FlipAxisInner({required this.setState});
  final StateSetter setState;
  @override
  State<_FlipAxisInner> createState() => _FlipAxisInnerState();
}

class _FlipAxisInnerState extends State<_FlipAxisInner> {
  Axis current = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    final Axis flipped = current == Axis.horizontal
        ? Axis.vertical
        : Axis.horizontal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '`flipAxis(Axis.horizontal)` returns `Axis.vertical` and '
          '`flipAxis(Axis.vertical)` returns `Axis.horizontal`.  It is a '
          'one-line helper but it is widely used inside scroll-bridge '
          'machinery (e.g. mapping a list axis to its cross axis when '
          'computing scrollbar geometry).  Tap the button to flip the '
          'current axis and watch the painter rotate.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _flipAccent.withOpacity(0.3)),
          ),
          child: CustomPaint(
            painter: _FlipDiagramPainter(from: current),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'input',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      'Axis.${current.name}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, color: Color(0xFF6A1B9A)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'flipAxis(input)',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      'Axis.${flipped.name}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                current = flipped;
              });
            },
            icon: const Icon(Icons.swap_horiz),
            label: const Text('Flip axis'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _flipAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pseudocode:\n'
          '  Axis flipAxis(Axis a) =>\n'
          '      a == Axis.horizontal ? Axis.vertical : Axis.horizontal;',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Section 3: ListView with scrollDirection — side-by-side comparison.
// -----------------------------------------------------------------------------
Widget _listViewSection() {
  final List<int> data = List<int>.generate(20, (int i) => i + 1);
  return _sectionShell(
    bg: _listBg,
    accent: _listAccent,
    ink: _listInk,
    title: '3. ListView.scrollDirection',
    subtitle:
        'A horizontal list and a vertical list, fed by the same data set.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ListView accepts an `Axis scrollDirection` (default '
          '`Axis.vertical`).  When set to `Axis.horizontal` the list lays '
          'children left-to-right; when set to `Axis.vertical` (the '
          'default) it stacks them top-to-bottom.  Notice that the '
          '*cross-axis* size must be bounded — a horizontal ListView '
          'needs a height, a vertical one needs a width.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _miniLabel('Axis.horizontal'),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _listAccent.withOpacity(0.3)),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (final int n in data) _tile(n, _listAccent),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('Axis.vertical (default)'),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _listAccent.withOpacity(0.3)),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (final int n in data.take(8)) _vTile(n, _listAccent),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tile(int n, Color accent) {
  return Container(
    width: 60,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Center(
      child: Text(
        '#$n',
        style: TextStyle(color: accent, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _vTile(int n, Color accent) {
  return Container(
    height: 36,
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: accent.withOpacity(0.10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Text('Item #$n', style: TextStyle(color: accent)),
  );
}

// -----------------------------------------------------------------------------
// Section 4: GridView with scrollDirection.
// -----------------------------------------------------------------------------
Widget _gridViewSection() {
  return _sectionShell(
    bg: _gridBg,
    accent: _gridAccent,
    ink: _gridInk,
    title: '4. GridView.scrollDirection',
    subtitle:
        'Both axes for `GridView.count` — note the cross-axis count is '
        'measured against the *cross* axis, not the scroll axis.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A GridView with `scrollDirection: Axis.horizontal` and '
          '`crossAxisCount: 3` lays out three rows running left-to-right; '
          'flipping to vertical reuses the same `crossAxisCount` to mean '
          '"three columns".  The cross-axis count is always relative to '
          'the chosen axis, which is why the same number can produce '
          'visually different layouts.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _miniLabel('horizontal grid (3 rows)'),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _gridAccent.withOpacity(0.3)),
          ),
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (int i = 1; i <= 18; i++) _gridCell(i, _gridAccent),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('vertical grid (3 columns)'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _gridAccent.withOpacity(0.3)),
          ),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              for (int i = 1; i <= 12; i++) _gridCell(i, _gridAccent),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _gridCell(int n, Color accent) {
  return Container(
    decoration: BoxDecoration(
      color: accent.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Center(
      child: Text(
        '$n',
        style: TextStyle(color: accent, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 5: PageView.scrollDirection.
// -----------------------------------------------------------------------------
Widget _pageViewSection() {
  return _sectionShell(
    bg: _pageBg,
    accent: _pageAccent,
    ink: _pageInk,
    title: '5. PageView.scrollDirection',
    subtitle: 'Carousel pagination horizontally and vertically.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'PageView is a paginating scrollable; its `scrollDirection` is '
          'an `Axis` exactly like ListView, but each "page" snaps to the '
          'viewport size.  Vertical PageViews are commonly used for '
          'TikTok-style feeds; horizontal PageViews back onboarding and '
          'image carousels.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _miniLabel('horizontal pages'),
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _pageAccent.withOpacity(0.3)),
          ),
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _pageBox('Page 1', _pageAccent),
              _pageBox('Page 2', _pageAccent),
              _pageBox('Page 3', _pageAccent),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('vertical pages'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _pageAccent.withOpacity(0.3)),
          ),
          child: PageView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _pageBox('Top', _pageAccent),
              _pageBox('Middle', _pageAccent),
              _pageBox('Bottom', _pageAccent),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pageBox(String label, Color accent) {
  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 6: Stepper — uses StepperType, not Axis directly, but the values
// map 1:1.  We discuss the equivalence and demonstrate both orientations.
// -----------------------------------------------------------------------------
Widget _stepperSection() {
  return _sectionShell(
    bg: _stepperBg,
    accent: _stepperAccent,
    ink: _stepperInk,
    title: '6. Stepper (via StepperType)',
    subtitle: 'StepperType.horizontal and .vertical mirror the Axis values.',
    body: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _StepperInner();
      },
    ),
  );
}

class _StepperInner extends StatefulWidget {
  @override
  State<_StepperInner> createState() => _StepperInnerState();
}

class _StepperInnerState extends State<_StepperInner> {
  int currentStep = 0;
  StepperType type = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '`Stepper` does not take an `Axis`; it takes a `StepperType` enum '
          'with two values that map directly to the Axis values: '
          '`StepperType.horizontal` ≡ `Axis.horizontal`, '
          '`StepperType.vertical` ≡ `Axis.vertical`.  This is a recurring '
          'Flutter pattern: a widget defines its own stronger-typed enum to '
          'avoid spreading `Axis` semantics across unrelated APIs.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            ChoiceChip(
              label: const Text('horizontal'),
              selected: type == StepperType.horizontal,
              onSelected: (bool v) {
                if (v) setState(() => type = StepperType.horizontal);
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('vertical'),
              selected: type == StepperType.vertical,
              onSelected: (bool v) {
                if (v) setState(() => type = StepperType.vertical);
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _stepperAccent.withOpacity(0.3)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: _stepperAccent,
              ),
            ),
            child: Stepper(
              type: type,
              currentStep: currentStep,
              onStepTapped: (int i) => setState(() => currentStep = i),
              onStepContinue: () {
                if (currentStep < 2) {
                  setState(() => currentStep++);
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() => currentStep--);
                }
              },
              steps: const <Step>[
                Step(
                  title: Text('Source'),
                  content: Text('Pick the source axis to flip.'),
                ),
                Step(
                  title: Text('Flip'),
                  content: Text('Apply flipAxis to obtain the cross axis.'),
                ),
                Step(
                  title: Text('Done'),
                  content: Text('Use the cross axis for layout queries.'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Section 7: ToggleButtons — direction is an Axis.
// -----------------------------------------------------------------------------
Widget _toggleButtonsSection() {
  return _sectionShell(
    bg: _toggleBg,
    accent: _toggleAccent,
    ink: _toggleInk,
    title: '7. ToggleButtons.direction',
    subtitle:
        'A genuine `Axis` parameter — flips the layout from a row to a column.',
    body: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _ToggleButtonsInner();
      },
    ),
  );
}

class _ToggleButtonsInner extends StatefulWidget {
  @override
  State<_ToggleButtonsInner> createState() => _ToggleButtonsInnerState();
}

class _ToggleButtonsInnerState extends State<_ToggleButtonsInner> {
  List<bool> selected = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ToggleButtons accepts an `Axis direction` (default '
          '`Axis.horizontal`) and an optional `verticalDirection` for the '
          'cross axis.  Flipping the direction is one of the cleanest '
          'demonstrations of `Axis` because the layout reorients without '
          'any other code changes.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  _miniLabel('horizontal'),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    isSelected: selected,
                    onPressed: (int i) {
                      setState(() {
                        for (int j = 0; j < selected.length; j++) {
                          selected[j] = j == i;
                        }
                      });
                    },
                    color: _toggleAccent,
                    selectedColor: Colors.white,
                    fillColor: _toggleAccent,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('A'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('B'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('C'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: <Widget>[
                  _miniLabel('vertical'),
                  ToggleButtons(
                    direction: Axis.vertical,
                    isSelected: selected,
                    onPressed: (int i) {
                      setState(() {
                        for (int j = 0; j < selected.length; j++) {
                          selected[j] = j == i;
                        }
                      });
                    },
                    color: _toggleAccent,
                    selectedColor: Colors.white,
                    fillColor: _toggleAccent,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Text('A'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Text('B'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Text('C'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Section 8: ReorderableListView — scrollDirection is an Axis.
// -----------------------------------------------------------------------------
Widget _reorderableSection() {
  return _sectionShell(
    bg: _reorderBg,
    accent: _reorderAccent,
    ink: _reorderInk,
    title: '8. ReorderableListView.scrollDirection',
    subtitle: 'Drag-to-reorder lists in either orientation.',
    body: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return _ReorderableInner();
      },
    ),
  );
}

class _ReorderableInner extends StatefulWidget {
  @override
  State<_ReorderableInner> createState() => _ReorderableInnerState();
}

class _ReorderableInnerState extends State<_ReorderableInner> {
  List<String> hItems = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  List<String> vItems = <String>['Alpha', 'Beta', 'Gamma', 'Delta'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ReorderableListView is one of the few "complex" widgets that '
          'still accepts a plain `Axis scrollDirection`.  The drag '
          'gesture, the placeholder, and the auto-scroll heuristics all '
          'adapt automatically when you flip the axis.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _miniLabel('horizontal'),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _reorderAccent.withOpacity(0.3)),
          ),
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(6),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final String item = hItems.removeAt(oldIndex);
                hItems.insert(newIndex, item);
              });
            },
            children: <Widget>[
              for (final String s in hItems)
                Container(
                  key: ValueKey<String>(s),
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _reorderAccent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _reorderAccent.withOpacity(0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    s,
                    style: TextStyle(
                      color: _reorderAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('vertical'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _reorderAccent.withOpacity(0.3)),
          ),
          child: ReorderableListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(6),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final String item = vItems.removeAt(oldIndex);
                vItems.insert(newIndex, item);
              });
            },
            children: <Widget>[
              for (final String s in vItems)
                Container(
                  key: ValueKey<String>(s),
                  height: 36,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: _reorderAccent.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _reorderAccent.withOpacity(0.4)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(s, style: TextStyle(color: _reorderAccent)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Section 9: Wrap.direction — Axis-driven flow layout.
// -----------------------------------------------------------------------------
Widget _wrapSection() {
  return _sectionShell(
    bg: _wrapBg,
    accent: _wrapAccent,
    ink: _wrapInk,
    title: '9. Wrap.direction',
    subtitle: 'A self-wrapping flow whose main axis is set by `Axis`.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Wrap is the canonical "row that wraps" widget.  Its `direction` '
          'parameter is an `Axis`: `Axis.horizontal` (default) wraps rows, '
          '`Axis.vertical` wraps columns.  Pair with `runSpacing` (cross '
          'axis) and `spacing` (main axis) for clean grids.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        _miniLabel('Axis.horizontal'),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wrapAccent.withOpacity(0.3)),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final String tag in const <String>[
                'pad',
                'sliver',
                'axis',
                'flex',
                'wrap',
                'flow',
                'grid',
                'list',
                'page',
                'tab',
                'step',
                'tile',
              ])
                _wrapChip(tag, _wrapAccent),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('Axis.vertical'),
        Container(
          height: 180,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wrapAccent.withOpacity(0.3)),
          ),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final String tag in const <String>[
                'one',
                'two',
                'three',
                'four',
                'five',
                'six',
                'seven',
                'eight',
                'nine',
                'ten',
              ])
                _wrapChip(tag, _wrapAccent),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _wrapChip(String label, Color accent) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: accent.withOpacity(0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: accent,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 10: Row / Column / Flex / Flow — axis-locked cousins.
// -----------------------------------------------------------------------------
Widget _flexCousinsSection() {
  return _sectionShell(
    bg: _flexBg,
    accent: _flexAccent,
    ink: _flexInk,
    title: '10. Row / Column / Flex (axis-locked cousins)',
    subtitle: 'Where Axis appears implicitly.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '`Row` and `Column` are dedicated subclasses of `Flex` that bake '
          'the `direction` in: Row sets it to `Axis.horizontal`, Column to '
          '`Axis.vertical`.  If you need to swap them at runtime, use '
          '`Flex(direction: ...)` directly — it is the abstract parent that '
          'takes an explicit `Axis`.  `Flow` and `Stack` are NOT axis-aware '
          'in the same sense; their layout is driven by `FlowDelegate` or '
          'positional children.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _flexAccent.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _flexRow('Row', 'Axis.horizontal', 'fixed'),
              _flexRow('Column', 'Axis.vertical', 'fixed'),
              _flexRow('Flex', 'Axis (any)', 'parameter'),
              _flexRow('ListBody', 'Axis (any)', 'parameter'),
              _flexRow('Wrap', 'Axis (any)', 'parameter'),
              _flexRow('Stack', 'n/a', 'positional'),
              _flexRow('Flow', 'n/a', 'delegate'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tip: when you find yourself writing `widget.direction == '
          'Axis.horizontal ? Row(...) : Column(...)`, reach for `Flex` and '
          'pass the axis through — it removes one layer of branching.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _flexRow(String widget, String axis, String how) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            widget,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 130,
          child: Text(
            axis,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: _flexAccent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            how,
            style: TextStyle(color: _flexAccent, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 11: Viewport.axis and SliverFillRemaining notes.
// -----------------------------------------------------------------------------
Widget _viewportNoteSection() {
  return _sectionShell(
    bg: _viewportBg,
    accent: _viewportAccent,
    ink: _viewportInk,
    title: '11. Viewport, Sliver, Scrollable',
    subtitle: 'Where Axis lives at the rendering layer.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Below the widget layer, Axis is the type used to declare the '
          'main axis of every viewport-bearing widget:\n\n'
          '  • `Viewport.axis` — the underlying RenderViewport\'s axis, '
          'derived from `axisDirection`.\n'
          '  • `Scrollable.axisDirection` — paired with the `Axis` of the '
          'scroll position via `axisDirectionToAxis`.\n'
          '  • `Sliver*` widgets do not take an `Axis` directly — they '
          'inherit it from their host viewport.\n'
          '  • `SliverFillRemaining` extends along the viewport\'s main '
          'axis whatever that may be.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _viewportAccent.withOpacity(0.3)),
          ),
          child: const Text(
            'final scrollable = Scrollable(\n'
            '  axisDirection: AxisDirection.right,\n'
            '  // axisDirection.axis == Axis.horizontal\n'
            '  viewportBuilder: (_, position) => Viewport(\n'
            '    axisDirection: AxisDirection.right,\n'
            '    offset: position,\n'
            '    slivers: <Widget>[/* slivers inherit horizontal */],\n'
            '  ),\n'
            ');',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 12: Decision card — when to choose horizontal vs vertical.
// -----------------------------------------------------------------------------
Widget _decisionSection() {
  return _sectionShell(
    bg: _decisionBg,
    accent: _decisionAccent,
    ink: _decisionInk,
    title: '12. Choosing horizontal vs vertical',
    subtitle: 'A cheat-sheet for everyday UI decisions.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _decisionRow(
          'Reading order',
          'Left-to-right languages (LTR) prefer horizontal axes for '
              'progress / steps; vertical for content backbone.',
        ),
        _decisionRow(
          'Content density',
          'Vertical lists scale better — phones are taller than wide.  '
              'Use horizontal lists for *peeking* at adjacent items, not '
              'for primary content.',
        ),
        _decisionRow(
          'Gesture conventions',
          'Vertical scrolls are the default user expectation; horizontal '
              'scrolling competes with back-swipe and tab-swipe gestures '
              'on iOS / Android.',
        ),
        _decisionRow(
          'Cross-axis bounds',
          'A horizontal Axis requires a bounded *height*; a vertical '
              'Axis requires a bounded *width*.  Forgetting this is the '
              'most common Axis pitfall.',
        ),
        _decisionRow(
          'Stepper / wizard',
          'Use `StepperType.vertical` for narrow viewports (mobile), '
              '`StepperType.horizontal` for wide ones (desktop / tablet).',
        ),
        _decisionRow(
          'Reorderable',
          'Vertical reorderables are the norm; horizontal ones suit '
              'tab strips, day pickers, and chip ribbons.',
        ),
      ],
    ),
  );
}

Widget _decisionRow(String topic, String advice) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            topic,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _decisionAccent,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            advice,
            style: const TextStyle(fontSize: 12, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Section 13: Reference card — every common widget that takes an Axis.
// -----------------------------------------------------------------------------
Widget _referenceCardSection() {
  return _sectionShell(
    bg: _refBg,
    accent: _refAccent,
    ink: _refInk,
    title: '13. Reference: widgets that consume Axis',
    subtitle: 'A quick lookup table.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _refAccent.withOpacity(0.3)),
          ),
          child: Column(
            children: <Widget>[
              _refRow('Widget', 'Parameter', 'Default', isHeader: true),
              _refRow('ListView', 'scrollDirection', 'Axis.vertical'),
              _refRow('GridView', 'scrollDirection', 'Axis.vertical'),
              _refRow('CustomScrollView', 'scrollDirection', 'Axis.vertical'),
              _refRow('PageView', 'scrollDirection', 'Axis.horizontal'),
              _refRow('NestedScrollView', 'scrollDirection', 'Axis.vertical'),
              _refRow('SingleChildScrollView', 'scrollDirection', 'Axis.vertical'),
              _refRow('ReorderableListView', 'scrollDirection', 'Axis.vertical'),
              _refRow('Wrap', 'direction', 'Axis.horizontal'),
              _refRow('Flex', 'direction', '(required)'),
              _refRow('ListBody', 'mainAxis', 'Axis.vertical'),
              _refRow('ToggleButtons', 'direction', 'Axis.horizontal'),
              _refRow('Scrollbar', '— inferred from child', 'n/a'),
              _refRow('Viewport', 'axisDirection.axis', 'n/a'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'And the helpers worth memorising:\n'
          '  • `flipAxis(Axis a)` — toggle helper.\n'
          '  • `axisDirectionToAxis(AxisDirection)` — discard the sign.\n'
          '  • `flipAxisDirection(AxisDirection)` — full 4-value flip.\n'
          '  • `Axis.values` / `Axis.values.map(...)` — exhaustively iterate.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _refRow(
  String widget,
  String param,
  String def, {
  bool isHeader = false,
}) {
  final TextStyle style = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    color: isHeader ? _refAccent : Colors.black87,
  );
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _refAccent.withOpacity(isHeader ? 0.4 : 0.1)),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: Text(widget, style: style)),
        Expanded(flex: 4, child: Text(param, style: style)),
        Expanded(flex: 3, child: Text(def, style: style)),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// Section: footer.
// -----------------------------------------------------------------------------
Widget _footerSection() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Deep Demo  •  Axis  •  Flutter painting',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Helpers shared by sections.
// -----------------------------------------------------------------------------
Widget _sectionShell({
  required Color bg,
  required Color accent,
  required Color ink,
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: ink.withOpacity(0.7)),
        ),
        const SizedBox(height: 12),
        body,
      ],
    ),
  );
}

Widget _miniLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 2),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.black54,
      ),
    ),
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            key,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
