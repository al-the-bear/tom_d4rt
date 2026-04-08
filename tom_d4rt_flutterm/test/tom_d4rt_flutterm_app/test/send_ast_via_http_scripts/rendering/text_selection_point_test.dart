// ignore_for_file: avoid_print
// Deep demo: TextSelectionPoint
// Demonstrates the TextSelectionPoint class — an immutable value carrying
// the screen position and text direction of a selection handle endpoint.
import 'package:flutter/material.dart';

// ─── palette: Deep Green / Mint ───────────────────────────────────
const Color _ptGreen = Color(0xFF1B5E20);
const Color _ptMint = Color(0xFFE8F5E9);
const Color _ptAccent = Color(0xFF43A047);
const Color _ptDark = Color(0xFF1A1A1A);
const Color _ptBlue = Color(0xFF1565C0);
const Color _ptPurple = Color(0xFF7B1FA2);
const Color _ptOrange = Color(0xFFE65100);
const Color _ptTeal = Color(0xFF00695C);

// ─── text helpers ─────────────────────────────────────────────────
Widget _ptTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _ptGreen,
              letterSpacing: 0.3)),
    );

Widget _ptSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _ptAccent)),
    );

Widget _ptBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _ptCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _ptDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFA5D6A7),
              height: 1.5)),
    );

Widget _ptNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _ptMint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _ptGreen.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _ptGreen),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _ptGreen, height: 1.4)),
          ),
        ],
      ),
    );

Widget _ptDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _ptGreen.withValues(alpha: 0.12)),
    );

Widget _ptBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _ptAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _ptTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _ptLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _ptGreen,
        letterSpacing: 0.2));

Widget _ptSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── coordinate visual builders ───────────────────────────────────

/// A crosshair marker to show an exact point on screen.
Widget _ptCrosshair(Color c, {double size = 18}) => SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _PtCrosshairPainter(c)),
    );

class _PtCrosshairPainter extends CustomPainter {
  final Color color;
  const _PtCrosshairPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawCircle(Offset(cx, cy), 3, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A small direction arrow showing TextDirection.
Widget _ptDirArrow(TextDirection dir, Color c) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          dir == TextDirection.ltr
              ? Icons.arrow_forward
              : Icons.arrow_back,
          size: 18,
          color: c,
        ),
        const SizedBox(width: 4),
        Text(
          dir == TextDirection.ltr ? 'LTR' : 'RTL',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: c,
              fontFamily: 'monospace'),
        ),
      ],
    );

