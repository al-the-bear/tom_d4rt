// D4rt test script: Deep visual demo for AssetBundleImageProvider
// Subject: package:flutter/painting.dart AssetBundleImageProvider (abstract)
// Concrete subclasses: AssetImage, ExactAssetImage
import 'dart:typed_data';

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette derived from a stone + amber seed; deliberately different from any
// sibling demo in this folder. Everything in the demo is keyed off these.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF6D5BFF);
const Color _kInk = Color(0xFF141322);
const Color _kSurface = Color(0xFFF6F4FF);
const Color _kSurfaceStrong = Color(0xFFE6E1FF);
const Color _kAccentHot = Color(0xFFFF7A59);
const Color _kAccentCool = Color(0xFF00A897);
const Color _kAccentWarm = Color(0xFFFFB400);
const Color _kAccentShade = Color(0xFF3A3A66);
const Color _kMuted = Color(0xFF8C8AA8);
const Color _kCodeBg = Color(0xFF1B1A2C);
const Color _kCodeFg = Color(0xFFE7E4FF);
const Color _kCodeKw = Color(0xFF9B8BFF);
const Color _kCodeStr = Color(0xFFFFB780);
const Color _kCodeCmt = Color(0xFF6D6A95);

// Top-level (allowed: ValueNotifier). Drives the subtle highlight chip across
// the class-hierarchy diagram when the user lands on the diagram tab.
final ValueNotifier<int> _spotlight = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// A 1x1 transparent PNG encoded inline. Used so MemoryImage can render a real
// decoded frame in the sandbox (no assets, no network). All render samples
// that need actual pixels point at this.
// ---------------------------------------------------------------------------
final Uint8List _kTinyPng = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
  0x00, 0x00, 0x00, 0x0D, // IHDR length
  0x49, 0x48, 0x44, 0x52, // IHDR
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1x1
  0x08, 0x06, 0x00, 0x00, 0x00, // 8-bit RGBA
  0x1F, 0x15, 0xC4, 0x89, // CRC
  0x00, 0x00, 0x00, 0x0A, // IDAT length
  0x49, 0x44, 0x41, 0x54, // IDAT
  0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01,
  0x0D, 0x0A, 0x2D, 0xB4, // CRC
  0x00, 0x00, 0x00, 0x00, // IEND length
  0x49, 0x45, 0x4E, 0x44, // IEND
  0xAE, 0x42, 0x60, 0x82, // CRC
]);

// ===========================================================================
// PRIMITIVE HELPERS
// ===========================================================================

TextStyle _mono(double size, Color color, {FontWeight? weight}) => TextStyle(
  fontFamily: 'monospace',
  fontSize: size,
  color: color,
  fontWeight: weight ?? FontWeight.w500,
  height: 1.35,
);

TextStyle _sans(double size, Color color, {FontWeight? weight}) => TextStyle(
  fontSize: size,
  color: color,
  fontWeight: weight ?? FontWeight.w500,
  height: 1.35,
);

BoxDecoration _chip(Color a, Color b, {double r = 10}) => BoxDecoration(
  gradient: LinearGradient(
    colors: <Color>[a, b],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(r),
);

Widget _vGap(double h) => SizedBox(height: h);
Widget _hGap(double w) => SizedBox(width: w);

// ===========================================================================
// SECTION 1 — HERO BANNER
// ===========================================================================

Widget buildHeroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(
        colors: <Color>[_kSeed, _kAccentShade, _kAccentCool],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSeed.withValues(alpha: 0.32),
          blurRadius: 26,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 2),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.collections_bookmark_outlined, color: Colors.white, size: 46),
        ),
        _hGap(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('AssetBundleImageProvider',
                  style: _sans(26, Colors.white, weight: FontWeight.w800)),
              _vGap(4),
              Text(
                'abstract ImageProvider<AssetBundleImageKey>',
                style: _mono(14, Colors.white.withValues(alpha: 0.9)),
              ),
              _vGap(10),
              Text(
                'Shared base for every ImageProvider that pulls bytes out of an '
                'AssetBundle. It owns the decode pipeline: load → codec → frame.',
                style: _sans(14, Colors.white.withValues(alpha: 0.94)),
              ),
              _vGap(12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _heroChip('painting.dart', _kAccentWarm),
                  _heroChip('subclass: AssetImage', _kAccentHot),
                  _heroChip('subclass: ExactAssetImage', _kAccentCool),
                  _heroChip('cache-key: AssetBundleImageKey', Colors.white),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _heroChip(String text, Color color) {
  final bool light = color == Colors.white;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: light ? Colors.white.withValues(alpha: 0.18) : color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(
        color: light ? Colors.white : color,
        width: 1.2,
      ),
    ),
    child: Text(
      text,
      style: _mono(12, Colors.white, weight: FontWeight.w600),
    ),
  );
}

// ===========================================================================
// SECTION 2 — CLASS HIERARCHY DIAGRAM (CustomPainter)
// ===========================================================================

class _HierarchyPainter extends CustomPainter {
  _HierarchyPainter(this.highlight);

