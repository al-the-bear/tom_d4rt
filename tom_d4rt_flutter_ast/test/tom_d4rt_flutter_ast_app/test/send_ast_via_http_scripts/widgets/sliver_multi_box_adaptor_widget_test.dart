import 'dart:math' as math;

import 'package:flutter/material.dart';

// =============================================================================
// SliverMultiBoxAdaptorWidget — Widget-Tier Adaptor Gallery
// -----------------------------------------------------------------------------
// This demo treats the abstract `SliverMultiBoxAdaptorWidget` class as the
// central subject of a curated museum exhibit. The widget sits at the top of
// a small dynasty of sliver adaptors: SliverList, SliverGrid,
// SliverFixedExtentList and SliverPrototypeExtentList all descend from it.
// Each concrete subclass specialises the base contract: a lazily-producing
// delegate driving a RenderSliverMultiBoxAdaptor variant via a dedicated
// SliverMultiBoxAdaptorElement.
//
// Companion file 410 covers the element tier (SliverMultiBoxAdaptorElement).
// This file stays strictly on the widget side — constructors, delegate fields,
// and the widget-to-element plumbing — without drifting into element lifecycle
// details.
//
// Theme: burgundy + ivory + gold "museum gallery" aesthetic with plinths,
// placards and hand-drawn cross-sections.
// =============================================================================

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kBurgundy = Color(0xFF5C1A2A);
const Color _kIvory = Color(0xFFFAF5EC);
const Color _kGold = Color(0xFFC9A34E);
const Color _kDeepBurgundy = Color(0xFF3F0F1C);
const Color _kSoftGold = Color(0xFFE6D39A);
const Color _kInk = Color(0xFF1A0B11);
const Color _kParchment = Color(0xFFF3EAD6);
const Color _kShadow = Color(0xFF2A0A13);

// ---------------------------------------------------------------------------
// Top-level entry point — d4rt AST harness expects a `build` function.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliverMultiBoxAdaptorWidget Gallery',
    home: _SmbawGalleryHome(),
  );
}

// ---------------------------------------------------------------------------
// Home scaffold — houses the entire gallery in a scrollable column.
// ---------------------------------------------------------------------------

class _SmbawGalleryHome extends StatefulWidget {
  const _SmbawGalleryHome();

  @override
  State<_SmbawGalleryHome> createState() => _SmbawGalleryHomeState();
}

