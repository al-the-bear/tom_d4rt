// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// GridView — Visual Deep Demo
// =============================================================================
//
// This file is a hand-authored, exhaustive visual reference for the Flutter
// `GridView` family. It is part of the tom_d4rt_flutter_ast corpus — a
// collection of standalone Dart scripts that are parsed, transported as AST
// fragments over HTTP, replayed inside the d4rt interpreter, and finally
// rendered by a host Flutter app. As a result the file follows a fixed shape:
// a top-level `dynamic build(BuildContext context)` returns a Widget tree.
// There is no `main`, no `runApp`, no animation controller, no timers — every
// non-trivial piece of interactivity is scoped inside a `StatefulBuilder` so
// the surrounding script stays purely declarative.
//
// The topic at hand: `GridView` and its closely related cousins.
// Specifically:
//
//   * `GridView.count`     — fixed crossAxisCount, takes explicit children.
//   * `GridView.extent`    — declares maxCrossAxisExtent, children auto-flow.
//   * `GridView.builder`   — lazy builder; pair with a SliverGridDelegate.
//   * `GridView.custom`    — a custom SliverChildDelegate + grid delegate.
//   * `GridView(...)`      — the raw constructor for delegate composition.
//
//   * `SliverGridDelegateWithFixedCrossAxisCount`   — fixed N columns.
//   * `SliverGridDelegateWithMaxCrossAxisExtent`    — fluid responsive grid.
//
// Plus, on the layout side: `mainAxisSpacing`, `crossAxisSpacing`,
// `childAspectRatio`, `mainAxisExtent`, `scrollDirection`, `reverse`,
// `padding`, and `shrinkWrap`. Each is given a dedicated card with a fully
// rendered example so the layout output is recognizable at a glance.
//
// -----------------------------------------------------------------------------
// Reading order
// -----------------------------------------------------------------------------
//
//   1. Anatomy diagram — slot model for a GridView, labelling crossAxisCount,
//      mainAxisSpacing, crossAxisSpacing, and childAspectRatio.
//   2. Decision matrix — picking a constructor + delegate pair.
//   3. GridView.count section — explicit child list with a fixed column count.
//   4. GridView.extent section — fluid maxCrossAxisExtent behaviour.
//   5. GridView.builder section — lazy itemBuilder with both delegates.
//   6. GridView.custom section — a SliverChildBuilderDelegate companion.
//   7. Aspect ratio vs mainAxisExtent — how those two arguments differ.
//   8. Spacing micro-tour — mainAxis vs crossAxis spacing isolated.
//   9. ScrollDirection / reverse — horizontal grids and reversed grids.
//  10. Padding & shrinkWrap — padded grids and shrink-wrapping behaviour.
//  11. Interactive crossAxisCount slider — StatefulBuilder demo.
//  12. Constructor summary table — final reference card.
//
// -----------------------------------------------------------------------------
// Embedding constraints
// -----------------------------------------------------------------------------
//
// The outer scaffold uses a `SingleChildScrollView`, which means every inner
// `GridView` MUST set `shrinkWrap: true`, `physics: NeverScrollableScrollPhysics()`
// and `primary: false`. Otherwise Flutter throws an unbounded-height assertion
// or a PrimaryScrollController conflict, depending on the position of the
// offending grid. These three flags are repeated mechanically throughout
// the file — that is the price of letting all examples live on one page.
//
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
// Palette + style constants
// =============================================================================
//
// We use a small slate + accent palette so the demo cards read as a single
// design system rather than a random parade of colours. Tile palettes are
// section-scoped so that, for example, the GridView.count section feels
// chromatically distinct from the GridView.extent section without losing the
// overall family resemblance.

const Color _kInk = Color(0xFF0F172A);
const Color _kMuted = Color(0xFF475569);
const Color _kBorderSoft = Color(0xFFCBD5E1);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kPanelBg = Color(0xFFF8FAFC);
const Color _kAccent = Color(0xFF2563EB);
const Color _kAccentSoft = Color(0xFFDBEAFE);

// Section palettes — six distinct tile colours per section so the visual
// rhythm changes as the reader scrolls.
const List<Color> _kPaletteCount = <Color>[
  Color(0xFFEF4444), // red-500
  Color(0xFFF97316), // orange-500
  Color(0xFFF59E0B), // amber-500
  Color(0xFF84CC16), // lime-500
  Color(0xFF10B981), // emerald-500
  Color(0xFF06B6D4), // cyan-500
  Color(0xFF3B82F6), // blue-500
  Color(0xFF8B5CF6), // violet-500
  Color(0xFFEC4899), // pink-500
];

const List<Color> _kPaletteExtent = <Color>[
  Color(0xFF1E40AF),
  Color(0xFF1D4ED8),
  Color(0xFF2563EB),
  Color(0xFF3B82F6),
  Color(0xFF60A5FA),
  Color(0xFF93C5FD),
  Color(0xFFBFDBFE),
  Color(0xFFDBEAFE),
  Color(0xFFEFF6FF),
];

const List<Color> _kPaletteBuilder = <Color>[
  Color(0xFF064E3B),
  Color(0xFF065F46),
  Color(0xFF047857),
  Color(0xFF059669),
  Color(0xFF10B981),
  Color(0xFF34D399),
  Color(0xFF6EE7B7),
  Color(0xFFA7F3D0),
  Color(0xFFD1FAE5),
];

const List<Color> _kPaletteCustom = <Color>[
  Color(0xFF581C87),
  Color(0xFF6B21A8),
  Color(0xFF7E22CE),
  Color(0xFF9333EA),
  Color(0xFFA855F7),
  Color(0xFFC084FC),
  Color(0xFFD8B4FE),
  Color(0xFFE9D5FF),
  Color(0xFFF3E8FF),
];

