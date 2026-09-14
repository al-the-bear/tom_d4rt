// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for CupertinoThumbPainter and
// associated Cupertino slider/switch family
// =====================================================================
// CupertinoThumbPainter — Deep Visual Demo
// =====================================================================
//
// CupertinoThumbPainter is the small, sharply-focused primitive that
// draws the iOS-style thumb (the small circle) used inside both
// CupertinoSlider and CupertinoSwitch.  It is *not* a widget — it is a
// plain Dart class that exposes a `paint(Canvas canvas, Rect rect)`
// method, two static constants, and two named factory / constructor
// forms.  When the framework draws a slider thumb or a switch thumb it
// constructs an instance of this class, sets the rectangle for the
// thumb, and calls `paint`.
//
// Class summary (verbatim from flutter/cupertino/thumb_painter.dart):
//
//   class CupertinoThumbPainter {
//     const CupertinoThumbPainter({
//       this.color = CupertinoColors.white,
//       this.shadows = _kSliderBoxShadows,
//     });
//
//     const CupertinoThumbPainter.switchThumb({
//       Color color = CupertinoColors.white,
//       List<BoxShadow> shadows = _kSwitchBoxShadows,
//     }) : this(color: color, shadows: shadows);
//
//     final Color color;
//     final List<BoxShadow> shadows;
//     static const double radius = 14.0;
//     static const double extension = 7.0;
//
//     void paint(Canvas canvas, Rect rect) { ... }
//   }
//
// Notable points the demo highlights:
//   * `radius` is half the natural thumb diameter — 14.0 px → 28.0 px
//     thumb.  Slider rendering uses this to lay out track widths.
//   * `extension` is how many pixels the thumb is allowed to stretch
//     when the user is dragging — adds 7.0 px to the active side.
//   * The default slider shadow stack has THREE BoxShadows; the
//     switchThumb shadow stack has TWO BoxShadows; the difference is
//     subtle but visible in side-by-side comparison cards.
//   * A faint border with alpha 0x0A is painted under the fill so that
//     the thumb stays visible on solid white backgrounds.
//
// The demo is intentionally rich:
//   * Section 1 — Anatomy CustomPaint diagram with labels
//   * Section 2 — Painter catalog: 12 painters drawn through CustomPaint
//   * Section 3 — Sizing reference card (radius vs extension)
//   * Section 4 — CupertinoSlider state gallery (8 snapshots)
//   * Section 5 — CupertinoSwitch state gallery (8 snapshots)
//   * Section 6 — Shadow ablation comparison (no / one / two / three)
//   * Section 7 — Color theme matrix (5 themes × 2 painter kinds)
//   * Section 8 — Family context: filled button + activity indicator
//   * Section 9 — Mock Cupertino settings screen putting it all together
// =====================================================================

import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------
//
// Most of the demo uses a small, named palette of constants so the
// sections feel visually related and the harness can reference the same
// numbers in multiple places.
// ---------------------------------------------------------------------

const double _kSectionPad = 20.0;
const double _kCardRadius = 16.0;
const double _kGapXs = 4.0;
const double _kGapSm = 8.0;
const double _kGapMd = 12.0;
const double _kGapLg = 20.0;
const double _kGapXl = 28.0;

const Color _kInkPrimary = Color(0xFF1F1F23);
const Color _kInkSecondary = Color(0xFF555560);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kPaperLight = Color(0xFFFBFBFD);
const Color _kPaperMid = Color(0xFFF1F1F4);
const Color _kPaperDeep = Color(0xFFE6E6EB);
const Color _kStrokeLine = Color(0xFFCFCFD3);

// Cupertino accent palette referenced by multiple sections.
const List<Color> _kAccentPalette = <Color>[
  CupertinoColors.activeBlue,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemPurple,
  CupertinoColors.systemPink,
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemTeal,
];

const List<String> _kAccentNames = <String>[
  'activeBlue',
  'systemIndigo',
  'systemPurple',
  'systemPink',
  'systemRed',
  'systemOrange',
  'systemYellow',
  'systemGreen',
  'systemTeal',
];

// Slider shadow stack — re-declared here so we can use it in custom
// painter ablations without relying on a private framework constant.
const List<BoxShadow> _kReferenceSliderShadows = <BoxShadow>[
  BoxShadow(color: Color(0x26000000), offset: Offset(0, 3), blurRadius: 8.0),
  BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 1.0),
  BoxShadow(color: Color(0x1A000000), offset: Offset(0, 3), blurRadius: 1.0),
];

// Switch shadow stack — same as above but only two shadows.
const List<BoxShadow> _kReferenceSwitchShadows = <BoxShadow>[
  BoxShadow(color: Color(0x26000000), offset: Offset(0, 3), blurRadius: 8.0),
  BoxShadow(color: Color(0x0F000000), offset: Offset(0, 3), blurRadius: 1.0),
];

