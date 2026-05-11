// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, unused_import, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, avoid_unnecessary_containers

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEDEFF6),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroHeader(),
            SizedBox(height: 28),
            _AnatomySection(),
            SizedBox(height: 28),
            _StaticGallerySection(),
            SizedBox(height: 28),
            _ControllerStateSection(),
            SizedBox(height: 28),
            _MagnifierInfoSection(),
            SizedBox(height: 28),
            _DecorationSection(),
            SizedBox(height: 28),
            _ComparisonSection(),
            SizedBox(height: 28),
            _CodeBlockSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _TheorySection(),
            SizedBox(height: 28),
            _FooterStamp(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SHARED TOKENS
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF0E1530);
const Color _kInkSoft = Color(0xFF31405F);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kSurfaceAlt = Color(0xFFF6F8FE);
const Color _kBorder = Color(0xFFD9DEEB);
const Color _kAccent = Color(0xFF2D6CDF);
const Color _kAccentDeep = Color(0xFF1B3D8F);
const Color _kAccentPink = Color(0xFFE03A8E);
const Color _kAccentTeal = Color(0xFF1FA7A0);
const Color _kAccentAmber = Color(0xFFE0A02D);
const Color _kAccentRed = Color(0xFFD2433A);
const Color _kAccentMint = Color(0xFF44B07A);

const TextStyle _kSans = TextStyle(
  fontFamily: 'CupertinoSystemText',
  color: _kInk,
  fontSize: 13.5,
  height: 1.35,
  fontWeight: FontWeight.w500,
);

const TextStyle _kMono = TextStyle(
  fontFamily: 'Menlo',
  color: _kInk,
  fontSize: 12.0,
  height: 1.35,
  fontWeight: FontWeight.w600,
);

// ---------------------------------------------------------------------------
// SECTION HEADER
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final IconData icon;

  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.32),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 54.0,
            height: 54.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
            child: Icon(icon, color: const Color(0xFFFFFFFF), size: 26.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Section $number',
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFE9ECF5),
                    fontSize: 11.0,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFFFFFFF),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.86),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
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
}

// ---------------------------------------------------------------------------
// HERO HEADER
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0A2540),
            Color(0xFF1E3A8A),
            Color(0xFF4364C7),
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0A2540).withValues(alpha: 0.45),
            blurRadius: 28.0,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.36),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'flutter/cupertino.dart',
                style: TextStyle(
                  fontFamily: 'Menlo',
                  color: Color(0xFFE7EAF6),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.30),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'D4RT - deep visual',
                style: TextStyle(
                  fontFamily: 'CupertinoSystemText',
                  color: Color(0xFFE0E5F4),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 18.0),
          const Text(
            'The iOS Text Magnifier',
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: Color(0xFFFFFFFF),
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'CupertinoTextMagnifier, MagnifierController, MagnifierDecoration',
            style: TextStyle(
              fontFamily: 'Menlo',
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.88),
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            'The round loupe that floats above your finger when you drag a '
            'selection handle in iOS TextField. It samples a small rectangle '
            'beneath the touch point, scales it up, and projects it through a '
            'circular clip with a subtle drop-shadow ring. This demo dissects '
            'its anatomy, controller lifecycle, decoration tokens and the '
            'overlay layer it lives in.',
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: const Color(0xFFE7EAF6).withValues(alpha: 0.95),
              fontSize: 14.0,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18.0),
          Wrap(spacing: 8.0, runSpacing: 8.0, children: const <Widget>[
            _HeroChip(label: 'CupertinoTextMagnifier'),
            _HeroChip(label: 'TextMagnifier'),
            _HeroChip(label: 'CupertinoMagnifier'),
            _HeroChip(label: 'MagnifierController'),
            _HeroChip(label: 'MagnifierDecoration'),
            _HeroChip(label: 'RawMagnifier'),
            _HeroChip(label: 'Overlay layer'),
          ]),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  const _HeroChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Menlo',
          color: Color(0xFFFFFFFF),
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CARD WRAPPER
// ---------------------------------------------------------------------------

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(18, 18, 18, 18),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _kBorder, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.05),
            blurRadius: 14.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String text;
  final Color color;
  const _SubTitle(this.text, {this.color = _kInk});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'CupertinoSystemText',
        color: color,
        fontSize: 15.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.1,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 - ANATOMY
// ---------------------------------------------------------------------------

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '01',
        title: 'Anatomy of the Loupe',
        subtitle: 'Circular clip, magnified content, ring shadow, focal offset',
        gradient: <Color>[Color(0xFF1B3D8F), Color(0xFF3B5CB8)],
        icon: CupertinoIcons.search_circle_fill,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('Anatomy diagram'),
          const SizedBox(height: 6),
          const Text(
            'The CupertinoTextMagnifier draws a circular window above the '
            'finger position. Content beneath is sampled, scaled by '
            'magnificationScale, and rendered inside a clipped ring with a '
            'soft outer shadow.',
            style: _kSans,
          ),
          const SizedBox(height: 14),
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: _kBorder, width: 1.0),
            ),
            child: const _AnatomyPainterBox(),
          ),
          const SizedBox(height: 14),
          const _AnatomyLegend(),
        ]),
      ),
    ]);
  }
}

class _AnatomyPainterBox extends StatelessWidget {
  const _AnatomyPainterBox();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: CustomPaint(
        painter: _AnatomyPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF6F8FE);
    canvas.drawRect(Offset.zero & size, bg);

    // Simulated underlying text strip ----------------------------------------
    final double stripTop = size.height * 0.62;
    final double stripBottom = size.height * 0.78;
    final Paint stripBg = Paint()..color = const Color(0xFFEDEFF6);
    canvas.drawRect(
      Rect.fromLTRB(20.0, stripTop, size.width - 20.0, stripBottom),
      stripBg,
    );
    _drawTextRow(canvas, 30.0, (stripTop + stripBottom) / 2 - 6.0,
        size.width - 60.0, 12.0, const Color(0xFF8089A6));
    _drawTextRow(canvas, 30.0, (stripTop + stripBottom) / 2 + 6.0,
        size.width - 90.0, 8.0, const Color(0xFFB5BCD0));