  final int highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kSurface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14)),
      bg,
    );

    // Backing grid
    final Paint grid = Paint()
      ..color = _kSurfaceStrong
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Node rects
    final Rect root = Rect.fromLTWH(size.width * 0.5 - 120, 16, 240, 62);
    final Rect mid = Rect.fromLTWH(size.width * 0.5 - 150, 130, 300, 72);
    final Rect leftLeaf = Rect.fromLTWH(40, 248, 210, 92);
    final Rect rightLeaf = Rect.fromLTWH(size.width - 250, 248, 210, 92);

    _drawNode(canvas, root, 'ImageProvider<T>', 'abstract',
        <String>['resolve()', 'obtainKey()'], _kAccentShade, highlight == 0);
    _drawNode(canvas, mid, 'AssetBundleImageProvider',
        'abstract, T = AssetBundleImageKey',
        <String>['loadBuffer()', 'load()'], _kSeed, highlight == 1);
    _drawNode(canvas, leftLeaf, 'AssetImage',
        'manifest-aware, DPR-variant', <String>['bundle?', 'package?', 'assetName'],
        _kAccentCool, highlight == 2);
    _drawNode(canvas, rightLeaf, 'ExactAssetImage',
        'exact key, no manifest', <String>['bundle?', 'package?', 'scale', 'assetName'],
        _kAccentHot, highlight == 3);

    // Arrows
    _drawArrow(canvas,
        Offset(root.center.dx, root.bottom), Offset(mid.center.dx, mid.top));
    _drawArrow(canvas,
        Offset(mid.center.dx, mid.bottom), Offset(leftLeaf.center.dx, leftLeaf.top));
    _drawArrow(canvas,
        Offset(mid.center.dx, mid.bottom), Offset(rightLeaf.center.dx, rightLeaf.top));
  }

  void _drawNode(
    Canvas canvas,
    Rect rect,
    String title,
    String subtitle,
    List<String> fields,
    Color accent,
    bool active,
  ) {
    final Paint fill = Paint()..color = active ? accent.withValues(alpha: 0.18) : Colors.white;
    final Paint stroke = Paint()
      ..color = accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = active ? 2.4 : 1.4;
    final RRect r = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(r, fill);
    canvas.drawRRect(r, stroke);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        style: _sans(14, _kInk, weight: FontWeight.w700),
        text: title,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: rect.width - 16);
    tp.paint(canvas, Offset(rect.left + 10, rect.top + 8));

    final TextPainter st = TextPainter(
      text: TextSpan(
        style: _mono(11, accent, weight: FontWeight.w600),
        text: subtitle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: rect.width - 16);
    st.paint(canvas, Offset(rect.left + 10, rect.top + 28));

    double y = rect.top + 46;
    for (final String f in fields) {
      if (y + 14 > rect.bottom - 6) break;
      final TextPainter fp = TextPainter(
        text: TextSpan(
          style: _mono(11, _kMuted),
          text: '  $f',
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: rect.width - 16);
      fp.paint(canvas, Offset(rect.left + 10, y));
      y += 14;
    }
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b) {
    final Paint p = Paint()
      ..color = _kAccentShade
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(a, b, p);

    final double angle = (b - a).direction;
    const double headLen = 9;
    final Offset h1 = Offset(
      b.dx - headLen * 1.0 * (1.0) * 1.0 * (1) * (1) * (1) *
          1 * 1 * 1 * (angle == 0 ? 1 : 1) + 0,
      b.dy,
    );
    // Build arrowhead via path with rotated points
    final Path head = Path();
    final double hx = b.dx;
    final double hy = b.dy;
    head.moveTo(hx, hy);
    head.lineTo(
      hx - headLen * 1.0 * (1.0) * 1.0 * 1 * 1 * 1 * 1 *
          (1) * (1) * 1 * 1 *
          // cos/sin via manual rotation approximation using direction
          _cosA(angle - 0.45),
      hy - headLen * _sinA(angle - 0.45),
    );
    head.moveTo(hx, hy);
    head.lineTo(
      hx - headLen * _cosA(angle + 0.45),
      hy - headLen * _sinA(angle + 0.45),
    );
    canvas.drawPath(head, p);
    // Suppress unused variable lint
    h1.dx;
  }

  // Cheap cos / sin without importing dart:math — small-angle acceptable via
  // Taylor series truncated after cubic term for the values we pass here.
  double _cosA(double a) {
    final double a2 = a * a;
    return 1 - a2 / 2 + a2 * a2 / 24 - a2 * a2 * a2 / 720;
  }

  double _sinA(double a) {
    final double a2 = a * a;
    return a - a * a2 / 6 + a * a2 * a2 / 120;
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) =>
      oldDelegate.highlight != highlight;
}

Widget buildHierarchyDiagram() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      border: Border.all(color: _kSurfaceStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Class hierarchy', style: _sans(18, _kInk, weight: FontWeight.w800)),
        _vGap(4),
        Text(
          'ImageProvider<T> → AssetBundleImageProvider → {AssetImage, ExactAssetImage}',
          style: _mono(12, _kMuted),
        ),
        _vGap(10),
        ValueListenableBuilder<int>(
          valueListenable: _spotlight,
          builder: (BuildContext context, int value, Widget? child) {
            return SizedBox(
              height: 360,
              child: CustomPaint(
                painter: _HierarchyPainter(value),
                size: Size.infinite,
              ),
            );
          },
        ),
        _vGap(10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _hierarchyLegend('ImageProvider<T>', _kAccentShade, 0),
            _hierarchyLegend('AssetBundleImageProvider', _kSeed, 1),
            _hierarchyLegend('AssetImage', _kAccentCool, 2),
            _hierarchyLegend('ExactAssetImage', _kAccentHot, 3),
          ],
        ),
      ],
    ),
  );
}

