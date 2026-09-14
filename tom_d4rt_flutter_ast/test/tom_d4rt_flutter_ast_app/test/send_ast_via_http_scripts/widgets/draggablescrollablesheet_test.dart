// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// DraggableScrollableSheet — Visual Deep Demo (static snapshot edition)
// =====================================================================
//
// DraggableScrollableSheet is a *resizable* widget. In normal Flutter
// code it lives at the bottom of a Stack, can be dragged up and down by
// the user, optionally snaps to predefined fractions of the available
// height, and forwards an inner ScrollController to its child so the
// drag-to-resize and the inner scroll work seamlessly together.
//
// This file is a *static snapshot* — it is rendered once. We do NOT
// instantiate a DraggableScrollableController, we do NOT call setState,
// we do NOT use any AnimationController, Timer, Future, or Stream.
// Instead we paint hand-drawn "frame mock-ups" of what the widget looks
// like at min / initial / max sizes, we draw a snap-point ruler, and we
// document the parameters in code-style cards.
//
// We also render one *real* DraggableScrollableSheet at the bottom of
// the page — wrapped in a fixed-size box, with a static ListView whose
// controller is the one supplied by the builder. That single live
// instance demonstrates the actual API surface, while the rest of the
// page is paper documentation that can never go stale.
//
// Sections (top → bottom):
//   01. Hero / Title card
//   02. Anatomy of the constructor (parameter table + code block)
//   03. Frame mocks at min / initial / max (sheet rising up)
//   04. Snap-points visualization (vertical ruler with stops)
//   05. expand:true vs expand:false explainer
//   06. Builder signature card with annotated code
//   07. ScrollController threading explanation
//   08. snapAnimationDuration card
//   09. DraggableScrollableController API card
//   10. Relationship to NestedScrollView
//   11. Comparison with showModalBottomSheet
//   12. Live, framed DraggableScrollableSheet sample
//   13. Common pitfalls
//   14. Lifecycle / state diagram
//   15. Footer
//
// Visual language: cards, soft shadows, indigo / teal / amber accents,
// monospace where we want to evoke source code. Every numeric size is
// specified explicitly so the analyzer never complains about implicit
// dynamics. Hand-authored to be analyzer-clean and long enough to read
// like a documentation poster.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Color palette — declared once so every section reads consistently.
// ---------------------------------------------------------------------

const Color _kInk = Color(0xFF12172A);
const Color _kInkSoft = Color(0xFF44496A);
const Color _kPaper = Color(0xFFF6F7FB);
const Color _kPaperWarm = Color(0xFFFDF9F2);
const Color _kPaperCool = Color(0xFFEEF2FB);
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
const Color _kViolet = Color(0xFF7C3AED);
const Color _kVioletSoft = Color(0xFFEDE9FE);
const Color _kSky = Color(0xFF0EA5E9);
const Color _kSkySoft = Color(0xFFE0F2FE);

// ---------------------------------------------------------------------
// Entry point — required signature.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'DraggableScrollableSheet — Visual Deep Demo',
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
              _frameMocksSection(),
              const SizedBox(height: 36),
              _snapRulerSection(),
              const SizedBox(height: 36),
              _expandSection(),
              const SizedBox(height: 36),
              _builderSignatureSection(),
              const SizedBox(height: 36),
              _controllerThreadingSection(),
              const SizedBox(height: 36),
              _snapDurationSection(),
              const SizedBox(height: 36),
              _controllerApiSection(),
              const SizedBox(height: 36),
              _nestedScrollSection(),
              const SizedBox(height: 36),
              _modalBottomSheetSection(),
              const SizedBox(height: 36),
              _liveSheetSection(),
              const SizedBox(height: 36),
              _pitfallsSection(),
              const SizedBox(height: 36),
              _lifecycleSection(),
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
// 01. HERO
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
          color: _kIndigo.withValues(alpha: 0.32),
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
            _heroChip('flutter / widgets'),
            const SizedBox(width: 10),
            _heroChip('sheet · drag · snap'),
            const SizedBox(width: 10),
            _heroChip('builder + controller'),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'DraggableScrollableSheet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A bottom sheet you can drag up and down. Its child receives an\n'
          'inner ScrollController so that, once the sheet is fully open,\n'
          'continued drags scroll the content instead of resizing the sheet.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.94),
            fontSize: 17,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _heroBadge('initialChildSize', 'double'),
            _heroBadge('minChildSize', 'double'),
            _heroBadge('maxChildSize', 'double'),
            _heroBadge('expand', 'bool'),
            _heroBadge('snap', 'bool'),
            _heroBadge('snapSizes', 'List<double>?'),
            _heroBadge('snapAnimationDuration', 'Duration?'),
            _heroBadge('controller', 'DraggableScrollableController?'),
            _heroBadge('builder', 'Widget Function(ctx, ctrl)'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.40)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'monospace',
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _heroBadge(String label, String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          type,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.80),
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 02. ANATOMY OF THE CONSTRUCTOR
// =====================================================================

