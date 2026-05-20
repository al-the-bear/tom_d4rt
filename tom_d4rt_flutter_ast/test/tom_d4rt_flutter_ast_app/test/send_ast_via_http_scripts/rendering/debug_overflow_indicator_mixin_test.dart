// D4rt test script: Tests DebugOverflowIndicatorMixin from rendering.
// Deep Demo: "The Overflow Detective's Handbook" — a visual treatise on the
// yellow-and-black striped overflow indicator that Flutter paints whenever a
// child renders outside of its parent constraints. We never trigger a *real*
// overflow during this widget build (every too-big subtree is clipped via
// ClipRect/ClipRRect), but we faithfully reproduce the indicator's appearance
// using a custom painter, and we annotate each of the canonical scenarios in
// which the framework would paint the stripes.
import 'package:flutter/material.dart';

// =====================================================================
// _StripePainter
// ---------------------------------------------------------------------
// A CustomPainter that reproduces the classic 45-degree alternating
// yellow-and-black band pattern that DebugOverflowIndicatorMixin paints
// onto overflowing edges of a render object. The framework paints these
// stripes inside the rect that lies outside the parent's bounds; we use
// the painter purely for documentation purposes in a normal child rect.
// =====================================================================
class _StripePainter extends CustomPainter {
  const _StripePainter({this.bandWidth = 12.0, this.opacity = 0.85});

  final double bandWidth;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint yellow = Paint()
      ..color = const Color(0xFFFFEB3B).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    final Paint black = Paint()
      ..color = const Color(0xFF111111).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    // Fill the background with yellow first.
    canvas.drawRect(Offset.zero & size, yellow);

    // Now overlay diagonal black bands every (bandWidth * 2) pixels along
    // the x-axis, drawn as parallelograms slanted at 45 degrees so that
    // they reproduce the iconic warning-tape stripe pattern.
    final double diagonal = size.width + size.height;
    double x = -size.height;
    while (x < diagonal) {
      final Path path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + bandWidth, 0)
        ..lineTo(x + bandWidth + size.height, size.height)
        ..lineTo(x + size.height, size.height)
        ..close();
      canvas.drawPath(path, black);
      x += bandWidth * 2;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.bandWidth != bandWidth ||
        oldDelegate.opacity != opacity;
  }
}

// =====================================================================
// _stripe — convenience helper returning a CustomPaint-wrapped Container
// painted with the warning stripes. Used for the legend, anatomy
// diagrams, and the schematic overlays on each "would overflow" demo.
// =====================================================================
Widget _stripe({
  required double width,
  required double height,
  double bandWidth = 10.0,
  double opacity = 0.85,
  String? label,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: CustomPaint(
      painter: _StripePainter(bandWidth: bandWidth, opacity: opacity),
      child: label == null
          ? const SizedBox.shrink()
          : Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                color: Colors.black.withValues(alpha: 0.55),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
    ),
  );
}

// =====================================================================
// _sectionHeader — large titled banner introducing each section.
// =====================================================================
Widget _sectionHeader(String number, String title, String tagline) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A1A1A), Color(0xFF2C2C2C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFFFEB3B), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFEB3B),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                tagline,
                style: TextStyle(
                  color: Colors.yellow.shade100,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _narration — body text block inside a section.
// =====================================================================
Widget _narration(String body) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      body,
      style: TextStyle(
        fontSize: 13.0,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

// =====================================================================
// _codeBlock — monospace styled code excerpt block.
// =====================================================================
Widget _codeBlock(String code, {String? caption}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (caption != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.0),
                topRight: Radius.circular(7.0),
              ),
            ),
            child: Text(
              caption,
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              height: 1.45,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _labeledCard — a titled card with optional accent.
// =====================================================================
Widget _labeledCard({
  required String title,
  required Color accent,
  required Widget child,
  String? subtitle,
}) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
        const SizedBox(height: 10.0),
        child,
      ],
    ),
  );
}