    // Focal point marker (the finger position) -------------------------------
    final Offset focal = Offset(size.width * 0.50, (stripTop + stripBottom) / 2);
    final Paint focalPaint = Paint()..color = _kAccentPink;
    canvas.drawCircle(focal, 4.0, focalPaint);

    // Loupe center -----------------------------------------------------------
    final Offset center = Offset(focal.dx, focal.dy - 110.0);
    const double radius = 56.0;

    // Drop shadow ring
    final Paint shadow = Paint()
      ..color = _kInk.withValues(alpha: 0.20)
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawCircle(center + const Offset(0, 6), radius + 2.0, shadow);

    // Outer ring stroke
    final Paint outerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(center, radius + 1.5, outerRing);

    // Glass body (clipped magnified content)
    canvas.save();
    final Path clip = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clip);

    // Background of the magnified region (lighter to imply lensed surface)
    final Paint glassBg = Paint()..color = const Color(0xFFFCFDFF);
    canvas.drawRect(Offset.zero & size, glassBg);

    // Magnified text rows - scaled-up version of the row beneath focal
    _drawTextRow(canvas, center.dx - radius - 4.0, center.dy - 6.0,
        radius * 2.0 + 8.0, 18.0, const Color(0xFF31405F));
    _drawTextRow(canvas, center.dx - radius - 4.0, center.dy + 12.0,
        radius * 2.0 + 8.0, 12.0, const Color(0xFF6F7995));

    // Tinted dome highlight
    final Paint dome = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx - radius, center.dy - radius),
        Offset(center.dx + radius, center.dy),
        <Color>[
          const Color(0xFFFFFFFF).withValues(alpha: 0.65),
          const Color(0xFFFFFFFF).withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(center, radius, dome);
    canvas.restore();

    // Inner crisp ring
    final Paint innerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFB2BBD5);
    canvas.drawCircle(center, radius, innerRing);

    // Connector line from loupe to focal (no actual tail on iOS, but we mark
    // the focal vector for legend clarity).
    final Paint vector = Paint()
      ..color = _kAccentPink.withValues(alpha: 0.45)
      ..strokeWidth = 1.2;
    canvas.drawLine(
        Offset(center.dx, center.dy + radius + 2.0), focal, vector);

    // Callouts ---------------------------------------------------------------
    _drawCallout(canvas, const Offset(20, 22),
        'size: Size(77.5, 37.5)\nthe loupe rect', _kAccent);
    _drawCallout(canvas, Offset(size.width - 220, 22),
        'magnificationScale: 1.25', _kAccentDeep);
    _drawCallout(canvas, const Offset(20, 230),
        'clipBehavior: Clip.hardEdge\n(circular clipPath)', _kAccentMint);
    _drawCallout(canvas, Offset(size.width - 220, 230),
        'borderRadius: full circle\n(size.shortestSide / 2)', _kAccentAmber);

    // Focal offset arrow -----------------------------------------------------
    final Paint offsetLine = Paint()
      ..color = _kAccentPink
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Path dashed = Path()
      ..moveTo(center.dx + radius + 10.0, center.dy)
      ..lineTo(center.dx + radius + 10.0, focal.dy);
    canvas.drawPath(dashed, offsetLine);
    _drawLabel(canvas, Offset(center.dx + radius + 14.0, center.dy + 40.0),
        'additionalFocalPointOffset', _kAccentPink);
  }

  void _drawTextRow(Canvas canvas, double x, double y, double w, double h,
      Color c) {
    final Paint p = Paint()..color = c.withValues(alpha: 0.75);
    final RRect r = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, y - h / 2, w, h),
      const Radius.circular(2.0),
    );
    canvas.drawRRect(r, p);
  }

  void _drawCallout(Canvas canvas, Offset at, String text, Color color) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: 'Menlo',
      fontSize: 10.0,
      height: 1.3,
      textAlign: TextAlign.left,
    ))
      ..pushStyle(ui.TextStyle(color: color, fontWeight: FontWeight.w700))
      ..addText(text);
    final ui.Paragraph p = pb.build()
      ..layout(const ui.ParagraphConstraints(width: 200.0));
    canvas.drawParagraph(p, at);
  }

  void _drawLabel(Canvas canvas, Offset at, String text, Color color) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: 'Menlo',
      fontSize: 9.5,
      height: 1.2,
    ))
      ..pushStyle(ui.TextStyle(color: color, fontWeight: FontWeight.w700))
      ..addText(text);
    final ui.Paragraph p = pb.build()
      ..layout(const ui.ParagraphConstraints(width: 220.0));
    canvas.drawParagraph(p, at);
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter oldDelegate) => false;
}

class _AnatomyLegend extends StatelessWidget {
  const _AnatomyLegend();
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 12, runSpacing: 8, children: const <Widget>[
      _LegendDot(label: 'size', color: _kAccent),
      _LegendDot(label: 'magnificationScale', color: _kAccentDeep),
      _LegendDot(label: 'borderRadius', color: _kAccentAmber),
      _LegendDot(label: 'clipBehavior', color: _kAccentMint),
      _LegendDot(label: 'additionalFocalPointOffset', color: _kAccentPink),
    ]);
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: _kMono),
    ]);
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 - STATIC GALLERY
// ---------------------------------------------------------------------------

class _StaticGallerySection extends StatelessWidget {
  const _StaticGallerySection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '02',
        title: 'Static Gallery',
        subtitle: 'Hand-drawn loupes over six different text contexts',
        gradient: <Color>[Color(0xFF1FA7A0), Color(0xFF44B07A)],
        icon: CupertinoIcons.photo_on_rectangle,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('Gallery snapshots'),
          const SizedBox(height: 6),
          const Text(
            'Because the live CupertinoTextMagnifier is driven by a '
            'MagnifierController off the gesture stream, this gallery '
            'approximates the rendered output with a CustomPainter. Each '
            'tile shows a different underlying text context with the loupe '
            'hovering above a chosen focal point.',
            style: _kSans,
          ),
          const SizedBox(height: 14),
          const _GalleryGrid(),
        ]),
      ),
    ]);
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid();
  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      Row(children: <Widget>[
        Expanded(child: _GalleryTile(
          label: 'Long sentence',
          variant: _GalleryVariant.longSentence,
        )),
        SizedBox(width: 10),
        Expanded(child: _GalleryTile(
          label: 'Code mono',
          variant: _GalleryVariant.code,
        )),
      ]),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(child: _GalleryTile(
          label: 'RTL Arabic',
          variant: _GalleryVariant.rtl,
        )),
        SizedBox(width: 10),
        Expanded(child: _GalleryTile(
          label: 'Multi-line',
          variant: _GalleryVariant.multiline,
        )),
      ]),
    ]);
  }
}