/// A visual coordinate display box.
Widget _ptCoordBox(String label, double x, double y,
    {TextDirection? dir, Color markerColor = _ptBlue}) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _ptGreen.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        _ptCrosshair(markerColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _ptGreen)),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text('(${x.toStringAsFixed(1)}, ${y.toStringAsFixed(1)})',
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: Colors.black87)),
                  if (dir != null) ...[
                    const SizedBox(width: 12),
                    _ptDirArrow(dir, markerColor),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _ptBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_ptGreen, Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.location_on_outlined, size: 48, color: _ptMint),
          const SizedBox(height: 10),
          const Text('TextSelectionPoint',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Screen position + direction of a selection endpoint',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _ptTag('rendering', _ptAccent),
              _ptTag('immutable', _ptBlue),
              _ptTag('text selection', _ptPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _ptWhatIs() => [
      _ptTitle('§2  What Is TextSelectionPoint?'),
      _ptBody(
          'TextSelectionPoint is an immutable value object that describes '
          'where a text selection endpoint appears on screen. It carries '
          'two pieces of information: a screen coordinate (Offset) and '
          'an optional text direction (TextDirection).'),
      _ptCode(
          'class TextSelectionPoint {\n'
          '  const TextSelectionPoint(\n'
          '    this.point,      // Offset — screen position\n'
          '    this.direction,  // TextDirection? — text flow\n'
          '  );\n'
          '\n'
          '  final Offset point;\n'
          '  final TextDirection? direction;\n'
          '}'),
      _ptBody(
          'RenderEditable and similar render objects produce lists of '
          'TextSelectionPoint to tell the selection overlay exactly '
          'where to draw handles.'),
    ];

// ─── §3 The two fields ───────────────────────────────────────────
List<Widget> _ptFields() => [
      _ptDivider(),
      _ptTitle('§3  The Two Fields'),
      _ptSubtitle('point (Offset)'),
      _ptBody(
          'The position in the coordinate space of the render object '
          '(typically local coordinates). The x component gives the '
          'horizontal position along the text baseline. The y component '
          'gives the vertical position at the bottom of the text line.'),
      _ptBullet('Type', 'Offset (dx, dy)'),
      _ptBullet('Origin', 'Top-left corner of the RenderEditable'),
      _ptBullet('Y value', 'Bottom of the text line containing the endpoint'),
      _ptSubtitle('direction (TextDirection?)'),
      _ptBody(
          'The direction of text flow at the selection endpoint. This '
          'is needed to correctly orient the handle shape and determines '
          'which side the handle "leans" toward:'),
      _ptBullet('LTR', 'Handle extends to the right of the point'),
      _ptBullet('RTL', 'Handle extends to the left of the point'),
      _ptBullet('null', 'Direction unknown or text is vertical'),
      _ptNote(
          'The direction field is nullable. It can be null in scenarios '
          'where the text direction is ambiguous or irrelevant, such as '
          'collapsed cursors in empty text fields.'),
    ];

// ─── §4 Visual: coordinate anatomy ──────────────────────────────
List<Widget> _ptCoordAnatomy() => [
      _ptDivider(),
      _ptTitle('§4  Visual: Coordinate Anatomy'),
      _ptBody(
          'The point offset describes where the selection endpoint sits '
          'relative to the render object:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _ptLabel('Text field coordinate system'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _ptGreen.withValues(alpha: 0.3)),
              ),
              child: CustomPaint(painter: _PtCoordsPainter()),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                        width: 12, height: 12, color: _ptBlue),
                    const SizedBox(width: 4),
                    _ptSmall('point.dx (horizontal)'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 12, height: 12, color: _ptOrange),
                    const SizedBox(width: 4),
                    _ptSmall('point.dy (vertical)'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      _ptCode(
          '// Example: Selection start at 142px from left,\n'
          '// 28px from top (bottom of first text line).\n'
          'final startPoint = TextSelectionPoint(\n'
          '  const Offset(142.0, 28.0),\n'
          '  TextDirection.ltr,\n'
          ');'),
    ];

class _PtCoordsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Origin label
    final textPaint = TextPainter(
      text: const TextSpan(
          text: '(0,0)',
          style: TextStyle(fontSize: 9, color: Colors.black45)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPaint.paint(canvas, const Offset(4, 4));

    // Simulated text lines
    final linePaint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 1;
    for (var y = 24.0; y < size.height - 20; y += 24) {
      canvas.drawLine(
          Offset(16, y), Offset(size.width - 16, y), linePaint);
    }

    // Crosshair at the selection point
    const px = 120.0;
    const py = 48.0;
    final hPaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 1.2;
    final vPaint = Paint()
      ..color = const Color(0xFFE65100)
      ..strokeWidth = 1.2;

    // Horizontal (dx) arrow
    canvas.drawLine(const Offset(16, py), const Offset(px, py), hPaint);
    // Vertical (dy) arrow
    canvas.drawLine(const Offset(px, 18), const Offset(px, py), vPaint);

    // Point marker
    canvas.drawCircle(const Offset(px, py), 5,
        Paint()..color = const Color(0xFF1B5E20));
    canvas.drawCircle(const Offset(px, py), 3,
        Paint()..color = Colors.white);

    // Labels
    final dxLabel = TextPainter(
      text: const TextSpan(
          text: 'dx=120',
          style: TextStyle(fontSize: 8, color: Color(0xFF1565C0))),
      textDirection: TextDirection.ltr,
    )..layout();
    dxLabel.paint(canvas, const Offset(60, py + 4));

    final dyLabel = TextPainter(
      text: const TextSpan(
          text: 'dy=48',
          style: TextStyle(fontSize: 8, color: Color(0xFFE65100))),
      textDirection: TextDirection.ltr,
    )..layout();
    dyLabel.paint(canvas, Offset(px + 6, 30));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── §5 Visual: direction impact ─────────────────────────────────
List<Widget> _ptDirImpact() => [
      _ptDivider(),
      _ptTitle('§5  Visual: How Direction Affects Handle Placement'),
      _ptBody(
          'The direction field tells the overlay which side of the point '
          'to draw the handle. This matters for bidirectional text:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptLabel('Handle placement by direction'),
            const SizedBox(height: 10),
            _ptDirRow('LTR', Icons.arrow_forward,
                'Handle drawn to the right of point', _ptBlue),
            const SizedBox(height: 8),
            _ptDirRow('RTL', Icons.arrow_back,
                'Handle drawn to the left of point', _ptPurple),
            const SizedBox(height: 8),
            _ptDirRow('null', Icons.help_outline,
                'Default placement (typically LTR)', _ptOrange),
          ],
        ),
      ),
      _ptCode(
          '// LTR selection point — handle extends right\n'
          'TextSelectionPoint(\n'
          '  Offset(100.0, 24.0),\n'
          '  TextDirection.ltr,\n'
          ');\n'
          '\n'
          '// RTL selection point — handle extends left\n'
          'TextSelectionPoint(\n'
          '  Offset(300.0, 24.0),\n'
          '  TextDirection.rtl,\n'
          ');'),
      _ptBody(
          'In mixed-direction text (like Arabic embedded in English), '
          'the start and end points may have different directions.'),
    ];

Widget _ptDirRow(String label, IconData icon, String desc, Color c) => Row(
      children: [
        Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Icon(icon, size: 18, color: c),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );

// ─── §6 Creating TextSelectionPoint ──────────────────────────────
List<Widget> _ptCreation() => [
      _ptDivider(),
      _ptTitle('§6  Creating TextSelectionPoint'),
      _ptBody(
          'TextSelectionPoint is always created via its const constructor. '
          'It is immutable — once created, neither field can change.'),
      _ptCode(
          '// Simple LTR point\n'
          'const p1 = TextSelectionPoint(\n'
          '  Offset(42.5, 20.0),\n'
          '  TextDirection.ltr,\n'
          ');\n'
          '\n'
          '// Point with unknown direction\n'
          'const p2 = TextSelectionPoint(\n'
          '  Offset(0.0, 0.0),\n'
          '  null,\n'
          ');\n'
          '\n'
          'print(p1.point);      // Offset(42.5, 20.0)\n'
          'print(p1.direction);  // TextDirection.ltr\n'
          'print(p2.direction);  // null'),
      _ptSubtitle('Typical producers'),
      _ptBody(
          'You rarely create TextSelectionPoint directly. Instead, render '
          'objects produce them:'),
      _ptBullet('RenderEditable',
          'getEndpointsForSelection() returns List<TextSelectionPoint>'),
      _ptBullet('RenderParagraph',
          'getEndpointsForSelection() for read-only text'),
      _ptBullet('Custom render objects',
          'Override to provide custom selection geometry'),
      _ptNote(
          'The list always contains exactly two points for a range '
          'selection (start and end), or one point for a collapsed cursor.'),
    ];

// ─── §7 Usage in SelectionOverlay ────────────────────────────────
List<Widget> _ptOverlay() => [
      _ptDivider(),
      _ptTitle('§7  Usage In SelectionOverlay'),
      _ptBody(
          'The primary consumer of TextSelectionPoint is the selection '
          'overlay, which positions handles at the computed points:'),
      _ptCode(
          '// Simplified flow inside SelectionOverlay:\n'
          'final endpoints = renderEditable\n'
          '    .getEndpointsForSelection(selection);\n'
          '\n'
          '// Position the start handle\n'
          'final start = endpoints.first;\n'
          'final startHandlePos = start.point;\n'
          'final startDir = start.direction;\n'
          '\n'
          '// Position the end handle\n'
          'if (endpoints.length > 1) {\n'
          '  final end = endpoints.last;\n'
          '  final endHandlePos = end.point;\n'
          '  // ... place end handle\n'
          '}'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptLabel('Selection overlay data flow'),
            const SizedBox(height: 10),
            _ptFlowStep('1', 'User selects text', _ptGreen),
            _ptFlowStep(
                '2', 'RenderEditable computes endpoints', _ptBlue),
            _ptFlowStep(
                '3', 'Returns List<TextSelectionPoint>', _ptPurple),
            _ptFlowStep('4', 'SelectionOverlay reads .point', _ptOrange),
            _ptFlowStep(
                '5', 'Overlay reads .direction for handle shape', _ptTeal),
            _ptFlowStep('6', 'Handles rendered at coordinates', _ptGreen),
          ],
        ),
      ),
    ];

Widget _ptFlowStep(String num, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 12, color: Colors.black87)),
          ),
        ],
      ),
    );