Widget _anatomySection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 02',
    title: 'Anatomy of the constructor',
    subtitle:
        'DraggableScrollableSheet has nine constructor parameters. Three '
        'control sizing, two control snapping, one toggles expansion, one '
        'is the optional controller, and the remaining one is the all-'
        'important builder.',
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
            "DraggableScrollableSheet({\n"
            "  Key?                          key,\n"
            "  double                        initialChildSize       = 0.5,\n"
            "  double                        minChildSize           = 0.25,\n"
            "  double                        maxChildSize           = 1.0,\n"
            "  bool                          expand                 = true,\n"
            "  bool                          snap                   = false,\n"
            "  List<double>?                 snapSizes,\n"
            "  Duration?                     snapAnimationDuration,\n"
            "  DraggableScrollableController? controller,\n"
            "  bool                          shouldCloseOnMinExtent = true,\n"
            "  required ScrollableWidgetBuilder builder,\n"
            "})",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        _argRow(<Widget>[
          _argCard(
            'initialChildSize',
            'double = 0.5',
            'The fraction of the parent height the sheet occupies when '
                'it is first laid out. Must be ≥ minChildSize and '
                '≤ maxChildSize.',
            _kIndigo,
            _kIndigoSoft,
          ),
          _argCard(
            'minChildSize',
            'double = 0.25',
            'The smallest fraction the sheet can shrink to before it is '
                'considered closed. Drags below this are clamped (or, if '
                'shouldCloseOnMinExtent is true, dismiss the sheet).',
            _kTeal,
            _kTealSoft,
          ),
          _argCard(
            'maxChildSize',
            'double = 1.0',
            'The largest fraction the sheet can grow to. 1.0 means full '
                'screen height; values like 0.9 leave some breathing '
                'room for a status bar.',
            _kAmber,
            _kAmberSoft,
          ),
        ]),
        const SizedBox(height: 14),
        _argRow(<Widget>[
          _argCard(
            'expand',
            'bool = true',
            'When true, the sheet expands to fill the parent so its '
                'maximum height is the full available space. When false, '
                'the sheet sizes itself to its child.',
            _kViolet,
            _kVioletSoft,
          ),
          _argCard(
            'snap',
            'bool = false',
            'When true, the sheet snaps to the closest entry in '
                'snapSizes (or to min/max if snapSizes is null) once the '
                'drag ends.',
            _kRose,
            _kRoseSoft,
          ),
          _argCard(
            'snapSizes',
            'List<double>?',
            'Optional list of fractions to snap to. Must be sorted, all '
                'values in [minChildSize, maxChildSize]. Null falls back '
                'to snapping to the boundaries only.',
            _kEmerald,
            _kEmeraldSoft,
          ),
        ]),
        const SizedBox(height: 14),
        _argRow(<Widget>[
          _argCard(
            'snapAnimationDuration',
            'Duration?',
            'How long the snap animation runs. When null, Flutter picks '
                'a duration proportional to distance and velocity.',
            _kSky,
            _kSkySoft,
          ),
          _argCard(
            'controller',
            'DraggableScrollableController?',
            'Optional handle for programmatic resize. Lets you call '
                'animateTo / jumpTo, query the current size, and listen '
                'to changes.',
            _kIndigo,
            _kIndigoSoft,
          ),
          _argCard(
            'builder',
            'ScrollableWidgetBuilder',
            'Required. Builds the sheet content given a BuildContext '
                'and a ScrollController that MUST be wired into the '
                'inner Scrollable.',
            _kSlate,
            _kSlateSoft,
          ),
        ]),
      ],
    ),
  );
}

// =====================================================================
// 03. FRAME MOCKS — sheet at min / initial / max
// =====================================================================

Widget _frameMocksSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 03',
    title: 'Sheet rising up · min / initial / max',
    subtitle:
        'Three mock phones, side by side, showing how the same sheet '
        'looks at minChildSize, initialChildSize and maxChildSize. The '
        'parent height is 100%; the colored handle marks the current top '
        'of the sheet.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _phoneFrame(
            label: 'minChildSize · 0.25',
            sheetFraction: 0.25,
            accent: _kRose,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _phoneFrame(
            label: 'initialChildSize · 0.50',
            sheetFraction: 0.50,
            accent: _kAmber,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _phoneFrame(
            label: 'maxChildSize · 0.95',
            sheetFraction: 0.95,
            accent: _kEmerald,
          ),
        ),
      ],
    ),
  );
}