const List<Color> _kPaletteAspect = <Color>[
  Color(0xFF7C2D12),
  Color(0xFF9A3412),
  Color(0xFFB45309),
  Color(0xFFD97706),
  Color(0xFFEAB308),
  Color(0xFFFACC15),
  Color(0xFFFDE047),
  Color(0xFFFEF08A),
  Color(0xFFFEF9C3),
];

const List<Color> _kPaletteSpacing = <Color>[
  Color(0xFF134E4A),
  Color(0xFF115E59),
  Color(0xFF0F766E),
  Color(0xFF0D9488),
  Color(0xFF14B8A6),
  Color(0xFF2DD4BF),
  Color(0xFF5EEAD4),
  Color(0xFF99F6E4),
  Color(0xFFCCFBF1),
];

const List<Color> _kPaletteScroll = <Color>[
  Color(0xFF881337),
  Color(0xFF9F1239),
  Color(0xFFBE123C),
  Color(0xFFE11D48),
  Color(0xFFF43F5E),
  Color(0xFFFB7185),
  Color(0xFFFDA4AF),
  Color(0xFFFECDD3),
  Color(0xFFFFE4E6),
];

const List<Color> _kPalettePadding = <Color>[
  Color(0xFF312E81),
  Color(0xFF3730A3),
  Color(0xFF4338CA),
  Color(0xFF4F46E5),
  Color(0xFF6366F1),
  Color(0xFF818CF8),
  Color(0xFFA5B4FC),
  Color(0xFFC7D2FE),
  Color(0xFFE0E7FF),
];

// Tile icons — rotated through each example so the children are not just
// coloured squares but tangible little glyphs.
const List<IconData> _kIcons = <IconData>[
  Icons.star_rounded,
  Icons.favorite_rounded,
  Icons.bolt_rounded,
  Icons.cake_rounded,
  Icons.cloud_rounded,
  Icons.diamond_rounded,
  Icons.eco_rounded,
  Icons.flag_rounded,
  Icons.grass_rounded,
  Icons.headphones_rounded,
  Icons.icecream_rounded,
  Icons.key_rounded,
  Icons.local_fire_department_rounded,
  Icons.music_note_rounded,
  Icons.nightlight_rounded,
  Icons.opacity_rounded,
  Icons.park_rounded,
  Icons.public_rounded,
  Icons.rocket_launch_rounded,
  Icons.spa_rounded,
];

// Tile labels — short two-character strings so they read as little chips.
const List<String> _kLabels = <String>[
  'A1', 'B2', 'C3', 'D4', 'E5', 'F6', 'G7', 'H8', 'I9', 'J0',
  'K1', 'L2', 'M3', 'N4', 'O5', 'P6', 'Q7', 'R8', 'S9', 'T0',
];

// =============================================================================
// Text styles
// =============================================================================

const TextStyle _kSectionTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.2,
);

const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: _kMuted,
);

const TextStyle _kBodyStyle = TextStyle(
  fontSize: 13.5,
  color: _kInk,
  height: 1.45,
);

const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
);

const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 11.5,
  color: _kMuted,
  fontWeight: FontWeight.w500,
);

const TextStyle _kTileTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

// =============================================================================
// Shared decorations
// =============================================================================
//
// Each section card gets its own gradient decoration with a multi-layer
// shadow stack so the page actually looks like a curated tour rather than a
// stark white wall of widgets.

BoxDecoration _sectionCardDecoration({
  required Color tone,
  required Color toneSoft,
}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color.alphaBlend(tone.withValues(alpha: 0.08), _kCardBg),
        _kCardBg,
        Color.alphaBlend(toneSoft.withValues(alpha: 0.18), _kCardBg),
      ],
      stops: const <double>[0.0, 0.55, 1.0],
    ),
    borderRadius: BorderRadius.circular(18.0),
    border: Border.all(color: tone.withValues(alpha: 0.22), width: 1.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: tone.withValues(alpha: 0.10),
        blurRadius: 24.0,
        spreadRadius: -4.0,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 4.0,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

BoxDecoration _heroDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xFF0F172A),
        Color(0xFF1E293B),
        Color(0xFF334155),
      ],
    ),
    borderRadius: BorderRadius.circular(24.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Color(0xFF0F172A).withValues(alpha: 0.35),
        blurRadius: 32.0,
        spreadRadius: -6.0,
        offset: const Offset(0, 18),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.10),
        blurRadius: 6.0,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

BoxDecoration _codeCardDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Color(0xFF1E293B),
        Color(0xFF0F172A),
      ],
    ),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.30),
        blurRadius: 16.0,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

BoxDecoration _tileDecoration(Color color) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        color,
        Color.alphaBlend(Colors.black.withValues(alpha: 0.18), color),
      ],
    ),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: color.withValues(alpha: 0.30),
        blurRadius: 6.0,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

