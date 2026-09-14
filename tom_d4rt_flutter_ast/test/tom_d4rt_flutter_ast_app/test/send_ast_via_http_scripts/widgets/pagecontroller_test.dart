// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// PageController — Visual Deep Demo (static snapshot edition)
// =====================================================================
//
// PageController is a *live* controller. In normal Flutter code you
// would create one with `PageController()`, hold onto it through a
// stateful widget's lifecycle, and dispose it when the widget unmounts.
//
// This demo file is a *static snapshot* — it is rendered once, with no
// setState, no async, no AnimationController, no Timer, no Stream. We
// therefore deliberately do NOT instantiate any PageController.
// Instead, we paint hand-drawn "filmstrip" mock-ups of what the
// controller's parameters do to a real PageView.
//
// Sections (top → bottom):
//   1.  Hero / Title card
//   2.  Anatomy of the PageController constructor
//   3.  viewportFraction visual (1.0, 0.85, 0.6 side by side)
//   4.  initialPage filmstrip with index 2 highlighted
//   5.  keepPage panel
//   6.  page getter explainer (decimal positions)
//   7.  position object overview
//   8.  animateToPage / jumpToPage signature card
//   9.  nextPage / previousPage signature card
//   10. Axis Direction (horizontal vs vertical)
//   11. PageView.builder lazy story
//   12. PageView.custom childrenDelegate story
//   13. Common pitfalls (live controller — no setState here)
//   14. Footer
//
// Visual language: cards, soft shadows, indigo / teal / amber accents,
// monospace where we want to evoke source code.
//
// This file is hand-authored to be analyzer-clean and long enough to
// serve as a documentation poster.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Color palette — declared once so every section reads consistently.
// ---------------------------------------------------------------------

const Color _kInk = Color(0xFF1A1F36);
const Color _kInkSoft = Color(0xFF4A5072);
const Color _kPaper = Color(0xFFF7F8FC);
const Color _kPaperWarm = Color(0xFFFDF9F2);
const Color _kIndigo = Color(0xFF4F46E5);
const Color _kIndigoSoft = Color(0xFFE0E7FF);
const Color _kTeal = Color(0xFF0D9488);
const Color _kTealSoft = Color(0xFFCCFBF1);
const Color _kAmber = Color(0xFFD97706);
const Color _kAmberSoft = Color(0xFFFEF3C7);
const Color _kRose = Color(0xFFE11D48);
const Color _kRoseSoft = Color(0xFFFFE4E6);
const Color _kEmerald = Color(0xFF059669);
const Color _kEmeraldSoft = Color(0xFFD1FAE5);
const Color _kSlate = Color(0xFF334155);
const Color _kSlateSoft = Color(0xFFE2E8F0);

// ---------------------------------------------------------------------
// Entry point — required signature.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'PageController — Visual Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kIndigo,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _heroSection(),
              const SizedBox(height: 36),
              _anatomySection(),
              const SizedBox(height: 36),
              _viewportFractionSection(),
              const SizedBox(height: 36),
              _initialPageSection(),
              const SizedBox(height: 36),
              _keepPageSection(),
              const SizedBox(height: 36),
              _pageGetterSection(),
              const SizedBox(height: 36),
              _positionObjectSection(),
              const SizedBox(height: 36),
              _animateJumpSection(),
              const SizedBox(height: 36),
              _nextPreviousSection(),
              const SizedBox(height: 36),
              _axisDirectionSection(),
              const SizedBox(height: 36),
              _builderStorySection(),
              const SizedBox(height: 36),
              _customDelegateSection(),
              const SizedBox(height: 36),
              _pitfallsSection(),
              const SizedBox(height: 36),
              _footerSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// 1. HERO
// =====================================================================

