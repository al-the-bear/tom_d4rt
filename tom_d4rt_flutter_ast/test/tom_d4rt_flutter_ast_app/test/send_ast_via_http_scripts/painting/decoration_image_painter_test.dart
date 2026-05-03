// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element
//
// Deep demo: package:flutter/painting — DecorationImage & DecorationImagePainter
// =============================================================================
// This script teaches how a BoxDecoration paints a bitmap. The configuration
// object is `DecorationImage`; the painter created on demand by
// `DecorationImage.createPainter(VoidCallback onChanged)` is a
// `DecorationImagePainter`. The painter resolves the ImageProvider, listens
// for the decoded ImageInfo, calls `onChanged` when the bitmap arrives, and
// then implements `paint(canvas, rect, textDirection, configuration)` to
// project the bitmap into a target rect using fit/alignment/repeat/scale.
//
// Because real ImageProvider decoding is unsafe inside an interpreted test
// harness, we DEPICT bitmaps using gradient stand-ins. Where DecorationImage
// instances are constructed for showcase, we wrap creation in try/catch so
// that headless environments without an asset bundle still render the
// labelled card. Each section is hand-authored — the prose teaches what the
// painter does, what knob you turn on the configuration, and how the field
// surfaces visually on screen.

import 'dart:typed_data';

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Palette and small helpers shared across sections.
// ─────────────────────────────────────────────────────────────────────────────

const Color _kBg = Color(0xFF0E1A2C);
const Color _kCard = Color(0xFF13243C);
const Color _kCardAlt = Color(0xFF18304F);
const Color _kInk = Color(0xFFE6F1FF);
const Color _kInkSoft = Color(0xFFB7C8DD);
const Color _kAccent = Color(0xFF59C2FF);
const Color _kAccent2 = Color(0xFF7CFFC4);
const Color _kAccent3 = Color(0xFFFFC857);
const Color _kAccent4 = Color(0xFFFF6B9A);
const Color _kAccent5 = Color(0xFFB388FF);
const Color _kDanger = Color(0xFFFF5C75);

// Six gradient builders used as bitmap stand-ins. Each one acts as the
// "decoded ImageInfo" that DecorationImagePainter would otherwise paint.

LinearGradient _gradMeadow() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF6BCB77),
      Color(0xFF1B998B),
      Color(0xFF0F5132),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _gradSunset() {
  return LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      Color(0xFFFFB199),
      Color(0xFFFF6B9A),
      Color(0xFFB388FF),
    ],
    stops: <double>[0.0, 0.5, 1.0],
  );
}

LinearGradient _gradOcean() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF59C2FF),
      Color(0xFF1F6FEB),
      Color(0xFF0B2B6B),
    ],
    stops: <double>[0.0, 0.45, 1.0],
  );
}

LinearGradient _gradEmber() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFD166),
      Color(0xFFEF476F),
      Color(0xFF8E1F4B),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _gradStorm() {
  return LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[
      Color(0xFF607D8B),
      Color(0xFF37474F),
      Color(0xFF102027),
    ],
    stops: <double>[0.0, 0.5, 1.0],
  );
}

LinearGradient _gradSpring() {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFF7CFFC4),
      Color(0xFF59C2FF),
      Color(0xFFB388FF),
    ],
    stops: <double>[0.0, 0.5, 1.0],
  );
}

LinearGradient _gradHeader() {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFF1F6FEB),
      Color(0xFF59C2FF),
      Color(0xFF7CFFC4),
    ],
  );
}

LinearGradient _gradHeader2() {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFFB388FF),
      Color(0xFFFF6B9A),
      Color(0xFFFFC857),
    ],
  );
}

// Six BoxShadow definitions used to lift cards above the dark background.

List<BoxShadow> _shadowSoft() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x55000000),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color(0x22000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
}

List<BoxShadow> _shadowGlow(Color c) {
  return <BoxShadow>[
    BoxShadow(
      color: c.withValues(alpha: 0.45),
      blurRadius: 18,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
  ];
}

List<BoxShadow> _shadowDeep() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x88000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];
}

List<BoxShadow> _shadowInner() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x33FFFFFF),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}

List<BoxShadow> _shadowCrisp(Color c) {
  return <BoxShadow>[
    BoxShadow(
      color: c.withValues(alpha: 0.30),
      blurRadius: 8,
      offset: Offset(0, 3),
    ),
  ];
}

List<BoxShadow> _shadowFlat() {
  return <BoxShadow>[
    BoxShadow(
      color: Color(0x22000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}

// A small chip used inside cards.
Widget _chip(String label, Color c) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: c.withValues(alpha: 0.55)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: c,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _badge(String label, Color c) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _kbd(String key) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    margin: EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: Color(0xFF0A1626),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _kAccent.withValues(alpha: 0.4)),
    ),
    child: Text(
      key,
      style: TextStyle(
        color: _kAccent,
        fontFamily: 'monospace',
        fontSize: 11,
      ),
    ),
  );
}

Widget _para(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: TextStyle(
        color: _kInkSoft,
        fontSize: 13,
        height: 1.45,
      ),
    ),
  );
}

Widget _h2(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 4, bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        color: _kInk,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _hr() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          Color(0x00FFFFFF),
          Color(0x33FFFFFF),
          Color(0x00FFFFFF),
        ],
      ),
    ),
  );
}

Widget _sectionHeader(String title, String subtitle, LinearGradient grad,
    IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: grad,
      borderRadius: BorderRadius.circular(14),
      boxShadow: _shadowDeep(),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Color(0x33000000),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0x55FFFFFF)),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontSize: 12,
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

Widget _card({required Widget child, EdgeInsets? padding, Color? color}) {
  return Container(
    width: double.infinity,
    padding: padding ?? EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color ?? _kCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kAccent.withValues(alpha: 0.18)),
      boxShadow: _shadowSoft(),
    ),
    child: child,
  );
}