// =====================================================================
// build(BuildContext)
// =====================================================================
//
// Returns a CupertinoApp wrapping a navigation bar + ListView.  Each
// list child is one section widget.  The build function logs every
// section it composes so that the test harness can confirm coverage.
// =====================================================================
dynamic build(BuildContext context) {
  print('CupertinoThumbPainter deep demo: build() starting');

  // Construct a flight of painters up front so the harness has a clear
  // log of every distinct configuration the demo exercises.
  final defaultPainter = CupertinoThumbPainter();
  final defaultSwitch = CupertinoThumbPainter.switchThumb();
  final bluePainter = CupertinoThumbPainter(color: CupertinoColors.activeBlue);
  final indigoPainter = CupertinoThumbPainter(color: CupertinoColors.systemIndigo);
  final pinkPainter = CupertinoThumbPainter(color: CupertinoColors.systemPink);
  final greenPainter = CupertinoThumbPainter(color: CupertinoColors.systemGreen);
  final greySwitch = CupertinoThumbPainter.switchThumb(color: CupertinoColors.systemGrey);
  final tealSwitch = CupertinoThumbPainter.switchThumb(color: CupertinoColors.systemTeal);
  final noShadowPainter = CupertinoThumbPainter(
    color: CupertinoColors.white,
    shadows: <BoxShadow>[],
  );
  final heavyShadowPainter = CupertinoThumbPainter(
    color: CupertinoColors.white,
    shadows: <BoxShadow>[
      BoxShadow(color: Color(0x66000000), offset: Offset(0, 6), blurRadius: 12.0),
      BoxShadow(color: Color(0x33000000), offset: Offset(0, 12), blurRadius: 22.0),
    ],
  );
  final twoShadowPainter = CupertinoThumbPainter(
    color: CupertinoColors.white,
    shadows: <BoxShadow>[
      BoxShadow(color: Color(0x33000000), offset: Offset(0, 4), blurRadius: 6.0),
      BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 2.0),
    ],
  );
  final singleShadowPainter = CupertinoThumbPainter(
    color: CupertinoColors.white,
    shadows: <BoxShadow>[
      BoxShadow(color: Color(0x40000000), offset: Offset(0, 3), blurRadius: 5.0),
    ],
  );

  print('  painter inventory:');
  print('    defaultPainter        hash=${defaultPainter.hashCode}');
  print('    defaultSwitch         hash=${defaultSwitch.hashCode}');
  print('    bluePainter           hash=${bluePainter.hashCode}');
  print('    indigoPainter         hash=${indigoPainter.hashCode}');
  print('    pinkPainter           hash=${pinkPainter.hashCode}');
  print('    greenPainter          hash=${greenPainter.hashCode}');
  print('    greySwitch            hash=${greySwitch.hashCode}');
  print('    tealSwitch            hash=${tealSwitch.hashCode}');
  print('    noShadowPainter       hash=${noShadowPainter.hashCode}');
  print('    heavyShadowPainter    hash=${heavyShadowPainter.hashCode}');
  print('    twoShadowPainter      hash=${twoShadowPainter.hashCode}');
  print('    singleShadowPainter   hash=${singleShadowPainter.hashCode}');

  print('  static constants:');
  print('    radius     = ${CupertinoThumbPainter.radius}');
  print('    extension  = ${CupertinoThumbPainter.extension}');

  // Compose the sections.  Each section is its own widget builder.
  print('  building section 1 — anatomy diagram');
  final Widget section1 = _buildAnatomySection();
  print('  building section 2 — painter catalog');
  final Widget section2 = _buildPainterCatalogSection();
  print('  building section 3 — sizing reference card');
  final Widget section3 = _buildSizingReferenceSection();
  print('  building section 4 — slider state gallery');
  final Widget section4 = _buildSliderGallerySection();
  print('  building section 5 — switch state gallery');
  final Widget section5 = _buildSwitchGallerySection();
  print('  building section 6 — shadow ablation');
  final Widget section6 = _buildShadowAblationSection();
  print('  building section 7 — color theme matrix');
  final Widget section7 = _buildColorThemeMatrixSection();
  print('  building section 8 — family context');
  final Widget section8 = _buildFamilyContextSection();
  print('  building section 9 — mock settings screen');
  final Widget section9 = _buildMockSettingsSection();

  print('CupertinoThumbPainter deep demo: build() complete');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: _kPaperLight,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Thumb Painter Deep Demo'),
        backgroundColor: Color(0xF2FFFFFF),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(_kSectionPad),
          children: <Widget>[
            _buildIntroBanner(),
            const SizedBox(height: _kGapXl),
            section1,
            const SizedBox(height: _kGapXl),
            section2,
            const SizedBox(height: _kGapXl),
            section3,
            const SizedBox(height: _kGapXl),
            section4,
            const SizedBox(height: _kGapXl),
            section5,
            const SizedBox(height: _kGapXl),
            section6,
            const SizedBox(height: _kGapXl),
            section7,
            const SizedBox(height: _kGapXl),
            section8,
            const SizedBox(height: _kGapXl),
            section9,
            const SizedBox(height: _kGapXl),
            _buildOutroBanner(),
            const SizedBox(height: _kSectionPad),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// Intro and outro banners
// =====================================================================
//
// Headline cards used to bookend the demo.  The intro banner introduces
// the painter; the outro banner summarises everything the reader has
// just seen.
// =====================================================================

Widget _buildIntroBanner() {
  return Container(
    padding: const EdgeInsets.all(_kSectionPad),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFFEFF6FF),
          Color(0xFFFDF4FF),
        ],
      ),
      borderRadius: BorderRadius.circular(_kCardRadius + 4.0),
      border: Border.all(color: const Color(0xFFE0E7FF), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'CupertinoThumbPainter',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: _kGapXs),
        Text(
          'The iOS-style thumb primitive that powers CupertinoSlider and CupertinoSwitch.',
          style: TextStyle(
            fontSize: 14.0,
            color: _kInkSecondary,
            height: 1.4,
          ),
        ),
        SizedBox(height: _kGapMd),
        Text(
          'This walkthrough renders the painter directly via CustomPaint and through '
          'its host widgets, with annotated diagrams, color matrices, and shadow ablations.',
          style: TextStyle(
            fontSize: 13.0,
            color: _kInkTertiary,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOutroBanner() {
  return Container(
    padding: const EdgeInsets.all(_kSectionPad),
    decoration: BoxDecoration(
      color: _kPaperMid,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: _kPaperDeep, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
          ),
        ),
        SizedBox(height: _kGapSm),
        Text(
          'The thumb painter is a tiny but ubiquitous primitive — its 28 px circle '
          'shows up everywhere from accessibility sliders to system toggles. The '
          'class is `const`-friendly, ships with two factories, and has only two '
          'configurable parameters (color, shadows). Compose it inside CustomPaint '
          'when you want pixel-exact iOS thumbs in custom widgets.',
          style: TextStyle(
            fontSize: 13.0,
            color: _kInkSecondary,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 1 — Anatomy diagram
// =====================================================================
//
// A 280-px-tall CustomPaint that walks through the construction of a
// single thumb circle.  Two diagrams sit side-by-side: a "raw" diagram
// showing the geometric guide lines and a "live" diagram showing the
// actual CupertinoThumbPainter output for comparison.
// =====================================================================

Widget _buildAnatomySection() {
  return _buildSectionCard(
    title: '1. Anatomy of a thumb',
    description:
        'The thumb is a 28 px (2 × radius) circle drawn from three layers: shadows, '
        'a faint border (alpha 0x0A), then the fill. The anatomy painter below '
        'highlights each layer so the construction order is visible.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 240.0,
          decoration: BoxDecoration(
            color: _kPaperLight,
            borderRadius: BorderRadius.circular(_kCardRadius - 4.0),
            border: Border.all(color: _kStrokeLine, width: 1.0),
          ),
          child: CustomPaint(
            painter: _AnatomyPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: _kGapMd),
        _buildLegendRow('Shadows', 'List<BoxShadow> drawn below the thumb shape.'),
        _buildLegendRow('Border', 'Color(0x0A000000) — barely visible on white backgrounds.'),
        _buildLegendRow('Fill', 'The `color` parameter; default = CupertinoColors.white.'),
        _buildLegendRow('Radius', 'rect.shortestSide / 2 — always a true circle when rect is square.'),
      ],
    ),
  );
}

Widget _buildLegendRow(String name, String description) {
  return Padding(
    padding: const EdgeInsets.only(top: _kGapSm),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.only(top: 6.0, right: _kGapSm),
          decoration: const BoxDecoration(
            color: CupertinoColors.activeBlue,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: _kInkPrimary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 13.0,
              color: _kInkSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Centre the diagram horizontally.
    final double midY = size.height * 0.5;
    final double leftCx = size.width * 0.28;
    final double rightCx = size.width * 0.72;
    final double thumbRadius = CupertinoThumbPainter.radius;

    // -------------------------------------------------------------
    // Left half: deconstruction diagram with the three layers
    // separated horizontally.
    // -------------------------------------------------------------
    final List<Color> layerColors = <Color>[
      const Color(0xFFFFE5B4),
      const Color(0xFFE5E5E5),
      CupertinoColors.white,
    ];
    final List<String> layerLabels = <String>['shadows', 'border', 'fill'];
    for (int i = 0; i < 3; i++) {
      final double cx = leftCx - 36.0 + i * 36.0;
      final Rect layerRect = Rect.fromCircle(
        center: Offset(cx, midY),
        radius: thumbRadius,
      );
      final Paint p = Paint()..color = layerColors[i];
      canvas.drawCircle(Offset(cx, midY), thumbRadius, p);
      final Paint outline = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = const Color(0xFF6B7280);
      canvas.drawCircle(Offset(cx, midY), thumbRadius, outline);
      _drawDiagramText(
        canvas,
        layerLabels[i],
        Offset(layerRect.left, midY + thumbRadius + 6.0),
        const Color(0xFF374151),
        11.0,
      );
    }
    _drawDiagramText(
      canvas,
      'Deconstruction',
      Offset(leftCx - 50.0, midY - thumbRadius - 32.0),
      _kInkPrimary,
      13.0,
    );

    // Plus and equals arithmetic glyphs between the layers.
    _drawDiagramText(
      canvas,
      '+',
      Offset(leftCx - 22.0, midY - 8.0),
      const Color(0xFF6B7280),
      14.0,
    );
    _drawDiagramText(
      canvas,
      '+',
      Offset(leftCx + 14.0, midY - 8.0),
      const Color(0xFF6B7280),
      14.0,
    );

    // -------------------------------------------------------------
    // Right half: actual painter output rendered at native size.
    // -------------------------------------------------------------
    final CupertinoThumbPainter realPainter = const CupertinoThumbPainter();
    final Rect realRect = Rect.fromCircle(
      center: Offset(rightCx, midY),
      radius: thumbRadius,
    );
    realPainter.paint(canvas, realRect);

    _drawDiagramText(
      canvas,
      'Composite (live)',
      Offset(rightCx - 56.0, midY - thumbRadius - 32.0),
      _kInkPrimary,
      13.0,
    );

    // Radius callout.
    final Paint callout = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFFF9500);
    canvas.drawLine(
      Offset(rightCx, midY),
      Offset(rightCx + thumbRadius, midY),
      callout,
    );
    canvas.drawCircle(
      Offset(rightCx, midY),
      2.0,
      Paint()..color = const Color(0xFFFF9500),
    );
    _drawDiagramText(
      canvas,
      'radius = 14.0',
      Offset(rightCx + 2.0, midY + 6.0),
      const Color(0xFFB45309),
      11.0,
    );

    // Extension callout: stretch arrow.
    final Paint extPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF1D4ED8);
    final double extY = midY + thumbRadius + 22.0;
    canvas.drawLine(
      Offset(rightCx - thumbRadius, extY),
      Offset(rightCx + thumbRadius + CupertinoThumbPainter.extension, extY),
      extPaint,
    );
    canvas.drawLine(
      Offset(rightCx + thumbRadius, extY - 4.0),
      Offset(rightCx + thumbRadius, extY + 4.0),
      extPaint,
    );
    canvas.drawLine(
      Offset(
        rightCx + thumbRadius + CupertinoThumbPainter.extension,
        extY - 4.0,
      ),
      Offset(
        rightCx + thumbRadius + CupertinoThumbPainter.extension,
        extY + 4.0,
      ),
      extPaint,
    );
    _drawDiagramText(
      canvas,
      'extension = 7.0 (when pressed)',
      Offset(rightCx - 26.0, extY + 6.0),
      const Color(0xFF1D4ED8),
      11.0,
    );
  }

  void _drawDiagramText(
    Canvas canvas,
    String text,
    Offset at,
    Color color,
    double fontSize,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// Section 2 — Painter catalog
// =====================================================================
//
// Twelve labelled CustomPaint tiles, each rendering one configuration
// of CupertinoThumbPainter at native size + an enlarged 2× drawing
// next to it for inspection.  The catalog mixes default constructor,
// switchThumb factory, custom colors, and custom shadow stacks so the
// reader can see how each parameter changes the visual output.
// =====================================================================

Widget _buildPainterCatalogSection() {
  final List<_PainterSample> samples = <_PainterSample>[
    _PainterSample(
      label: 'Default slider thumb',
      caption: 'CupertinoThumbPainter()',
      painter: const CupertinoThumbPainter(),
    ),
    _PainterSample(
      label: 'Default switch thumb',
      caption: 'CupertinoThumbPainter.switchThumb()',
      painter: const CupertinoThumbPainter.switchThumb(),
    ),
    _PainterSample(
      label: 'activeBlue fill',
      caption: 'color: CupertinoColors.activeBlue',
      painter: const CupertinoThumbPainter(color: CupertinoColors.activeBlue),
    ),
    _PainterSample(
      label: 'systemIndigo fill',
      caption: 'color: CupertinoColors.systemIndigo',
      painter: const CupertinoThumbPainter(color: CupertinoColors.systemIndigo),
    ),
    _PainterSample(
      label: 'systemPink fill',
      caption: 'color: CupertinoColors.systemPink',
      painter: const CupertinoThumbPainter(color: CupertinoColors.systemPink),
    ),
    _PainterSample(
      label: 'systemGreen switch',
      caption: 'switchThumb(color: systemGreen)',
      painter: const CupertinoThumbPainter.switchThumb(
        color: CupertinoColors.systemGreen,
      ),
    ),
    _PainterSample(
      label: 'No shadows',
      caption: 'shadows: <BoxShadow>[]',
      painter: const CupertinoThumbPainter(shadows: <BoxShadow>[]),
    ),
    _PainterSample(
      label: 'Single soft shadow',
      caption: '1 BoxShadow, blur 5, dy 3',
      painter: const CupertinoThumbPainter(
        shadows: <BoxShadow>[
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
    ),
    _PainterSample(
      label: 'Two-shadow stack',
      caption: '2 BoxShadows, layered',
      painter: const CupertinoThumbPainter(
        shadows: <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 4),
            blurRadius: 6.0,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 2.0,
          ),
        ],
      ),
    ),
    _PainterSample(
      label: 'Heavy (dramatic) shadows',
      caption: '2 BoxShadows, blur 12 + 22',
      painter: const CupertinoThumbPainter(
        shadows: <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 6),
            blurRadius: 12.0,
          ),
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 12),
            blurRadius: 22.0,
          ),
        ],
      ),
    ),
    _PainterSample(
      label: 'Slider default shadows',
      caption: '3 BoxShadows — slider preset',
      painter: const CupertinoThumbPainter(
        shadows: _kReferenceSliderShadows,
      ),
    ),
    _PainterSample(
      label: 'Switch default shadows',
      caption: '2 BoxShadows — switch preset',
      painter: const CupertinoThumbPainter(
        shadows: _kReferenceSwitchShadows,
      ),
    ),
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    tiles.add(_buildCatalogTile(samples[i], i));
  }

  return _buildSectionCard(
    title: '2. Painter catalog',
    description:
        'Twelve distinct CupertinoThumbPainter configurations rendered via CustomPaint. '
        'Each tile shows the native 28 px thumb on the left and a 2× enlargement on '
        'the right so subtle shadow stacking differences are visible.',
    body: Column(
      children: tiles,
    ),
  );
}

