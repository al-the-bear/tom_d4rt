// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element, unnecessary_import

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// painting / ImageInfo — deep visual demonstration
// ---------------------------------------------------------------------------
//
// ImageInfo is the value object that an ImageStreamListener receives once an
// ImageProvider has finished decoding a frame.  It bundles together three
// pieces of information that downstream painting code needs in order to draw
// the bitmap onto a logical-pixel surface:
//
//   * image       — the decoded `dart:ui.Image` (raw pixel buffer + GPU
//                   handle).  Width and height on this object are PHYSICAL
//                   pixels, not logical pixels.
//   * scale       — a `double` describing how many physical pixels of the
//                   bitmap correspond to one logical pixel on screen.  A
//                   scale of 2.0 means "this asset was prepared for 2x
//                   density displays"; the painted size is therefore
//                   image.width / 2 by image.height / 2 logical pixels.
//   * debugLabel  — an optional `String?` carried for diagnostics.  It is
//                   surfaced in the DevTools "Images" panel and in
//                   `Image`'s error-builder fallback path.  Production
//                   layout never reads it; tooling and crash reports do.
//
// The interpreter that runs this demo cannot synthesise a real `ui.Image`
// safely, so every "ImageInfo" rendered here is a labelled, conceptual
// stand-in: a card showing the values its three fields would carry, paired
// with a gradient block representing the bitmap.
//
// The build function is invoked exactly once.  No state, no controllers, no
// streams, no async work, no setState.  All data is const literal lists.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Palette — reused across sections for visual coherence.
// ---------------------------------------------------------------------------

const Color kCanvas = Color(0xFF0F1B2D);
const Color kSurface = Color(0xFF18253A);
const Color kSurfaceAlt = Color(0xFF1F2F47);
const Color kSurfaceHi = Color(0xFF243650);
const Color kBorder = Color(0xFF2C405E);
const Color kBorderHi = Color(0xFF3C547A);
const Color kInk = Color(0xFFE8EEF8);
const Color kInkSoft = Color(0xFFB7C2D5);
const Color kInkFaint = Color(0xFF8693AB);
const Color kAccentCyan = Color(0xFF4FD1FF);
const Color kAccentTeal = Color(0xFF34D6B5);
const Color kAccentMagenta = Color(0xFFFF6FB5);
const Color kAccentAmber = Color(0xFFFFB74D);
const Color kAccentLime = Color(0xFFB6E061);
const Color kAccentViolet = Color(0xFF9D7DFF);
const Color kAccentRose = Color(0xFFFF8A8A);
const Color kAccentSky = Color(0xFF7FB8FF);
const Color kSuccess = Color(0xFF55E1A8);
const Color kWarning = Color(0xFFFFCB66);
const Color kDanger = Color(0xFFFF7676);

// ---------------------------------------------------------------------------
// Gradients — at least six distinct linear gradients used across sections.
// ---------------------------------------------------------------------------

const LinearGradient kHeaderAnatomy = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1F4E78), Color(0xFF4FD1FF), Color(0xFF34D6B5)],
);

const LinearGradient kHeaderScale = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF6A2A8A), Color(0xFFFF6FB5), Color(0xFFFFB74D)],
);

const LinearGradient kHeaderDebug = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[Color(0xFF1B5E20), Color(0xFF66BB6A), Color(0xFFB6E061)],
);

const LinearGradient kHeaderDpr = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF263238), Color(0xFF4FD1FF), Color(0xFFB6E061)],
);

const LinearGradient kHeaderLifecycle = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF311B92), Color(0xFF7E57C2), Color(0xFFFF6FB5)],
);

const LinearGradient kHeaderRecipes = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF004D40), Color(0xFF26A69A), Color(0xFF4FD1FF)],
);

const LinearGradient kHeaderFootguns = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF8B0000), Color(0xFFFF7676), Color(0xFFFFB74D)],
);

const LinearGradient kHeaderCompare = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF1A237E), Color(0xFF7FB8FF), Color(0xFF9D7DFF)],
);

const LinearGradient kHeaderApi = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF263238), Color(0xFF455A64), Color(0xFF4FD1FF)],
);

const LinearGradient kBitmap1x = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF4FD1FF), Color(0xFF1F4E78)],
);

const LinearGradient kBitmap2x = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFFF6FB5), Color(0xFF6A2A8A)],
);

const LinearGradient kBitmap3x = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFFFB74D), Color(0xFFB23A48)],
);

const LinearGradient kBitmapTeal = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF34D6B5), Color(0xFF004D40)],
);

const LinearGradient kBitmapLime = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFB6E061), Color(0xFF33691E)],
);

const LinearGradient kBitmapViolet = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF9D7DFF), Color(0xFF311B92)],
);

// ---------------------------------------------------------------------------
// Shadow ladders — at least six distinct shadows.
// ---------------------------------------------------------------------------

const List<BoxShadow> kShadowSoft = <BoxShadow>[
  BoxShadow(color: Color(0x33000000), blurRadius: 14, offset: Offset(0, 6)),
];

const List<BoxShadow> kShadowMedium = <BoxShadow>[
  BoxShadow(color: Color(0x4D000000), blurRadius: 22, offset: Offset(0, 10)),
];

const List<BoxShadow> kShadowStrong = <BoxShadow>[
  BoxShadow(color: Color(0x66000000), blurRadius: 30, offset: Offset(0, 14)),
];