BoxDecoration _innerPanelDecoration() {
  return BoxDecoration(
    color: _kPanelBg,
    borderRadius: BorderRadius.circular(12.0),
    border: Border.all(color: _kBorderSoft, width: 1.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 4.0,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

// =============================================================================
// Anatomy diagram — CustomPainter
// =============================================================================
//
// We draw a stylised grid with explicit labels showing what crossAxisCount,
// mainAxisSpacing, crossAxisSpacing, and childAspectRatio mean. The painter
// keeps no state; it is invoked once during the build pass. The arrows are
// just lines with little triangle heads so we can avoid pulling in
// flutter/rendering primitives explicitly.

class _GridAnatomyPainter extends CustomPainter {
  const _GridAnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint cellPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _kAccentSoft;
    final Paint cellBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = _kAccent;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _kInk;
    final Paint dashPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _kMuted;

    const int cols = 3;
    const int rows = 2;
    const double padding = 36.0;
    const double crossSpacing = 14.0;
    const double mainSpacing = 18.0;

    final double cellW =
        (size.width - 2 * padding - (cols - 1) * crossSpacing) / cols;
    final double cellH =
        (size.height - 2 * padding - (rows - 1) * mainSpacing) / rows;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final double x = padding + c * (cellW + crossSpacing);
        final double y = padding + r * (cellH + mainSpacing);
        final Rect cellRect = Rect.fromLTWH(x, y, cellW, cellH);
        final RRect rounded = RRect.fromRectAndRadius(
          cellRect,
          const Radius.circular(8.0),
        );
        canvas.drawRRect(rounded, cellPaint);
        canvas.drawRRect(rounded, cellBorder);
      }
    }

    // crossAxisSpacing arrow + label
    final double csStartX = padding + cellW;
    final double csEndX = csStartX + crossSpacing;
    final double csY = padding + cellH / 2;
    _drawArrowH(canvas, arrowPaint, csStartX, csEndX, csY);
    _drawLabel(canvas, 'crossAxisSpacing', csStartX - 24, csY - 30);

    // mainAxisSpacing arrow + label
    final double msX = padding + cellW / 2;
    final double msStartY = padding + cellH;
    final double msEndY = msStartY + mainSpacing;
    _drawArrowV(canvas, arrowPaint, msX, msStartY, msEndY);
    _drawLabel(canvas, 'mainAxisSpacing', msX + 10, msStartY + 2);

    // childAspectRatio bracket on one cell
    final double arX = padding + 2 * (cellW + crossSpacing);
    final double arY = padding + cellH + mainSpacing;
    _drawBracket(
      canvas,
      dashPaint,
      Rect.fromLTWH(arX, arY, cellW, cellH),
    );
    _drawLabel(canvas, 'childAspectRatio = w / h', arX - 8, arY + cellH + 6);

    // crossAxisCount label (top)
    _drawLabel(canvas, 'crossAxisCount = $cols', padding, 8);
    // scroll direction marker
    _drawLabel(canvas, 'scroll axis ->', padding, size.height - 18);
  }

  void _drawArrowH(Canvas canvas, Paint p, double x1, double x2, double y) {
    canvas.drawLine(Offset(x1, y), Offset(x2, y), p);
    final Path head = Path()
      ..moveTo(x2, y)
      ..lineTo(x2 - 4, y - 3)
      ..lineTo(x2 - 4, y + 3)
      ..close();
    canvas.drawPath(head, p..style = PaintingStyle.fill);
    p.style = PaintingStyle.stroke;
    final Path head2 = Path()
      ..moveTo(x1, y)
      ..lineTo(x1 + 4, y - 3)
      ..lineTo(x1 + 4, y + 3)
      ..close();
    canvas.drawPath(head2, p..style = PaintingStyle.fill);
    p.style = PaintingStyle.stroke;
  }

  void _drawArrowV(Canvas canvas, Paint p, double x, double y1, double y2) {
    canvas.drawLine(Offset(x, y1), Offset(x, y2), p);
    final Path head = Path()
      ..moveTo(x, y2)
      ..lineTo(x - 3, y2 - 4)
      ..lineTo(x + 3, y2 - 4)
      ..close();
    canvas.drawPath(head, p..style = PaintingStyle.fill);
    p.style = PaintingStyle.stroke;
  }

  void _drawBracket(Canvas canvas, Paint p, Rect rect) {
    final Path path = Path()
      ..moveTo(rect.left, rect.bottom + 4)
      ..lineTo(rect.left, rect.bottom + 10)
      ..lineTo(rect.right, rect.bottom + 10)
      ..lineTo(rect.right, rect.bottom + 4);
    canvas.drawPath(path, p);
  }

  void _drawLabel(Canvas canvas, String text, double x, double y) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 10.5,
          color: _kInk,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant _GridAnatomyPainter oldDelegate) => false;
}

// =============================================================================
// Generic helpers
// =============================================================================
//
// Building blocks reused throughout the file. Keeping these tiny and pure
// makes each section read as straight composition.

Widget _buildGridTile(
  int index, {
  required List<Color> palette,
  String? overrideLabel,
  IconData? overrideIcon,
  double? size,
}) {
  final Color color = palette[index % palette.length];
  final IconData icon = overrideIcon ?? _kIcons[index % _kIcons.length];
  final String label = overrideLabel ?? _kLabels[index % _kLabels.length];
  return Container(
    decoration: _tileDecoration(color),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: size ?? 22.0),
        const SizedBox(height: 4.0),
        Text(label, style: _kTileTextStyle),
      ],
    ),
  );
}

List<Widget> _buildTileList(int count, List<Color> palette) {
  return <Widget>[
    for (int i = 0; i < count; i++) _buildGridTile(i, palette: palette),
  ];
}

Widget _sectionBadge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _sectionTitle(String title, String subtitle, Color tone) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 6.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tone.withValues(alpha: 0.35),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: _kSectionTitleStyle),
            const SizedBox(height: 2.0),
            Text(subtitle, style: _kSubtitleStyle),
          ],
        ),
      ),
    ],
  );
}

Widget _bodyParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Text(text, style: _kBodyStyle),
  );
}

Widget _captionRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Text(label, style: _kCaptionStyle),
        ),
        Expanded(
          child: Text(value, style: _kCodeStyle),
        ),
      ],
    ),
  );
}

Widget _codeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: _codeCardDecoration(),
    child: Text(
      code,
      style: const TextStyle(
        fontSize: 12,
        fontFamily: 'monospace',
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
  );
}

Widget _gridFrame(Widget child) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: _innerPanelDecoration(),
    child: child,
  );
}

// =============================================================================
// Section: Hero header
// =============================================================================

