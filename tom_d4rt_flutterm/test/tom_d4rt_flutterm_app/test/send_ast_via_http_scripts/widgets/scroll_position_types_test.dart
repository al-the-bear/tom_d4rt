import 'package:flutter/material.dart';

// =============================================================================
// ScrollPosition Type Zoo
// -----------------------------------------------------------------------------
// A museum-style visual demo of the concrete subtypes of ScrollPosition that
// you can reach through controller.position in a running Flutter app.
//
// Specimens on display:
//   - ScrollPositionWithSingleContext : ListView / GridView / CustomScrollView
//                                       / SingleChildScrollView / Scrollable
//   - _PagePosition (library-private) : PageView driven by PageController
//   - FixedExtentScrollPosition       : ListWheelScrollView driven by a
//                                       FixedExtentScrollController
//
// The demo is a pure StatefulWidget tree. No main(), no runApp() — the d4rt
// AST harness calls build(BuildContext context) directly and expects a
// MaterialApp(home: ...) back.
// =============================================================================

// -----------------------------------------------------------------------------
// Palette — burgundy / sand / pine / paper museum feel.
// -----------------------------------------------------------------------------
const Color kBurgundy = Color(0xFF7C1D2E);
const Color kSand = Color(0xFFE8D5B7);
const Color kPine = Color(0xFF2F4F4F);
const Color kPaper = Color(0xFFF9F5EC);
const Color kInk = Color(0xFF1E1A15);
const Color kShadow = Color(0xFF2A1A10);
const Color kAccentGold = Color(0xFFB08D4A);
const Color kSpecimenTagBorder = Color(0xFF8C7A5B);

// -----------------------------------------------------------------------------
// Entry point expected by the d4rt AST harness. Returns a MaterialApp.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollPosition Type Zoo',
    theme: ThemeData(
      scaffoldBackgroundColor: kPaper,
      primaryColor: kBurgundy,
      colorScheme: const ColorScheme.light(
        primary: kBurgundy,
        secondary: kPine,
        surface: kPaper,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInk, fontSize: 14),
        titleLarge: TextStyle(color: kBurgundy, fontWeight: FontWeight.bold),
      ),
    ),
    home: const _ScrollPositionZooHome(),
  );
}

// =============================================================================
// The root stateful widget — owns all three controllers plus rebuild ticker.
// =============================================================================
class _ScrollPositionZooHome extends StatefulWidget {
  const _ScrollPositionZooHome();

  @override
  State<_ScrollPositionZooHome> createState() => _ScrollPositionZooHomeState();
}

class _ScrollPositionZooHomeState extends State<_ScrollPositionZooHome> {
  // Plain ScrollController => ScrollPositionWithSingleContext when attached.
  final ScrollController _plainController = ScrollController();

  // PageController => _PagePosition (library-private) when attached.
  final PageController _pageController = PageController(
    viewportFraction: 0.86,
    initialPage: 0,
  );

  // FixedExtentScrollController => FixedExtentScrollPosition.
  final FixedExtentScrollController _wheelController =
      FixedExtentScrollController(initialItem: 4);

  // Live snapshots of the three positions, filled in from scroll listeners.
  _PositionSnapshot _plainSnap = _PositionSnapshot.empty('plain');
  _PositionSnapshot _pageSnap = _PositionSnapshot.empty('page');
  _PositionSnapshot _wheelSnap = _PositionSnapshot.empty('wheel');

  int _wheelSelected = 4;