class _SmbawGalleryHomeState extends State<_SmbawGalleryHome>
    with TickerProviderStateMixin {
  late final AnimationController _marqueeController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _marqueeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    debugPrint('[Smbaw] gallery initialised');
  }

  @override
  void dispose() {
    _marqueeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kIvory,
      appBar: _SmbawGalleryAppBar(pulse: _pulseController),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        children: <Widget>[
          _SmbawHeroMarquee(controller: _marqueeController),
          const SizedBox(height: 28),
          const _SmbawIntroBlurb(),
          const SizedBox(height: 28),
          const _SmbawPlinthRow(),
          const SizedBox(height: 32),
          const _SmbawComparisonTable(),
          const SizedBox(height: 32),
          const _SmbawConstructorAnatomyGrid(),
          const SizedBox(height: 32),
          const _SmbawIncorrectVsCorrectPair(),
          const SizedBox(height: 32),
          const _SmbawSpecSheetTabs(),
          const SizedBox(height: 32),
          const _SmbawPitfallCard(),
          const SizedBox(height: 32),
          const _SmbawFooterPlate(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Gallery app bar with pulsing gold underline.
// ---------------------------------------------------------------------------

class _SmbawGalleryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _SmbawGalleryAppBar({required this.pulse});

  final AnimationController pulse;

  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _kBurgundy,
      elevation: 0,
      toolbarHeight: 74,
      title: const Text(
        'SliverMultiBoxAdaptorWidget · Gallery',
        style: TextStyle(
          color: _kIvory,
          fontFamily: 'serif',
          fontSize: 20,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(6),
        child: AnimatedBuilder(
          animation: pulse,
          builder: (BuildContext context, Widget? child) {
            final double t = pulse.value;
            return Container(
              height: 6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _kGold.withValues(alpha: 0.4 + 0.5 * t),
                    _kSoftGold.withValues(alpha: 0.8),
                    _kGold.withValues(alpha: 0.4 + 0.5 * (1.0 - t)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero marquee — gold pinstripe animation with serif class name.
// ---------------------------------------------------------------------------

class _SmbawHeroMarquee extends StatelessWidget {
  const _SmbawHeroMarquee({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 220,
          decoration: BoxDecoration(
            color: _kDeepBurgundy,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kShadow.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CustomPaint(
                  painter: _SmbawPinstripePainter(phase: controller.value),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Colors.transparent,
                          _kBurgundy.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'THE WIDGET-TIER',
                        style: TextStyle(
                          color: _kSoftGold.withValues(alpha: 0.82),
                          fontFamily: 'serif',
                          fontSize: 13,
                          letterSpacing: 3.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'SliverMultiBoxAdaptorWidget',
                        style: TextStyle(
                          color: _kIvory,
                          fontFamily: 'serif',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 2,
                        width: 120,
                        color: _kGold,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'The abstract base for lazily-producing box-child slivers',
                        style: TextStyle(
                          color: _kIvory.withValues(alpha: 0.88),
                          fontFamily: 'serif',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 18,
                  child: _SmbawWingMark(phase: controller.value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Pinstripe painter — diagonal animated gold lines, museum signage style.
// ---------------------------------------------------------------------------

class _SmbawPinstripePainter extends CustomPainter {
  const _SmbawPinstripePainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint thick = Paint()
      ..color = _kGold.withValues(alpha: 0.22)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;
    final Paint thin = Paint()
      ..color = _kSoftGold.withValues(alpha: 0.12)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    const double spacing = 26;
    final double shift = phase * spacing * 2;
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      final double xs = x + shift;
      canvas.drawLine(
        Offset(xs, 0),
        Offset(xs - size.height, size.height),
        thick,
      );
      canvas.drawLine(
        Offset(xs + spacing / 2, 0),
        Offset(xs + spacing / 2 - size.height, size.height),
        thin,
      );
    }

    // Ornamental corner brackets.
    final Paint bracket = Paint()
      ..color = _kGold
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    const double b = 18;
    canvas.drawLine(const Offset(8, 8), const Offset(8 + b, 8), bracket);
    canvas.drawLine(const Offset(8, 8), const Offset(8, 8 + b), bracket);
    canvas.drawLine(
      Offset(size.width - 8, 8),
      Offset(size.width - 8 - b, 8),
      bracket,
    );
    canvas.drawLine(
      Offset(size.width - 8, 8),
      Offset(size.width - 8, 8 + b),
      bracket,
    );
    canvas.drawLine(
      Offset(8, size.height - 8),
      Offset(8 + b, size.height - 8),
      bracket,
    );
    canvas.drawLine(
      Offset(8, size.height - 8),
      Offset(8, size.height - 8 - b),
      bracket,
    );
    canvas.drawLine(
      Offset(size.width - 8, size.height - 8),
      Offset(size.width - 8 - b, size.height - 8),
      bracket,
    );
    canvas.drawLine(
      Offset(size.width - 8, size.height - 8),
      Offset(size.width - 8, size.height - 8 - b),
      bracket,
    );
  }

  @override
  bool shouldRepaint(covariant _SmbawPinstripePainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ---------------------------------------------------------------------------
// Wing mark — rotating gold circlet used as a decorative signature.
// ---------------------------------------------------------------------------

class _SmbawWingMark extends StatelessWidget {
  const _SmbawWingMark({required this.phase});

  final double phase;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: CustomPaint(
        painter: _SmbawWingPainter(phase: phase),
      ),
    );
  }
}

class _SmbawWingPainter extends CustomPainter {
  const _SmbawWingPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = math.min(size.width, size.height) / 2 - 4;
    final Paint outer = Paint()
      ..color = _kGold
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final Paint inner = Paint()
      ..color = _kSoftGold.withValues(alpha: 0.8)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, r, outer);
    canvas.drawCircle(center, r - 5, inner);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(phase * 2 * math.pi);
    for (int i = 0; i < 8; i++) {
      final double a = (i / 8) * 2 * math.pi;
      final Offset p1 = Offset(math.cos(a) * (r - 10), math.sin(a) * (r - 10));
      final Offset p2 = Offset(math.cos(a) * (r - 3), math.sin(a) * (r - 3));
      canvas.drawLine(p1, p2, outer);
    }
    canvas.restore();

    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'S·M',
        style: TextStyle(
          color: _kIvory,
          fontFamily: 'serif',
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _SmbawWingPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ---------------------------------------------------------------------------
// Intro blurb — narrative paragraph framed by gold rules.
// ---------------------------------------------------------------------------

class _SmbawIntroBlurb extends StatelessWidget {
  const _SmbawIntroBlurb();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 32, height: 2, color: _kGold),
              const SizedBox(width: 10),
              const Text(
                'CURATOR’S NOTE',
                style: TextStyle(
                  color: _kBurgundy,
                  fontFamily: 'serif',
                  fontSize: 12,
                  letterSpacing: 2.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: _kGold.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: _kInk,
                fontFamily: 'serif',
                fontSize: 15,
                height: 1.55,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text:
                      'The abstract class SliverMultiBoxAdaptorWidget is the widget-tier '
                      'ancestor of the four great scrolling slivers — ',
                ),
                TextSpan(
                  text: 'SliverList',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ', '),
                TextSpan(
                  text: 'SliverGrid',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ', '),
                TextSpan(
                  text: 'SliverFixedExtentList',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'SliverPrototypeExtentList',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text:
                      '. All four entrust their child production to a shared '
                      'SliverChildDelegate and defer element orchestration to a '
                      'SliverMultiBoxAdaptorElement. Only the render object varies.',
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
// Plinth row — four plinths side-by-side in a scrollable horizontal strip.
// ---------------------------------------------------------------------------

class _SmbawPlinthRow extends StatelessWidget {
  const _SmbawPlinthRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SmbawSectionHeader(
          eyebrow: 'GALLERY · EXHIBIT A',
          title: 'Four Concrete Subclasses on Display',
          lead:
              'Each plinth showcases one concrete adaptor with placard, live '
              'specimen and cross-section of its widget→element→render-object chain.',
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 620,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            children: const <Widget>[
              _SmbawPlinthSliverList(),
              SizedBox(width: 18),
              _SmbawPlinthSliverGrid(),
              SizedBox(width: 18),
              _SmbawPlinthSliverFixedExtent(),
              SizedBox(width: 18),
              _SmbawPlinthSliverPrototypeExtent(),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section header used throughout the gallery.
// ---------------------------------------------------------------------------

class _SmbawSectionHeader extends StatelessWidget {
  const _SmbawSectionHeader({
    required this.eyebrow,
    required this.title,
    required this.lead,
  });

  final String eyebrow;
  final String title;
  final String lead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(width: 40, height: 3, color: _kGold),
            const SizedBox(width: 10),
            Text(
              eyebrow,
              style: const TextStyle(
                color: _kBurgundy,
                fontFamily: 'serif',
                fontSize: 12,
                letterSpacing: 2.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: _kDeepBurgundy,
            fontFamily: 'serif',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          lead,
          style: TextStyle(
            color: _kInk.withValues(alpha: 0.78),
            fontFamily: 'serif',
            fontStyle: FontStyle.italic,
            fontSize: 14,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared plinth shell — consistent museum-pedestal chrome.
// ---------------------------------------------------------------------------

class _SmbawPlinthShell extends StatelessWidget {
  const _SmbawPlinthShell({
    required this.accent,
    required this.label,
    required this.subtitle,
    required this.placardLines,
    required this.specimen,
    required this.crossSectionTitle,
  });

  final Color accent;
  final String label;
  final String subtitle;
  final List<String> placardLines;
  final Widget specimen;
  final String crossSectionTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top placard.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: _kBurgundy,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              border: Border.all(color: accent, width: 1.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: _kIvory,
                    fontFamily: 'serif',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _kSoftGold.withValues(alpha: 0.9),
                    fontFamily: 'serif',
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          // Specimen case.
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: _kParchment,
              border: Border(
                left: BorderSide(color: accent, width: 1.4),
                right: BorderSide(color: accent, width: 1.4),
              ),
            ),
            child: ClipRect(child: specimen),
          ),
          // Placard body.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kIvory,
              border: Border(
                left: BorderSide(color: accent, width: 1.4),
                right: BorderSide(color: accent, width: 1.4),
                top: BorderSide(color: accent.withValues(alpha: 0.4)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: placardLines
                  .map(
                    (String l) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '◆ ',
                            style: TextStyle(color: accent, fontSize: 11),
                          ),
                          Expanded(
                            child: Text(
                              l,
                              style: const TextStyle(
                                color: _kInk,
                                fontFamily: 'serif',
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Cross-section diagram.
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: _kDeepBurgundy,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              border: Border.all(color: accent, width: 1.4),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  crossSectionTitle,
                  style: TextStyle(
                    color: _kSoftGold.withValues(alpha: 0.9),
                    fontFamily: 'serif',
                    fontSize: 11,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: CustomPaint(
                    painter: _SmbawCrossSectionPainter(accent: accent),
                    size: Size.infinite,
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
// Cross-section painter: widget → element → render object.
// ---------------------------------------------------------------------------

class _SmbawCrossSectionPainter extends CustomPainter {
  const _SmbawCrossSectionPainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint box = Paint()
      ..color = _kIvory.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    final Paint border = Paint()
      ..color = accent
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final Paint line = Paint()
      ..color = _kSoftGold.withValues(alpha: 0.6)
      ..strokeWidth = 1.0;

    final double w = (size.width - 20) / 3;
    final double h = size.height - 10;
    final List<String> labels = <String>['Widget', 'Element', 'RenderObject'];

    for (int i = 0; i < 3; i++) {
      final Rect r = Rect.fromLTWH(i * (w + 10), 5, w, h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        box,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        border,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: _kIvory,
            fontFamily: 'serif',
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2 - 4),
      );
      final TextPainter tp2 = TextPainter(
        text: TextSpan(
          text: _abbrev(labels[i]),
          style: TextStyle(
            color: _kSoftGold.withValues(alpha: 0.9),
            fontFamily: 'monospace',
            fontSize: 8,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp2.paint(
        canvas,
        Offset(r.center.dx - tp2.width / 2, r.center.dy + 4),
      );
    }

    // Connecting arrows.
    for (int i = 0; i < 2; i++) {
      final double x1 = (i + 1) * w + i * 10;
      final double x2 = x1 + 10;
      final double y = size.height / 2;
      canvas.drawLine(Offset(x1, y), Offset(x2, y), line);
      final Path head = Path()
        ..moveTo(x2, y)
        ..lineTo(x2 - 3, y - 3)
        ..lineTo(x2 - 3, y + 3)
        ..close();
      canvas.drawPath(head, Paint()..color = _kSoftGold);
    }
  }

  String _abbrev(String label) {
    switch (label) {
      case 'Widget':
        return 'SMBAdaptor';
      case 'Element':
        return 'SMBAElement';
      case 'RenderObject':
        return 'RenderSMBA';
    }
    return '';
  }

  @override
  bool shouldRepaint(covariant _SmbawCrossSectionPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

// ---------------------------------------------------------------------------
// Plinth 1 — SliverList. Specimen: variable-height poetry stanzas.
// ---------------------------------------------------------------------------

class _SmbawPlinthSliverList extends StatelessWidget {
  const _SmbawPlinthSliverList();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> stanzas = <Map<String, String>>[
      <String, String>{'t': 'I', 'l': 'A single line'},
      <String, String>{
        't': 'II',
        'l': 'Two measured breaths\nupon a sliver afternoon',
      },
      <String, String>{'t': 'III', 'l': 'Tiny'},
      <String, String>{
        't': 'IV',
        'l':
            'A stanza whose weight varies with its words\n'
            'and whose height the list must patiently resolve\n'
            'line by lazy line',
      },
      <String, String>{'t': 'V', 'l': 'Middling, even-footed'},
      <String, String>{'t': 'VI', 'l': 'Brief'},
      <String, String>{
        't': 'VII',
        'l':
            'The seventh stanza sprawls awhile\n'
            'before yielding to the scroll',
      },
      <String, String>{'t': 'VIII', 'l': 'Short'},
      <String, String>{'t': 'IX', 'l': 'Penultimate thought'},
      <String, String>{'t': 'X', 'l': 'Epilogue'},
      <String, String>{
        't': 'XI',
        'l':
            'A postscript of several lines\n'
            'musing on lazy loading\n'
            'and the patient delegate',
      },
      <String, String>{'t': 'XII', 'l': 'Twelve.'},
      <String, String>{'t': 'XIII', 'l': 'Superstitious but brief'},
      <String, String>{
        't': 'XIV',
        'l': 'Fourteenth of twenty\nstill variable',
      },
      <String, String>{'t': 'XV', 'l': 'A quarter-closing note'},
      <String, String>{'t': 'XVI', 'l': 'Sixteen'},
      <String, String>{
        't': 'XVII',
        'l':
            'A sprawling verse\n'
            'that rebukes the fixed-extent list\n'
            'and praises the flexible one',
      },
      <String, String>{'t': 'XVIII', 'l': 'Almost there'},
      <String, String>{'t': 'XIX', 'l': 'Penultimate again'},
      <String, String>{'t': 'XX', 'l': 'Finis'},
    ];
    return _SmbawPlinthShell(
      accent: _kGold,
      label: 'SliverList',
      subtitle: 'Variable-height children',
      placardLines: const <String>[
        'Use when children have unpredictable heights.',
        'Each child is measured on demand.',
        'Ideal for feeds, poems, variable cards.',
      ],
      specimen: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Map<String, String> s = stanzas[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kIvory,
                    border: Border(
                      left: BorderSide(color: _kGold, width: 3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        s['t']!,
                        style: const TextStyle(
                          color: _kBurgundy,
                          fontFamily: 'serif',
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        s['l']!,
                        style: const TextStyle(
                          color: _kInk,
                          fontFamily: 'serif',
                          fontSize: 11,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: stanzas.length,
            ),
          ),
        ],
      ),
      crossSectionTitle: 'WIDGET TIER · CHAIN',
    );
  }
}

// ---------------------------------------------------------------------------
// Plinth 2 — SliverGrid. Specimen: 2D tile mosaic of emblem glyphs.
// ---------------------------------------------------------------------------

class _SmbawPlinthSliverGrid extends StatelessWidget {
  const _SmbawPlinthSliverGrid();

  @override
  Widget build(BuildContext context) {
    const List<IconData> glyphs = <IconData>[
      Icons.shield,
      Icons.emoji_events,
      Icons.diamond,
      Icons.star,
      Icons.favorite,
      Icons.local_florist,
      Icons.spa,
      Icons.park,
      Icons.auto_awesome,
      Icons.brightness_5,
      Icons.filter_vintage,
      Icons.bubble_chart,
      Icons.hdr_weak,
      Icons.blur_on,
      Icons.grain,
      Icons.spoke,
      Icons.hive,
      Icons.flare,
      Icons.ac_unit,
      Icons.whatshot,
    ];
    return _SmbawPlinthShell(
      accent: const Color(0xFFD4B463),
      label: 'SliverGrid',
      subtitle: '2D arrangement via grid delegate',
      placardLines: const <String>[
        'Use when children lay out in a 2D grid.',
        'Driven by a SliverGridDelegate.',
        'Perfect for icon grids, photo mosaics.',
      ],
      specimen: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: _kBurgundy,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _kGold, width: 1),
                    ),
                    child: Center(
                      child: Icon(
                        glyphs[index],
                        color: _kSoftGold,
                        size: 22,
                      ),
                    ),
                  );
                },
                childCount: glyphs.length,
              ),
            ),
          ),
        ],
      ),
      crossSectionTitle: 'WIDGET TIER · CHAIN',
    );
  }
}

// ---------------------------------------------------------------------------
// Plinth 3 — SliverFixedExtentList. Specimen: chapter ledger rows (72px each).
// ---------------------------------------------------------------------------

class _SmbawPlinthSliverFixedExtent extends StatelessWidget {
  const _SmbawPlinthSliverFixedExtent();

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> chapters = <Map<String, String>>[
      <String, String>{'n': '01', 't': 'Overture', 'p': '003'},
      <String, String>{'n': '02', 't': 'The Delegate', 'p': '014'},
      <String, String>{'n': '03', 't': 'Lazy Children', 'p': '027'},
      <String, String>{'n': '04', 't': 'Extent & Axis', 'p': '039'},
      <String, String>{'n': '05', 't': 'Element Tier', 'p': '052'},
      <String, String>{'n': '06', 't': 'Render Object', 'p': '067'},
      <String, String>{'n': '07', 't': 'Keep Alive', 'p': '081'},
      <String, String>{'n': '08', 't': 'Semantic Indexes', 'p': '094'},
      <String, String>{'n': '09', 't': 'Prototype Dance', 'p': '108'},
      <String, String>{'n': '10', 't': 'Grid Mechanics', 'p': '120'},
      <String, String>{'n': '11', 't': 'Performance', 'p': '133'},
      <String, String>{'n': '12', 't': 'Pitfalls', 'p': '145'},
      <String, String>{'n': '13', 't': 'Scroll Physics', 'p': '158'},
      <String, String>{'n': '14', 't': 'Sliver Coords', 'p': '170'},
      <String, String>{'n': '15', 't': 'Geometry', 'p': '183'},
      <String, String>{'n': '16', 't': 'Cache Extent', 'p': '196'},
      <String, String>{'n': '17', 't': 'Paint Extent', 'p': '208'},
      <String, String>{'n': '18', 't': 'Layout Extent', 'p': '219'},
      <String, String>{'n': '19', 't': 'Finale', 'p': '231'},
      <String, String>{'n': '20', 't': 'Colophon', 'p': '243'},
    ];
    return _SmbawPlinthShell(
      accent: const Color(0xFFB9923A),
      label: 'SliverFixedExtentList',
      subtitle: 'Uniform main-axis extent',
      placardLines: const <String>[
        'Use when every child has the SAME extent.',
        'Faster — no measurement needed.',
        'Great for fixed-row ledgers, timetables.',
      ],
      specimen: CustomScrollView(
        slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: 44,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Map<String, String> c = chapters[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? _kIvory
                        : _kParchment.withValues(alpha: 0.8),
                    border: Border.all(
                      color: _kGold.withValues(alpha: 0.3),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 24,
                        alignment: Alignment.center,
                        child: Text(
                          c['n']!,
                          style: const TextStyle(
                            color: _kBurgundy,
                            fontFamily: 'serif',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          c['t']!,
                          style: const TextStyle(
                            color: _kInk,
                            fontFamily: 'serif',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        c['p']!,
                        style: TextStyle(
                          color: _kInk.withValues(alpha: 0.6),
                          fontFamily: 'monospace',
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: chapters.length,
            ),
          ),
        ],
      ),
      crossSectionTitle: 'WIDGET TIER · CHAIN',
    );
  }
}

// ---------------------------------------------------------------------------
// Plinth 4 — SliverPrototypeExtentList. Specimen: badge cards sized by prototype.
// ---------------------------------------------------------------------------

class _SmbawPlinthSliverPrototypeExtent extends StatelessWidget {
  const _SmbawPlinthSliverPrototypeExtent();

  @override
  Widget build(BuildContext context) {
    const List<String> badges = <String>[
      'Archivist',
      'Apprentice',
      'Curator',
      'Scholar',
      'Patron',
      'Fellow',
      'Laureate',
      'Historian',
      'Conservator',
      'Engraver',
      'Illuminator',
      'Bookbinder',
      'Keeper',
      'Herald',
      'Scribe',
      'Mason',
      'Sculptor',
      'Guilder',
      'Steward',
      'Emeritus',
    ];
    return _SmbawPlinthShell(
      accent: const Color(0xFFE1C27A),
      label: 'SliverPrototypeExtentList',
      subtitle: 'Extent copied from a prototype',
      placardLines: const <String>[
        'Use when ONE prototype sets the extent.',
        'Extent derived from the prototype child.',
        'Ideal for galleries of same-kind cards.',
      ],
      specimen: CustomScrollView(
        slivers: <Widget>[
          SliverPrototypeExtentList(
            prototypeItem: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              padding: const EdgeInsets.all(10),
              child: const Text('Prototype', style: TextStyle(fontSize: 13)),
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kBurgundy,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _kGold, width: 1),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.workspace_premium,
                        color: _kSoftGold,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          badges[index],
                          style: const TextStyle(
                            color: _kIvory,
                            fontFamily: 'serif',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '#${(index + 1).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: _kSoftGold.withValues(alpha: 0.9),
                          fontFamily: 'monospace',
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: badges.length,
            ),
          ),
        ],
      ),
      crossSectionTitle: 'WIDGET TIER · CHAIN',
    );
  }
}

// ---------------------------------------------------------------------------
// Comparison table — hand-built DataTable across adaptors.
// ---------------------------------------------------------------------------

class _SmbawComparisonTable extends StatelessWidget {
  const _SmbawComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SmbawSectionHeader(
          eyebrow: 'GALLERY · EXHIBIT B',
          title: 'Comparative Specimen Table',
          lead:
              'A hand-built DataTable cross-checking each adaptor against the '
              'four essential questions of sliver geometry.',
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: _kParchment,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kGold, width: 1.2),
          ),
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                _kBurgundy.withValues(alpha: 0.1),
              ),
              dataRowMinHeight: 48,
              dataRowMaxHeight: 64,
              columnSpacing: 26,
              border: TableBorder.all(
                color: _kGold.withValues(alpha: 0.4),
                width: 0.6,
              ),
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Adaptor',
                    style: TextStyle(
                      color: _kBurgundy,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Variable height?',
                    style: TextStyle(
                      color: _kBurgundy,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Uniform extent?',
                    style: TextStyle(
                      color: _kBurgundy,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Prototype-based?',
                    style: TextStyle(
                      color: _kBurgundy,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Grid layout?',
                    style: TextStyle(
                      color: _kBurgundy,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                _buildRow('SliverList', 'Yes', 'No', 'No', 'No'),
                _buildRow('SliverGrid', 'Per axis', 'No', 'No', 'Yes'),
                _buildRow(
                  'SliverFixedExtentList',
                  'No',
                  'Yes — itemExtent',
                  'No',
                  'No',
                ),
                _buildRow(
                  'SliverPrototypeExtentList',
                  'No',
                  'Yes — from prototype',
                  'Yes',
                  'No',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildRow(String a, String b, String c, String d, String e) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
          Text(
            a,
            style: const TextStyle(
              color: _kDeepBurgundy,
              fontFamily: 'serif',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        DataCell(_cell(b)),
        DataCell(_cell(c)),
        DataCell(_cell(d)),
        DataCell(_cell(e)),
      ],
    );
  }

  Widget _cell(String s) {
    final bool yes = s.toLowerCase().startsWith('yes');
    final bool no = s.toLowerCase() == 'no';
    final Color tint = yes
        ? _kGold
        : no
            ? _kInk.withValues(alpha: 0.45)
            : _kBurgundy.withValues(alpha: 0.75);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          yes
              ? Icons.check_circle
              : no
                  ? Icons.remove_circle_outline
                  : Icons.adjust,
          size: 14,
          color: tint,
        ),
        const SizedBox(width: 6),
        Text(
          s,
          style: TextStyle(
            color: tint,
            fontFamily: 'serif',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Constructor-anatomy grid — four RichText cards highlighting params.
// ---------------------------------------------------------------------------

class _SmbawConstructorAnatomyGrid extends StatelessWidget {
  const _SmbawConstructorAnatomyGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SmbawSectionHeader(
          eyebrow: 'GALLERY · EXHIBIT C',
          title: 'Constructor Anatomy',
          lead:
              'Each card dissects one concrete subclass constructor, tinting '
              'the salient parameters in gold and burgundy.',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final int cols = c.maxWidth < 720 ? 1 : 2;
            const List<_SmbawAnatomy> anatomies = <_SmbawAnatomy>[
              _SmbawAnatomy(
                name: 'SliverList',
                code: 'SliverList({\n'
                    '  Key? key,\n'
                    '  required SliverChildDelegate delegate,\n'
                    '})',
                highlights: <String>['delegate'],
                notes:
                    'Accepts any SliverChildDelegate. No extent fields — each '
                    'child is measured on demand by the render object.',
              ),
              _SmbawAnatomy(
                name: 'SliverGrid',
                code: 'SliverGrid({\n'
                    '  Key? key,\n'
                    '  required SliverChildDelegate delegate,\n'
                    '  required SliverGridDelegate gridDelegate,\n'
                    '})',
                highlights: <String>['delegate', 'gridDelegate'],
                notes:
                    'The grid delegate chooses layout strategy: fixed cross-axis '
                    'count or max cross-axis extent. The child delegate still '
                    'lazily supplies children.',
              ),
              _SmbawAnatomy(
                name: 'SliverFixedExtentList',
                code: 'SliverFixedExtentList({\n'
                    '  Key? key,\n'
                    '  required SliverChildDelegate delegate,\n'
                    '  required double itemExtent,\n'
                    '})',
                highlights: <String>['delegate', 'itemExtent'],
                notes:
                    'itemExtent fixes every child’s main-axis size in logical '
                    'pixels. Layout becomes O(1) to locate any child by index.',
              ),
              _SmbawAnatomy(
                name: 'SliverPrototypeExtentList',
                code: 'SliverPrototypeExtentList({\n'
                    '  Key? key,\n'
                    '  required SliverChildDelegate delegate,\n'
                    '  required Widget prototypeItem,\n'
                    '})',
                highlights: <String>['delegate', 'prototypeItem'],
                notes:
                    'prototypeItem is measured once; its extent becomes the '
                    'uniform extent for all children. Useful when the extent '
                    'isn’t known in pixels but can be inferred from a sample.',
              ),
            ];
            final List<Widget> rows = <Widget>[];
            for (int i = 0; i < anatomies.length; i += cols) {
              final List<Widget> rowChildren = <Widget>[];
              for (int j = 0; j < cols; j++) {
                if (i + j < anatomies.length) {
                  rowChildren.add(
                    Expanded(
                      child: _SmbawAnatomyCard(anatomy: anatomies[i + j]),
                    ),
                  );
                  if (j < cols - 1 && i + j + 1 < anatomies.length) {
                    rowChildren.add(const SizedBox(width: 14));
                  }
                } else {
                  rowChildren.add(const Expanded(child: SizedBox.shrink()));
                }
              }
              rows.add(
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rowChildren,
                  ),
                ),
              );
            }
            return Column(children: rows);
          },
        ),
      ],
    );
  }
}

class _SmbawAnatomy {
  const _SmbawAnatomy({
    required this.name,
    required this.code,
    required this.highlights,
    required this.notes,
  });

  final String name;
  final String code;
  final List<String> highlights;
  final String notes;
}

class _SmbawAnatomyCard extends StatelessWidget {
  const _SmbawAnatomyCard({required this.anatomy});

  final _SmbawAnatomy anatomy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kIvory,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kShadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _kBurgundy,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  anatomy.name,
                  style: const TextStyle(
                    color: _kIvory,
                    fontFamily: 'serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: _kGold.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kDeepBurgundy,
              borderRadius: BorderRadius.circular(6),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.45,
                  color: _kIvory,
                ),
                children: _highlightCode(anatomy.code, anatomy.highlights),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            anatomy.notes,
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.82),
              fontFamily: 'serif',
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  List<InlineSpan> _highlightCode(String code, List<String> highlights) {
    final List<InlineSpan> spans = <InlineSpan>[];
    final List<String> keywords = <String>['required', 'Key?', 'Widget', 'double'];
    final RegExp token = RegExp(r'(\w+\??)|(\W+)');
    for (final RegExpMatch m in token.allMatches(code)) {
      final String t = m.group(0)!;
      if (highlights.contains(t)) {
        spans.add(
          TextSpan(
            text: t,
            style: const TextStyle(
              color: _kGold,
              fontWeight: FontWeight.w700,
              backgroundColor: Color(0x33C9A34E),
            ),
          ),
        );
      } else if (keywords.contains(t)) {
        spans.add(
          TextSpan(
            text: t,
            style: const TextStyle(
              color: _kSoftGold,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: t));
      }
    }
    return spans;
  }
}

// ---------------------------------------------------------------------------
// Incorrect-vs-correct pair — ListView-in-CustomScrollView vs SliverList.
// ---------------------------------------------------------------------------

class _SmbawIncorrectVsCorrectPair extends StatelessWidget {
  const _SmbawIncorrectVsCorrectPair();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SmbawSectionHeader(
          eyebrow: 'GALLERY · EXHIBIT D',
          title: 'Two Specimens, One Lesson',
          lead:
              'On the left, a ListView nested inside a CustomScrollView — a '
              'classic overflow. On the right, the same content wrapped in a '
              'SliverList, scrolling as nature intended.',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final bool stack = c.maxWidth < 680;
            final Widget wrong = _SmbawFrame(
              title: '✖  Incorrect',
              accent: const Color(0xFF9B2F3A),
              caption:
                  'ListView inside a CustomScrollView forces an unbounded '
                  'viewport — children overflow and no scroll is coordinated.',
              child: _SmbawWrongSample(),
            );
            final Widget right = _SmbawFrame(
              title: '✓  Correct',
              accent: _kGold,
              caption:
                  'A SliverList participates in the surrounding '
                  'CustomScrollView — children scroll in concert.',
              child: _SmbawRightSample(),
            );
            if (stack) {
              return Column(
                children: <Widget>[wrong, const SizedBox(height: 14), right],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: wrong),
                const SizedBox(width: 14),
                Expanded(child: right),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SmbawFrame extends StatelessWidget {
  const _SmbawFrame({
    required this.title,
    required this.accent,
    required this.caption,
    required this.child,
  });

  final String title;
  final Color accent;
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kIvory,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1.4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontFamily: 'serif',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.78),
              fontFamily: 'serif',
              fontStyle: FontStyle.italic,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _kParchment,
                  border: Border.all(
                    color: accent.withValues(alpha: 0.5),
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmbawWrongSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Intentionally shown as an explanatory mock; we simulate the overflow
    // pictorially rather than actually throwing at layout time.
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _SmbawOverflowPainter(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                color: const Color(0xFF9B2F3A),
                child: const Text(
                  'CustomScrollView > ListView.builder(…)',
                  style: TextStyle(
                    color: _kIvory,
                    fontFamily: 'monospace',
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              ...List<Widget>.generate(6, (int i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _kIvory,
                    border: Border.all(
                      color: const Color(0xFF9B2F3A).withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    'row $i — overflow beyond viewport',
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 11,
                      color: _kInk,
                    ),
                  ),
                );
              }),
              const Text(
                '▼  overflow continues…',
                style: TextStyle(
                  color: Color(0xFF9B2F3A),
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmbawOverflowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = const Color(0xFF9B2F3A).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    for (double y = 0; y < size.height; y += 8) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 3), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SmbawRightSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              color: _kGold,
              child: const Text(
                'CustomScrollView > SliverList(…)',
                style: TextStyle(
                  color: _kDeepBurgundy,
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _kIvory,
                  border: Border(
                    left: BorderSide(color: _kGold, width: 3),
                  ),
                ),
                child: Text(
                  'row $index — participates in scroll',
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 11,
                    color: _kInk,
                  ),
                ),
              );
            },
            childCount: 40,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Spec-sheet tabs — one TabBar tab per concrete adaptor.
// ---------------------------------------------------------------------------

class _SmbawSpecSheetTabs extends StatelessWidget {
  const _SmbawSpecSheetTabs();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SmbawSectionHeader(
          eyebrow: 'GALLERY · EXHIBIT E',
          title: 'Curator’s Spec Sheets',
          lead:
              'Tab through technical placards for each concrete subclass — '
              'base class, render object and primary delegate properties.',
        ),
        const SizedBox(height: 16),
        DefaultTabController(
          length: 4,
          child: Container(
            decoration: BoxDecoration(
              color: _kIvory,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kGold, width: 1.2),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: _kBurgundy,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(9),
                    ),
                  ),
                  child: const TabBar(
                    indicatorColor: _kGold,
                    indicatorWeight: 3,
                    labelColor: _kIvory,
                    unselectedLabelColor: _kSoftGold,
                    labelStyle: TextStyle(
                      fontFamily: 'serif',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(text: 'SliverList'),
                      Tab(text: 'SliverGrid'),
                      Tab(text: 'SliverFixedExtentList'),
                      Tab(text: 'SliverPrototypeExtentList'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 260,
                  child: TabBarView(
                    children: <Widget>[
                      _SmbawSpecSheet(
                        adaptor: 'SliverList',
                        baseClass: 'SliverMultiBoxAdaptorWidget',
                        renderObject: 'RenderSliverList',
                        element: 'SliverMultiBoxAdaptorElement',
                        keyProps: <String>['delegate'],
                        summary:
                            'Scrolls a linear list of variable-height '
                            'children within a CustomScrollView. Each child '
                            'is laid out on demand; siblings’ positions are '
                            'a running sum of the preceding children.',
                      ),
                      _SmbawSpecSheet(
                        adaptor: 'SliverGrid',
                        baseClass: 'SliverMultiBoxAdaptorWidget',
                        renderObject: 'RenderSliverGrid',
                        element: 'SliverMultiBoxAdaptorElement',
                        keyProps: <String>['delegate', 'gridDelegate'],
                        summary:
                            'Lays children out in a 2D grid. The gridDelegate '
                            '(typically SliverGridDelegateWithFixedCrossAxis'
                            'Count or …MaxCrossAxisExtent) computes the tile '
                            'geometry; the child delegate supplies widgets.',
                      ),
                      _SmbawSpecSheet(
                        adaptor: 'SliverFixedExtentList',
                        baseClass: 'SliverMultiBoxAdaptorWidget',
                        renderObject: 'RenderSliverFixedExtentList',
                        element: 'SliverMultiBoxAdaptorElement',
                        keyProps: <String>['delegate', 'itemExtent'],
                        summary:
                            'Optimised for uniformly-sized children. Because '
                            'itemExtent is known up front, the child at any '
                            'scroll offset can be located with a single '
                            'division — no child-by-child measurement.',
                      ),
                      _SmbawSpecSheet(
                        adaptor: 'SliverPrototypeExtentList',
                        baseClass: 'SliverMultiBoxAdaptorWidget',
                        renderObject: 'RenderSliverFixedExtentBoxAdaptor',
                        element: 'SliverMultiBoxAdaptorElement',
                        keyProps: <String>['delegate', 'prototypeItem'],
                        summary:
                            'Derives a uniform extent from a prototype widget '
                            'rather than a literal pixel value. Ideal when '
                            'extent depends on text, theme or content but the '
                            'exact pixel count is inconvenient to compute.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SmbawSpecSheet extends StatelessWidget {
  const _SmbawSpecSheet({
    required this.adaptor,
    required this.baseClass,
    required this.renderObject,
    required this.element,
    required this.keyProps,
    required this.summary,
  });

  final String adaptor;
  final String baseClass;
  final String renderObject;
  final String element;
  final List<String> keyProps;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  adaptor,
                  style: const TextStyle(
                    color: _kDeepBurgundy,
                    fontFamily: 'serif',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Container(height: 2, width: 60, color: _kGold),
                const SizedBox(height: 10),
                Text(
                  summary,
                  style: TextStyle(
                    color: _kInk.withValues(alpha: 0.82),
                    fontFamily: 'serif',
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kParchment,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _kGold.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _specRow('Base class', baseClass),
                  _specRow('Element', element),
                  _specRow('Render object', renderObject),
                  _specRow('Key props', keyProps.join(', ')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: _kBurgundy,
                fontFamily: 'serif',
                fontSize: 11,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pitfall card — don't instantiate the base directly.
// ---------------------------------------------------------------------------

class _SmbawPitfallCard extends StatelessWidget {
  const _SmbawPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kDeepBurgundy, _kBurgundy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold, width: 1.4),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _kGold,
              shape: BoxShape.circle,
              border: Border.all(color: _kSoftGold, width: 2),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: _kDeepBurgundy,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PITFALL · DO NOT INSTANTIATE THE BASE DIRECTLY',
                  style: TextStyle(
                    color: _kSoftGold.withValues(alpha: 0.95),
                    fontFamily: 'serif',
                    fontSize: 12,
                    letterSpacing: 2.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'SliverMultiBoxAdaptorWidget is abstract — it defines the '
                  'delegate contract and element factory, but does NOT '
                  'provide a createRenderObject. Always pick one of the four '
                  'concrete subclasses (SliverList, SliverGrid, '
                  'SliverFixedExtentList, SliverPrototypeExtentList).',
                  style: TextStyle(
                    color: _kIvory,
                    fontFamily: 'serif',
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _kShadow.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '// ✖ Abstract — cannot be constructed\n'
                    '// new SliverMultiBoxAdaptorWidget(...)\n'
                    '\n'
                    '// ✓ Pick a subclass\n'
                    'SliverList(delegate: ...)',
                    style: TextStyle(
                      color: _kSoftGold,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.5,
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
}

// ---------------------------------------------------------------------------
// Footer plate — small colophon with gallery signature.
// ---------------------------------------------------------------------------

class _SmbawFooterPlate extends StatelessWidget {
  const _SmbawFooterPlate();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kGold.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.auto_stories, color: _kBurgundy, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Widget-Tier Adaptor Gallery · Companion 410 covers the element tier.',
              style: TextStyle(
                color: _kInk.withValues(alpha: 0.8),
                fontFamily: 'serif',
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            'SMBAW · vIII',
            style: TextStyle(
              color: _kBurgundy.withValues(alpha: 0.85),
              fontFamily: 'monospace',
              fontSize: 11,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