Widget _phoneFrame({
  required String label,
  required double sheetFraction,
  required Color accent,
}) {
  const double phoneHeight = 360.0;
  final double sheetHeight = phoneHeight * sheetFraction;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        height: phoneHeight,
        decoration: BoxDecoration(
          color: _kInk,
          borderRadius: BorderRadius.circular(28),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _kInk.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: <Widget>[
              // Background app content.
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[_kPaperCool, _kPaper],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 22,
                        color: _kInk.withValues(alpha: 0.05),
                        alignment: Alignment.center,
                        child: Text(
                          '9:41',
                          style: TextStyle(
                            color: _kInk.withValues(alpha: 0.55),
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
                        child: Text(
                          'Map',
                          style: TextStyle(
                            color: _kInk,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: _kInk.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          height: 8,
                          width: 80,
                          decoration: BoxDecoration(
                            color: _kInk.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // The sheet itself.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: sheetHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: _kInk.withValues(alpha: 0.16),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                    border: Border.all(
                      color: accent.withValues(alpha: 0.55),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 8),
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: _kInk.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${(sheetFraction * 100).round()}%',
                                style: TextStyle(
                                  color: accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.search, size: 14, color: _kInkSoft),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(child: _mockListInside()),
                    ],
                  ),
                ),
              ),
              // Top edge marker line.
              Positioned(
                left: 0,
                right: 0,
                bottom: sheetHeight - 1,
                child: Container(
                  height: 1.5,
                  color: accent.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _kInk,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _mockListInside() {
  final List<String> rows = <String>[
    'Coffee Lab',
    'Brick & Mortar',
    'Roasters Union',
    'Slow Drip',
    'Pour Over Co.',
    'Cup of Joe',
    'Bean Scene',
    'Mug Life',
  ];
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    itemCount: rows.length,
    itemBuilder: (BuildContext c, int i) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _kPaperCool,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _kInkSoft.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                rows[i],
                style: TextStyle(
                  color: _kInk,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// =====================================================================
// 04. SNAP-POINTS RULER
// =====================================================================

Widget _snapRulerSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 04',
    title: 'Snap points · vertical ruler',
    subtitle:
        'When snap is true, the sheet stops at predefined fractions. '
        'Drags between stops are completed by an animated jump to the '
        'closest one. The ruler below shows a 5-stop configuration.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _snapRulerWidget(
            stops: <double>[0.15, 0.30, 0.50, 0.70, 0.95],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _snapRow('0.15', 'collapsed peek',
                  'Shows just a header strip. Useful for quick previews.'),
              const SizedBox(height: 10),
              _snapRow('0.30', 'compact list',
                  'A handful of items visible. Common default for map sheets.'),
              const SizedBox(height: 10),
              _snapRow('0.50', 'half-screen',
                  'The classic "modal half-sheet" stop. Lots of room for content.'),
              const SizedBox(height: 10),
              _snapRow('0.70', 'mostly open',
                  'Headline content + scrollable body, app underneath still hinted.'),
              const SizedBox(height: 10),
              _snapRow('0.95', 'almost full',
                  'Leaves a sliver visible so the user knows they can swipe down.'),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kAmberSoft,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _kAmber.withValues(alpha: 0.40),
                  ),
                ),
                child: const Text(
                  'snapSizes must be sorted ascending and lie within '
                  '[minChildSize, maxChildSize]. The boundaries '
                  'themselves are implicit snap targets when snap is '
                  'true and snapSizes is null.',
                  style: TextStyle(
                    color: _kAmber,
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
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

Widget _snapRulerWidget({required List<double> stops}) {
  const double rulerHeight = 360.0;
  return Container(
    height: rulerHeight,
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kAmber.withValues(alpha: 0.35)),
    ),
    child: Stack(
      children: <Widget>[
        // The vertical bar (sheet height range).
        Positioned(
          left: 22,
          top: 6,
          bottom: 6,
          width: 8,
          child: Container(
            decoration: BoxDecoration(
              color: _kAmber.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Stops (drawn from bottom = small height, top = full height).
        for (final double s in stops)
          Positioned(
            left: 6,
            right: 6,
            bottom: 6 + (rulerHeight - 12) * s - 8,
            height: 16,
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  alignment: Alignment.center,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: _kAmber,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _kAmber.withValues(alpha: 0.50),
                    ),
                  ),
                  child: Text(
                    s.toStringAsFixed(2),
                    style: TextStyle(
                      color: _kAmber,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
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

Widget _snapRow(String fraction, String name, String description) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kAmberSoft, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kAmber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            fraction,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
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
// 05. EXPAND TRUE vs FALSE
// =====================================================================

Widget _expandSection() {
  return _sectionShell(
    accent: _kViolet,
    accentSoft: _kVioletSoft,
    eyebrow: 'section · 05',
    title: 'expand · true vs false',
    subtitle:
        'expand:true is the default. The sheet expands to fill its parent '
        'so it can be dragged to maxChildSize of the *parent* height. '
        'expand:false makes the sheet shrink-wrap to its child, useful '
        'when the sheet is itself a child of an Align or a sized box.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _expandCard(true)),
        const SizedBox(width: 18),
        Expanded(child: _expandCard(false)),
      ],
    ),
  );
}

Widget _expandCard(bool expand) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: expand
            ? _kViolet.withValues(alpha: 0.45)
            : _kSlate.withValues(alpha: 0.30),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: expand ? _kViolet : _kSlate,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                expand ? 'expand: true' : 'expand: false',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              expand ? '· default' : '· shrink-wrap',
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: _kPaperCool,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSlateSoft),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Stack parent\n(full screen)',
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                top: expand ? 12 : 130,
                child: Container(
                  decoration: BoxDecoration(
                    color: expand ? _kVioletSoft : _kSlateSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: expand ? _kViolet : _kSlate,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    expand ? 'fills parent' : 'wraps child',
                    style: TextStyle(
                      color: expand ? _kViolet : _kSlate,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          expand
              ? 'Use expand:true when the sheet lives at the bottom of '
                  'a Stack that fills the screen. The sheet then has the '
                  'full screen height to expand into; minChildSize and '
                  'maxChildSize are interpreted as fractions of that '
                  'screen height.'
              : 'Use expand:false when you want the sheet to be just as '
                  'tall as its content — for example, inside a popup, '
                  'a side panel, or anywhere it must coexist with other '
                  'siblings without taking over their space.',
          style: TextStyle(
            color: _kInk,
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 06. BUILDER SIGNATURE
// =====================================================================

Widget _builderSignatureSection() {
  return _sectionShell(
    accent: _kSlate,
    accentSoft: _kSlateSoft,
    eyebrow: 'section · 06',
    title: 'Builder signature · ScrollableWidgetBuilder',
    subtitle:
        'The builder receives a BuildContext and a ScrollController '
        'managed by the sheet. The returned widget is the sheet body. '
        'The controller MUST end up wired into the sheet\'s scrollable '
        'descendant — that is what links drag-to-resize and inner '
        'scrolling.',
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
            "typedef ScrollableWidgetBuilder = Widget Function(\n"
            "  BuildContext     context,\n"
            "  ScrollController scrollController,\n"
            ");\n"
            "\n"
            "// usage\n"
            "DraggableScrollableSheet(\n"
            "  initialChildSize: 0.5,\n"
            "  builder: (BuildContext ctx, ScrollController inner) {\n"
            "    return Container(\n"
            "      decoration: const BoxDecoration(\n"
            "        color: Colors.white,\n"
            "        borderRadius: BorderRadius.vertical(\n"
            "          top: Radius.circular(16),\n"
            "        ),\n"
            "      ),\n"
            "      child: ListView.builder(\n"
            "        controller: inner,        // ← MUST use the inner ctrl\n"
            "        itemCount: items.length,\n"
            "        itemBuilder: (c, i) => ListTile(title: Text(items[i])),\n"
            "      ),\n"
            "    );\n"
            "  },\n"
            ")",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 16),
        _calloutCard(
          color: _kRose,
          colorSoft: _kRoseSoft,
          icon: '!',
          title: 'Forget to wire the controller and the sheet looks broken',
          body:
              'If the inner ScrollController is not attached to a Scrollable, '
              'the sheet still resizes on drag — but once it reaches '
              'maxChildSize the gesture cannot transfer to inner scrolling. '
              'The user is stuck at the top of the list.',
        ),
      ],
    ),
  );
}

// =====================================================================
// 07. CONTROLLER THREADING EXPLANATION
// =====================================================================

Widget _controllerThreadingSection() {
  return _sectionShell(
    accent: _kRose,
    accentSoft: _kRoseSoft,
    eyebrow: 'section · 07',
    title: 'Threading the inner ScrollController',
    subtitle:
        'The sheet hands you a ScrollController. The user\'s vertical '
        'drag is read by that controller. Below maxChildSize the '
        'controller resizes the sheet; at maxChildSize, additional '
        'scroll-down forwards to the inner Scrollable.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _threadingDiagram()),
            const SizedBox(width: 18),
            Expanded(child: _threadingNotes()),
          ],
        ),
      ],
    ),
  );
}

Widget _threadingDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kRose.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _threadStep(
          '1',
          'User drags upward',
          'Vertical pointer movement is captured by the gesture '
              'recognizer of the sheet.',
          _kRose,
        ),
        _threadArrow(),
        _threadStep(
          '2',
          'sheet < maxChildSize?',
          'Yes → resize the sheet (extent grows). No → forward to inner '
              'ScrollController.',
          _kAmber,
        ),
        _threadArrow(),
        _threadStep(
          '3',
          'inner ScrollController scrolls',
          'The Scrollable that uses the controller (ListView, '
              'CustomScrollView, …) scrolls its viewport.',
          _kEmerald,
        ),
        _threadArrow(),
        _threadStep(
          '4',
          'User drags downward at offset 0',
          'When the inner Scrollable is at its top edge, drag-down '
              'transfers control back to the sheet, which shrinks.',
          _kIndigo,
        ),
      ],
    ),
  );
}

Widget _threadStep(String n, String title, String body, Color accent) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
          child: Text(
            n,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 11.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _threadArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        color: _kInkSoft.withValues(alpha: 0.55),
        size: 18,
      ),
    ),
  );
}

