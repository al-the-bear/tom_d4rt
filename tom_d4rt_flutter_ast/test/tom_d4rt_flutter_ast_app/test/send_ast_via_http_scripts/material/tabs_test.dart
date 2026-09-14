// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo - Material Tabs family
// ---------------------------------------------------------------------------
// This file is a hand-authored, visual deep dive into Flutter's Material
// Tabs widgets. It exercises:
//
//   * TabBar               - the strip of tab labels at the top of a Scaffold
//   * TabBarView           - the page-style swipe area below the TabBar
//   * Tab                  - the single tab cell (icon, text, both, or child)
//   * TabController        - the bridge between TabBar and TabBarView
//   * DefaultTabController - an InheritedWidget-backed controller for simple
//                            cases where you don't need a vsync
//   * TabAlignment         - how tabs align inside a scrollable TabBar
//                            (start, center, fill, startOffset)
//   * TabBarTheme(Data)    - theme-level overrides that propagate to every
//                            TabBar in the subtree
//   * TabBarIndicatorSize  - whether the indicator hugs the .label or the .tab
//
// The harness does not have a runApp() / main(). It exposes a single
// build(BuildContext) function that returns a MaterialApp; the test runner
// hosts it. Because a TabBarView needs bounded vertical space (it is itself
// a PageView), every example sits in a SizedBox or in a Card with a fixed
// height, and each is wrapped in a DefaultTabController unless the section
// specifically demonstrates programmatic TabController control - in that
// case a small private StatefulWidget at file scope owns the controller via
// SingleTickerProviderStateMixin.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Material Tabs Deep Demo ===');
  print('  TabAlignment values:');
  for (final v in TabAlignment.values) {
    print('    - ${v.name} (index ${v.index})');
  }
  print('  TabBarIndicatorSize values:');
  for (final v in TabBarIndicatorSize.values) {
    print('    - ${v.name} (index ${v.index})');
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material Tabs Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: Scaffold(
      backgroundColor: const Color(0xFFEEF2F7),
      appBar: AppBar(
        title: const Text('Material Tabs - Deep Demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              // ===============================================================
              // SECTION 1 - HERO CARD
              // ---------------------------------------------------------------
              // High-level intro. Lists the seven knobs the demo will probe
              // and gives a rule-of-thumb summary so the rest of the page is
              // self-contained even if the reader scrolls casually.
              // ===============================================================
              _HeroCard(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF1565C0),
                title: '2. Basic 3-tab TabBar + TabBarView',
                subtitle:
                    'The minimum viable tabbed surface. DefaultTabController '
                    'wires the bar and the view together with no controller '
                    'plumbing at all.',
              ),
              SizedBox(height: 12),
              _BasicThreeTabSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF6A1B9A),
                title: '3. Scrollable TabBar with TabAlignment variants',
                subtitle:
                    'Eight tabs, four alignment values rendered side by side. '
                    'TabAlignment only matters when isScrollable is true.',
              ),
              SizedBox(height: 12),
              _ScrollableAlignmentSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF00695C),
                title: '4. Indicator variants',
                subtitle:
                    'Underline, BoxDecoration pill, RoundedRectangleBorder '
                    'card-style, and the tab vs label sizing toggle.',
              ),
              SizedBox(height: 12),
              _IndicatorVariantsSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFFAD1457),
                title: '5. TabBarTheme overrides',
                subtitle:
                    'The same TabBar widget rendered under three different '
                    'TabBarTheme settings. Theme always loses to explicit '
                    'TabBar parameters - that is the inversion most folks '
                    'forget.',
              ),
              SizedBox(height: 12),
              _TabBarThemeSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFFE65100),
                title: '6. Tab content kinds: icon, text, both, child',
                subtitle:
                    'Each Tab cell can carry an icon, a text label, both, or '
                    'an arbitrary child widget. Mixing is allowed.',
              ),
              SizedBox(height: 12),
              _TabContentKindsSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF2E7D32),
                title: '7. Programmatic TabController + listeners',
                subtitle:
                    'Manually owned TabController demonstrates animateTo, the '
                    'index/animation listener split, and external Next / '
                    'Previous buttons.',
              ),
              SizedBox(height: 12),
              _ProgrammaticTabSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF455A64),
                title: '8. Disabled swipe (NeverScrollableScrollPhysics)',
                subtitle:
                    'Sometimes the content owns horizontal gestures (charts, '
                    'maps, code editors). Disabling swipe on TabBarView lets '
                    'the inner widget keep them.',
              ),
              SizedBox(height: 12),
              _NoSwipeSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF4527A0),
                title: '9. Vertical-feeling tabs via RotatedBox',
                subtitle:
                    'TabBar is intrinsically horizontal. RotatedBox is a '
                    'cheap trick to fake a side rail; it has accessibility '
                    'tradeoffs noted in the caption.',
              ),
              SizedBox(height: 12),
              _VerticalRotatedSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF263238),
                title: '10. Material 2 vs Material 3 side by side',
                subtitle:
                    'Same widget tree, two different Theme widgets, very '
                    'different visuals. Useful when migrating an app.',
              ),
              SizedBox(height: 12),
              _MaterialVersionsSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF1B5E20),
                title: '11. TabBar vs PageView vs NavigationBar',
                subtitle:
                    'A decision matrix to pick the right horizontal-page '
                    'navigation widget. Tabs are not always the answer.',
              ),
              SizedBox(height: 12),
              _DecisionMatrixSection(),
              SizedBox(height: 28),

              _SectionHeader(
                accent: Color(0xFF37474F),
                title: '12. Reference tables',
                subtitle:
                    'Quick look-up for the enums used above and a reminder '
                    'of the TabBar properties most relevant to this demo.',
              ),
              SizedBox(height: 12),
              _ReferenceSection(),
              SizedBox(height: 24),
              _Footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO CARD