  @override
  void initState() {
    super.initState();
    _plainController.addListener(_onPlain);
    _pageController.addListener(_onPage);
    _wheelController.addListener(_onWheel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onPlain();
      _onPage();
      _onWheel();
    });
  }

  void _onPlain() {
    if (!_plainController.hasClients) return;
    final pos = _plainController.position;
    setState(() {
      _plainSnap = _PositionSnapshot(
        label: 'plain',
        runtimeTypeName: pos.runtimeType.toString(),
        pixels: pos.pixels,
        minScrollExtent: pos.minScrollExtent,
        maxScrollExtent: pos.maxScrollExtent,
        viewportDimension: pos.viewportDimension,
        haveDimensions: pos.haveDimensions,
        userScrollDirection: pos.userScrollDirection.toString(),
        axisDirection: pos.axisDirection.toString(),
      );
    });
  }

  void _onPage() {
    if (!_pageController.hasClients) return;
    final pos = _pageController.position;
    double? pageValue;
    try {
      pageValue = _pageController.page;
    } catch (_) {
      pageValue = null;
    }
    setState(() {
      _pageSnap = _PositionSnapshot(
        label: 'page',
        runtimeTypeName: pos.runtimeType.toString(),
        pixels: pos.pixels,
        minScrollExtent: pos.minScrollExtent,
        maxScrollExtent: pos.maxScrollExtent,
        viewportDimension: pos.viewportDimension,
        haveDimensions: pos.haveDimensions,
        userScrollDirection: pos.userScrollDirection.toString(),
        axisDirection: pos.axisDirection.toString(),
        extraLabel: 'page',
        extraValue: pageValue == null ? '—' : pageValue.toStringAsFixed(3),
      );
    });
  }

  void _onWheel() {
    if (!_wheelController.hasClients) return;
    final pos = _wheelController.position;
    setState(() {
      _wheelSnap = _PositionSnapshot(
        label: 'wheel',
        runtimeTypeName: pos.runtimeType.toString(),
        pixels: pos.pixels,
        minScrollExtent: pos.minScrollExtent,
        maxScrollExtent: pos.maxScrollExtent,
        viewportDimension: pos.viewportDimension,
        haveDimensions: pos.haveDimensions,
        userScrollDirection: pos.userScrollDirection.toString(),
        axisDirection: pos.axisDirection.toString(),
        extraLabel: 'selectedItem',
        extraValue: _wheelController.selectedItem.toString(),
      );
    });
  }

  @override
  void dispose() {
    _plainController.removeListener(_onPlain);
    _pageController.removeListener(_onPage);
    _wheelController.removeListener(_onWheel);
    _plainController.dispose();
    _pageController.dispose();
    _wheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _HeroHeader(),
              const SizedBox(height: 28),
              _SpecimenPlainListView(
                controller: _plainController,
                snap: _plainSnap,
              ),
              const SizedBox(height: 28),
              _SpecimenPageView(
                controller: _pageController,
                snap: _pageSnap,
              ),
              const SizedBox(height: 28),
              _SpecimenWheel(
                controller: _wheelController,
                snap: _wheelSnap,
                onChanged: (int i) {
                  setState(() => _wheelSelected = i);
                },
                currentSelection: _wheelSelected,
              ),
              const SizedBox(height: 28),
              _RuntimeTypeComparisonTable(
                plain: _plainSnap,
                page: _pageSnap,
                wheel: _wheelSnap,
              ),
              const SizedBox(height: 28),
              const _HierarchyDiagram(),
              const SizedBox(height: 28),
              _SharedMetricsPanel(
                plain: _plainSnap,
                page: _pageSnap,
                wheel: _wheelSnap,
              ),
              const SizedBox(height: 28),
              const _TeachingPanel(),
              const SizedBox(height: 28),
              const _UseCasesStrip(),
              const SizedBox(height: 28),
              const _CodeSnippetsPanel(),
              const SizedBox(height: 28),
              const _FooterSummary(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// A snapshot of the metrics we pull out of ScrollPosition via listener.
// =============================================================================
class _PositionSnapshot {
  const _PositionSnapshot({
    required this.label,
    required this.runtimeTypeName,
    required this.pixels,
    required this.minScrollExtent,
    required this.maxScrollExtent,
    required this.viewportDimension,
    required this.haveDimensions,
    required this.userScrollDirection,
    required this.axisDirection,
    this.extraLabel,
    this.extraValue,
  });

  factory _PositionSnapshot.empty(String label) {
    return _PositionSnapshot(
      label: label,
      runtimeTypeName: '(not attached yet)',
      pixels: 0,
      minScrollExtent: 0,
      maxScrollExtent: 0,
      viewportDimension: 0,
      haveDimensions: false,
      userScrollDirection: 'ScrollDirection.idle',
      axisDirection: 'AxisDirection.down',
    );
  }

  final String label;
  final String runtimeTypeName;
  final double pixels;
  final double minScrollExtent;
  final double maxScrollExtent;
  final double viewportDimension;
  final bool haveDimensions;
  final String userScrollDirection;
  final String axisDirection;
  final String? extraLabel;
  final String? extraValue;
}

// =============================================================================
// Hero header — specimen jars and the title strip.
// =============================================================================
class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kBurgundy,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.45),
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
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kSand,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'FLUTTER INTERNALS · CAB. 7 · DRAWER C',
                  style: TextStyle(
                    color: kBurgundy,
                    fontSize: 11,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.museum_outlined,
                  color: kSand.withValues(alpha: 0.85), size: 22),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'ScrollPosition subtypes',
            style: TextStyle(
              color: kPaper,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'one abstract, many concrete flavours',
            style: TextStyle(
              color: kSand.withValues(alpha: 0.95),
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 22),
          const _SpecimenJarsRow(),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: kPine.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: kSand.withValues(alpha: 0.35), width: 1.0),
            ),
            child: const Text(
              'Each jar holds a living scrollable. Tap, scroll, fling — the '
              'diagnostics below each specimen show you the runtimeType of '
              'controller.position and the extra getters its concrete subtype '
              'brings along.',
              style: TextStyle(
                color: kPaper,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecimenJarsRow extends StatelessWidget {
  const _SpecimenJarsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          child: _SpecimenJar(
            label: 'SPSC',
            tagline: 'ScrollPositionWith\nSingleContext',
            icon: Icons.list_alt_outlined,
            accent: kSand,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _SpecimenJar(
            label: '_PP',
            tagline: '_PagePosition\n(library-private)',
            icon: Icons.pageview_outlined,
            accent: Color(0xFFE8BFC4),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _SpecimenJar(
            label: 'FESP',
            tagline: 'FixedExtent\nScrollPosition',
            icon: Icons.toll_outlined,
            accent: Color(0xFFD0D8C0),
          ),
        ),
      ],
    );
  }
}