Widget _threadingNotes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _noteCard(
        title: 'Why a separate controller?',
        body:
            'A normal PrimaryScrollController belongs to the surrounding '
            'Scaffold. The sheet supplies its OWN controller because it '
            'must intercept gestures before they reach the inner '
            'Scrollable. That interception is what makes drag-to-resize '
            'feel native.',
        color: _kIndigo,
        colorSoft: _kIndigoSoft,
      ),
      const SizedBox(height: 12),
      _noteCard(
        title: 'You can use it like any other ScrollController',
        body:
            'The controller exposes offset, position, addListener, '
            'jumpTo, animateTo. Treat it as a normal '
            'ScrollController for everything except its lifetime — the '
            'sheet creates and disposes it for you.',
        color: _kEmerald,
        colorSoft: _kEmeraldSoft,
      ),
      const SizedBox(height: 12),
      _noteCard(
        title: 'Multiple Scrollables? Wrap them in one CustomScrollView',
        body:
            'The controller can drive only a single Scrollable. If your '
            'sheet body has several lists or grids, combine them with '
            'CustomScrollView and SliverList / SliverGrid, then attach '
            'the controller to the CustomScrollView.',
        color: _kAmber,
        colorSoft: _kAmberSoft,
      ),
    ],
  );
}

// =====================================================================
// 08. SNAP ANIMATION DURATION
// =====================================================================

