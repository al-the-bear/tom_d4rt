// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

// =============================================================================
// NotchedShape - Visual Deep Demo
// =============================================================================
//
// This file is a long-form, hand-authored, analyzer-clean exploration of the
// `NotchedShape` family of classes from package:flutter/material.dart. It
// focuses on the abstract `NotchedShape` API, its two concrete subclasses
// (`CircularNotchedRectangle` and `AutomaticNotchedShape`), and the geometric
// contract behind `getOuterPath(Rect host, Rect? guest)`.
//
// The most common consumer of `NotchedShape` is `BottomAppBar`. When a
// `FloatingActionButton` is docked onto a `BottomAppBar`, the bar's `shape`
// (a `NotchedShape`) is used to cut a rounded notch out of the bar's
// silhouette so that the FAB appears to nest inside it. The geometry is
// driven by:
//
//   * `host`  - the `Rect` describing the bar (the shape being notched).
//   * `guest` - the `Rect` describing the FAB (or null if no FAB is docked).
//   * `notchMargin` - extra padding around the guest, applied by `BottomAppBar`.
//
// Sections:
//   1.  Hero
//   2.  Anatomy of NotchedShape (the abstract API)
//   3.  Live BottomAppBar + FAB demo (CircularNotchedRectangle, real widget)
//   4.  CustomPainter notch visualization (red stroke along the cut path)
//   5.  AutomaticNotchedShape explainer (RoundedRectangleBorder + CircleBorder)
//   6.  getOuterPath(Rect, Rect?) signature card
//   7.  Geometry diagram (host rect, guest oval, notch radius)
//   8.  Three notch variants (small / medium / large guest size)
//   9.  Comparison table NotchedShape vs ShapeBorder
//  10.  Common pitfalls
//  11.  Code recipes (BottomAppBar.shape, manual ShapeBorder, custom notched)
//  12.  CircularNotchedRectangle internals (transition curves)
//  13.  Cookbook: notch on top vs notch on bottom
//  14.  References & links
//  15.  Footer
//
// Constraints:
//   * Single import: package:flutter/material.dart.
//   * No setState / AnimationController / Timer / Future / Stream / async.
//   * No controllers of any kind. Pure declarative widget tree.
//   * Color.withValues(alpha: ...) for translucent colors.
//
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------
//
// All colors are centralized so the demo reads consistently. The palette
// leans into a deep teal / coral pairing so the notch geometry pops against
// the bar surface in section 3 and section 4.

class _Palette {
  static const Color background = Color(0xFFF6F8FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFD8DEE8);
  static const Color textPrimary = Color(0xFF1B2333);
  static const Color textSecondary = Color(0xFF5C6479);
  static const Color textMuted = Color(0xFF8C95A8);
  static const Color accent = Color(0xFF0F766E);
  static const Color accentSoft = Color(0xFFCCFBF1);
  static const Color coral = Color(0xFFE85A4F);
  static const Color coralSoft = Color(0xFFFEE2DF);
  static const Color amber = Color(0xFFD97706);
  static const Color amberSoft = Color(0xFFFEF3C7);
  static const Color violet = Color(0xFF7C3AED);
  static const Color violetSoft = Color(0xFFEDE9FE);
  static const Color slate = Color(0xFF334155);
  static const Color slateSoft = Color(0xFFE2E8F0);
  static const Color codeBg = Color(0xFF0F172A);
  static const Color codeFg = Color(0xFFE2E8F0);
  static const Color codeKey = Color(0xFF93C5FD);
  static const Color codeStr = Color(0xFFFBBF24);
  static const Color codeCmt = Color(0xFF64748B);
  static const Color barFill = Color(0xFF1F2937);
  static const Color barEdge = Color(0xFFFB7185);
}

// -----------------------------------------------------------------------------
// Top-level entry point
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NotchedShape - Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _Palette.background,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _Palette.accent,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: _Palette.textPrimary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    ),
    home: const _DemoHome(),
  );
}

// -----------------------------------------------------------------------------
// Demo home - vertical scroll of sections
// -----------------------------------------------------------------------------