// ─── §8 Multi-line selections ────────────────────────────────────
List<Widget> _ptMultiLine() => [
      _ptDivider(),
      _ptTitle('§8  Multi-Line Selections'),
      _ptBody(
          'For a selection spanning multiple lines, getEndpointsForSelection '
          'returns two TextSelectionPoint values — one for the start line '
          'and one for the end line:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _ptLabel('Multi-line selection endpoints'),
            const SizedBox(height: 12),
            // Start point
            _ptCoordBox(
                'Start (line 1)', 85.0, 24.0,
                dir: TextDirection.ltr, markerColor: _ptBlue),
            const SizedBox(height: 4),
            // Vertical connector
            Container(
              width: 2,
              height: 20,
              margin: const EdgeInsets.only(left: 20),
              color: _ptAccent.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 4),
            // End point
            _ptCoordBox(
                'End (line 3)', 210.0, 72.0,
                dir: TextDirection.ltr, markerColor: _ptPurple),
            const SizedBox(height: 8),
            _ptSmall(
                'Start point is on line 1, end point is on line 3'),
          ],
        ),
      ),
      _ptCode(
          '// Multi-line: two endpoints\n'
          'final endpoints = renderEditable\n'
          '    .getEndpointsForSelection(\n'
          '      TextSelection(baseOffset: 15, extentOffset: 85),\n'
          '    );\n'
          '\n'
          'assert(endpoints.length == 2);\n'
          'print(endpoints[0].point); // start offset\n'
          'print(endpoints[1].point); // end offset'),
      _ptNote(
          'Even though the selection may highlight three or more lines, '
          'only two TextSelectionPoint values are returned — one for each '
          'handle. The intermediate lines are highlighted by the selection '
          'rectangle, not by endpoints.'),
    ];