class _SpecimenJar extends StatelessWidget {
  const _SpecimenJar({
    required this.label,
    required this.tagline,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String tagline;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(36),
          bottom: Radius.circular(10),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: kAccentGold, width: 1.2),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(color: kBurgundy, width: 1.2),
            ),
            child: Icon(icon, color: kBurgundy, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: kBurgundy,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tagline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: kInk,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// A specimen card: museum label on top, body below, diagnostics underneath.
// =============================================================================
class _SpecimenCard extends StatelessWidget {
  const _SpecimenCard({
    required this.specimenTag,
    required this.title,
    required this.subtitle,
    required this.bodyHeight,
    required this.body,
    required this.diagnostics,
    this.accent = kSand,
  });

  final String specimenTag;
  final String title;
  final String subtitle;
  final double bodyHeight;
  final Widget body;
  final Widget diagnostics;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: kAccentGold.withValues(alpha: 0.8),
          width: 1.1,
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SpecimenTag(text: specimenTag),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kBurgundy,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: kPine,
              fontSize: 13,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: bodyHeight,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: kBurgundy.withValues(alpha: 0.25), width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: body,
          ),
          const SizedBox(height: 14),
          diagnostics,
        ],
      ),
    );
  }
}

class _SpecimenTag extends StatelessWidget {
  const _SpecimenTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Transform.rotate(
        angle: -0.02,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kSpecimenTagBorder, width: 1.1),
            borderRadius: BorderRadius.circular(3),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kShadow.withValues(alpha: 0.15),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: kInk,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Diagnostics card — shared visual style, pulls from a _PositionSnapshot.
// =============================================================================
class _DiagnosticsCard extends StatelessWidget {
  const _DiagnosticsCard({
    required this.snap,
    required this.note,
    this.showExtra = false,
  });