// =====================================================================
// _debugErrorPanel — a stylised reproduction of the framework's red
// "A RenderFlex overflowed by N pixels" debug error banner that gets
// printed when the indicator triggers. We never actually emit the error
// here; we just render its visual signature so readers recognise it.
// =====================================================================
Widget _debugErrorPanel(String headline, String details) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFB71C1C),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade900, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.error_outline, color: Colors.white, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                headline,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          color: Colors.black.withValues(alpha: 0.35),
          child: Text(
            details,
            style: const TextStyle(
              color: Colors.yellowAccent,
              fontSize: 11.0,
              height: 1.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _legendDot — small color swatch + label used in the anatomy diagram.
// =====================================================================
Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
      ),
      const SizedBox(width: 6.0),
      Text(
        label,
        style: const TextStyle(fontSize: 11.0, color: Colors.black87),
      ),
    ],
  );
}

// =====================================================================
// _formCard — placeholder vertical form card used in Column overflow.
// =====================================================================
Widget _formCard(String label, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent, width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.edit, color: accent, size: 14.0),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _miniRow — small flex-ratio illustration used in the fix cards.
// =====================================================================
Widget _miniRow(List<Color> colors, List<int> flexes) {
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < colors.length; i++) {
    children.add(Expanded(
      flex: flexes[i],
      child: Container(
        height: 24.0,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: colors[i],
          borderRadius: BorderRadius.circular(3.0),
        ),
        alignment: Alignment.center,
        child: Text(
          '${flexes[i]}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(children: children),
  );
}

// =====================================================================
// _practiceStep — a numbered card used in the debug-practice section.
// =====================================================================
Widget _practiceStep(
  String number,
  String title,
  String body,
  IconData icon,
  Color accent,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: accent, size: 18.0),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _cheatHeaderRow — header row for the cheat-sheet table.
// =====================================================================
Widget _cheatHeaderRow() {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(9.0),
        topRight: Radius.circular(9.0),
      ),
    ),
    child: const Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            'Symptom',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Likely Cause',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Fix',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// _cheatRow — a data row in the cheat-sheet table.
// =====================================================================
Widget _cheatRow(
  String symptom,
  String cause,
  String fix,
  Color background,
) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: background,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            symptom,
            style: const TextStyle(fontSize: 11.0, color: Colors.black87),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cause,
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            fix,
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// build entrypoint executed by the d4rt interpreter.
// =====================================================================
dynamic build(BuildContext context) {
  debugPrint('DebugOverflowIndicatorMixin Deep Demo: building scene');

  final List<Widget> body = <Widget>[];

  // ===================================================================
  // SECTION 1: Hero header — what overflow is, what the indicator looks
  // like, when it appears, who paints it.
  // ===================================================================
  body.add(_sectionHeader(
    '1',
    'The Overflow Detective\'s Handbook',
    'A field guide to the yellow-and-black stripes you have all seen.',
  ));
  body.add(_narration(
    'In Flutter, every RenderBox is laid out by its parent. The parent '
    'hands the child a BoxConstraints object. The child must produce a '
    'Size that satisfies those constraints. When a render object paints '
    'children that fall outside of its own bounds — a Row with five '
    'oversized buttons inside a 200px-wide phone column, for instance — '
    'the layout has "overflowed".\n\n'
    'During debug builds, DebugOverflowIndicatorMixin (used by RenderFlex '
    'and a handful of other render objects) reacts by:\n'
    '  1. Painting a black region inside the parent on the overflowing '
    'edge.\n'
    '  2. Painting yellow-and-black 45 deg warning stripes on the edge '
    'itself, in the rect that lives just outside the parent.\n'
    '  3. Emitting a red console message: "A RenderFlex overflowed by '
    'N pixels on the …".\n\n'
    'Release builds skip both the stripes and the message: '
    'DebugOverflowIndicatorMixin is a debugging aid, not a runtime '
    'safeguard. The fix always belongs in your layout code.',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.yellow.shade700, width: 2.0),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: _stripe(width: 120.0, height: 48.0),
          ),
          const SizedBox(width: 12.0),
          const Expanded(
            child: Text(
              'This is what the indicator looks like at full scale. The '
              'yellow background communicates "warning"; the black bands '
              'communicate "danger zone, please look". Combined they '
              'pattern-match the universally-recognised hazard tape used '
              'in physical construction sites.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 2: Stripe legend — show the painter in several orientations
  // so readers see how the same painter applies to horizontal, vertical,
  // and square overflow patches.
  // ===================================================================
  body.add(_sectionHeader(
    '2',
    'Stripe Legend',
    'The single visual element of the indicator at varied dimensions.',
  ));
  body.add(_narration(
    'The stripes are not orientation-aware. They are simply painted into '
    'whatever rectangle represents the overflowed area: a thin tall sliver '
    'on the right edge for a wide-overflow Row, a thin wide bar on the '
    'bottom for a tall-overflow Column, an L-shape for bidirectional '
    'overflow, or a full rectangle in dramatic cases.',
  ));
  body.add(
    Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(width: 200.0, height: 24.0, label: 'right edge'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(width: 24.0, height: 120.0, label: 'bottom edge'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(width: 80.0, height: 80.0, label: 'square'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(width: 160.0, height: 60.0, label: 'wide'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(width: 50.0, height: 160.0, label: 'tall'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(
            width: 120.0,
            height: 60.0,
            bandWidth: 4.0,
            label: 'fine',
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: _stripe(
            width: 120.0,
            height: 60.0,
            bandWidth: 18.0,
            label: 'coarse',
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 3: Anatomy of paintOverflowIndicator — labelled diagram.
  // ===================================================================
  body.add(_sectionHeader(
    '3',
    'Anatomy of paintOverflowIndicator',
    'What the mixin actually draws on top of your render tree.',
  ));
  body.add(_narration(
    'paintOverflowIndicator(PaintingContext context, Offset offset, Rect '
    'containerRect, Rect childRect, {List<DiagnosticsNode>? overflowHints}) '
    'is the single method the mixin exposes. The render object that uses '
    'the mixin (RenderFlex, RenderConstrainedOverflowBox, …) calls it '
    'during paint when childRect is not contained in containerRect. The '
    'mixin then computes the four "leak" rectangles (left, top, right, '
    'bottom of the container) and paints stripes into whichever are '
    'non-empty. Hints are forwarded to the debug error message.',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Schematic: container = 200x100, child = 280x100',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),
          ClipRect(
            child: SizedBox(
              width: 320.0,
              height: 140.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20.0,
                    top: 20.0,
                    child: Container(
                      width: 200.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        border: Border.all(
                          color: Colors.blue.shade700,
                          width: 2.0,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'containerRect',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    top: 36.0,
                    child: Container(
                      width: 280.0,
                      height: 68.0,
                      color: Colors.green.withValues(alpha: 0.35),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: const Text(
                        'childRect',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 220.0,
                    top: 36.0,
                    child: _stripe(width: 80.0, height: 68.0, label: 'leak'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _legendDot(Colors.blue, 'container'),
              _legendDot(Colors.green, 'child'),
              _legendDot(Colors.yellow.shade700, 'stripes (leak)'),
            ],
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 4: Row overflow — the canonical case.
  // ===================================================================
  body.add(_sectionHeader(
    '4',
    'Row Overflow',
    'A Row whose unflexed children total wider than its incoming width.',
  ));
  body.add(_narration(
    'This is the situation that DebugOverflowIndicatorMixin was written '
    'for. A Row with no Expanded/Flexible children and total child width '
    '> incoming maxWidth will lay out the children at their preferred '
    'sizes, paint them past the right edge, and trigger the indicator.',
  ));
  body.add(_codeBlock(
    'Row(\n'
    '  children: <Widget>[\n'
    '    Container(width: 120, color: Colors.red),\n'
    '    Container(width: 120, color: Colors.green),\n'
    '    Container(width: 120, color: Colors.blue),\n'
    '  ],\n'
    ')   // inside a 220px-wide phone column',
    caption: 'overflow_row.dart',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Schematic reproduction (clipped to avoid real overflow)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 280.0,
            height: 80.0,
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: SizedBox(
                    width: 220.0,
                    height: 80.0,
                    child: Row(
                      children: <Widget>[
                        Container(width: 120.0, color: Colors.red.shade300),
                        Container(width: 120.0, color: Colors.green.shade300),
                        Container(width: 120.0, color: Colors.blue.shade300),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: _stripe(width: 60.0, height: 80.0, label: '140 px'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 5: Column overflow — the vertical counterpart.
  // ===================================================================
  body.add(_sectionHeader(
    '5',
    'Column Overflow',
    'A Column too tall for its parent constraints, indicator on the bottom.',
  ));
  body.add(_narration(
    'Vertical overflow looks exactly the same — the indicator just appears '
    'on the bottom edge instead of the right. This is the most common '
    'overflow during keyboard insertion: a Column-based form does not '
    'become scrollable, the keyboard reduces the available height, the '
    'Column overflows, and you see the bottom stripes.',
  ));
  body.add(_codeBlock(
    'Column(\n'
    '  children: <Widget>[\n'
    '    SizedBox(height: 80, child: Card()),\n'
    '    SizedBox(height: 80, child: Card()),\n'
    '    SizedBox(height: 80, child: Card()),\n'
    '    SizedBox(height: 80, child: Card()),\n'
    '  ],\n'
    ')   // inside a 220px-tall constrained box',
    caption: 'overflow_column.dart',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Schematic reproduction (clipped)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 200.0,
            height: 260.0,
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: SizedBox(
                    width: 200.0,
                    height: 220.0,
                    child: Column(
                      children: <Widget>[
                        _formCard('Name', Colors.deepPurple),
                        _formCard('Email', Colors.teal),
                        _formCard('Address', Colors.amber),
                        _formCard('Phone', Colors.indigo),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: _stripe(width: 200.0, height: 40.0, label: '100 px'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 6: Bidirectional overflow.
  // ===================================================================
  body.add(_sectionHeader(
    '6',
    'Bidirectional Overflow',
    'When the child exceeds both width and height of its container.',
  ));
  body.add(_narration(
    'If a child is too big in both axes, the mixin paints stripes on the '
    'right *and* the bottom. The corner pixel where the two stripes meet '
    'is painted twice but you cannot tell because they are the same band '
    'pattern. The debug message in this case reports both axes.',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Schematic: parent 180x140, child 260x220',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 260.0,
            height: 220.0,
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: SizedBox(
                    width: 180.0,
                    height: 140.0,
                    child: Container(
                      color: Colors.pink.shade100,
                      child: Center(
                        child: Container(
                          width: 260.0,
                          height: 220.0,
                          color: Colors.deepOrange.shade300,
                          alignment: Alignment.center,
                          child: const Text(
                            '260 x 220',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 80.0,
                  top: 0.0,
                  bottom: 80.0,
                  child: _stripe(width: 30.0, height: 140.0, label: '80 px'),
                ),
                Positioned(
                  left: 0.0,
                  right: 80.0,
                  bottom: 80.0,
                  child: _stripe(width: 180.0, height: 30.0, label: '80 px'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 7: How to fix — three side-by-side fix cards.
  // ===================================================================
  body.add(_sectionHeader(
    '7',
    'How To Fix',
    'Three idiomatic Flutter answers to a Row that overflows.',
  ));
  body.add(_narration(
    'When the indicator appears, your job is to teach the layout how to '
    'cope with not enough space. The three canonical strategies are: '
    'Expanded (share remaining space), Flexible (allow but do not require '
    'shrinking), and SingleChildScrollView (offload extra content to a '
    'scroll viewport).',
  ));
  body.add(
    Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 260.0,
          child: _labeledCard(
            title: 'Fix 1: Expanded',
            accent: Colors.green.shade700,
            subtitle: 'Forces the child to fill the remaining space.',
            child: Column(
              children: <Widget>[
                _codeBlock(
                  'Row(\n'
                  '  children: <Widget>[\n'
                  '    Icon(Icons.label),\n'
                  '    Expanded(\n'
                  '      child: Text(longText),\n'
                  '    ),\n'
                  '    Icon(Icons.close),\n'
                  '  ],\n'
                  ')',
                ),
                _miniRow(<Color>[
                  Colors.red.shade300,
                  Colors.green.shade300,
                  Colors.blue.shade300,
                ], <int>[1, 4, 1]),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 260.0,
          child: _labeledCard(
            title: 'Fix 2: Flexible',
            accent: Colors.orange.shade700,
            subtitle: 'Allows the child to shrink if needed.',
            child: Column(
              children: <Widget>[
                _codeBlock(
                  'Row(\n'
                  '  children: <Widget>[\n'
                  '    Flexible(child: Text(name)),\n'
                  '    SizedBox(width: 8),\n'
                  '    Text("(verified)"),\n'
                  '  ],\n'
                  ')',
                ),
                _miniRow(<Color>[
                  Colors.orange.shade300,
                  Colors.amber.shade300,
                  Colors.deepOrange.shade300,
                ], <int>[3, 1, 2]),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 260.0,
          child: _labeledCard(
            title: 'Fix 3: SingleChildScrollView',
            accent: Colors.purple.shade700,
            subtitle: 'Offload to scrolling. Use when content is unbounded.',
            child: Column(
              children: <Widget>[
                _codeBlock(
                  'SingleChildScrollView(\n'
                  '  scrollDirection: Axis.horizontal,\n'
                  '  child: Row(children: chips),\n'
                  ')',
                ),
                _miniRow(<Color>[
                  Colors.purple.shade300,
                  Colors.purple.shade400,
                  Colors.purple.shade500,
                  Colors.purple.shade600,
                ], <int>[1, 1, 1, 1]),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ===================================================================
  // SECTION 8: Why Row + Text without Flexible misbehaves.
  // ===================================================================
  body.add(_sectionHeader(
    '8',
    'Row + Text Without Flexible',
    'The single most common cause of mysterious right-edge stripes.',
  ));
  body.add(_narration(
    'A Text widget reports its intrinsic width (no wrapping) when placed '
    'in a Row, because Row gives unbounded width during the first layout '
    'pass to non-flex children. So Text("a long sentence that is many many '
    'pixels wide") asks for, say, 800 pixels — and the Row obediently '
    'paints it, then overflows the parent.\n\n'
    'The fix is to wrap the Text in Expanded or Flexible so it receives '
    'bounded width and can wrap (or ellipsize).',
  ));
  body.add(_debugErrorPanel(
    'FlutterError: A RenderFlex overflowed by 312 pixels on the right.',
    'The relevant error-causing widget was:\n'
    '  Row Row:file:///lib/main.dart:42:18\n\n'
    'The overflowing RenderFlex has an orientation of Axis.horizontal.\n'
    'Consider applying a flex factor (e.g. using an Expanded widget) to\n'
    'force the children of the RenderFlex to fit within the available\n'
    'space instead of being sized to their natural size.',
  ));

  // ===================================================================
  // SECTION 9: Padding-induced overflow.
  // ===================================================================
  body.add(_sectionHeader(
    '9',
    'Padding-Induced Overflow',
    'When EdgeInsets eat more space than the parent has available.',
  ));
  body.add(_narration(
    'A SizedBox(width: 100) wrapped in Padding(padding: EdgeInsets.all(80)) '
    'asks the renderbox to lay out at width = 100 + 160 = 260, regardless '
    'of incoming maxWidth. If the parent is only 200 wide, overflow occurs '
    'on the right. Padding overflow is sneaky because the code looks '
    'innocuous.',
  ));
  body.add(_codeBlock(
    'Padding(\n'
    '  padding: EdgeInsets.all(80),\n'
    '  child: SizedBox(width: 100, height: 40, child: Text("Hi")),\n'
    ') // inside a 200x80 parent',
    caption: 'padding_overflow.dart',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: SizedBox(
        width: 280.0,
        height: 100.0,
        child: Stack(
          children: <Widget>[
            ClipRect(
              child: SizedBox(
                width: 200.0,
                height: 80.0,
                child: Container(
                  color: Colors.lime.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      width: 200.0,
                      color: Colors.green.shade400,
                      alignment: Alignment.center,
                      child: const Text(
                        'inner',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              top: 0.0,
              bottom: 20.0,
              child: _stripe(width: 80.0, height: 80.0, label: 'pad+w'),
            ),
          ],
        ),
      ),
    ),
  );

  // ===================================================================
  // SECTION 10: SizedBox forced size.
  // ===================================================================
  body.add(_sectionHeader(
    '10',
    'SizedBox Forced Size',
    'When a SizedBox.fromSize or SizedBox(width:) refuses to shrink.',
  ));
  body.add(_narration(
    'A SizedBox(width: 400) ignores incoming constraints when it is taller '
    'than allowed (it is treated as tight in that dimension). If 400 > '
    'parent maxWidth, overflow happens immediately. The fix is usually to '
    'use ConstrainedBox(constraints: BoxConstraints(maxWidth: 400)) or to '
    'wrap with FittedBox so the child scales down.',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Schematic: parent 220 wide, SizedBox 360 wide',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 280.0,
            height: 70.0,
            child: Stack(
              children: <Widget>[
                ClipRect(
                  child: SizedBox(
                    width: 220.0,
                    height: 50.0,
                    child: Container(
                      color: Colors.cyan.shade100,
                      alignment: Alignment.center,
                      child: Container(
                        width: 360.0,
                        height: 32.0,
                        color: Colors.cyan.shade700,
                        alignment: Alignment.center,
                        child: const Text(
                          'SizedBox(width: 360)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  bottom: 20.0,
                  child: _stripe(width: 60.0, height: 50.0, label: '140 px'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // SECTION 11: Debug practice card.
  // ===================================================================
  body.add(_sectionHeader(
    '11',
    'Debug Practice',
    'A repeatable workflow for resolving any overflow indicator sighting.',
  ));
  body.add(_narration(
    'When you see stripes on a real device or in widget tests, do not '
    'panic. Walk through the following four steps and you will resolve '
    '95% of cases in under five minutes.',
  ));
  body.add(_practiceStep(
    '1',
    'Read the debug message',
    'Look at the console for "A RenderFlex overflowed by N pixels on '
    'the X". X is the axis (right, bottom, …) and the file:line link '
    'points to the offending Row or Column.',
    Icons.read_more,
    Colors.blue.shade700,
  ));
  body.add(_practiceStep(
    '2',
    'Identify the parent',
    'Use the Flutter Inspector or the file:line link to locate the '
    'RenderFlex. Walk up the tree until you find what restricts its '
    'cross-axis size (usually a SizedBox, Container, Padding, or '
    'MediaQuery).',
    Icons.account_tree,
    Colors.green.shade700,
  ));
  body.add(_practiceStep(
    '3',
    'Find the unflexed child',
    'The child whose intrinsic width pushes the total above the parent '
    'is the culprit. Often a long Text, a SizedBox with a hard-coded '
    'width, or an Image with no constraints.',
    Icons.search,
    Colors.orange.shade700,
  ));
  body.add(_practiceStep(
    '4',
    'Apply the right fix',
    'Wrap with Expanded for "share remaining space", Flexible for '
    '"allow shrinking", or refactor to a scroll view for unbounded '
    'content.',
    Icons.build,
    Colors.purple.shade700,
  ));

  // ===================================================================
  // SECTION 12: Cheat-sheet card.
  // ===================================================================
  body.add(_sectionHeader(
    '12',
    'Cheat Sheet',
    'Symptom -> Likely Cause -> Fix.',
  ));
  body.add(_narration(
    'Print this and stick it on your monitor. After a few weeks the '
    'patterns become second nature and the indicator stops being '
    'frightening.',
  ));
  body.add(
    Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        children: <Widget>[
          _cheatHeaderRow(),
          _cheatRow(
            'Right stripes in a Row',
            'Unflexed Text/Image',
            'Wrap in Expanded / Flexible',
            Colors.red.shade50,
          ),
          _cheatRow(
            'Bottom stripes in a Column',
            'Tall list inside Column',
            'Use ListView or scroll view',
            Colors.orange.shade50,
          ),
          _cheatRow(
            'Stripes on opening keyboard',
            'Form Column not scrollable',
            'SingleChildScrollView wrap',
            Colors.yellow.shade50,
          ),
          _cheatRow(
            'Corner L-shape stripes',
            'Bidirectional overflow',
            'Shrink child or expand parent',
            Colors.green.shade50,
          ),
          _cheatRow(
            'Stripes inside Card/Padding',
            'Padding > parent space',
            'Reduce padding or remove SizedBox',
            Colors.blue.shade50,
          ),
          _cheatRow(
            'Stripes when device rotates',
            'Hardcoded SizedBox width',
            'Use LayoutBuilder / MediaQuery',
            Colors.indigo.shade50,
          ),
          _cheatRow(
            'Stripes only in release? (rare)',
            'AssertionError in custom paint',
            'Audit assert() calls',
            Colors.purple.shade50,
          ),
        ],
      ),
    ),
  );

  // ===================================================================
  // Footer
  // ===================================================================
  body.add(
    Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFEB3B), Color(0xFFFFC107)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: const Column(
        children: <Widget>[
          Icon(Icons.verified, size: 36.0, color: Colors.black87),
          SizedBox(height: 8.0),
          Text(
            'End of the Overflow Detective\'s Handbook',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'DebugOverflowIndicatorMixin: the most useful debug aid in '
            'Flutter, once you stop being scared of it.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ],
      ),
    ),
  );

  debugPrint('DebugOverflowIndicatorMixin Deep Demo: scene complete');

  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    appBar: AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.yellow.shade400,
      title: const Text('DebugOverflowIndicatorMixin Deep Demo'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: body,
      ),
    ),
  );
}