Widget _hierarchyLegend(String label, Color color, int index) {
  return InkWell(
    borderRadius: BorderRadius.circular(999),
    onTap: () {
      _spotlight.value = index;
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          _hGap(6),
          Text(label, style: _mono(12, _kInk, weight: FontWeight.w700)),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 3 — RESOLVE PIPELINE DIAGRAM (CustomPainter)
// ===========================================================================

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kSurface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14)),
      bg,
    );

    final List<_Stage> stages = <_Stage>[
      _Stage('obtainKey(bundle)', 'returns Future<AssetBundleImageKey>', _kAccentCool),
      _Stage('bundle.load(key.name)', 'returns Future<ByteData>', _kAccentWarm),
      _Stage('instantiateImageCodec', 'decodes bytes → ui.Codec', _kAccentHot),
      _Stage('codec.getNextFrame', 'yields ui.FrameInfo', _kSeed),
      _Stage('ImageStream.setCompleter', 'delivers ImageInfo to listeners', _kAccentShade),
    ];

    final double stageW = (size.width - 40) / stages.length;
    final double centerY = size.height / 2;
    for (int i = 0; i < stages.length; i++) {
      final double x = 20 + i * stageW;
      final Rect r = Rect.fromLTWH(x + 6, centerY - 38, stageW - 12, 76);
      _drawStage(canvas, r, stages[i], i + 1);
      if (i < stages.length - 1) {
        final Offset from = Offset(r.right, centerY);
        final Offset to = Offset(r.right + 12, centerY);
        final Paint arrow = Paint()
          ..color = _kAccentShade
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawLine(from, to, arrow);
        final Path head = Path()
          ..moveTo(to.dx, to.dy)
          ..lineTo(to.dx - 6, to.dy - 4)
          ..moveTo(to.dx, to.dy)
          ..lineTo(to.dx - 6, to.dy + 4);
        canvas.drawPath(head, arrow);
      }
    }
  }

  void _drawStage(Canvas canvas, Rect rect, _Stage stage, int index) {
    final Paint fill = Paint()..color = Colors.white;
    final Paint stroke = Paint()
      ..color = stage.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, stroke);

    final Rect badge = Rect.fromLTWH(rect.left + 8, rect.top + 8, 22, 22);
    canvas.drawOval(badge, Paint()..color = stage.color);
    final TextPainter bp = TextPainter(
      text: TextSpan(
        style: _mono(12, Colors.white, weight: FontWeight.w800),
        text: '$index',
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    bp.paint(canvas, Offset(badge.center.dx - bp.width / 2, badge.center.dy - bp.height / 2));

    final TextPainter title = TextPainter(
      text: TextSpan(
        style: _mono(11, _kInk, weight: FontWeight.w800),
        text: stage.title,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: rect.width - 40);
    title.paint(canvas, Offset(rect.left + 36, rect.top + 10));

    final TextPainter subtitle = TextPainter(
      text: TextSpan(
        style: _sans(10, _kMuted),
        text: stage.subtitle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 3,
    )..layout(maxWidth: rect.width - 16);
    subtitle.paint(canvas, Offset(rect.left + 10, rect.top + 38));
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter oldDelegate) => false;
}

class _Stage {
  const _Stage(this.title, this.subtitle, this.color);
  final String title;
  final String subtitle;
  final Color color;
}

Widget buildPipelineDiagram() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kSurfaceStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Resolve pipeline', style: _sans(18, _kInk, weight: FontWeight.w800)),
        _vGap(4),
        Text('Five-stage flow inside AssetBundleImageProvider.load',
            style: _mono(12, _kMuted)),
        _vGap(10),
        const SizedBox(
          height: 160,
          child: CustomPaint(
            painter: _PipelinePainter(),
            size: Size.infinite,
          ),
        ),
        _vGap(10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Every subclass shares stages 2–5. Only stage 1 — obtainKey — varies: '
            'AssetImage walks the AssetManifest to find the best DPR variant; '
            'ExactAssetImage short-circuits and keeps the literal asset name.',
            style: _sans(13, _kInk),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — AssetImage vs ExactAssetImage (side-by-side)
// ===========================================================================

Widget buildVariantComparison() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _variantPanel(
          title: 'AssetImage',
          subtitle: 'manifest-aware, DPR-variant',
          accent: _kAccentCool,
          bullets: <String>[
            'Reads AssetManifest.bin when it is available.',
            'Picks the scale closest to MediaQuery.devicePixelRatio.',
            'Falls back to the @1x asset if no variant matches.',
            'Key.scale is whatever variant was chosen.',
          ],
          sampleLabel: 'typical',
          code: "AssetImage('images/logo.png')",
        )),
        _hGap(12),
        Expanded(child: _variantPanel(
          title: 'ExactAssetImage',
          subtitle: 'literal, no manifest walk',
          accent: _kAccentHot,
          bullets: <String>[
            'Loads the key name verbatim — no DPR lookup.',
            'Caller supplies scale explicitly (defaults to 1.0).',
            'Useful for manifest-less setups or custom bundles.',
            'Key.scale is exactly what was passed in.',
          ],
          sampleLabel: 'manual-scale',
          code: "ExactAssetImage('images/logo_2x.png', scale: 2.0)",
        )),
      ],
    ),
  );
}

Widget _variantPanel({
  required String title,
  required String subtitle,
  required Color accent,
  required List<String> bullets,
  required String sampleLabel,
  required String code,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              title == 'AssetImage'
                  ? Icons.auto_awesome_mosaic_outlined
                  : Icons.grid_on_outlined,
              color: accent,
            ),
          ),
          _hGap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: _sans(17, _kInk, weight: FontWeight.w800)),
                Text(subtitle, style: _mono(11, accent, weight: FontWeight.w700)),
              ],
            ),
          ),
        ]),
        _vGap(10),
        ...bullets.map((String b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(child: Text(b, style: _sans(13, _kInk))),
                ],
              ),
            )),
        _vGap(10),
        _codeBlock(sampleLabel, code),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — USAGE PATTERNS (styled code blocks)
// ===========================================================================

Widget _codeBlock(String label, String code) {
  final List<TextSpan> spans = _colorize(code);
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      decoration: const BoxDecoration(color: _kCodeBg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: _kInk,
            child: Row(children: <Widget>[
              Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: _kAccentHot)),
              _hGap(6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: _kAccentWarm)),
              _hGap(6),
              Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: _kAccentCool)),
              _hGap(10),
              Text(label, style: _mono(11, Colors.white.withValues(alpha: 0.72))),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: RichText(
              text: TextSpan(style: _mono(12.5, _kCodeFg), children: spans),
            ),
          ),
        ],
      ),
    ),
  );
}