enum _GalleryVariant { longSentence, code, rtl, multiline, heading, numeric }

class _GalleryTile extends StatelessWidget {
  final String label;
  final _GalleryVariant variant;
  const _GalleryTile({required this.label, required this.variant});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: SizedBox(
            height: 150.0,
            child: CustomPaint(
              painter: _GalleryPainter(variant: variant),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: const BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: _kInk,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ]),
    );
  }
}

class _GalleryPainter extends CustomPainter {
  final _GalleryVariant variant;
  _GalleryPainter({required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawRect(Offset.zero & size, bg);

    switch (variant) {
      case _GalleryVariant.longSentence:
        _drawSentenceBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.55, size.height * 0.65),
            32.0, 1.30, _GalleryVariant.longSentence);
        break;
      case _GalleryVariant.code:
        _drawCodeBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.40, size.height * 0.62),
            30.0, 1.40, _GalleryVariant.code);
        break;
      case _GalleryVariant.rtl:
        _drawRtlBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.62, size.height * 0.60),
            32.0, 1.25, _GalleryVariant.rtl);
        break;
      case _GalleryVariant.multiline:
        _drawMultilineBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.45, size.height * 0.55),
            30.0, 1.25, _GalleryVariant.multiline);
        break;
      case _GalleryVariant.heading:
        _drawHeadingBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.50, size.height * 0.60),
            34.0, 1.20, _GalleryVariant.heading);
        break;
      case _GalleryVariant.numeric:
        _drawNumericBg(canvas, size);
        _drawLoupe(canvas, size, Offset(size.width * 0.50, size.height * 0.60),
            30.0, 1.50, _GalleryVariant.numeric);
        break;
    }
  }

  void _drawSentenceBg(Canvas canvas, Size size) {
    final Paint p1 = Paint()..color = const Color(0xFF31405F);
    final Paint p2 = Paint()..color = const Color(0xFF8089A6);
    _row(canvas, 10, size.height * 0.40, size.width - 20, 7.0, p1);
    _row(canvas, 10, size.height * 0.55, size.width - 40, 7.0, p1);
    _row(canvas, 10, size.height * 0.70, size.width - 60, 7.0, p2);
    _row(canvas, 10, size.height * 0.85, size.width - 100, 7.0, p2);
  }

  void _drawCodeBg(Canvas canvas, Size size) {
    final Paint kw = Paint()..color = const Color(0xFFAA0B5C);
    final Paint id = Paint()..color = const Color(0xFF1B3D8F);
    final Paint plain = Paint()..color = const Color(0xFF31405F);
    final List<List<double>> rows = <List<double>>[
      <double>[10.0, 32.0, 56.0, 24.0],
      <double>[10.0, 60.0, 90.0, 30.0],
      <double>[10.0, 88.0, 40.0, 70.0],
      <double>[10.0, 116.0, 75.0, 40.0],
    ];
    int i = 0;
    for (final List<double> r in rows) {
      final Paint a = i.isEven ? kw : id;
      final Paint b = plain;
      canvas.drawRect(Rect.fromLTWH(r[0], r[1], r[2], 6.0), a);
      canvas.drawRect(Rect.fromLTWH(r[0] + r[2] + 6.0, r[1], r[3], 6.0), b);
      i++;
    }
  }

  void _drawRtlBg(Canvas canvas, Size size) {
    final Paint p1 = Paint()..color = const Color(0xFF31405F);
    for (int i = 0; i < 4; i++) {
      final double y = size.height * (0.40 + i * 0.13);
      final double w = size.width - 20 - i * 16.0;
      canvas.drawRect(
        Rect.fromLTWH(size.width - 10 - w, y, w, 6.0),
        p1,
      );
    }
  }

  void _drawMultilineBg(Canvas canvas, Size size) {
    final Paint p1 = Paint()..color = const Color(0xFF31405F);
    for (int i = 0; i < 5; i++) {
      final double y = size.height * (0.20 + i * 0.14);
      final double w = size.width - 20 - (i % 3) * 14.0;
      canvas.drawRect(Rect.fromLTWH(10, y, w, 5.0), p1);
    }
  }

  void _drawHeadingBg(Canvas canvas, Size size) {
    final Paint big = Paint()..color = const Color(0xFF0E1530);
    canvas.drawRect(Rect.fromLTWH(10, size.height * 0.50, size.width - 20, 18.0), big);
    final Paint small = Paint()..color = const Color(0xFF8089A6);
    canvas.drawRect(Rect.fromLTWH(10, size.height * 0.80, size.width - 60, 5.0), small);
  }

  void _drawNumericBg(Canvas canvas, Size size) {
    final Paint p = Paint()..color = const Color(0xFF1B3D8F);
    final List<String> rows = <String>['1234', '5678', '90.0'];
    for (int i = 0; i < rows.length; i++) {
      final double y = size.height * (0.40 + i * 0.15);
      double x = 10.0;
      for (int j = 0; j < rows[i].length; j++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y, 16.0, 14.0), const Radius.circular(3.0)),
          p,
        );
        x += 22.0;
      }
    }
  }

  void _row(Canvas canvas, double x, double y, double w, double h, Paint p) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, w, h), const Radius.circular(2.0)),
      p,
    );
  }

  void _drawLoupe(Canvas canvas, Size size, Offset focal, double radius,
      double scale, _GalleryVariant v) {
    final Offset center = Offset(focal.dx, focal.dy - radius - 36.0);
    // Shadow
    final Paint shadow = Paint()
      ..color = _kInk.withValues(alpha: 0.20)
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 5.0);
    canvas.drawCircle(center + const Offset(0, 4), radius + 2.0, shadow);
    // White ring
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(center, radius + 1.5, ring);
    // Glass interior - clipped enlarged content
    canvas.save();
    final Path clip = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clip);
    final Paint glass = Paint()..color = const Color(0xFFFCFDFF);
    canvas.drawCircle(center, radius, glass);

    // Magnified content
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scale, scale);
    canvas.translate(-focal.dx, -focal.dy);
    switch (v) {
      case _GalleryVariant.longSentence:
        _drawSentenceBg(canvas, size);
        break;
      case _GalleryVariant.code:
        _drawCodeBg(canvas, size);
        break;
      case _GalleryVariant.rtl:
        _drawRtlBg(canvas, size);
        break;
      case _GalleryVariant.multiline:
        _drawMultilineBg(canvas, size);
        break;
      case _GalleryVariant.heading:
        _drawHeadingBg(canvas, size);
        break;
      case _GalleryVariant.numeric:
        _drawNumericBg(canvas, size);
        break;
    }
    canvas.restore();

    // Highlight gloss
    final Paint gloss = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx - radius, center.dy - radius),
        Offset(center.dx, center.dy),
        <Color>[
          const Color(0xFFFFFFFF).withValues(alpha: 0.55),
          const Color(0xFFFFFFFF).withValues(alpha: 0.0),
        ],
      );
    canvas.drawCircle(center, radius, gloss);

    canvas.restore();
    // Inner ring
    final Paint innerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFFB2BBD5);
    canvas.drawCircle(center, radius, innerRing);
    // Focal dot
    final Paint focalDot = Paint()..color = _kAccentPink;
    canvas.drawCircle(focal, 3.5, focalDot);
  }

  @override
  bool shouldRepaint(covariant _GalleryPainter old) => old.variant != variant;
}