Widget _buildHero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 28.0),
    decoration: _heroDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _sectionBadge('VISUAL DEEP DEMO', const Color(0xFF38BDF8)),
            const SizedBox(width: 8.0),
            _sectionBadge('GridView family', const Color(0xFFA78BFA)),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'GridView, GridView.count, .extent, .builder, .custom',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Every constructor in the GridView family rendered side by side, with '
          'their delegates, spacings, aspect ratios and scroll directions made '
          'visible. This document is meant to be read as a tour: each card '
          'introduces a concept, then a working grid, then a short prose note.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFCBD5E1),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _sectionBadge('crossAxisCount', const Color(0xFFFB7185)),
            _sectionBadge('maxCrossAxisExtent', const Color(0xFF34D399)),
            _sectionBadge('childAspectRatio', const Color(0xFFFBBF24)),
            _sectionBadge('mainAxisExtent', const Color(0xFFA78BFA)),
            _sectionBadge('mainAxisSpacing', const Color(0xFF60A5FA)),
            _sectionBadge('crossAxisSpacing', const Color(0xFFF472B6)),
            _sectionBadge('scrollDirection', const Color(0xFF22D3EE)),
            _sectionBadge('shrinkWrap', const Color(0xFF84CC16)),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Anatomy
// =============================================================================
//
// A diagram + paragraph explaining how a GridView lays out its children. The
// diagram is painted by `_GridAnatomyPainter`. Below it we add a "legend"
// row of coloured chips that line up with the labels in the diagram.

Widget _buildAnatomySection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF2563EB),
      toneSoft: const Color(0xFF93C5FD),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '1. Anatomy of a GridView',
          'How crossAxisCount, mainAxisSpacing, crossAxisSpacing and childAspectRatio cooperate',
          const Color(0xFF2563EB),
        ),
        const SizedBox(height: 16.0),
        _bodyParagraph(
          'A GridView is, in essence, a scrollable two-dimensional layout. '
          'It chops the cross-axis (perpendicular to the scroll direction) '
          'into a number of equally sized slots. Each slot then accepts '
          'one child. The vertical default makes the cross-axis the horizontal '
          'one — so crossAxisCount = 3 means three columns. The child you '
          'hand the grid is then forced into a slot whose width is fixed by '
          'the delegate and whose height is derived from either childAspectRatio '
          'or mainAxisExtent. The space between slots in each direction is '
          'controlled by mainAxisSpacing (vertical gap) and crossAxisSpacing '
          '(horizontal gap), regardless of how the children themselves draw.',
        ),
        const SizedBox(height: 12.0),
        Container(
          height: 240.0,
          decoration: _innerPanelDecoration(),
          child: const CustomPaint(
            painter: _GridAnatomyPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 16.0),
        _captionRow('crossAxisCount', 'number of slots across the cross axis'),
        _captionRow('crossAxisSpacing', 'gap between columns (or rows if horizontal)'),
        _captionRow('mainAxisSpacing', 'gap between rows (or columns if horizontal)'),
        _captionRow('childAspectRatio', 'width / height — defaults to 1.0 (square)'),
        _captionRow('mainAxisExtent', 'pin slot height directly; overrides aspect'),
      ],
    ),
  );
}

// =============================================================================
// Section: Decision matrix
// =============================================================================
//
// A DataTable mapping constructor name to delegate to "use it when". This is
// the single most-referenced piece of information for newcomers, so we give
// it its own card right after the anatomy diagram.