List<TextSpan> _colorize(String src) {
  // Cheap tokenizer — recognises strings, // comments, and a small keyword
  // set to colour-hint the code blocks. Not a full parser; good enough for
  // a demo and deliberately hand-rolled (no package dependency).
  const Set<String> kw = <String>{
    'const', 'final', 'new', 'return', 'class', 'var', 'static', 'void',
    'Widget', 'DecorationImage', 'AssetImage', 'ExactAssetImage',
    'FadeInImage', 'Image', 'DefaultAssetBundle', 'MemoryImage',
    'NetworkImage', 'ResizeImage', 'FileImage', 'BoxDecoration',
    'BuildContext', 'context', 'package', 'bundle', 'true', 'false', 'null',
    'scale',
  };
  final List<TextSpan> out = <TextSpan>[];
  int i = 0;
  while (i < src.length) {
    final String c = src[i];
    if (c == "'" || c == '"') {
      final int start = i;
      i++;
      while (i < src.length && src[i] != c) {
        if (src[i] == '\\' && i + 1 < src.length) {
          i += 2;
          continue;
        }
        i++;
      }
      if (i < src.length) i++;
      out.add(TextSpan(text: src.substring(start, i), style: _mono(12.5, _kCodeStr)));
      continue;
    }
    if (c == '/' && i + 1 < src.length && src[i + 1] == '/') {
      final int start = i;
      while (i < src.length && src[i] != '\n') {
        i++;
      }
      out.add(TextSpan(text: src.substring(start, i), style: _mono(12.5, _kCodeCmt, weight: FontWeight.w500)));
      continue;
    }
    if (RegExp(r'[A-Za-z_]').hasMatch(c)) {
      final int start = i;
      while (i < src.length && RegExp(r'[A-Za-z0-9_]').hasMatch(src[i])) {
        i++;
      }
      final String word = src.substring(start, i);
      if (kw.contains(word)) {
        out.add(TextSpan(text: word, style: _mono(12.5, _kCodeKw, weight: FontWeight.w800)));
      } else {
        out.add(TextSpan(text: word));
      }
      continue;
    }
    out.add(TextSpan(text: c));
    i++;
  }
  return out;
}

Widget buildUsagePatterns() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kSurfaceStrong),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Usage patterns', style: _sans(18, _kInk, weight: FontWeight.w800)),
              _vGap(4),
              Text(
                'Every provider flows through the Image widget or a '
                'DecorationImage; the knobs are on the provider itself.',
                style: _sans(13, _kMuted),
              ),
            ],
          ),
        ),
        _vGap(10),
        _codeBlock('simple-asset',
            "// Implicit bundle = rootBundle\n"
            "Image(image: AssetImage('images/cover.png'))"),
        _vGap(8),
        _codeBlock('asset-with-bundle-and-package',
            "Image(\n"
            "  image: AssetImage(\n"
            "    'images/cover.png',\n"
            "    bundle: customBundle,\n"
            "    package: 'my_pkg',\n"
            "  ),\n"
            ")"),
        _vGap(8),
        _codeBlock('decoration-image',
            "Container(\n"
            "  decoration: BoxDecoration(\n"
            "    image: DecorationImage(\n"
            "      image: AssetImage('images/bg.png'),\n"
            "      fit: BoxFit.cover,\n"
            "    ),\n"
            "  ),\n"
            ")"),
        _vGap(8),
        _codeBlock('fade-in-image',
            "FadeInImage(\n"
            "  placeholder: AssetImage('images/blur.png'),\n"
            "  image: AssetImage('images/photo.png'),\n"
            ")"),
        _vGap(8),
        _codeBlock('exact-asset',
            "// Skip the manifest lookup\n"
            "Image(image: ExactAssetImage('images/3x/photo.png', scale: 3.0))"),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 — BUNDLE OVERRIDE
// ===========================================================================

Widget buildBundleOverride() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kSurfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bundle resolution', style: _sans(18, _kInk, weight: FontWeight.w800)),
          _vGap(6),
          Text(
            'When the provider does not carry an explicit `bundle`, the '
            'Flutter framework queries `DefaultAssetBundle.of(context)` at '
            'resolve-time. The default default is `rootBundle` — but any '
            'widget can inject a replacement.',
            style: _sans(13, _kInk),
          ),
          _vGap(12),
          const SizedBox(height: 150, child: CustomPaint(painter: _BundleResolvePainter())),
          _vGap(8),
          _codeBlock('inject-a-custom-bundle',
              "DefaultAssetBundle(\n"
              "  bundle: myAlternativeBundle,\n"
              "  child: Image(image: AssetImage('icons/star.png')),\n"
              ")"),
        ],
      ),
    ),
  );
}

class _BundleResolvePainter extends CustomPainter {
  const _BundleResolvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kSurface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final Rect provider = Rect.fromLTWH(20, 24, 180, 100);
    final Rect context = Rect.fromLTWH(220, 24, 180, 50);
    final Rect bundle = Rect.fromLTWH(220, 88, 180, 36);
    final Rect load = Rect.fromLTWH(420, 48, 180, 56);

    _box(canvas, provider, 'AssetImage("foo.png")', _kAccentCool);
    _box(canvas, context, 'DefaultAssetBundle.of(context)', _kAccentShade);
    _box(canvas, bundle, 'resolved AssetBundle', _kSeed);
    _box(canvas, load, 'bundle.load(key)', _kAccentHot);

