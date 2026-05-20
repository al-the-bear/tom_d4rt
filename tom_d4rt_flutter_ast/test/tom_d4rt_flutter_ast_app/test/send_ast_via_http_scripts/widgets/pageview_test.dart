// D4rt test script: Tests PageView widget from widgets
// Deep Demo: "PageView: every way to browse pages"
//
// This file is intentionally large — it walks through every commonly used
// facet of [PageView]: the three constructors (default, builder, custom),
// scroll axes, viewport fractions, the [PageController] API (jumpToPage,
// animateToPage, nextPage, previousPage), the various [ScrollPhysics]
// flavours that compose well with paged scrollables, page snapping,
// padEnds, allowImplicitScrolling and clipBehavior.
//
// Each visual section is implemented as its own private stateful widget so
// that controllers can be owned and disposed properly. The top-level
// [build] function returns a [Scaffold] containing a vertically scrollable
// column of those sections.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('PageView Deep Demo executing');

  return Scaffold(
    backgroundColor: const Color(0xFFF7F8FC),
    appBar: AppBar(
      title: const Text('PageView Deep Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _HeroHeader(),
          _SectionDivider(label: 'SECTION 1 — Onboarding'),
          _OnboardingSection(),
          _SectionDivider(label: 'SECTION 2 — PageView.builder'),
          _BuilderSection(),
          _SectionDivider(label: 'SECTION 3 — Horizontal vs Vertical'),
          _AxisSection(),
          _SectionDivider(label: 'SECTION 4 — viewportFraction carousel'),
          _CarouselSection(),
          _SectionDivider(label: 'SECTION 5 — Programmatic control'),
          _ProgrammaticSection(),
          _SectionDivider(label: 'SECTION 6 — onPageChanged + indicator'),
          _IndicatorSection(),
          _SectionDivider(label: 'SECTION 7 — Physics variants'),
          _PhysicsSection(),
          _SectionDivider(label: 'SECTION 8 — PageView.custom'),
          _CustomSection(),
          _SectionDivider(label: 'SECTION 9 — viewportFraction × padEnds'),
          _PadEndsGridSection(),
          _SectionDivider(label: 'SECTION 10 — Cheat-sheet'),
          _CheatSheetSection(),
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 0: Hero header — what a PageView is and when to reach for it.
// ============================================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.indigo.shade700,
            Colors.deepPurple.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.view_carousel, color: Colors.white, size: 40.0),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'PageView',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'A scrollable list that works page by page. Each child takes a '
            'full viewport (or a fraction of it), and the scroll snaps to '
            'page boundaries.',
            style: TextStyle(color: Colors.white, fontSize: 14.0, height: 1.4),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _HeroChip(label: 'Onboarding'),
              _HeroChip(label: 'Carousels'),
              _HeroChip(label: 'Image galleries'),
              _HeroChip(label: 'Wizards'),
              _HeroChip(label: 'Tab-like swipers'),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Prefer PageView over TabBarView when you do not need the tab '
              'chrome, and over ListView when items must lock into discrete '
              'positions.',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1.0,
              color: Colors.indigo.shade100,
            ),
          ),
        ],
      ),
    );
  }
}