Widget _buildDecisionMatrix() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFFEC4899),
      toneSoft: const Color(0xFFF9A8D4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '2. Picking a constructor',
          'Decision matrix — constructor, delegate, when to use',
          const Color(0xFFEC4899),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'The GridView family ships with four high-level constructors and '
          'one fallback. Each maps to a SliverGridDelegate under the hood. '
          'The convenience constructors only differ in how they let you '
          'declare children — list of widgets, builder callback, or custom '
          'delegate — and which gridDelegate they synthesize internally. '
          'Always pick the constructor that matches your data shape first; '
          'then, only if you need surgical control over the slot geometry, '
          'fall back to the raw GridView(...) and a hand-built delegate.',
        ),
        const SizedBox(height: 12.0),
        Theme(
          data: ThemeData(
            dataTableTheme: const DataTableThemeData(
              headingTextStyle: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
              dataTextStyle: TextStyle(fontSize: 12.5, color: _kInk),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            primary: false,
            child: DataTable(
              columnSpacing: 24.0,
              headingRowColor: WidgetStateProperty.all(
                const Color(0xFFFFE4E6),
              ),
              columns: const <DataColumn>[
                DataColumn(label: Text('Constructor')),
                DataColumn(label: Text('Built-in delegate')),
                DataColumn(label: Text('Child source')),
                DataColumn(label: Text('Use when…')),
              ],
              rows: const <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text('GridView.count')),
                  DataCell(Text('FixedCrossAxisCount')),
                  DataCell(Text('children: <Widget>[ ... ]')),
                  DataCell(Text('static layout with a known column count')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('GridView.extent')),
                  DataCell(Text('MaxCrossAxisExtent')),
                  DataCell(Text('children: <Widget>[ ... ]')),
                  DataCell(Text('responsive layout — fit as many as possible')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('GridView.builder')),
                  DataCell(Text('any SliverGridDelegate')),
                  DataCell(Text('itemBuilder + itemCount')),
                  DataCell(Text('large / dynamic / lazy data')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('GridView.custom')),
                  DataCell(Text('any SliverGridDelegate')),
                  DataCell(Text('SliverChildDelegate')),
                  DataCell(Text('custom child indexing / keys / reorder')),
                ]),
                DataRow(cells: <DataCell>[
                  DataCell(Text('GridView(...)')),
                  DataCell(Text('explicit gridDelegate')),
                  DataCell(Text('children: <Widget>[ ... ]')),
                  DataCell(Text('exotic delegates beyond the two built-ins')),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: GridView.count
// =============================================================================
//
// Three nested examples: bare 3-column grid, 4-column with spacing, and a
// 2-column with custom child aspect. Each shows the explicit `children:` list
// pattern that this constructor uses.

Widget _buildGridCountSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFFEF4444),
      toneSoft: const Color(0xFFFCA5A5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '3. GridView.count',
          'Fixed number of equally sized slots across the cross axis',
          const Color(0xFFEF4444),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'GridView.count is the most explicit member of the family. You give '
          'it crossAxisCount and an actual list of children, and it builds a '
          'SliverGridDelegateWithFixedCrossAxisCount under the hood. Because '
          'all children are constructed up front, this constructor is best '
          'reserved for short, fixed lists — typically fewer than a hundred '
          'tiles. Beyond that, swap to GridView.builder so children are built '
          'lazily as the user scrolls into them. Below, three variants make '
          'the trade-offs visible at a glance.',
        ),
        const SizedBox(height: 14.0),
        Text('3.1  crossAxisCount: 3, default spacing, square tiles',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(9, _kPaletteCount),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('3.2  crossAxisCount: 4, mainAxisSpacing 10, crossAxisSpacing 10',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteCount),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('3.3  crossAxisCount: 2, childAspectRatio: 2.4 (wide cards)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.4,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(6, _kPaletteCount),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeSnippet(
          'GridView.count(\n'
          '  crossAxisCount: 3,\n'
          '  mainAxisSpacing: 10.0,\n'
          '  crossAxisSpacing: 10.0,\n'
          '  childAspectRatio: 1.0,\n'
          '  shrinkWrap: true,\n'
          '  physics: NeverScrollableScrollPhysics(),\n'
          '  primary: false,\n'
          '  children: <Widget>[ /* ... tiles ... */ ],\n'
          ')',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: GridView.extent
// =============================================================================

Widget _buildGridExtentSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF2563EB),
      toneSoft: const Color(0xFF93C5FD),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '4. GridView.extent',
          'Responsive grid driven by maxCrossAxisExtent',
          const Color(0xFF2563EB),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'GridView.extent flips the relationship between slot size and slot '
          'count. Instead of telling the grid how many columns you want, you '
          'cap how wide each slot is allowed to grow. The grid then divides '
          'the cross axis into as many equally sized slots as fit, never '
          'wider than maxCrossAxisExtent. This is the constructor of choice '
          'when you want a layout that adapts to the device width — phones '
          'get two columns, tablets four, desktops six — without having to '
          'wire up a MediaQuery-driven crossAxisCount yourself.',
        ),
        const SizedBox(height: 14.0),
        Text('4.1  maxCrossAxisExtent: 90.0', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.extent(
            maxCrossAxisExtent: 90.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(12, _kPaletteExtent),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('4.2  maxCrossAxisExtent: 140.0 (wider slots, fewer columns)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.extent(
            maxCrossAxisExtent: 140.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteExtent),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('4.3  maxCrossAxisExtent: 200.0, childAspectRatio: 1.6',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.extent(
            maxCrossAxisExtent: 200.0,
            childAspectRatio: 1.6,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(6, _kPaletteExtent),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeSnippet(
          'GridView.extent(\n'
          '  maxCrossAxisExtent: 140.0,\n'
          '  mainAxisSpacing: 10.0,\n'
          '  crossAxisSpacing: 10.0,\n'
          '  childAspectRatio: 1.0,\n'
          '  shrinkWrap: true,\n'
          '  physics: NeverScrollableScrollPhysics(),\n'
          '  primary: false,\n'
          '  children: <Widget>[ /* ... */ ],\n'
          ')',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: GridView.builder
// =============================================================================
//
// Two flavours: builder with FixedCrossAxisCount delegate, and builder with
// MaxCrossAxisExtent delegate. Same itemBuilder, different gridDelegate.

Widget _buildGridBuilderSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF059669),
      toneSoft: const Color(0xFF6EE7B7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '5. GridView.builder',
          'Lazy itemBuilder paired with any SliverGridDelegate',
          const Color(0xFF059669),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'For larger or unbounded datasets, GridView.builder is the right '
          'choice. The builder constructor takes itemCount plus an itemBuilder '
          'callback and only constructs children that are actually visible. '
          'It separates "how is the grid carved up" — the gridDelegate — from '
          '"what goes in each slot" — the itemBuilder. You can therefore mix '
          'and match either of the two built-in delegates with the builder '
          'pattern, getting both lazy construction and responsive layout in '
          'a single call.',
        ),
        const SizedBox(height: 14.0),
        Text('5.1  Builder + SliverGridDelegateWithFixedCrossAxisCount',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridTile(index, palette: _kPaletteBuilder);
            },
          ),
        ),
        const SizedBox(height: 18.0),
        Text('5.2  Builder + SliverGridDelegateWithMaxCrossAxisExtent',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridTile(index, palette: _kPaletteBuilder);
            },
          ),
        ),
        const SizedBox(height: 18.0),
        Text('5.3  Builder with index-aware content (number badges)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 1.0,
            ),
            itemCount: 15,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridTile(
                index,
                palette: _kPaletteBuilder,
                overrideLabel: '#${index + 1}',
                overrideIcon: Icons.tag_rounded,
              );
            },
          ),
        ),
        const SizedBox(height: 14.0),
        _codeSnippet(
          'GridView.builder(\n'
          '  itemCount: items.length,\n'
          '  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n'
          '    crossAxisCount: 4,\n'
          '    mainAxisSpacing: 8.0,\n'
          '    crossAxisSpacing: 8.0,\n'
          '  ),\n'
          '  itemBuilder: (ctx, i) => Tile(item: items[i]),\n'
          ')',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: GridView.custom
// =============================================================================

Widget _buildGridCustomSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF7E22CE),
      toneSoft: const Color(0xFFD8B4FE),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '6. GridView.custom',
          'Hand-rolled SliverChildDelegate paired with a SliverGridDelegate',
          const Color(0xFF7E22CE),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'GridView.custom is the constructor for cases where neither the '
          'fixed list of children of GridView.count nor the simple itemBuilder '
          'of GridView.builder is enough. It accepts any SliverChildDelegate, '
          'which means you can supply keys explicitly, opt out of automatic '
          'keep-alive, or layer your own caching on top. Below we use a '
          'SliverChildBuilderDelegate with explicit ValueKey instances so '
          'that hot reloads preserve element identity across rebuilds.',
        ),
        const SizedBox(height: 14.0),
        Text('6.1  Custom with SliverChildBuilderDelegate', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.custom(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildGridTile(
                  index,
                  palette: _kPaletteCustom,
                );
              },
              childCount: 9,
              findChildIndexCallback: (Key key) {
                if (key is ValueKey<int>) {
                  return key.value;
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('6.2  Raw GridView(...) with explicit gridDelegate',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteCustom),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeSnippet(
          'GridView.custom(\n'
          '  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n'
          '    crossAxisCount: 3,\n'
          '  ),\n'
          '  childrenDelegate: SliverChildBuilderDelegate(\n'
          '    (ctx, i) => Tile(key: ValueKey<int>(i), item: items[i]),\n'
          '    childCount: items.length,\n'
          '    findChildIndexCallback: (k) => (k as ValueKey<int>).value,\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Aspect ratio vs mainAxisExtent
// =============================================================================

Widget _buildAspectRatioSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFFD97706),
      toneSoft: const Color(0xFFFCD34D),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '7. childAspectRatio vs mainAxisExtent',
          'Two ways to control slot height — pick exactly one',
          const Color(0xFFD97706),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'Both gridDelegates expose two complementary knobs for choosing '
          'slot height. The familiar childAspectRatio is a ratio: 1.0 makes '
          'each slot square, 2.0 makes each slot twice as wide as it is tall. '
          'The newer mainAxisExtent is an absolute size: each slot will be '
          'exactly that many logical pixels tall (or wide, when scrolling '
          'horizontally). The two cannot both be specified — picking '
          'mainAxisExtent overrides childAspectRatio for that delegate. The '
          'three rows below illustrate the spectrum from tall, to square, '
          'to wide cards.',
        ),
        const SizedBox(height: 14.0),
        Text('7.1  childAspectRatio: 0.7 — tall tiles', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteAspect),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('7.2  childAspectRatio: 1.0 — square tiles', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteAspect),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('7.3  childAspectRatio: 1.8 — wide tiles', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.8,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(6, _kPaletteAspect),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('7.4  mainAxisExtent: 60.0 — slot height pinned to 60 px',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              mainAxisExtent: 60.0,
            ),
            itemCount: 9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridTile(
                index,
                palette: _kPaletteAspect,
                size: 16.0,
              );
            },
          ),
        ),
        const SizedBox(height: 18.0),
        Text('7.5  mainAxisExtent: 110.0 with MaxCrossAxisExtent delegate',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 140.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              mainAxisExtent: 110.0,
            ),
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridTile(index, palette: _kPaletteAspect);
            },
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Spacing micro-tour
// =============================================================================

