import 'package:flutter/material.dart';

// ScrollView Family Portrait — a deep visual demo for the ScrollView abstract
// class and its direct subclasses (ListView, GridView, CustomScrollView,
// PageView). This file is executed by the d4rt AST harness which expects a
// top-level `build(BuildContext)` returning a MaterialApp. There is no
// main()/runApp(): the harness hosts the tree.
//
// Palette:
//   forest  Color(0xFF2F4F2F)
//   coral   Color(0xFFE07856)
//   cream   Color(0xFFFBF8EF)
//   ink     Color(0xFF1B2A33)

// ---------------------------------------------------------------------------
// Palette constants
// ---------------------------------------------------------------------------

const Color kForest = Color(0xFF2F4F2F);
const Color kCoral = Color(0xFFE07856);
const Color kCream = Color(0xFFFBF8EF);
const Color kInk = Color(0xFF1B2A33);
const Color kMist = Color(0xFFEFE6D4);
const Color kSage = Color(0xFF6A8E5A);
const Color kAmber = Color(0xFFE3B23C);

// ---------------------------------------------------------------------------
// Entry point — the d4rt harness calls this.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollView Family Portrait',
    theme: ThemeData(
      scaffoldBackgroundColor: kCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kForest,
        primary: kForest,
        secondary: kCoral,
        surface: kCream,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInk),
        headlineSmall: TextStyle(
          color: kForest,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    home: const _ScrollViewFamilyHome(),
  );
}

// ---------------------------------------------------------------------------
// Home shell — StatefulWidget so we can own the controllers and the
// "focused scroller" selection for the diagnostics panel.
// ---------------------------------------------------------------------------

class _ScrollViewFamilyHome extends StatefulWidget {
  const _ScrollViewFamilyHome();

  @override
  State<_ScrollViewFamilyHome> createState() => _ScrollViewFamilyHomeState();
}

enum _FocusedScroller { listView, gridView, customScrollView, pageView }

class _ScrollViewFamilyHomeState extends State<_ScrollViewFamilyHome> {
  // Controllers — each live subclass gets its own. PageView requires a
  // PageController; the others use ScrollController. We dispose them below.
  final ScrollController _listController = ScrollController();
  final ScrollController _gridController = ScrollController();
  final ScrollController _customController = ScrollController();
  final PageController _pageController = PageController();

  // The scroller whose shared properties are mirrored in the diagnostics
  // panel. SegmentedButton drives this.
  _FocusedScroller _focused = _FocusedScroller.listView;

  // Page index tracked for the indicator dots on PageView.
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final p = _pageController.page;
    if (p == null) return;
    final next = p.round();
    if (next != _pageIndex) {
      setState(() => _pageIndex = next);
    }
  }

  @override
  void dispose() {
    _listController.dispose();
    _gridController.dispose();
    _customController.dispose();
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Scaffold
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        backgroundColor: kForest,
        foregroundColor: kCream,
        elevation: 0,
        title: const Text(
          'ScrollView — Family Portrait',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
      ),
      body: SafeArea(
        child: ListView(
          // The outer page scroller. Shrink-wrap false because we want
          // the viewport-sized behaviour.
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          children: <Widget>[
            // Section 1 — Hero header with family portrait.
            const _HeroHeader(),
            const SizedBox(height: 24),

            // Section 2 — ListView card (live).
            _ListViewCard(controller: _listController),
            const SizedBox(height: 24),

            // Section 3 — GridView card (live).
            _GridViewCard(controller: _gridController),
            const SizedBox(height: 24),

            // Section 4 — CustomScrollView card (live).
            _CustomScrollViewCard(controller: _customController),
            const SizedBox(height: 24),

            // Section 5 — PageView card (live).
            _PageViewCard(
              controller: _pageController,
              pageIndex: _pageIndex,
              onDotTap: (i) => _pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
              ),
            ),
            const SizedBox(height: 28),

            // Section 6 — Shared-property diagnostics panel.
            _SharedDiagnosticsPanel(
              focused: _focused,
              onChanged: (f) => setState(() => _focused = f),
            ),
            const SizedBox(height: 28),

            // Section 7 — Property showcase row.
            const _PropertyShowcaseRow(),
            const SizedBox(height: 28),

            // Section 8 — Class hierarchy diagram.
            const _ClassHierarchyDiagram(),
            const SizedBox(height: 28),

            // Section 9 — Decision table.
            const _DecisionTable(),
            const SizedBox(height: 28),

            // Section 10 — Teaching tiles.
            const _TeachingTiles(),
            const SizedBox(height: 28),

            // Section 11 — Footer summary.
            const _FooterSummary(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Hero header
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kForest,
            kSage,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.16),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
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
                  color: kCream.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: kCream.withValues(alpha: 0.32),
                  ),
                ),
                child: const Text(
                  'abstract class ScrollView',
                  style: TextStyle(
                    color: kCream,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.view_stream_rounded, color: kCream),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'ScrollView — the shared spine\nof Flutter scrollables',
            style: TextStyle(
              color: kCream,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.18,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Four subclasses, one heartbeat. Scroll direction, physics, '
            'cacheExtent, shrinkWrap, keyboardDismissBehavior — they all flow '
            'from the same abstract parent.',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.88),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          // 4-quadrant "family portrait" grid.
          const _FamilyPortraitGrid(),
        ],
      ),
    );
  }
}