Widget _heroSection() {
  return Container(
    padding: const EdgeInsets.all(36),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kIndigo,
          _kIndigo.withValues(alpha: 0.82),
          _kTeal.withValues(alpha: 0.78),
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kIndigo.withValues(alpha: 0.30),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                ),
              ),
              child: const Text(
                'flutter / material',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                ),
              ),
              child: const Text(
                'controller · live · disposable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'PageController',
          style: TextStyle(
            color: Colors.white,
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A controller for PageView. Tracks the current page, exposes a\n'
          'fractional position, and drives jump / animate transitions.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.94),
            fontSize: 18,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            _heroBadge('initialPage', 'int'),
            const SizedBox(width: 10),
            _heroBadge('viewportFraction', 'double'),
            const SizedBox(width: 10),
            _heroBadge('keepPage', 'bool'),
            const SizedBox(width: 10),
            _heroBadge('page', 'double?'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label, String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          type,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 2. ANATOMY OF THE CONSTRUCTOR
// =====================================================================

Widget _anatomySection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 02',
    title: 'Anatomy of the constructor',
    subtitle:
        'PageController exposes three knobs at construction time. They '
        'never change for the life of the controller.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "PageController({\n"
            "  int    initialPage      = 0,\n"
            "  bool   keepPage         = true,\n"
            "  double viewportFraction = 1.0,\n"
            "})",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _argCard(
                'initialPage',
                'int = 0',
                'The page to display first. 0-based. Stored on the '
                    'controller and consulted when the PageView is first '
                    'attached.',
                _kIndigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'keepPage',
                'bool = true',
                'When true, the PageView preserves the current page across '
                    'rebuilds caused by ancestor state changes (e.g. '
                    'TabBarView keep-alive).',
                _kTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'viewportFraction',
                'double = 1.0',
                'How much of the viewport each page occupies. < 1.0 lets '
                    'siblings peek; > 1.0 makes pages overflow the viewport.',
                _kAmber,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _argCard(String name, String type, String body, Color accent) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 3. VIEWPORT FRACTION VISUAL
// =====================================================================

Widget _viewportFractionSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 03',
    title: 'viewportFraction — three frames',
    subtitle:
        'Each frame shows the same five pages with a different '
        'viewportFraction. The dashed window is the visible PageView area.',
    child: Column(
      children: <Widget>[
        _viewportFrame(label: 'viewportFraction: 1.0', fraction: 1.0),
        const SizedBox(height: 18),
        _viewportFrame(label: 'viewportFraction: 0.85', fraction: 0.85),
        const SizedBox(height: 18),
        _viewportFrame(label: 'viewportFraction: 0.6', fraction: 0.6),
        const SizedBox(height: 18),
        _viewportLegend(),
      ],
    ),
  );
}

Widget _viewportFrame({required String label, required double fraction}) {
  // Visual width of the "viewport" in pixels.
  const double viewportWidth = 720.0;
  // Each rendered "page" is fraction * viewportWidth wide.
  final double pageWidth = viewportWidth * fraction;
  // We render 5 mock pages and let them overflow horizontally inside
  // a clipped viewport box.
  final List<Widget> pages = <Widget>[];
  for (int i = 0; i < 5; i++) {
    pages.add(_mockPageBlock(index: i, width: pageWidth, focused: i == 2));
    if (i != 4) {
      pages.add(const SizedBox(width: 6));
    }
  }
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kAmber.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.aspect_ratio, color: _kAmber, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: _kInk,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Text(
              'page width = ${pageWidth.toStringAsFixed(0)}px',
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 110,
          width: viewportWidth,
          decoration: BoxDecoration(
            color: _kPaperWarm,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _kAmber.withValues(alpha: 0.55),
              style: BorderStyle.solid,
              width: 1.4,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: OverflowBox(
            alignment: Alignment.centerLeft,
            maxWidth: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: pages,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _mockPageBlock({
  required int index,
  required double width,
  required bool focused,
}) {
  final Color base = focused ? _kIndigo : _kSlateSoft;
  final Color borderColor =
      focused ? _kIndigo : _kSlate.withValues(alpha: 0.25);
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: base.withValues(alpha: focused ? 0.18 : 0.55),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: borderColor,
        width: focused ? 2.0 : 1.0,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'page $index',
            style: TextStyle(
              color: focused ? _kIndigo : _kSlate,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            focused ? 'focused' : '——',
            style: TextStyle(
              color: focused
                  ? _kIndigo.withValues(alpha: 0.75)
                  : _kSlate.withValues(alpha: 0.55),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _viewportLegend() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kAmberSoft.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber.withValues(alpha: 0.30)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.lightbulb_outline, color: _kAmber, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'When viewportFraction < 1.0, the active page sits centered '
            'in the viewport while neighbouring pages "peek". This is '
            'how carousel-like patterns are built without third-party '
            'packages.',
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 4. INITIAL PAGE FILMSTRIP
// =====================================================================

Widget _initialPageSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 04',
    title: 'initialPage — opening shot',
    subtitle:
        'A filmstrip of five pages. With initialPage: 2 the controller '
        'opens centered on the third frame.',
    child: Column(
      children: <Widget>[
        _filmstripFiveFrames(),
        const SizedBox(height: 16),
        _arrowsRow(),
        const SizedBox(height: 16),
        _initialPageCallouts(),
      ],
    ),
  );
}

Widget _filmstripFiveFrames() {
  final List<Widget> frames = <Widget>[];
  for (int i = 0; i < 5; i++) {
    frames.add(_filmstripCell(index: i, focused: i == 2));
    if (i != 4) {
      frames.add(const SizedBox(width: 8));
    }
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kTeal.withValues(alpha: 0.28)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: frames,
    ),
  );
}

Widget _filmstripCell({required int index, required bool focused}) {
  return Expanded(
    child: AspectRatio(
      aspectRatio: 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: focused ? _kTealSoft : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: focused ? _kTeal : _kSlate.withValues(alpha: 0.22),
            width: focused ? 2.4 : 1.0,
          ),
          boxShadow: focused
              ? <BoxShadow>[
                  BoxShadow(
                    color: _kTeal.withValues(alpha: 0.30),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : <BoxShadow>[],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '#$index',
              style: TextStyle(
                color: focused ? _kTeal : _kSlate,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              focused ? 'INITIAL' : 'page',
              style: TextStyle(
                color: focused
                    ? _kTeal
                    : _kSlate.withValues(alpha: 0.65),
                fontSize: 11,
                letterSpacing: focused ? 1.4 : 0.4,
                fontWeight:
                    focused ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
            if (focused) ...<Widget>[
              const SizedBox(height: 8),
              Container(
                width: 26,
                height: 4,
                decoration: BoxDecoration(
                  color: _kTeal,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

Widget _arrowsRow() {
  return Row(
    children: <Widget>[
      const Spacer(flex: 5),
      const Icon(Icons.south, color: _kTeal, size: 22),
      const Spacer(flex: 9),
    ],
  );
}

Widget _initialPageCallouts() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: _calloutCard(
          icon: Icons.flag_outlined,
          title: 'PageController(initialPage: 2)',
          body:
              'On first attach, the PageView resolves to page index 2. '
              'No animation, no scroll — just a static opening frame.',
          accent: _kTeal,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _calloutCard(
          icon: Icons.history,
          title: 'After first frame',
          body:
              'initialPage is read once. Changing the field afterwards has '
              'no effect; use animateToPage / jumpToPage instead.',
          accent: _kSlate,
        ),
      ),
    ],
  );
}

Widget _calloutCard({
  required IconData icon,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 5. KEEP PAGE PANEL
// =====================================================================

Widget _keepPageSection() {
  return _sectionShell(
    accent: _kEmerald,
    accentSoft: _kEmeraldSoft,
    eyebrow: 'section · 05',
    title: 'keepPage — survive ancestor rebuilds',
    subtitle:
        'When keepPage is true (the default), the PageView remembers the '
        'page across teardown / re-attach cycles caused by ancestor state.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _keepPanel(
            heading: 'keepPage: true',
            tag: 'default',
            accent: _kEmerald,
            tagSoft: _kEmeraldSoft,
            line1: 'PageView is rebuilt by ancestor.',
            line2: 'Controller restores its previous page.',
            line3: 'User experience: "where I left off".',
            ok: true,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _keepPanel(
            heading: 'keepPage: false',
            tag: 'opt-in reset',
            accent: _kRose,
            tagSoft: _kRoseSoft,
            line1: 'PageView is rebuilt by ancestor.',
            line2: 'Controller resets to initialPage.',
            line3: 'User experience: "fresh start".',
            ok: false,
          ),
        ),
      ],
    ),
  );
}

Widget _keepPanel({
  required String heading,
  required String tag,
  required Color accent,
  required Color tagSoft,
  required String line1,
  required String line2,
  required String line3,
  required bool ok,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.32)),
    ),
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
                color: tagSoft,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const Spacer(),
            Icon(
              ok ? Icons.check_circle : Icons.refresh,
              color: accent,
              size: 18,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          heading,
          style: const TextStyle(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 12),
        _bullet(line1),
        _bullet(line2),
        _bullet(line3),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _kInkSoft.withValues(alpha: 0.65),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 6. PAGE GETTER EXPLAINER
// =====================================================================

Widget _pageGetterSection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 06',
    title: 'page getter — the fractional truth',
    subtitle:
        'controller.page is a double?, not an int. While the user drags, '
        'page sits between integers. Useful for parallax & indicator dots.',
    child: Column(
      children: <Widget>[
        _decimalRuler(),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _pageReadingCard(
                value: '0.00',
                label: 'fully on page 0',
                accent: _kSlate,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _pageReadingCard(
                value: '0.50',
                label: 'half-way 0 → 1',
                accent: _kAmber,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _pageReadingCard(
                value: '1.00',
                label: 'fully on page 1',
                accent: _kIndigo,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _pageReadingCard(
                value: '2.83',
                label: 'mid-drag 2 → 3',
                accent: _kTeal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _pageGetterCode(),
      ],
    ),
  );
}

Widget _decimalRuler() {
  // Ruler showing 0..4 with sub-ticks at every 0.25 — purely visual.
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i <= 16; i++) {
    final bool major = i % 4 == 0;
    ticks.add(
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: major ? 22 : 10,
              width: major ? 2.0 : 1.0,
              color: major ? _kIndigo : _kSlate.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 16,
              child: major
                  ? Text(
                      (i / 4).toStringAsFixed(0),
                      style: const TextStyle(
                        color: _kIndigo,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kIndigo.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'controller.page  (double?)',
          style: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(height: 50, child: Row(children: ticks)),
      ],
    ),
  );
}

Widget _pageReadingCard({
  required String value,
  required String label,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            color: accent,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _pageGetterCode() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Text(
      "// Read the current fractional page (may be null until first attach)\n"
      "final double? p = controller.page;\n"
      "\n"
      "// Snap to int for an indicator\n"
      "final int activeDot = (p ?? 0.0).round();\n"
      "\n"
      "// Use the fractional part for parallax\n"
      "final double offset = (p ?? 0.0) - activeDot;",
      style: TextStyle(
        color: Color(0xFFE2E8F0),
        fontSize: 13,
        height: 1.55,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =====================================================================
// 7. POSITION OBJECT
// =====================================================================

Widget _positionObjectSection() {
  return _sectionShell(
    accent: _kSlate,
    accentSoft: _kSlateSoft,
    eyebrow: 'section · 07',
    title: 'controller.position — the ScrollPosition',
    subtitle:
        'PageController is a ScrollController. Its position is a '
        'PagePosition (subclass of ScrollPositionWithSingleContext).',
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSlate.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Common reads',
            style: TextStyle(
              color: _kInk,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          _kvRow('position.pixels', 'double',
              'Current scroll offset in logical pixels.'),
          _kvRow('position.minScrollExtent', 'double',
              'Smallest valid pixel offset (usually 0.0).'),
          _kvRow('position.maxScrollExtent', 'double',
              'Largest valid pixel offset (depends on child count).'),
          _kvRow('position.viewportDimension', 'double',
              'Width (or height) of the visible viewport.'),
          _kvRow('position.userScrollDirection', 'ScrollDirection',
              'forward / reverse / idle as the user drags.'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSlateSoft.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Tip: prefer the page getter for page-aware logic. '
              'Use position only when you need raw pixels (e.g. for a '
              'hero indicator that follows the drag).',
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _kvRow(String key, String type, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220,
          child: Text(
            key,
            style: const TextStyle(
              color: _kIndigo,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            type,
            style: const TextStyle(
              color: _kTeal,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            body,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 8. ANIMATE / JUMP SIGNATURE CARD
// =====================================================================

Widget _animateJumpSection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 08',
    title: 'animateToPage / jumpToPage',
    subtitle:
        'Two ways to programmatically move. animateToPage glides; '
        'jumpToPage teleports.',
    child: Column(
      children: <Widget>[
        _signatureCard(
          icon: Icons.animation,
          accent: _kIndigo,
          name: 'animateToPage',
          signature: 'Future<void> animateToPage(\n'
              '  int page, {\n'
              '  required Duration duration,\n'
              '  required Curve curve,\n'
              '})',
          notes: <String>[
            'Returns a Future that completes when the animation ends.',
            'Curves.easeInOut + 300ms is a common, safe baseline.',
            'Calling it again before completion cancels the previous one.',
          ],
        ),
        const SizedBox(height: 14),
        _flowDiagram(
          'page 0  ─►  page 3   (animated)',
          showCurve: true,
        ),
        const SizedBox(height: 22),
        _signatureCard(
          icon: Icons.bolt,
          accent: _kAmber,
          name: 'jumpToPage',
          signature: 'void jumpToPage(int page)',
          notes: <String>[
            'Synchronous. The position snaps immediately.',
            'No animation, no Future — fire-and-forget.',
            'Use for "deep link" entry points or test setup.',
          ],
        ),
        const SizedBox(height: 14),
        _flowDiagram(
          'page 0  ━►  page 3   (jump)',
          showCurve: false,
        ),
      ],
    ),
  );
}

Widget _signatureCard({
  required IconData icon,
  required Color accent,
  required String name,
  required String signature,
  required List<String> notes,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Text(
            signature,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final String note in notes)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_right_alt,
                  color: accent.withValues(alpha: 0.75),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    note,
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 13,
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

Widget _flowDiagram(String label, {required bool showCurve}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: showCurve ? _kIndigoSoft : _kAmberSoft,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: <Widget>[
        _diagramBubble('0', showCurve ? _kIndigo : _kAmber),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: showCurve ? _kIndigo : _kAmber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _diagramBubble('1', _kSlate.withValues(alpha: 0.4)),
        const SizedBox(width: 10),
        _diagramBubble('2', _kSlate.withValues(alpha: 0.4)),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: showCurve ? _kIndigo : _kAmber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _diagramBubble('3', showCurve ? _kIndigo : _kAmber),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            color: showCurve ? _kIndigo : _kAmber,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _diagramBubble(String label, Color color) {
  return Container(
    width: 36,
    height: 36,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w900,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =====================================================================
// 9. NEXT / PREVIOUS
// =====================================================================

Widget _nextPreviousSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 09',
    title: 'nextPage / previousPage',
    subtitle:
        'Convenience wrappers around animateToPage. Same Duration / '
        'Curve required. Move exactly one page at a time.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _signatureCard(
            icon: Icons.arrow_forward_ios,
            accent: _kTeal,
            name: 'nextPage',
            signature: 'Future<void> nextPage({\n'
                '  required Duration duration,\n'
                '  required Curve curve,\n'
                '})',
            notes: <String>[
              'Equivalent to animateToPage(currentPage + 1, ...).',
              'No-op if the controller is already on the last page.',
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _signatureCard(
            icon: Icons.arrow_back_ios_new,
            accent: _kRose,
            name: 'previousPage',
            signature: 'Future<void> previousPage({\n'
                '  required Duration duration,\n'
                '  required Curve curve,\n'
                '})',
            notes: <String>[
              'Equivalent to animateToPage(currentPage - 1, ...).',
              'No-op if the controller is already on page 0.',
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 10. AXIS DIRECTION
// =====================================================================

Widget _axisDirectionSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 10',
    title: 'PageView scrollDirection',
    subtitle:
        'PageController works for both axes. The PageView itself decides '
        'horizontal vs vertical via scrollDirection.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _axisCard(horizontal: true)),
        const SizedBox(width: 14),
        Expanded(child: _axisCard(horizontal: false)),
      ],
    ),
  );
}

Widget _axisCard({required bool horizontal}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kAmber.withValues(alpha: 0.28)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              horizontal ? Icons.swap_horiz : Icons.swap_vert,
              color: _kAmber,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              horizontal
                  ? 'scrollDirection: Axis.horizontal'
                  : 'scrollDirection: Axis.vertical',
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: horizontal
              ? Row(
                  children: <Widget>[
                    _axisFrame(label: '0', focused: false),
                    const SizedBox(width: 6),
                    _axisFrame(label: '1', focused: true),
                    const SizedBox(width: 6),
                    _axisFrame(label: '2', focused: false),
                  ],
                )
              : Column(
                  children: <Widget>[
                    _axisFrame(label: '0', focused: false),
                    const SizedBox(height: 6),
                    _axisFrame(label: '1', focused: true),
                    const SizedBox(height: 6),
                    _axisFrame(label: '2', focused: false),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        Text(
          horizontal
              ? 'Drag left ↔ right. Default axis.'
              : 'Drag up ↕ down. Common for stories / feeds.',
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _axisFrame({required String label, required bool focused}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: focused ? _kAmberSoft : _kSlateSoft.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: focused ? _kAmber : _kSlate.withValues(alpha: 0.25),
          width: focused ? 2.0 : 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: focused ? _kAmber : _kSlate,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

// =====================================================================
// 11. PAGEVIEW.BUILDER
// =====================================================================

Widget _builderStorySection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 11',
    title: 'PageView.builder — lazy children',
    subtitle:
        'Same controller, lazy children. Ideal for unbounded or expensive '
        'pages.',
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "PageView.builder(\n"
            "  controller: controller,         // your PageController\n"
            "  itemCount: 1000,                // bounded; null = infinite\n"
            "  scrollDirection: Axis.horizontal,\n"
            "  itemBuilder: (BuildContext c, int i) {\n"
            "    return _PageCard(index: i);   // built only as needed\n"
            "  },\n"
            ")",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.6,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 16),
        _builderTimeline(),
      ],
    ),
  );
}

Widget _builderTimeline() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kIndigo.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Build cadence',
          style: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 10),
        _timelineRow(
            'attach', 'builds page 0 (and possibly cacheExtent neighbours).'),
        _timelineRow('user drags →', 'builds page 1 just-in-time.'),
        _timelineRow('settles on 1', 'page 0 may be evicted.'),
        _timelineRow('jumpToPage(42)',
            'builds page 42 immediately, skipping the rest.'),
      ],
    ),
  );
}

Widget _timelineRow(String when, String what) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            when,
            style: const TextStyle(
              color: _kIndigo,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            what,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 12. PAGEVIEW.CUSTOM
// =====================================================================

Widget _customDelegateSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 12',
    title: 'PageView.custom — your own SliverChildDelegate',
    subtitle:
        'For advanced reordering, semantic indexes, or custom child '
        'lifetimes you build a SliverChildDelegate.',
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "PageView.custom(\n"
        "  controller: controller,\n"
        "  childrenDelegate: SliverChildBuilderDelegate(\n"
        "    (BuildContext c, int i) => _PageCard(index: i),\n"
        "    childCount: 24,\n"
        "    findChildIndexCallback: (Key key) {\n"
        "      // Map a stable key to its current index after a reorder.\n"
        "      return null; // returning null falls back to a linear scan\n"
        "    },\n"
        "  ),\n"
        ")",
        style: TextStyle(
          color: Color(0xFFE2E8F0),
          fontSize: 13,
          height: 1.6,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

// =====================================================================
// 13. PITFALLS
// =====================================================================

Widget _pitfallsSection() {
  return _sectionShell(
    accent: _kRose,
    accentSoft: _kRoseSoft,
    eyebrow: 'section · 13',
    title: 'Pitfalls — live controller realities',
    subtitle:
        'PageController is a stateful, disposable resource. Treat it like '
        'a TextEditingController, not like a value.',
    child: Column(
      children: <Widget>[
        _pitfall(
          icon: Icons.report_outlined,
          title: 'Do not recreate it on every build',
          body:
              'Hold the controller in a State (or a Riverpod / GetIt '
              'scope). If you call PageController() inside build(), every '
              'rebuild starts from initialPage and animations break.',
        ),
        _pitfall(
          icon: Icons.delete_outline,
          title: 'Always dispose()',
          body:
              'PageController owns notifiers. Forgetting to dispose leaks '
              'listeners and can keep widgets alive after they unmount.',
        ),
        _pitfall(
          icon: Icons.warning_amber_rounded,
          title: 'page is null before first attach',
          body: 'Reading controller.page before the PageView has laid out '
              'returns null. Guard with `?? initialPage.toDouble()`.',
        ),
        _pitfall(
          icon: Icons.sync_problem_outlined,
          title: 'Animate during build = assertion',
          body: 'Calling animateToPage / jumpToPage inside build() throws. '
              'Defer to a post-frame callback or a user-driven event.',
        ),
        _pitfall(
          icon: Icons.science_outlined,
          title: 'This file is a static demo',
          body: 'No setState. No live PageController. The visuals above '
              "mock the controller's behaviour with plain Containers so "
              'the file can render once and remain analyzer-clean.',
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kRose.withValues(alpha: 0.28)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kRoseSoft,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kRose, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _kInkSoft,
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

// =====================================================================
// 14. FOOTER
// =====================================================================

Widget _footerSection() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kIndigo.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.menu_book_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'PageController — Visual Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Static snapshot. No live controllers, no setState, no '
                'async. Renders identically every build, suitable for '
                'AST round-trip testing.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _footerChip('material.dart'),
                  _footerChip('PageController'),
                  _footerChip('PageView'),
                  _footerChip('PageView.builder'),
                  _footerChip('PageView.custom'),
                  _footerChip('Axis'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _footerChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =====================================================================
// SECTION SHELL — shared scaffold for sections 02..13
// =====================================================================

Widget _sectionShell({
  required Color accent,
  required Color accentSoft,
  required String eyebrow,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: accent.withValues(alpha: 0.18)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.06),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: accentSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                eyebrow,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            color: _kInk,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: _kInkSoft.withValues(alpha: 0.95),
            fontSize: 15,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 22),
        child,
      ],
    ),
  );
}

// =====================================================================
// END OF FILE
// =====================================================================