Widget _snapDurationSection() {
  return _sectionShell(
    accent: _kSky,
    accentSoft: _kSkySoft,
    eyebrow: 'section · 08',
    title: 'snapAnimationDuration',
    subtitle:
        'When snap is true and the user releases mid-drag, the sheet '
        'animates to the closest snap stop. snapAnimationDuration '
        'controls how long that animation runs.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _durationCard(
            label: 'null',
            seconds: 'auto',
            description:
                'Default. Flutter picks a duration based on velocity '
                'and distance, so a quick flick produces a quick snap '
                'and a slow drag produces a slow snap.',
            accent: _kSlate,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _durationCard(
            label: 'Duration(milliseconds: 120)',
            seconds: '120 ms',
            description:
                'Snappy and assertive. Good for high-density UIs where '
                'the sheet should feel instantaneous.',
            accent: _kSky,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _durationCard(
            label: 'Duration(milliseconds: 350)',
            seconds: '350 ms',
            description:
                'Cinematic. Pairs well with bouncy curves, but feels '
                'sluggish if the user is in flow.',
            accent: _kViolet,
          ),
        ),
      ],
    ),
  );
}

Widget _durationCard({
  required String label,
  required String seconds,
  required String description,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          seconds,
          style: TextStyle(
            color: _kInk,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 09. CONTROLLER API CARD
// =====================================================================

Widget _controllerApiSection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 09',
    title: 'DraggableScrollableController · API',
    subtitle:
        'The optional controller lets you drive the sheet '
        'programmatically. Three methods plus a getter and a '
        'ChangeNotifier surface cover almost every use case.',
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
            "class DraggableScrollableController extends ChangeNotifier {\n"
            "  // current size of the sheet, expressed as a fraction\n"
            "  // of the parent height; throws if not attached.\n"
            "  double  get size;\n"
            "  double  get pixels;\n"
            "  bool    get isAttached;\n"
            "\n"
            "  // imperative resize\n"
            "  Future<void> animateTo(\n"
            "    double size, {\n"
            "    required Duration duration,\n"
            "    required Curve    curve,\n"
            "  });\n"
            "  void jumpTo(double size);\n"
            "\n"
            "  // utility\n"
            "  void reset();   // back to initialChildSize\n"
            "  double sizeToPixels(double size);\n"
            "  double pixelsToSize(double pixels);\n"
            "}",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 14),
        _argRow(<Widget>[
          _argCard(
            'animateTo',
            'Future<void>',
            'Smoothly animates to the given fraction. Throws if no '
                'sheet is attached. Always pass duration and curve — '
                'they are required.',
            _kIndigo,
            _kIndigoSoft,
          ),
          _argCard(
            'jumpTo',
            'void',
            'Instantly resizes. No animation, no listeners coalesced. '
                'Use for syncing with other widgets, not for user-facing '
                'transitions.',
            _kRose,
            _kRoseSoft,
          ),
          _argCard(
            'size',
            'double',
            'The current size as a fraction. Reading it before the '
                'sheet is attached throws — guard with isAttached.',
            _kEmerald,
            _kEmeraldSoft,
          ),
        ]),
        const SizedBox(height: 14),
        _argRow(<Widget>[
          _argCard(
            'reset',
            'void',
            'Returns the sheet to its initialChildSize without '
                'animation. Useful when re-presenting a sheet that has '
                'state.',
            _kAmber,
            _kAmberSoft,
          ),
          _argCard(
            'sizeToPixels',
            'double',
            'Converts a fraction to absolute pixels using the parent '
                'height the sheet is sized against. Handy for layout '
                'calculations.',
            _kViolet,
            _kVioletSoft,
          ),
          _argCard(
            'addListener',
            'void',
            'Inherited from ChangeNotifier. Fires every frame the size '
                'changes. Use it sparingly — listeners run on the UI '
                'thread.',
            _kSky,
            _kSkySoft,
          ),
        ]),
      ],
    ),
  );
}