Widget _section({required Widget header, required List<Widget> body}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[header, ...body],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Bitmap stand-in.
//
// A real DecorationImagePainter would, on `paint`, take the decoded
// `ui.Image` from the resolved ImageProvider and project it into the rect
// using the configured fit/alignment/repeat/scale. Rather than decode a real
// image, we render a Container whose gradient + decorative widgets simulate
// the bitmap. The intrinsic "image size" is exposed via [imgWidth]/[imgHeight]
// so that callers can illustrate intrinsic-vs-target rect mathematics.
// ─────────────────────────────────────────────────────────────────────────────

Widget _bitmap({
  required double imgWidth,
  required double imgHeight,
  LinearGradient? gradient,
  String label = 'IMG',
  Color labelColor = Colors.white,
  bool showSun = true,
  bool showMountains = true,
  double cornerRadius = 6,
}) {
  return Container(
    width: imgWidth,
    height: imgHeight,
    decoration: BoxDecoration(
      gradient: gradient ?? _gradOcean(),
      borderRadius: BorderRadius.circular(cornerRadius),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        if (showMountains)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: imgHeight * 0.42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0x66102027),
                    Color(0xCC102027),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(cornerRadius),
                  bottomRight: Radius.circular(cornerRadius),
                ),
              ),
            ),
          ),
        if (showSun)
          Positioned(
            top: imgHeight * 0.12,
            right: imgWidth * 0.10,
            child: Container(
              width: imgWidth * 0.18 < 8 ? 8 : imgWidth * 0.18,
              height: imgWidth * 0.18 < 8 ? 8 : imgWidth * 0.18,
              decoration: BoxDecoration(
                color: Color(0xFFFFE082),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x88FFE082),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        Center(
          child: Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: imgWidth < 60 ? 9 : (imgWidth < 120 ? 11 : 13),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              shadows: <Shadow>[
                Shadow(color: Color(0x99000000), blurRadius: 4),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Tile pattern stand-in for repeating textures.
Widget _patternTile(double size, Color a, Color b) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[a, b],
      ),
      border: Border.all(color: Color(0x33FFFFFF), width: 0.5),
    ),
    child: Center(
      child: Container(
        width: size * 0.4,
        height: size * 0.4,
        decoration: BoxDecoration(
          color: Color(0x55FFFFFF),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// DecorationImage construction.
//
// The bridge accepts a real `MemoryImage` instance backed by the smallest
// possible byte list. The list of constructed configurations is exposed for
// the API summary section. Each construction is wrapped in try/catch so that
// a constrained interpreter still renders the labelled card explaining the
// configuration; in that fallback path we record the configuration as a
// description rather than as a constructed instance.
// ─────────────────────────────────────────────────────────────────────────────

class _DimSpec {
  final String name;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final double scale;
  final double opacity;
  final bool invertColors;
  final bool isAntiAlias;
  final bool matchTextDirection;
  final FilterQuality filterQuality;
  final ColorFilter? colorFilter;
  final String narrative;
  final bool constructed;

  const _DimSpec({
    required this.name,
    required this.fit,
    required this.alignment,
    required this.repeat,
    required this.scale,
    required this.opacity,
    required this.invertColors,
    required this.isAntiAlias,
    required this.matchTextDirection,
    required this.filterQuality,
    required this.colorFilter,
    required this.narrative,
    required this.constructed,
  });
}

_DimSpec _attemptBuildDim({
  required String name,
  BoxFit fit = BoxFit.cover,
  AlignmentGeometry alignment = Alignment.center,
  ImageRepeat repeat = ImageRepeat.noRepeat,
  double scale = 1.0,
  double opacity = 1.0,
  bool invertColors = false,
  bool isAntiAlias = false,
  bool matchTextDirection = false,
  FilterQuality filterQuality = FilterQuality.low,
  ColorFilter? colorFilter,
  required String narrative,
}) {
  bool ok = false;
  try {
    // Construct the configuration object. The image provider is a
    // MemoryImage with a single byte — it will fail to decode but the
    // configuration object itself is well-formed.
    final DecorationImage di = DecorationImage(
      image: MemoryImage(_oneBytePng()),
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      scale: scale,
      opacity: opacity,
      invertColors: invertColors,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      filterQuality: filterQuality,
      colorFilter: colorFilter,
    );
    ok = true;
  } catch (_) {
    ok = false;
  }
  return _DimSpec(
    name: name,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
    scale: scale,
    opacity: opacity,
    invertColors: invertColors,
    isAntiAlias: isAntiAlias,
    matchTextDirection: matchTextDirection,
    filterQuality: filterQuality,
    colorFilter: colorFilter,
    narrative: narrative,
    constructed: ok,
  );
}

// Smallest byte payload usable for MemoryImage construction. Decoding will
// fail (which is fine — we never actually paint the image), but the
// constructor accepts it.
Uint8List _oneBytePng() {
  // 1×1 transparent PNG header bytes. We do not require a valid image since
  // construction does not decode; if construction throws we fall back.
  return Uint8List.fromList(<int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  ]);
}


// ─────────────────────────────────────────────────────────────────────────────
// SECTION 1 — Anatomy diagram
//
// BoxDecoration.image: DecorationImage      (configuration object — immutable)
//        │
//        ▼
// DecorationImage.createPainter(onChanged)  (called by the box painter when
//        │                                  the BoxDecoration is rendered)
//        ▼
// DecorationImagePainter.paint(canvas,      (resolves provider, listens for
//   rect, textDirection, configuration)     ImageInfo, blits with fit etc.)
// ─────────────────────────────────────────────────────────────────────────────

Widget _arrow(Color c) {
  return Container(
    width: 36,
    height: 28,
    margin: EdgeInsets.symmetric(horizontal: 4),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 22,
            height: 2,
            color: c,
          ),
          Container(
            width: 0,
            height: 0,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.transparent, width: 6),
                bottom: BorderSide(color: Colors.transparent, width: 6),
                left: BorderSide(color: c, width: 8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _anatomyNode({
  required String title,
  required String role,
  required IconData icon,
  required Color tone,
  required List<String> bullets,
}) {
  return Container(
    width: 200,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone.withValues(alpha: 0.55)),
      boxShadow: _shadowCrisp(tone),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: tone, size: 18),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          role,
          style: TextStyle(
            color: tone,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(bullets.length, (int i) {
            return Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 4,
                    height: 4,
                    margin: EdgeInsets.only(top: 6, right: 6),
                    decoration: BoxDecoration(
                      color: tone,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullets[i],
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _section1Anatomy() {
  return _section(
    header: _sectionHeader(
      '1 · Anatomy of a DecorationImage',
      'Configuration object → painter factory → paint pipeline.',
      _gradHeader(),
      Icons.architecture,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _h2('What does the painter actually do?'),
            _para(
              'A `BoxDecoration` exposes an `image` field of type '
              '`DecorationImage`. The decoration itself is immutable and '
              'cheap — it is only a description of *how* a bitmap should be '
              'projected into a target rect. The actual work of resolving '
              'the `ImageProvider`, listening to the `ImageStream`, and '
              'pushing pixels through `paintImage(...)` happens inside a '
              '`DecorationImagePainter` returned by '
              '`DecorationImage.createPainter(VoidCallback onChanged)`.',
            ),
            _para(
              'The `onChanged` callback exists because image decoding is '
              'asynchronous: the painter is asked to paint immediately, but '
              'the bitmap may arrive several frames later. When the '
              'underlying `ImageStream` resolves, the painter invokes '
              '`onChanged`, and the owning `RenderBox` schedules a repaint '
              'so the now-decoded image can be blitted into the previously '
              'reserved rect.',
            ),
            _para(
              'When the BoxDecoration is no longer used — for example when '
              'the widget rebuilds with a different image, or unmounts — '
              'the painter must be `dispose()`d. Forgetting to dispose '
              'leaks a listener on the ImageStream, which prevents the '
              'cached `ui.Image` from being released; this is one of the '
              'classic Flutter memory regressions in image-heavy lists.',
            ),
            _hr(),
            _h2('Diagram'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _anatomyNode(
                    title: 'BoxDecoration',
                    role: 'OWNER',
                    icon: Icons.crop_square,
                    tone: _kAccent,
                    bullets: <String>[
                      'Holds an .image: DecorationImage?',
                      'Created on every build()',
                      'Drives the BoxPainter when painted',
                    ],
                  ),
                  _arrow(_kAccent),
                  _anatomyNode(
                    title: 'DecorationImage',
                    role: 'CONFIG',
                    icon: Icons.tune,
                    tone: _kAccent2,
                    bullets: <String>[
                      'Immutable, value-equal',
                      'Has image, fit, alignment, repeat…',
                      'createPainter(onChanged) is the factory',
                    ],
                  ),
                  _arrow(_kAccent2),
                  _anatomyNode(
                    title: 'DecorationImagePainter',
                    role: 'PAINTER',
                    icon: Icons.brush,
                    tone: _kAccent3,
                    bullets: <String>[
                      'Subscribes to the ImageStream',
                      'Calls onChanged when ready',
                      'paint(canvas, rect, td, cfg)',
                    ],
                  ),
                  _arrow(_kAccent3),
                  _anatomyNode(
                    title: 'paintImage()',
                    role: 'BLIT',
                    icon: Icons.collections,
                    tone: _kAccent4,
                    bullets: <String>[
                      'Honours fit/alignment/repeat',
                      'Applies colorFilter & opacity',
                      'Final canvas.drawImageRect',
                    ],
                  ),
                ],
              ),
            ),
            _hr(),
            _h2('Reading the diagram'),
            _para(
              'Each node owns the next: the BoxDecoration owns the '
              'DecorationImage, the DecorationImage owns the painter '
              'lifecycle, the painter owns the listener on the resolved '
              '`ImageStream`. The split is deliberate — the configuration '
              'is hashable and const-friendly, while the painter holds '
              'mutable subscription state that must not creep into the '
              'widget tree.',
            ),
            Row(
              children: <Widget>[
                _badge('CONFIG', _kAccent2),
                SizedBox(width: 8),
                _badge('PAINTER', _kAccent3),
                SizedBox(width: 8),
                _badge('BLIT', _kAccent4),
                SizedBox(width: 8),
                _chip('createPainter()', _kAccent),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 2 — BoxFit grid
//
// `BoxFit` is consumed by `paintImage` (called inside the painter) to decide
// how the intrinsic image rectangle is mapped into the destination rectangle
// supplied to `DecorationImagePainter.paint`. We render eight cards: each
// card has a fixed parent rectangle and a stand-in "image" rectangle scaled
// and clipped to mimic the chosen BoxFit.
// ─────────────────────────────────────────────────────────────────────────────

class _FitSample {
  final BoxFit fit;
  final String name;
  final String summary;
  // Logical content size representing the bitmap intrinsic size.
  final double imgW;
  final double imgH;
  // Target rect size shown in the card.
  final double dstW;
  final double dstH;
  // How the painter would project: drawWFraction/drawHFraction relative to
  // the destination rect; clip true if the result is clipped to dst.
  final double drawWFraction;
  final double drawHFraction;
  final bool clip;
  final LinearGradient gradient;

  const _FitSample({
    required this.fit,
    required this.name,
    required this.summary,
    required this.imgW,
    required this.imgH,
    required this.dstW,
    required this.dstH,
    required this.drawWFraction,
    required this.drawHFraction,
    required this.clip,
    required this.gradient,
  });
}

Widget _fitCard(_FitSample s) {
  final double drawW = s.dstW * s.drawWFraction;
  final double drawH = s.dstH * s.drawHFraction;
  return Container(
    width: 220,
    margin: EdgeInsets.only(right: 12, bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccent.withValues(alpha: 0.25)),
      boxShadow: _shadowFlat(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _badge(s.name, _kAccent),
            SizedBox(width: 6),
            if (s.clip) _chip('CLIPPED', _kAccent4),
          ],
        ),
        SizedBox(height: 8),
        // The destination rect.
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: s.dstW,
            height: s.dstH,
            decoration: BoxDecoration(
              color: Color(0xFF0A1626),
              border: Border.all(color: _kInk.withValues(alpha: 0.20)),
            ),
            child: Center(
              child: SizedBox(
                width: drawW,
                height: drawH,
                child: _bitmap(
                  imgWidth: drawW,
                  imgHeight: drawH,
                  gradient: s.gradient,
                  label: s.name.toUpperCase(),
                  cornerRadius: 0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          s.summary,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _section2BoxFit() {
  final List<_FitSample> samples = <_FitSample>[
    _FitSample(
      fit: BoxFit.fill,
      name: 'fill',
      summary:
          'Stretch the bitmap on both axes to fill the destination rect — '
          'aspect ratio is destroyed.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 1.0, drawHFraction: 1.0,
      clip: false,
      gradient: _gradOcean(),
    ),
    _FitSample(
      fit: BoxFit.contain,
      name: 'contain',
      summary:
          'Scale uniformly until the larger axis fits; leaves letterboxing on '
          'the other axis.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 1.0, drawHFraction: 0.61,
      clip: false,
      gradient: _gradMeadow(),
    ),
    _FitSample(
      fit: BoxFit.cover,
      name: 'cover',
      summary:
          'Scale uniformly until the smaller axis fills; the longer axis is '
          'cropped — most common for hero banners.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 1.55, drawHFraction: 1.0,
      clip: true,
      gradient: _gradSunset(),
    ),
    _FitSample(
      fit: BoxFit.fitWidth,
      name: 'fitWidth',
      summary:
          'Match the destination width exactly; height is whatever the '
          'aspect ratio implies, possibly overflowing or leaving gaps.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 1.0, drawHFraction: 0.61,
      clip: false,
      gradient: _gradEmber(),
    ),
    _FitSample(
      fit: BoxFit.fitHeight,
      name: 'fitHeight',
      summary:
          'Match the destination height exactly; width follows the aspect '
          'ratio. Useful for portrait imagery in landscape rails.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 1.95, drawHFraction: 1.0,
      clip: true,
      gradient: _gradStorm(),
    ),
    _FitSample(
      fit: BoxFit.none,
      name: 'none',
      summary:
          'Do not scale at all. The intrinsic size is used; alignment then '
          'positions the bitmap inside the destination rect.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 0.66, drawHFraction: 0.55,
      clip: false,
      gradient: _gradSpring(),
    ),
    _FitSample(
      fit: BoxFit.scaleDown,
      name: 'scaleDown',
      summary:
          'Behaves like contain *only when the source is larger* than the '
          'destination; otherwise behaves like none. Great for icons.',
      imgW: 160, imgH: 90,
      dstW: 180, dstH: 110,
      drawWFraction: 0.50, drawHFraction: 0.42,
      clip: false,
      gradient: _gradOcean(),
    ),
    _FitSample(
      fit: BoxFit.fitWidth,
      name: 'fitWidth (portrait)',
      summary:
          'Same fit but with a tall source — the aspect ratio drives the '
          'height much taller than the destination, so vertical clipping is '
          'inevitable.',
      imgW: 60, imgH: 200,
      dstW: 180, dstH: 110,
      drawWFraction: 1.0, drawHFraction: 1.6,
      clip: true,
      gradient: _gradEmber(),
    ),
  ];

  return _section(
    header: _sectionHeader(
      '2 · BoxFit — projecting source into destination',
      'How `paintImage` maps the intrinsic image rect into the target rect.',
      _gradHeader2(),
      Icons.aspect_ratio,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              'Every `BoxFit` value answers a single question: given a source '
              'rectangle of size *Si × Hi* and a destination rectangle of '
              'size *Sd × Hd*, how should the painter pick a draw rect '
              'inside the destination? `fill` stretches, `contain` letters, '
              '`cover` crops, the directional fits lock one axis, and '
              '`scaleDown` falls back to `none` when the source is already '
              'small enough.',
            ),
            _para(
              '`DecorationImagePainter` does not implement these rules '
              'itself; it delegates to the top-level `paintImage` helper in '
              '`package:flutter/painting`. That helper computes the source '
              'and destination rects from `BoxFit` plus `Alignment`, then '
              'invokes `canvas.drawImageRect` once (or in a tile loop when '
              '`repeat` is non-noRepeat).',
            ),
            _para(
              'When you cannot decide between `cover` and `contain`, ask '
              'whether the rectangle is *meaningful* (a card, an avatar) or '
              '*decorative* (a hero, a backdrop). Decorative rects almost '
              'always want `cover`; meaningful rects almost always want '
              '`contain` so that the user sees the entire bitmap.',
            ),
            _hr(),
            _h2('Eight side-by-side samples'),
            Wrap(
              children:
                  List<Widget>.generate(samples.length, (int i) => _fitCard(samples[i])),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 3 — Alignment grid
// ─────────────────────────────────────────────────────────────────────────────

class _AlignSample {
  final String name;
  final AlignmentGeometry alignment;
  // x/y in [-1,1] for placing the stand-in inside the parent rect.
  final double x;
  final double y;
  const _AlignSample(this.name, this.alignment, this.x, this.y);
}

Widget _alignCard(_AlignSample s) {
  return Container(
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAccent.withValues(alpha: 0.20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: 110,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF0A1626),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _kInk.withValues(alpha: 0.18)),
              ),
            ),
            Positioned(
              left: ((s.x + 1) / 2) * (110 - 36),
              top: ((s.y + 1) / 2) * (80 - 24),
              child: _bitmap(
                imgWidth: 36,
                imgHeight: 24,
                gradient: _gradSunset(),
                label: '·',
                cornerRadius: 4,
                showSun: false,
                showMountains: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          s.name,
          style: TextStyle(
            color: _kInk,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _section3Alignment() {
  final List<List<_AlignSample>> rows = <List<_AlignSample>>[
    <_AlignSample>[
      _AlignSample('topLeft', Alignment.topLeft, -1, -1),
      _AlignSample('topCenter', Alignment.topCenter, 0, -1),
      _AlignSample('topRight', Alignment.topRight, 1, -1),
    ],
    <_AlignSample>[
      _AlignSample('centerLeft', Alignment.centerLeft, -1, 0),
      _AlignSample('center', Alignment.center, 0, 0),
      _AlignSample('centerRight', Alignment.centerRight, 1, 0),
    ],
    <_AlignSample>[
      _AlignSample('bottomLeft', Alignment.bottomLeft, -1, 1),
      _AlignSample('bottomCenter', Alignment.bottomCenter, 0, 1),
      _AlignSample('bottomRight', Alignment.bottomRight, 1, 1),
    ],
  ];
  return _section(
    header: _sectionHeader(
      '3 · Alignment — anchoring the source rect',
      'Where the bitmap sits when fit leaves slack inside the destination.',
      _gradHeader(),
      Icons.center_focus_strong,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              '`DecorationImage.alignment` only matters when the chosen '
              '`BoxFit` leaves whitespace (e.g. `contain`, `none`, '
              '`scaleDown` on a smaller bitmap) or overflow (`cover`, '
              '`fitWidth` with a tall source). The painter takes the '
              '`alignment` value, treats it as a position in [-1, +1] '
              'across each axis, and slides the drawn rect inside the '
              'destination accordingly.',
            ),
            _para(
              'Use `AlignmentDirectional` instead of `Alignment` when your '
              'layout must mirror under RTL text direction — the painter '
              'resolves it via the `TextDirection` passed to '
              '`DecorationImagePainter.paint`. The `matchTextDirection` '
              'field, demonstrated later, takes this further by horizontally '
              'flipping the bitmap itself.',
            ),
            _para(
              'A common pitfall is using `Alignment(0.4, 0.0)` on a hero '
              'image to nudge a face into the visible area: when '
              '`matchTextDirection` is true, the value is mirrored under '
              'RTL, and your nudge ends up off-frame. Prefer '
              '`AlignmentDirectional.centerStart` for content-aware nudges.',
            ),
            _hr(),
            _h2('3 × 3 grid of named alignments'),
            Column(
              children: List<Widget>.generate(rows.length, (int r) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    rows[r].length,
                    (int c) => _alignCard(rows[r][c]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 4 — ImageRepeat
//
// When `repeat` is anything other than `noRepeat`, the painter tiles the
// bitmap across the destination rect. We simulate this with a Wrap of small
// pattern tiles so the visual reads as "tiled" without invoking the real
// painter loop.
// ─────────────────────────────────────────────────────────────────────────────

class _RepeatSample {
  final ImageRepeat repeat;
  final String name;
  final String summary;
  // Tile counts used to produce the simulated image.
  final int cols;
  final int rows;
  final Color a;
  final Color b;
  const _RepeatSample({
    required this.repeat,
    required this.name,
    required this.summary,
    required this.cols,
    required this.rows,
    required this.a,
    required this.b,
  });
}

Widget _repeatCard(_RepeatSample s) {
  const double tileSize = 22;
  // Build a column of rows of pattern tiles. For "repeatX" we render a
  // single row centered vertically; for "repeatY" we render a single
  // column centered horizontally.
  Widget grid;
  if (s.repeat == ImageRepeat.noRepeat) {
    grid = Center(
      child: SizedBox(
        width: tileSize * 1.6,
        height: tileSize * 1.6,
        child: _patternTile(tileSize * 1.6, s.a, s.b),
      ),
    );
  } else if (s.repeat == ImageRepeat.repeatX) {
    grid = Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          s.cols,
          (int i) => _patternTile(tileSize, s.a, s.b),
        ),
      ),
    );
  } else if (s.repeat == ImageRepeat.repeatY) {
    grid = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          s.rows,
          (int i) => _patternTile(tileSize, s.a, s.b),
        ),
      ),
    );
  } else {
    grid = Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(s.rows, (int r) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            s.cols,
            (int c) => _patternTile(tileSize, s.a, s.b),
          ),
        );
      }),
    );
  }
  return Container(
    width: 220,
    margin: EdgeInsets.only(right: 12, bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccent2.withValues(alpha: 0.25)),
      boxShadow: _shadowFlat(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _badge(s.name, _kAccent2),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 196,
            height: 110,
            color: Color(0xFF0A1626),
            child: ClipRect(child: grid),
          ),
        ),
        SizedBox(height: 8),
        Text(
          s.summary,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _section4Repeat() {
  final List<_RepeatSample> samples = <_RepeatSample>[
    _RepeatSample(
      repeat: ImageRepeat.noRepeat,
      name: 'noRepeat',
      summary:
          'The painter draws the bitmap exactly once into the destination '
          'rect. Slack is left as transparent space.',
      cols: 1, rows: 1,
      a: Color(0xFF59C2FF), b: Color(0xFF1F6FEB),
    ),
    _RepeatSample(
      repeat: ImageRepeat.repeat,
      name: 'repeat',
      summary:
          'Tile in both axes. Useful for textures/backgrounds. The painter '
          'computes a tile rect and paints copies until the destination is '
          'filled.',
      cols: 8, rows: 5,
      a: Color(0xFFFFD166), b: Color(0xFFEF476F),
    ),
    _RepeatSample(
      repeat: ImageRepeat.repeatX,
      name: 'repeatX',
      summary:
          'Tile horizontally only — vertical alignment determines where the '
          'strip sits. Classic header pattern.',
      cols: 8, rows: 1,
      a: Color(0xFF6BCB77), b: Color(0xFF1B998B),
    ),
    _RepeatSample(
      repeat: ImageRepeat.repeatY,
      name: 'repeatY',
      summary:
          'Tile vertically only — horizontal alignment positions the column. '
          'Handy for vertical decorative gutters.',
      cols: 1, rows: 5,
      a: Color(0xFFB388FF), b: Color(0xFF7CFFC4),
    ),
  ];
  return _section(
    header: _sectionHeader(
      '4 · ImageRepeat — tile or single-shot',
      'Filling slack space by tiling rather than scaling.',
      _gradHeader2(),
      Icons.grid_view,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              '`ImageRepeat` is the second projection knob the painter '
              'consults. Once `BoxFit` has chosen a draw rect, the painter '
              'asks: should I paint that rect once, or should I tile copies '
              'along one or both axes? `noRepeat` is the default; the other '
              'three values turn the painter into a tile loop.',
            ),
            _para(
              'Tiling is much cheaper than re-decoding: the painter holds a '
              'single decoded `ui.Image` and replicates it via '
              '`canvas.drawImageRect`. Use it for textures, hatch '
              'backgrounds and watermarks where the visual is intentionally '
              'periodic. Bitmap textures should be authored to tile '
              'seamlessly — the painter will not blend edges for you.',
            ),
            _para(
              'A subtle interaction: `BoxFit` and `ImageRepeat` are '
              'orthogonal. With `BoxFit.contain` plus `ImageRepeat.repeat`, '
              'the painter contains the source, then tiles the contained '
              'rect — usually not what you want. For backgrounds, prefer '
              '`BoxFit.none` (or omit fit entirely) and let `repeat` fill '
              'the rect.',
            ),
            _hr(),
            _h2('Four repeat modes'),
            Wrap(
              children: List<Widget>.generate(
                samples.length,
                (int i) => _repeatCard(samples[i]),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 5 — ColorFilter showcase
// ─────────────────────────────────────────────────────────────────────────────

class _FilterSample {
  final String name;
  final String summary;
  final ColorFilter? filter;
  final Color tint;
  final BlendMode? blend;
  const _FilterSample({
    required this.name,
    required this.summary,
    required this.filter,
    required this.tint,
    required this.blend,
  });
}

Widget _filterCard(_FilterSample s) {
  // For visualisation, paint the stand-in then apply a ColorFiltered
  // over it using the same filter so the screen reflects the configured
  // filter behaviour.
  Widget child = _bitmap(
    imgWidth: 200,
    imgHeight: 110,
    gradient: _gradSunset(),
    label: 'BITMAP',
    cornerRadius: 8,
  );
  if (s.filter != null) {
    child = ColorFiltered(colorFilter: s.filter!, child: child);
  }
  return Container(
    width: 230,
    margin: EdgeInsets.only(right: 12, bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccent3.withValues(alpha: 0.30)),
      boxShadow: _shadowFlat(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _badge(s.name, _kAccent3),
            SizedBox(width: 6),
            if (s.blend != null)
              _chip(s.blend!.name, _kAccent5),
          ],
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: child,
        ),
        SizedBox(height: 8),
        Text(
          s.summary,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _section5ColorFilter() {
  final List<_FilterSample> samples = <_FilterSample>[
    _FilterSample(
      name: 'no filter',
      summary:
          'Baseline: the bitmap is painted untouched. `colorFilter` is null '
          'on the DecorationImage.',
      filter: null,
      tint: Colors.transparent,
      blend: null,
    ),
    _FilterSample(
      name: 'darken 35%',
      summary:
          'A common hero pattern: composite a black overlay at ~35% alpha so '
          'foreground text remains legible.',
      filter: ColorFilter.mode(Color(0x59000000), BlendMode.darken),
      tint: Color(0x59000000),
      blend: BlendMode.darken,
    ),
    _FilterSample(
      name: 'colorBurn',
      summary:
          'Multiply-style burn — punches contrast into a busy bitmap. Often '
          'paired with `BoxFit.cover` for editorial overlays.',
      filter: ColorFilter.mode(Color(0xFF1F6FEB), BlendMode.colorBurn),
      tint: Color(0xFF1F6FEB),
      blend: BlendMode.colorBurn,
    ),
    _FilterSample(
      name: 'saturation',
      summary:
          'Channel matrix that scales R/G/B equally — produces a tinted, '
          'lifted look. Works at the painter step before alignment/repeat.',
      filter: ColorFilter.matrix(<double>[
        1.2, 0, 0, 0, 0,
        0, 1.2, 0, 0, 0,
        0, 0, 1.2, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      tint: Color(0xFFFFFFFF),
      blend: null,
    ),
    _FilterSample(
      name: 'grayscale',
      summary:
          'Classic luminance matrix. The painter applies the matrix once per '
          'paint, so cost is constant in the image area — no per-pixel '
          'overhead in user code.',
      filter: ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      tint: Color(0xFF888888),
      blend: null,
    ),
    _FilterSample(
      name: 'tint via srcIn',
      summary:
          'Replace bitmap colour with a tint while keeping the alpha mask — '
          'the right move for monochrome icon decorations.',
      filter: ColorFilter.mode(Color(0xFF59C2FF), BlendMode.srcIn),
      tint: Color(0xFF59C2FF),
      blend: BlendMode.srcIn,
    ),
  ];
  return _section(
    header: _sectionHeader(
      '5 · colorFilter & invertColors',
      'Per-paint colour transforms applied by the painter before tiling.',
      _gradHeader(),
      Icons.color_lens,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              '`DecorationImage.colorFilter` is plumbed straight through to '
              '`paintImage` and ultimately to `Paint.colorFilter`. The '
              'painter applies the filter once per paint pass, so cost is '
              'constant per frame — there is no per-pixel work on the Dart '
              'side.',
            ),
            _para(
              '`invertColors`, by contrast, is implemented via a built-in '
              'colour matrix that the engine composes with any user '
              '`colorFilter`. It is meant for accessibility / dark-mode '
              'inversion and is a separate boolean knob on DecorationImage.',
            ),
            _para(
              'Choose `BlendMode.srcIn` for tinting icon-style monochrome '
              'images, `BlendMode.darken`/`overlay` for editorial '
              'photography, and a `ColorFilter.matrix` when you need '
              'continuous tone control such as saturation or brightness.',
            ),
            _hr(),
            _h2('Six filters side by side'),
            Wrap(
              children: List<Widget>.generate(
                samples.length,
                (int i) => _filterCard(samples[i]),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 6 — Practical recipe gallery
// ─────────────────────────────────────────────────────────────────────────────

class _Recipe {
  final String title;
  final String useCase;
  final String fields;
  final Widget visual;
  final Color tone;
  final _DimSpec spec;
  const _Recipe({
    required this.title,
    required this.useCase,
    required this.fields,
    required this.visual,
    required this.tone,
    required this.spec,
  });
}

Widget _recipeCard(_Recipe r) {
  return Container(
    width: 320,
    margin: EdgeInsets.only(right: 14, bottom: 14),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: r.tone.withValues(alpha: 0.40)),
      boxShadow: _shadowGlow(r.tone),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _badge(r.title, r.tone),
            SizedBox(width: 8),
            _chip(
              r.spec.constructed ? 'Painter constructed' : 'Skipped (offline)',
              r.spec.constructed ? _kAccent2 : _kAccent3,
            ),
          ],
        ),
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: r.visual,
        ),
        SizedBox(height: 10),
        Text(
          r.useCase,
          style: TextStyle(
            color: _kInk,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          r.fields,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            height: 1.45,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _recipeHeroBanner() {
  return Stack(
    children: <Widget>[
      _bitmap(
        imgWidth: 290,
        imgHeight: 130,
        gradient: _gradSunset(),
        label: 'HERO',
      ),
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0x00000000),
                Color(0x99000000),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 12,
        right: 12,
        bottom: 10,
        child: Text(
          'Discover the Highlands',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            shadows: <Shadow>[Shadow(color: Color(0xAA000000), blurRadius: 6)],
          ),
        ),
      ),
    ],
  );
}

Widget _recipeRepeatTexture() {
  return Container(
    width: 290,
    height: 130,
    color: Color(0xFF0A1626),
    child: ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(6, (int r) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              14,
              (int c) => _patternTile(22, Color(0xFF1F6FEB), Color(0xFF59C2FF)),
            ),
          );
        }),
      ),
    ),
  );
}

Widget _recipeAvatar() {
  return Container(
    width: 290,
    height: 130,
    color: Color(0xFF0A1626),
    alignment: Alignment.center,
    child: Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _kAccent, width: 2),
        boxShadow: _shadowCrisp(_kAccent),
      ),
      child: ClipOval(
        child: _bitmap(
          imgWidth: 92,
          imgHeight: 92,
          gradient: _gradMeadow(),
          label: 'AV',
          cornerRadius: 0,
        ),
      ),
    ),
  );
}

Widget _recipeWatermark() {
  return Stack(
    children: <Widget>[
      _bitmap(
        imgWidth: 290,
        imgHeight: 130,
        gradient: _gradStorm(),
        label: 'DOC',
      ),
      Positioned.fill(
        child: Center(
          child: Opacity(
            opacity: 0.18,
            child: Transform.rotate(
              angle: -0.45,
              child: Text(
                'DRAFT',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 6,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _section6Recipes() {
  final _DimSpec hero = _attemptBuildDim(
    name: 'hero banner',
    fit: BoxFit.cover,
    alignment: Alignment.center,
    colorFilter: ColorFilter.mode(Color(0x59000000), BlendMode.darken),
    filterQuality: FilterQuality.medium,
    isAntiAlias: true,
    narrative:
        'Banner with a 35% black overlay so headline text stays legible.',
  );
  final _DimSpec texture = _attemptBuildDim(
    name: 'tile texture',
    fit: BoxFit.none,
    alignment: Alignment.topLeft,
    repeat: ImageRepeat.repeat,
    filterQuality: FilterQuality.none,
    narrative:
        'Tiled background with no fit and pixel-snapped alignment.',
  );
  final _DimSpec avatar = _attemptBuildDim(
    name: 'avatar',
    fit: BoxFit.cover,
    alignment: Alignment.center,
    filterQuality: FilterQuality.high,
    isAntiAlias: true,
    narrative:
        'Square bitmap clipped to a circle with cover so faces stay framed.',
  );
  final _DimSpec watermark = _attemptBuildDim(
    name: 'watermark',
    fit: BoxFit.cover,
    alignment: Alignment.center,
    opacity: 0.85,
    colorFilter: ColorFilter.mode(Color(0x33FFFFFF), BlendMode.softLight),
    narrative:
        'Soft-light overlay at 85% opacity for branded watermarks.',
  );
  final _DimSpec onboarding = _attemptBuildDim(
    name: 'onboarding contain',
    fit: BoxFit.contain,
    alignment: Alignment.center,
    filterQuality: FilterQuality.medium,
    narrative:
        'Marketing illustration shown in full via contain, on a tinted card.',
  );
  final _DimSpec parallaxLayer = _attemptBuildDim(
    name: 'parallax layer',
    fit: BoxFit.cover,
    alignment: Alignment(0, 0.2),
    filterQuality: FilterQuality.medium,
    narrative:
        'Parallax sublayer with cover and a small vertical bias.',
  );

  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Hero banner',
      useCase: 'Hero with darken overlay',
      fields: 'fit: cover\nalignment: center\ncolorFilter: darken 35%',
      visual: _recipeHeroBanner(),
      tone: _kAccent4,
      spec: hero,
    ),
    _Recipe(
      title: 'Repeating texture',
      useCase: 'Background texture',
      fields: 'fit: none\nrepeat: repeat\nfilterQuality: none',
      visual: _recipeRepeatTexture(),
      tone: _kAccent2,
      spec: texture,
    ),
    _Recipe(
      title: 'Avatar',
      useCase: 'Circular avatar with cover',
      fields: 'fit: cover\nalignment: center\nisAntiAlias: true',
      visual: _recipeAvatar(),
      tone: _kAccent,
      spec: avatar,
    ),
    _Recipe(
      title: 'Watermark',
      useCase: 'Document watermark',
      fields: 'opacity: 0.85\ncolorFilter: softLight\nfit: cover',
      visual: _recipeWatermark(),
      tone: _kAccent5,
      spec: watermark,
    ),
    _Recipe(
      title: 'Onboarding',
      useCase: 'Illustration in full',
      fields: 'fit: contain\nfilterQuality: medium',
      visual: Container(
        width: 290,
        height: 130,
        color: Color(0xFF0A1626),
        alignment: Alignment.center,
        child: _bitmap(
          imgWidth: 200,
          imgHeight: 110,
          gradient: _gradSpring(),
          label: 'ILLUS',
        ),
      ),
      tone: _kAccent3,
      spec: onboarding,
    ),
    _Recipe(
      title: 'Parallax layer',
      useCase: 'Vertical parallax sublayer',
      fields: 'fit: cover\nalignment: (0, 0.2)\nfilterQuality: medium',
      visual: ClipRect(
        child: OverflowBox(
          maxHeight: 160,
          alignment: Alignment(0, 0.2),
          child: _bitmap(
            imgWidth: 290,
            imgHeight: 160,
            gradient: _gradEmber(),
            label: 'PARALLAX',
          ),
        ),
      ),
      tone: _kAccent4,
      spec: parallaxLayer,
    ),
  ];

  return _section(
    header: _sectionHeader(
      '6 · Practical recipe gallery',
      'Real-world DecorationImage configurations and what they buy you.',
      _gradHeader2(),
      Icons.menu_book,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              'These six recipes correspond to DecorationImage configurations '
              'you will reach for in production. Each one constructs a real '
              '`DecorationImage` instance through `_attemptBuildDim` so that '
              'the bridge actually exercises the constructor; the visual '
              'beneath is a hand-laid approximation of what the painter '
              'would emit when its image stream resolves.',
            ),
            _para(
              'Notice how each recipe combines several fields rather than '
              'tweaking one in isolation. `cover + darken + medium quality` '
              'is the editorial banner; `none + repeat + quality:none` is '
              'the pixel-art texture; `cover + isAntiAlias + clipOval` is '
              'the avatar. The painter does not impose any of these — they '
              'are emergent recipes from the field combinations.',
            ),
            _para(
              'When a recipe says `Painter constructed`, the bridge was '
              'able to instantiate the underlying `DecorationImage`. When '
              'it says `Skipped (offline)`, the constructor threw — usually '
              'because the embedder cannot resolve a `MemoryImage` byte '
              'stream — and the visual is shown without a backing instance.',
            ),
            _hr(),
            _h2('Six hand-authored recipes'),
            Wrap(
              children: List<Widget>.generate(
                recipes.length,
                (int i) => _recipeCard(recipes[i]),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 7 — Footguns
// ─────────────────────────────────────────────────────────────────────────────

class _Footgun {
  final String title;
  final String mistake;
  final String fix;
  final Widget visual;
  const _Footgun({
    required this.title,
    required this.mistake,
    required this.fix,
    required this.visual,
  });
}

Widget _footgunVisualFillLowRes() {
  return Container(
    width: 270,
    height: 110,
    color: Color(0xFF0A1626),
    alignment: Alignment.center,
    child: SizedBox(
      width: 260,
      height: 100,
      child: _bitmap(
        imgWidth: 260,
        imgHeight: 100,
        gradient: _gradStorm(),
        label: 'STRETCHED',
      ),
    ),
  );
}

Widget _footgunVisualCoverMismatchRTL() {
  return Container(
    width: 270,
    height: 110,
    color: Color(0xFF0A1626),
    alignment: Alignment.center,
    child: ClipRect(
      child: OverflowBox(
        maxWidth: 350,
        alignment: Alignment.centerRight,
        child: _bitmap(
          imgWidth: 350,
          imgHeight: 100,
          gradient: _gradEmber(),
          label: 'MIRRORED?',
        ),
      ),
    ),
  );
}

Widget _footgunVisualTinyCells() {
  return Container(
    width: 270,
    height: 110,
    color: Color(0xFF0A1626),
    padding: EdgeInsets.all(8),
    child: Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List<Widget>.generate(
        18,
        (int i) => _bitmap(
          imgWidth: 26,
          imgHeight: 26,
          gradient: i.isEven ? _gradOcean() : _gradEmber(),
          label: 'x',
          cornerRadius: 4,
          showSun: false,
          showMountains: false,
        ),
      ),
    ),
  );
}

Widget _footgunVisualLeak() {
  return Container(
    width: 270,
    height: 110,
    color: Color(0xFF0A1626),
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber, color: _kDanger, size: 18),
            SizedBox(width: 6),
            Text(
              'Listener count growing',
              style: TextStyle(
                color: _kDanger,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        // A "leak meter".
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFF132034),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[_kAccent3, _kDanger],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Expanded(flex: 3, child: SizedBox.shrink()),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'streamCompleter listeners: 7 → 8 → 9 → …',
          style: TextStyle(
            color: _kInkSoft,
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Cause: forgot painter.dispose() on rebuild',
          style: TextStyle(color: _kInk, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget _footgunCard(_Footgun f) {
  return Container(
    width: 320,
    margin: EdgeInsets.only(right: 14, bottom: 14),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kDanger.withValues(alpha: 0.45)),
      boxShadow: _shadowCrisp(_kDanger),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _badge('FOOTGUN', _kDanger),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                f.title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: f.visual,
        ),
        SizedBox(height: 10),
        Text(
          'Mistake — ${f.mistake}',
          style: TextStyle(
            color: _kDanger,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Fix — ${f.fix}',
          style: TextStyle(
            color: _kAccent2,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _section7Footguns() {
  final List<_Footgun> guns = <_Footgun>[
    _Footgun(
      title: 'BoxFit.fill on a low-res asset',
      mistake:
          'The painter stretches a small bitmap to a much larger rect — '
          'aspect ratio is lost and the user sees blurred, smeared pixels.',
      fix:
          'Use BoxFit.cover and supply a 2× / 3× asset; keep filterQuality '
          'at medium so the engine resamples cleanly.',
      visual: _footgunVisualFillLowRes(),
    ),
    _Footgun(
      title: 'cover + matchTextDirection mismatch',
      mistake:
          'matchTextDirection mirrors the bitmap, but a hand-tuned '
          'Alignment(0.4, 0) nudge does not flip — under RTL the focal '
          'point ends up off-frame.',
      fix:
          'Use AlignmentDirectional or disable matchTextDirection for '
          'photos that contain text or directional cues.',
      visual: _footgunVisualCoverMismatchRTL(),
    ),
    _Footgun(
      title: 'filterQuality.none on tiny cells',
      mistake:
          'Disabling resampling on lots of small avatars produces aliased, '
          'jagged edges; the painter blits without smoothing.',
      fix:
          'Set filterQuality: FilterQuality.medium (or high for retina) '
          'and isAntiAlias: true for circular crops.',
      visual: _footgunVisualTinyCells(),
    ),
    _Footgun(
      title: 'Leaking the painter',
      mistake:
          'Calling createPainter on every build without disposing the '
          'previous painter leaks listeners on the ImageStream and pins '
          'decoded ui.Image instances in the cache.',
      fix:
          'Hold the painter on a State object and call dispose() in '
          'didUpdateWidget when the DecorationImage changes, and again '
          'in dispose().',
      visual: _footgunVisualLeak(),
    ),
  ];
  return _section(
    header: _sectionHeader(
      '7 · Footguns — what bites teams in production',
      'Common DecorationImage / painter mistakes and their fixes.',
      _gradHeader(),
      Icons.warning,
    ),
    body: <Widget>[
      _card(
        color: _kCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              'Each of these mistakes ships in real apps. They are easy to '
              'miss because the painter never throws — it just produces '
              'subtly wrong pixels or quietly accumulates listeners. The '
              'fixes are all one or two field changes on the configuration '
              'or one extra dispose() on the painter handle.',
            ),
            _para(
              'In all four cases, run the layout under both LTR and RTL, '
              'and at multiple device pixel ratios. The painter behaves '
              'differently when matchTextDirection is true and when '
              'filterQuality is none — and these differences only become '
              'visible on high-DPR devices or under accessibility settings.',
            ),
            _hr(),
            Wrap(
              children: List<Widget>.generate(
                guns.length,
                (int i) => _footgunCard(guns[i]),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 8 — Painter lifecycle (4-step flow)
// ─────────────────────────────────────────────────────────────────────────────

Widget _lifecycleStep({
  required int n,
  required String title,
  required String body,
  required Color tone,
  required IconData icon,
}) {
  return Container(
    width: 220,
    padding: EdgeInsets.all(14),
    margin: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone.withValues(alpha: 0.55)),
      boxShadow: _shadowCrisp(tone),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: tone,
                shape: BoxShape.circle,
                boxShadow: _shadowCrisp(tone),
              ),
              alignment: Alignment.center,
              child: Text(
                '$n',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(icon, color: tone, size: 20),
          ],
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _section8Lifecycle() {
  return _section(
    header: _sectionHeader(
      '8 · Painter lifecycle',
      'Resolve → listen → paint → dispose. Forgetting any step bites you.',
      _gradHeader2(),
      Icons.timeline,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              'A `DecorationImagePainter` lives between two events: the '
              'BoxDecoration starts being painted (createPainter is called) '
              'and the BoxDecoration stops being painted (dispose is '
              'called). In between, the painter holds an `ImageStream` '
              'subscription that delivers `ImageInfo` updates whenever the '
              'underlying provider resolves a new frame.',
            ),
            _para(
              'The painter is *not* attached to the widget tree directly; '
              'it lives on the RenderBox or any owner that performs '
              'BoxDecoration painting. That is why holding a painter in a '
              'StatelessWidget is wrong — there is no reliable disposal '
              'site. Always treat painter ownership as State-bound.',
            ),
            _para(
              'When the configuration object changes (different '
              'ImageProvider, different fit) the rule is: dispose the old '
              'painter, then call createPainter on the new DecorationImage. '
              'Do not try to mutate the existing painter — DecorationImage '
              'is intentionally immutable.',
            ),
            _hr(),
            _h2('Four-step flow'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _lifecycleStep(
                    n: 1,
                    title: 'createPainter(onChanged)',
                    body:
                        'The DecorationImage constructs a painter and hands '
                        'over your repaint callback. No image work happens '
                        'yet; the painter is cheap to create.',
                    tone: _kAccent,
                    icon: Icons.build_circle,
                  ),
                  _arrow(_kAccent),
                  _lifecycleStep(
                    n: 2,
                    title: 'paint(canvas, rect, td, cfg)',
                    body:
                        'On first paint the painter resolves the '
                        'ImageProvider and subscribes to its ImageStream. '
                        'If the bitmap is not yet decoded, paint is a '
                        'no-op for the image layer.',
                    tone: _kAccent2,
                    icon: Icons.brush,
                  ),
                  _arrow(_kAccent2),
                  _lifecycleStep(
                    n: 3,
                    title: 'onChanged() fires',
                    body:
                        'When ImageInfo arrives the painter invokes your '
                        'callback; the owner schedules a repaint and the '
                        'next paint call blits the bitmap with the '
                        'configured fit/repeat/filter.',
                    tone: _kAccent3,
                    icon: Icons.notifications_active,
                  ),
                  _arrow(_kAccent3),
                  _lifecycleStep(
                    n: 4,
                    title: 'dispose()',
                    body:
                        'Cancels the ImageStream subscription, releases the '
                        'cached ui.Image reference, and frees the painter. '
                        'Skipping this is the most common image-related '
                        'leak in Flutter.',
                    tone: _kAccent4,
                    icon: Icons.delete_sweep,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 9 — API summary table
// ─────────────────────────────────────────────────────────────────────────────

class _ApiRow {
  final String name;
  final String type;
  final String description;
  const _ApiRow(this.name, this.type, this.description);
}

Widget _apiTable(String title, List<_ApiRow> rows, Color tone) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: _kCardAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tone.withValues(alpha: 0.40)),
      boxShadow: _shadowFlat(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Column(
          children: List<Widget>.generate(rows.length, (int i) {
            final _ApiRow r = rows[i];
            final bool even = i.isEven;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              color: even
                  ? Color(0x14FFFFFF)
                  : Color(0x00FFFFFF),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: Text(
                      r.name,
                      style: TextStyle(
                        color: tone,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(
                      r.type,
                      style: TextStyle(
                        color: _kInkSoft,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.description,
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _section9Api() {
  final List<_ApiRow> dimRows = <_ApiRow>[
    _ApiRow('image', 'ImageProvider',
        'The bitmap source. AssetImage / NetworkImage / MemoryImage / FileImage.'),
    _ApiRow('fit', 'BoxFit?',
        'Projection mode from intrinsic to destination rect.'),
    _ApiRow('alignment', 'AlignmentGeometry',
        'Where the source rect sits when fit leaves slack or overflow.'),
    _ApiRow('repeat', 'ImageRepeat',
        'Tile the source across X, Y, both, or paint once.'),
    _ApiRow('scale', 'double',
        'Logical→physical pixel ratio used when measuring the bitmap.'),
    _ApiRow('opacity', 'double',
        'Per-image opacity multiplier applied during paint.'),
    _ApiRow('colorFilter', 'ColorFilter?',
        'Composed with the engine paint before blitting.'),
    _ApiRow('invertColors', 'bool',
        'Built-in inversion matrix; useful for accessibility.'),
    _ApiRow('isAntiAlias', 'bool',
        'Smooths edges; pair with circular ClipOval avatars.'),
    _ApiRow('matchTextDirection', 'bool',
        'Mirror horizontally when ambient TextDirection is RTL.'),
    _ApiRow('filterQuality', 'FilterQuality',
        'Low / medium / high resampling for non-pixel-aligned scales.'),
    _ApiRow('createPainter()', '→ DecorationImagePainter',
        'Factory: returns a painter that owns the stream subscription.'),
  ];
  final List<_ApiRow> dipRows = <_ApiRow>[
    _ApiRow('paint(canvas, rect, td, cfg)', 'void',
        'Blit the bitmap into rect using the configured fit/alignment/repeat.'),
    _ApiRow('dispose()', 'void',
        'Cancel ImageStream subscription, release cached ui.Image refs.'),
    _ApiRow('onChanged', 'VoidCallback',
        'Invoked when the ImageStream resolves; owner repaints next frame.'),
  ];
  return _section(
    header: _sectionHeader(
      '9 · API summary',
      'DecorationImage fields and DecorationImagePainter methods at a glance.',
      _gradHeader(),
      Icons.list_alt,
    ),
    body: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _para(
              'These are the surface APIs you will interact with directly. '
              'DecorationImage owns the configuration; DecorationImagePainter '
              'owns the runtime behaviour. There are no other public moving '
              'parts — everything else lives behind the static `paintImage` '
              'helper or the `ImageStream` machinery.',
            ),
            _apiTable('class DecorationImage', dimRows, _kAccent),
            _apiTable('class DecorationImagePainter', dipRows, _kAccent2),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 0 — Intro / hero
// ─────────────────────────────────────────────────────────────────────────────

Widget _intro() {
  return Container(
    margin: EdgeInsets.only(bottom: 30),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF13243C),
          Color(0xFF0E1A2C),
        ],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kAccent.withValues(alpha: 0.45)),
      boxShadow: _shadowDeep(),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _badge('PAINTING', _kAccent),
            SizedBox(width: 8),
            _badge('DECORATION', _kAccent2),
            SizedBox(width: 8),
            _badge('IMAGE', _kAccent3),
            SizedBox(width: 8),
            _chip('package:flutter/painting', _kAccent5),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'DecorationImage & DecorationImagePainter',
          style: TextStyle(
            color: _kInk,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'A deep, hand-authored tour of how a BoxDecoration paints a bitmap — '
          'from the immutable configuration object you instantiate, through '
          'the painter factory, to the listener-driven paint pipeline that '
          'projects pixels into a destination rect.',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: <Widget>[
            _kbd('image'),
            _kbd('fit'),
            _kbd('alignment'),
            _kbd('repeat'),
            _kbd('scale'),
            _kbd('opacity'),
            _kbd('colorFilter'),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: <Widget>[
            _kbd('invertColors'),
            _kbd('isAntiAlias'),
            _kbd('matchTextDirection'),
            _kbd('filterQuality'),
          ],
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// build() — the single entry point.
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0E1A2C),
      appBar: AppBar(title: const Text('DecorationImage / DecorationImagePainter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _intro(),
            _section1Anatomy(),
            _section2BoxFit(),
            _section3Alignment(),
            _section4Repeat(),
            _section5ColorFilter(),
            _section6Recipes(),
            _section7Footguns(),
            _section8Lifecycle(),
            _section9Api(),
          ],
        ),
      ),
    ),
  );
}