// ---------------------------------------------------------------------------
// SECTION 3 - CONTROLLER STATE DIAGRAM
// ---------------------------------------------------------------------------

class _ControllerStateSection extends StatelessWidget {
  const _ControllerStateSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '03',
        title: 'MagnifierController State Machine',
        subtitle: 'hidden -> showing -> visible -> hiding -> hidden',
        gradient: <Color>[Color(0xFFE03A8E), Color(0xFFAA0B5C)],
        icon: CupertinoIcons.flowchart,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('Lifecycle'),
          const SizedBox(height: 6),
          const Text(
            'A MagnifierController owns the overlay entry that hosts the '
            'magnifier widget. show() inserts the entry and triggers the '
            'enter animation. update() pumps a new MagnifierInfo (geometry + '
            'focal point). hide() drives the exit animation; when complete '
            'the controller removes the entry.',
            style: _kSans,
          ),
          const SizedBox(height: 14),
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: _kBorder, width: 1.0),
            ),
            child: CustomPaint(
              painter: _StateMachinePainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 14),
          const _StateLegend(),
        ]),
      ),
    ]);
  }
}

class _StateMachinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<_StateNode> nodes = <_StateNode>[
      _StateNode(
          label: 'hidden',
          color: const Color(0xFF8089A6),
          pos: Offset(size.width * 0.10, size.height * 0.55)),
      _StateNode(
          label: 'showing',
          color: _kAccent,
          pos: Offset(size.width * 0.30, size.height * 0.20)),
      _StateNode(
          label: 'visible',
          color: _kAccentMint,
          pos: Offset(size.width * 0.52, size.height * 0.55)),
      _StateNode(
          label: 'hiding',
          color: _kAccentAmber,
          pos: Offset(size.width * 0.74, size.height * 0.20)),
      _StateNode(
          label: 'hidden',
          color: const Color(0xFF8089A6),
          pos: Offset(size.width * 0.92, size.height * 0.55)),
    ];

    // Edges
    _edge(canvas, nodes[0].pos, nodes[1].pos, 'show()', _kAccent);
    _edge(canvas, nodes[1].pos, nodes[2].pos, 'enter end', _kAccentMint);
    _edge(canvas, nodes[2].pos, nodes[2].pos + const Offset(0, -34), 'update()',
        _kAccent, selfLoop: true);
    _edge(canvas, nodes[2].pos, nodes[3].pos, 'hide()', _kAccentAmber);
    _edge(canvas, nodes[3].pos, nodes[4].pos, 'exit end', const Color(0xFF8089A6));

    // Nodes
    for (final _StateNode n in nodes) {
      _drawNode(canvas, n);
    }
  }

  void _drawNode(Canvas canvas, _StateNode n) {
    final Paint shadow = Paint()
      ..color = _kInk.withValues(alpha: 0.10)
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawCircle(n.pos + const Offset(0, 3), 30.0, shadow);
    final Paint fill = Paint()..color = n.color;
    canvas.drawCircle(n.pos, 30.0, fill);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(n.pos, 30.0, ring);

    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: 'Menlo',
      fontSize: 11.0,
      height: 1.2,
      textAlign: TextAlign.center,
    ))
      ..pushStyle(ui.TextStyle(
          color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w800))
      ..addText(n.label);
    final ui.Paragraph p = pb.build()
      ..layout(const ui.ParagraphConstraints(width: 70.0));
    canvas.drawParagraph(p, Offset(n.pos.dx - 35.0, n.pos.dy - 6.0));
  }

  void _edge(Canvas canvas, Offset a, Offset b, String label, Color color,
      {bool selfLoop = false}) {
    final Paint line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    if (selfLoop) {
      final Path loop = Path()
        ..moveTo(a.dx - 12.0, a.dy - 26.0)
        ..cubicTo(a.dx - 50.0, a.dy - 80.0, a.dx + 50.0, a.dy - 80.0,
            a.dx + 12.0, a.dy - 26.0);
      canvas.drawPath(loop, line);
      _arrow(canvas, Offset(a.dx + 12.0, a.dy - 26.0), const Offset(0, 1),
          color);
      _label(canvas, Offset(a.dx - 30.0, a.dy - 76.0), label, color);
      return;
    }
    final Offset dir = (b - a);
    final double dist = dir.distance;
    final Offset unit = Offset(dir.dx / dist, dir.dy / dist);
    final Offset start = a + unit * 32.0;
    final Offset end = b - unit * 32.0;
    canvas.drawLine(start, end, line);
    _arrow(canvas, end, unit, color);
    final Offset mid = Offset((start.dx + end.dx) / 2.0,
        (start.dy + end.dy) / 2.0 - 8.0);
    _label(canvas, mid, label, color);
  }

  void _arrow(Canvas canvas, Offset tip, Offset unit, Color color) {
    final double angle = math.atan2(unit.dy, unit.dx);
    final Path arr = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 8.0 * math.cos(angle - 0.5),
          tip.dy - 8.0 * math.sin(angle - 0.5))
      ..lineTo(tip.dx - 8.0 * math.cos(angle + 0.5),
          tip.dy - 8.0 * math.sin(angle + 0.5))
      ..close();
    canvas.drawPath(arr, Paint()..color = color);
  }

  void _label(Canvas canvas, Offset at, String text, Color color) {
    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: 'Menlo',
      fontSize: 10.0,
      textAlign: TextAlign.center,
    ))
      ..pushStyle(ui.TextStyle(color: color, fontWeight: FontWeight.w700))
      ..addText(text);
    final ui.Paragraph p = pb.build()
      ..layout(const ui.ParagraphConstraints(width: 100.0));
    canvas.drawParagraph(p, Offset(at.dx - 50.0, at.dy));
  }

  @override
  bool shouldRepaint(covariant _StateMachinePainter old) => false;
}