class _PainterSample {
  const _PainterSample({
    required this.label,
    required this.caption,
    required this.painter,
  });
  final String label;
  final String caption;
  final CupertinoThumbPainter painter;
}

Widget _buildCatalogTile(_PainterSample sample, int index) {
  final Color stripe = _kAccentPalette[index % _kAccentPalette.length];
  return Container(
    margin: const EdgeInsets.only(top: _kGapSm),
    padding: const EdgeInsets.symmetric(horizontal: _kGapMd, vertical: _kGapMd),
    decoration: BoxDecoration(
      color: _kPaperLight,
      borderRadius: BorderRadius.circular(_kCardRadius - 4.0),
      border: Border.all(color: _kStrokeLine, width: 0.6),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 4.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: stripe,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: _kGapMd),
        SizedBox(
          width: 56.0,
          height: 56.0,
          child: CustomPaint(
            painter: _SinglePainterAdapter(sample.painter, 1.0),
          ),
        ),
        const SizedBox(width: _kGapSm),
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: CustomPaint(
            painter: _SinglePainterAdapter(sample.painter, 2.0),
          ),
        ),
        const SizedBox(width: _kGapMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sample.label,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
              const SizedBox(height: _kGapXs),
              Text(
                sample.caption,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: _kInkSecondary,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SinglePainterAdapter extends CustomPainter {
  const _SinglePainterAdapter(this.thumb, this.scale);
  final CupertinoThumbPainter thumb;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = CupertinoThumbPainter.radius * scale;
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    thumb.paint(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// Section 3 — Sizing reference card
// =====================================================================
//
// Three side-by-side diagrams: native size, with-extension (pressed),
// and a 4× zoom for inspection.  Each diagram is annotated with a
// pixel ruler so the reader can read off `radius` and `extension`.
// =====================================================================

Widget _buildSizingReferenceSection() {
  return _buildSectionCard(
    title: '3. Sizing reference',
    description:
        'CupertinoThumbPainter exposes two static constants: `radius` (14.0) and '
        '`extension` (7.0). Together they determine the thumb diameter (28 px) and '
        'how far the thumb stretches horizontally when the user presses it.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: _kPaperLight,
            borderRadius: BorderRadius.circular(_kCardRadius - 4.0),
            border: Border.all(color: _kStrokeLine, width: 1.0),
          ),
          child: CustomPaint(
            painter: _SizingReferencePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: _kGapMd),
        _buildKeyValueRow('radius', '14.0', '→ diameter 28.0'),
        _buildKeyValueRow('extension', '7.0', '→ pressed width 35.0'),
        _buildKeyValueRow('aspect (resting)', '1:1', '→ perfect circle'),
        _buildKeyValueRow('aspect (pressed)', '5:4', '→ rounded pill'),
        const SizedBox(height: _kGapSm),
        Container(
          padding: const EdgeInsets.all(_kGapSm),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6E5),
            borderRadius: BorderRadius.circular(_kGapSm),
            border: Border.all(color: const Color(0xFFFFE7BC)),
          ),
          child: const Text(
            'Both values are `static const` — they cannot be overridden per instance.'
            ' If you need a non-iOS-style size, you must implement your own painter.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF7A4A00),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyValueRow(String key, String value, String trailing) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: _kGapXs),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              color: _kInkPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            trailing,
            style: const TextStyle(
              fontSize: 13.0,
              color: _kInkSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SizingReferencePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height * 0.5;
    final CupertinoThumbPainter painter = const CupertinoThumbPainter();
    final double r = CupertinoThumbPainter.radius;
    final double ext = CupertinoThumbPainter.extension;

    final List<double> centers = <double>[
      size.width * 0.18,
      size.width * 0.48,
      size.width * 0.82,
    ];

    // 1× native circle
    {
      final Rect rect = Rect.fromCircle(center: Offset(centers[0], midY), radius: r);
      painter.paint(canvas, rect);
      _ruler(canvas, rect.left, rect.right, midY + r + 18.0, '28 px');
      _label(canvas, '1× resting', centers[0] - 28.0, midY - r - 26.0);
    }

    // 1× with extension (pressed) — wider pill
    {
      final Rect rect = Rect.fromLTRB(
        centers[1] - r,
        midY - r,
        centers[1] + r + ext,
        midY + r,
      );
      painter.paint(canvas, rect);
      _ruler(canvas, rect.left, rect.right, midY + r + 18.0, '35 px (pressed)');
      _label(canvas, '1× pressed', centers[1] - 30.0, midY - r - 26.0);
    }

    // 4× zoom
    {
      final double br = r * 2.2;
      final Rect rect = Rect.fromCircle(
        center: Offset(centers[2], midY),
        radius: br,
      );
      painter.paint(canvas, rect);
      _ruler(canvas, rect.left, rect.right, midY + br + 8.0, '~62 px zoom');
      _label(canvas, '2× zoom', centers[2] - 22.0, midY - br - 18.0);
    }
  }

  void _ruler(Canvas canvas, double left, double right, double y, String label) {
    final Paint p = Paint()
      ..color = const Color(0xFF6B7280)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(left, y), Offset(right, y), p);
    canvas.drawLine(Offset(left, y - 4.0), Offset(left, y + 4.0), p);
    canvas.drawLine(Offset(right, y - 4.0), Offset(right, y + 4.0), p);
    final double midX = (left + right) * 0.5;
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Color(0xFF374151),
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(midX - tp.width * 0.5, y + 4.0));
  }

  void _label(Canvas canvas, String text, double x, double y) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _kInkPrimary,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// Section 4 — Slider state gallery
// =====================================================================
//
// Eight CupertinoSlider snapshots in static configurations.  Sliders
// require an onChanged callback to remain enabled — we pass a no-op
// closure so the slider draws in its enabled (not disabled) state.
// We deliberately do NOT animate; each row shows a fixed value.
// =====================================================================

Widget _buildSliderGallerySection() {
  final List<_SliderSnapshot> snapshots = <_SliderSnapshot>[
    _SliderSnapshot(
      label: 'value = 0.0 (leftmost)',
      value: 0.0,
      activeColor: null,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'value = 0.25',
      value: 0.25,
      activeColor: null,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'value = 0.5 (centred)',
      value: 0.5,
      activeColor: null,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'value = 0.75',
      value: 0.75,
      activeColor: null,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'value = 1.0 (rightmost)',
      value: 1.0,
      activeColor: null,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'systemPink active track',
      value: 0.6,
      activeColor: CupertinoColors.systemPink,
      thumbColor: null,
    ),
    _SliderSnapshot(
      label: 'systemGreen active, systemGrey thumb',
      value: 0.4,
      activeColor: CupertinoColors.systemGreen,
      thumbColor: CupertinoColors.systemGrey,
    ),
    _SliderSnapshot(
      label: 'Disabled (onChanged null)',
      value: 0.5,
      activeColor: null,
      thumbColor: null,
      disabled: true,
    ),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < snapshots.length; i++) {
    rows.add(_buildSliderRow(snapshots[i]));
  }

  return _buildSectionCard(
    title: '4. CupertinoSlider gallery',
    description:
        'CupertinoSlider draws its thumb with CupertinoThumbPainter internally. '
        'Each snapshot below is a static value — there is no animation, only a '
        'no-op onChanged so the slider stays enabled. The last row shows the '
        'disabled state (onChanged == null).',
    body: Column(children: rows),
  );
}

class _SliderSnapshot {
  const _SliderSnapshot({
    required this.label,
    required this.value,
    required this.activeColor,
    required this.thumbColor,
    this.disabled = false,
  });
  final String label;
  final double value;
  final Color? activeColor;
  final Color? thumbColor;
  final bool disabled;
}

Widget _buildSliderRow(_SliderSnapshot s) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: _kGapSm),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _kPaperDeep, width: 0.5),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          s.label,
          style: const TextStyle(
            fontSize: 12.0,
            color: _kInkSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: _kGapXs),
        CupertinoSlider(
          value: s.value,
          activeColor: s.activeColor,
          thumbColor: s.thumbColor ?? CupertinoColors.white,
          onChanged: s.disabled ? null : (v) {},
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 5 — Switch state gallery
// =====================================================================
//
// Eight CupertinoSwitch snapshots in their various visual states.  Like
// the slider, switches need an onChanged callback to look enabled — we
// pass a no-op.  The switch can be coloured with activeColor (track
// when on), trackColor (track when off), and thumbColor.
// =====================================================================

Widget _buildSwitchGallerySection() {
  final List<_SwitchSnapshot> snapshots = <_SwitchSnapshot>[
    _SwitchSnapshot(label: 'OFF — default', value: false),
    _SwitchSnapshot(label: 'ON — default (green)', value: true),
    _SwitchSnapshot(
      label: 'ON — activeColor systemBlue',
      value: true,
      activeColor: CupertinoColors.activeBlue,
    ),
    _SwitchSnapshot(
      label: 'ON — activeColor systemPurple',
      value: true,
      activeColor: CupertinoColors.systemPurple,
    ),
    _SwitchSnapshot(
      label: 'ON — activeColor systemRed',
      value: true,
      activeColor: CupertinoColors.systemRed,
    ),
    _SwitchSnapshot(
      label: 'ON — thumbColor systemYellow',
      value: true,
      thumbColor: CupertinoColors.systemYellow,
    ),
    _SwitchSnapshot(
      label: 'OFF — trackColor systemGrey4',
      value: false,
      trackColor: CupertinoColors.systemGrey4,
    ),
    _SwitchSnapshot(label: 'OFF — disabled (onChanged null)', value: false, disabled: true),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < snapshots.length; i++) {
    rows.add(_buildSwitchRow(snapshots[i]));
  }

  return _buildSectionCard(
    title: '5. CupertinoSwitch gallery',
    description:
        'CupertinoSwitch also uses CupertinoThumbPainter (via the switchThumb '
        'factory). The thumb is the small white circle that slides between the '
        'two sides; the track is everything else. Each snapshot shows a different '
        'combination of value + customisation.',
    body: Column(children: rows),
  );
}

class _SwitchSnapshot {
  const _SwitchSnapshot({
    required this.label,
    required this.value,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
    this.disabled = false,
  });
  final String label;
  final bool value;
  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;
  final bool disabled;
}

Widget _buildSwitchRow(_SwitchSnapshot s) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: _kGapSm, horizontal: _kGapXs),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: _kPaperDeep, width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            s.label,
            style: const TextStyle(
              fontSize: 13.0,
              color: _kInkPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CupertinoSwitch(
          value: s.value,
          activeColor: s.activeColor,
          trackColor: s.trackColor,
          thumbColor: s.thumbColor,
          onChanged: s.disabled ? null : (_) {},
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 6 — Shadow ablation
// =====================================================================
//
// Four columns that compare 0, 1, 2, and 3 BoxShadow layers.  Each
// column has the painter drawn on three different backgrounds (white,
// light grey, dark grey) so the reader can see how each shadow stack
// "reads" against the surface beneath it.
// =====================================================================

Widget _buildShadowAblationSection() {
  final List<_AblationColumn> columns = <_AblationColumn>[
    const _AblationColumn(
      title: 'No shadow',
      shadows: <BoxShadow>[],
      summary: 'Stark, flat. Reads as a sticker on top of the surface.',
    ),
    _AblationColumn(
      title: '1 shadow',
      shadows: const <BoxShadow>[
        BoxShadow(
          color: Color(0x40000000),
          offset: Offset(0, 3),
          blurRadius: 5.0,
        ),
      ],
      summary: 'A single soft drop. Cheap and effective for hover/menu surfaces.',
    ),
    const _AblationColumn(
      title: '2 shadows (switch preset)',
      shadows: _kReferenceSwitchShadows,
      summary: 'The iOS switch preset — broad blur + crisp edge.',
    ),
    const _AblationColumn(
      title: '3 shadows (slider preset)',
      shadows: _kReferenceSliderShadows,
      summary: 'The iOS slider preset — broad + edge + tight band.',
    ),
  ];

  final List<Widget> columnWidgets = <Widget>[];
  for (int i = 0; i < columns.length; i++) {
    columnWidgets.add(_buildAblationColumn(columns[i]));
  }

  return _buildSectionCard(
    title: '6. Shadow ablation',
    description:
        'CupertinoSlider ships with a 3-shadow stack; CupertinoSwitch with a 2-shadow '
        'stack. The ablation below isolates each layer count on three backgrounds so '
        'you can see how the shadow choice affects readability on light vs dark '
        'surfaces.',
    body: Column(children: columnWidgets),
  );
}

class _AblationColumn {
  const _AblationColumn({
    required this.title,
    required this.shadows,
    required this.summary,
  });
  final String title;
  final List<BoxShadow> shadows;
  final String summary;
}

Widget _buildAblationColumn(_AblationColumn col) {
  final CupertinoThumbPainter painter = CupertinoThumbPainter(shadows: col.shadows);
  final List<Color> backgrounds = const <Color>[
    Color(0xFFFFFFFF),
    Color(0xFFEDEDF0),
    Color(0xFF2C2C2E),
  ];
  final List<String> bgLabels = const <String>['white', 'grey', 'dark'];

  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < backgrounds.length; i++) {
    swatches.add(
      Container(
        width: 60.0,
        height: 60.0,
        margin: const EdgeInsets.only(right: _kGapSm),
        decoration: BoxDecoration(
          color: backgrounds[i],
          borderRadius: BorderRadius.circular(_kGapSm),
          border: Border.all(color: _kStrokeLine, width: 0.5),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: _SinglePainterAdapter(painter, 1.0),
              ),
            ),
            Positioned(
              left: 4.0,
              bottom: 2.0,
              child: Text(
                bgLabels[i],
                style: TextStyle(
                  fontSize: 9.0,
                  color: i == 2
                      ? CupertinoColors.systemGrey3
                      : _kInkTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.only(top: _kGapMd),
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: _kPaperLight,
      borderRadius: BorderRadius.circular(_kCardRadius - 4.0),
      border: Border.all(color: _kStrokeLine, width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          col.title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          col.summary,
          style: const TextStyle(
            fontSize: 12.0,
            color: _kInkSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Row(children: swatches),
      ],
    ),
  );
}

// =====================================================================
// Section 7 — Color theme matrix
// =====================================================================
//
// A 2D matrix: rows = painter kind (default vs switchThumb), columns =
// nine Cupertino accent colours.  Each cell renders a 1× thumb and a
// label, surrounded by a tinted card whose background matches the
// accent at 12 % opacity.  This is the most "showcase-y" section.
// =====================================================================

Widget _buildColorThemeMatrixSection() {
  final List<Widget> defaultRow = <Widget>[];
  final List<Widget> switchRow = <Widget>[];
  for (int i = 0; i < _kAccentPalette.length; i++) {
    final Color accent = _kAccentPalette[i];
    final String name = _kAccentNames[i];
    final CupertinoThumbPainter defaultP = CupertinoThumbPainter(color: accent);
    final CupertinoThumbPainter switchP = CupertinoThumbPainter.switchThumb(color: accent);
    defaultRow.add(_buildMatrixCell(defaultP, accent, 'CupertinoThumbPainter', name));
    switchRow.add(_buildMatrixCell(switchP, accent, 'switchThumb', name));
  }

  return _buildSectionCard(
    title: '7. Color theme matrix',
    description:
        'Nine accent colours × two painter kinds = eighteen tinted thumb cells. '
        'Useful for comparing how each accent reads at the small 28 px native '
        'size — some colours (yellow, teal) lose contrast quickly against white.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoThumbPainter() — slider thumb',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
          ),
        ),
        const SizedBox(height: _kGapSm),
        SizedBox(
          height: 110.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: defaultRow,
          ),
        ),
        const SizedBox(height: _kGapMd),
        const Text(
          'CupertinoThumbPainter.switchThumb() — switch thumb',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
          ),
        ),
        const SizedBox(height: _kGapSm),
        SizedBox(
          height: 110.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: switchRow,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatrixCell(
  CupertinoThumbPainter painter,
  Color accent,
  String kind,
  String name,
) {
  return Container(
    width: 96.0,
    margin: const EdgeInsets.only(right: _kGapSm),
    padding: const EdgeInsets.all(_kGapSm),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.12),
      borderRadius: BorderRadius.circular(_kCardRadius - 4.0),
      border: Border.all(color: accent.withOpacity(0.25), width: 0.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 56.0,
          height: 56.0,
          child: CustomPaint(
            painter: _SinglePainterAdapter(painter, 1.0),
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          name,
          style: const TextStyle(
            fontSize: 10.0,
            color: _kInkPrimary,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          kind,
          style: const TextStyle(
            fontSize: 9.0,
            color: _kInkSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 8 — Family context
// =====================================================================
//
// CupertinoThumbPainter is part of a family of small Cupertino
// primitives.  This section puts it next to other family members
// (CupertinoButton.filled, CupertinoActivityIndicator) on a single
// shared card so the reader gets a feel for how the family hangs
// together.  Each member gets a caption explaining how it relates.
// =====================================================================

Widget _buildFamilyContextSection() {
  return _buildSectionCard(
    title: '8. Family context',
    description:
        'CupertinoThumbPainter does not stand alone — it shares a design language '
        'with the rest of the Cupertino primitives. The card below places a slider, '
        'a switch, a filled button, and an activity indicator next to each other so '
        'you can confirm the visual family resemblance.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFamilyRow(
          name: 'CupertinoSlider',
          caption: 'Track + thumb. Thumb uses CupertinoThumbPainter (slider preset).',
          child: CupertinoSlider(
            value: 0.42,
            onChanged: (v) {},
          ),
        ),
        _buildFamilyRow(
          name: 'CupertinoSwitch',
          caption: 'Track + thumb. Thumb uses CupertinoThumbPainter.switchThumb().',
          child: CupertinoSwitch(value: true, onChanged: (_) {}),
        ),
        _buildFamilyRow(
          name: 'CupertinoButton.filled',
          caption: 'Solid pill button. No thumb, but shares the same border-radius family.',
          child: CupertinoButton.filled(
            onPressed: () {},
            child: const Text('Confirm'),
          ),
        ),
        _buildFamilyRow(
          name: 'CupertinoActivityIndicator',
          caption: 'Spinning iOS-style activity ring. Tiny but iconic.',
          child: const CupertinoActivityIndicator(radius: 12.0),
        ),
        _buildFamilyRow(
          name: 'CupertinoActivityIndicator (large)',
          caption: 'Same widget at a larger radius, for hero loading screens.',
          child: const CupertinoActivityIndicator(radius: 20.0),
        ),
        _buildFamilyRow(
          name: 'CupertinoButton (plain)',
          caption: 'Text-only Cupertino button. Often paired with a switch row.',
          child: CupertinoButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFamilyRow({
  required String name,
  required String caption,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: _kGapSm),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                caption,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: _kInkSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: _kGapMd),
        Expanded(child: Align(alignment: Alignment.centerLeft, child: child)),
      ],
    ),
  );
}

// =====================================================================
// Section 9 — Mock Cupertino settings screen
// =====================================================================
//
// The full-pull-it-together section.  A pretend "Sound & Haptics"
// settings screen with grouped sections that mix sliders, switches,
// buttons, and an activity indicator at the bottom for a "syncing…"
// affordance.  The screen uses CupertinoListSection / CupertinoListTile
// where possible so that the result feels native.
// =====================================================================

Widget _buildMockSettingsSection() {
  return _buildSectionCard(
    title: '9. Mock settings screen',
    description:
        'A pretend "Sound & Haptics" panel — sliders for volume, switches for '
        'haptics toggles, a filled "Apply" button, and a small activity indicator '
        'for the syncing state. This is where CupertinoThumbPainter shows up in '
        'real product UIs.',
    body: Column(
      children: <Widget>[
        _buildSettingsGroup(
          header: 'RINGER AND ALERTS',
          children: <Widget>[
            _buildSettingsSliderRow(
              label: 'Ringer volume',
              value: 0.6,
              activeColor: CupertinoColors.activeBlue,
            ),
            _buildSettingsDivider(),
            _buildSettingsSliderRow(
              label: 'Alert volume',
              value: 0.35,
              activeColor: CupertinoColors.activeBlue,
            ),
            _buildSettingsDivider(),
            _buildSettingsSwitchRow(
              label: 'Change with buttons',
              value: true,
            ),
          ],
        ),
        const SizedBox(height: _kGapMd),
        _buildSettingsGroup(
          header: 'HAPTICS',
          children: <Widget>[
            _buildSettingsSwitchRow(label: 'System haptics', value: true),
            _buildSettingsDivider(),
            _buildSettingsSwitchRow(label: 'Play haptics in ring mode', value: true),
            _buildSettingsDivider(),
            _buildSettingsSwitchRow(label: 'Play haptics in silent mode', value: false),
          ],
        ),
        const SizedBox(height: _kGapMd),
        _buildSettingsGroup(
          header: 'KEYBOARD FEEDBACK',
          children: <Widget>[
            _buildSettingsSwitchRow(label: 'Sound', value: false),
            _buildSettingsDivider(),
            _buildSettingsSwitchRow(label: 'Haptic', value: true),
            _buildSettingsDivider(),
            _buildSettingsSliderRow(
              label: 'Click strength',
              value: 0.75,
              activeColor: CupertinoColors.systemGreen,
            ),
          ],
        ),
        const SizedBox(height: _kGapLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Row(
              children: <Widget>[
                CupertinoActivityIndicator(radius: 8.0),
                SizedBox(width: _kGapSm),
                Text(
                  'Syncing preferences…',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkSecondary,
                  ),
                ),
              ],
            ),
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              onPressed: () {},
              child: const Text('Apply'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSettingsGroup({
  required String header,
  required List<Widget> children,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: _kGapXs, bottom: _kGapXs),
        child: Text(
          header,
          style: const TextStyle(
            fontSize: 11.0,
            color: _kInkTertiary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(_kCardRadius - 6.0),
          border: Border.all(color: _kStrokeLine, width: 0.5),
        ),
        child: Column(children: children),
      ),
    ],
  );
}

Widget _buildSettingsDivider() {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Container(
      height: 0.5,
      color: _kPaperDeep,
    ),
  );
}

Widget _buildSettingsSliderRow({
  required String label,
  required double value,
  Color? activeColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.0,
            color: _kInkPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: _kGapXs),
        CupertinoSlider(
          value: value,
          activeColor: activeColor,
          onChanged: (v) {},
        ),
      ],
    ),
  );
}

Widget _buildSettingsSwitchRow({
  required String label,
  required bool value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
              color: _kInkPrimary,
            ),
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: (_) {},
        ),
      ],
    ),
  );
}

// =====================================================================
// Reusable section card
// =====================================================================
//
// All numbered sections share a card chrome: title, supporting prose,
// and a body slot. This helper keeps each section visually consistent
// while letting the body be anything.
// =====================================================================

Widget _buildSectionCard({
  required String title,
  required String description,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(_kSectionPad),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: _kPaperDeep, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          offset: Offset(0, 1),
          blurRadius: 2.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: _kInkPrimary,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Text(
          description,
          style: const TextStyle(
            fontSize: 13.0,
            color: _kInkSecondary,
            height: 1.45,
          ),
        ),
        const SizedBox(height: _kGapLg),
        body,
      ],
    ),
  );
}
