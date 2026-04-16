import 'package:flutter/material.dart';

// ─── Top-level ValueNotifiers ────────────────────────────────────────────────
final ValueNotifier<double> _outerOffset = ValueNotifier<double>(0);
final ValueNotifier<double> _innerOffset = ValueNotifier<double>(0);
final ValueNotifier<bool> _showFab = ValueNotifier<bool>(false);

// ─── GlobalKey for NestedScrollViewState access ───────────────────────────────
final GlobalKey<NestedScrollViewState> _nestedKey =
    GlobalKey<NestedScrollViewState>();

// ─── Tab labels (9 tabs required) ────────────────────────────────────────────
const List<String> _tabLabels = <String>[
  'Alpha',
  'Beta',
  'Gamma',
  'Delta',
  'Epsilon',
  'Zeta',
  'Eta',
  'Theta',
  'Iota',
];

// ─── Entry point ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: const _NestedScrollViewStateDemo(),
  );
}

// ─── Root demo widget ─────────────────────────────────────────────────────────
class _NestedScrollViewStateDemo extends StatelessWidget {
  const _NestedScrollViewStateDemo();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLabels.length,
      child: Scaffold(
        body: _buildBody(context),
        floatingActionButton: _ScrollToTopFab(nestedKey: _nestedKey),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // Determine which controller fired by checking the scroll context depth.
        // The inner controllers sit below the tab viewport; the outer one is
        // the SliverAppBar host.  We use the notification's depth: depth==0
        // means the innermost scrollable that is currently scrolling; the outer
        // SliverAppBar host fires at depth==1 from the TabBarView perspective.
        // A simpler heuristic: after the first frame we read directly.
        if (_nestedKey.currentState != null) {
          final NestedScrollViewState state = _nestedKey.currentState!;
          if (state.outerController.hasClients) {
            _outerOffset.value = state.outerController.offset;
            _showFab.value = state.outerController.offset > 40;
          }
          if (state.innerController.hasClients) {
            _innerOffset.value = state.innerController.offset;
          }
        }
        return false;
      },
      child: NestedScrollView(
        key: _nestedKey,
        headerSliverBuilder:
            (BuildContext ctx, bool innerBoxIsScrolled) =>
                _buildHeaderSlivers(ctx, innerBoxIsScrolled),
        body: TabBarView(
          children: List<Widget>.generate(
            _tabLabels.length,
            (int i) => _TabContent(tabIndex: i, label: _tabLabels[i]),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderSlivers(
    BuildContext context,
    bool innerBoxIsScrolled,
  ) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          expandedHeight: 260,
          floating: false,
          pinned: true,
          forceElevated: innerBoxIsScrolled,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('NestedScrollViewState'),
            background: _HeroBanner(),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabLabels
                .map((String l) => Tab(text: l))
                .toList(),
          ),
        ),
      ),
    ];
  }
}

// ─── Section 1: Hero Banner ───────────────────────────────────────────────────
class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            cs.primaryContainer,
            cs.secondaryContainer,
            cs.tertiaryContainer,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.layers, size: 32, color: cs.primary),
              const SizedBox(width: 12),
              Text(
                'NestedScrollViewState',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The State object of a NestedScrollView. '
            'Obtain it via a GlobalKey<NestedScrollViewState> attached to the '
            'NestedScrollView widget. It exposes two scroll controllers: '
            'outerController (the collapsing SliverAppBar host) and '
            'innerController (the active tab\'s inner ListView).',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSecondaryContainer,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: <Widget>[
              _HeroBadge(label: 'innerController', icon: Icons.arrow_downward),
              _HeroBadge(label: 'outerController', icon: Icons.arrow_upward),
              _HeroBadge(label: 'GlobalKey access', icon: Icons.vpn_key),
              _HeroBadge(label: 'programmatic scroll', icon: Icons.touch_app),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(icon, size: 14, color: cs.onPrimary),
      label: Text(label, style: const TextStyle(fontSize: 11)),
      backgroundColor: cs.primary,
      labelStyle: TextStyle(color: cs.onPrimary),
      visualDensity: VisualDensity.compact,
    );
  }
}