class _StateNode {
  final String label;
  final Color color;
  final Offset pos;
  const _StateNode({required this.label, required this.color, required this.pos});
}

class _StateLegend extends StatelessWidget {
  const _StateLegend();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
      _StateRow(
        state: 'hidden',
        body: 'No overlay entry. controller.overlayEntry is null. Initial.',
      ),
      SizedBox(height: 6),
      _StateRow(
        state: 'showing',
        body: 'show() called. Overlay entry inserted; enter animation runs.',
      ),
      SizedBox(height: 6),
      _StateRow(
        state: 'visible',
        body: 'Steady state. update(MagnifierInfo) on each gesture move.',
      ),
      SizedBox(height: 6),
      _StateRow(
        state: 'hiding',
        body: 'hide(removeFromOverlay: true) requested; exit animation runs.',
      ),
      SizedBox(height: 6),
      _StateRow(
        state: 'hidden',
        body: 'Final. Entry removed; controller can be reused.',
      ),
    ]);
  }
}

class _StateRow extends StatelessWidget {
  final String state;
  final String body;
  const _StateRow({required this.state, required this.body});
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        width: 84.0,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kSurfaceAlt,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: _kBorder, width: 1.0),
        ),
        child: Text(
          state,
          style: const TextStyle(
            fontFamily: 'Menlo',
            color: _kInk,
            fontSize: 11.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(child: Text(body, style: _kSans)),
    ]);
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 - MAGNIFIERINFO
// ---------------------------------------------------------------------------

class _MagnifierInfoSection extends StatelessWidget {
  const _MagnifierInfoSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '04',
        title: 'MagnifierInfo',
        subtitle: 'The geometry payload pumped on every gesture tick',
        gradient: <Color>[Color(0xFFE0A02D), Color(0xFFD2433A)],
        icon: CupertinoIcons.cube_box,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('MagnifierInfo fields'),
          const SizedBox(height: 6),
          const Text(
            'MagnifierInfo lives in the widgets layer and bundles the four '
            'rectangles + focal point that the magnifier needs each frame. '
            'It is fed by SelectionOverlay -> MagnifierController.update().',
            style: _kSans,
          ),
          const SizedBox(height: 12),
          const _ParamTable(rows: <_ParamRow>[
            _ParamRow(name: 'globalGesturePosition', type: 'Offset',
                desc: 'Pointer position in screen coordinates.'),
            _ParamRow(name: 'caretRect', type: 'Rect',
                desc: 'Caret rectangle for the currently dragged handle.'),
            _ParamRow(name: 'fieldBounds', type: 'Rect',
                desc: 'Editing field rectangle in global coordinates.'),
            _ParamRow(name: 'currentLineBoundaries', type: 'Rect',
                desc: 'Current text line rect; used to clamp the focal Y.'),
          ]),
          const SizedBox(height: 14),
          const _SubTitle('How update() flows'),
          const SizedBox(height: 6),
          const Text(
            'TextSelectionGestureDetectorBuilder receives drag events from '
            'the selection handle. Each drag calls SelectionOverlay.'
            'showMagnifier / updateMagnifier, which in turn pushes a fresh '
            'MagnifierInfo through the ValueNotifier and your MagnifierBuilder '
            'rebuilds the loupe.',
            style: _kSans,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kBorder, width: 1.0),
            ),
            child: const Text(
              'gesture.move\n'
              '  -> SelectionOverlay.updateMagnifier(MagnifierInfo)\n'
              '    -> ValueNotifier<MagnifierInfo>.value = info\n'
              '      -> ValueListenableBuilder rebuilds CupertinoTextMagnifier\n'
              '        -> position recomputed; clip + scale repaint',
              style: _kMono,
            ),
          ),
        ]),
      ),
    ]);
  }
}

class _ParamRow {
  final String name;
  final String type;
  final String desc;
  const _ParamRow({required this.name, required this.type, required this.desc});
}

class _ParamTable extends StatelessWidget {
  final List<_ParamRow> rows;
  const _ParamTable({required this.rows});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border(bottom: BorderSide(color: _kBorder, width: 1.0)),
          ),
          child: Row(children: const <Widget>[
            SizedBox(
              width: 170.0,
              child: Text('field',
                  style: TextStyle(
                      fontFamily: 'Menlo',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      color: _kInkSoft)),
            ),
            SizedBox(
              width: 100.0,
              child: Text('type',
                  style: TextStyle(
                      fontFamily: 'Menlo',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      color: _kInkSoft)),
            ),
            Expanded(
              child: Text('description',
                  style: TextStyle(
                      fontFamily: 'Menlo',
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      color: _kInkSoft)),
            ),
          ]),
        ),
        ...rows.map((_ParamRow r) => _paramRowWidget(r, rows.last == r)),
      ]),
    );
  }

  Widget _paramRowWidget(_ParamRow r, bool isLast) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: _kBorder, width: 1.0),
              ),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(r.name,
              style: const TextStyle(
                  fontFamily: 'Menlo',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: _kInk)),
        ),
        SizedBox(
          width: 100.0,
          child: Text(r.type,
              style: const TextStyle(
                  fontFamily: 'Menlo',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: _kAccentDeep)),
        ),
        Expanded(child: Text(r.desc, style: _kSans)),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 - DECORATION