const List<BoxShadow> kShadowCyanGlow = <BoxShadow>[
  BoxShadow(color: Color(0x554FD1FF), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> kShadowMagentaGlow = <BoxShadow>[
  BoxShadow(color: Color(0x55FF6FB5), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> kShadowAmberGlow = <BoxShadow>[
  BoxShadow(color: Color(0x55FFB74D), blurRadius: 24, offset: Offset(0, 0)),
];

const List<BoxShadow> kShadowLimeGlow = <BoxShadow>[
  BoxShadow(color: Color(0x55B6E061), blurRadius: 24, offset: Offset(0, 0)),
];

// ---------------------------------------------------------------------------
// Build entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0F1B2D),
      appBar: AppBar(
        backgroundColor: kSurface,
        foregroundColor: kInk,
        elevation: 0,
        title: const Text('painting ImageInfo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroBanner(),
            const SizedBox(height: 28),
            _section1Anatomy(),
            const SizedBox(height: 28),
            _section2ScaleLadder(),
            const SizedBox(height: 28),
            _section3DebugLabels(),
            const SizedBox(height: 28),
            _section4DprAware(),
            const SizedBox(height: 28),
            _section5Lifecycle(),
            const SizedBox(height: 28),
            _section6Recipes(),
            const SizedBox(height: 28),
            _section7Footguns(),
            const SizedBox(height: 28),
            _section8VsImageProvider(),
            const SizedBox(height: 28),
            _section9ApiSummary(),
            const SizedBox(height: 28),
            _constructionAttempt(),
            const SizedBox(height: 28),
            _footerCard(),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared building blocks
// ---------------------------------------------------------------------------

Widget _sectionHeader({
  required String index,
  required String title,
  required String subtitle,
  required LinearGradient gradient,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(20),
      boxShadow: kShadowMedium,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x66FFFFFF), width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFE5EEFF),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _proseParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: kInkSoft,
        fontSize: 14,
        height: 1.55,
      ),
    ),
  );
}

Widget _surfaceCard({
  required Widget child,
  Color background = kSurface,
  Color border = kBorder,
  EdgeInsets padding = const EdgeInsets.all(18),
  List<BoxShadow> shadow = kShadowSoft,
  double radius = 16,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border, width: 1),
      boxShadow: shadow,
    ),
    child: child,
  );
}

Widget _bitmapStandIn({
  required double width,
  required double height,
  required LinearGradient gradient,
  String? overlay,
  List<BoxShadow> shadow = kShadowSoft,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x66FFFFFF), width: 1),
      boxShadow: shadow,
    ),
    alignment: Alignment.center,
    child: overlay == null
        ? null
        : Text(
            overlay,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
  );
}

Widget _kvRow(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 96,
          child: Text(
            key,
            style: const TextStyle(
              color: kInkFaint,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? kInk,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _badge(String text, {Color color = kAccentCyan}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero banner — sets the stage for ImageInfo
// ---------------------------------------------------------------------------

Widget _heroBanner() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0B2A4A),
          Color(0xFF1F4E78),
          Color(0xFF34D6B5),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: kShadowStrong,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x33000000),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0x66FFFFFF), width: 1),
              ),
              child: const Text(
                'package:flutter/painting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10),
            _badge('value object', color: kAccentLime),
            const SizedBox(width: 10),
            _badge('immutable', color: kAccentAmber),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'ImageInfo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The lightweight payload delivered by ImageStreamListener.',
          style: TextStyle(
            color: Color(0xFFE3F2FF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x33000000),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x66FFFFFF), width: 1),
          ),
          child: const Text(
            'class ImageInfo {\n'
            '  final ui.Image image;     // decoded GPU-backed bitmap\n'
            '  final double scale;       // physical pixels per logical pixel\n'
            '  final String? debugLabel; // diagnostic provenance\n'
            '}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Anatomy diagram
// ---------------------------------------------------------------------------

Widget _section1Anatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '01',
        title: 'Anatomy of an ImageInfo',
        subtitle: 'Three immutable fields: image, scale, debugLabel.',
        gradient: kHeaderAnatomy,
        icon: Icons.account_tree_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'An ImageInfo is the smallest possible "envelope" a decoded image can '
        'travel in.  Crucially, it is delivered AFTER decoding — by the time '
        'an ImageStreamListener.onImage callback fires with one, the bytes '
        'have already been turned into a GPU-backed dart:ui.Image.  The '
        'envelope therefore carries no loading state, no progress, no error: '
        'just the finished bitmap, the density it was prepared for, and an '
        'optional diagnostic label naming where it came from.',
      ),
      _proseParagraph(
        'Because the three fields are final, ImageInfo is safe to share '
        'across frames and across widgets.  The painting pipeline relies on '
        'this immutability when caching providers — two listeners that '
        'resolve the same key will receive the same ImageInfo, never a '
        'mutated copy.  If you need different scaling, you create a new '
        'ImageInfo; you never mutate an existing one.',
      ),
      _proseParagraph(
        'The reader should think of ImageInfo as the "answer" half of the '
        'image-loading conversation.  ImageProvider asks "where do I find '
        'this picture?", and ImageInfo answers "here is the decoded bitmap, '
        'this is its density, and here is the human-readable label you can '
        'show in DevTools when something goes wrong".',
      ),
      const SizedBox(height: 8),
      _anatomyDiagram(),
      const SizedBox(height: 14),
      _anatomyFieldsTable(),
    ],
  );
}