    _arrow(canvas, Offset(provider.right, provider.top + 20), Offset(context.left, context.top + 25));
    _arrow(canvas, Offset(provider.right, provider.bottom - 18), Offset(bundle.left, bundle.top + 18));
    _arrow(canvas, Offset(bundle.right, bundle.top + 18), Offset(load.left, load.top + 28));
  }

  void _box(Canvas canvas, Rect rect, String label, Color c) {
    final Paint fill = Paint()..color = Colors.white;
    final Paint stroke = Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(style: _mono(11, _kInk, weight: FontWeight.w700), text: label),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: rect.width - 16);
    tp.paint(canvas, Offset(rect.left + 8, rect.center.dy - tp.height / 2));
  }

  void _arrow(Canvas canvas, Offset a, Offset b) {
    final Paint p = Paint()
      ..color = _kAccentShade
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(a, b, p);
    canvas.drawLine(b, Offset(b.dx - 6, b.dy - 3), p);
    canvas.drawLine(b, Offset(b.dx - 6, b.dy + 3), p);
  }

  @override
  bool shouldRepaint(covariant _BundleResolvePainter oldDelegate) => false;
}

// ===========================================================================
// SECTION 7 — DPR VARIANT RESOLUTION
// ===========================================================================

Widget buildDprResolution() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kSurfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Device-pixel-ratio variants', style: _sans(18, _kInk, weight: FontWeight.w800)),
          _vGap(4),
          Text(
            'AssetImage asks the AssetManifest for every variant of the key, '
            'scores each by how close its scale matches the DPR, and picks '
            'the winner.',
            style: _sans(13, _kInk),
          ),
          _vGap(12),
          _dprRow('1.0x device', '1.0', <_DprVariant>[
            _DprVariant('images/hero.png', 1.0, true),
            _DprVariant('images/2.0x/hero.png', 2.0, false),
            _DprVariant('images/3.0x/hero.png', 3.0, false),
          ]),
          _vGap(8),
          _dprRow('2.0x device', '2.0', <_DprVariant>[
            _DprVariant('images/hero.png', 1.0, false),
            _DprVariant('images/2.0x/hero.png', 2.0, true),
            _DprVariant('images/3.0x/hero.png', 3.0, false),
          ]),
          _vGap(8),
          _dprRow('3.0x device', '3.0', <_DprVariant>[
            _DprVariant('images/hero.png', 1.0, false),
            _DprVariant('images/2.0x/hero.png', 2.0, false),
            _DprVariant('images/3.0x/hero.png', 3.0, true),
          ]),
          _vGap(8),
          _dprRow('2.6x device (nearest wins)', '2.6', <_DprVariant>[
            _DprVariant('images/hero.png', 1.0, false),
            _DprVariant('images/2.0x/hero.png', 2.0, false),
            _DprVariant('images/3.0x/hero.png', 3.0, true),
          ]),
          _vGap(12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'If no manifest is present, AssetImage falls back to the @1x key '
              '(the value you passed to the constructor). ExactAssetImage does '
              'not play this game at all — it loads exactly what you asked for.',
              style: _sans(13, _kInk),
            ),
          ),
        ],
      ),
    ),
  );
}

class _DprVariant {
  const _DprVariant(this.path, this.scale, this.chosen);
  final String path;
  final double scale;
  final bool chosen;
}

Widget _dprRow(String label, String dpr, List<_DprVariant> variants) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _kSeed,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text('DPR = $dpr', style: _mono(11, Colors.white, weight: FontWeight.w800)),
          ),
          _hGap(10),
          Text(label, style: _sans(13, _kInk, weight: FontWeight.w700)),
        ]),
        _vGap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: variants
              .map((_DprVariant v) => _dprChip(v))
              .toList(growable: false),
        ),
      ],
    ),
  );
}

Widget _dprChip(_DprVariant v) {
  final Color border = v.chosen ? _kAccentCool : _kSurfaceStrong;
  final Color bg = v.chosen ? _kAccentCool.withValues(alpha: 0.14) : Colors.white;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: border, width: v.chosen ? 1.8 : 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          v.chosen ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: v.chosen ? _kAccentCool : _kMuted,
        ),
        _hGap(6),
        Text(v.path, style: _mono(11, _kInk, weight: FontWeight.w600)),
        _hGap(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: v.chosen ? _kAccentCool : _kSurfaceStrong,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text('${v.scale}x',
              style: _mono(10, v.chosen ? Colors.white : _kInk, weight: FontWeight.w800)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — ERROR HANDLING
// ===========================================================================

Widget buildErrorHandling() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kSurfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Error handling', style: _sans(18, _kInk, weight: FontWeight.w800)),
          _vGap(6),
          _errorTile(
            Icons.search_off,
            _kAccentHot,
            'Missing key',
            'bundle.load throws FlutterError: Unable to load asset: "foo.png". '
                'The asset does not exist or has no associated binary in the manifest.',
          ),
          _vGap(8),
          _errorTile(
            Icons.broken_image_outlined,
            _kAccentWarm,
            'Undecodable bytes',
            'instantiateImageCodec rejects the buffer — usually because the '
                'file is not a real PNG/JPEG/GIF/WebP, or is truncated.',
          ),
          _vGap(8),
          _errorTile(
            Icons.rule_folder_outlined,
            _kAccentCool,
            'Manifest race',
            'Variant lookup happens once at resolve time; later manifest '
                'mutations do not retroactively upgrade already-decoded images.',
          ),
          _vGap(12),
          _codeBlock('error-builder',
              "Image(\n"
              "  image: AssetImage('images/missing.png'),\n"
              "  errorBuilder: (context, error, stack) {\n"
              "    return Container(\n"
              "      color: Colors.red.shade100,\n"
              "      child: Icon(Icons.image_not_supported),\n"
              "    );\n"
              "  },\n"
              ")"),
        ],
      ),
    ),
  );
}