class _DemoHome extends StatelessWidget {
  const _DemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Palette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _HeroSection(),
              SizedBox(height: 28),
              _AnatomySection(),
              SizedBox(height: 28),
              _LiveBottomAppBarSection(),
              SizedBox(height: 28),
              _PainterVisualizationSection(),
              SizedBox(height: 28),
              _AutomaticNotchedShapeSection(),
              SizedBox(height: 28),
              _SignatureCardSection(),
              SizedBox(height: 28),
              _GeometryDiagramSection(),
              SizedBox(height: 28),
              _NotchVariantsSection(),
              SizedBox(height: 28),
              _ComparisonTableSection(),
              SizedBox(height: 28),
              _PitfallsSection(),
              SizedBox(height: 28),
              _RecipesSection(),
              SizedBox(height: 28),
              _CircularInternalsSection(),
              SizedBox(height: 28),
              _CookbookSection(),
              SizedBox(height: 28),
              _ReferencesSection(),
              SizedBox(height: 28),
              _FooterSection(),
              SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 1 - Hero
// -----------------------------------------------------------------------------
//
// The hero introduces NotchedShape with the fundamental question it answers:
// "How does the BottomAppBar know how to cut a hole around the FAB?"

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.fromLTRB(36, 36, 36, 36),
      gradient: const LinearGradient(
        colors: [Color(0xFF0F766E), Color(0xFF0E7490)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ChipText(
                text: 'painting / NotchedShape',
                bg: Colors.white.withValues(alpha: 0.15),
                fg: Colors.white,
              ),
              const SizedBox(width: 8),
              _ChipText(
                text: 'Material',
                bg: Colors.white.withValues(alpha: 0.15),
                fg: Colors.white,
              ),
              const SizedBox(width: 8),
              _ChipText(
                text: 'BottomAppBar.shape',
                bg: Colors.white.withValues(alpha: 0.15),
                fg: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'NotchedShape',
            style: TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A shape with a notch in its outline.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'NotchedShape describes a closed outer path that has a bite '
            'taken out of one edge to host a guest widget - most often a '
            'FloatingActionButton docked onto a BottomAppBar. The class is '
            'abstract: subclasses provide the geometric recipe for the bite.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 15,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _MetricTile(
                label: 'Subclasses',
                value: '2',
                hint: 'Circular + Automatic',
              ),
              const SizedBox(width: 14),
              _MetricTile(
                label: 'Method',
                value: '1',
                hint: 'getOuterPath',
              ),
              const SizedBox(width: 14),
              _MetricTile(
                label: 'Inputs',
                value: 'host + guest',
                hint: 'Rect + Rect?',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 2 - Anatomy of NotchedShape
// -----------------------------------------------------------------------------

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '02',
            title: 'Anatomy of NotchedShape',
            subtitle:
                'An abstract class with a single method describing how to '
                'carve a guest-shaped bite out of a host rectangle.',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AnatomyEntry(
                  badge: 'abstract',
                  badgeColor: _Palette.violet,
                  title: 'NotchedShape',
                  body:
                      'The base class. It declares only one method: '
                      'getOuterPath(Rect host, Rect? guest). Concrete '
                      'subclasses decide how the notch is shaped and how '
                      'it transitions into the host.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AnatomyEntry(
                  badge: 'subclass',
                  badgeColor: _Palette.accent,
                  title: 'CircularNotchedRectangle',
                  body:
                      'A rectangle with a smooth circular notch on its top '
                      'edge. The notch is sized to fit the guest rect '
                      'expanded by notchMargin. This is the default shape '
                      'used by BottomAppBar.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AnatomyEntry(
                  badge: 'subclass',
                  badgeColor: _Palette.coral,
                  title: 'AutomaticNotchedShape',
                  body:
                      'Combines two ShapeBorders: one for the host outline '
                      '(e.g. RoundedRectangleBorder) and one for the guest '
                      'silhouette (e.g. CircleBorder). The guest path is '
                      'subtracted from the host path.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _Divider(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _BulletList(
                  title: 'When to use NotchedShape',
                  items: const [
                    'You want a BottomAppBar with a docked FAB.',
                    'You need a custom container with a hole for a child.',
                    'You are subclassing a Material container that takes '
                        'a NotchedShape parameter.',
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _BulletList(
                  title: 'When NOT to use NotchedShape',
                  items: const [
                    'You just want a rounded container - use ShapeBorder.',
                    'You need clipping for any reason other than a guest '
                        'widget - use ClipPath or ClipRRect.',
                    'You want to draw a complex outline that does not '
                        'depend on a guest rect.',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 3 - Live BottomAppBar + FAB demo
// -----------------------------------------------------------------------------
//
// This is the canonical use of NotchedShape. We render an actual
// BottomAppBar with shape: CircularNotchedRectangle() and a FAB centered
// over it. Because the demo is not using a real Scaffold (we're inside a
// SingleChildScrollView), we use a fake-Scaffold composition: a Stack with
// the bar at the bottom and the FAB overlapping it.

class _LiveBottomAppBarSection extends StatelessWidget {
  const _LiveBottomAppBarSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '03',
            title: 'Live BottomAppBar + FAB demo',
            subtitle:
                'A real BottomAppBar with shape: CircularNotchedRectangle() '
                'and a FAB that appears to nest in the carved notch.',
          ),
          const SizedBox(height: 18),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: _Palette.slateSoft,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _Palette.outline),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: _Palette.slateSoft,
                    child: Center(
                      child: Text(
                        'page content',
                        style: TextStyle(
                          color: _Palette.textSecondary
                              .withValues(alpha: 0.7),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomAppBar(
                    color: _Palette.barFill,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 6.0,
                    elevation: 0,
                    height: 64,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.menu, color: Colors.white),
                            SizedBox(width: 16),
                            Icon(Icons.search, color: Colors.white),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.bookmark_outline,
                                color: Colors.white),
                            SizedBox(width: 16),
                            Icon(Icons.more_vert, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 32,
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: null,
                      backgroundColor: _Palette.coral,
                      elevation: 6,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _CodeBlock(
            lines: const [
              _CodeLine.cmt('// BottomAppBar with circular notch'),
              _CodeLine.code('BottomAppBar('),
              _CodeLine.code('  shape: CircularNotchedRectangle(),'),
              _CodeLine.code('  notchMargin: 6.0,'),
              _CodeLine.code('  child: Row(...),'),
              _CodeLine.code(');'),
              _CodeLine.cmt('// FAB docked via Scaffold'),
              _CodeLine.code('Scaffold('),
              _CodeLine.code('  bottomNavigationBar: BottomAppBar(...),'),
              _CodeLine.code('  floatingActionButton: FloatingActionButton(...)'),
              _CodeLine.code('  floatingActionButtonLocation:'),
              _CodeLine.code('      FloatingActionButtonLocation.centerDocked,'),
              _CodeLine.code(');'),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 4 - CustomPainter notch visualization
// -----------------------------------------------------------------------------
//
// In this section, we draw the same `CircularNotchedRectangle` outline
// directly onto a CustomPaint surface, using a thick coral stroke so the
// notch geometry is clearly visible. The host rect and the guest oval are
// also drawn so the relationship is obvious.

class _PainterVisualizationSection extends StatelessWidget {
  const _PainterVisualizationSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '04',
            title: 'CustomPainter notch visualization',
            subtitle:
                'A direct render of getOuterPath(host, guest). The coral '
                'stroke is the path returned by CircularNotchedRectangle.',
          ),
          const SizedBox(height: 18),
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: _Palette.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _Palette.outline),
            ),
            child: CustomPaint(
              painter: _NotchOutlinePainter(),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              _LegendDot(color: _Palette.barEdge, label: 'outer path (notched)'),
              SizedBox(width: 18),
              _LegendDot(color: _Palette.accent, label: 'host rect'),
              SizedBox(width: 18),
              _LegendDot(color: _Palette.violet, label: 'guest rect'),
            ],
          ),
          const SizedBox(height: 16),
          const _Note(
            color: _Palette.amberSoft,
            iconColor: _Palette.amber,
            text:
                'The coral path closes around the notch - it does not draw '
                'an arc and stop. The complete returned outline is a closed '
                'figure, suitable for filling, clipping, or border drawing.',
          ),
        ],
      ),
    );
  }
}

class _NotchOutlinePainter extends CustomPainter {
  const _NotchOutlinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect host = Rect.fromLTWH(
      24,
      size.height * 0.45,
      size.width - 48,
      72,
    );
    final double guestSize = 56;
    final Rect guest = Rect.fromLTWH(
      host.center.dx - guestSize / 2,
      host.top - guestSize / 2 - 2,
      guestSize,
      guestSize,
    );

    final Path outer =
        const CircularNotchedRectangle().getOuterPath(host, guest);

    final Paint fill = Paint()
      ..color = _Palette.barFill.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    canvas.drawPath(outer, fill);

    final Paint stroke = Paint()
      ..color = _Palette.barEdge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    canvas.drawPath(outer, stroke);

    final Paint hostPaint = Paint()
      ..color = _Palette.accent.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(host.deflate(0.5), hostPaint);

    final Paint guestPaint = Paint()
      ..color = _Palette.violet.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(guest, guestPaint);

    final Paint guestOval = Paint()
      ..color = _Palette.violet.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    canvas.drawOval(guest, guestOval);

    final Paint center = Paint()
      ..color = _Palette.textMuted.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(host.center.dx, 8),
      Offset(host.center.dx, host.bottom + 8),
      center,
    );

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'CircularNotchedRectangle.getOuterPath(host, guest)',
        style: const TextStyle(
          color: _Palette.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: size.width - 48);
    tp.paint(canvas, const Offset(24, 14));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// Section 5 - AutomaticNotchedShape explainer
// -----------------------------------------------------------------------------

class _AutomaticNotchedShapeSection extends StatelessWidget {
  const _AutomaticNotchedShapeSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '05',
            title: 'AutomaticNotchedShape',
            subtitle:
                'A NotchedShape built by combining two ShapeBorders: one '
                'for the host (the bar) and one for the guest (the FAB).',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _AutomaticPiece(
                  title: 'host shape',
                  border: 'RoundedRectangleBorder',
                  description:
                      'Defines the outer outline of the bar. The path '
                      'comes from ShapeBorder.getOuterPath(host).',
                  color: _Palette.accent,
                  child: const _PiecePainter(kind: _PieceKind.host),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AutomaticPiece(
                  title: 'guest shape',
                  border: 'CircleBorder',
                  description:
                      'Defines the silhouette of the docked widget. The '
                      'path comes from ShapeBorder.getOuterPath(guest).',
                  color: _Palette.coral,
                  child: const _PiecePainter(kind: _PieceKind.guest),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AutomaticPiece(
                  title: 'combined outline',
                  border: 'host - guest',
                  description:
                      'The guest path is subtracted from the host path '
                      'using Path.combine(PathOperation.difference, ...). '
                      'The result is the notched outline.',
                  color: _Palette.violet,
                  child: const _PiecePainter(kind: _PieceKind.combined),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _CodeBlock(
            lines: const [
              _CodeLine.cmt('// AutomaticNotchedShape: two borders -> notch'),
              _CodeLine.code('const NotchedShape s = AutomaticNotchedShape('),
              _CodeLine.code('  RoundedRectangleBorder('),
              _CodeLine.code('    borderRadius: BorderRadius.all('),
              _CodeLine.code('      Radius.circular(12),'),
              _CodeLine.code('    ),'),
              _CodeLine.code('  ),'),
              _CodeLine.code('  CircleBorder(),'),
              _CodeLine.code(');'),
            ],
          ),
        ],
      ),
    );
  }
}

enum _PieceKind { host, guest, combined }

class _PiecePainter extends StatelessWidget {
  const _PiecePainter({required this.kind});
  final _PieceKind kind;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: CustomPaint(
        painter: _PieceCustomPainter(kind: kind),
      ),
    );
  }
}

class _PieceCustomPainter extends CustomPainter {
  const _PieceCustomPainter({required this.kind});
  final _PieceKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect host = Rect.fromLTWH(
      8,
      size.height - 40,
      size.width - 16,
      32,
    );
    final double guestR = 18;
    final Rect guest = Rect.fromCircle(
      center: Offset(size.width / 2, host.top - 2),
      radius: guestR,
    );