Widget _anatomyDiagram() {
  return _surfaceCard(
    background: kSurfaceAlt,
    border: kBorderHi,
    shadow: kShadowMedium,
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.center_focus_strong_outlined,
                color: kAccentCyan, size: 18),
            const SizedBox(width: 8),
            const Text(
              'Diagram — what an ImageInfo holds',
              style: TextStyle(
                color: kInk,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _bitmapStandIn(
              width: 140,
              height: 100,
              gradient: kBitmap2x,
              overlay: 'ui.Image\n400 × 300 px',
              shadow: kShadowMagentaGlow,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _kvRow('image', 'ui.Image (400 × 300 physical pixels)',
                      valueColor: kAccentMagenta),
                  _kvRow('scale', '2.0  → painted at 200 × 150 logical px',
                      valueColor: kAccentCyan),
                  _kvRow('debugLabel', '"AssetImage: assets/hero/banner.png"',
                      valueColor: kAccentLime),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kCanvas,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: const Text(
            'logicalWidth  = image.width  / scale\n'
            'logicalHeight = image.height / scale\n'
            'paintedSize   = Size(logicalWidth, logicalHeight)\n'
            '// debugLabel never affects layout — diagnostics only.',
            style: TextStyle(
              color: kInk,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyFieldsTable() {
  const List<List<String>> rows = <List<String>>[
    <String>['image', 'ui.Image', 'Decoded GPU-backed bitmap. Width/height '
        'are PHYSICAL pixels.'],
    <String>['scale', 'double',
        'Physical pixels per logical pixel. Must be > 0.'],
    <String>['debugLabel', 'String?',
        'Diagnostic name. Surfaced in DevTools and error builders.'],
    <String>['isCloneOf', 'method',
        'Returns true if two ImageInfos refer to the same underlying '
            'decoded image.'],
    <String>['clone()', 'method',
        'Returns a new ImageInfo whose ui.Image is a clone of this one '
            '(reference-counted).'],
    <String>['dispose()', 'method',
        'Disposes the underlying ui.Image when no listener still needs it.'],
  ];
  return _surfaceCard(
    background: kSurface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.table_chart_outlined, color: kAccentTeal, size: 18),
            const SizedBox(width: 8),
            const Text(
              'Fields & key methods',
              style: TextStyle(
                color: kInk,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Column(
          children: List<Widget>.generate(rows.length, (int i) {
            final List<String> row = rows[i];
            final bool last = i == rows.length - 1;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: last ? Colors.transparent : kBorder,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: Text(
                      row[0],
                      style: const TextStyle(
                        color: kAccentCyan,
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 88,
                    child: Text(
                      row[1],
                      style: const TextStyle(
                        color: kAccentAmber,
                        fontSize: 12,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row[2],
                      style: const TextStyle(
                        color: kInkSoft,
                        fontSize: 13,
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

// ---------------------------------------------------------------------------
// Section 2 — Scale ladder
// ---------------------------------------------------------------------------

Widget _section2ScaleLadder() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '02',
        title: 'Scale ladder — same bitmap, six densities',
        subtitle: 'A 200×200 px source resolves to different logical sizes.',
        gradient: kHeaderScale,
        icon: Icons.stairs_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'Scale is the lever that converts a fixed pixel-count bitmap into a '
        'density-correct logical-pixel size.  For a hypothetical source of '
        '200 × 200 PHYSICAL pixels, an ImageInfo with scale = 1.0 will paint '
        'as a 200 × 200 LOGICAL box, while scale = 2.0 will paint as a '
        '100 × 100 logical box.  Same bytes, same GPU texture — only the '
        'reported scale differs.',
      ),
      _proseParagraph(
        'The painting subsystem uses scale during layout: when an Image '
        'widget is given no explicit size, it asks its ImageInfo for the '
        'natural logical size and supplies that to its parent.  This is why '
        'a 2x asset on a 2x screen "just looks right" — the framework has '
        'already done the division.',
      ),
      _proseParagraph(
        'Below, six labelled cards show the same hypothetical 200 × 200 '
        'pixel source rendered with scales 1.0, 1.25, 1.5, 2.0, 2.5, and 3.0.  '
        'The gradient stand-in shrinks proportionally so the eye can compare '
        'the resulting on-screen footprint at a glance.',
      ),
      const SizedBox(height: 8),
      _scaleLadderGrid(),
      const SizedBox(height: 14),
      _scaleFormulaCard(),
    ],
  );
}

Widget _scaleLadderGrid() {
  // 200 × 200 physical pixels source.
  const double sourcePx = 200;
  final List<_ScaleEntry> entries = <_ScaleEntry>[
    const _ScaleEntry(
      scale: 1.0,
      label: '1.0x',
      caption: 'Reference density. 1 px == 1 logical px.',
      gradient: kBitmap1x,
      glow: kShadowCyanGlow,
      provenance: 'AssetImage: assets/icon.png',
    ),
    const _ScaleEntry(
      scale: 1.25,
      label: '1.25x',
      caption: 'Common on Windows 125 % display scaling.',
      gradient: kBitmap2x,
      glow: kShadowMagentaGlow,
      provenance: 'AssetImage: assets/1.25x/icon.png',
    ),
    const _ScaleEntry(
      scale: 1.5,
      label: '1.5x',
      caption: 'Mid-DPI Android (hdpi bucket).',
      gradient: kBitmap3x,
      glow: kShadowAmberGlow,
      provenance: 'AssetImage: assets/1.5x/icon.png',
    ),
    const _ScaleEntry(
      scale: 2.0,
      label: '2.0x',
      caption: 'Retina laptops and most modern phones.',
      gradient: kBitmapTeal,
      glow: kShadowCyanGlow,
      provenance: 'AssetImage: assets/2.0x/icon.png',
    ),
    const _ScaleEntry(
      scale: 2.5,
      label: '2.5x',
      caption: 'High-DPI Android (xhdpi/xxhdpi blend).',
      gradient: kBitmapLime,
      glow: kShadowLimeGlow,
      provenance: 'AssetImage: assets/2.5x/icon.png',
    ),
    const _ScaleEntry(
      scale: 3.0,
      label: '3.0x',
      caption: 'iPhone Pro / xxxhdpi.',
      gradient: kBitmapViolet,
      glow: kShadowMagentaGlow,
      provenance: 'AssetImage: assets/3.0x/icon.png',
    ),
  ];

  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: List<Widget>.generate(entries.length, (int i) {
      final _ScaleEntry e = entries[i];
      final double logical = sourcePx / e.scale;
      return SizedBox(
        width: 240,
        child: _surfaceCard(
          background: kSurface,
          border: kBorder,
          shadow: kShadowSoft,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    e.label,
                    style: const TextStyle(
                      color: kInk,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  _badge('scale: ${e.scale}', color: kAccentCyan),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: _bitmapStandIn(
                  width: logical,
                  height: logical,
                  gradient: e.gradient,
                  overlay:
                      'logical\n${logical.toStringAsFixed(1)} × ${logical.toStringAsFixed(1)}',
                  shadow: e.glow,
                ),
              ),
              const SizedBox(height: 12),
              _kvRow('image', '200 × 200 px', valueColor: kAccentMagenta),
              _kvRow('scale', e.scale.toString(),
                  valueColor: kAccentCyan),
              _kvRow(
                'logical',
                '${logical.toStringAsFixed(2)} × ${logical.toStringAsFixed(2)}',
                valueColor: kAccentLime,
              ),
              _kvRow('debugLabel', e.provenance,
                  valueColor: kAccentAmber),
              const SizedBox(height: 8),
              Text(
                e.caption,
                style: const TextStyle(
                  color: kInkSoft,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}

class _ScaleEntry {
  final double scale;
  final String label;
  final String caption;
  final LinearGradient gradient;
  final List<BoxShadow> glow;
  final String provenance;
  const _ScaleEntry({
    required this.scale,
    required this.label,
    required this.caption,
    required this.gradient,
    required this.glow,
    required this.provenance,
  });
}

Widget _scaleFormulaCard() {
  return _surfaceCard(
    background: kSurfaceAlt,
    border: kBorderHi,
    shadow: kShadowMedium,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.functions, color: kAccentMagenta, size: 18),
            const SizedBox(width: 8),
            const Text(
              'The conversion formula',
              style: TextStyle(
                color: kInk,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kCanvas,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: const Text(
            'Size logicalSize(ImageInfo info) {\n'
            '  return Size(\n'
            '    info.image.width  / info.scale,\n'
            '    info.image.height / info.scale,\n'
            '  );\n'
            '}',
            style: TextStyle(
              color: kInk,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Reading the table: the source is fixed at 200 × 200 PHYSICAL '
          'pixels.  The "logical" column is what the framework will report '
          'to the parent widget when no explicit width/height is set on the '
          'Image.  Higher scale → smaller logical footprint → sharper paint '
          'on a high-density display.',
          style: TextStyle(color: kInkSoft, fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Debug-label patterns
// ---------------------------------------------------------------------------

Widget _section3DebugLabels() {
  const List<List<String>> labelRows = <List<String>>[
    <String>['AssetImage', 'AssetImage: assets/logo.png',
        'Bundled asset; resolved through AssetBundle.'],
    <String>['NetworkImage', 'NetworkImage: https://cdn.example.com/u/42.jpg',
        'HTTP-fetched bitmap; URL is the natural label.'],
    <String>['MemoryImage', 'MemoryImage(94 KB)',
        'In-memory Uint8List; size is the most useful tag.'],
    <String>['FileImage', 'FileImage: /tmp/cache/avatar_42.webp',
        'Disk-backed bitmap; absolute path identifies the source.'],
    <String>['ResizeImage', 'ResizeImage<AssetImage: hero/banner.png>',
        'Wraps another provider; brackets show the inner one.'],
    <String>['ExactAssetImage', 'ExactAssetImage: 2.0x/assets/icon.png',
        'Pinned to a specific density variant of an asset.'],
    <String>['scaled', 'AssetImage: assets/icon.png @ 2.0x',
        'Custom format some teams use to record scale inline.'],
    <String>['null', '(no debugLabel)',
        'Custom providers that forget to set one — show up '
            'as anonymous in DevTools.'],
    <String>['fallback', 'placeholder/checkerboard.png',
        'Used by Image.errorBuilder when the real provider fails.'],
    <String>['SVG-rasterised', 'VectorBitmap<assets/illustration.svg>',
        'Custom debugLabel pattern when an SVG is rasterised '
            'into a ui.Image at a specific scale.'],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '03',
        title: 'debugLabel patterns',
        subtitle: 'Provenance strings that surface in DevTools.',
        gradient: kHeaderDebug,
        icon: Icons.label_important_outline,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'The debugLabel field is a deliberately freeform String?.  Flutter '
        'core providers populate it with a short, readable description of '
        'where the bitmap came from — "AssetImage: assets/logo.png" for an '
        'asset, "NetworkImage: <url>" for a network fetch, and so on.  '
        'Custom providers should follow the same convention so that the '
        'DevTools Images panel can group, filter and dedupe entries.',
      ),
      _proseParagraph(
        'Because debugLabel is nullable, code that consumes it must always '
        'fall back gracefully.  A common pattern is `info.debugLabel ?? '
        '"(unknown)"`.  Layout never reads it: it is purely for human '
        'consumption when triaging "why is this image blurry?" or "which '
        'provider produced this 12 MB bitmap?".',
      ),
      _proseParagraph(
        'The table below collects ten typical debugLabel shapes seen in '
        'real codebases.  Notice that wrapping providers (ResizeImage) '
        'embed the inner provider\'s label inside their own — this lets '
        'you trace a chain of transformations without re-implementing it.',
      ),
      const SizedBox(height: 8),
      _surfaceCard(
        background: kSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.tag, color: kAccentLime, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Common debugLabel shapes',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: List<Widget>.generate(labelRows.length, (int i) {
                final List<String> row = labelRows[i];
                final bool last = i == labelRows.length - 1;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: last ? Colors.transparent : kBorder,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 110,
                        child: Text(
                          row[0],
                          style: const TextStyle(
                            color: kAccentTeal,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          row[1],
                          style: const TextStyle(
                            color: kInk,
                            fontSize: 12.5,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Text(
                          row[2],
                          style: const TextStyle(
                            color: kInkSoft,
                            fontSize: 12.5,
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
      ),
      const SizedBox(height: 14),
      _surfaceCard(
        background: kSurfaceAlt,
        border: kBorderHi,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.lightbulb_outline,
                    color: kAccentAmber, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Tip — make your custom providers searchable',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'When you implement ImageProvider.loadImage / loadBuffer, the '
              'ImageInfo you yield should include a debugLabel that names '
              'BOTH your provider class and the unique key.  Example: '
              '"S3Image: bucket/u/42/avatar.webp@2x".  This pattern lets '
              'DevTools group all images from your provider and lets crash '
              'reports point straight to the failing key.',
              style: TextStyle(
                color: kInkSoft,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — DPR-aware sizing
// ---------------------------------------------------------------------------

Widget _section4DprAware() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '04',
        title: 'DPR + ImageInfo.scale — the full equation',
        subtitle:
            'How devicePixelRatio and scale combine into pixel-perfect paint.',
        gradient: kHeaderDpr,
        icon: Icons.aspect_ratio_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'A Flutter view exposes a devicePixelRatio (DPR) — the number of '
        'physical pixels per logical pixel of the screen.  An ImageInfo '
        'separately reports its OWN scale — the number of physical pixels '
        'per logical pixel of the BITMAP.  When the two match, every '
        'bitmap pixel maps to exactly one screen pixel: pixel-perfect.',
      ),
      _proseParagraph(
        'If the bitmap scale is lower than DPR, the image will be upscaled '
        'on draw, producing softness or visible pixels.  If it is higher, '
        'the bitmap is supersampled — sharp, but wasted memory and bandwidth.  '
        'The asset-resolution machinery in AssetImage exists to pick the '
        'closest scale variant so that ImageInfo.scale matches DPR as '
        'closely as possible.',
      ),
      _proseParagraph(
        'The diagram below ties the two concepts together for a fixed '
        '300 × 200 bitmap on three different displays.  The middle row is '
        'always pixel-perfect; the others illustrate the upscale and '
        'supersample regimes.',
      ),
      const SizedBox(height: 8),
      _dprDiagram(),
    ],
  );
}

Widget _dprDiagram() {
  final List<_DprRow> rows = <_DprRow>[
    const _DprRow(
      device: 'Older Android (mdpi)',
      dpr: 1.0,
      scale: 2.0,
      verdict: 'Supersampled — 4× pixels for 1× display.',
      verdictColor: kWarning,
      gradient: kBitmap1x,
    ),
    const _DprRow(
      device: 'iPhone (Retina)',
      dpr: 2.0,
      scale: 2.0,
      verdict: 'Pixel-perfect — bitmap scale matches DPR.',
      verdictColor: kSuccess,
      gradient: kBitmap2x,
    ),
    const _DprRow(
      device: 'iPhone Pro (xxxhdpi)',
      dpr: 3.0,
      scale: 2.0,
      verdict: 'Upscaled — bitmap is below DPR; expect softness.',
      verdictColor: kDanger,
      gradient: kBitmap3x,
    ),
  ];
  return _surfaceCard(
    background: kSurfaceAlt,
    border: kBorderHi,
    shadow: kShadowMedium,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.devices_other_outlined,
                color: kAccentCyan, size: 18),
            const SizedBox(width: 8),
            const Text(
              '300 × 200 bitmap, scale = 2.0, on three displays',
              style: TextStyle(
                color: kInk,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Column(
          children: List<Widget>.generate(rows.length, (int i) {
            final _DprRow r = rows[i];
            final double effective = (r.scale - r.dpr).abs();
            final bool perfect = effective < 0.001;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _bitmapStandIn(
                    width: 84,
                    height: 56,
                    gradient: r.gradient,
                    overlay: 'scale\n${r.scale}',
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          r.device,
                          style: const TextStyle(
                            color: kInk,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'DPR = ${r.dpr}   ·   info.scale = ${r.scale}   ·   '
                          '${perfect ? "match" : "Δ ${effective.toStringAsFixed(1)}"}',
                          style: const TextStyle(
                            color: kInkSoft,
                            fontSize: 12.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: r.verdictColor.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: r.verdictColor.withValues(alpha: 0.5),
                                width: 1),
                          ),
                          child: Text(
                            r.verdict,
                            style: TextStyle(
                              color: r.verdictColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCanvas,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: const Text(
            '// Pseudocode: when paint runs\n'
            'final double effectivePixels = info.image.width;\n'
            'final double logicalWidth   = effectivePixels / info.scale;\n'
            'final double targetPixels   = logicalWidth * view.devicePixelRatio;\n'
            '// targetPixels == effectivePixels ⇒ pixel-perfect',
            style: TextStyle(
              color: kInk,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

class _DprRow {
  final String device;
  final double dpr;
  final double scale;
  final String verdict;
  final Color verdictColor;
  final LinearGradient gradient;
  const _DprRow({
    required this.device,
    required this.dpr,
    required this.scale,
    required this.verdict,
    required this.verdictColor,
    required this.gradient,
  });
}

// ---------------------------------------------------------------------------
// Section 5 — Lifecycle pipeline
// ---------------------------------------------------------------------------

Widget _section5Lifecycle() {
  final List<_PipeStep> steps = <_PipeStep>[
    const _PipeStep(
      title: 'ImageProvider',
      detail: 'Identity object: knows WHERE bytes live and how to fetch them.',
      icon: Icons.link,
      gradient: kBitmap1x,
    ),
    const _PipeStep(
      title: 'ImageStream',
      detail: 'Long-lived handle: emits decoded frames over time.',
      icon: Icons.stream,
      gradient: kBitmap2x,
    ),
    const _PipeStep(
      title: 'StreamListener',
      detail: 'Subscriber: registered with addListener(...).',
      icon: Icons.notifications_active_outlined,
      gradient: kBitmap3x,
    ),
    const _PipeStep(
      title: 'ImageInfo',
      detail: 'Payload: arrives in the onImage callback.',
      icon: Icons.image_outlined,
      gradient: kBitmapTeal,
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '05',
        title: 'Lifecycle pipeline',
        subtitle: 'From ImageProvider to ImageInfo in four hops.',
        gradient: kHeaderLifecycle,
        icon: Icons.timeline_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'ImageInfo never appears alone — it is always the terminal step of a '
        'four-stage pipeline.  An ImageProvider is the identity ("which '
        'bytes?"), it returns an ImageStream when resolved, an '
        'ImageStreamListener subscribes to that stream, and finally an '
        'ImageInfo arrives in the listener\'s onImage callback together '
        'with a `bool synchronousCall` flag.',
      ),
      _proseParagraph(
        'Understanding this chain is essential when debugging.  If you see '
        'no ImageInfo, the bug is upstream: maybe the provider is wrong, '
        'maybe the stream completed with an error, maybe the listener was '
        'never attached.  ImageInfo itself cannot fail to deliver — it is '
        'just a value object that either arrives or doesn\'t.',
      ),
      _proseParagraph(
        'The diagram below is a horizontal flow with one decorated card '
        'per stage.  Each card explains the role of that stage and how it '
        'hands control to the next.',
      ),
      const SizedBox(height: 8),
      _surfaceCard(
        background: kSurfaceAlt,
        border: kBorderHi,
        shadow: kShadowMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.alt_route, color: kAccentViolet, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Pipeline — four stages, one ImageInfo',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: List<Widget>.generate(steps.length * 2 - 1, (int i) {
                if (i.isOdd) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    child: Icon(Icons.arrow_forward_rounded,
                        color: kAccentViolet, size: 22),
                  );
                }
                final _PipeStep s = steps[i ~/ 2];
                return SizedBox(
                  width: 200,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: s.gradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: kShadowSoft,
                      border: Border.all(
                          color: const Color(0x66FFFFFF), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(s.icon, color: Colors.white, size: 18),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                s.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.detail,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kCanvas,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kBorder, width: 1),
              ),
              child: const Text(
                'final ImageStream stream = provider.resolve(\n'
                '  createLocalImageConfiguration(context),\n'
                ');\n'
                'stream.addListener(ImageStreamListener(\n'
                '  (ImageInfo info, bool synchronousCall) {\n'
                '    // info.image, info.scale, info.debugLabel\n'
                '  },\n'
                '));',
                style: TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _PipeStep {
  final String title;
  final String detail;
  final IconData icon;
  final LinearGradient gradient;
  const _PipeStep({
    required this.title,
    required this.detail,
    required this.icon,
    required this.gradient,
  });
}

// ---------------------------------------------------------------------------
// Section 6 — Recipes
// ---------------------------------------------------------------------------

Widget _section6Recipes() {
  final List<_Recipe> recipes = <_Recipe>[
    const _Recipe(
      title: 'Precache a hero image',
      goal: 'Avoid the loading flash on a route transition.',
      body:
          'Call precacheImage(provider, context).  Internally it resolves the '
          'ImageStream and waits for the first ImageInfo.  By the time you '
          'push the route, the bitmap is already cached — the next Image '
          'widget that uses the same provider receives the cached ImageInfo '
          'synchronously.',
      gradient: kBitmap1x,
      glow: kShadowCyanGlow,
      labelLine: 'debugLabel: AssetImage: hero/banner.png',
    ),
    const _Recipe(
      title: 'Low-res placeholder swap',
      goal: 'Show a tiny blurry version, then swap to high-res.',
      body:
          'Two providers, two ImageInfos.  The placeholder ImageInfo arrives '
          'first with scale = 1.0 (small bitmap, large logical footprint = '
          'blurry).  When the second ImageInfo arrives with scale = 3.0 '
          '(large bitmap, same logical footprint = sharp), Image swaps '
          'frames and crossfades.',
      gradient: kBitmap2x,
      glow: kShadowMagentaGlow,
      labelLine: 'debugLabel: NetworkImage: cdn/photo_full.jpg',
    ),
    const _Recipe(
      title: 'Trace a noisy provider',
      goal: 'Find which provider is producing 10 MB bitmaps.',
      body:
          'Open DevTools → Images.  Each row shows the ImageInfo.debugLabel '
          'and decoded byte size.  Sort by size, click into the offender, '
          'and the debugLabel tells you exactly which provider key created '
          'it.  No log statements required.',
      gradient: kBitmap3x,
      glow: kShadowAmberGlow,
      labelLine: 'debugLabel: NetworkImage: api/heavy_asset.png',
    ),
    const _Recipe(
      title: 'Compute logical size on demand',
      goal: 'Fit content around an image before laying it out.',
      body:
          'Given an ImageInfo, compute Size(image.width / scale, '
          'image.height / scale).  This is what the framework does '
          'internally for unsized Image widgets.  Use it when you need to '
          'reserve space, build a custom layout, or run a manual '
          'aspect-ratio check.',
      gradient: kBitmapTeal,
      glow: kShadowCyanGlow,
      labelLine: 'debugLabel: AssetImage: gallery/photo_07.jpg',
    ),
    const _Recipe(
      title: 'Cross-fade with isCloneOf',
      goal: 'Skip the fade when both frames refer to the same bitmap.',
      body:
          'ImageInfo exposes isCloneOf(other).  If your custom Image widget '
          'compares the new ImageInfo to the previous one and both report '
          'true, you can skip the cross-fade animation entirely — the user '
          'would see no change anyway, and you save a frame.',
      gradient: kBitmapLime,
      glow: kShadowLimeGlow,
      labelLine: 'debugLabel: ResizeImage<AssetImage: a.png>',
    ),
    const _Recipe(
      title: 'Custom error fallback',
      goal: 'Surface a useful message when decoding fails.',
      body:
          'In ImageStreamListener, alongside onImage you can pass onError.  '
          'When it fires, the failed provider\'s identity is in the stack '
          'trace, but you can also look at the LAST successful ImageInfo '
          'and reuse its debugLabel to tell the user "couldn\'t reload '
          'AssetImage: hero/banner.png".',
      gradient: kBitmapViolet,
      glow: kShadowMagentaGlow,
      labelLine: 'debugLabel: AssetImage: hero/banner.png',
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '06',
        title: 'Practical recipes',
        subtitle: 'Six real-world places ImageInfo earns its keep.',
        gradient: kHeaderRecipes,
        icon: Icons.menu_book_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'In day-to-day Flutter work, you rarely construct an ImageInfo '
        'yourself.  You consume them — in onImage callbacks, in custom '
        'paint code that draws via Canvas.drawImage, in test mocks that '
        'pretend a provider has resolved.  The recipes below show six of '
        'the most common consumption patterns.',
      ),
      _proseParagraph(
        'Notice how often debugLabel appears: it is the connecting thread '
        'across crash reports, DevTools, and custom error UIs.  Even when '
        'you do not need scale or image, debugLabel is the quickest path '
        'from a bug report back to the failing provider.',
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: List<Widget>.generate(recipes.length, (int i) {
          final _Recipe r = recipes[i];
          return SizedBox(
            width: 320,
            child: _surfaceCard(
              background: kSurface,
              border: kBorder,
              shadow: kShadowSoft,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: r.gradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: r.glow,
                      border: Border.all(
                          color: const Color(0x66FFFFFF), width: 1),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      r.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Goal: ${r.goal}',
                    style: const TextStyle(
                      color: kAccentLime,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    r.body,
                    style: const TextStyle(
                      color: kInkSoft,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: kCanvas,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kBorder, width: 1),
                    ),
                    child: Text(
                      r.labelLine,
                      style: const TextStyle(
                        color: kAccentAmber,
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ],
  );
}

class _Recipe {
  final String title;
  final String goal;
  final String body;
  final LinearGradient gradient;
  final List<BoxShadow> glow;
  final String labelLine;
  const _Recipe({
    required this.title,
    required this.goal,
    required this.body,
    required this.gradient,
    required this.glow,
    required this.labelLine,
  });
}

// ---------------------------------------------------------------------------
// Section 7 — Footguns
// ---------------------------------------------------------------------------

Widget _section7Footguns() {
  final List<_Footgun> guns = <_Footgun>[
    const _Footgun(
      title: 'Comparing across scales without normalising',
      bad:
          'if (a.image.width == b.image.width) sameSize();',
      good:
          'if (a.image.width / a.scale == b.image.width / b.scale) sameSize();',
      explain:
          'Pixel widths are not comparable until you divide by scale.  Two '
          'ImageInfos can have wildly different image.width values yet '
          'paint at the exact same logical size.  Always compare in '
          'logical pixels.',
      gradient: kBitmap1x,
      severity: kDanger,
    ),
    const _Footgun(
      title: 'Forgetting that image is a ui.Image',
      bad:
          'final ImageInfo info = ...;\n// info goes out of scope, never disposed.',
      good:
          'info.dispose(); // releases the ui.Image when the last clone is gone.',
      explain:
          'image is a GPU-backed handle, not a plain object.  Until it is '
          'disposed, the texture occupies VRAM.  Hold onto an ImageInfo for '
          'longer than necessary and you slowly leak GPU memory.  Dispose '
          'when you are sure no listener still needs the bitmap.',
      gradient: kBitmap2x,
      severity: kWarning,
    ),
    const _Footgun(
      title: 'Losing debugLabel in custom providers',
      bad:
          'return ImageInfo(image: img, scale: 2.0); // debugLabel: null',
      good:
          'return ImageInfo(\n'
          '  image: img,\n'
          '  scale: 2.0,\n'
          '  debugLabel: "S3Image: bucket/" + key,\n'
          ');',
      explain:
          'A null debugLabel makes your provider invisible in DevTools.  '
          'Always set one — even a fixed string is better than null '
          'because it lets DevTools group entries by source.',
      gradient: kBitmap3x,
      severity: kWarning,
    ),
    const _Footgun(
      title: 'Treating scale = 0 as valid',
      bad:
          'final info = ImageInfo(image: img, scale: 0);',
      good:
          'assert(scale > 0);\nfinal info = ImageInfo(image: img, scale: 1);',
      explain:
          'Scale must be strictly positive — division by zero in the '
          'paint code will produce Infinity or NaN sizes and crash layout.  '
          'If a configuration ever hands you scale = 0, treat it as a bug '
          'and substitute 1.0 with a logged warning.',
      gradient: kBitmapTeal,
      severity: kDanger,
    ),
    const _Footgun(
      title: 'Mutating fields you assumed were not final',
      bad:
          'info.scale = 2.0; // does not compile — scale is final.',
      good:
          'final next = ImageInfo(\n'
          '  image: info.image.clone(),\n'
          '  scale: 2.0,\n'
          '  debugLabel: info.debugLabel,\n'
          ');',
      explain:
          'ImageInfo is immutable.  If you need different scale or label, '
          'construct a new ImageInfo, clone() the underlying ui.Image '
          '(reference-counted), and dispose the old one when you are '
          'done with it.',
      gradient: kBitmapLime,
      severity: kWarning,
    ),
    const _Footgun(
      title: 'Holding ImageInfo past widget disposal',
      bad:
          'class _State extends State<X> {\n'
          '  ImageInfo? cached; // never released on dispose.\n'
          '}',
      good:
          '@override\nvoid dispose() {\n  cached?.dispose();\n  cached = null;\n  super.dispose();\n}',
      explain:
          'A captured ImageInfo will keep its ui.Image alive even after '
          'your widget is gone.  Always dispose in your State.dispose '
          'override (or the equivalent for your custom controller).',
      gradient: kBitmapViolet,
      severity: kDanger,
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '07',
        title: 'Footguns',
        subtitle: 'Six recurring ways teams misuse ImageInfo.',
        gradient: kHeaderFootguns,
        icon: Icons.warning_amber_outlined,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'ImageInfo is small, but each of its three fields hides a sharp '
        'edge.  The collection below is drawn from real production '
        'incidents — texture leaks, mysteriously blurry images, '
        'untraceable bug reports.  Each card pairs a "bad" snippet with '
        'a "good" one and explains the failure mode in human terms.',
      ),
      _proseParagraph(
        'A common thread: ImageInfo is a value object, but its image '
        'field is not.  The discipline ImageInfo demands is the same '
        'discipline any code holding a ui.Image demands — be explicit '
        'about ownership, dispose when done, and never assume two '
        'objects refer to "the same image" without calling isCloneOf.',
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: List<Widget>.generate(guns.length, (int i) {
          final _Footgun g = guns[i];
          return SizedBox(
            width: 360,
            child: _surfaceCard(
              background: kSurface,
              border: kBorder,
              padding: const EdgeInsets.all(16),
              shadow: kShadowSoft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 30,
                        decoration: BoxDecoration(
                          color: g.severity,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          g.title,
                          style: const TextStyle(
                            color: kInk,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _bitmapStandIn(
                    width: double.infinity,
                    height: 30,
                    gradient: g.gradient,
                  ),
                  const SizedBox(height: 12),
                  _codeBlock('// BAD', g.bad, kDanger),
                  const SizedBox(height: 8),
                  _codeBlock('// GOOD', g.good, kSuccess),
                  const SizedBox(height: 10),
                  Text(
                    g.explain,
                    style: const TextStyle(
                      color: kInkSoft,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ],
  );
}

Widget _codeBlock(String header, String body, Color tone) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kCanvas,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tone.withValues(alpha: 0.4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          header,
          style: TextStyle(
            color: tone,
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: const TextStyle(
            color: kInk,
            fontSize: 12,
            fontFamily: 'monospace',
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _Footgun {
  final String title;
  final String bad;
  final String good;
  final String explain;
  final LinearGradient gradient;
  final Color severity;
  const _Footgun({
    required this.title,
    required this.bad,
    required this.good,
    required this.explain,
    required this.gradient,
    required this.severity,
  });
}

// ---------------------------------------------------------------------------
// Section 8 — ImageInfo vs ImageProvider
// ---------------------------------------------------------------------------

Widget _section8VsImageProvider() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '08',
        title: 'ImageProvider vs ImageInfo',
        subtitle: 'Intent vs outcome — the two halves of image loading.',
        gradient: kHeaderCompare,
        icon: Icons.compare_arrows,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'Beginners often conflate ImageProvider and ImageInfo because both '
        'show up around image loading.  They are opposites.  ImageProvider '
        'is the INTENT — a small identity object that says "fetch the bytes '
        'at this URL / asset / file path".  ImageInfo is the OUTCOME — a '
        'value object delivered AFTER decoding, carrying the resulting '
        'ui.Image plus its density and provenance.',
      ),
      _proseParagraph(
        'You hold an ImageProvider for as long as the WIDGET that references '
        'the image lives.  You hold an ImageInfo only as long as you '
        'actively need to PAINT or INSPECT the bitmap.  ImageProvider is '
        'cheap and re-creatable; ImageInfo is heavy because of its embedded '
        'GPU texture and must be disposed.',
      ),
      _proseParagraph(
        'The side-by-side cards below contrast the two.  Use this as a '
        'quick decision aid: if you are configuring "where", you want '
        'ImageProvider; if you are reacting to "what arrived", you want '
        'ImageInfo.',
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _comparisonCard(
              title: 'ImageProvider',
              role: 'INTENT',
              roleColor: kAccentSky,
              gradient: kBitmap1x,
              bullets: const <String>[
                'Identity: knows where to find the bytes.',
                'Cheap to construct; small object.',
                'Configured ONCE per widget.',
                'Compared by `==` to share cache entries.',
                'Subclasses: AssetImage, NetworkImage, FileImage, MemoryImage.',
                'Method: resolve(ImageConfiguration) → ImageStream.',
              ],
              footer: 'Lives as long as the widget.',
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _comparisonCard(
              title: 'ImageInfo',
              role: 'OUTCOME',
              roleColor: kAccentMagenta,
              gradient: kBitmap2x,
              bullets: const <String>[
                'Payload: carries the decoded bitmap.',
                'Heavy: contains a GPU-backed ui.Image.',
                'Delivered MULTIPLE times for animated images.',
                'Compared by isCloneOf for identity.',
                'Fields: image, scale, debugLabel — all final.',
                'Method: dispose() releases the ui.Image.',
              ],
              footer: 'Lives only while a listener still needs it.',
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _comparisonCard({
  required String title,
  required String role,
  required Color roleColor,
  required LinearGradient gradient,
  required List<String> bullets,
  required String footer,
}) {
  return _surfaceCard(
    background: kSurface,
    border: kBorder,
    padding: const EdgeInsets.all(18),
    shadow: kShadowMedium,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: const Color(0x66FFFFFF), width: 1),
            boxShadow: kShadowSoft,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: _badge(role, color: roleColor),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(bullets.length, (int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.fiber_manual_record,
                      size: 8, color: roleColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      bullets[i],
                      style: const TextStyle(
                        color: kInk,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kCanvas,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.schedule, size: 14, color: kInkFaint),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  footer,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — API summary
// ---------------------------------------------------------------------------

Widget _section9ApiSummary() {
  const List<List<String>> apiRows = <List<String>>[
    <String>['ImageInfo', 'constructor',
        'ImageInfo({required image, scale = 1.0, debugLabel})'],
    <String>['image', 'final ui.Image',
        'The decoded bitmap; physical pixel size.'],
    <String>['scale', 'final double',
        'Physical pixels per logical pixel.  Default 1.0.'],
    <String>['debugLabel', 'final String?',
        'Diagnostic name; null is allowed but discouraged.'],
    <String>['sizeBytes', 'int',
        'Approximate decoded byte cost (image bytes).'],
    <String>['clone()', 'ImageInfo',
        'Returns a new ImageInfo whose ui.Image is a clone.'],
    <String>['isCloneOf(other)', 'bool',
        'True if both ImageInfos refer to the same source image.'],
    <String>['dispose()', 'void',
        'Disposes the underlying ui.Image (ref-counted).'],
    <String>['toString()', 'String',
        'Includes debugLabel + scale + image dimensions.'],
    <String>['ImageStreamListener', 'class',
        'Receives ImageInfo via onImage(info, synchronousCall).'],
    <String>['precacheImage', 'top-level fn',
        'Resolves a provider eagerly; awaits the first ImageInfo.'],
    <String>['paintImage', 'top-level fn',
        'Paints an ImageInfo.image into a Canvas with a Rect.'],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        index: '09',
        title: 'API summary',
        subtitle: 'ImageInfo and the symbols that surround it.',
        gradient: kHeaderApi,
        icon: Icons.menu_open,
      ),
      const SizedBox(height: 14),
      _proseParagraph(
        'The table below collects ImageInfo\'s own surface plus the most '
        'commonly co-occurring API symbols.  Treat it as a cheat sheet: '
        'when you encounter one of these in stack traces or DevTools, you '
        'know roughly what role it plays in the loading pipeline.',
      ),
      const SizedBox(height: 8),
      _surfaceCard(
        background: kSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.fact_check_outlined,
                    color: kAccentCyan, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Symbols at a glance',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: List<Widget>.generate(apiRows.length, (int i) {
                final List<String> row = apiRows[i];
                final bool last = i == apiRows.length - 1;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: last ? Colors.transparent : kBorder,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        child: Text(
                          row[0],
                          style: const TextStyle(
                            color: kAccentCyan,
                            fontSize: 12.5,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: Text(
                          row[1],
                          style: const TextStyle(
                            color: kAccentAmber,
                            fontSize: 12,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row[2],
                          style: const TextStyle(
                            color: kInkSoft,
                            fontSize: 12.5,
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
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Construction attempt — wrapped in try/catch, badged result.
// ---------------------------------------------------------------------------

Widget _constructionAttempt() {
  String status;
  Color statusColor;
  String detail;
  try {
    // We deliberately do NOT construct a real ui.Image here — that requires
    // async decoding which is forbidden in this build.  Instead we record
    // that construction was skipped on purpose.
    final ui.Image? maybe = null;
    if (maybe == null) {
      throw StateError('No ui.Image available in offline demo');
    }
    // Unreachable; left to satisfy the analyzer about the import.
    final ImageInfo info = ImageInfo(
      image: maybe,
      scale: 2.0,
      debugLabel: 'demo',
    );
    status = 'Constructed';
    statusColor = kSuccess;
    detail = 'ImageInfo built with scale=${info.scale}, '
        'debugLabel=${info.debugLabel}.';
  } catch (_) {
    status = 'Skipped (offline)';
    statusColor = kWarning;
    detail = 'A ui.Image cannot be synthesised in this interpreter '
        'without async decoding.  The demo therefore renders ImageInfo '
        'configurations as labelled stand-ins instead of constructing '
        'real instances.';
  }

  return _surfaceCard(
    background: kSurfaceAlt,
    border: kBorderHi,
    shadow: kShadowMedium,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.science_outlined, color: kAccentTeal, size: 18),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Live construction attempt',
                style: TextStyle(
                  color: kInk,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _badge(status, color: statusColor),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          detail,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

Widget _footerCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0B2A4A),
          Color(0xFF1F4E78),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: kShadowMedium,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flag_outlined, color: kAccentLime, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'ImageInfo bundles three immutable fields — image, scale, '
          'debugLabel — into a value object delivered by '
          'ImageStreamListener.onImage.  scale converts physical pixels to '
          'logical pixels; debugLabel keeps DevTools and crash reports '
          'honest; image is a GPU-backed ui.Image that must be disposed.  '
          'Treat ImageInfo as the OUTCOME of an ImageProvider\'s INTENT '
          'and you will reach for the right tool every time.',
          style: TextStyle(
            color: Color(0xFFE3F2FF),
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}