class _FamilyPortraitGrid extends StatelessWidget {
  const _FamilyPortraitGrid();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCream.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCream.withValues(alpha: 0.22)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: const <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _FamilyQuadrant(
                  icon: Icons.view_list_rounded,
                  label: 'ListView',
                  subtitle: 'linear · lazy',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _FamilyQuadrant(
                  icon: Icons.grid_view_rounded,
                  label: 'GridView',
                  subtitle: '2-D tiles',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _FamilyQuadrant(
                  icon: Icons.layers_rounded,
                  label: 'CustomScrollView',
                  subtitle: 'slivers',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _FamilyQuadrant(
                  icon: Icons.view_carousel_rounded,
                  label: 'PageView',
                  subtitle: 'paginated',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FamilyQuadrant extends StatelessWidget {
  const _FamilyQuadrant({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  final IconData icon;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: kInk.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kCoral.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kCream, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: kCream,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: kCream.withValues(alpha: 0.76),
                    fontSize: 11,
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
}

// ---------------------------------------------------------------------------
// Reusable "card" chrome with a coloured top strip that names the subclass.
// ---------------------------------------------------------------------------

class _SubclassCard extends StatelessWidget {
  const _SubclassCard({
    required this.title,
    required this.subtitle,
    required this.stripColor,
    required this.child,
    required this.diagnostics,
    this.height = 320,
  });

  final String title;
  final String subtitle;
  final Color stripColor;
  final Widget child;
  final Widget diagnostics;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kMist),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Top strip.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: stripColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: kCream,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: kCream.withValues(alpha: 0.82),
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: kCream.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(
                      color: kCream,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Live region.
          SizedBox(height: height, child: child),
          // Diagnostics footer.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kMist.withValues(alpha: 0.45),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              border: Border(
                top: BorderSide(color: kMist),
              ),
            ),
            child: diagnostics,
          ),
        ],
      ),
    );
  }
}