// ---------------------------------------------------------------------------

class _DecorationSection extends StatelessWidget {
  const _DecorationSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '05',
        title: 'MagnifierDecoration',
        subtitle: 'shape, shadows and opacity of the loupe chrome',
        gradient: <Color>[Color(0xFF44B07A), Color(0xFF1FA7A0)],
        icon: CupertinoIcons.paintbrush_fill,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('MagnifierDecoration fields'),
          const SizedBox(height: 6),
          const Text(
            'MagnifierDecoration sits on RawMagnifier and controls how the '
            'magnifier ring is drawn. CupertinoTextMagnifier wires it to the '
            'iOS standard: a circle, soft outer shadow, opaque-edge ring.',
            style: _kSans,
          ),
          const SizedBox(height: 12),
          const _ParamTable(rows: <_ParamRow>[
            _ParamRow(
                name: 'opacity',
                type: 'double',
                desc: 'Overall alpha multiplier; default 1.0.'),
            _ParamRow(
                name: 'shadows',
                type: 'List<BoxShadow>',
                desc: 'Soft drop shadow around the lens ring.'),
            _ParamRow(
                name: 'shape',
                type: 'ShapeBorder',
                desc: 'Outer geometry; iOS uses CircleBorder.'),
          ]),
          const SizedBox(height: 16),
          const _SubTitle('Sample decorations'),
          const SizedBox(height: 8),
          const _DecorationSamples(),
        ]),
      ),
    ]);
  }
}

class _DecorationSamples extends StatelessWidget {
  const _DecorationSamples();
  @override
  Widget build(BuildContext context) {
    return Row(children: const <Widget>[
      Expanded(child: _DecorationSample(
          name: 'Default iOS',
          shadowAlpha: 0.25,
          shadowBlur: 8.0,
          ringColor: Color(0xFFFFFFFF))),
      SizedBox(width: 10),
      Expanded(child: _DecorationSample(
          name: 'Heavy shadow',
          shadowAlpha: 0.45,
          shadowBlur: 16.0,
          ringColor: Color(0xFFFFFFFF))),
      SizedBox(width: 10),
      Expanded(child: _DecorationSample(
          name: 'Hairline tint',
          shadowAlpha: 0.10,
          shadowBlur: 4.0,
          ringColor: Color(0xFFBEC9E7))),
    ]);
  }
}

class _DecorationSample extends StatelessWidget {
  final String name;
  final double shadowAlpha;
  final double shadowBlur;
  final Color ringColor;
  const _DecorationSample({
    required this.name,
    required this.shadowAlpha,
    required this.shadowBlur,
    required this.ringColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(children: <Widget>[
        SizedBox(
          height: 120.0,
          child: CustomPaint(
            painter: _DecorationPainter(
              shadowAlpha: shadowAlpha,
              shadowBlur: shadowBlur,
              ringColor: ringColor,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: const BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Text(name,
              style: const TextStyle(
                fontFamily: 'CupertinoSystemText',
                color: _kInk,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              )),
        ),
      ]),
    );
  }
}

class _DecorationPainter extends CustomPainter {
  final double shadowAlpha;
  final double shadowBlur;
  final Color ringColor;
  _DecorationPainter({
    required this.shadowAlpha,
    required this.shadowBlur,
    required this.ringColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFBFE);
    canvas.drawRect(Offset.zero & size, bg);
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    const double radius = 30.0;
    final Paint shadow = Paint()
      ..color = _kInk.withValues(alpha: shadowAlpha)
      ..maskFilter = ui.MaskFilter.blur(BlurStyle.normal, shadowBlur);
    canvas.drawCircle(center + const Offset(0, 4), radius + 2.0, shadow);
    final Paint glass = Paint()..color = const Color(0xFFFCFDFF);
    canvas.drawCircle(center, radius, glass);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = ringColor;
    canvas.drawCircle(center, radius + 1.5, ring);
    final Paint inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFFB2BBD5);
    canvas.drawCircle(center, radius, inner);
    // Magnified content suggestion
    final Paint t = Paint()..color = const Color(0xFF31405F);
    canvas.drawRect(
        Rect.fromLTWH(center.dx - 18, center.dy - 3, 36, 6), t);
  }

  @override
  bool shouldRepaint(covariant _DecorationPainter o) =>
      o.shadowAlpha != shadowAlpha ||
      o.shadowBlur != shadowBlur ||
      o.ringColor != ringColor;
}

// ---------------------------------------------------------------------------
// SECTION 6 - COMPARISON
// ---------------------------------------------------------------------------

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '06',
        title: 'Cupertino vs Material vs Raw',
        subtitle: 'Three magnifiers side by side',
        gradient: <Color>[Color(0xFF2D6CDF), Color(0xFF1B3D8F)],
        icon: CupertinoIcons.rectangle_split_3x1,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('Comparison row'),
          const SizedBox(height: 6),
          const Text(
            'CupertinoTextMagnifier is the iOS-styled loupe used by the '
            'Cupertino text-selection toolbar. TextMagnifier is the Material '
            'equivalent: a rectangular pill. CupertinoMagnifier and '
            'RawMagnifier are lower-level building blocks you can compose '
            'into your own custom magnifier widget.',
            style: _kSans,
          ),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
            Expanded(child: _CompareTile(
              title: 'CupertinoTextMagnifier',
              shape: _CompareShape.circle,
              accent: _kAccent,
              notes: 'Circular loupe, full ring, soft shadow.\n'
                  'Used by CupertinoTextField selection.',
            )),
            SizedBox(width: 10),
            Expanded(child: _CompareTile(
              title: 'TextMagnifier (material)',
              shape: _CompareShape.pill,
              accent: _kAccentPink,
              notes: 'Rounded rectangle / pill shape.\n'
                  'Used by Material TextField selection.',
            )),
            SizedBox(width: 10),
            Expanded(child: _CompareTile(
              title: 'CupertinoMagnifier',
              shape: _CompareShape.bare,
              accent: _kAccentMint,
              notes: 'Bare lens primitive. No animation policy;\n'
                  'compose into your own controller.',
            )),
          ]),
        ]),
      ),
    ]);
  }
}

enum _CompareShape { circle, pill, bare }

