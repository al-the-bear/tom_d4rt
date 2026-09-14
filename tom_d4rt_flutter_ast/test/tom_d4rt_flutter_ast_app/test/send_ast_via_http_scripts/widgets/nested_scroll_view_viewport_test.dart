import 'package:flutter/material.dart';

// ─── Top-level ValueNotifiers ────────────────────────────────────────────────

final ValueNotifier<int> _activeTabNotifier = ValueNotifier<int>(0);

// ─── Entry point ─────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A6B3C)),
    ),
    home: const _NestedScrollViewViewportDemo(),
  );
}

// ─── Root scaffold ────────────────────────────────────────────────────────────

class _NestedScrollViewViewportDemo extends StatelessWidget {
  const _NestedScrollViewViewportDemo();

  static const List<_TabSpec> _tabs = <_TabSpec>[
    _TabSpec(icon: Icons.home_outlined, label: 'Intro'),
    _TabSpec(icon: Icons.layers_outlined, label: 'Working'),
    _TabSpec(icon: Icons.broken_image_outlined, label: 'Broken'),
    _TabSpec(icon: Icons.account_tree_outlined, label: 'Budget'),
    _TabSpec(icon: Icons.tab_outlined, label: 'Tab Sync'),
    _TabSpec(icon: Icons.animation_outlined, label: 'Variants'),
    _TabSpec(icon: Icons.swap_vert_outlined, label: 'Coord'),
    _TabSpec(icon: Icons.code_outlined, label: 'API'),
    _TabSpec(icon: Icons.warning_amber_outlined, label: 'Pitfalls'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NestedScrollViewViewport'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: (int i) => _activeTabNotifier.value = i,
            tabs: _tabs
                .map((t) => Tab(icon: Icon(t.icon), text: t.label))
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _WorkingNestedScrollTab(),
            _BrokenVsFixedTab(),
            _OverlapBudgetDiagramTab(),
            _TabSyncTab(),
            _VariantsTab(),
            _ScrollCoordinationTab(),
            _ApiSnippetsTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Hero Banner / Intro
// ═══════════════════════════════════════════════════════════════════════════════

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(0),
      children: <Widget>[
        _GradientBanner(
          child: Column(
            children: <Widget>[
              Icon(Icons.layers, size: 64, color: cs.onPrimary),
              const SizedBox(height: 12),
              Text(
                'NestedScrollViewViewport',
                style: tt.headlineMedium?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "The custom Viewport that powers NestedScrollView's\ntwo-level scroll coordination.",
                style: tt.bodyMedium?.copyWith(color: cs.onPrimary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SectionHeading('What Is NestedScrollViewViewport?'),
              const SizedBox(height: 8),
              Text(
                'NestedScrollViewViewport is the internal Viewport subclass used '
                'by NestedScrollView for its inner scrollable regions (one per tab). '
                'Unlike a plain Viewport, it carries an extra "overlap" offset that '
                'accounts for the space consumed by the pinned/floating SliverAppBar '
                'sitting above it.',
                style: tt.bodyMedium,
              ),
              const SizedBox(height: 20),
              _SectionHeading('The Overlap-Budget Concept'),
              const SizedBox(height: 8),
              _InfoCard(
                icon: Icons.lightbulb_outline,
                color: cs.tertiaryContainer,
                child: Text(
                  'When a SliverAppBar is pinned, its collapsed height "overlaps" the '
                  'inner scroll area. Without compensation, the top of the inner list '
                  'is hidden under the app bar. The overlap budget is the measured '
                  'amount of that overlap, produced by SliverOverlapAbsorber in the '
                  'outer scroll and consumed by SliverOverlapInjector in each inner '
                  'scroll.',
                  style: tt.bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              _SectionHeading('Why Plain CustomScrollView Breaks'),
              const SizedBox(height: 8),
              _StepTile(
                index: 1,
                title: 'No overlap measurement',
                body: 'A regular CustomScrollView does not measure the outer '
                    'SliverAppBar\'s extent and pass it inward. The inner '
                    'viewport starts at offset 0, not offset = appBarHeight.',
              ),
              const SizedBox(height: 8),
              _StepTile(
                index: 2,
                title: 'Double-scroll problem',
                body: 'Without coordination, dragging can scroll the outer list '
                    'AND the inner list simultaneously, producing jittery or '
                    'physically incorrect behaviour.',
              ),
              const SizedBox(height: 8),
              _StepTile(
                index: 3,
                title: 'No shared scroll physics',
                body: 'NestedScrollView installs a custom ScrollPhysics that '
                    'apportions drag between inner and outer. A plain '
                    'CustomScrollView has no such delegation.',
              ),
              const SizedBox(height: 20),
              _SectionHeading('Key Classes at a Glance'),
              const SizedBox(height: 8),
              _ClassTable(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientBanner extends StatelessWidget {
  const _GradientBanner({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cs.primary, cs.tertiary],
        ),
      ),
      child: child,
    );
  }
}

class _ClassTable extends StatelessWidget {
  const _ClassTable();

  static const List<List<String>> _rows = <List<String>>[
    <String>['NestedScrollViewViewport', 'Viewport subclass', 'Inner viewport with overlap offset'],
    <String>['SliverOverlapAbsorber', 'SingleChildRenderObjectWidget', 'Measures & absorbs overlap budget'],
    <String>['SliverOverlapInjector', 'SingleChildRenderObjectWidget', 'Re-injects budget into inner list'],
    <String>['NestedScrollView', 'StatefulWidget', 'Coordinates outer + inner scrollables'],
    <String>['_NestedScrollCoordinator', 'Internal class', 'Delegates drag between viewports'],
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(4),
        },
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: cs.primaryContainer),
            children: <Widget>[
              _tableHeader('Class'),
              _tableHeader('Type'),
              _tableHeader('Role'),
            ],
          ),
          ..._rows.map(
            (r) => TableRow(
              children: r.map((c) => _tableData(c)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tableHeader(String text) => Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );

Widget _tableData(String text) => Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text),
    );

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Working NestedScrollView
// ═══════════════════════════════════════════════════════════════════════════════

class _WorkingNestedScrollTab extends StatelessWidget {
  const _WorkingNestedScrollTab();

  static const List<String> _categories = <String>['Rivers', 'Mountains', 'Deserts'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverAppBar(
                title: const Text('Working NestedScrollView'),
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: _HeroFlexBackground(),
                ),
                bottom: TabBar(
                  tabs: _categories.map((c) => Tab(text: c)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: _categories.map((cat) => _InnerList(category: cat)).toList(),
        ),
      ),
    );
  }
}

class _HeroFlexBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[cs.primary, cs.secondary],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 48),
          Icon(Icons.public, size: 48, color: Colors.white.withAlpha(200)),
          const SizedBox(height: 8),
          Text(
            'Correctly Coordinated Scroll',
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InnerList extends StatelessWidget {
  const _InnerList({required this.category});
  final String category;

  static const Map<String, List<String>> _data = <String, List<String>>{
    'Rivers': <String>[
      'Amazon', 'Nile', 'Yangtze', 'Mississippi', 'Congo', 'Niger', 'Mekong',
      'Volga', 'Zambezi', 'Murray',
    ],
    'Mountains': <String>[
      'Everest', 'K2', 'Kangchenjunga', 'Lhotse', 'Makalu', 'Cho Oyu',
      'Dhaulagiri', 'Manaslu', 'Nanga Parbat', 'Annapurna',
    ],
    'Deserts': <String>[
      'Sahara', 'Arabian', 'Gobi', 'Patagonian', 'Great Victoria', 'Kalahari',
      'Great Basin', 'Syrian', 'Chihuahuan', 'Taklamakan',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> items = _data[category] ?? <String>[];
    return Builder(
      builder: (BuildContext ctx) {
        return CustomScrollView(
          key: PageStorageKey<String>(category),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList.builder(
                itemCount: items.length,
                itemBuilder: (_, int i) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text(items[i]),
                    subtitle: Text('$category item ${i + 1}'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Broken vs Fixed
// ═══════════════════════════════════════════════════════════════════════════════

class _BrokenVsFixedTab extends StatelessWidget {
  const _BrokenVsFixedTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          color: cs.surfaceContainerHighest,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Left: missing SliverOverlapInjector (content hidden under header). '
                  'Right: correct implementation.',
                  style: tt.bodySmall,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(child: _BrokenScrollDemo()),
              VerticalDivider(width: 2, color: cs.outlineVariant),
              Expanded(child: _FixedScrollDemo()),
            ],
          ),
        ),
      ],
    );
  }
}

class _BrokenScrollDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        Container(
          color: cs.errorContainer,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.close, color: cs.onErrorContainer, size: 16),
              const SizedBox(width: 4),
              Text(
                'Broken (no injector)',
                style: TextStyle(
                  color: cs.onErrorContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: const Text('Header', style: TextStyle(fontSize: 14)),
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
              ),
              // Deliberately NO SliverOverlapInjector here — broken!
              SliverList.builder(
                itemCount: 15,
                itemBuilder: (_, int i) => ListTile(
                  dense: true,
                  title: Text('Item ${i + 1}'),
                  tileColor: i == 0 ? cs.errorContainer : null,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: cs.errorContainer,
          child: Text(
            'Item 1 is hidden behind the header!',
            style: TextStyle(
              color: cs.onErrorContainer,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _FixedScrollDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        Container(
          color: cs.primaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check, color: cs.onPrimaryContainer, size: 16),
              const SizedBox(width: 4),
              Text(
                'Fixed (with injector)',
                style: TextStyle(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 1,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext ctx, bool scrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    sliver: SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      title: const Text('Header', style: TextStyle(fontSize: 14)),
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      forceElevated: scrolled,
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (BuildContext ctx) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                      ),
                      SliverList.builder(
                        itemCount: 15,
                        itemBuilder: (_, int i) => ListTile(
                          dense: true,
                          title: Text('Item ${i + 1}'),
                          tileColor: i == 0 ? cs.primaryContainer : null,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: cs.primaryContainer,
          child: Text(
            'Item 1 is fully visible!',
            style: TextStyle(
              color: cs.onPrimaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 4 — Overlap Budget Diagram (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════════════

class _OverlapBudgetDiagramTab extends StatelessWidget {
  const _OverlapBudgetDiagramTab();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('Overlap-Budget Data Flow'),
        const SizedBox(height: 8),
        Text(
          'The diagram below shows how the overlap value is produced by '
          'SliverOverlapAbsorber in the outer scroll and consumed by '
          'SliverOverlapInjector in each inner scroll.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            width: 360,
            height: 460,
            child: CustomPaint(
              painter: _OverlapBudgetPainter(
                primary: cs.primary,
                secondary: cs.secondary,
                tertiary: cs.tertiary,
                surface: cs.surface,
                onSurface: cs.onSurface,
                outline: cs.outline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeading('Step-by-Step'),
        const SizedBox(height: 8),
        _StepTile(
          index: 1,
          title: 'SliverAppBar expands',
          body: 'The outer SliverAppBar fills its expandedHeight. The pinned '
              'portion (toolbarHeight + tabBarHeight) is the overlap budget.',
        ),
        const SizedBox(height: 8),
        _StepTile(
          index: 2,
          title: 'SliverOverlapAbsorber captures it',
          body: 'Wrapped around the SliverAppBar in the outer headerSliverBuilder, '
              'it calls NestedScrollView.sliverOverlapAbsorberHandleFor(context) and '
              'stores the overlap measurement in the handle.',
        ),
        const SizedBox(height: 8),
        _StepTile(
          index: 3,
          title: 'Handle is passed to inner viewport',
          body: 'NestedScrollViewViewport receives the handle and adjusts its '
              'anchor/offset so the inner content starts below the pinned header.',
        ),
        const SizedBox(height: 8),
        _StepTile(
          index: 4,
          title: 'SliverOverlapInjector re-injects',
          body: 'At the top of each inner CustomScrollView, SliverOverlapInjector '
              'reads the same handle and inserts a virtual sliver of that exact '
              'height, pushing the real content down to the correct position.',
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _OverlapBudgetPainter extends CustomPainter {
  const _OverlapBudgetPainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.surface,
    required this.onSurface,
    required this.outline,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color surface;
  final Color onSurface;
  final Color outline;

  static const double _boxW = 200;
  static const double _boxH = 48;
  static const double _r = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arrowPaint = Paint()
      ..color = onSurface
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint outlinePaint = Paint()
      ..color = outline
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final double cx = size.width / 2;

    // Box 1: SliverAppBar
    _drawBox(canvas, cx, 20, 'SliverAppBar\n(expandedHeight)', primary,
        Colors.white, outlinePaint);

    // Arrow down
    _drawArrow(canvas, cx, 20 + _boxH, cx, 110, arrowPaint);
    _drawLabel(canvas, cx + 8, 84, '① measures overlap', onSurface);

    // Box 2: SliverOverlapAbsorber
    _drawBox(canvas, cx, 110, 'SliverOverlapAbsorber\n(outer list)', secondary,
        Colors.white, outlinePaint);

    // Arrow down
    _drawArrow(canvas, cx, 110 + _boxH, cx, 200, arrowPaint);
    _drawLabel(canvas, cx + 8, 174, '② stores in handle', onSurface);

    // Box 3: NestedScrollViewViewport
    _drawBox(canvas, cx, 200, 'NestedScrollViewViewport\n(inner)', tertiary,
        Colors.white, outlinePaint);

    // Arrow down
    _drawArrow(canvas, cx, 200 + _boxH, cx, 290, arrowPaint);
    _drawLabel(canvas, cx + 8, 264, '③ adjusts anchor', onSurface);

    // Box 4: SliverOverlapInjector
    _drawBox(canvas, cx, 290, 'SliverOverlapInjector\n(top of inner list)',
        primary.withAlpha(180), Colors.white, outlinePaint);

    // Arrow down
    _drawArrow(canvas, cx, 290 + _boxH, cx, 380, arrowPaint);
    _drawLabel(canvas, cx + 8, 354, '④ pushes content down', onSurface);

    // Box 5: Inner list content
    _drawBox(canvas, cx, 380, 'Inner List Content\n(correct position)',
        secondary.withAlpha(180), Colors.white, outlinePaint);
  }

  void _drawBox(Canvas canvas, double cx, double top, String label,
      Color fillColor, Color textColor, Paint stroke) {
    final Paint fill = Paint()..color = fillColor;
    final Rect rect = Rect.fromLTWH(cx - _boxW / 2, top, _boxW, _boxH);
    final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(_r));
    canvas.drawRRect(rRect, fill);
    canvas.drawRRect(rRect, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: _boxW - 8);
    tp.paint(
      canvas,
      Offset(cx - tp.width / 2, top + (_boxH - tp.height) / 2),
    );
  }

  void _drawArrow(
      Canvas canvas, double x1, double y1, double x2, double y2, Paint paint) {
    canvas.drawLine(Offset(x1, y1 + 2), Offset(x2, y2 - 8), paint);
    final Path head = Path()
      ..moveTo(x2 - 6, y2 - 14)
      ..lineTo(x2, y2 - 4)
      ..lineTo(x2 + 6, y2 - 14);
    canvas.drawPath(
        head,
        Paint()
          ..color = paint.color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round);
  }

  void _drawLabel(Canvas canvas, double x, double y, String text, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 10, fontStyle: FontStyle.italic),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    // keep within bounds
    final double drawX = (x + tp.width > 360) ? x - tp.width - 16 : x;
    tp.paint(canvas, Offset(drawX, y));
  }

  @override
  bool shouldRepaint(covariant _OverlapBudgetPainter old) =>
      old.primary != primary ||
      old.secondary != secondary ||
      old.onSurface != onSurface;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 5 — Tab Synchronization
// ═══════════════════════════════════════════════════════════════════════════════

class _TabSyncTab extends StatelessWidget {
  const _TabSyncTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('One SliverOverlapInjector Per Tab'),
        const SizedBox(height: 8),
        Text(
          'A critical rule: each tab\'s CustomScrollView must have its own '
          'SliverOverlapInjector. They all read from the same '
          'SliverOverlapAbsorberHandle — the handle is not consumed; it can '
          'be read by many injectors simultaneously.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 20),
        _SectionHeading('Widget Tree Diagram'),
        const SizedBox(height: 12),
        _TreeDiagram(cs: cs),
        const SizedBox(height: 24),
        _SectionHeading('Why Each Tab Needs Its Own Injector'),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.tab,
          color: cs.secondaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PageStorageKey preserves scroll position per tab.',
                style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'When the user switches tabs, the new tab\'s CustomScrollView '
                'becomes visible. It must independently obtain the current overlap '
                'budget from the shared handle and display content at the correct '
                'vertical position — even if its scroll offset differs from '
                'the previous tab.',
                style: tt.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionHeading('Correct Pattern'),
        const SizedBox(height: 8),
        _CodeSnippet(
          code: '''
// In each tab's Builder:
Builder(
  builder: (BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>(tabLabel), // ← preserve position
      slivers: <Widget>[
        SliverOverlapInjector(
          // Same handle as the absorber ↑
          handle: NestedScrollView
            .sliverOverlapAbsorberHandleFor(context),
        ),
        // ... actual tab slivers
      ],
    );
  },
)
''',
        ),
        const SizedBox(height: 20),
        _SectionHeading('Common Mistake'),
        const SizedBox(height: 8),
        _ErrorCard(
          title: 'Sharing a single injector across tabs',
          body: 'If you try to reuse one SliverOverlapInjector widget across '
              'multiple tabs (e.g., outside the TabBarView), it will only be '
              'mounted in one tab at a time. The other tabs will start at '
              'offset 0 and appear clipped under the header.',
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _TreeDiagram extends StatelessWidget {
  const _TreeDiagram({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TreeNode(label: 'NestedScrollView', depth: 0, color: cs.primary),
            _TreeNode(label: '├─ headerSliverBuilder', depth: 1, color: cs.secondary),
            _TreeNode(label: '│   ├─ SliverOverlapAbsorber (★ ONE only)', depth: 2, color: cs.tertiary),
            _TreeNode(label: '│   └─ SliverAppBar (pinned)', depth: 2, color: cs.secondary),
            _TreeNode(label: '└─ body: DefaultTabController', depth: 1, color: cs.secondary),
            _TreeNode(label: '    └─ TabBarView', depth: 2, color: cs.secondary),
            _TreeNode(label: '        ├─ Builder → CustomScrollView [Tab 1]', depth: 3, color: cs.tertiary),
            _TreeNode(label: '        │   ├─ SliverOverlapInjector (handle)', depth: 4, color: cs.primary),
            _TreeNode(label: '        │   └─ SliverList', depth: 4, color: cs.outline),
            _TreeNode(label: '        ├─ Builder → CustomScrollView [Tab 2]', depth: 3, color: cs.tertiary),
            _TreeNode(label: '        │   ├─ SliverOverlapInjector (handle)', depth: 4, color: cs.primary),
            _TreeNode(label: '        │   └─ SliverList', depth: 4, color: cs.outline),
            _TreeNode(label: '        └─ Builder → CustomScrollView [Tab N]', depth: 3, color: cs.tertiary),
            _TreeNode(label: '            ├─ SliverOverlapInjector (handle)', depth: 4, color: cs.primary),
            _TreeNode(label: '            └─ SliverList', depth: 4, color: cs.outline),
          ],
        ),
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  const _TreeNode({
    required this.label,
    required this.depth,
    required this.color,
  });
  final String label;
  final int depth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 8.0, top: 3, bottom: 3),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: color,
          fontWeight: label.contains('★') ? FontWeight.w800 : FontWeight.w500,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 6 — Pinned / Floating / Snap Variants
// ═══════════════════════════════════════════════════════════════════════════════

class _VariantsTab extends StatelessWidget {
  const _VariantsTab();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('Three SliverAppBar Behavior Variants'),
        const SizedBox(height: 8),
        Text(
          'NestedScrollView works correctly with all three SliverAppBar '
          'behavior modes. Each demo below is a self-contained NestedScrollView '
          'embedded at reduced height so all three are visible together.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 20),
        _VariantCard(
          title: 'Pinned Only',
          subtitle: 'pinned: true, floating: false, snap: false',
          description: 'The app bar collapses to its toolbarHeight and stays '
              'pinned. The overlap budget is fixed at toolbarHeight. The inner '
              'list always starts below the pinned bar.',
          colorSeed: const Color(0xFF1B5E20),
          pinned: true,
          floating: false,
          snap: false,
        ),
        const SizedBox(height: 20),
        _VariantCard(
          title: 'Pinned + Floating',
          subtitle: 'pinned: true, floating: true, snap: false',
          description: 'The app bar floats back into view when the user scrolls '
              'up even a tiny amount. Useful for re-revealing navigation without '
              'losing the current scroll position.',
          colorSeed: const Color(0xFF0D47A1),
          pinned: true,
          floating: true,
          snap: false,
        ),
        const SizedBox(height: 20),
        _VariantCard(
          title: 'Floating + Snap',
          subtitle: 'pinned: false, floating: true, snap: true',
          description: 'The app bar fully snaps in or out — it never pauses '
              'mid-expansion. The overlap budget jumps between 0 and '
              'expandedHeight rather than animating continuously.',
          colorSeed: const Color(0xFF4A148C),
          pinned: false,
          floating: true,
          snap: true,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.colorSeed,
    required this.pinned,
    required this.floating,
    required this.snap,
  });

  final String title;
  final String subtitle;
  final String description;
  final Color colorSeed;
  final bool pinned;
  final bool floating;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme varCs =
        ColorScheme.fromSeed(seedColor: colorSeed, brightness: Brightness.light);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: varCs.primary,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: tt.titleMedium?.copyWith(
                      color: varCs.onPrimary,
                      fontWeight: FontWeight.w800,
                    )),
                Text(subtitle,
                    style: tt.bodySmall?.copyWith(
                      color: varCs.onPrimary.withAlpha(200),
                      fontFamily: 'monospace',
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(description, style: tt.bodySmall),
          ),
          SizedBox(
            height: 260,
            child: _MiniNestedScrollView(
              varCs: varCs,
              pinned: pinned,
              floating: floating,
              snap: snap,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniNestedScrollView extends StatelessWidget {
  const _MiniNestedScrollView({
    required this.varCs,
    required this.pinned,
    required this.floating,
    required this.snap,
  });

  final ColorScheme varCs;
  final bool pinned;
  final bool floating;
  final bool snap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: pinned,
                floating: floating,
                snap: snap,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: pinned ? 100 : 80,
                backgroundColor: varCs.primary,
                foregroundColor: varCs.onPrimary,
                title: Text(
                  '${pinned ? "Pinned" : ""}${floating ? " Floating" : ""}${snap ? " Snap" : ""}',
                  style: const TextStyle(fontSize: 13),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(color: varCs.secondary),
                ),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext ctx) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                ),
                SliverList.builder(
                  itemCount: 12,
                  itemBuilder: (_, int i) => ListTile(
                    dense: true,
                    tileColor: i.isEven ? varCs.surfaceContainerLow : null,
                    title: Text('Row ${i + 1}',
                        style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 7 — Scroll Coordination Diagram
// ═══════════════════════════════════════════════════════════════════════════════

class _ScrollCoordinationTab extends StatelessWidget {
  const _ScrollCoordinationTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('Two-Level Scroll Coordination'),
        const SizedBox(height: 8),
        Text(
          'NestedScrollView uses _NestedScrollCoordinator to apportion drag '
          'deltas between the outer scrollable (which moves the header) and the '
          'inner scrollable (which moves the list). The rule is simple: the outer '
          'scrollable gets first dibs until it reaches its maxScrollExtent, then '
          'the inner takes over.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            width: 380,
            height: 520,
            child: CustomPaint(
              painter: _CoordinationDiagramPainter(
                primary: cs.primary,
                secondary: cs.secondary,
                tertiary: cs.tertiary,
                onSurface: cs.onSurface,
                outline: cs.outline,
                error: cs.error,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeading('Scroll Phase Rules'),
        const SizedBox(height: 8),
        _PhaseTable(),
        const SizedBox(height: 20),
        _SectionHeading('The Coordinator Contract'),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.handshake_outlined,
          color: cs.tertiaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Drag down (positive delta):', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(
                '1. Outer scrollable absorbs delta until minScrollExtent.\n'
                '2. Remaining delta goes to inner scrollable.',
                style: tt.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text('Drag up (negative delta):', style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(
                '1. Inner scrollable absorbs delta until minScrollExtent.\n'
                '2. Remaining delta goes to outer scrollable (collapses header).',
                style: tt.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionHeading('NestedScrollViewViewport\'s Role'),
        const SizedBox(height: 8),
        Text(
          'NestedScrollViewViewport differs from a plain Viewport in one key way: '
          'it accepts an overlap parameter. This value is passed down from the '
          'coordinator and offsets the viewport\'s anchor point so that child '
          'slivers are positioned below the pinned header, not underneath it.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _PhaseTable extends StatelessWidget {
  const _PhaseTable();

  static const List<List<String>> _rows = <List<String>>[
    <String>['Scroll up (expand header)', 'Inner at min', 'Outer expands', 'Full header visible'],
    <String>['Scroll up (header expanded)', 'Outer at max', 'Inner scrolls', 'List moves down'],
    <String>['Scroll down (collapse header)', 'Inner first absorbs', 'Outer collapses', 'Header shrinks'],
    <String>['Fling (fast scroll)', 'Split by velocity', 'Both animate', 'Physics handles it'],
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(3),
        },
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: cs.primaryContainer),
            children: <Widget>[
              _tableHeader('Gesture'),
              _tableHeader('Phase 1'),
              _tableHeader('Phase 2'),
              _tableHeader('Result'),
            ],
          ),
          ..._rows.map(
            (r) => TableRow(children: r.map((c) => _tableData(c)).toList()),
          ),
        ],
      ),
    );
  }
}

class _CoordinationDiagramPainter extends CustomPainter {
  const _CoordinationDiagramPainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.onSurface,
    required this.outline,
    required this.error,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color onSurface;
  final Color outline;
  final Color error;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final Paint arrowP = Paint()
      ..color = onSurface
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint outlineP = Paint()
      ..color = outline
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    // User drag gesture box
    _paintBox(canvas, cx, 10, 220, 44, 'User Drag Gesture', primary, Colors.white, outlineP);

    // Arrow to coordinator
    _arrowDown(canvas, cx, 54, cx, 90, arrowP);

    // Coordinator
    _paintBox(canvas, cx, 90, 280, 44, '_NestedScrollCoordinator', secondary, Colors.white, outlineP);

    // Two branches
    _arrowAngle(canvas, cx - 60, 134, cx - 110, 178, arrowP);
    _arrowAngle(canvas, cx + 60, 134, cx + 110, 178, arrowP);

    // Outer scroll
    _paintBox(canvas, cx - 110, 178, 180, 52, 'Outer Scrollable\n(header region)', tertiary, Colors.white, outlineP);

    // Inner scroll
    _paintBox(canvas, cx + 110, 178, 180, 52, 'Inner Scrollable\n(list region)', primary.withAlpha(180), Colors.white, outlineP);

    // Arrow from outer to NestedScrollViewViewport
    _arrowDown(canvas, cx - 110, 230, cx - 110, 276, arrowP);

    // Arrow from inner to NestedScrollViewViewport
    _arrowDown(canvas, cx + 110, 230, cx + 110, 276, arrowP);

    // Converge arrows
    _arrowAngle(canvas, cx - 110, 320, cx - 40, 360, arrowP);
    _arrowAngle(canvas, cx + 110, 320, cx + 40, 360, arrowP);

    // Outer viewport box
    _paintBox(canvas, cx - 110, 276, 180, 44, 'Outer Viewport\n(SliverAppBar lives here)', secondary.withAlpha(180), Colors.white, outlineP);

    // Inner viewport box
    _paintBox(canvas, cx + 110, 276, 180, 44, 'NestedScrollViewViewport\n(overlap-aware)', tertiary.withAlpha(200), Colors.white, outlineP);

    // Final result box
    _paintBox(canvas, cx, 360, 280, 52, 'Coordinated Frame\n(correct overlap budget applied)', primary, Colors.white, outlineP);

    // Label
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'overlap budget',
        style: TextStyle(
          color: tertiary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx + 14, 310));
  }

  void _paintBox(Canvas canvas, double cx, double top, double w, double h,
      String label, Color fillColor, Color textColor, Paint stroke) {
    final Paint fill = Paint()..color = fillColor;
    final Rect rect = Rect.fromLTWH(cx - w / 2, top, w, h);
    final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    canvas.drawRRect(rRect, fill);
    canvas.drawRRect(rRect, stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(color: textColor, fontSize: 10.5, fontWeight: FontWeight.w600),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: w - 8);
    tp.paint(canvas, Offset(cx - tp.width / 2, top + (h - tp.height) / 2));
  }

  void _arrowDown(Canvas canvas, double x, double y1, double x2, double y2, Paint p) {
    canvas.drawLine(Offset(x, y1 + 2), Offset(x2, y2 - 8), p);
    final Path head = Path()
      ..moveTo(x2 - 5, y2 - 13)
      ..lineTo(x2, y2 - 3)
      ..lineTo(x2 + 5, y2 - 13);
    canvas.drawPath(
        head,
        Paint()
          ..color = p.color
          ..strokeWidth = 1.8
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round);
  }

  void _arrowAngle(Canvas canvas, double x1, double y1, double x2, double y2, Paint p) {
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2 - 6), p);
    final double dx = x2 - x1;
    final double dy = (y2 - 6) - y1;
    final double len = (dx * dx + dy * dy) == 0 ? 1 : 1;
    final double ux = dx * len;
    final double uy = dy * len;
    canvas.drawLine(Offset(x2 - ux * 8 - uy * 5, y2 - 6 - uy * 8 + ux * 5),
        Offset(x2, y2 - 6), p);
    canvas.drawLine(Offset(x2 - ux * 8 + uy * 5, y2 - 6 - uy * 8 - ux * 5),
        Offset(x2, y2 - 6), p);
  }

  @override
  bool shouldRepaint(covariant _CoordinationDiagramPainter old) =>
      old.primary != primary || old.onSurface != onSurface;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 8 — API Snippets
// ═══════════════════════════════════════════════════════════════════════════════

class _ApiSnippetsTab extends StatelessWidget {
  const _ApiSnippetsTab();

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('SliverOverlapAbsorber'),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.compress_outlined,
          color: cs.secondaryContainer,
          child: Text(
            'Placed in the outer headerSliverBuilder, wrapping the SliverAppBar. '
            'It measures the overlap that the pinned portion of the app bar '
            'creates over the inner scroll area and stores it in a '
            'SliverOverlapAbsorberHandle.',
            style: tt.bodyMedium,
          ),
        ),
        const SizedBox(height: 8),
        _CodeSnippet(code: r'''
SliverOverlapAbsorber(
  // Obtain the handle from NestedScrollView's context
  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  sliver: SliverAppBar(
    pinned: true,
    expandedHeight: 200,
    flexibleSpace: FlexibleSpaceBar(
      title: Text('My App'),
    ),
    bottom: TabBar(tabs: myTabs),
  ),
)
'''),
        const SizedBox(height: 24),
        _SectionHeading('SliverOverlapInjector'),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.expand_outlined,
          color: cs.tertiaryContainer,
          child: Text(
            'Placed at the very top of each inner CustomScrollView\'s sliver list. '
            'It reads the overlap value from the same handle and inserts a '
            'virtual sliver of that exact height, ensuring the real content '
            'starts below the pinned header.',
            style: tt.bodyMedium,
          ),
        ),
        const SizedBox(height: 8),
        _CodeSnippet(code: r'''
// Inside each tab's Builder:
Builder(
  builder: (BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>('tab_key'),
      slivers: <Widget>[
        // ← MUST be first
        SliverOverlapInjector(
          handle: NestedScrollView
            .sliverOverlapAbsorberHandleFor(context),
        ),
        // Your real slivers below:
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) => ListTile(title: Text(items[i])),
        ),
      ],
    );
  },
)
'''),
        const SizedBox(height: 24),
        _SectionHeading('NestedScrollViewViewport Constructor'),
        const SizedBox(height: 8),
        _InfoCard(
          icon: Icons.view_quilt_outlined,
          color: cs.primaryContainer,
          child: Text(
            'Normally you never construct NestedScrollViewViewport directly — '
            'NestedScrollView creates it internally. This reference is provided '
            'for completeness and for custom Viewport subclassing scenarios.',
            style: tt.bodyMedium,
          ),
        ),
        const SizedBox(height: 8),
        _CodeSnippet(code: r'''
// Internal constructor (Flutter framework):
NestedScrollViewViewport({
  super.key,
  super.axisDirection,
  super.crossAxisDirection,
  super.anchor,
  required super.offset,
  super.center,
  super.cacheExtent,
  super.cacheExtentStyle,
  // The overlap value — set by _NestedScrollCoordinator:
  required this.handle,
  super.clipBehavior,
  super.children,
})
'''),
        const SizedBox(height: 24),
        _SectionHeading('SliverOverlapAbsorberHandle'),
        const SizedBox(height: 8),
        _CodeSnippet(code: r'''
// Obtain handle — call inside a Builder whose context
// is a descendant of NestedScrollView:
final SliverOverlapAbsorberHandle handle =
  NestedScrollView.sliverOverlapAbsorberHandleFor(context);

// The handle exposes:
// handle.overlap — current overlap in logical pixels
// handle.layoutExtent — total layout extent of the absorber
'''),
        const SizedBox(height: 24),
        _SectionHeading('Full NestedScrollView Skeleton'),
        const SizedBox(height: 8),
        _CodeSnippet(code: r'''
DefaultTabController(
  length: tabs.length,
  child: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView
            .sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            title: const Text('Title'),
            pinned: true,
            floating: false,
            forceElevated: boxIsScrolled,
            bottom: TabBar(
              tabs: tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ),
      ];
    },
    body: TabBarView(
      children: tabs.map((tab) {
        return Builder(builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(tab),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView
                  .sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList.builder(
                itemCount: 20,
                itemBuilder: (_, i) => ListTile(title: Text('$tab $i')),
              ),
            ],
          );
        });
      }).toList(),
    ),
  ),
)
'''),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 9 — Pitfalls + API Cheat Sheet
// ═══════════════════════════════════════════════════════════════════════════════

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionHeading('Common Pitfalls'),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 1,
          title: 'Missing SliverOverlapInjector',
          severity: 'High',
          symptoms:
              'The first visible items in the inner list appear to start below '
              'the correct top — i.e., the top few items are hidden behind the '
              'pinned app bar. Scrolling down reveals them, but they cannot be '
              'reached by scrolling up.',
          fix: 'Add SliverOverlapInjector as the very first sliver in every '
              'inner CustomScrollView, using the handle from '
              'NestedScrollView.sliverOverlapAbsorberHandleFor(context).',
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 2,
          title: 'Multiple SliverOverlapAbsorbers for one NestedScrollView',
          severity: 'Medium',
          symptoms:
              'Overlap is counted multiple times. The inner list is pushed down '
              'by more than the actual header height, leaving a gap at the top '
              'of the inner scroll area. In debug mode, an assertion fires: '
              '"There are multiple SliverOverlapAbsorbers on the same handle."',
          fix: 'Use exactly ONE SliverOverlapAbsorber per NestedScrollView, '
              'wrapping the outermost SliverAppBar. Multiple inner tabs share '
              'the same absorber via the common handle.',
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          number: 3,
          title: 'shrinkWrap: true with NestedScrollView',
          severity: 'High',
          symptoms:
              'NestedScrollView does not support shrinkWrap. Using it with a '
              'shrinkWrap parent causes layout exceptions or infinite height '
              'constraint errors. The inner CustomScrollView also must not use '
              'shrinkWrap.',
          fix: 'Place NestedScrollView in a container with a bounded height '
              '(e.g., Expanded, SizedBox with a fixed height, or a full-screen '
              'Scaffold body). Never wrap it in a shrinkWrap ListView.',
        ),
        const SizedBox(height: 28),
        _SectionHeading('API Cheat Sheet'),
        const SizedBox(height: 12),
        _CheatSheetCard(cs: cs),
        const SizedBox(height: 28),
        _SectionHeading('Quick Checklist'),
        const SizedBox(height: 8),
        _ChecklistCard(),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number,
    required this.title,
    required this.severity,
    required this.symptoms,
    required this.fix,
  });

  final int number;
  final String title;
  final String severity;
  final String symptoms;
  final String fix;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    final Color severityColor =
        severity == 'High' ? cs.error : cs.tertiary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: cs.primaryContainer,
                  radius: 16,
                  child: Text('$number',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: cs.onPrimaryContainer)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: tt.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: severityColor, width: 1),
                  ),
                  child: Text(severity,
                      style: TextStyle(
                          color: severityColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Symptoms:', style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(symptoms, style: tt.bodySmall),
            const SizedBox(height: 10),
            Text('Fix:', style: tt.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.primary,
            )),
            const SizedBox(height: 4),
            Text(fix, style: tt.bodySmall?.copyWith(color: cs.primary)),
          ],
        ),
      ),
    );
  }
}

class _CheatSheetCard extends StatelessWidget {
  const _CheatSheetCard({required this.cs});
  final ColorScheme cs;

  static const List<List<String>> _rows = <List<String>>[
    <String>[
      'SliverOverlapAbsorber',
      'handle, sliver',
      'Outer headerSliverBuilder',
      'Wraps SliverAppBar; absorbs overlap into handle',
    ],
    <String>[
      'SliverOverlapInjector',
      'handle',
      'Top of each inner CustomScrollView',
      'Re-injects overlap as virtual sliver height',
    ],
    <String>[
      'NestedScrollViewViewport',
      'offset, handle, (all Viewport params)',
      'Created by NestedScrollView internally',
      'Inner viewport with overlap compensation',
    ],
    <String>[
      'NestedScrollView.sliverOverlapAbsorberHandleFor',
      'context (BuildContext)',
      'Inside Builder descendant of NestedScrollView',
      'Returns the shared SliverOverlapAbsorberHandle',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(4),
        },
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: cs.primaryContainer),
            children: <Widget>[
              _tableHeader('Class / Method'),
              _tableHeader('Key Params'),
              _tableHeader('Location'),
              _tableHeader('Purpose'),
            ],
          ),
          ..._rows.map(
            (r) => TableRow(children: r.map((c) => _tableData(c)).toList()),
          ),
        ],
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard();

  static const List<String> _items = <String>[
    'NestedScrollView is the root scroll widget',
    'headerSliverBuilder contains exactly ONE SliverOverlapAbsorber',
    'SliverOverlapAbsorber wraps the SliverAppBar',
    'Body uses DefaultTabController + TabBarView',
    'Each tab is wrapped in a Builder',
    'Each Builder → CustomScrollView has PageStorageKey',
    'SliverOverlapInjector is FIRST sliver in each CustomScrollView',
    'Injector and absorber share the same handle (from context)',
    'No shrinkWrap on any inner scroll',
    'No nested NestedScrollViews',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: _items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.check_circle_outline,
                          color: cs.primary, size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item, style: tt.bodySmall)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helper widgets
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.color,
    required this.child,
  });

  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 22),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.error),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.error_outline, color: cs.error, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onErrorContainer,
                    )),
                const SizedBox(height: 4),
                Text(body,
                    style:
                        tt.bodySmall?.copyWith(color: cs.onErrorContainer)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.title,
    required this.body,
  });

  final int index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: cs.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(body, style: tt.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code.trim(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: cs.onSurfaceVariant,
            height: 1.55,
          ),
        ),
      ),
    );
  }
}