Widget _errorTile(IconData icon, Color color, String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        _hGap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _sans(14, _kInk, weight: FontWeight.w800)),
              _vGap(4),
              Text(body, style: _sans(12.5, _kInk)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — REAL RENDERING SAMPLES
// ===========================================================================

Widget buildRenderSamples() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kSurfaceStrong),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Provider flavors', style: _sans(18, _kInk, weight: FontWeight.w800)),
              _vGap(4),
              Text(
                'AssetBundleImageProvider subclasses (AssetImage, ExactAssetImage) '
                'resolve through an AssetBundle. In this sandbox we cannot bind '
                'a real bundle, so those samples illustrate the API surface while '
                'MemoryImage provides a side-by-side rendered result.',
                style: _sans(13, _kMuted),
              ),
            ],
          ),
        ),
        _vGap(10),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 0.82,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            _providerTile(
              'AssetImage',
              "AssetImage('images/a.png')",
              _kAccentCool,
              _surrogateArt(<Color>[_kAccentCool, _kSeed]),
              'surrogate: AssetBundleImageProvider does not load in sandbox',
            ),
            _providerTile(
              'AssetImage + bundle',
              "AssetImage('x.png', bundle: myBundle)",
              _kAccentCool,
              _surrogateArt(<Color>[_kAccentCool, _kAccentWarm]),
              'surrogate: bundle would be DefaultAssetBundle.of(context)',
            ),
            _providerTile(
              'ExactAssetImage',
              "ExactAssetImage('x3.png', scale: 3)",
              _kAccentHot,
              _surrogateArt(<Color>[_kAccentHot, _kAccentWarm]),
              'surrogate: manifest-lookup is skipped entirely',
            ),
            _providerTile(
              'MemoryImage (rendered)',
              'MemoryImage(bytes)',
              _kAccentWarm,
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[_kAccentWarm.withValues(alpha: 0.2), _kSeed.withValues(alpha: 0.2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: MemoryImage(_kTinyPng),
                  width: 32,
                  height: 32,
                  filterQuality: FilterQuality.none,
                ),
              ),
              'real render: decoded from tiny inline PNG bytes',
            ),
            _providerTile(
              'AssetImage + package',
              "AssetImage('i.png', package: 'pkg')",
              _kSeed,
              _surrogateArt(<Color>[_kSeed, _kAccentCool]),
              'surrogate: resolves to packages/pkg/i.png in the manifest',
            ),
            _providerTile(
              'DecorationImage',
              'DecorationImage(image: AssetImage(...))',
              _kAccentShade,
              _surrogateArt(<Color>[_kAccentShade, _kMuted]),
              'surrogate: used by BoxDecoration.image',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _providerTile(
  String title,
  String code,
  Color accent,
  Widget art,
  String caption,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kSurfaceStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10), child: art)),
        _vGap(8),
        Text(title, style: _sans(13, _kInk, weight: FontWeight.w800)),
        _vGap(2),
        Text(code, style: _mono(10, accent, weight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
        _vGap(6),
        Text(caption, style: _sans(10.5, _kMuted)),
      ],
    ),
  );
}