    switch (kind) {
      case _PieceKind.host:
        final Paint p = Paint()..color = _Palette.accent;
        final RRect rr = RRect.fromRectAndRadius(
          host,
          const Radius.circular(8),
        );
        canvas.drawRRect(rr, p);
        break;
      case _PieceKind.guest:
        final Paint p = Paint()..color = _Palette.coral;
        canvas.drawCircle(guest.center, guestR, p);
        break;
      case _PieceKind.combined:
        final Path notched = const CircularNotchedRectangle()
            .getOuterPath(host, guest);
        final Paint p = Paint()..color = _Palette.violet;
        canvas.drawPath(notched, p);
        final Paint outline = Paint()
          ..color = _Palette.coral
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4;
        canvas.drawCircle(guest.center, guestR, outline);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AutomaticPiece extends StatelessWidget {
  const _AutomaticPiece({
    required this.title,
    required this.border,
    required this.description,
    required this.color,
    required this.child,
  });

  final String title;
  final String border;
  final String description;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: _Palette.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            border,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamilyFallback: const ['monospace'],
            ),
          ),
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 6 - getOuterPath signature card
// -----------------------------------------------------------------------------

class _SignatureCardSection extends StatelessWidget {
  const _SignatureCardSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '06',
            title: 'getOuterPath(Rect host, Rect? guest)',
            subtitle:
                'The single method that defines a NotchedShape. Returns '
                'a closed Path describing the outer outline of host with '
                'a guest-shaped notch.',
          ),
          const SizedBox(height: 18),
          _CodeBlock(
            lines: const [
              _CodeLine.cmt('// Method signature on NotchedShape'),
              _CodeLine.code('Path getOuterPath('),
              _CodeLine.code('  Rect host,'),
              _CodeLine.code('  Rect? guest,'),
              _CodeLine.code(');'),
              _CodeLine.cmt(''),
              _CodeLine.cmt('// CircularNotchedRectangle implementation'),
              _CodeLine.code('class CircularNotchedRectangle'),
              _CodeLine.code('    extends NotchedShape {'),
              _CodeLine.code('  @override'),
              _CodeLine.code('  Path getOuterPath(Rect host, Rect? guest) {'),
              _CodeLine.code(
                  '    if (guest == null || !host.overlaps(guest)) {'),
              _CodeLine.code('      return Path()..addRect(host);'),
              _CodeLine.code('    }'),
              _CodeLine.code('    // ... carve a circular notch ...'),
              _CodeLine.code('  }'),
              _CodeLine.code('}'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ParamCard(
                  name: 'host',
                  type: 'Rect',
                  description:
                      'The bounding box of the shape that will be notched. '
                      'For BottomAppBar this is the bar rect.',
                  required: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _ParamCard(
                  name: 'guest',
                  type: 'Rect?',
                  description:
                      'The bounding box of the docked widget (FAB). May '
                      'be null when no FAB is docked, in which case no '
                      'notch is carved and the host is returned as-is.',
                  required: false,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _ParamCard(
                  name: 'returns',
                  type: 'Path',
                  description:
                      'A closed outer path. Suitable for fill, stroke, '
                      'or clipping. Should be the silhouette of the bar '
                      'with the notch carved into the appropriate edge.',
                  required: true,
                  isReturn: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 7 - Geometry diagram
// -----------------------------------------------------------------------------

class _GeometryDiagramSection extends StatelessWidget {
  const _GeometryDiagramSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '07',
            title: 'Geometry of a circular notch',
            subtitle:
                'How the host rect, the guest oval, the notch radius, and '
                'the transition curves relate to one another.',
          ),
          const SizedBox(height: 18),
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: _Palette.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _Palette.outline),
            ),
            child: CustomPaint(
              painter: _GeometryDiagramPainter(),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 14),
          _BulletList(
            title: 'Anatomy of the notch',
            items: const [
              'host: the rect the notch is carved out of (the bar).',
              'guest: the rect the docked widget occupies (the FAB).',
              'notchMargin: extra space around the guest, applied by '
                  'BottomAppBar before invoking getOuterPath.',
              'notch radius: half the width of the inflated guest rect '
                  'plus a fudge factor; the notch arcs around it.',
              'transition curves: short cubic Bezier arcs blending the '
                  'top edge of the host into the notch arc.',
            ],
          ),
        ],
      ),
    );
  }
}

class _GeometryDiagramPainter extends CustomPainter {
  const _GeometryDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect host = Rect.fromLTWH(
      30,
      size.height * 0.55,
      size.width - 60,
      82,
    );
    final double guestSize = 80;
    final Rect guest = Rect.fromLTWH(
      host.center.dx - guestSize / 2,
      host.top - guestSize / 2 - 6,
      guestSize,
      guestSize,
    );