// =====================================================================
// 10. NESTED SCROLL VIEW RELATIONSHIP
// =====================================================================

Widget _nestedScrollSection() {
  return _sectionShell(
    accent: _kEmerald,
    accentSoft: _kEmeraldSoft,
    eyebrow: 'section · 10',
    title: 'DraggableScrollableSheet · NestedScrollView',
    subtitle:
        'They are conceptual cousins. Both coordinate an outer drag '
        'with an inner scroll, but the coupling differs: the sheet '
        'changes its own *size*; NestedScrollView only changes the '
        'offset of an outer Sliver header.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _comparisonCard(
            heading: 'DraggableScrollableSheet',
            color: _kIndigo,
            colorSoft: _kIndigoSoft,
            bullets: <String>[
              'Resizes itself between minChildSize and maxChildSize.',
              'Hands you a ScrollController to attach to one Scrollable.',
              'Handoff happens at the size boundaries.',
              'Supports snap, snapSizes, snapAnimationDuration.',
              'Optional DraggableScrollableController for programmatic resize.',
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: _comparisonCard(
            heading: 'NestedScrollView',
            color: _kEmerald,
            colorSoft: _kEmeraldSoft,
            bullets: <String>[
              'Has a fixed-size body; only an outer header scrolls away.',
              'headerSliverBuilder vs body — two sliver-shaped roles.',
              'Handoff happens at the header collapse boundary.',
              'No snap/snapSizes; uses scroll physics for fling behavior.',
              'innerController accessible via PrimaryScrollController.',
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonCard({
  required String heading,
  required Color color,
  required Color colorSoft,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: colorSoft,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          heading,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 10),
        for (final String b in bullets) ...<Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  b,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ],
    ),
  );
}

// =====================================================================
// 11. COMPARISON WITH showModalBottomSheet
// =====================================================================

Widget _modalBottomSheetSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 11',
    title: 'DraggableScrollableSheet · showModalBottomSheet',
    subtitle:
        'Both produce a sheet at the bottom of the screen. They serve '
        'different jobs and you can absolutely combine them.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _comparisonCard(
                heading: 'DraggableScrollableSheet',
                color: _kIndigo,
                colorSoft: _kIndigoSoft,
                bullets: <String>[
                  'A widget — lives in the tree like any other.',
                  'Persistent: stays put in the layout you place it in.',
                  'Drag to resize; optional snap.',
                  'Best for map overlays, navigation hubs, persistent panels.',
                  'No barrier; no automatic dismiss.',
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: _comparisonCard(
                heading: 'showModalBottomSheet',
                color: _kAmber,
                colorSoft: _kAmberSoft,
                bullets: <String>[
                  'A function — pushes a route on top.',
                  'Modal: renders a barrier and intercepts back-button.',
                  'Closes by tapping the barrier or swiping down.',
                  'Best for one-shot pickers, confirmation prompts.',
                  'Often hosts a DraggableScrollableSheet as its child.',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _calloutCard(
          color: _kEmerald,
          colorSoft: _kEmeraldSoft,
          icon: '+',
          title: 'They combine cleanly',
          body:
              'showModalBottomSheet(isScrollControlled: true) gives the '
              'route the full screen height. Putting a '
              'DraggableScrollableSheet inside makes the modal itself '
              'draggable. Pair this with snapSizes for an iOS-style '
              'detent picker.',
        ),
      ],
    ),
  );
}

// =====================================================================
// 12. LIVE FRAMED SHEET
// =====================================================================

Widget _liveSheetSection() {
  return _sectionShell(
    accent: _kViolet,
    accentSoft: _kVioletSoft,
    eyebrow: 'section · 12',
    title: 'A real DraggableScrollableSheet, framed',
    subtitle:
        'One genuine widget, given a fixed parent height so the demo '
        'can render it inline. Drag the handle in your imagination — '
        'in a real app, it would resize between minChildSize and '
        'maxChildSize.',
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 420,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        _kPaperCool,
                        _kPaper,
                        _kPaperWarm,
                      ],
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Background app',
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Imagine a map, a feed, or a dashboard here. '
                        'The sheet rises from the bottom edge.',
                        style: TextStyle(
                          color: _kInkSoft,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.55,
                minChildSize: 0.30,
                maxChildSize: 0.95,
                snap: true,
                snapSizes: const <double>[0.30, 0.55, 0.95],
                snapAnimationDuration:
                    const Duration(milliseconds: 220),
                builder: (BuildContext ctx, ScrollController inner) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                    child: ListView(
                      controller: inner,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: _kInk.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Nearby places',
                          style: TextStyle(
                            color: _kInk,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Snap stops · 0.30 · 0.55 · 0.95',
                          style: TextStyle(
                            color: _kInkSoft,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 14),
                        for (int i = 0; i < 8; i++)
                          _liveListTile(i, _kViolet),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _liveListTile(int i, Color accent) {
  final List<String> names = <String>[
    'Coffee Lab',
    'Brick & Mortar',
    'Roasters Union',
    'Slow Drip',
    'Pour Over Co.',
    'Cup of Joe',
    'Bean Scene',
    'Mug Life',
  ];
  final List<String> tags = <String>[
    '0.2 mi · café',
    '0.4 mi · café',
    '0.5 mi · roaster',
    '0.7 mi · café',
    '0.8 mi · café',
    '0.9 mi · diner',
    '1.0 mi · café',
    '1.2 mi · café',
  ];
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPaperCool,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${i + 1}',
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                names[i],
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                tags[i],
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.chevron_right,
          color: _kInkSoft.withValues(alpha: 0.65),
          size: 18,
        ),
      ],
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
    title: 'Common pitfalls',
    subtitle:
        'A handful of pitfalls account for most "the sheet feels weird" '
        'bug reports. Recognise them once and they stop biting.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _pitfallCard(
          number: '01',
          title: 'Forgetting to attach the inner ScrollController',
          body:
              'The sheet still grows on drag, but at maxChildSize the '
              'gesture cannot transfer to inner scrolling. Symptom: list '
              'never scrolls past its initial offset.',
          fix:
              'Attach the controller passed to your builder to the inner '
              'Scrollable\'s controller field.',
        ),
        _pitfallCard(
          number: '02',
          title: 'Setting initialChildSize outside [min, max]',
          body:
              'In debug it asserts; in release it clamps silently. Either '
              'way the value you set is not the value you get.',
          fix:
              'Make sure minChildSize ≤ initialChildSize ≤ maxChildSize. '
              'A glance at this triple is the first thing reviewers '
              'should check.',
        ),
        _pitfallCard(
          number: '03',
          title: 'Unsorted or out-of-range snapSizes',
          body:
              'snapSizes must be sorted ascending and lie within '
              '[minChildSize, maxChildSize]. Violating either causes an '
              'assertion failure at build time.',
          fix:
              'Sort the list, and clamp values to the sheet\'s [min, '
              'max] range. Treat snapSizes as immutable configuration, '
              'never recomputed per build.',
        ),
        _pitfallCard(
          number: '04',
          title: 'Disposing the controller you did not create',
          body:
              'A DraggableScrollableSheet creates and disposes the inner '
              'ScrollController itself. Calling .dispose() on it from '
              'your code crashes the next frame.',
          fix:
              'Treat the inner ScrollController as borrowed. Only manage '
              'a DraggableScrollableController that you supplied to the '
              'controller parameter.',
        ),
        _pitfallCard(
          number: '05',
          title: 'Not using expand:false inside an Align',
          body:
              'expand:true wants the full available height. If you put '
              'the sheet inside an Align or a sized SizedBox, expand '
              'true makes the sheet fight the Align.',
          fix:
              'Set expand:false. The sheet will then size itself to its '
              'child up to maxChildSize × the available height.',
        ),
        _pitfallCard(
          number: '06',
          title: 'Listening to the controller every frame',
          body:
              'addListener fires every animation frame the size changes. '
              'Doing heavy work in the listener tanks performance.',
          fix:
              'Throttle by comparing against a stored last-emitted value, '
              'or move expensive work behind a microtask. For UI that '
              'depends on size, prefer a ValueListenableBuilder.',
        ),
      ],
    ),
  );
}