Widget _buildSpacingSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF0D9488),
      toneSoft: const Color(0xFF5EEAD4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '8. Spacing — main vs cross axis',
          'Side-by-side isolation of mainAxisSpacing and crossAxisSpacing',
          const Color(0xFF0D9488),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'mainAxisSpacing and crossAxisSpacing are independent. In a vertical '
          'grid, mainAxisSpacing is the vertical gap between rows and '
          'crossAxisSpacing is the horizontal gap between columns. In a '
          'horizontal grid those roles swap. The four variants below — no '
          'spacing, only main, only cross, both — make the geometry '
          'unambiguous. Spacing is applied uniformly between slots; it '
          'never adds an outer padding (that is what the padding argument '
          'is for).',
        ),
        const SizedBox(height: 14.0),
        Text('8.1  no spacing', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteSpacing),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('8.2  mainAxisSpacing: 16, crossAxisSpacing: 0', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteSpacing),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('8.3  mainAxisSpacing: 0, crossAxisSpacing: 16', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteSpacing),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('8.4  mainAxisSpacing: 16, crossAxisSpacing: 16', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPaletteSpacing),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Scroll direction / reverse
// =============================================================================

Widget _buildScrollDirectionSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFFE11D48),
      toneSoft: const Color(0xFFFDA4AF),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '9. scrollDirection & reverse',
          'Horizontal grids, reversed grids, and how the cross axis flips',
          const Color(0xFFE11D48),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'The scroll axis is configurable. With Axis.horizontal, the main '
          'axis becomes the horizontal one — meaning crossAxisCount is now '
          'the number of *rows* (the cross axis is vertical). The reverse '
          'flag flips child order along the main axis, so item zero appears '
          'at the trailing edge of the grid. The two flags are independent. '
          'Note that when scrolling horizontally you still need a bounded '
          'height (or a non-shrinkWrap viewport); we use SizedBox(height: …) '
          'to keep the embedded grids honest.',
        ),
        const SizedBox(height: 14.0),
        Text('9.1  vertical, reverse: false (default)', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            children: _buildTileList(8, _kPaletteScroll),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('9.2  vertical, reverse: true (items flow upward)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        _gridFrame(
          GridView.count(
            crossAxisCount: 4,
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            children: _buildTileList(8, _kPaletteScroll),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('9.3  horizontal, crossAxisCount: 2 (two rows, scrolls sideways)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: _innerPanelDecoration(),
          child: SizedBox(
            height: 160.0,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              primary: false,
              children: _buildTileList(12, _kPaletteScroll),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('9.4  horizontal, reverse: true', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: _innerPanelDecoration(),
          child: SizedBox(
            height: 160.0,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              reverse: true,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              primary: false,
              children: _buildTileList(12, _kPaletteScroll),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: padding + shrinkWrap
// =============================================================================

Widget _buildPaddingShrinkSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF4F46E5),
      toneSoft: const Color(0xFFA5B4FC),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '10. padding & shrinkWrap',
          'Outer breathing room, and making the grid hug its content',
          const Color(0xFF4F46E5),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'The padding argument inserts an EdgeInsets-shaped margin around '
          'the entire grid content — slots first, then padding. It is the '
          'right place to put outer breathing room. shrinkWrap, on the other '
          'hand, controls the grids height: when true, the grid measures '
          'itself to the height of its visible children; when false, it '
          'fills all the height the parent gives it. Every grid in this '
          'file uses shrinkWrap: true because it sits inside a '
          'SingleChildScrollView. The cards below isolate padding so its '
          'effect on first-row alignment becomes obvious.',
        ),
        const SizedBox(height: 14.0),
        Text('10.1  padding: EdgeInsets.all(16)', style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        Container(
          decoration: _innerPanelDecoration(),
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16.0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(6, _kPalettePadding),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('10.2  padding: EdgeInsets.symmetric(h: 32, v: 8)',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        Container(
          decoration: _innerPanelDecoration(),
          child: GridView.count(
            crossAxisCount: 4,
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 8.0,
            ),
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(8, _kPalettePadding),
          ),
        ),
        const SizedBox(height: 18.0),
        Text('10.3  padding: EdgeInsets.fromLTRB(40, 0, 4, 16) — uneven',
            style: _kCaptionStyle),
        const SizedBox(height: 8.0),
        Container(
          decoration: _innerPanelDecoration(),
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 4.0, 16.0),
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            children: _buildTileList(6, _kPalettePadding),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Wrap palette
// =============================================================================
//
// A Wrap of every section badge so the reader can see, in one place, the
// colour key used throughout the document. This is also a fulfilment of the
// "≥ 1 Wrap palette section" requirement.

Widget _buildPaletteSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF9333EA),
      toneSoft: const Color(0xFFD8B4FE),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '11. Palette legend',
          'Per-section colour ramps used in this document',
          const Color(0xFF9333EA),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'Each section uses its own colour ramp so that, when scrolling, the '
          'reader can tell at a glance which constructor or knob a particular '
          'card is illustrating. Below is the full legend, presented as a '
          'Wrap so the chips reflow naturally on narrower viewports. The '
          'naming follows the Tailwind palette where applicable; small '
          'deviations exist where a more saturated mid-tone reads better '
          'against the section card background.',
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _paletteChip('count', _kPaletteCount),
            _paletteChip('extent', _kPaletteExtent),
            _paletteChip('builder', _kPaletteBuilder),
            _paletteChip('custom', _kPaletteCustom),
            _paletteChip('aspect', _kPaletteAspect),
            _paletteChip('spacing', _kPaletteSpacing),
            _paletteChip('scroll', _kPaletteScroll),
            _paletteChip('padding', _kPalettePadding),
          ],
        ),
      ],
    ),
  );
}