// ============================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A237E),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.tab,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Material Tabs family',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Tabs give a horizontal navigation surface inside a single '
              'screen. They are appropriate when the items being navigated '
              'are peers (sibling categories of the same kind), the count '
              'is small to medium (~ 2 to 12), and the user is expected to '
              'switch between them often.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 18),
            _heroBullet(
              icon: Icons.view_carousel,
              title: 'TabBar + TabBarView',
              body: 'A TabBar drives a TabBarView via a shared TabController. '
                  'They listen to each other so swiping the view scrolls the '
                  'bar and tapping the bar animates the view.',
            ),
            _heroBullet(
              icon: Icons.swipe,
              title: 'DefaultTabController',
              body: 'Most cases do not need a custom controller. Wrap the '
                  'subtree in DefaultTabController(length: N) and both '
                  'TabBar and TabBarView will pick it up.',
            ),
            _heroBullet(
              icon: Icons.settings_suggest,
              title: 'TabAlignment',
              body: 'Only meaningful for isScrollable: true. Picks one of '
                  'start, center, fill, startOffset. Material 3 default is '
                  'startOffset for scrollable bars.',
            ),
            _heroBullet(
              icon: Icons.line_weight,
              title: 'Indicator and TabBarIndicatorSize',
              body: 'The selected-tab marker can be an underline, a filled '
                  'pill, a card, or a custom Decoration. Its width can hug '
                  'the label (.label) or the whole cell (.tab).',
            ),
            _heroBullet(
              icon: Icons.palette,
              title: 'TabBarTheme(Data)',
              body: 'Theme-level defaults: label color, unselected label '
                  'color, indicator color, divider color, overlay color, '
                  'tab alignment. Explicit TabBar args win every time.',
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.18)),
              ),
              child: const Text(
                'Rule of thumb: reach for tabs only when items are siblings. '
                'If items are different kinds (Profile vs Inbox vs Settings) '
                'use NavigationBar. If items are an ordered sequence with no '
                'header (a wizard) use PageView with a PageIndicator.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _heroBullet({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
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

// ============================================================================
// SECTION 2 - BASIC THREE TABS
// ----------------------------------------------------------------------------
// The skeleton every tabbed screen starts from. DefaultTabController owns the
// length and the initial index; the TabBar at the top and the TabBarView
// below both subscribe to it via the inherited widget. No setState, no
// controller fields, no vsync.
// ============================================================================

class _BasicThreeTabSection extends StatelessWidget {
  const _BasicThreeTabSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Three peer categories of news content. Tap a tab or swipe '
              'horizontally inside the page area to navigate.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TabBar(
                      labelColor: Color(0xFF0D47A1),
                      unselectedLabelColor: Color(0xFF607D8B),
                      indicatorColor: Color(0xFF1565C0),
                      tabs: [
                        Tab(text: 'World'),
                        Tab(text: 'Sports'),
                        Tab(text: 'Tech'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 220,
                    child: TabBarView(
                      children: [
                        _NewsPage(
                          accent: Color(0xFF0D47A1),
                          headline: 'Diplomatic summit concludes',
                          body:
                              'Three world leaders met to discuss border '
                              'agreements and trade flows. The communique '
                              'is expected later this week.',
                        ),
                        _NewsPage(
                          accent: Color(0xFFAD1457),
                          headline: 'Cup final goes to penalties',
                          body:
                              'Both sides finished extra time at 2-2. The '
                              'shootout was decided on the seventh kick '
                              'after a tense save by the home keeper.',
                        ),
                        _NewsPage(
                          accent: Color(0xFF00695C),
                          headline: 'Open-source release shakes up tooling',
                          body:
                              'A new compiler front-end published this '
                              'morning lands type-narrowing improvements '
                              'and faster incremental builds out of the '
                              'box.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _Caption(
              text:
                  'Caption: DefaultTabController(length: 3) is enough. The '
                  'page widgets are built lazily - the second and third tabs '
                  'are not constructed until the user swipes near them.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 3 - SCROLLABLE + TabAlignment GRID
// ----------------------------------------------------------------------------
// One scrollable bar per TabAlignment value. Each bar has the same eight
// tabs and the same fixed width (the parent Card) so the only changing
// variable is the alignment. The TabBarView is omitted here on purpose -
// this section is about the bar's layout policy, not about page content.
// ============================================================================

class _ScrollableAlignmentSection extends StatelessWidget {
  const _ScrollableAlignmentSection();

  static const _categories = <String>[
    'Top stories',
    'Local',
    'World',
    'Politics',
    'Business',
    'Tech',
    'Sports',
    'Entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'TabAlignment policies for a scrollable bar with 8 tabs.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            SizedBox(height: 14),
            _AlignmentBar(
              alignment: TabAlignment.start,
              accent: Color(0xFF6A1B9A),
              caption:
                  'start - tabs hug the leading edge. Use when the first tab '
                  'should always be visible without scrolling.',
            ),
            SizedBox(height: 12),
            _AlignmentBar(
              alignment: TabAlignment.startOffset,
              accent: Color(0xFF8E24AA),
              caption:
                  'startOffset - like start, but with a leading 52dp gutter. '
                  'This is the Material 3 default for scrollable bars.',
            ),
            SizedBox(height: 12),
            _AlignmentBar(
              alignment: TabAlignment.center,
              accent: Color(0xFFAB47BC),
              caption:
                  'center - tabs are centered as a group. Reads nicely when '
                  'tab count is small or content is symmetric.',
            ),
            SizedBox(height: 12),
            _AlignmentBar(
              alignment: TabAlignment.fill,
              accent: Color(0xFFCE93D8),
              caption:
                  'fill - tabs share the available width evenly. Note: only '
                  'valid when isScrollable is false. Shown here in a '
                  'non-scrollable bar for completeness.',
            ),
            SizedBox(height: 12),
            _Caption(
              text:
                  'Caption: TabAlignment.fill REQUIRES isScrollable: false; '
                  'the others REQUIRE isScrollable: true. The widget asserts '
                  'this in debug mode, so passing the wrong combination '
                  'crashes early with a clear message.',
            ),
          ],
        ),
      ),
    );
  }
}

class _AlignmentBar extends StatelessWidget {
  const _AlignmentBar({
    required this.alignment,
    required this.accent,
    required this.caption,
  });

  final TabAlignment alignment;
  final Color accent;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final isFill = alignment == TabAlignment.fill;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'TabAlignment.${alignment.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isFill ? '(non-scrollable)' : '(scrollable)',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF607D8B),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        DefaultTabController(
          length: _ScrollableAlignmentSection._categories.length,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withOpacity(0.3)),
            ),
            child: TabBar(
              isScrollable: !isFill,
              tabAlignment: alignment,
              labelColor: accent,
              unselectedLabelColor: const Color(0xFF6D6875),
              indicatorColor: accent,
              tabs: [
                for (final c in _ScrollableAlignmentSection._categories)
                  Tab(text: c),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caption,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF455A64),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 4 - INDICATOR VARIANTS
// ----------------------------------------------------------------------------
// Underline (default), filled BoxDecoration "pill", a card-shaped indicator
// using RoundedRectangleBorder, and the .tab vs .label width comparison.
// Each variant gets its own DefaultTabController so the demo bars don't
// fight over a shared index.
// ============================================================================

class _IndicatorVariantsSection extends StatelessWidget {
  const _IndicatorVariantsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Four indicator variants. Each demo strip is independent.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            const _IndicatorVariantRow(
              title: 'UnderlineTabIndicator (default-shaped, custom width)',
              accent: Color(0xFF00695C),
              child: _UnderlineIndicatorBar(),
            ),
            const SizedBox(height: 14),
            const _IndicatorVariantRow(
              title: 'BoxDecoration "pill" indicator',
              accent: Color(0xFFEF6C00),
              child: _PillIndicatorBar(),
            ),
            const SizedBox(height: 14),
            const _IndicatorVariantRow(
              title: 'RoundedRectangleBorder card indicator',
              accent: Color(0xFF1565C0),
              child: _CardIndicatorBar(),
            ),
            const SizedBox(height: 14),
            const _IndicatorVariantRow(
              title: 'TabBarIndicatorSize.tab vs .label',
              accent: Color(0xFF6A1B9A),
              child: _SizeComparisonBar(),
            ),
            const SizedBox(height: 12),
            const _Caption(
              text:
                  'Caption: indicator + indicatorSize is one of the most '
                  'common visual customisations. In Material 3 the underline '
                  'with .label is the recommended default; .tab is more '
                  'common in Material 2 / pre-2022 codebases.',
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorVariantRow extends StatelessWidget {
  const _IndicatorVariantRow({
    required this.title,
    required this.accent,
    required this.child,
  });

  final String title;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accent.withOpacity(0.4)),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _UnderlineIndicatorBar extends StatelessWidget {
  const _UnderlineIndicatorBar();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TabBar(
          labelColor: Color(0xFF004D40),
          unselectedLabelColor: Color(0xFF607D8B),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4, color: Color(0xFF00897B)),
            insets: EdgeInsets.symmetric(horizontal: 24),
          ),
          tabs: [
            Tab(text: 'Inbox'),
            Tab(text: 'Outbox'),
            Tab(text: 'Drafts'),
            Tab(text: 'Trash'),
          ],
        ),
      ),
    );
  }
}