Widget _pitfallCard({
  required String number,
  required String title,
  required String body,
  required String fix,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kRoseSoft, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kRose.withValues(alpha: 0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kRoseSoft,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _kRose.withValues(alpha: 0.30),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _kRose,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'fix',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fix,
                        style: TextStyle(
                          color: _kRose,
                          fontSize: 12,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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
// 14. LIFECYCLE / STATE DIAGRAM
// =====================================================================

Widget _lifecycleSection() {
  return _sectionShell(
    accent: _kSky,
    accentSoft: _kSkySoft,
    eyebrow: 'section · 14',
    title: 'Lifecycle · from build to dismiss',
    subtitle:
        'The sheet is a StatefulWidget. Its state owns the inner '
        'ScrollController and reads/writes to the optional '
        'DraggableScrollableController. Here is the journey.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _lifeStep(
          phase: 'createState',
          title: 'Inner controller is created',
          body:
              'The sheet allocates a private _DraggableScrollableSheet'
              'ScrollController. Your DraggableScrollableController, if '
              'supplied, is attached to that inner controller now.',
          accent: _kIndigo,
        ),
        _lifeArrow(),
        _lifeStep(
          phase: 'build',
          title: 'builder is invoked with (context, scrollController)',
          body:
              'Every rebuild calls builder. The same controller is '
              'reused — your job is to thread it into the Scrollable.',
          accent: _kEmerald,
        ),
        _lifeArrow(),
        _lifeStep(
          phase: 'gesture',
          title: 'User drags',
          body:
              'Pointer events flow through the gesture recognizer of the '
              'sheet. Below maxChildSize, the inner controller adjusts '
              'the sheet extent; at the boundary, control passes to the '
              'inner Scrollable.',
          accent: _kAmber,
        ),
        _lifeArrow(),
        _lifeStep(
          phase: 'snap',
          title: 'On release, snap (if enabled)',
          body:
              'If snap is true, the sheet animates from its current '
              'fraction to the closest entry in snapSizes (or to '
              'min/max). Duration is snapAnimationDuration or auto.',
          accent: _kViolet,
        ),
        _lifeArrow(),
        _lifeStep(
          phase: 'dismiss / dispose',
          title: 'Sheet leaves the tree',
          body:
              'When the route is popped or the sheet is removed from '
              'the widget tree, the inner controller is disposed by the '
              'state. Your DraggableScrollableController, if you own '
              'it, must still be disposed by you.',
          accent: _kRose,
        ),
      ],
    ),
  );
}

Widget _lifeStep({
  required String phase,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            phase,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifeArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Center(
      child: Icon(
        Icons.south,
        color: _kInkSoft.withValues(alpha: 0.55),
        size: 16,
      ),
    ),
  );
}

// =====================================================================
// 15. FOOTER
// =====================================================================

Widget _footerSection() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInk, _kInk.withValues(alpha: 0.92)],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _kEmerald,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'visual deep demo · static snapshot · analyzer-clean',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 12,
                fontFamily: 'monospace',
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'DraggableScrollableSheet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Three numeric knobs for sizing, two for snapping, one for '
          'expansion, one for the optional controller, and one builder '
          'that wires everything together. Master those nine and the '
          'sheet does the rest.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _footerChip('initialChildSize'),
            _footerChip('minChildSize'),
            _footerChip('maxChildSize'),
            _footerChip('expand'),
            _footerChip('snap'),
            _footerChip('snapSizes'),
            _footerChip('snapAnimationDuration'),
            _footerChip('controller'),
            _footerChip('builder'),
          ],
        ),
      ],
    ),
  );
}