  final _PositionSnapshot snap;
  final String note;
  final bool showExtra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPine.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: kPine.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.analytics_outlined,
                  size: 16, color: kBurgundy),
              const SizedBox(width: 6),
              const Text(
                'controller.position',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kBurgundy,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              _RuntimeTypeBadge(name: snap.runtimeTypeName),
            ],
          ),
          const SizedBox(height: 10),
          _DiagRow(label: 'pixels', value: snap.pixels.toStringAsFixed(2)),
          _DiagRow(
              label: 'minScrollExtent',
              value: snap.minScrollExtent.toStringAsFixed(2)),
          _DiagRow(
              label: 'maxScrollExtent',
              value: snap.maxScrollExtent.toStringAsFixed(2)),
          _DiagRow(
              label: 'viewportDimension',
              value: snap.viewportDimension.toStringAsFixed(2)),
          _DiagRow(
              label: 'userScrollDirection',
              value: snap.userScrollDirection),
          _DiagRow(label: 'axisDirection', value: snap.axisDirection),
          _DiagRow(
              label: 'haveDimensions',
              value: snap.haveDimensions.toString()),
          if (showExtra && snap.extraLabel != null)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: kBurgundy.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: _DiagRow(
                label: '${snap.extraLabel} (subtype-only)',
                value: snap.extraValue ?? '—',
                highlight: true,
              ),
            ),
          const SizedBox(height: 10),
          Text(
            note,
            style: const TextStyle(
              color: kPine,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagRow extends StatelessWidget {
  const _DiagRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: highlight ? kBurgundy : kInk,
                fontWeight:
                    highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: highlight ? kBurgundy : kInk,
                fontWeight:
                    highlight ? FontWeight.w700 : FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuntimeTypeBadge extends StatelessWidget {
  const _RuntimeTypeBadge({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Color(0xFFC4F0B4),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// =============================================================================
// Specimen 1 — ScrollPositionWithSingleContext via a plain ListView.
// =============================================================================
class _SpecimenPlainListView extends StatelessWidget {
  const _SpecimenPlainListView({
    required this.controller,
    required this.snap,
  });

  final ScrollController controller;
  final _PositionSnapshot snap;

  static const List<Color> _tileColors = <Color>[
    Color(0xFF7C1D2E),
    Color(0xFF8A2B3A),
    Color(0xFF973F4B),
    Color(0xFFA55363),
    Color(0xFFB3677A),
    Color(0xFF2F4F4F),
    Color(0xFF3D5F5E),
    Color(0xFF4B6F6D),
    Color(0xFF597F7C),
    Color(0xFF678F8B),
    Color(0xFFB08D4A),
    Color(0xFFBF9D5E),
    Color(0xFFCEAD72),
    Color(0xFFDDBD86),
    Color(0xFFEBCD9A),
    Color(0xFF5D4037),
    Color(0xFF6D5047),
    Color(0xFF7D6057),
    Color(0xFF8D7067),
    Color(0xFF9D8077),
  ];

  @override
  Widget build(BuildContext context) {
    return _SpecimenCard(
      specimenTag:
          'SPECIMEN #01 · runtimeType = ScrollPositionWithSingleContext',
      title: '1. ScrollPositionWithSingleContext',
      subtitle:
          'The most common position — used by ListView, GridView, '
          'CustomScrollView, SingleChildScrollView, and the base Scrollable.',
      bodyHeight: 260,
      accent: kSand,
      body: ListView.builder(
        controller: controller,
        itemCount: 40,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        itemBuilder: (BuildContext ctx, int i) {
          final Color c = _tileColors[i % _tileColors.length];
          return Container(
            height: 42,
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(6),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kShadow.withValues(alpha: 0.18),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: kPaper.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: c,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'tile ${i + 1} · plain ScrollController',
                    style: TextStyle(
                      color: kPaper.withValues(alpha: 0.98),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.drag_handle,
                    color: kPaper.withValues(alpha: 0.85), size: 18),
              ],
            ),
          );
        },
      ),
      diagnostics: _DiagnosticsCard(
        snap: snap,
        note: 'Because this is a vanilla ScrollController attached to a '
            'ListView, controller.position resolves to '
            'ScrollPositionWithSingleContext. No subtype-specific getters — '
            'all you can read is the base ScrollMetrics surface.',
      ),
    );
  }
}

// =============================================================================
// Specimen 2 — _PagePosition via PageView.
// =============================================================================
class _SpecimenPageView extends StatelessWidget {
  const _SpecimenPageView({
    required this.controller,
    required this.snap,
  });

  final PageController controller;
  final _PositionSnapshot snap;

  static const List<_OnboardingPanel> _panels = <_OnboardingPanel>[
    _OnboardingPanel(
      headline: 'Welcome',
      body: 'A tour of scroll position subtypes, powered by the real '
          'PageController you see here.',
      icon: Icons.auto_awesome_outlined,
      color: Color(0xFF7C1D2E),
    ),
    _OnboardingPanel(
      headline: 'viewportFraction',
      body: 'PageController.viewportFraction = 0.86 — neighbouring pages '
          'peek in on both sides.',
      icon: Icons.crop_free_outlined,
      color: Color(0xFFB08D4A),
    ),
    _OnboardingPanel(
      headline: 'page',
      body: 'controller.page returns a fractional page index while you '
          'drag; integer when at rest.',
      icon: Icons.numbers_outlined,
      color: Color(0xFF2F4F4F),
    ),
    _OnboardingPanel(
      headline: '_PagePosition',
      body: 'The runtimeType is library-private, but toString() still '
          'yields its name — useful for diagnostics.',
      icon: Icons.layers_outlined,
      color: Color(0xFF4A2C2A),
    ),
    _OnboardingPanel(
      headline: 'Extends SPSC',
      body: '_PagePosition extends ScrollPositionWithSingleContext, '
          'so you get all base ScrollMetrics plus page-aware math.',
      icon: Icons.account_tree_outlined,
      color: Color(0xFF3B5F5D),
    ),
    _OnboardingPanel(
      headline: 'Swipe on',
      body: 'Fling this PageView, watch pixels jump by viewport-width '
          'chunks, and `page` slide between integers.',
      icon: Icons.swipe_outlined,
      color: Color(0xFF8A2B3A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SpecimenCard(
      specimenTag: 'SPECIMEN #02 · runtimeType = _PagePosition (private)',
      title: '2. _PagePosition (via PageController)',
      subtitle:
          'Library-private subclass that extends '
          'ScrollPositionWithSingleContext. You cannot name the type in '
          'source, but the runtime still knows it.',
      bodyHeight: 220,
      accent: const Color(0xFFE8BFC4),
      body: PageView.builder(
        controller: controller,
        itemCount: _panels.length,
        padEnds: false,
        itemBuilder: (BuildContext ctx, int i) {
          final _OnboardingPanel p = _panels[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: p.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kShadow.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kPaper.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(p.icon, color: kPaper, size: 22),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: kPaper.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${i + 1} / ${_panels.length}',
                          style: const TextStyle(
                            color: kPaper,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        p.headline,
                        style: const TextStyle(
                          color: kPaper,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.body,
                        style: TextStyle(
                          color: kPaper.withValues(alpha: 0.92),
                          fontSize: 12.5,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      diagnostics: _DiagnosticsCard(
        snap: snap,
        showExtra: true,
        note: 'Notice `page` — that getter is not on ScrollPosition. It '
            'lives on PageController and is derived from _PagePosition. '
            'pixels grow in viewport-sized steps.',
      ),
    );
  }
}

class _OnboardingPanel {
  const _OnboardingPanel({
    required this.headline,
    required this.body,
    required this.icon,
    required this.color,
  });

  final String headline;
  final String body;
  final IconData icon;
  final Color color;
}

// =============================================================================
// Specimen 3 — FixedExtentScrollPosition via ListWheelScrollView.
// =============================================================================
class _SpecimenWheel extends StatelessWidget {
  const _SpecimenWheel({
    required this.controller,
    required this.snap,
    required this.onChanged,
    required this.currentSelection,
  });

  final FixedExtentScrollController controller;
  final _PositionSnapshot snap;
  final ValueChanged<int> onChanged;
  final int currentSelection;

  static const List<String> _months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
    'Undecember',
    'Duodecember',
    'Nonember',
    'Octember',
    'Septeber',
    'Hextember',
    'Pentember',
    'Quartember',
  ];

  @override
  Widget build(BuildContext context) {
    return _SpecimenCard(
      specimenTag:
          'SPECIMEN #03 · runtimeType = FixedExtentScrollPosition',
      title: '3. FixedExtentScrollPosition',
      subtitle:
          'The snapped-to-item position — used by ListWheelScrollView. '
          'pixels always lands on a multiple of itemExtent.',
      bodyHeight: 220,
      accent: const Color(0xFFD0D8C0),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 60,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: onChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: _months.length,
                builder: (BuildContext ctx, int i) {
                  final bool sel = i == currentSelection;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: sel
                          ? kBurgundy
                          : kPine.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            sel ? kAccentGold : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _months[i],
                      style: TextStyle(
                        color: sel ? kPaper : kInk,
                        fontSize: 16,
                        fontWeight: sel
                            ? FontWeight.w800
                            : FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: 1,
            color: kBurgundy.withValues(alpha: 0.25),
            margin: const EdgeInsets.symmetric(vertical: 18),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'selectedItem',
                    style: TextStyle(
                      color: kPine,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$currentSelection',
                    style: const TextStyle(
                      color: kBurgundy,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kBurgundy.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _months[currentSelection],
                      style: const TextStyle(
                        color: kBurgundy,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'pixels snap to\nmultiples of itemExtent = 60',
                    style: TextStyle(
                      color: kInk,
                      fontSize: 11,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      diagnostics: _DiagnosticsCard(
        snap: snap,
        showExtra: true,
        note: 'FixedExtentScrollController.selectedItem is derived from '
            'the concrete FixedExtentScrollPosition subtype — it is not on '
            'the base ScrollPosition. pixels divides cleanly by 60.',
      ),
    );
  }
}

// =============================================================================
// Section — runtimeType comparison table.
// =============================================================================
class _RuntimeTypeComparisonTable extends StatelessWidget {
  const _RuntimeTypeComparisonTable({
    required this.plain,
    required this.page,
    required this.wheel,
  });

  final _PositionSnapshot plain;
  final _PositionSnapshot page;
  final _PositionSnapshot wheel;

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 5 · COMPARISON',
      title: 'runtimeType comparison table',
      subtitle:
          'Four common scrollables, the controllers that drive them, and the '
          'concrete ScrollPosition subtype you observe at runtime.',
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: kBurgundy,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            child: Row(
              children: const <Widget>[
                Expanded(
                    flex: 3,
                    child: _ColHeader(text: 'Scrollable')),
                Expanded(
                    flex: 3,
                    child: _ColHeader(text: 'Controller')),
                Expanded(
                    flex: 4,
                    child: _ColHeader(
                        text: 'Position runtimeType')),
                Expanded(
                    flex: 4,
                    child:
                        _ColHeader(text: 'Notable extra getters')),
              ],
            ),
          ),
          _ComparisonRow(
            scrollable: 'ListView / GridView',
            controller: 'ScrollController',
            positionType: plain.runtimeTypeName,
            extras: '(none — base ScrollMetrics)',
            even: true,
          ),
          _ComparisonRow(
            scrollable: 'PageView',
            controller: 'PageController',
            positionType: page.runtimeTypeName,
            extras: 'PageController.page',
            even: false,
          ),
          _ComparisonRow(
            scrollable: 'ListWheelScrollView',
            controller: 'FixedExtentScrollController',
            positionType: wheel.runtimeTypeName,
            extras: 'selectedItem',
            even: true,
          ),
          _ComparisonRow(
            scrollable: 'CustomScrollView',
            controller: 'ScrollController',
            positionType: 'ScrollPositionWithSingleContext',
            extras: '(sliver geometry via RenderSliver…)',
            even: false,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ColHeader extends StatelessWidget {
  const _ColHeader({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: kPaper,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.scrollable,
    required this.controller,
    required this.positionType,
    required this.extras,
    required this.even,
    this.isLast = false,
  });

  final String scrollable;
  final String controller;
  final String positionType;
  final String extras;
  final bool even;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: even
            ? kPaper
            : kSand.withValues(alpha: 0.55),
        borderRadius: isLast
            ? const BorderRadius.vertical(bottom: Radius.circular(8))
            : BorderRadius.zero,
        border: Border(
          bottom: BorderSide(
            color: kBurgundy.withValues(alpha: 0.22),
            width: isLast ? 0 : 0.6,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              scrollable,
              style: const TextStyle(
                color: kInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              controller,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: kPine,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: kInk,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                positionType,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFFC4F0B4),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Text(
              extras,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: kBurgundy,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section — Class hierarchy diagram (column of boxes with guide lines).
// =============================================================================
class _HierarchyDiagram extends StatelessWidget {
  const _HierarchyDiagram();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 6 · HIERARCHY',
      title: 'Class hierarchy diagram',
      subtitle:
          'How the concrete subtypes descend from the abstract base. The '
          'bracketed branches are drawn by hand with Container boxes.',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HierarchyBox(
              title: 'ScrollPosition',
              subtitle: 'abstract · dart:flutter/widgets',
              badge: 'abstract',
              color: kInk,
              textColor: kPaper,
            ),
            const _HierarchyConnector(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      _HierarchyBox(
                        title: 'ScrollPositionWithSingleContext',
                        subtitle: 'public · concrete',
                        badge: 'concrete',
                        color: kBurgundy,
                        textColor: kPaper,
                      ),
                      const _HierarchyConnector(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _HierarchyBox(
                              title: '_PagePosition',
                              subtitle: 'private · via PageController',
                              badge: 'private',
                              color: kPine,
                              textColor: kPaper,
                              dashed: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _HierarchyBox(
                              title: '(used directly)',
                              subtitle: 'ListView / GridView /\n'
                                  'CustomScrollView',
                              badge: 'usage',
                              color: kSand,
                              textColor: kInk,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      _HierarchyBox(
                        title: 'FixedExtentScrollPosition',
                        subtitle: 'public · concrete',
                        badge: 'concrete',
                        color: kAccentGold,
                        textColor: kInk,
                      ),
                      const _HierarchyConnector(),
                      _HierarchyBox(
                        title: '(used directly)',
                        subtitle: 'ListWheelScrollView\n'
                            'via FixedExtentScrollController',
                        badge: 'usage',
                        color: kSand,
                        textColor: kInk,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HierarchyBox extends StatelessWidget {
  const _HierarchyBox({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.color,
    required this.textColor,
    this.dashed = false,
  });

  final String title;
  final String subtitle;
  final String badge;
  final Color color;
  final Color textColor;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: dashed
              ? kAccentGold
              : color.withValues(alpha: 0.0),
          width: dashed ? 1.5 : 0,
          style: dashed ? BorderStyle.solid : BorderStyle.none,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: textColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.85),
              fontSize: 10.5,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _HierarchyConnector extends StatelessWidget {
  const _HierarchyConnector();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 2,
        height: 18,
        color: kAccentGold,
      ),
    );
  }
}

// =============================================================================
// Section — Shared metrics panel across all three specimens.
// =============================================================================
class _SharedMetricsPanel extends StatelessWidget {
  const _SharedMetricsPanel({
    required this.plain,
    required this.page,
    required this.wheel,
  });

  final _PositionSnapshot plain;
  final _PositionSnapshot page;
  final _PositionSnapshot wheel;

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 7 · SHARED vs DIFFERENT',
      title: 'Shared metrics panel',
      subtitle:
          'Top row = what every ScrollPosition exposes. Bottom row = the '
          'subtype-only getters that set each specimen apart.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _MetricsRowLabel(
            label: 'SHARED · ScrollMetrics surface',
            color: kPine,
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Expanded(
                  child: _MetricsTile(
                      title: 'plain', snap: plain, color: kBurgundy)),
              const SizedBox(width: 8),
              Expanded(
                  child: _MetricsTile(
                      title: 'page', snap: page, color: kPine)),
              const SizedBox(width: 8),
              Expanded(
                  child: _MetricsTile(
                      title: 'wheel', snap: wheel, color: kAccentGold)),
            ],
          ),
          const SizedBox(height: 16),
          const _MetricsRowLabel(
            label: 'DIFFERENT · subtype-only getters',
            color: kBurgundy,
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Expanded(
                child: _ExtraTile(
                  title: 'ScrollPositionWith\nSingleContext',
                  extraName: '—',
                  extraValue: 'only ScrollMetrics',
                  color: kBurgundy,
                  available: false,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ExtraTile(
                  title: '_PagePosition',
                  extraName: 'page',
                  extraValue: page.extraValue ?? '—',
                  color: kPine,
                  available: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ExtraTile(
                  title: 'FixedExtent\nScrollPosition',
                  extraName: 'selectedItem',
                  extraValue: wheel.extraValue ?? '—',
                  color: kAccentGold,
                  available: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricsRowLabel extends StatelessWidget {
  const _MetricsRowLabel({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 14, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _MetricsTile extends StatelessWidget {
  const _MetricsTile({
    required this.title,
    required this.snap,
    required this.color,
  });

  final String title;
  final _PositionSnapshot snap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          _KvRow(k: 'pixels', v: snap.pixels.toStringAsFixed(1)),
          _KvRow(k: 'min', v: snap.minScrollExtent.toStringAsFixed(1)),
          _KvRow(k: 'max', v: snap.maxScrollExtent.toStringAsFixed(1)),
          _KvRow(k: 'viewport', v: snap.viewportDimension.toStringAsFixed(1)),
        ],
      ),
    );
  }
}

class _ExtraTile extends StatelessWidget {
  const _ExtraTile({
    required this.title,
    required this.extraName,
    required this.extraValue,
    required this.color,
    required this.available,
  });

  final String title;
  final String extraName;
  final String extraValue;
  final Color color;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: available
            ? color.withValues(alpha: 0.15)
            : kSand.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: available
              ? color
              : kInk.withValues(alpha: 0.3),
          width: 1.2,
          style:
              available ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: available ? color : kInk,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            extraName,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: available ? kInk : kInk.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            extraValue,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: available ? color : kInk.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _KvRow extends StatelessWidget {
  const _KvRow({required this.k, required this.v});
  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 58,
            child: Text(
              k,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: kPine,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: kInk,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section — Teaching panel (prose tiles).
// =============================================================================
class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 8 · FIELD GUIDE',
      title: 'When to reach for which controller',
      subtitle:
          'A short flowchart in prose. Pick your question, get your controller.',
      child: Column(
        children: <Widget>[
          _TeachingTile(
            leadingIcon: Icons.article_outlined,
            title: 'Need page-level math?',
            body:
                'If you need page fraction, viewportFraction, or pagewise '
                'snapping, use a PageController. Its controller.position is '
                'internally a _PagePosition (extends '
                'ScrollPositionWithSingleContext) and the controller exposes '
                '`page` as a first-class getter.',
            color: kBurgundy,
          ),
          SizedBox(height: 10),
          _TeachingTile(
            leadingIcon: Icons.filter_3_outlined,
            title: 'Need snapped-to-item math?',
            body:
                'If you are building a picker, cupertino-style wheel, or any '
                'UI where a single discrete item is selected, reach for '
                'FixedExtentScrollController. You get FixedExtentScrollPosition '
                'and its `selectedItem` getter for free.',
            color: kPine,
          ),
          SizedBox(height: 10),
          _TeachingTile(
            leadingIcon: Icons.view_list_outlined,
            title: 'Need arbitrary pixels?',
            body:
                'For everything else — chat logs, feeds, data grids, hero '
                'scroll effects — a plain ScrollController gives you '
                'ScrollPositionWithSingleContext, which exposes only the base '
                'ScrollMetrics surface. That is usually all you need.',
            color: kAccentGold,
          ),
          SizedBox(height: 10),
          _TeachingTile(
            leadingIcon: Icons.help_outline,
            title: 'What about CustomScrollView?',
            body:
                'It uses the same ScrollPositionWithSingleContext under the '
                'hood. The slivers compose their geometry during layout — the '
                'ScrollPosition remains the same. So your controller reads '
                'the same metrics you know from ListView.',
            color: kInk,
          ),
        ],
      ),
    );
  }
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({
    required this.leadingIcon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData leadingIcon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 4),
          top: BorderSide(
              color: color.withValues(alpha: 0.2), width: 1),
          bottom: BorderSide(
              color: color.withValues(alpha: 0.2), width: 1),
          right: BorderSide(
              color: color.withValues(alpha: 0.2), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(leadingIcon, color: color, size: 22),
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
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: kInk,
                    fontSize: 12.5,
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
}

// =============================================================================
// Section — Use cases strip.
// =============================================================================
class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 9 · IN THE WILD',
      title: 'Where each subtype shows up',
      subtitle:
          'Four concrete app archetypes, one for each of the common '
          'scroll-position flavours you will meet in production code.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          Expanded(
            child: _UseCaseTile(
              title: 'Infinite chat log',
              subtitle: 'plain ScrollController',
              positionType: 'ScrollPositionWith\nSingleContext',
              icon: Icons.chat_bubble_outline,
              color: kBurgundy,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _UseCaseTile(
              title: 'Onboarding flow',
              subtitle: 'PageController',
              positionType: '_PagePosition',
              icon: Icons.view_carousel_outlined,
              color: kPine,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _UseCaseTile(
              title: 'Cupertino picker',
              subtitle: 'FixedExtentScroll\nController',
              positionType: 'FixedExtentScroll\nPosition',
              icon: Icons.date_range_outlined,
              color: kAccentGold,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _UseCaseTile(
              title: 'Hybrid carousel',
              subtitle: 'PageController\n(with snap)',
              positionType: '_PagePosition',
              icon: Icons.photo_library_outlined,
              color: Color(0xFF4A2C2A),
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({
    required this.title,
    required this.subtitle,
    required this.positionType,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String positionType;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.28),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: kPaper.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: kPaper, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: kPaper,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: kPaper.withValues(alpha: 0.82),
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              positionType,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFC4F0B4),
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section — Code snippets panel (three monospace code blocks side-by-side).
// =============================================================================
class _CodeSnippetsPanel extends StatelessWidget {
  const _CodeSnippetsPanel();

  static const String _plainCode = '''// ScrollPositionWithSingleContext
final scrollController =
    ScrollController();

ListView.builder(
  controller: scrollController,
  itemCount: 500,
  itemBuilder: (ctx, i) =>
      ListTile(title: Text('\$i')),
);

// read metrics:
final p = scrollController.position;
debugPrint(p.runtimeType.toString());
debugPrint('pixels=\${p.pixels}');
debugPrint('max=\${p.maxScrollExtent}');''';

  static const String _pageCode = '''// _PagePosition (extends SPSC)
final pageController = PageController(
  viewportFraction: 0.86,
  initialPage: 0,
);

PageView.builder(
  controller: pageController,
  itemCount: 6,
  itemBuilder: (ctx, i) =>
      _buildPanel(i),
);

// read PAGE-AWARE metrics:
final p = pageController.position;
debugPrint(p.runtimeType.toString());
debugPrint('page=\${pageController.page}');
debugPrint('pixels=\${p.pixels}');''';

  static const String _wheelCode = '''// FixedExtentScrollPosition
final wheelController =
    FixedExtentScrollController(
        initialItem: 4);

ListWheelScrollView.useDelegate(
  controller: wheelController,
  itemExtent: 60,
  physics:
      const FixedExtentScrollPhysics(),
  childDelegate:
      ListWheelChildBuilderDelegate(
    childCount: 20,
    builder: (ctx, i) => _buildItem(i),
  ),
);

// snapped-to-item metrics:
debugPrint(
    wheelController.selectedItem
        .toString());''';

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      sectionLabel: 'SECTION 10 · SNIPPETS',
      title: 'Three controllers, three code paths',
      subtitle:
          'Side-by-side construction recipes for each of the specimens '
          'above. Copy any one of them into a fresh app and watch the '
          'runtimeType appear.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          Expanded(
            child: _CodeBlock(
              caption: 'plain',
              code: _plainCode,
              accent: kBurgundy,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _CodeBlock(
              caption: 'page',
              code: _pageCode,
              accent: kPine,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _CodeBlock(
              caption: 'wheel',
              code: _wheelCode,
              accent: kAccentGold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({
    required this.caption,
    required this.code,
    required this.accent,
  });

  final String caption;
  final String code;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(7)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6F61),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD166),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6ECB63),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'specimen.$caption.dart',
                  style: const TextStyle(
                    color: kPaper,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFDCE6CC),
                fontFamily: 'monospace',
                fontSize: 10.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section — Footer summary card.
// =============================================================================
class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kPine, kBurgundy],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
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
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kSand,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'EXHIBIT CLOSES',
                  style: TextStyle(
                    color: kBurgundy,
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.bookmark_border,
                  color: kPaper.withValues(alpha: 0.85)),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Three subtypes, one abstract ancestor',
            style: TextStyle(
              color: kPaper,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ScrollPosition is the abstract spine of every scrollable in '
            'Flutter. The concrete subtypes you actually encounter — '
            'ScrollPositionWithSingleContext, _PagePosition, and '
            'FixedExtentScrollPosition — are how the framework tunes its '
            'pixel model to ListView, PageView, and ListWheelScrollView '
            'respectively. Knowing which one you are holding tells you '
            'which extra getters you can reach.',
            style: TextStyle(
              color: kPaper.withValues(alpha: 0.95),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              _FooterPill(
                  label: 'pixels', color: kSand, textColor: kBurgundy),
              const SizedBox(width: 8),
              _FooterPill(
                  label: 'page',
                  color: kAccentGold,
                  textColor: kInk),
              const SizedBox(width: 8),
              _FooterPill(
                  label: 'selectedItem',
                  color: kPaper,
                  textColor: kBurgundy),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterPill extends StatelessWidget {
  const _FooterPill({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =============================================================================
// Reusable section frame used by sections 5-10.
// =============================================================================
class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.sectionLabel,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String sectionLabel;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: kAccentGold.withValues(alpha: 0.7),
          width: 1.1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kShadow.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: kInk,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  sectionLabel,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: kSand,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 2,
                color: kAccentGold,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: kBurgundy,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: kPine,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