    final Path outer =
        const CircularNotchedRectangle().getOuterPath(host, guest);
    final Paint outerFill = Paint()
      ..color = _Palette.barFill
      ..style = PaintingStyle.fill;
    canvas.drawPath(outer, outerFill);

    final Paint guestPaint = Paint()
      ..color = _Palette.coral
      ..style = PaintingStyle.fill;
    canvas.drawOval(guest, guestPaint);

    final Offset gc = guest.center;
    final double r = guest.width / 2;
    final Paint radius = Paint()
      ..color = _Palette.amber
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(gc, Offset(gc.dx + r, gc.dy), radius);

    _label(canvas,
        text: 'notch radius (r)',
        offset: Offset(gc.dx + r + 6, gc.dy - 6),
        color: _Palette.amber);

    _label(canvas,
        text: 'host',
        offset: Offset(host.left + 8, host.bottom - 18),
        color: Colors.white);

    _label(canvas,
        text: 'guest',
        offset: Offset(gc.dx - 18, gc.dy - 4),
        color: Colors.white);

    final Paint markerPaint = Paint()
      ..color = _Palette.accent
      ..style = PaintingStyle.fill;
    final double approxCurveSpan = r * 1.45;
    canvas.drawCircle(
      Offset(gc.dx - approxCurveSpan, host.top),
      3,
      markerPaint,
    );
    canvas.drawCircle(
      Offset(gc.dx + approxCurveSpan, host.top),
      3,
      markerPaint,
    );
    _label(canvas,
        text: 'transition entry',
        offset: Offset(gc.dx - approxCurveSpan - 12, host.top + 12),
        color: _Palette.accent);
    _label(canvas,
        text: 'transition exit',
        offset: Offset(gc.dx + approxCurveSpan + 6, host.top + 12),
        color: _Palette.accent);
  }