class _CompareTile extends StatelessWidget {
  final String title;
  final _CompareShape shape;
  final Color accent;
  final String notes;
  const _CompareTile({
    required this.title,
    required this.shape,
    required this.accent,
    required this.notes,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(
          height: 110,
          child: CustomPaint(
            painter: _ComparePainter(shape: shape, accent: accent),
            child: const SizedBox.expand(),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
          decoration: const BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(title,
                style: TextStyle(
                  fontFamily: 'Menlo',
                  color: accent,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 4),
            Text(notes, style: _kSans.copyWith(fontSize: 11.5)),
          ]),
        ),
      ]),
    );
  }
}

class _ComparePainter extends CustomPainter {
  final _CompareShape shape;
  final Color accent;
  _ComparePainter({required this.shape, required this.accent});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawRect(Offset.zero & size, bg);
    // Stripe of underlying text
    final Paint text = Paint()..color = const Color(0xFF31405F);
    canvas.drawRect(
        Rect.fromLTWH(10, size.height - 18, size.width - 20, 6), text);

    final Offset center = Offset(size.width / 2.0, size.height * 0.40);
    final Paint shadow = Paint()
      ..color = _kInk.withValues(alpha: 0.22)
      ..maskFilter = const ui.MaskFilter.blur(BlurStyle.normal, 7.0);
    final Paint glass = Paint()..color = const Color(0xFFFCFDFF);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = const Color(0xFFFFFFFF);
    final Paint inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = accent;

    switch (shape) {
      case _CompareShape.circle:
        canvas.drawCircle(center + const Offset(0, 4), 26.0, shadow);
        canvas.drawCircle(center, 24.0, glass);
        canvas.drawCircle(center, 25.0, ring);
        canvas.drawCircle(center, 24.0, inner);
        // magnified text suggestion
        canvas.drawRect(
            Rect.fromLTWH(center.dx - 14, center.dy - 2, 28, 5),
            Paint()..color = const Color(0xFF31405F));
        break;
      case _CompareShape.pill:
        final RRect r = RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 78.0, height: 36.0),
          const Radius.circular(18.0),
        );
        canvas.drawRRect(r.shift(const Offset(0, 3)), shadow);
        canvas.drawRRect(r, glass);
        canvas.drawRRect(r, ring);
        canvas.drawRRect(r, inner);
        canvas.drawRect(
            Rect.fromLTWH(center.dx - 28, center.dy - 2, 56, 5),
            Paint()..color = const Color(0xFF31405F));
        break;
      case _CompareShape.bare:
        // Hexagonal-ish bare lens
        final RRect r = RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 70.0, height: 34.0),
          const Radius.circular(12.0),
        );
        canvas.drawRRect(r.shift(const Offset(0, 3)), shadow);
        canvas.drawRRect(r, glass);
        canvas.drawRRect(r, inner);
        canvas.drawRect(
            Rect.fromLTWH(center.dx - 24, center.dy - 2, 48, 5),
            Paint()..color = const Color(0xFF31405F));
        break;
    }
    // Focal dot
    canvas.drawCircle(Offset(center.dx, size.height - 15.0), 3.0,
        Paint()..color = _kAccentPink);
  }

  @override
  bool shouldRepaint(covariant _ComparePainter o) =>
      o.shape != shape || o.accent != accent;
}

// ---------------------------------------------------------------------------
// SECTION 7 - CODE BLOCKS
// ---------------------------------------------------------------------------

class _CodeBlockSection extends StatelessWidget {
  const _CodeBlockSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '07',
        title: 'Idiomatic Usage',
        subtitle: 'Three canonical code patterns',
        gradient: <Color>[Color(0xFF31405F), Color(0xFF0E1530)],
        icon: CupertinoIcons.chevron_left_slash_chevron_right,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          const _SubTitle('Pattern A - Default Cupertino magnifier'),
          const SizedBox(height: 6),
          const _CodeBlock(
            text:
                "// CupertinoTextField already wires CupertinoTextMagnifier.\n"
                "// Just enable it via TextMagnifierConfiguration.\n"
                "CupertinoTextField(\n"
                "  magnifierConfiguration: TextMagnifierConfiguration(\n"
                "    magnifierBuilder: (BuildContext context,\n"
                "        MagnifierController controller,\n"
                "        ValueNotifier<MagnifierInfo> info) {\n"
                "      return CupertinoTextMagnifier(\n"
                "        controller: controller,\n"
                "        magnifierInfo: info,\n"
                "      );\n"
                "    },\n"
                "  ),\n"
                ")",
          ),
          const SizedBox(height: 14),
          const _SubTitle('Pattern B - Custom RawMagnifier'),
          const SizedBox(height: 6),
          const _CodeBlock(
            text:
                "// Roll your own loupe geometry via RawMagnifier.\n"
                "RawMagnifier(\n"
                "  decoration: const MagnifierDecoration(\n"
                "    shape: CircleBorder(side: BorderSide.none),\n"
                "    shadows: <BoxShadow>[\n"
                "      BoxShadow(\n"
                "        color: Color(0x33000000),\n"
                "        blurRadius: 8.0,\n"
                "        offset: Offset(0, 4),\n"
                "      ),\n"
                "    ],\n"
                "  ),\n"
                "  magnificationScale: 1.3,\n"
                "  size: const Size(80, 80),\n"
                "  focalPointOffset: const Offset(0, 30),\n"
                ")",
          ),
          const SizedBox(height: 14),
          const _SubTitle('Pattern C - MagnifierController lifecycle'),
          const SizedBox(height: 6),
          const _CodeBlock(
            text:
                "// Mount / update / unmount the overlay entry.\n"
                "final MagnifierController controller = MagnifierController();\n"
                "\n"
                "// On gesture start:\n"
                "controller.show(\n"
                "  context: context,\n"
                "  below: null,\n"
                "  builder: (BuildContext ctx) => CupertinoTextMagnifier(\n"
                "    controller: controller,\n"
                "    magnifierInfo: infoNotifier,\n"
                "  ),\n"
                ");\n"
                "\n"
                "// On gesture move:\n"
                "infoNotifier.value = MagnifierInfo(...);\n"
                "\n"
                "// On gesture end:\n"
                "controller.hide(removeFromOverlay: true);\n"
                "\n"
                "// On dispose:\n"
                "controller.overlayEntry?.remove();",
          ),
        ]),
      ),
    ]);
  }
}