// ─── §9 Bidirectional text ───────────────────────────────────────
List<Widget> _ptBidi() => [
      _ptDivider(),
      _ptTitle('§9  Bidirectional Text'),
      _ptBody(
          'In bidirectional text, the two endpoints may have different '
          'directions. A selection starting in English (LTR) and ending '
          'in Arabic (RTL) produces:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptLabel('Bidi selection — mixed directions'),
            const SizedBox(height: 10),
            _ptBidiRow('Start', 'English text', TextDirection.ltr, _ptBlue),
            Container(
              width: 2,
              height: 12,
              margin: const EdgeInsets.only(left: 30),
              color: _ptAccent.withValues(alpha: 0.3),
            ),
            _ptBidiRow('End', 'Arabic text', TextDirection.rtl, _ptPurple),
          ],
        ),
      ),
      _ptCode(
          '// Start point in LTR region\n'
          'endpoints[0] = TextSelectionPoint(\n'
          '  Offset(50.0, 24.0),\n'
          '  TextDirection.ltr,  // English\n'
          ');\n'
          '\n'
          '// End point in RTL region\n'
          'endpoints[1] = TextSelectionPoint(\n'
          '  Offset(280.0, 24.0),\n'
          '  TextDirection.rtl,  // Arabic\n'
          ');'),
      _ptBody(
          'The selection overlay uses each point\'s individual direction '
          'to orient the handle correctly, so the left-end handle can lean '
          'one way while the right-end handle leans the other.'),
    ];