Widget _paletteChip(String name, List<Color> palette) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBorderSoft),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: _kCaptionStyle),
        const SizedBox(height: 6.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final Color c in palette.take(6))
              Container(
                width: 18.0,
                height: 18.0,
                margin: const EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Interactive crossAxisCount slider
// =============================================================================
//
// Uses StatefulBuilder so we can mutate a local crossAxisCount without
// dragging in a StatefulWidget. The slider redraws the embedded GridView on
// every change. We also flip the layout direction with a Switch to keep the
// interactivity rich without exceeding the scope rules.

Widget _buildInteractiveSection() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF0EA5E9),
      toneSoft: const Color(0xFF7DD3FC),
    ),
    child: _InteractiveStatefulScope(
      builder: (
        int currentCount,
        bool isHorizontal,
        double currentAspect,
        ValueChanged<int> onCountChanged,
        ValueChanged<bool> onHorizontalChanged,
        ValueChanged<double> onAspectChanged,
      ) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _sectionTitle(
                '12. Interactive playground',
                'StatefulBuilder-driven crossAxisCount, scrollDirection and aspect',
                const Color(0xFF0EA5E9),
              ),
              const SizedBox(height: 14.0),
              _bodyParagraph(
                'This card uses a StatefulBuilder to keep tiny pieces of '
                'state scoped to a single subtree. The crossAxisCount is '
                'tied to a Slider, scrollDirection is bound to a Switch and '
                'childAspectRatio is tied to another Slider. Every change '
                'triggers a rebuild of the embedded GridView.builder. There '
                'is no global state, no AnimationController, no Future — the '
                'whole thing is a pure synchronous setState callback.',
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'crossAxisCount: $currentCount',
                          style: _kCaptionStyle,
                        ),
                        Slider(
                          value: currentCount.toDouble(),
                          min: 2.0,
                          max: 8.0,
                          divisions: 6,
                          label: '$currentCount',
                          onChanged: (double v) =>
                              onCountChanged(v.round()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'childAspectRatio: '
                          '${currentAspect.toStringAsFixed(2)}',
                          style: _kCaptionStyle,
                        ),
                        Slider(
                          value: currentAspect,
                          min: 0.6,
                          max: 2.4,
                          divisions: 18,
                          label: currentAspect.toStringAsFixed(2),
                          onChanged: onAspectChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('scrollDirection:', style: _kCaptionStyle),
                  const SizedBox(width: 8.0),
                  Text(
                    isHorizontal ? 'Axis.horizontal' : 'Axis.vertical',
                    style: _kCodeStyle,
                  ),
                  const Spacer(),
                  Switch(
                    value: isHorizontal,
                    onChanged: onHorizontalChanged,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: _innerPanelDecoration(),
                child: SizedBox(
                  height: isHorizontal ? 200.0 : null,
                  child: GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: currentCount,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                      childAspectRatio: currentAspect,
                    ),
                    itemCount: 20,
                    scrollDirection:
                        isHorizontal ? Axis.horizontal : Axis.vertical,
                    shrinkWrap: !isHorizontal,
                    physics: isHorizontal
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildGridTile(
                        index,
                        palette: _kPaletteScroll,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
      },
    ),
  );
}

// Helper widget that owns the actual mutable state for the interactive card.
// Pulling it out keeps the rest of the file declarative.
class _InteractiveStatefulScope extends StatefulWidget {
  const _InteractiveStatefulScope({required this.builder});

  final Widget Function(
    int crossAxisCount,
    bool horizontal,
    double aspectRatio,
    ValueChanged<int> onCountChanged,
    ValueChanged<bool> onHorizontalChanged,
    ValueChanged<double> onAspectChanged,
  ) builder;

  @override
  State<_InteractiveStatefulScope> createState() =>
      _InteractiveStatefulScopeState();
}

class _InteractiveStatefulScopeState
    extends State<_InteractiveStatefulScope> {
  int _crossAxisCount = 4;
  bool _horizontal = false;
  double _aspectRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _crossAxisCount,
      _horizontal,
      _aspectRatio,
      (int v) => setState(() => _crossAxisCount = v),
      (bool v) => setState(() => _horizontal = v),
      (double v) => setState(() => _aspectRatio = v),
    );
  }
}