Widget _footerChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.10),
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
// SHARED HELPERS
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
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(color: accentSoft, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
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
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                  letterSpacing: 0.6,
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
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: _kInk,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 22),
        child,
      ],
    ),
  );
}

Widget _argRow(List<Widget> children) {
  final List<Widget> spaced = <Widget>[];
  for (int i = 0; i < children.length; i++) {
    spaced.add(Expanded(child: children[i]));
    if (i < children.length - 1) {
      spaced.add(const SizedBox(width: 12));
    }
  }
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #106, P1):
  // `_argRow` is called five times (lines 322, 352, 382, 1498, 1527) to lay
  // out side-by-side argument/recipe cards inside the page-root
  // `SingleChildScrollView > Column(stretch)` chain. The SCV gives its
  // descendants unbounded vertical extent, so `Row(crossAxisAlignment.stretch)`
  // — which wants its children (each wrapped in `Expanded(_argCard(…))`) to
  // share a common cross-axis height — receives an infinite-height
  // constraint and raises "BoxConstraints forces an infinite height."
  // (frameworkErrors=1, reported once because Flutter dedupes the same
  // assertion under the diagnostic infrastructure). Wrapping the Row in
  // `IntrinsicHeight` gives the side-by-side cards a finite cross-axis
  // budget equal to the tallest sibling, preserving the equal-height
  // comparison the helper is designed to teach. Single-site fix covers
  // all five invocations.
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spaced,
    ),
  );
}

Widget _argCard(
  String name,
  String type,
  String description,
  Color accent,
  Color accentSoft,
) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accentSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: accent,
            fontSize: 13.5,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          type,
          style: TextStyle(
            color: accent.withValues(alpha: 0.85),
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: _kInk,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _calloutCard({
  required Color color,
  required Color colorSoft,
  required String icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: colorSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text(
            icon,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _noteCard({
  required String title,
  required String body,
  required Color color,
  required Color colorSoft,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: colorSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(
            color: _kInk,
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}