Widget _ptBidiRow(
    String label, String text, TextDirection dir, Color c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 48,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: c)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ),
        _ptDirArrow(dir, c),
      ],
    ),
  );
}

// ─── §10 Comparison with related types ───────────────────────────
List<Widget> _ptComparison() => [
      _ptDivider(),
      _ptTitle('§10  Comparison With Related Types'),
      _ptBody(
          'TextSelectionPoint is one of several types involved in text '
          'selection. Here is how it relates to the others:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _ptMint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptCompRow('TextSelectionPoint', 'Screen position + direction',
                'This class', isHeader: false),
            const SizedBox(height: 6),
            _ptCompRow('TextSelection', 'Range of text (base & extent offsets)',
                'Logical selection'),
            _ptCompRow('TextPosition', 'Single character offset + affinity',
                'Index into text'),
            _ptCompRow('TextSelectionHandleType', 'left / right / collapsed',
                'Handle shape enum'),
            _ptCompRow('SelectionOverlay', 'Composites handles + toolbar',
                'UI coordinator'),
          ],
        ),
      ),
      _ptNote(
          'TextSelection describes WHAT is selected (character offsets). '
          'TextSelectionPoint describes WHERE the selection appears on '
          'screen (pixel coordinates). The render object translates from '
          'one to the other.'),
    ];

Widget _ptCompRow(String type, String role, String note,
    {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(type,
              style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isHeader ? FontWeight.w700 : FontWeight.w600,
                  color: _ptGreen,
                  fontFamily: 'monospace')),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role,
                  style: const TextStyle(
                      fontSize: 10.5, color: Colors.black87)),
              Text(note,
                  style: const TextStyle(
                      fontSize: 9.5,
                      color: Colors.black45,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _ptSummary() => [
      _ptDivider(),
      _ptTitle('§11  Summary'),
      _ptBody(
          'TextSelectionPoint is a small but critical piece of the text '
          'selection pipeline. It is the bridge between character offsets '
          'in the text model and pixel coordinates on screen.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _ptGreen.withValues(alpha: 0.08),
              _ptMint,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _ptGreen.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _ptGreen)),
            const SizedBox(height: 10),
            _ptSumPt('point', 'Offset in render object coordinates'),
            _ptSumPt('direction',
                'TextDirection? for handle orientation (LTR/RTL/null)'),
            _ptSumPt('Immutable', 'Created via const constructor, never mutated'),
            _ptSumPt('Producer', 'RenderEditable.getEndpointsForSelection()'),
            _ptSumPt('Consumer', 'SelectionOverlay positions handles'),
            _ptSumPt('Count', 'Exactly 2 for range selection, 1 for collapsed'),
            _ptSumPt('Bidi aware', 'Start and end can have different directions'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _ptGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TextSelectionPoint Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _ptSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _ptAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _ptGreen)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ptBanner(),
        const SizedBox(height: 20),
        ..._ptWhatIs(),
        ..._ptFields(),
        ..._ptCoordAnatomy(),
        ..._ptDirImpact(),
        ..._ptCreation(),
        ..._ptOverlay(),
        ..._ptMultiLine(),
        ..._ptBidi(),
        ..._ptComparison(),
        ..._ptSummary(),
      ],
    ),
  );
}