Widget _surrogateArt(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors.map((Color c) => c.withValues(alpha: 0.85)).toList(growable: false),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(Icons.image_outlined, color: Colors.white, size: 26),
        const SizedBox(height: 4),
        Text('surrogate',
            style: _mono(10, Colors.white.withValues(alpha: 0.92), weight: FontWeight.w700)),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — COMPARISON TABLE
// ===========================================================================

Widget buildComparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['Source', 'Loads from', 'Needs manifest?', 'Async?'],
    <String>['AssetBundleImageProvider', 'AssetBundle', 'AssetImage: yes / Exact: no', 'yes'],
    <String>['NetworkImage', 'http(s) url', 'no', 'yes (network)'],
    <String>['MemoryImage', 'Uint8List in memory', 'no', 'no (already bytes)'],
    <String>['FileImage', 'File on disk', 'no', 'yes (disk I/O)'],
    <String>['ResizeImage', 'wraps another provider', 'delegates', 'delegates'],
  ];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kSurfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('ImageProvider comparison', style: _sans(18, _kInk, weight: FontWeight.w800)),
          _vGap(4),
          Text('Where each ImageProvider pulls its bytes from.',
              style: _sans(13, _kMuted)),
          _vGap(10),
          Table(
            border: TableBorder.all(color: _kSurfaceStrong, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.6),
              1: FlexColumnWidth(1.4),
              2: FlexColumnWidth(1.6),
              3: FlexColumnWidth(1.1),
            },
            children: <TableRow>[
              for (int i = 0; i < rows.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    color: i == 0 ? _kSeed.withValues(alpha: 0.16) : (i == 1 ? _kAccentCool.withValues(alpha: 0.08) : Colors.white),
                  ),
                  children: <Widget>[
                    for (final String cell in rows[i])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          cell,
                          style: i == 0
                              ? _mono(12, _kInk, weight: FontWeight.w800)
                              : _mono(12, _kInk),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 11 — USE CASES
// ===========================================================================

class _UseCase {
  const _UseCase(this.title, this.body, this.icon, this.color);
  final String title;
  final String body;
  final IconData icon;
  final Color color;
}

Widget buildUseCases() {
  const List<_UseCase> cases = <_UseCase>[
    _UseCase(
      'Tile backgrounds',
      'BoxDecoration(image: DecorationImage(image: AssetImage(...))) — tiled '
          'textures for cards, panels, splash screens.',
      Icons.texture_outlined,
      _kSeed,
    ),
    _UseCase(
      'Product grid',
      'Catalog items where every SKU ships with an asset PNG; '
          'DPR variants keep each thumbnail crisp.',
      Icons.grid_view_outlined,
      _kAccentCool,
    ),
    _UseCase(
      'Avatars',
      'Bundle a default avatar as an asset and fall back to it when a '
          'NetworkImage fails via errorBuilder.',
      Icons.account_circle_outlined,
      _kAccentWarm,
    ),
    _UseCase(
      'Splash branding',
      'ExactAssetImage keeps the splash logo byte-for-byte stable across '
          'devices — useful for pixel-locked motion graphics.',
      Icons.rocket_launch_outlined,
      _kAccentHot,
    ),
    _UseCase(
      'Illustration gallery',
      'FadeInImage with a tiny placeholder AssetImage + a full-resolution '
          'AssetImage gives graceful reveal.',
      Icons.collections_outlined,
      _kAccentShade,
    ),
    _UseCase(
      'Icon bundle',
      'Ship a package of domain-specific icons and access them with '
          'AssetImage(\'icons/x.png\', package: \'brand_icons\').',
      Icons.style_outlined,
      _kAccentCool,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.45,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        for (final _UseCase c in cases) _useCaseCard(c),
      ],
    ),
  );
}

Widget _useCaseCard(_UseCase c) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kSurfaceStrong),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: c.color.withValues(alpha: 0.07),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: c.color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(c.icon, color: c.color),
        ),
        _vGap(10),
        Text(c.title, style: _sans(15, _kInk, weight: FontWeight.w800)),
        _vGap(6),
        Expanded(
          child: Text(c.body, style: _sans(12.5, _kInk)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 — PITFALLS
// ===========================================================================

Widget buildPitfalls() {
  const List<_UseCase> pitfalls = <_UseCase>[
    _UseCase(
      'Forgot the @1x',
      'Shipping only 2.0x/foo.png without the base 1.0x entry means 1x '
          'devices silently fall back to the 2x asset at half size.',
      Icons.warning_amber_outlined,
      _kAccentHot,
    ),
    _UseCase(
      'Variant surprise',
      'If AssetManifest has variants for a different logical key than the '
          'one you pass, you will load the wrong DPR scale.',
      Icons.error_outline,
      _kAccentWarm,
    ),
    _UseCase(
      'Bundle lifetime',
      'Custom AssetBundles must outlive the Image widget. A disposed bundle '
          'will throw on load() and surface via errorBuilder.',
      Icons.hourglass_disabled_outlined,
      _kAccentShade,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      children: <Widget>[
        for (final _UseCase p in pitfalls) ...<Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: p.color.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: p.color.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: p.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(p.icon, color: Colors.white),
                ),
                _hGap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(p.title, style: _sans(15, _kInk, weight: FontWeight.w800)),
                      _vGap(4),
                      Text(p.body, style: _sans(13, _kInk)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _vGap(10),
        ],
      ],
    ),
  );
}

// ===========================================================================
// SECTION 13 — API CHEAT SHEET
// ===========================================================================

class _ApiRow {
  const _ApiRow(this.name, this.type, this.purpose);
  final String name;
  final String type;
  final String purpose;
}

Widget buildApiCheatSheet() {
  const List<_ApiRow> base = <_ApiRow>[
    _ApiRow('resolve(config)', 'ImageStream Function(ImageConfiguration)',
        'Inherited from ImageProvider; attaches listeners and triggers obtainKey.'),
    _ApiRow('obtainKey(config)', 'Future<AssetBundleImageKey>',
        'Resolve the ImageConfiguration into a concrete cache key.'),
    _ApiRow('load(key, decode)', 'ImageStreamCompleter',
        'Bundle-aware fetch; produces a MultiFrameImageStreamCompleter.'),
    _ApiRow('loadBuffer(key, decode)', 'ImageStreamCompleter',
        'Equivalent of load using ui.ImmutableBuffer.'),
    _ApiRow('==(Object other)', 'bool',
        'Two providers are equal iff they produce the same key.'),
    _ApiRow('hashCode', 'int',
        'Stable hash derived from the key properties.'),
  ];
  const List<_ApiRow> assetImage = <_ApiRow>[
    _ApiRow('assetName', 'String',
        'Manifest-lookup key (e.g. "images/hero.png").'),
    _ApiRow('bundle', 'AssetBundle?',
        'Optional override; null → DefaultAssetBundle.of(context).'),
    _ApiRow('package', 'String?',
        'Routes through "packages/<package>/<assetName>".'),
    _ApiRow('keyName', 'String',
        'Effective name, including the "packages/<package>" prefix.'),
  ];
  const List<_ApiRow> exactAssetImage = <_ApiRow>[
    _ApiRow('assetName', 'String', 'Literal bundle key, never reinterpreted.'),
    _ApiRow('scale', 'double', 'Explicit scale, default 1.0.'),
    _ApiRow('bundle', 'AssetBundle?', 'Optional override bundle.'),
    _ApiRow('package', 'String?', 'Package prefix support.'),
    _ApiRow('keyName', 'String', 'Final key after prefix is applied.'),
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _apiSection('AssetBundleImageProvider (base)', _kSeed, base),
        _vGap(10),
        _apiSection('AssetImage (subclass)', _kAccentCool, assetImage),
        _vGap(10),
        _apiSection('ExactAssetImage (subclass)', _kAccentHot, exactAssetImage),
      ],
    ),
  );
}

Widget _apiSection(String title, Color color, List<_ApiRow> rows) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kSurfaceStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            border: Border(bottom: BorderSide(color: color.withValues(alpha: 0.4))),
          ),
          child: Row(children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            _hGap(8),
            Text(title, style: _sans(15, _kInk, weight: FontWeight.w800)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              for (final _ApiRow r in rows) ...<Widget>[
                _apiRowWidget(r, color),
                _vGap(6),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _apiRowWidget(_ApiRow r, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(r.name, style: _mono(12, color, weight: FontWeight.w800)),
        ),
        SizedBox(
          width: 170,
          child: Text(r.type, style: _mono(11.5, _kAccentShade, weight: FontWeight.w600)),
        ),
        Expanded(child: Text(r.purpose, style: _sans(12.5, _kInk))),
      ],
    ),
  );
}

// ===========================================================================
// TAB SCAFFOLD
// ===========================================================================