class _CodeBlock extends StatelessWidget {
  final String text;
  const _CodeBlock({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1530),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF31405F), width: 1.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Menlo',
          color: Color(0xFFE9ECF5),
          fontSize: 11.5,
          height: 1.45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 - PITFALLS
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '08',
        title: 'Pitfalls',
        subtitle: 'Five common mistakes when wiring magnifiers',
        gradient: <Color>[Color(0xFFD2433A), Color(0xFFAA0B5C)],
        icon: CupertinoIcons.exclamationmark_triangle_fill,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
          _Pitfall(
            number: '1',
            title: 'Offset.zero positioning forgotten',
            body: 'CupertinoTextMagnifier expects its position relative to '
                'the overlay coordinate system. Default placement assumes the '
                'parent Stack uses Offset.zero as its origin. If you wrap it '
                'in a Positioned with stale coordinates the loupe drifts.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '2',
            title: 'Mismatched magnificationScale',
            body: 'A scale < 1.0 inverts the magnifier into a minifier and '
                'looks broken. The iOS default is ~1.25. Values above 2.0 '
                'produce visible pixel aliasing on text glyphs.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '3',
            title: 'Dispose ordering',
            body: 'MagnifierController.dispose does not automatically remove '
                'the OverlayEntry. Always call controller.hide(removeFromOverlay: '
                'true) before disposing the controller, or you leak an orphan '
                'entry that paints over future routes.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '4',
            title: 'RTL projection bug',
            body: 'When TextDirection.rtl is in play, the projected text '
                'inside the loupe must be drawn with the same directionality '
                'as the source field. Forgetting to honor textDirection on '
                'the inner Text widget produces mirror-flipped glyphs.',
          ),
          SizedBox(height: 10),
          _Pitfall(
            number: '5',
            title: 'Overlay layer collisions',
            body: 'If your app uses a custom Overlay (not WidgetsApp.overlay) '
                'you must pass the right BuildContext to controller.show(). '
                'Passing the wrong context attaches the magnifier to a '
                'different overlay, causing it to clip or vanish on route '
                'transitions.',
          ),
        ]),
      ),
    ]);
  }
}

class _Pitfall extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  const _Pitfall({required this.number, required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6F5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFF3CFCD), width: 1.0),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kAccentRed,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(number,
              style: const TextStyle(
                fontFamily: 'Menlo',
                color: Color(0xFFFFFFFF),
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              )),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title,
              style: const TextStyle(
                fontFamily: 'CupertinoSystemText',
                color: _kInk,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 4),
          Text(body, style: _kSans),
        ])),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 - THEORY
// ---------------------------------------------------------------------------

class _TheorySection extends StatelessWidget {
  const _TheorySection();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const _SectionHeader(
        number: '09',
        title: 'Theory',
        subtitle: 'Why iOS chose a circle, accessibility considerations',
        gradient: <Color>[Color(0xFF1FA7A0), Color(0xFF1B3D8F)],
        icon: CupertinoIcons.lightbulb_fill,
      ),
      const SizedBox(height: 14),
      _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
          _TheoryCard(
            title: 'Why a circular magnifier?',
            body: 'Apple chose a circle because (a) it has no preferred '
                'reading direction, working equally well for LTR and RTL; '
                '(b) the radial symmetry hides the discontinuity between the '
                'magnified strip and the underlying text; (c) it visually '
                'echoes the classic physical loupe and reinforces the '
                'metaphor that the user is "looking through glass".',
          ),
          SizedBox(height: 10),
          _TheoryCard(
            title: 'Why Material chose a rectangle',
            body: 'Material text magnifier is a horizontal pill. It mirrors '
                'the rectangular text-line itself and aligns to the text '
                'baseline, sacrificing the loupe metaphor in favor of a more '
                'utilitarian "second view of the same line".',
          ),
          SizedBox(height: 10),
          _TheoryCard(
            title: 'Accessibility',
            body: 'The magnifier is purely visual and is not announced by '
                'VoiceOver. Users with low vision can rely on it for text '
                'selection precision, but it must not become the only way to '
                'access selection - selection handles themselves are the '
                'semantically meaningful affordance. Avoid disabling the '
                'magnifier in custom toolbars.',
          ),
        ]),
      ),
    ]);
  }
}

class _TheoryCard extends StatelessWidget {
  final String title;
  final String body;
  const _TheoryCard({required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title,
            style: const TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: _kAccentDeep,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            )),
        const SizedBox(height: 4),
        Text(body, style: _kSans),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10 - FOOTER
// ---------------------------------------------------------------------------

class _FooterStamp extends StatelessWidget {
  const _FooterStamp();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF0E1530), Color(0xFF1B3D8F)],
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.30),
            blurRadius: 18.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text(
          'Magnifier API surface',
          style: TextStyle(
            fontFamily: 'CupertinoSystemText',
            color: Color(0xFFFFFFFF),
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Everything you need to bridge gestures to a custom loupe and back.',
          style: TextStyle(
            fontFamily: 'CupertinoSystemText',
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.84),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(spacing: 8, runSpacing: 8, children: const <Widget>[
          _FooterChip(text: 'CupertinoTextMagnifier'),
          _FooterChip(text: 'CupertinoMagnifier'),
          _FooterChip(text: 'TextMagnifier'),
          _FooterChip(text: 'RawMagnifier'),
          _FooterChip(text: 'MagnifierController'),
          _FooterChip(text: 'MagnifierInfo'),
          _FooterChip(text: 'MagnifierDecoration'),
          _FooterChip(text: 'TextMagnifierConfiguration'),
          _FooterChip(text: 'SelectionOverlay'),
          _FooterChip(text: 'OverlayEntry'),
        ]),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
              width: 1.0,
            ),
          ),
          child: const Text(
            'tom_d4rt_flutter_ast / cupertino / magnifier_test',
            style: TextStyle(
              fontFamily: 'Menlo',
              color: Color(0xFFE7EAF6),
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ]),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String text;
  const _FooterChip({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.28),
          width: 1.0,
        ),
      ),
      child: Text(text,
          style: const TextStyle(
            fontFamily: 'Menlo',
            color: Color(0xFFFFFFFF),
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