class _PillIndicatorBar extends StatelessWidget {
  const _PillIndicatorBar();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(40),
        ),
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFEF6C00),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            color: const Color(0xFFEF6C00),
          ),
          tabs: const [
            Tab(text: 'Day'),
            Tab(text: 'Week'),
            Tab(text: 'Month'),
            Tab(text: 'Year'),
          ],
        ),
      ),
    );
  }
}

class _CardIndicatorBar extends StatelessWidget {
  const _CardIndicatorBar();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          labelColor: const Color(0xFF0D47A1),
          unselectedLabelColor: const Color(0xFF607D8B),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFF1565C0), width: 1.2),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x331565C0),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Logs'),
            Tab(text: 'Metrics'),
            Tab(text: 'Alerts'),
          ],
        ),
      ),
    );
  }
}

class _SizeComparisonBar extends StatelessWidget {
  const _SizeComparisonBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 3,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TabBar(
              labelColor: Color(0xFF4A148C),
              unselectedLabelColor: Color(0xFF6D6875),
              indicatorColor: Color(0xFF6A1B9A),
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: 'Sm'),
                Tab(text: 'Medium'),
                Tab(text: 'Looooong label'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '^ TabBarIndicatorSize.label - underline matches the text width.',
          style: TextStyle(fontSize: 11, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 10),
        DefaultTabController(
          length: 3,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TabBar(
              labelColor: Color(0xFF4A148C),
              unselectedLabelColor: Color(0xFF6D6875),
              indicatorColor: Color(0xFF6A1B9A),
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: 'Sm'),
                Tab(text: 'Medium'),
                Tab(text: 'Looooong label'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '^ TabBarIndicatorSize.tab - underline matches the cell width.',
          style: TextStyle(fontSize: 11, color: Color(0xFF455A64)),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 5 - TabBarTheme overrides
// ----------------------------------------------------------------------------
// Three identical TabBar widgets, three different TabBarTheme settings.
// Theme attributes propagate via Theme inheritance, but explicit TabBar
// arguments always override them - the third example proves that.
// ============================================================================

class _TabBarThemeSection extends StatelessWidget {
  const _TabBarThemeSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ThemedBar(
              title: 'A) Pink theme - takes effect',
              caption:
                  'TabBarTheme provides labelColor, indicatorColor, divider '
                  'color. The TabBar declares no overrides so theme wins.',
              theme: TabBarThemeData(
                labelColor: Color(0xFFC2185B),
                unselectedLabelColor: Color(0xFFAD8190),
                indicatorColor: Color(0xFFE91E63),
                dividerColor: Color(0xFFFCE4EC),
              ),
              respectsTheme: true,
            ),
            SizedBox(height: 14),
            _ThemedBar(
              title: 'B) Teal theme - takes effect',
              caption:
                  'Same TabBar widget, but the surrounding Theme overrides '
                  'TabBarTheme to teal. The bar follows.',
              theme: TabBarThemeData(
                labelColor: Color(0xFF00695C),
                unselectedLabelColor: Color(0xFF80CBC4),
                indicatorColor: Color(0xFF00897B),
                dividerColor: Color(0xFFE0F2F1),
              ),
              respectsTheme: true,
            ),
            SizedBox(height: 14),
            _ThemedBar(
              title: 'C) Teal theme + explicit overrides - explicit wins',
              caption:
                  'Same teal theme, but the TabBar passes explicit '
                  'labelColor and indicatorColor. Those win regardless of '
                  'theme - that is the inversion most folks forget.',
              theme: TabBarThemeData(
                labelColor: Color(0xFF00695C),
                unselectedLabelColor: Color(0xFF80CBC4),
                indicatorColor: Color(0xFF00897B),
                dividerColor: Color(0xFFE0F2F1),
              ),
              respectsTheme: false,
            ),
            SizedBox(height: 12),
            _Caption(
              text:
                  'Caption: TabBarTheme is the right place to encode brand '
                  'colors once. Explicit TabBar parameters should be reserved '
                  'for one-off exceptions.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemedBar extends StatelessWidget {
  const _ThemedBar({
    required this.title,
    required this.caption,
    required this.theme,
    required this.respectsTheme,
  });

  final String title;
  final String caption;
  final TabBarThemeData theme;
  final bool respectsTheme;

  @override
  Widget build(BuildContext context) {
    final outer = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Theme(
          data: outer.copyWith(tabBarTheme: theme),
          child: DefaultTabController(
            length: 4,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                labelColor: respectsTheme ? null : const Color(0xFF263238),
                unselectedLabelColor:
                    respectsTheme ? null : const Color(0xFF90A4AE),
                indicatorColor:
                    respectsTheme ? null : const Color(0xFFFF6F00),
                tabs: const [
                  Tab(text: 'Home'),
                  Tab(text: 'Search'),
                  Tab(text: 'Library'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          caption,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF455A64),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 6 - TAB CONTENT KINDS
// ----------------------------------------------------------------------------
// A single TabBar with five tabs that each demonstrate one of the supported
// tab content kinds: icon-only, text-only, icon+text, custom child, and a
// child that hosts a Badge so the demo shows that arbitrary widgets work.
// ============================================================================

class _TabContentKindsSection extends StatelessWidget {
  const _TabContentKindsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Each tab uses a different Tab content style.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TabBar(
                      labelColor: Color(0xFFE65100),
                      unselectedLabelColor: Color(0xFF8D6E63),
                      indicatorColor: Color(0xFFE65100),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(text: 'Text only'),
                        Tab(icon: Icon(Icons.search), text: 'Search'),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.notifications),
                              SizedBox(width: 6),
                              Text('Custom'),
                              SizedBox(width: 6),
                              Icon(Icons.bolt, size: 14),
                            ],
                          ),
                        ),
                        Tab(
                          child: Badge(
                            label: Text('9+'),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Text('Inbox'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                    child: TabBarView(
                      children: [
                        _Pad(text: 'Tab(icon: Icon(...))'),
                        _Pad(text: "Tab(text: 'Text only')"),
                        _Pad(text: 'Tab(icon: ..., text: ...)'),
                        _Pad(text: 'Tab(child: Row(...))'),
                        _Pad(text: 'Tab(child: Badge(...))'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const _Caption(
              text:
                  'Caption: Tab.height is computed from whichever of icon, '
                  'text, or child is tallest. Mixing kinds is allowed but '
                  'looks off without consistent vertical sizing - use the '
                  'child slot if you need pixel control.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 7 - PROGRAMMATIC TabController
// ----------------------------------------------------------------------------
// A real, ticker-bound TabController. We listen to it twice - once for the
// integer index (only changes when a tab is committed) and once for the
// continuous animation value (changes during swipe / animateTo). External
// Next / Previous buttons drive the controller imperatively.
// ============================================================================

class _ProgrammaticTabSection extends StatefulWidget {
  const _ProgrammaticTabSection();

  @override
  State<_ProgrammaticTabSection> createState() =>
      _ProgrammaticTabSectionState();
}

class _ProgrammaticTabSectionState extends State<_ProgrammaticTabSection>
    with SingleTickerProviderStateMixin {
  static const _labels = <String>['Compose', 'Inbox', 'Sent', 'Archive'];
  late final TabController _controller;
  int _committedIndex = 0;
  double _animationValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _labels.length, vsync: this);
    _controller.addListener(_onIndexChanged);
    _controller.animation?.addListener(_onAnimation);
  }

  void _onIndexChanged() {
    if (_committedIndex != _controller.index) {
      setState(() => _committedIndex = _controller.index);
    }
  }

  void _onAnimation() {
    final next = _controller.animation?.value ?? 0;
    if ((_animationValue - next).abs() > 0.005) {
      setState(() => _animationValue = next);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onIndexChanged);
    _controller.animation?.removeListener(_onAnimation);
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (_controller.index > 0) {
      _controller.animateTo(_controller.index - 1);
    }
  }

  void _next() {
    if (_controller.index < _labels.length - 1) {
      _controller.animateTo(_controller.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Owning the TabController gives access to animateTo() and to '
              'two distinct streams of state - the committed integer index '
              'and the continuous animation value used to draw the marker.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _controller,
                labelColor: const Color(0xFF1B5E20),
                unselectedLabelColor: const Color(0xFF558B6E),
                indicatorColor: const Color(0xFF2E7D32),
                tabs: [for (final l in _labels) Tab(text: l)],
              ),
            ),
            SizedBox(
              height: 160,
              child: TabBarView(
                controller: _controller,
                children: [
                  for (var i = 0; i < _labels.length; i++)
                    _Pad(text: 'Page for "${_labels[i]}" (index $i)'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: _prev,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Previous'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _next,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Next'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8E6C9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'index: $_committedIndex   '
                      'anim: ${_animationValue.toStringAsFixed(3)}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const _Caption(
              text:
                  'Caption: controller.index changes once when a tab is '
                  'COMMITTED. controller.animation.value changes constantly '
                  'during the transition. Listen to whichever matches what '
                  'you are doing - drawing per-frame paint vs reacting to a '
                  'logical page change.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 8 - DISABLED SWIPE
// ----------------------------------------------------------------------------
// Some pages need horizontal gestures of their own (a chart with pan, a
// horizontal list, a code editor). NeverScrollableScrollPhysics on the
// TabBarView lets the inner widgets keep their gestures. The TabBar still
// works as the only navigation method.
// ============================================================================

class _NoSwipeSection extends StatelessWidget {
  const _NoSwipeSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Below, the inner pages contain a horizontal ListView. With '
              'TabBarView swipe disabled, dragging the list scrolls the '
              'list, not the tabs.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEFF1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TabBar(
                      labelColor: Color(0xFF263238),
                      unselectedLabelColor: Color(0xFF607D8B),
                      indicatorColor: Color(0xFF455A64),
                      tabs: [
                        Tab(text: 'CPU'),
                        Tab(text: 'Memory'),
                        Tab(text: 'Disk'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _HorizontalStrip(seed: 0xFF1565C0, label: 'CPU'),
                        _HorizontalStrip(seed: 0xFFAD1457, label: 'Memory'),
                        _HorizontalStrip(seed: 0xFF00897B, label: 'Disk'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const _Caption(
              text:
                  'Caption: physics: NeverScrollableScrollPhysics() is the '
                  'cleanest opt-out. You can also use ClampingScrollPhysics '
                  'or a custom NotificationListener if you want a partial '
                  'opt-out (e.g. allow swipe only at the edges).',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 9 - VERTICAL ROTATED
// ----------------------------------------------------------------------------
// TabBar is intrinsically horizontal. Wrapping it in a RotatedBox can fake
// a side rail; this is sometimes useful for narrow phones in landscape or
// for desktop "tool palettes". The rotation does NOT rotate gesture
// directions for the underlying TabBarView - so this trick is best used
// without a TabBarView, or with a regular non-rotated body.
// ============================================================================

class _VerticalRotatedSection extends StatelessWidget {
  const _VerticalRotatedSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A side-rail look-alike. The bar is rotated; the body is a '
              'regular Stack that swaps content based on the controller.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            DefaultTabController(
              length: 4,
              child: SizedBox(
                height: 220,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelColor: const Color(0xFF311B92),
                          unselectedLabelColor: const Color(0xFF7E57C2),
                          indicatorColor: const Color(0xFF4527A0),
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFF4527A0),
                            ),
                          ),
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.dashboard),
                              text: 'Overview',
                            ),
                            Tab(
                              icon: Icon(Icons.layers),
                              text: 'Layers',
                            ),
                            Tab(
                              icon: Icon(Icons.code),
                              text: 'Code',
                            ),
                            Tab(
                              icon: Icon(Icons.terminal),
                              text: 'Console',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _Pad(text: 'Overview pane'),
                          _Pad(text: 'Layers pane'),
                          _Pad(text: 'Code pane'),
                          _Pad(text: 'Console pane'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const _Caption(
              text:
                  'Caption: accessibility caveat - screen readers still read '
                  'the rotated TabBar as a horizontal element. For a true '
                  'side rail, prefer NavigationRail (Material) which is a '
                  'first-class widget designed for this.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 10 - MATERIAL 2 vs MATERIAL 3
// ----------------------------------------------------------------------------
// Same widget, two themes. Material 3 indicators are more rounded and the
// label spacing is denser. Useful sanity check during a M2 -> M3 migration.
// ============================================================================

class _MaterialVersionsSection extends StatelessWidget {
  const _MaterialVersionsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Identical TabBar in two Theme widgets that differ only in '
              'useMaterial3.',
              style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
            ),
            const SizedBox(height: 14),
            Row(
              children: const [
                Expanded(
                  child: _VersionedBar(
                    label: 'Material 2',
                    accent: Color(0xFF263238),
                    useMaterial3: false,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _VersionedBar(
                    label: 'Material 3',
                    accent: Color(0xFF1565C0),
                    useMaterial3: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const _Caption(
              text:
                  'Caption: notable M3 changes - default tab alignment is '
                  'startOffset for scrollable bars, default indicator is a '
                  'rounded underline that hugs the label, default divider '
                  'color is outlineVariant. Most differences are visible '
                  'only on real device pixels at typical sizes.',
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionedBar extends StatelessWidget {
  const _VersionedBar({
    required this.label,
    required this.accent,
    required this.useMaterial3,
  });

  final String label;
  final Color accent;
  final bool useMaterial3;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: useMaterial3, colorSchemeSeed: accent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          DefaultTabController(
            length: 3,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: const TabBar(
                tabs: [
                  Tab(text: 'One'),
                  Tab(text: 'Two'),
                  Tab(text: 'Three'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 11 - DECISION MATRIX
// ----------------------------------------------------------------------------
// When to use TabBar vs PageView vs NavigationBar. Pure markup, no live
// widgets - the goal is comparison.
// ============================================================================

class _DecisionMatrixSection extends StatelessWidget {
  const _DecisionMatrixSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _MatrixRow(
              accent: Color(0xFF1565C0),
              widget: 'TabBar + TabBarView',
              when: 'Sibling categories of the SAME kind, presented inside '
                  'a single screen, with a visible header row.',
              avoid: 'When categories are different KINDS (Profile vs Inbox '
                  'vs Settings) or when you need the user to perceive each '
                  'as a separate destination - use NavigationBar instead.',
            ),
            SizedBox(height: 12),
            _MatrixRow(
              accent: Color(0xFF6A1B9A),
              widget: 'PageView',
              when: 'Ordered sequences with no header (onboarding, image '
                  'carousels, wizards). Works well with PageIndicator.',
              avoid: 'When the user must be able to jump non-linearly. Tabs '
                  'show all destinations at once; PageView hides them.',
            ),
            SizedBox(height: 12),
            _MatrixRow(
              accent: Color(0xFF00695C),
              widget: 'NavigationBar / NavigationRail',
              when: 'Top-level destinations of an app (3 to 5 of them). '
                  'Persists across the app, not inside a single screen.',
              avoid: 'For sub-categories within a screen - that is too much '
                  'navigational chrome and loses the bar`s "you are here" '
                  'role.',
            ),
            SizedBox(height: 10),
            _Caption(
              text:
                  'Caption: a useful test - if the "back" button should '
                  'leave the screen, you probably want NavigationBar. If it '
                  'should switch sub-section, you probably want TabBar. If '
                  'there is no back button at all, you probably want '
                  'PageView.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.accent,
    required this.widget,
    required this.when,
    required this.avoid,
  });

  final Color accent;
  final String widget;
  final String when;
  final String avoid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: accent,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _MatrixLabel(text: 'USE'),
              Expanded(
                child: Text(
                  when,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _MatrixLabel(text: 'AVOID'),
              Expanded(
                child: Text(
                  avoid,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF455A64),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatrixLabel extends StatelessWidget {
  const _MatrixLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: const EdgeInsets.only(right: 8, top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFB0BEC5)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Color(0xFF37474F),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 12 - REFERENCE TABLES
// ----------------------------------------------------------------------------
// Quick-look tables for the enums and the most-used TabBar parameters.
// ============================================================================

class _ReferenceSection extends StatelessWidget {
  const _ReferenceSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'TabAlignment values',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            SizedBox(height: 8),
            _RefHeader(
              left: 'value',
              middle: 'requires',
              right: 'visual effect',
            ),
            _RefRow(
              left: '.start',
              middle: 'isScrollable: true',
              right: 'first tab pinned to leading edge',
            ),
            _RefRow(
              left: '.startOffset',
              middle: 'isScrollable: true',
              right: '52dp leading gutter (M3 default)',
            ),
            _RefRow(
              left: '.center',
              middle: 'isScrollable: true',
              right: 'centered group',
            ),
            _RefRow(
              left: '.fill',
              middle: 'isScrollable: false',
              right: 'tabs share width evenly',
            ),
            SizedBox(height: 18),
            Text(
              'TabBarIndicatorSize values',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            SizedBox(height: 8),
            _RefHeader(
              left: 'value',
              middle: 'best for',
              right: 'looks like',
            ),
            _RefRow(
              left: '.label',
              middle: 'underline indicators (M3 default)',
              right: 'marker hugs the text',
            ),
            _RefRow(
              left: '.tab',
              middle: 'pill / card indicators',
              right: 'marker fills the entire cell',
            ),
            SizedBox(height: 18),
            Text(
              'Most-used TabBar properties',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            SizedBox(height: 8),
            _RefHeader(
              left: 'property',
              middle: 'type',
              right: 'note',
            ),
            _RefRow(
              left: 'isScrollable',
              middle: 'bool',
              right: 'gates fill / start / startOffset alignment',
            ),
            _RefRow(
              left: 'tabAlignment',
              middle: 'TabAlignment?',
              right: 'see table above',
            ),
            _RefRow(
              left: 'indicator',
              middle: 'Decoration?',
              right: 'beats indicatorColor / indicatorWeight if non-null',
            ),
            _RefRow(
              left: 'indicatorSize',
              middle: 'TabBarIndicatorSize?',
              right: 'label vs tab; defaults to label in M3',
            ),
            _RefRow(
              left: 'labelColor',
              middle: 'Color?',
              right: 'selected tab text color',
            ),
            _RefRow(
              left: 'unselectedLabelColor',
              middle: 'Color?',
              right: 'idle tab text color',
            ),
            _RefRow(
              left: 'overlayColor',
              middle: 'WidgetStateProperty<Color?>?',
              right: 'hover/focus/pressed ink color',
            ),
            _RefRow(
              left: 'dividerColor',
              middle: 'Color?',
              right: 'thin line under the bar; M3 only',
            ),
            _RefRow(
              left: 'physics',
              middle: 'ScrollPhysics?',
              right: 'scrolling physics for the bar (when scrollable)',
            ),
            _RefRow(
              left: 'splashFactory',
              middle: 'InteractiveInkFeatureFactory?',
              right: 'override the ripple style',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// COMMON HELPERS
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  final Color accent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF455A64),
            ),
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          height: 1.4,
          color: Color(0xFF455A64),
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class _NewsPage extends StatelessWidget {
  const _NewsPage({
    required this.accent,
    required this.headline,
    required this.body,
  });

  final Color accent;
  final String headline;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'BREAKING',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            headline,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF263238),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pad extends StatelessWidget {
  const _Pad({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF455A64),
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class _HorizontalStrip extends StatelessWidget {
  const _HorizontalStrip({required this.seed, required this.label});

  final int seed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final base = Color(seed);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final shade = base.withOpacity(0.3 + (i % 6) * 0.1);
          return Container(
            width: 60,
            decoration: BoxDecoration(
              color: shade,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$label\n#$i',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RefHeader extends StatelessWidget {
  const _RefHeader({
    required this.left,
    required this.middle,
    required this.right,
  });

  final String left;
  final String middle;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF37474F),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              left,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              middle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              right,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.left,
    required this.middle,
    required this.right,
  });

  final String left;
  final String middle;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              left,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              middle,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              right,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.menu_book_outlined, color: Color(0xFF1A237E)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'End of demo. Twelve sections covered TabBar, TabBarView, Tab, '
              'TabController, DefaultTabController, TabAlignment, '
              'TabBarTheme(Data) and TabBarIndicatorSize. Each section is '
              'self-contained so individual snippets can be lifted into a '
              'real screen with minimal editing.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF1A237E),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