class _Narrative extends StatelessWidget {
  const _Narrative(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.0,
          height: 1.45,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          child,
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 1: Three-page onboarding using the default PageView constructor.
// ============================================================================

class _OnboardingSection extends StatefulWidget {
  const _OnboardingSection();

  @override
  State<_OnboardingSection> createState() => _OnboardingSectionState();
}

class _OnboardingSectionState extends State<_OnboardingSection> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_OnboardingPageData> pages = const <_OnboardingPageData>[
      _OnboardingPageData(
        title: 'Pack your bag',
        body: 'Plan trips you will actually take — drag, drop, done.',
        icon: Icons.luggage,
        gradient: <Color>[Color(0xFF7F7FD5), Color(0xFF86A8E7)],
      ),
      _OnboardingPageData(
        title: 'Fly anywhere',
        body: 'Cheap fares, near-by airports, and price alerts in one place.',
        icon: Icons.flight_takeoff,
        gradient: <Color>[Color(0xFFFD746C), Color(0xFFFF9068)],
      ),
      _OnboardingPageData(
        title: 'Make memories',
        body: 'A travel journal that writes the boring parts for you.',
        icon: Icons.camera_alt,
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
      ),
    ];

    return Column(
      children: <Widget>[
        const _Narrative(
          'A classic three-page intro flow. Plain PageView with a fixed list '
          'of children is the simplest and most common form — perfect for '
          'onboarding because the page count is known up front.',
        ),
        _DemoCard(
          title: 'PageView(children: ...)',
          subtitle: 'Default constructor, 3 colored pages, page-indicator dots.',
          child: SizedBox(
            height: 280.0,
            child: Stack(
              children: <Widget>[
                PageView(
                  controller: _controller,
                  onPageChanged: (int index) {
                    setState(() => _page = index);
                  },
                  children: <Widget>[
                    for (final _OnboardingPageData data in pages)
                      _OnboardingPage(data: data),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < pages.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: i == _page ? 22.0 : 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: i == _page
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
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

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.body,
    required this.icon,
    required this.gradient,
  });

  final String title;
  final String body;
  final IconData icon;
  final List<Color> gradient;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final _OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(data.icon, color: Colors.white, size: 64.0),
          const SizedBox(height: 18.0),
          Text(
            data.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            data.body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 2: PageView.builder — lazy 50-tip card stack.
// ============================================================================

class _BuilderSection extends StatefulWidget {
  const _BuilderSection();

  @override
  State<_BuilderSection> createState() => _BuilderSectionState();
}

class _BuilderSectionState extends State<_BuilderSection> {
  final PageController _controller = PageController(viewportFraction: 0.92);
  int _index = 0;

  static const int _tipCount = 50;
  static const List<String> _tips = <String>[
    'Use deep work blocks of 90 minutes.',
    'Capture every idea — review weekly.',
    'Energy beats time. Schedule peaks for hard work.',
    'Single-tasking is the new superpower.',
    'Define done before you start.',
  ];

  static const List<List<Color>> _palettes = <List<Color>>[
    <Color>[Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    <Color>[Color(0xFF2193B0), Color(0xFF6DD5ED)],
    <Color>[Color(0xFFEE0979), Color(0xFFFF6A00)],
    <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
    <Color>[Color(0xFFFFB75E), Color(0xFFED8F03)],
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'PageView.builder constructs pages on demand. Use it whenever the '
          'page count is large, computed, or effectively infinite — the '
          'framework only realises pages that come into the viewport.',
        ),
        _DemoCard(
          title: 'PageView.builder(itemCount: 50)',
          subtitle: 'Productivity tips card — lazy, viewportFraction 0.92.',
          child: SizedBox(
            height: 220.0,
            child: PageView.builder(
              controller: _controller,
              itemCount: _tipCount,
              onPageChanged: (int i) => setState(() => _index = i),
              itemBuilder: (BuildContext context, int i) {
                final List<Color> palette =
                    _palettes[i % _palettes.length];
                final String body = _tips[i % _tips.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: palette,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: palette.last.withValues(alpha: 0.4),
                          blurRadius: 12.0,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 22.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              'Tip #${i + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          body,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Swipe to load the next tip — built lazily.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Page ${_index + 1} / $_tipCount',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'allowImplicitScrolling: false (default)',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 3: Horizontal vs vertical scroll direction.
// ============================================================================

class _AxisSection extends StatefulWidget {
  const _AxisSection();

  @override
  State<_AxisSection> createState() => _AxisSectionState();
}

class _AxisSectionState extends State<_AxisSection> {
  final PageController _hController = PageController();
  final PageController _vController = PageController();

  @override
  void dispose() {
    _hController.dispose();
    _vController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'Set scrollDirection to Axis.vertical for stories-style swipers, or '
          'leave it as Axis.horizontal for classic carousels and onboarding. '
          'The same children render identically in either orientation.',
        ),
        _DemoCard(
          title: 'Axis.horizontal',
          subtitle: 'Default. Swipe left/right.',
          child: SizedBox(
            height: 160.0,
            child: PageView(
              controller: _hController,
              children: <Widget>[
                _AxisCard(label: 'H · 1', color: Colors.teal.shade400),
                _AxisCard(label: 'H · 2', color: Colors.cyan.shade400),
                _AxisCard(label: 'H · 3', color: Colors.blueGrey.shade400),
              ],
            ),
          ),
        ),
        _DemoCard(
          title: 'Axis.vertical',
          subtitle: 'Same widget set, swipe up/down.',
          child: SizedBox(
            height: 240.0,
            child: PageView(
              controller: _vController,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _AxisCard(label: 'V · 1', color: Colors.deepOrange.shade400),
                _AxisCard(label: 'V · 2', color: Colors.amber.shade700),
                _AxisCard(label: 'V · 3', color: Colors.brown.shade400),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AxisCard extends StatelessWidget {
  const _AxisCard({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 4: viewportFraction carousel with peeking neighbours.
// ============================================================================

class _CarouselSection extends StatefulWidget {
  const _CarouselSection();

  @override
  State<_CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<_CarouselSection> {
  final PageController _controller =
      PageController(viewportFraction: 0.7, initialPage: 1);

  static const List<_FoodCard> _items = <_FoodCard>[
    _FoodCard(name: 'Margherita', icon: Icons.local_pizza, color: Color(0xFFFF7043)),
    _FoodCard(name: 'Sushi', icon: Icons.set_meal, color: Color(0xFF26A69A)),
    _FoodCard(name: 'Burger', icon: Icons.lunch_dining, color: Color(0xFFAB47BC)),
    _FoodCard(name: 'Ramen', icon: Icons.ramen_dining, color: Color(0xFFEF5350)),
    _FoodCard(name: 'Salad', icon: Icons.eco, color: Color(0xFF66BB6A)),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'viewportFraction < 1.0 makes each page narrower than the viewport '
          'so the neighbours peek in. Combined with an AnimatedBuilder that '
          'listens to the PageController, we can fade and shrink off-centre '
          'cards for a coverflow feel.',
        ),
        _DemoCard(
          title: 'PageController(viewportFraction: 0.7)',
          subtitle: 'Cards scale/fade based on controller.page.',
          child: SizedBox(
            height: 220.0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? _) {
                final double rawPage =
                    _controller.hasClients && _controller.position.haveDimensions
                        ? (_controller.page ?? 0.0)
                        : (_controller.initialPage).toDouble();
                return PageView.builder(
                  controller: _controller,
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int i) {
                    final double delta = (rawPage - i).abs();
                    final double scale =
                        (1.0 - (delta * 0.18)).clamp(0.78, 1.0);
                    final double opacity =
                        (1.0 - (delta * 0.45)).clamp(0.35, 1.0);
                    return Center(
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: _CarouselCard(data: _items[i]),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _FoodCard {
  const _FoodCard({required this.name, required this.icon, required this.color});

  final String name;
  final IconData icon;
  final Color color;
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({required this.data});

  final _FoodCard data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[data.color, data.color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: data.color.withValues(alpha: 0.4),
            blurRadius: 14.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(data.icon, color: Colors.white, size: 56.0),
          const SizedBox(height: 14.0),
          Text(
            data.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Tap, swipe, savour',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5: Programmatic control — previousPage / nextPage / animateToPage.
// ============================================================================

class _ProgrammaticSection extends StatefulWidget {
  const _ProgrammaticSection();

  @override
  State<_ProgrammaticSection> createState() => _ProgrammaticSectionState();
}

class _ProgrammaticSectionState extends State<_ProgrammaticSection> {
  final PageController _controller = PageController();
  int _page = 0;

  static const int _count = 6;
  static const Duration _kDur = Duration(milliseconds: 350);
  static const Curve _kCurve = Curves.easeInOutCubic;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goFirst() {
    debugPrint('animateToPage(0)');
    _controller.animateToPage(0, duration: _kDur, curve: _kCurve);
  }

  void _goPrev() {
    debugPrint('previousPage');
    _controller.previousPage(duration: _kDur, curve: _kCurve);
  }

  void _goNext() {
    debugPrint('nextPage');
    _controller.nextPage(duration: _kDur, curve: _kCurve);
  }

  void _goLast() {
    debugPrint('animateToPage(last)');
    _controller.animateToPage(_count - 1, duration: _kDur, curve: _kCurve);
  }

  void _jumpToTwo() {
    debugPrint('jumpToPage(2)');
    _controller.jumpToPage(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'A PageController exposes a typed API for moving the view: '
          'jumpToPage for instant navigation, animateToPage / nextPage / '
          'previousPage for animated transitions. Buttons below trigger each.',
        ),
        _DemoCard(
          title: 'PageController API',
          subtitle: 'Buttons drive nextPage, previousPage, animateToPage, jumpToPage.',
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180.0,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _count,
                  onPageChanged: (int i) => setState(() => _page = i),
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(14.0),
                        border:
                            Border.all(color: Colors.indigo.shade200, width: 1.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Slide ${i + 1}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _NavButton(icon: Icons.first_page, onPressed: _goFirst),
                    _NavButton(icon: Icons.chevron_left, onPressed: _goPrev),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade700,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Page ${_page + 1}/$_count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _NavButton(icon: Icons.chevron_right, onPressed: _goNext),
                    _NavButton(icon: Icons.last_page, onPressed: _goLast),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              TextButton.icon(
                onPressed: _jumpToTwo,
                icon: const Icon(Icons.shortcut),
                label: const Text('jumpToPage(2) — instant, no animation'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo.shade100,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon, color: Colors.indigo.shade700, size: 22.0),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 6: onPageChanged + animated dot indicator.
// ============================================================================

class _IndicatorSection extends StatefulWidget {
  const _IndicatorSection();

  @override
  State<_IndicatorSection> createState() => _IndicatorSectionState();
}

class _IndicatorSectionState extends State<_IndicatorSection> {
  final PageController _controller = PageController();
  int _page = 0;

  static const List<List<Color>> _strip = <List<Color>>[
    <Color>[Color(0xFFFC466B), Color(0xFF3F5EFB)],
    <Color>[Color(0xFF00B4DB), Color(0xFF0083B0)],
    <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
    <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
    <Color>[Color(0xFFDA22FF), Color(0xFF9733EE)],
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'onPageChanged fires once per settled page. Use it to drive your own '
          'indicator widget — here a row of dots whose width animates when '
          'selected for a polished gallery feel.',
        ),
        _DemoCard(
          title: 'Gallery + onPageChanged',
          subtitle: 'Animated dot indicator below the strip.',
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 160.0,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _strip.length,
                  onPageChanged: (int i) {
                    debugPrint('onPageChanged: $i');
                    setState(() => _page = i);
                  },
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _strip[i],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Photo ${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < _strip.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      width: i == _page ? 24.0 : 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: i == _page
                            ? Colors.indigo.shade700
                            : Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 7: Physics variants — Bouncing / Clamping / NeverScrollable.
// ============================================================================

class _PhysicsSection extends StatefulWidget {
  const _PhysicsSection();

  @override
  State<_PhysicsSection> createState() => _PhysicsSectionState();
}

class _PhysicsSectionState extends State<_PhysicsSection> {
  final PageController _bouncing = PageController();
  final PageController _clamping = PageController();
  final PageController _never = PageController();

  @override
  void dispose() {
    _bouncing.dispose();
    _clamping.dispose();
    _never.dispose();
    super.dispose();
  }

  Widget _miniPageView({
    required PageController controller,
    required ScrollPhysics physics,
    required List<Color> palette,
    required String label,
  }) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120.0,
          width: 110.0,
          child: PageView.builder(
            controller: controller,
            physics: physics,
            itemCount: 4,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: palette[i % palette.length],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> a = <Color>[
      Colors.pink.shade300,
      Colors.pink.shade400,
      Colors.pink.shade500,
      Colors.pink.shade600,
    ];
    final List<Color> b = <Color>[
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade500,
      Colors.lightBlue.shade600,
    ];
    final List<Color> c = <Color>[
      Colors.grey.shade400,
      Colors.grey.shade500,
      Colors.grey.shade600,
      Colors.grey.shade700,
    ];

    return Column(
      children: <Widget>[
        const _Narrative(
          'Swap physics to change the over-scroll feel. PageScrollPhysics is '
          'the default; BouncingScrollPhysics adds iOS-style rubber-banding, '
          'ClampingScrollPhysics gives Android-style glow stops, and '
          'NeverScrollableScrollPhysics disables user gestures entirely.',
        ),
        _DemoCard(
          title: 'Three physics, side by side',
          subtitle: 'Drag each to feel the difference.',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _miniPageView(
                  controller: _bouncing,
                  physics: const BouncingScrollPhysics(),
                  palette: a,
                  label: 'Bouncing',
                ),
                _miniPageView(
                  controller: _clamping,
                  physics: const ClampingScrollPhysics(),
                  palette: b,
                  label: 'Clamping',
                ),
                _miniPageView(
                  controller: _never,
                  physics: const NeverScrollableScrollPhysics(),
                  palette: c,
                  label: 'Never',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'PageScrollPhysics composes well: const PageScrollPhysics()'
            '.applyTo(BouncingScrollPhysics()).',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 8: PageView.custom with SliverChildBuilderDelegate.
// ============================================================================

class _CustomSection extends StatefulWidget {
  const _CustomSection();

  @override
  State<_CustomSection> createState() => _CustomSectionState();
}

class _CustomSectionState extends State<_CustomSection> {
  final PageController _controller = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'PageView.custom takes a SliverChildDelegate directly. Use it when '
          'you need a feature the builder constructor does not expose — for '
          'example findChildIndexCallback for stable keys, or '
          'addAutomaticKeepAlives: false to manually manage state.',
        ),
        _DemoCard(
          title: 'PageView.custom(childrenDelegate: ...)',
          subtitle: 'SliverChildBuilderDelegate with findChildIndexCallback.',
          child: SizedBox(
            height: 170.0,
            child: PageView.custom(
              controller: _controller,
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  if (i >= 8) {
                    return null;
                  }
                  return Container(
                    key: ValueKey<int>(i),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      border: Border.all(
                          color: Colors.teal.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.code, color: Colors.teal.shade700),
                        const SizedBox(height: 6.0),
                        Text(
                          'sliver #${i + 1}',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                findChildIndexCallback: (Key key) {
                  if (key is ValueKey<int>) {
                    return key.value;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 9: 2×2 grid of viewportFraction × padEnds combinations.
// ============================================================================

class _PadEndsGridSection extends StatefulWidget {
  const _PadEndsGridSection();

  @override
  State<_PadEndsGridSection> createState() => _PadEndsGridSectionState();
}

class _PadEndsGridSectionState extends State<_PadEndsGridSection> {
  final PageController _aController =
      PageController(viewportFraction: 1.0);
  final PageController _bController =
      PageController(viewportFraction: 1.0);
  final PageController _cController =
      PageController(viewportFraction: 0.7);
  final PageController _dController =
      PageController(viewportFraction: 0.7);

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    _dController.dispose();
    super.dispose();
  }

  Widget _cell({
    required PageController controller,
    required double viewportFraction,
    required bool padEnds,
  }) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'vf: $viewportFraction · padEnds: $padEnds',
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 90.0,
            child: PageView.builder(
              controller: controller,
              padEnds: padEnds,
              itemCount: 4,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _Narrative(
          'padEnds controls whether the first and last pages get extra '
          'padding so they can centre when viewportFraction < 1. The four '
          'combinations below show how the corners line up — flip padEnds '
          'off and the edges hug the viewport instead of centring.',
        ),
        _DemoCard(
          title: 'viewportFraction × padEnds',
          subtitle: '2×2 matrix of common configurations.',
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _cell(
                      controller: _aController,
                      viewportFraction: 1.0,
                      padEnds: true,
                    ),
                  ),
                  Expanded(
                    child: _cell(
                      controller: _bController,
                      viewportFraction: 1.0,
                      padEnds: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _cell(
                      controller: _cController,
                      viewportFraction: 0.7,
                      padEnds: true,
                    ),
                  ),
                  Expanded(
                    child: _cell(
                      controller: _dController,
                      viewportFraction: 0.7,
                      padEnds: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 10: Cheat-sheet card summarising each parameter.
// ============================================================================

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection();

  static const List<_CheatRow> _rows = <_CheatRow>[
    _CheatRow(
      name: 'controller',
      summary: 'Owns scroll offset; exposes jumpToPage / animateToPage.',
    ),
    _CheatRow(
      name: 'scrollDirection',
      summary: 'Axis.horizontal (default) or Axis.vertical.',
    ),
    _CheatRow(
      name: 'pageSnapping',
      summary: 'When false the scrollable behaves like a ListView.',
    ),
    _CheatRow(
      name: 'physics',
      summary: 'PageScrollPhysics / Bouncing / Clamping / Never...',
    ),
    _CheatRow(
      name: 'onPageChanged',
      summary: 'Fires once the user settles on a new page.',
    ),
    _CheatRow(
      name: 'allowImplicitScrolling',
      summary: 'Lets a11y / focus traversal scroll between pages.',
    ),
    _CheatRow(
      name: 'padEnds',
      summary: 'Pads first/last pages so they can centre when vf < 1.',
    ),
    _CheatRow(
      name: 'clipBehavior',
      summary: 'Defaults to Clip.hardEdge; use Clip.none to bleed shadows.',
    ),
    _CheatRow(
      name: 'PageController.initialPage',
      summary: 'First visible page index (default 0).',
    ),
    _CheatRow(
      name: 'PageController.viewportFraction',
      summary: 'Fraction of the viewport each page takes (default 1.0).',
    ),
    _CheatRow(
      name: 'PageController.keepPage',
      summary: 'When true PageStorage remembers the current page.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Cheat-sheet',
      subtitle: 'Quick lookup of PageView and PageController parameters.',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: <Widget>[
            for (final _CheatRow r in _rows)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 150.0,
                      child: Text(
                        r.name,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo.shade900,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        r.summary,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade800,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CheatRow {
  const _CheatRow({required this.name, required this.summary});

  final String name;
  final String summary;
}