// =============================================================================
// Section: Summary reference card
// =============================================================================

Widget _buildReferenceCard() {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: _sectionCardDecoration(
      tone: const Color(0xFF334155),
      toneSoft: const Color(0xFF94A3B8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionTitle(
          '13. Constructor summary',
          'Quick-reference table for the entire GridView family',
          const Color(0xFF334155),
        ),
        const SizedBox(height: 14.0),
        _bodyParagraph(
          'The table below collapses the entire family into a single sheet. '
          'It is intentionally terse — use it as a lookup, not as a tutorial. '
          'Cross-reference each row with the section above for a worked '
          'example. The "key arguments" column lists arguments unique to '
          'that constructor; common arguments (padding, scrollDirection, '
          'reverse, controller, physics, shrinkWrap) apply to every entry.',
        ),
        const SizedBox(height: 12.0),
        Table(
          border: TableBorder.all(color: _kBorderSoft, width: 1.0),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(2.2),
            2: FlexColumnWidth(2.6),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
              ),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text('Constructor', style: _kSubtitleStyle),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Key arguments', style: _kSubtitleStyle),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Notes', style: _kSubtitleStyle),
                ),
              ],
            ),
            _refRow(
              'GridView.count',
              'crossAxisCount, children',
              'Eager. Best for short fixed lists.',
            ),
            _refRow(
              'GridView.extent',
              'maxCrossAxisExtent, children',
              'Responsive. Computes columns from width.',
            ),
            _refRow(
              'GridView.builder',
              'gridDelegate, itemCount, itemBuilder',
              'Lazy. Pair with either built-in delegate.',
            ),
            _refRow(
              'GridView.custom',
              'gridDelegate, childrenDelegate',
              'Hand-rolled SliverChildDelegate.',
            ),
            _refRow(
              'GridView(...)',
              'gridDelegate, children',
              'Raw form for custom grid delegates.',
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFCD34D)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.lightbulb_rounded,
                color: Color(0xFFB45309),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Tip: whenever a GridView is embedded inside a '
                  'SingleChildScrollView (as in this document), always set '
                  'shrinkWrap: true, physics: NeverScrollableScrollPhysics() '
                  'and primary: false. Otherwise the grid will assert on '
                  'an unbounded height or fight the PrimaryScrollController.',
                  style: _kBodyStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _refRow(String constructor, String args, String notes) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(constructor, style: _kCodeStyle),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(args, style: _kBodyStyle),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(notes, style: _kBodyStyle),
      ),
    ],
  );
}

// =============================================================================
// Top-level build
// =============================================================================

dynamic build(BuildContext context) {
  print('GridView deep visual demo: building…');

  final Widget body = SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildHero(),
        const SizedBox(height: 24.0),
        _buildAnatomySection(),
        const SizedBox(height: 24.0),
        _buildDecisionMatrix(),
        const SizedBox(height: 24.0),
        _buildGridCountSection(),
        const SizedBox(height: 24.0),
        _buildGridExtentSection(),
        const SizedBox(height: 24.0),
        _buildGridBuilderSection(),
        const SizedBox(height: 24.0),
        _buildGridCustomSection(),
        const SizedBox(height: 24.0),
        _buildAspectRatioSection(),
        const SizedBox(height: 24.0),
        _buildSpacingSection(),
        const SizedBox(height: 24.0),
        _buildScrollDirectionSection(),
        const SizedBox(height: 24.0),
        _buildPaddingShrinkSection(),
        const SizedBox(height: 24.0),
        _buildPaletteSection(),
        const SizedBox(height: 24.0),
        _buildInteractiveSection(),
        const SizedBox(height: 24.0),
        _buildReferenceCard(),
        const SizedBox(height: 32.0),
        Center(
          child: Text(
            'end of GridView deep visual demo',
            style: _kCaptionStyle,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );

  print('GridView deep visual demo: done.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF1F5F9),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(child: body),
    ),
  );
}