  void _label(Canvas canvas,
      {required String text,
      required Offset offset,
      required Color color}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// Section 8 - Three notch variants
// -----------------------------------------------------------------------------

class _NotchVariantsSection extends StatelessWidget {
  const _NotchVariantsSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '08',
            title: 'Three notch variants',
            subtitle:
                'The same CircularNotchedRectangle, three different guest '
                'sizes. The notch grows with the guest rect.',
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _NotchVariantPanel(
                  title: 'small',
                  guestSize: 36,
                  description: 'Mini-FAB sized guest. Notch is narrow and '
                      'shallow, blending almost continuously into the bar.',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _NotchVariantPanel(
                  title: 'medium',
                  guestSize: 56,
                  description:
                      'Standard FAB size. The default visual the BottomAppBar '
                      'is designed around.',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _NotchVariantPanel(
                  title: 'large',
                  guestSize: 80,
                  description: 'Extended FAB. The notch dominates the bar - '
                      'use only when the bar can spare the visual real estate.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotchVariantPanel extends StatelessWidget {
  const _NotchVariantPanel({
    required this.title,
    required this.guestSize,
    required this.description,
  });

  final String title;
  final double guestSize;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _Palette.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _VariantPainter(guestSize: guestSize),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantPainter extends CustomPainter {
  const _VariantPainter({required this.guestSize});
  final double guestSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect host = Rect.fromLTWH(
      6,
      size.height - 50,
      size.width - 12,
      42,
    );
    final Rect guest = Rect.fromLTWH(
      host.center.dx - guestSize / 2,
      host.top - guestSize / 2 - 2,
      guestSize,
      guestSize,
    );
    final Path outer =
        const CircularNotchedRectangle().getOuterPath(host, guest);
    final Paint fill = Paint()..color = _Palette.barFill;
    canvas.drawPath(outer, fill);
    final Paint guestFill = Paint()..color = _Palette.coral;
    canvas.drawOval(guest, guestFill);
  }

  @override
  bool shouldRepaint(covariant _VariantPainter oldDelegate) =>
      oldDelegate.guestSize != guestSize;
}

// -----------------------------------------------------------------------------
// Section 9 - Comparison table NotchedShape vs ShapeBorder
// -----------------------------------------------------------------------------

class _ComparisonTableSection extends StatelessWidget {
  const _ComparisonTableSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '09',
            title: 'NotchedShape vs ShapeBorder',
            subtitle:
                'Both describe outlines, but they answer different '
                'questions and accept different inputs.',
          ),
          const SizedBox(height: 18),
          _Table(
            columns: const [
              'Aspect',
              'NotchedShape',
              'ShapeBorder',
            ],
            rows: const [
              [
                'Inputs to outline',
                'host (Rect) + guest (Rect?)',
                'rect (Rect) only',
              ],
              [
                'Use case',
                'Container with a hole for a guest widget',
                'Painting a border around a rect',
              ],
              [
                'Concrete subclasses',
                'CircularNotchedRectangle, AutomaticNotchedShape',
                'RoundedRectangleBorder, CircleBorder, StadiumBorder, ...',
              ],
              [
                'Used by',
                'BottomAppBar.shape',
                'Card.shape, ShapeDecoration, OutlinedButton, ...',
              ],
              [
                'Returns',
                'Path with a notch carved into one edge',
                'Path describing the rect outline',
              ],
              [
                'Composes',
                'AutomaticNotchedShape composes two ShapeBorders',
                'ShapeBorder.lerp / + composes two ShapeBorders',
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 10 - Common pitfalls
// -----------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '10',
            title: 'Common pitfalls',
            subtitle:
                'Things that look right but produce a broken or '
                'mismatched notch.',
          ),
          const SizedBox(height: 18),
          Column(
            children: const [
              _Pitfall(
                color: _Palette.coral,
                title:
                    'Forgetting floatingActionButtonLocation: centerDocked',
                body:
                    'Without a *Docked location, the FAB is not on top of '
                    'the bar - the bar still has shape: '
                    'CircularNotchedRectangle() but no guest is supplied, so '
                    'the bar renders as a plain rectangle.',
              ),
              SizedBox(height: 12),
              _Pitfall(
                color: _Palette.amber,
                title: 'Setting notchMargin too small',
                body:
                    'The default notchMargin (4 px) is calibrated for a '
                    'standard FAB. With a custom-sized FAB you may need to '
                    'tune notchMargin so the bar does not visually touch '
                    'the FAB outline.',
              ),
              SizedBox(height: 12),
              _Pitfall(
                color: _Palette.violet,
                title: 'Mismatched guest shape and notch shape',
                body:
                    'CircularNotchedRectangle assumes the guest is round. '
                    'If you dock a square widget, the notch will still be '
                    'a circle and the geometry will look off. Use '
                    'AutomaticNotchedShape with a matching guest ShapeBorder '
                    'instead.',
              ),
              SizedBox(height: 12),
              _Pitfall(
                color: _Palette.accent,
                title: 'Building your own NotchedShape without closing the path',
                body:
                    'getOuterPath must return a closed path. If you forget '
                    'Path.close(), the bar will have a visual seam and '
                    'clipping will misbehave.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pitfall extends StatelessWidget {
  const _Pitfall({
    required this.color,
    required this.title,
    required this.body,
  });

  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    color: _Palette.textSecondary,
                    fontSize: 13,
                    height: 1.5,
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

// -----------------------------------------------------------------------------
// Section 11 - Code recipes
// -----------------------------------------------------------------------------

class _RecipesSection extends StatelessWidget {
  const _RecipesSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '11',
            title: 'Recipes',
            subtitle:
                'Three concise patterns for using NotchedShape in real '
                'codebases.',
          ),
          const SizedBox(height: 18),
          _RecipeCard(
            title: 'Recipe 1 - default circular notch',
            description: 'The standard Material recipe.',
            color: _Palette.accent,
            lines: const [
              _CodeLine.code('Scaffold('),
              _CodeLine.code('  body: ...,'),
              _CodeLine.code('  floatingActionButton: FloatingActionButton('),
              _CodeLine.code('    onPressed: () {},'),
              _CodeLine.code('    child: const Icon(Icons.add),'),
              _CodeLine.code('  ),'),
              _CodeLine.code('  floatingActionButtonLocation:'),
              _CodeLine.code('      FloatingActionButtonLocation.centerDocked,'),
              _CodeLine.code('  bottomNavigationBar: BottomAppBar('),
              _CodeLine.code('    shape: const CircularNotchedRectangle(),'),
              _CodeLine.code('    notchMargin: 6,'),
              _CodeLine.code('    child: Row(...),'),
              _CodeLine.code('  ),'),
              _CodeLine.code(');'),
            ],
          ),
          const SizedBox(height: 14),
          _RecipeCard(
            title: 'Recipe 2 - automatic notch from two ShapeBorders',
            description:
                'Use this when both bar and FAB have non-default shapes.',
            color: _Palette.coral,
            lines: const [
              _CodeLine.code('BottomAppBar('),
              _CodeLine.code('  shape: const AutomaticNotchedShape('),
              _CodeLine.code('    RoundedRectangleBorder('),
              _CodeLine.code('      borderRadius:'),
              _CodeLine.code('          BorderRadius.vertical('),
              _CodeLine.code('              top: Radius.circular(20)),'),
              _CodeLine.code('    ),'),
              _CodeLine.code('    StadiumBorder(),'),
              _CodeLine.code('  ),'),
              _CodeLine.code('  child: ...,'),
              _CodeLine.code(');'),
            ],
          ),
          const SizedBox(height: 14),
          _RecipeCard(
            title: 'Recipe 3 - custom NotchedShape',
            description:
                'Subclass NotchedShape directly when you need a non-circular '
                'or non-rectangular notch.',
            color: _Palette.violet,
            lines: const [
              _CodeLine.code('class TriangleNotch extends NotchedShape {'),
              _CodeLine.code('  const TriangleNotch();'),
              _CodeLine.code('  @override'),
              _CodeLine.code('  Path getOuterPath(Rect host, Rect? guest) {'),
              _CodeLine.code(
                  '    if (guest == null || !host.overlaps(guest)) {'),
              _CodeLine.code('      return Path()..addRect(host);'),
              _CodeLine.code('    }'),
              _CodeLine.code('    final path = Path()'),
              _CodeLine.code('      ..moveTo(host.left, host.top)'),
              _CodeLine.code('      ..lineTo(guest.left, host.top)'),
              _CodeLine.code('      ..lineTo(guest.center.dx, guest.center.dy)'),
              _CodeLine.code('      ..lineTo(guest.right, host.top)'),
              _CodeLine.code('      ..lineTo(host.right, host.top)'),
              _CodeLine.code('      ..lineTo(host.right, host.bottom)'),
              _CodeLine.code('      ..lineTo(host.left, host.bottom)'),
              _CodeLine.code('      ..close();'),
              _CodeLine.code('    return path;'),
              _CodeLine.code('  }'),
              _CodeLine.code('}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.description,
    required this.color,
    required this.lines,
  });

  final String title;
  final String description;
  final Color color;
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          _CodeBlock(lines: lines),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 12 - CircularNotchedRectangle internals
// -----------------------------------------------------------------------------

class _CircularInternalsSection extends StatelessWidget {
  const _CircularInternalsSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '12',
            title: 'CircularNotchedRectangle internals',
            subtitle:
                'How the notch arc is computed - at a conceptual level. '
                'See the Flutter source for the exact algorithm.',
          ),
          const SizedBox(height: 18),
          _BulletList(
            title: 'Step by step',
            items: const [
              'If guest is null or does not overlap host, return host.addRect(host).',
              'Compute notch radius r = guest.width / 2.',
              'Pick a small ease radius (~r * 0.8) for the transition curves.',
              'Move the path along the top edge of the host until just '
                  'before the notch entry.',
              'Draw a quadratic Bezier transition curve down into the arc.',
              'Sweep an arc around the guest center, using r and the arc '
                  'start/end angles derived from the geometry.',
              'Draw a second Bezier transition curve back up to the top edge.',
              'Continue along the top edge, then down the right side, '
                  'across the bottom, and back up the left side. Close.',
            ],
          ),
          const SizedBox(height: 18),
          const _Note(
            color: _Palette.accentSoft,
            iconColor: _Palette.accent,
            text:
                'CircularNotchedRectangle does not animate or interpolate '
                'between guest sizes. The notch is recomputed every layout '
                'pass from the current host and guest rects.',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section 13 - Cookbook: notch on top vs notch on bottom
// -----------------------------------------------------------------------------

class _CookbookSection extends StatelessWidget {
  const _CookbookSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '13',
            title: 'Cookbook - placement',
            subtitle:
                'CircularNotchedRectangle places the notch on the edge of '
                'host nearest to guest. The Cookbook shows two configurations.',
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _CookbookPanel(
                  title: 'Notch on top edge',
                  description:
                      'Standard BottomAppBar layout. Guest is above the '
                      'host top edge, so the notch is carved out of the top.',
                  topNotch: true,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _CookbookPanel(
                  title: 'Notch on bottom edge',
                  description:
                      'Inverted layout, e.g. a top app bar with a docked '
                      'widget hanging below. Guest sits under the bar.',
                  topNotch: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CookbookPanel extends StatelessWidget {
  const _CookbookPanel({
    required this.title,
    required this.description,
    required this.topNotch,
  });

  final String title;
  final String description;
  final bool topNotch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _Palette.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _CookbookPainter(topNotch: topNotch),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _CookbookPainter extends CustomPainter {
  const _CookbookPainter({required this.topNotch});
  final bool topNotch;

  @override
  void paint(Canvas canvas, Size size) {
    if (topNotch) {
      final Rect host = Rect.fromLTWH(
        6,
        size.height - 50,
        size.width - 12,
        42,
      );
      final double gs = 56;
      final Rect guest = Rect.fromLTWH(
        host.center.dx - gs / 2,
        host.top - gs / 2,
        gs,
        gs,
      );
      final Path outer =
          const CircularNotchedRectangle().getOuterPath(host, guest);
      canvas.drawPath(outer, Paint()..color = _Palette.barFill);
      canvas.drawOval(guest, Paint()..color = _Palette.coral);
    } else {
      final Rect host = Rect.fromLTWH(6, 12, size.width - 12, 42);
      final double gs = 56;
      final Rect guest = Rect.fromLTWH(
        host.center.dx - gs / 2,
        host.bottom - gs / 2,
        gs,
        gs,
      );
      final Path outer =
          const CircularNotchedRectangle().getOuterPath(host, guest);
      canvas.drawPath(outer, Paint()..color = _Palette.barFill);
      canvas.drawOval(guest, Paint()..color = _Palette.coral);
    }
  }

  @override
  bool shouldRepaint(covariant _CookbookPainter oldDelegate) =>
      oldDelegate.topNotch != topNotch;
}

// -----------------------------------------------------------------------------
// Section 14 - References & links
// -----------------------------------------------------------------------------

class _ReferencesSection extends StatelessWidget {
  const _ReferencesSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            number: '14',
            title: 'References',
            subtitle: 'Where to read more about NotchedShape and friends.',
          ),
          const SizedBox(height: 18),
          Column(
            children: const [
              _RefRow(
                title: 'NotchedShape (Material)',
                detail:
                    'package:flutter/material.dart - abstract NotchedShape',
                category: 'API',
              ),
              _RefRow(
                title: 'CircularNotchedRectangle',
                detail:
                    'package:flutter/material.dart - '
                    'CircularNotchedRectangle',
                category: 'API',
              ),
              _RefRow(
                title: 'AutomaticNotchedShape',
                detail:
                    'package:flutter/material.dart - '
                    'AutomaticNotchedShape',
                category: 'API',
              ),
              _RefRow(
                title: 'BottomAppBar',
                detail: 'shape: NotchedShape, notchMargin: double',
                category: 'API',
              ),
              _RefRow(
                title: 'FloatingActionButtonLocation',
                detail: 'centerDocked, endDocked, startDocked, etc.',
                category: 'API',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.title,
    required this.detail,
    required this.category,
  });

  final String title;
  final String detail;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.outline),
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _Palette.violetSoft,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: _Palette.violet,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _Palette.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    color: _Palette.textSecondary,
                    fontSize: 12,
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

// -----------------------------------------------------------------------------
// Section 15 - Footer
// -----------------------------------------------------------------------------

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 3,
            decoration: BoxDecoration(
              color: _Palette.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'NotchedShape - Visual Deep Demo',
            style: TextStyle(
              color: _Palette.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'A hand-authored, analyzer-clean exploration of NotchedShape, '
            'CircularNotchedRectangle, and AutomaticNotchedShape.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Reusable widgets and types
// -----------------------------------------------------------------------------

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(24, 22, 24, 22),
    this.gradient,
  });

  final Widget child;
  final EdgeInsets padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? _Palette.surface : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        border: gradient == null
            ? Border.all(color: _Palette.outline)
            : null,
        boxShadow: gradient == null
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _Palette.accentSoft,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: _Palette.accent,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _Palette.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _Palette.textSecondary,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: _Palette.outline);
  }
}

class _ChipText extends StatelessWidget {
  const _ChipText({
    required this.text,
    required this.bg,
    required this.fg,
  });

  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.hint,
  });

  final String label;
  final String value;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              hint,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnatomyEntry extends StatelessWidget {
  const _AnatomyEntry({
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.body,
  });

  final String badge;
  final Color badgeColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: badgeColor,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _Palette.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _Palette.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (it) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8, right: 10),
                  child: SizedBox(
                    width: 5,
                    height: 5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _Palette.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    it,
                    style: const TextStyle(
                      color: _Palette.textSecondary,
                      fontSize: 13,
                      height: 1.5,
                    ),
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

class _Note extends StatelessWidget {
  const _Note({
    required this.color,
    required this.iconColor,
    required this.text,
  });

  final Color color;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: iconColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: iconColor.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _Palette.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ParamCard extends StatelessWidget {
  const _ParamCard({
    required this.name,
    required this.type,
    required this.description,
    required this.required,
    this.isReturn = false,
  });

  final String name;
  final String type;
  final String description;
  final bool required;
  final bool isReturn;

  @override
  Widget build(BuildContext context) {
    final Color tint = isReturn
        ? _Palette.violet
        : (required ? _Palette.coral : _Palette.accent);
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isReturn
                      ? 'returns'
                      : (required ? 'required' : 'optional'),
                  style: TextStyle(
                    color: tint,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  color: _Palette.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            type,
            style: TextStyle(
              color: tint,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamilyFallback: const ['monospace'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.textSecondary,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({required this.columns, required this.rows});

  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: _Palette.slateSoft,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: columns
                  .map(
                    (c) => Expanded(
                      flex: c == columns.first ? 2 : 3,
                      child: Text(
                        c,
                        style: const TextStyle(
                          color: _Palette.slate,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven
                    ? _Palette.surface
                    : _Palette.slateSoft.withValues(alpha: 0.4),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int j = 0; j < rows[i].length; j++)
                    Expanded(
                      flex: j == 0 ? 2 : 3,
                      child: Text(
                        rows[i][j],
                        style: TextStyle(
                          color: j == 0
                              ? _Palette.textPrimary
                              : _Palette.textSecondary,
                          fontWeight:
                              j == 0 ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 12.5,
                          height: 1.45,
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

// -----------------------------------------------------------------------------
// Code block primitives
// -----------------------------------------------------------------------------

class _CodeLine {
  const _CodeLine.code(this.text) : kind = _CodeKind.code;
  const _CodeLine.cmt(this.text) : kind = _CodeKind.comment;
  final String text;
  final _CodeKind kind;
}

enum _CodeKind { code, comment }

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.lines});
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  line.text.isEmpty ? ' ' : line.text,
                  style: TextStyle(
                    color: line.kind == _CodeKind.comment
                        ? _Palette.codeCmt
                        : _Palette.codeFg,
                    fontFamily: 'monospace',
                    fontFamilyFallback: const ['monospace'],
                    fontSize: 12.5,
                    height: 1.55,
                    fontStyle: line.kind == _CodeKind.comment
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