// A compact key/value row used in diagnostics footers.
class _KvRow extends StatelessWidget {
  const _KvRow({required this.k, required this.v});

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 148,
            child: Text(
              k,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: kForest,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: kInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — ListView card
// ---------------------------------------------------------------------------

class _ListViewCard extends StatelessWidget {
  const _ListViewCard({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    // Build 40 coloured tiles.
    const tileCount = 40;
    return _SubclassCard(
      title: 'ListView',
      subtitle: 'ListView extends ScrollView',
      stripColor: kForest,
      diagnostics: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'ScrollView props in use',
            style: TextStyle(
              color: kCoral,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 6),
          _KvRow(k: 'scrollDirection', v: 'Axis.vertical'),
          _KvRow(k: 'physics', v: 'BouncingScrollPhysics'),
          _KvRow(k: 'cacheExtent', v: '600.0'),
          _KvRow(k: 'shrinkWrap', v: 'false'),
          _KvRow(k: 'itemBuilder', v: '.builder (lazy)'),
        ],
      ),
      child: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: tileCount,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 600,
        itemBuilder: (context, index) {
          final hue = (index * 9) % 360;
          final color = HSLColor.fromAHSL(1, hue.toDouble(), 0.45, 0.62)
              .toColor();
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: color.withValues(alpha: 0.62),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: kCream,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Item #${index + 1} — lazy built',
                    style: const TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: kInk,
                  size: 18,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — GridView card
// ---------------------------------------------------------------------------

class _GridViewCard extends StatelessWidget {
  const _GridViewCard({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    const tiles = 24;
    return _SubclassCard(
      title: 'GridView',
      subtitle: 'GridView extends ScrollView',
      stripColor: kCoral,
      diagnostics: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'ScrollView props in use',
            style: TextStyle(
              color: kCoral,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 6),
          _KvRow(k: 'scrollDirection', v: 'Axis.vertical'),
          _KvRow(k: 'physics', v: 'ClampingScrollPhysics'),
          _KvRow(k: 'cacheExtent', v: '400.0'),
          _KvRow(k: 'gridDelegate', v: 'FixedCrossAxisCount(2)'),
          _KvRow(k: 'childAspectRatio', v: '2.6'),
        ],
      ),
      child: GridView.count(
        controller: controller,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
        padding: const EdgeInsets.all(12),
        physics: const ClampingScrollPhysics(),
        cacheExtent: 400,
        children: List<Widget>.generate(tiles, (i) {
          final hue = (i * (360 / tiles)).floorToDouble();
          final color = HSLColor.fromAHSL(1, hue, 0.55, 0.55).toColor();
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  color.withValues(alpha: 0.86),
                  color.withValues(alpha: 0.54),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.92)),
            ),
            alignment: Alignment.center,
            child: Text(
              'tile ${i + 1}',
              style: const TextStyle(
                color: kCream,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — CustomScrollView card
// ---------------------------------------------------------------------------

class _CustomScrollViewCard extends StatelessWidget {
  const _CustomScrollViewCard({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return _SubclassCard(
      title: 'CustomScrollView',
      subtitle: 'CustomScrollView extends ScrollView — slivers all the way down',
      stripColor: kInk,
      height: 420,
      diagnostics: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'ScrollView props in use',
            style: TextStyle(
              color: kCoral,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 6),
          _KvRow(k: 'scrollDirection', v: 'Axis.vertical'),
          _KvRow(k: 'physics', v: 'BouncingScrollPhysics'),
          _KvRow(k: 'cacheExtent', v: '300.0'),
          _KvRow(
            k: 'slivers',
            v: '[SliverAppBar, Adapter, List, Grid]',
          ),
        ],
      ),
      child: CustomScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 300,
        slivers: <Widget>[
          // Pinned small SliverAppBar.
          SliverAppBar(
            pinned: true,
            backgroundColor: kForest,
            foregroundColor: kCream,
            elevation: 0,
            toolbarHeight: 38,
            title: const Text(
              'pinned SliverAppBar',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                letterSpacing: 0.4,
              ),
            ),
          ),
          // Banner.
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kAmber.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kAmber.withValues(alpha: 0.72)),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.info_outline, color: kInk, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'SliverToBoxAdapter — one box treated as a sliver.',
                      style: TextStyle(
                        color: kInk,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SliverList (20 items).
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: kSage.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kSage.withValues(alpha: 0.46)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kSage,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: kCream,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'SliverList row ${i + 1}',
                          style: const TextStyle(
                            color: kInk,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 20,
            ),
          ),
          // SliverGrid (2 x 10).
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final color = HSLColor.fromAHSL(
                    1,
                    (i * 36).toDouble() % 360,
                    0.5,
                    0.58,
                  ).toColor();
                  return Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: color.withValues(alpha: 0.72),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'g${i + 1}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — PageView card
// ---------------------------------------------------------------------------

class _PageViewCard extends StatelessWidget {
  const _PageViewCard({
    required this.controller,
    required this.pageIndex,
    required this.onDotTap,
  });

  final PageController controller;
  final int pageIndex;
  final void Function(int) onDotTap;

  @override
  Widget build(BuildContext context) {
    const panelColors = <Color>[
      Color(0xFFE07856), // coral
      Color(0xFFE3B23C), // amber
      Color(0xFF6A8E5A), // sage
      Color(0xFF2F4F2F), // forest
      Color(0xFF4F6D7A), // slate
      Color(0xFF8A5E9B), // plum
    ];
    return _SubclassCard(
      title: 'PageView',
      subtitle: 'PageView extends ScrollView via PageController',
      stripColor: kAmber,
      height: 300,
      diagnostics: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ScrollView props in use',
            style: TextStyle(
              color: kCoral,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const _KvRow(k: 'scrollDirection', v: 'Axis.horizontal'),
          const _KvRow(k: 'physics', v: 'PageScrollPhysics'),
          const _KvRow(k: 'controller', v: 'PageController'),
          _KvRow(k: 'currentPage', v: pageIndex.toString()),
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics: const PageScrollPhysics(),
              itemCount: panelColors.length,
              itemBuilder: (context, i) {
                final color = panelColors[i];
                return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        color,
                        color.withValues(alpha: 0.62),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: color.withValues(alpha: 0.42),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Panel ${i + 1} / ${panelColors.length}',
                        style: TextStyle(
                          color: kCream.withValues(alpha: 0.84),
                          fontSize: 12,
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Swipe →',
                        style: const TextStyle(
                          color: kCream,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'PageView snaps each child to the viewport.',
                        style: TextStyle(
                          color: kCream.withValues(alpha: 0.9),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Dots indicator.
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(panelColors.length, (i) {
                final active = i == pageIndex;
                return GestureDetector(
                  onTap: () => onDotTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active
                          ? kForest
                          : kForest.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Shared-property diagnostics panel
// ---------------------------------------------------------------------------

class _SharedDiagnosticsPanel extends StatelessWidget {
  const _SharedDiagnosticsPanel({
    required this.focused,
    required this.onChanged,
  });

  final _FocusedScroller focused;
  final void Function(_FocusedScroller) onChanged;

  Map<String, String> _propsFor(_FocusedScroller f) {
    switch (f) {
      case _FocusedScroller.listView:
        return <String, String>{
          'runtimeType': 'ListView',
          'scrollDirection': 'Axis.vertical',
          'reverse': 'false',
          'primary': 'null  (has controller)',
          'physics': 'BouncingScrollPhysics',
          'shrinkWrap': 'false',
          'cacheExtent': '600.0',
          'semanticChildCount': '40',
          'dragStartBehavior': 'DragStartBehavior.start',
          'keyboardDismissBehavior': 'manual',
          'restorationId': 'null',
          'clipBehavior': 'Clip.hardEdge',
          'hitTestBehavior': 'opaque',
          'controller': 'ScrollController',
        };
      case _FocusedScroller.gridView:
        return <String, String>{
          'runtimeType': 'GridView',
          'scrollDirection': 'Axis.vertical',
          'reverse': 'false',
          'primary': 'null  (has controller)',
          'physics': 'ClampingScrollPhysics',
          'shrinkWrap': 'false',
          'cacheExtent': '400.0',
          'semanticChildCount': '24',
          'dragStartBehavior': 'DragStartBehavior.start',
          'keyboardDismissBehavior': 'manual',
          'restorationId': 'null',
          'clipBehavior': 'Clip.hardEdge',
          'hitTestBehavior': 'opaque',
          'controller': 'ScrollController',
        };
      case _FocusedScroller.customScrollView:
        return <String, String>{
          'runtimeType': 'CustomScrollView',
          'scrollDirection': 'Axis.vertical',
          'reverse': 'false',
          'primary': 'null  (has controller)',
          'physics': 'BouncingScrollPhysics',
          'shrinkWrap': 'false',
          'cacheExtent': '300.0',
          'semanticChildCount': 'null  (slivers)',
          'dragStartBehavior': 'DragStartBehavior.start',
          'keyboardDismissBehavior': 'manual',
          'restorationId': 'null',
          'clipBehavior': 'Clip.hardEdge',
          'hitTestBehavior': 'opaque',
          'controller': 'ScrollController',
        };
      case _FocusedScroller.pageView:
        return <String, String>{
          'runtimeType': 'PageView',
          'scrollDirection': 'Axis.horizontal',
          'reverse': 'false',
          'primary': 'false  (uses PageController)',
          'physics': 'PageScrollPhysics',
          'shrinkWrap': 'n/a',
          'cacheExtent': 'null',
          'semanticChildCount': '6',
          'dragStartBehavior': 'DragStartBehavior.start',
          'keyboardDismissBehavior': 'manual',
          'restorationId': 'null',
          'clipBehavior': 'Clip.hardEdge',
          'hitTestBehavior': 'opaque',
          'controller': 'PageController',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final props = _propsFor(focused);
    return Container(
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.memory_rounded, color: kAmber, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Shared-property diagnostics',
                style: TextStyle(
                  color: kCream,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kCoral.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'read-only',
                  style: TextStyle(
                    color: kCoral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Pick a focused scroller to inspect its ScrollView-inherited '
            'properties. All four subclasses expose the same surface — only '
            'the runtime values differ.',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.82),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          // Segmented control.
          SegmentedButton<_FocusedScroller>(
            segments: const <ButtonSegment<_FocusedScroller>>[
              ButtonSegment<_FocusedScroller>(
                value: _FocusedScroller.listView,
                label: Text('ListView'),
                icon: Icon(Icons.view_list_rounded),
              ),
              ButtonSegment<_FocusedScroller>(
                value: _FocusedScroller.gridView,
                label: Text('GridView'),
                icon: Icon(Icons.grid_view_rounded),
              ),
              ButtonSegment<_FocusedScroller>(
                value: _FocusedScroller.customScrollView,
                label: Text('Custom'),
                icon: Icon(Icons.layers_rounded),
              ),
              ButtonSegment<_FocusedScroller>(
                value: _FocusedScroller.pageView,
                label: Text('PageView'),
                icon: Icon(Icons.view_carousel_rounded),
              ),
            ],
            selected: <_FocusedScroller>{focused},
            onSelectionChanged: (Set<_FocusedScroller> s) {
              if (s.isNotEmpty) {
                onChanged(s.first);
              }
            },
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(kCream),
              backgroundColor: WidgetStateProperty.resolveWith<Color>((s) {
                if (s.contains(WidgetState.selected)) {
                  return kCoral.withValues(alpha: 0.92);
                }
                return kInk;
              }),
              side: WidgetStatePropertyAll(
                BorderSide(color: kCream.withValues(alpha: 0.22)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Property grid — two columns.
          _PropertyGrid(props: props),
        ],
      ),
    );
  }
}

class _PropertyGrid extends StatelessWidget {
  const _PropertyGrid({required this.props});

  final Map<String, String> props;

  @override
  Widget build(BuildContext context) {
    final entries = props.entries.toList(growable: false);
    final left = <MapEntry<String, String>>[];
    final right = <MapEntry<String, String>>[];
    for (var i = 0; i < entries.length; i++) {
      if (i.isEven) {
        left.add(entries[i]);
      } else {
        right.add(entries[i]);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _PropertyColumn(entries: left)),
        const SizedBox(width: 14),
        Expanded(child: _PropertyColumn(entries: right)),
      ],
    );
  }
}

class _PropertyColumn extends StatelessWidget {
  const _PropertyColumn({required this.entries});

  final List<MapEntry<String, String>> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${e.key} ',
                  style: TextStyle(
                    color: kAmber.withValues(alpha: 0.9),
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    e.value,
                    style: const TextStyle(
                      color: kCream,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — Property showcase row (mini-cards)
// ---------------------------------------------------------------------------

class _PropertyShowcaseRow extends StatelessWidget {
  const _PropertyShowcaseRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          label: 'Property showcase',
          desc:
              'Same ListView, one property flipped per card — watch the '
              'visible consequence.',
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            children: const <Widget>[
              _PropertyMiniCard(
                label: 'reverse: true',
                note: 'Scrolls up from bottom.',
                child: _ReverseListDemo(),
              ),
              SizedBox(width: 12),
              _PropertyMiniCard(
                label: 'shrinkWrap: true',
                note: 'Sized to its children.',
                child: _ShrinkWrapListDemo(),
              ),
              SizedBox(width: 12),
              _PropertyMiniCard(
                label: 'physics: Never…',
                note: 'Cannot scroll.',
                child: _NeverScrollListDemo(),
              ),
              SizedBox(width: 12),
              _PropertyMiniCard(
                label: 'Axis.horizontal',
                note: 'Sideways flow.',
                child: _HorizontalListDemo(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PropertyMiniCard extends StatelessWidget {
  const _PropertyMiniCard({
    required this.label,
    required this.note,
    required this.child,
  });

  final String label;
  final String note;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kMist),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: kForest,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: kCream,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              note,
              style: const TextStyle(
                color: kInk,
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReverseListDemo extends StatelessWidget {
  const _ReverseListDemo();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 12,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: kCoral.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('row ${i + 1}', style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

class _ShrinkWrapListDemo extends StatelessWidget {
  const _ShrinkWrapListDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMist.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(6),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kSage.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'tight ${i + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NeverScrollListDemo extends StatelessWidget {
  const _NeverScrollListDemo();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 40,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: kInk.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('locked ${i + 1}',
            style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

class _HorizontalListDemo extends StatelessWidget {
  const _HorizontalListDemo();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, i) => Container(
        width: 56,
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        decoration: BoxDecoration(
          color: HSLColor.fromAHSL(1, (i * 18).toDouble(), 0.5, 0.62)
              .toColor(),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${i + 1}',
          style: const TextStyle(
            color: kCream,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — Class hierarchy diagram
// ---------------------------------------------------------------------------

class _ClassHierarchyDiagram extends StatelessWidget {
  const _ClassHierarchyDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          label: 'Class hierarchy',
          desc:
              'ScrollView is abstract; these four reuse the same shared '
              'property surface.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: kMist),
          ),
          child: Column(
            children: <Widget>[
              // Parent.
              _HierarchyBox(
                title: 'ScrollView',
                subtitle: 'abstract — extends StatelessWidget',
                color: kForest,
                wide: true,
              ),
              const _ArrowDown(),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: _HierarchyBox(
                      title: 'ListView',
                      subtitle: 'extends ScrollView',
                      color: kCoral,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _HierarchyBox(
                      title: 'GridView',
                      subtitle: 'extends ScrollView',
                      color: kCoral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: _HierarchyBox(
                      title: 'CustomScrollView',
                      subtitle: 'extends ScrollView',
                      color: kCoral,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _HierarchyBox(
                      title: 'PageView',
                      subtitle: 'extends ScrollView (via PageController)',
                      color: kCoral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kAmber.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kAmber.withValues(alpha: 0.52),
                  ),
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.bolt_rounded, color: kInk, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'ListWheelScrollView is NOT a ScrollView subclass — '
                        'it extends StatefulWidget directly. Same for any '
                        'scrollable composed from Scrollable + Viewport.',
                        style: TextStyle(color: kInk, fontSize: 12.5),
                      ),
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
}

class _HierarchyBox extends StatelessWidget {
  const _HierarchyBox({
    required this.title,
    required this.subtitle,
    required this.color,
    this.wide = false,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: kCream,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: kCream.withValues(alpha: 0.86),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  const _ArrowDown();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        Container(
          width: 2,
          height: 18,
          color: kForest.withValues(alpha: 0.6),
        ),
        Icon(
          Icons.arrow_drop_down_rounded,
          color: kForest.withValues(alpha: 0.8),
          size: 26,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — Decision table
// ---------------------------------------------------------------------------

class _DecisionTable extends StatelessWidget {
  const _DecisionTable();

  @override
  Widget build(BuildContext context) {
    const rows = <_DecisionRow>[
      _DecisionRow(
        intent: 'Fixed-extent linear list',
        pick: 'ListView',
        note: 'Use .builder for long, lazy data sets.',
        icon: Icons.view_list_rounded,
      ),
      _DecisionRow(
        intent: 'Grid of tiles',
        pick: 'GridView',
        note: 'Pick a gridDelegate that matches your layout.',
        icon: Icons.grid_view_rounded,
      ),
      _DecisionRow(
        intent: 'Mixed slivers (pinned header + list + grid)',
        pick: 'CustomScrollView',
        note: 'The Swiss-army knife for scroll composition.',
        icon: Icons.layers_rounded,
      ),
      _DecisionRow(
        intent: 'Paginated / swipeable',
        pick: 'PageView',
        note: 'Snap per-child; use PageController for jumpTo/page.',
        icon: Icons.view_carousel_rounded,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          label: 'Decision table',
          desc: 'Which subclass to reach for, row by row.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kMist),
          ),
          child: Column(
            children: <Widget>[
              // Header row.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: kForest,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 24),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Intent',
                        style: TextStyle(
                          color: kCream,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Pick',
                        style: TextStyle(
                          color: kCream,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Body rows.
              for (int i = 0; i < rows.length; i++)
                _DecisionRowTile(
                  row: rows[i],
                  striped: i.isOdd,
                  isLast: i == rows.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DecisionRow {
  const _DecisionRow({
    required this.intent,
    required this.pick,
    required this.note,
    required this.icon,
  });

  final String intent;
  final String pick;
  final String note;
  final IconData icon;
}

class _DecisionRowTile extends StatelessWidget {
  const _DecisionRowTile({
    required this.row,
    required this.striped,
    required this.isLast,
  });

  final _DecisionRow row;
  final bool striped;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: striped ? kMist.withValues(alpha: 0.34) : Colors.white,
        borderRadius: isLast
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            : null,
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : kMist,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(row.icon, size: 20, color: kForest),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row.intent,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  row.note,
                  style: TextStyle(
                    color: kInk.withValues(alpha: 0.74),
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: kCoral.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kCoral.withValues(alpha: 0.42)),
              ),
              child: Text(
                row.pick,
                style: const TextStyle(
                  color: kCoral,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 10 — Teaching tiles
// ---------------------------------------------------------------------------

class _TeachingTiles extends StatelessWidget {
  const _TeachingTiles();

  @override
  Widget build(BuildContext context) {
    const tiles = <_TeachingItem>[
      _TeachingItem(
        icon: Icons.construction_rounded,
        title: 'CustomScrollView is the Swiss-army knife',
        body:
            'Reach for it when a layout mixes slivers — pinned headers, '
            'lists, grids, adapters.',
        accent: kCoral,
      ),
      _TeachingItem(
        icon: Icons.timelapse_rounded,
        title: 'ListView.builder is lazy',
        body:
            'Use it whenever your list may grow. The default ListView() '
            'builds all children eagerly.',
        accent: kSage,
      ),
      _TeachingItem(
        icon: Icons.warning_amber_rounded,
        title: 'primary: true + controller is an error',
        body:
            'Pick one. Setting both breaks Flutter\'s ownership assumptions '
            'and produces an assertion.',
        accent: kAmber,
      ),
      _TeachingItem(
        icon: Icons.bolt_rounded,
        title: 'shrinkWrap: true is expensive',
        body:
            'It forces the scroll view to measure all children. Prefer a '
            'bounded parent when possible.',
        accent: kInk,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          label: 'Teaching notes',
          desc: 'Four rules of thumb that travel with every ScrollView.',
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < tiles.length; i++) ...<Widget>[
          _TeachingTile(item: tiles[i]),
          if (i != tiles.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TeachingItem {
  const _TeachingItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({required this.item});

  final _TeachingItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kMist),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: item.accent.withValues(alpha: 0.52)),
            ),
            alignment: Alignment.center,
            child: Icon(item.icon, color: item.accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: const TextStyle(
                    color: kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: TextStyle(
                    color: kInk.withValues(alpha: 0.78),
                    fontSize: 12.5,
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
}

// ---------------------------------------------------------------------------
// Section 11 — Footer summary
// ---------------------------------------------------------------------------

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
          colors: <Color>[kInk, kForest],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.auto_awesome_rounded, color: kAmber),
              const SizedBox(width: 10),
              const Text(
                'ScrollView — summary',
                style: TextStyle(
                  color: kCream,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kCoral.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'abstract',
                  style: TextStyle(
                    color: kCoral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'ScrollView unifies the configuration surface of Flutter\'s '
            'scrolling widgets. Its four concrete siblings — ListView, '
            'GridView, CustomScrollView, PageView — inherit the same '
            'properties for direction, physics, caching, and keyboard '
            'behaviour. Pick the subclass that matches your intent; tune the '
            'shared properties when you need to.',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              _FooterPill(label: 'ListView', color: kCoral),
              const SizedBox(width: 8),
              _FooterPill(label: 'GridView', color: kAmber),
              const SizedBox(width: 8),
              _FooterPill(label: 'CustomScrollView', color: kSage),
              const SizedBox(width: 8),
              _FooterPill(label: 'PageView', color: kCream),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Demo produced by the d4rt AST harness — Flutter 3.41.6.',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.6),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterPill extends StatelessWidget {
  const _FooterPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final fg = color == kCream ? kInk : kCream;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.desc});

  final String label;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6,
              height: 18,
              decoration: BoxDecoration(
                color: kCoral,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: kForest,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(
            color: kInk.withValues(alpha: 0.74),
            fontSize: 12.5,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