// ─── Tab Content (wraps all sections per tab) ─────────────────────────────────
class _TabContent extends StatelessWidget {
  const _TabContent({required this.tabIndex, required this.label});
  final int tabIndex;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext ctx) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            ),
            SliverToBoxAdapter(
              child: _buildTabPageContent(ctx, tabIndex, label),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabPageContent(
    BuildContext context,
    int index,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            title: 'Tab $label — index $index',
            icon: Icons.tab,
          ),
          const SizedBox(height: 12),

          // Section 2: Inner / Outer controller display (shown on tab 0)
          if (index == 0) ...<Widget>[
            _SectionHeader(
              title: 'Section 2 · Inner / Outer Controller Display',
              icon: Icons.swap_vert,
            ),
            const SizedBox(height: 8),
            _ControllerDisplay(),
            const SizedBox(height: 24),
          ],

          // Section 3: Scroll gauges (shown on tab 1)
          if (index == 1) ...<Widget>[
            _SectionHeader(
              title: 'Section 3 · Scroll Position Gauges',
              icon: Icons.show_chart,
            ),
            const SizedBox(height: 8),
            _ScrollGauges(),
            const SizedBox(height: 24),
          ],

          // Section 5: Programmatic inner scroll reset (shown on tab 2)
          if (index == 2) ...<Widget>[
            _SectionHeader(
              title: 'Section 5 · Programmatic Inner Scroll',
              icon: Icons.vertical_align_top,
            ),
            const SizedBox(height: 8),
            _InnerScrollControls(),
            const SizedBox(height: 24),
          ],

          // Section 6: CustomPainter diagram (shown on tab 3)
          if (index == 3) ...<Widget>[
            _SectionHeader(
              title: 'Section 6 · Structure Diagram',
              icon: Icons.account_tree,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 340,
              child: CustomPaint(
                painter: _NestedScrollDiagramPainter(),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Section 7: GlobalKey snippet (shown on tab 4)
          if (index == 4) ...<Widget>[
            _SectionHeader(
              title: 'Section 7 · GlobalKey Access Pattern',
              icon: Icons.vpn_key,
            ),
            const SizedBox(height: 8),
            _CodeSnippetCard(),
            const SizedBox(height: 24),
          ],

          // Section 8: Pitfalls (shown on tab 5)
          if (index == 5) ...<Widget>[
            _SectionHeader(
              title: 'Section 8 · Common Pitfalls',
              icon: Icons.warning_amber,
            ),
            const SizedBox(height: 8),
            _PitfallsTiles(),
            const SizedBox(height: 24),
          ],

          // Section 9: Comparison (shown on tab 6)
          if (index == 6) ...<Widget>[
            _SectionHeader(
              title: 'Section 9 · Comparison',
              icon: Icons.compare_arrows,
            ),
            const SizedBox(height: 8),
            _ComparisonTable(),
            const SizedBox(height: 24),
          ],

          // Section 10: API cheat sheet (shown on tab 7)
          if (index == 7) ...<Widget>[
            _SectionHeader(
              title: 'Section 10 · API Cheat Sheet',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 8),
            _ApiCheatSheet(),
            const SizedBox(height: 24),
          ],

          // Generic content tiles for every tab
          _SectionHeader(
            title: 'List content for tab $label',
            icon: Icons.list,
          ),
          const SizedBox(height: 8),
          ...List<Widget>.generate(
            20,
            (int i) => _ContentTile(index: i, tabLabel: label),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ─── Section 2: Controller display ───────────────────────────────────────────
class _ControllerDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Live controller offsets',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Updated via NotificationListener<ScrollNotification> wrapping '
              'the NestedScrollView. Reading _key.currentState!.outerController '
              'and .innerController directly.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<double>(
              valueListenable: _outerOffset,
              builder: (BuildContext ctx, double v, Widget? _) =>
                  _OffsetRow(
                    label: 'outerController.offset',
                    value: v,
                    maxValue: 260,
                    color: cs.primary,
                  ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<double>(
              valueListenable: _innerOffset,
              builder: (BuildContext ctx, double v, Widget? _) =>
                  _OffsetRow(
                    label: 'innerController.offset',
                    value: v,
                    maxValue: 800,
                    color: cs.secondary,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Scroll the outer SliverAppBar or the list content in any tab '
              'to see the values update here.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OffsetRow extends StatelessWidget {
  const _OffsetRow({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });
  final String label;
  final double value;
  final double maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double fraction = (value / maxValue).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label, style: const TextStyle(fontSize: 12)),
            Text(
              '${value.toStringAsFixed(1)} px',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 10,
            color: color,
            backgroundColor: color.withAlpha(40),
          ),
        ),
      ],
    );
  }
}

// ─── Section 3: Scroll gauges ─────────────────────────────────────────────────
class _ScrollGauges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Slider-style scroll position indicators',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _GaugeRow(
              label: 'Outer (SliverAppBar region)',
              notifier: _outerOffset,
              maxValue: 260,
              color: cs.primary,
            ),
            const SizedBox(height: 12),
            _GaugeRow(
              label: 'Inner (active tab ListView)',
              notifier: _innerOffset,
              maxValue: 1200,
              color: cs.tertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'The outer gauge maxes out at ~260 px (the SliverAppBar '
              'expandedHeight). The inner gauge reflects the active tab\'s '
              'ListView, which can scroll much further.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugeRow extends StatelessWidget {
  const _GaugeRow({
    required this.label,
    required this.notifier,
    required this.maxValue,
    required this.color,
  });
  final String label;
  final ValueNotifier<double> notifier;
  final double maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        ValueListenableBuilder<double>(
          valueListenable: notifier,
          builder: (BuildContext ctx, double v, Widget? _) {
            return Column(
              children: <Widget>[
                SliderTheme(
                  data: SliderTheme.of(ctx).copyWith(
                    trackHeight: 8,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 0),
                    activeTrackColor: color,
                    thumbColor: color,
                    inactiveTrackColor: color.withAlpha(40),
                  ),
                  child: Slider(
                    value: v.clamp(0.0, maxValue),
                    min: 0,
                    max: maxValue,
                    onChanged: null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '0 px',
                      style: TextStyle(fontSize: 10, color: color),
                    ),
                    Text(
                      '${v.toStringAsFixed(0)} / ${maxValue.toStringAsFixed(0)} px',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      '${maxValue.toStringAsFixed(0)} px',
                      style: TextStyle(fontSize: 10, color: color),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ─── Section 4: FAB (scroll-to-top) ──────────────────────────────────────────
class _ScrollToTopFab extends StatelessWidget {
  const _ScrollToTopFab({required this.nestedKey});
  final GlobalKey<NestedScrollViewState> nestedKey;

  void _scrollToTop() {
    final NestedScrollViewState? state = nestedKey.currentState;
    if (state == null) {
      return;
    }
    if (state.outerController.hasClients) {
      state.outerController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
    if (state.innerController.hasClients) {
      state.innerController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showFab,
      builder: (BuildContext ctx, bool show, Widget? _) {
        return AnimatedOpacity(
          opacity: show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton.extended(
            onPressed: show ? _scrollToTop : null,
            icon: const Icon(Icons.vertical_align_top),
            label: const Text('Back to top'),
            tooltip: 'Calls outerController.animateTo(0) + innerController.animateTo(0)',
          ),
        );
      },
    );
  }
}

// ─── Section 5: Inner scroll controls ────────────────────────────────────────
class _InnerScrollControls extends StatelessWidget {
  void _resetInner() {
    final NestedScrollViewState? state = _nestedKey.currentState;
    if (state == null) {
      return;
    }
    if (state.innerController.hasClients) {
      state.innerController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _jumpToMiddle() {
    final NestedScrollViewState? state = _nestedKey.currentState;
    if (state == null) {
      return;
    }
    if (state.innerController.hasClients) {
      final double max =
          state.innerController.position.maxScrollExtent;
      state.innerController.animateTo(
        max / 2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _jumpToBottom() {
    final NestedScrollViewState? state = _nestedKey.currentState;
    if (state == null) {
      return;
    }
    if (state.innerController.hasClients) {
      state.innerController.animateTo(
        state.innerController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Programmatic inner scroll',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Uses _nestedKey.currentState!.innerController.animateTo(…). '
              'The innerController always refers to the currently active tab.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _resetInner,
                  icon: const Icon(Icons.vertical_align_top, size: 16),
                  label: const Text('Reset to top'),
                ),
                FilledButton.tonal(
                  onPressed: _jumpToMiddle,
                  child: const Text('Jump to middle'),
                ),
                FilledButton.tonal(
                  onPressed: _jumpToBottom,
                  child: const Text('Jump to bottom'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<double>(
              valueListenable: _innerOffset,
              builder: (BuildContext ctx, double v, Widget? _) => Text(
                'Current innerController.offset: ${v.toStringAsFixed(1)} px',
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onPrimaryContainer,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section 6: Structure diagram (CustomPainter) ────────────────────────────
class _NestedScrollDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = const Color(0xFF555555);

    // Outer scroll region box
    fillPaint.color = const Color(0xFFE8EAF6);
    borderPaint.color = const Color(0xFF3949AB);
    final Rect outerRect = Rect.fromLTWH(16, 16, size.width - 32, 130);
    canvas.drawRRect(
      RRect.fromRectAndRadius(outerRect, const Radius.circular(10)),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(outerRect, const Radius.circular(10)),
      borderPaint,
    );

    _drawLabel(
      canvas,
      'Outer Scroll Region',
      Offset(outerRect.left + 10, outerRect.top + 8),
      const Color(0xFF1A237E),
      fontSize: 12,
      bold: true,
    );
    _drawLabel(
      canvas,
      'SliverAppBar (collapsing header)',
      Offset(outerRect.left + 14, outerRect.top + 28),
      const Color(0xFF283593),
      fontSize: 11,
    );
    _drawLabel(
      canvas,
      'outerController ← managed by NestedScrollViewState',
      Offset(outerRect.left + 14, outerRect.top + 50),
      const Color(0xFF3949AB),
      fontSize: 10,
    );
    _drawLabel(
      canvas,
      'TabBar (pinned at the bottom of the SliverAppBar)',
      Offset(outerRect.left + 14, outerRect.top + 70),
      const Color(0xFF283593),
      fontSize: 10,
    );

    // Connecting arrow
    final double arrowY = outerRect.bottom + 4;
    final double midX = size.width / 2;
    canvas.drawLine(Offset(midX, arrowY), Offset(midX, arrowY + 14), arrowPaint);
    _drawArrowHead(canvas, Offset(midX, arrowY + 14), arrowPaint);

    // Inner scroll region box
    fillPaint.color = const Color(0xFFE8F5E9);
    borderPaint.color = const Color(0xFF2E7D32);
    final Rect innerRect = Rect.fromLTWH(
      16,
      outerRect.bottom + 20,
      size.width - 32,
      140,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(innerRect, const Radius.circular(10)),
      fillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(innerRect, const Radius.circular(10)),
      borderPaint,
    );

    _drawLabel(
      canvas,
      'Inner Scroll Region (TabBarView body)',
      Offset(innerRect.left + 10, innerRect.top + 8),
      const Color(0xFF1B5E20),
      fontSize: 12,
      bold: true,
    );
    _drawLabel(
      canvas,
      'innerController ← active tab\'s ScrollController',
      Offset(innerRect.left + 14, innerRect.top + 28),
      const Color(0xFF2E7D32),
      fontSize: 10,
    );
    _drawLabel(
      canvas,
      'Tab 0: ListView (items 0..n)',
      Offset(innerRect.left + 14, innerRect.top + 48),
      const Color(0xFF388E3C),
      fontSize: 10,
    );
    _drawLabel(
      canvas,
      'Tab 1: ListView (items 0..n)',
      Offset(innerRect.left + 14, innerRect.top + 64),
      const Color(0xFF388E3C),
      fontSize: 10,
    );
    _drawLabel(
      canvas,
      '…',
      Offset(innerRect.left + 14, innerRect.top + 80),
      const Color(0xFF388E3C),
      fontSize: 10,
    );
    _drawLabel(
      canvas,
      'Tab 8: ListView (items 0..n)',
      Offset(innerRect.left + 14, innerRect.top + 94),
      const Color(0xFF388E3C),
      fontSize: 10,
    );

    // GlobalKey pointer line
    fillPaint.color = const Color(0xFFFFF9C4);
    borderPaint.color = const Color(0xFFF9A825);
    final Rect keyRect = Rect.fromLTWH(
      16,
      innerRect.bottom + 20,
      size.width - 32,
      44,
    );
    if (keyRect.bottom <= size.height - 8) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(keyRect, const Radius.circular(8)),
        fillPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(keyRect, const Radius.circular(8)),
        borderPaint,
      );
      _drawLabel(
        canvas,
        'GlobalKey<NestedScrollViewState> _key',
        Offset(keyRect.left + 10, keyRect.top + 6),
        const Color(0xFFE65100),
        fontSize: 11,
        bold: true,
      );
      _drawLabel(
        canvas,
        '_key.currentState!.outerController   |   _key.currentState!.innerController',
        Offset(keyRect.left + 10, keyRect.top + 24),
        const Color(0xFFBF360C),
        fontSize: 9.5,
      );
    }
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset offset,
    Color color, {
    double fontSize = 11,
    bool bold = false,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  void _drawArrowHead(Canvas canvas, Offset tip, Paint paint) {
    final Path path = Path()
      ..moveTo(tip.dx - 5, tip.dy - 8)
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(tip.dx + 5, tip.dy - 8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NestedScrollDiagramPainter oldDelegate) => false;
}

// ─── Section 7: GlobalKey code snippet ───────────────────────────────────────
class _CodeSnippetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final List<_CodeLine> lines = <_CodeLine>[
      _CodeLine('// 1. Declare the key at widget scope or top-level', cs.outline),
      _CodeLine(
        'final GlobalKey<NestedScrollViewState> _key =',
        cs.onSurface,
      ),
      _CodeLine('    GlobalKey<NestedScrollViewState>();', cs.onSurface),
      _CodeLine('', cs.onSurface),
      _CodeLine('// 2. Attach it to the NestedScrollView', cs.outline),
      _CodeLine('NestedScrollView(', cs.tertiary),
      _CodeLine('  key: _key,', cs.onSurface),
      _CodeLine('  headerSliverBuilder: (ctx, innerScrolled) => [...],', cs.onSurface),
      _CodeLine('  body: TabBarView(children: [...]),', cs.onSurface),
      _CodeLine(')', cs.tertiary),
      _CodeLine('', cs.onSurface),
      _CodeLine('// 3. Access the state after the first frame', cs.outline),
      _CodeLine('final state = _key.currentState!;', cs.onSurface),
      _CodeLine('final outer = state.outerController;  // SliverAppBar host', cs.primary),
      _CodeLine('final inner = state.innerController;  // active tab body', cs.secondary),
      _CodeLine('', cs.onSurface),
      _CodeLine('// 4. Scroll programmatically', cs.outline),
      _CodeLine('outer.animateTo(0,', cs.onSurface),
      _CodeLine('  duration: Duration(milliseconds: 400),', cs.onSurface),
      _CodeLine('  curve: Curves.easeOut,', cs.onSurface),
      _CodeLine(');', cs.onSurface),
    ];

    return Card(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.code, size: 18, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  'GlobalKey access pattern',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lines
                    .map(
                      (l) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          l.text,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: l.color,
                            height: 1.6,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeLine {
  const _CodeLine(this.text, this.color);
  final String text;
  final Color color;
}

// ─── Section 8: Pitfalls ─────────────────────────────────────────────────────
class _PitfallsTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PitfallData> pitfalls = <_PitfallData>[
      _PitfallData(
        title: 'Reading state before the first frame',
        description:
            '_key.currentState is null until the widget is mounted. '
            'Never access it in initState() or during the build that creates '
            'the NestedScrollView. Use addPostFrameCallback or an '
            'onPressed handler (which only runs after the first frame).',
        icon: Icons.timer_off,
        severity: 'High',
      ),
      _PitfallData(
        title: 'innerController refers to the wrong tab',
        description:
            'innerController tracks the currently visible tab. '
            'Switching tabs updates it. Do not cache the controller object '
            'across tab switches — always read it fresh from currentState. '
            'Calling animateTo on a stale reference throws a '
            '"ScrollController not attached to any scroll views" assertion.',
        icon: Icons.tab_unselected,
        severity: 'Medium',
      ),
      _PitfallData(
        title: 'Missing SliverOverlapAbsorber / SliverOverlapInjector',
        description:
            'Without SliverOverlapAbsorber in the headerSliverBuilder and a '
            'matching SliverOverlapInjector at the top of each tab\'s '
            'CustomScrollView, the tab content will overlap the SliverAppBar. '
            'Use NestedScrollView.sliverOverlapAbsorberHandleFor(context) to '
            'share the handle between absorber and injector.',
        icon: Icons.layers_clear,
        severity: 'High',
      ),
    ];

    return Column(
      children: pitfalls
          .map((p) => _PitfallCard(data: p))
          .toList(),
    );
  }
}

class _PitfallData {
  const _PitfallData({
    required this.title,
    required this.description,
    required this.icon,
    required this.severity,
  });
  final String title;
  final String description;
  final IconData icon;
  final String severity;
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.data});
  final _PitfallData data;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final bool isHigh = data.severity == 'High';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isHigh ? cs.errorContainer : cs.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              data.icon,
              size: 28,
              color: isHigh ? cs.error : cs.secondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isHigh
                                ? cs.onErrorContainer
                                : cs.onSecondaryContainer,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isHigh ? cs.error : cs.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          data.severity,
                          style: TextStyle(
                            fontSize: 10,
                            color: isHigh ? cs.onError : cs.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isHigh
                          ? cs.onErrorContainer
                          : cs.onSecondaryContainer,
                      height: 1.5,
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

// ─── Section 9: Comparison table ─────────────────────────────────────────────
class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final List<_ComparisonRow> rows = <_ComparisonRow>[
      _ComparisonRow(
        aspect: 'Widget',
        nestedScrollView: 'NestedScrollView',
        customScrollView: 'CustomScrollView + pinned SliverAppBar',
        coordinatedScroll: 'CoordinatedScrollView (custom)',
      ),
      _ComparisonRow(
        aspect: 'State access',
        nestedScrollView: 'GlobalKey<NestedScrollViewState>',
        customScrollView: 'External ScrollController',
        coordinatedScroll: 'External controllers, manual sync',
      ),
      _ComparisonRow(
        aspect: 'Controllers',
        nestedScrollView: 'outerController + innerController (auto)',
        customScrollView: 'Single ScrollController',
        coordinatedScroll: 'Multiple manually linked controllers',
      ),
      _ComparisonRow(
        aspect: 'Tab support',
        nestedScrollView: 'Built-in via TabBarView body',
        customScrollView: 'Manual — no built-in tab integration',
        coordinatedScroll: 'Manual — full custom logic',
      ),
      _ComparisonRow(
        aspect: 'SliverOverlap handling',
        nestedScrollView: 'Required: Absorber + Injector pair',
        customScrollView: 'Not needed — single scroll physics',
        coordinatedScroll: 'Manual per design',
      ),
      _ComparisonRow(
        aspect: 'Complexity',
        nestedScrollView: 'Medium — framework does the linking',
        customScrollView: 'Low — single scroll physics',
        coordinatedScroll: 'High — fully manual',
      ),
      _ComparisonRow(
        aspect: 'Use case',
        nestedScrollView: 'Tab + collapsing header pattern',
        customScrollView: 'Single-page slivers without tabs',
        coordinatedScroll: 'Fully custom advanced layouts',
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(cs.primaryContainer),
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              'Aspect',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'NestedScrollView',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'CustomScrollView +\npinned SliverAppBar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'CoordinatedScrollView\n(custom)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
        ],
        rows: rows
            .map(
              (r) => DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(
                      r.aspect,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(r.nestedScrollView, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(r.customScrollView, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(r.coordinatedScroll, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ComparisonRow {
  const _ComparisonRow({
    required this.aspect,
    required this.nestedScrollView,
    required this.customScrollView,
    required this.coordinatedScroll,
  });
  final String aspect;
  final String nestedScrollView;
  final String customScrollView;
  final String coordinatedScroll;
}

// ─── Section 10: API cheat sheet ─────────────────────────────────────────────
class _ApiCheatSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_ApiEntry> entries = <_ApiEntry>[
      _ApiEntry(
        member: 'outerController',
        type: 'ScrollController',
        description:
            'Controls the outer scroll position (SliverAppBar expansion). '
            'Reading .offset gives the amount the header has collapsed. '
            'Always check .hasClients before accessing .offset or calling '
            'animateTo. This controller drives the collapsing effect.',
        lifecycle: 'Available after first frame. Remains stable for the life of the NestedScrollView.',
      ),
      _ApiEntry(
        member: 'innerController',
        type: 'ScrollController',
        description:
            'Controls the inner scroll position (the active tab\'s body). '
            'Points to the currently visible tab. Switches automatically when '
            'the user swipes between tabs. animateTo(0) resets the tab list '
            'to the top.',
        lifecycle: 'Switches when the active tab changes. Re-check hasClients after tab switch.',
      ),
      _ApiEntry(
        member: 'State lifecycle',
        type: 'NestedScrollViewState',
        description:
            'Created when NestedScrollView is first mounted. Accessible via '
            '_key.currentState after the first frame. Destroyed when the '
            'NestedScrollView is removed from the tree. Both controllers are '
            'disposed automatically by the framework.',
        lifecycle: 'initState → build → first frame → accessible → dispose',
      ),
      _ApiEntry(
        member: 'sliverOverlapAbsorberHandleFor',
        type: 'SliverOverlapAbsorberHandle',
        description:
            'Static method on NestedScrollView. Returns the handle for a '
            'given BuildContext. Pass to SliverOverlapAbsorber in the header '
            'and SliverOverlapInjector in each tab body. Ensures tab content '
            'is not hidden under the SliverAppBar.',
        lifecycle: 'Used at build time inside headerSliverBuilder and each tab.',
      ),
      _ApiEntry(
        member: 'animateTo(offset, duration, curve)',
        type: 'ScrollController',
        description:
            'Smoothly scrolls to a given pixel offset. Use on outerController '
            'to collapse/expand the header, or on innerController to scroll '
            'the list. Requires .hasClients to be true. Returns a Future that '
            'completes when the animation finishes.',
        lifecycle: 'Runtime. Requires mounted controller with at least one attached position.',
      ),
      _ApiEntry(
        member: 'jumpTo(offset)',
        type: 'ScrollController',
        description:
            'Instantly jumps to an offset without animation. Useful for '
            'imperatively restoring a scroll position (e.g. on tab-switch). '
            'Same .hasClients precondition as animateTo.',
        lifecycle: 'Runtime. Synchronous — completes immediately.',
      ),
    ];

    return Column(
      children: entries
          .map(
            (e) => _ApiEntryCard(entry: e),
          )
          .toList(),
    );
  }
}

class _ApiEntry {
  const _ApiEntry({
    required this.member,
    required this.type,
    required this.description,
    required this.lifecycle,
  });
  final String member;
  final String type;
  final String description;
  final String lifecycle;
}

class _ApiEntryCard extends StatelessWidget {
  const _ApiEntryCard({required this.entry});
  final _ApiEntry entry;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    entry.member,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    entry.type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: cs.onTertiaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.description, style: const TextStyle(fontSize: 12, height: 1.5)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.schedule, size: 14, color: cs.outline),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      entry.lifecycle,
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.outline,
                        fontStyle: FontStyle.italic,
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

// ─── Shared helpers ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Icon(icon, size: 20, color: cs.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
        ),
        Container(
          height: 2,
          width: 40,
          color: cs.primary.withAlpha(80),
        ),
      ],
    );
  }
}

class _ContentTile extends StatelessWidget {
  const _ContentTile({required this.index, required this.tabLabel});
  final int index;
  final String tabLabel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final List<Color> palette = <Color>[
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.surfaceContainerHighest,
    ];
    final Color bg = palette[index % palette.length];
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: bg,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.primary,
          child: Text(
            '$index',
            style: TextStyle(color: cs.onPrimary, fontSize: 13),
          ),
        ),
        title: Text(
          'Tab $tabLabel — item $index',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Scroll this list to exercise innerController. '
          'The position gauge on tab Beta updates as you scroll.',
          style: const TextStyle(fontSize: 11),
        ),
        trailing: Icon(Icons.drag_handle, color: cs.outline),
      ),
    );
  }
}