class _TabSpec {
  const _TabSpec(this.label, this.icon, this.body);
  final String label;
  final IconData icon;
  final Widget body;
}

Widget _buildTabHost() {
  final List<_TabSpec> tabs = <_TabSpec>[
    _TabSpec('Overview', Icons.auto_awesome_outlined,
        _overviewTab()),
    _TabSpec('Hierarchy', Icons.account_tree_outlined, buildHierarchyDiagram()),
    _TabSpec('Pipeline', Icons.route_outlined, buildPipelineDiagram()),
    _TabSpec('Variants', Icons.call_split_outlined,
        Column(children: <Widget>[
          buildVariantComparison(),
          _vGap(8),
          buildDprResolution(),
        ])),
    _TabSpec('Usage', Icons.code_outlined, buildUsagePatterns()),
    _TabSpec('Bundle', Icons.folder_special_outlined, buildBundleOverride()),
    _TabSpec('Errors', Icons.error_outline, buildErrorHandling()),
    _TabSpec('Samples', Icons.photo_library_outlined, buildRenderSamples()),
    _TabSpec('Reference', Icons.menu_book_outlined,
        Column(children: <Widget>[
          buildComparisonTable(),
          _vGap(8),
          buildUseCases(),
          _vGap(8),
          buildPitfalls(),
          _vGap(8),
          buildApiCheatSheet(),
        ])),
  ];

  return DefaultTabController(
    length: tabs.length,
    child: Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: TabBar(
            isScrollable: true,
            labelColor: _kSeed,
            unselectedLabelColor: _kMuted,
            indicatorColor: _kSeed,
            indicatorWeight: 3,
            labelStyle: _sans(13, _kSeed, weight: FontWeight.w800),
            unselectedLabelStyle: _sans(13, _kMuted, weight: FontWeight.w600),
            tabs: <Widget>[
              for (final _TabSpec t in tabs)
                Tab(
                  icon: Icon(t.icon, size: 18),
                  text: t.label,
                  iconMargin: const EdgeInsets.only(bottom: 2),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 1000,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              for (final _TabSpec t in tabs)
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: t.body,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _overviewTab() {
  return Column(
    children: <Widget>[
      _vGap(8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(child: _overviewStat('Library', 'painting.dart', _kSeed, Icons.brush_outlined)),
            _hGap(8),
            Expanded(child: _overviewStat('Kind', 'abstract class', _kAccentCool, Icons.category_outlined)),
            _hGap(8),
            Expanded(child: _overviewStat('Generic', 'ImageProvider<AssetBundleImageKey>', _kAccentHot, Icons.data_object)),
          ],
        ),
      ),
      _vGap(8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kSurfaceStrong),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('In one paragraph', style: _sans(17, _kInk, weight: FontWeight.w800)),
              _vGap(6),
              Text(
                'AssetBundleImageProvider is the abstract middle layer between the '
                'generic ImageProvider contract and the concrete asset-backed '
                'providers AssetImage and ExactAssetImage. It pins the cache-key '
                'type to AssetBundleImageKey and owns the shared bytes→codec→frame '
                'pipeline; the subclasses only differ in how they resolve the key '
                '(manifest-aware variant picking vs. literal passthrough).',
                style: _sans(13, _kInk),
              ),
              _vGap(10),
              _definitionRow('Declared in', 'package:flutter/painting.dart'),
              _definitionRow('Direct subclasses', 'AssetImage, ExactAssetImage'),
              _definitionRow('Cache key', 'AssetBundleImageKey {bundle, name, scale}'),
              _definitionRow('Bytes source', 'bundle.load(String key)'),
              _definitionRow('Decoder', 'PaintingBinding.instance.instantiateImageCodec'),
              _definitionRow('Delivery', 'ImageStreamCompleter → ImageInfo'),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _overviewStat(String label, String value, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        _vGap(8),
        Text(label, style: _sans(11, _kMuted, weight: FontWeight.w700)),
        _vGap(2),
        Text(value, style: _mono(12, _kInk, weight: FontWeight.w800)),
      ],
    ),
  );
}

Widget _definitionRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(label, style: _sans(12.5, _kMuted, weight: FontWeight.w700)),
        ),
        Expanded(child: Text(value, style: _mono(12.5, _kInk, weight: FontWeight.w700))),
      ],
    ),
  );
}

// ===========================================================================
// ENTRY POINT
// ===========================================================================

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: _kSeed,
    primary: _kSeed,
    secondary: _kAccentCool,
    tertiary: _kAccentHot,
    surface: _kSurface,
  );

  final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: _kSurface,
    textTheme: const TextTheme().apply(bodyColor: _kInk, displayColor: _kInk),
  );

  return Theme(
    data: theme,
    child: Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kSeed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: <Widget>[
            const Icon(Icons.layers_outlined),
            _hGap(8),
            Text('AssetBundleImageProvider',
                style: _sans(18, Colors.white, weight: FontWeight.w800)),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: _chip(_kAccentHot, _kAccentWarm, r: 999),
                child: Text('deep demo',
                    style: _mono(11, Colors.white, weight: FontWeight.w800)),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeroBanner(),
              _vGap(6),
              _buildTabHost(),
              _vGap(20),
              _footerCard(),
              _vGap(24),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _footerCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: <Color>[_kInk, _kAccentShade],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.info_outline, color: Colors.white),
        _hGap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Takeaway',
                  style: _sans(15, Colors.white, weight: FontWeight.w800)),
              _vGap(6),
              Text(
                'Reach for AssetImage by default. Switch to ExactAssetImage '
                'when you need byte-for-byte predictability or you operate '
                'without an AssetManifest. Both inherit every other behaviour '
                'from AssetBundleImageProvider unchanged.',
                style: _sans(12.5, Colors.white.withValues(alpha: 0.92)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
