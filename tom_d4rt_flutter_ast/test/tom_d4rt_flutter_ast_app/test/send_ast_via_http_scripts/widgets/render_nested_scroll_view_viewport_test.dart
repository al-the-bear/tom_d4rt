import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (stateless, no StatefulWidget)
// ---------------------------------------------------------------------------
final ValueNotifier<double> _overlapExtent = ValueNotifier<double>(0.0);
final ValueNotifier<double> _overlapExtent2 = ValueNotifier<double>(0.0);

// ---------------------------------------------------------------------------
// Entry point required by the harness
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return _RenderNestedScrollViewViewportDemo();
}

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------
class _RenderNestedScrollViewViewportDemo extends StatelessWidget {
  const _RenderNestedScrollViewViewportDemo();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90D9)),
      ),
      home: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('RenderNestedScrollViewViewport'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: <Widget>[
                Tab(text: 'Hero'),
                Tab(text: 'Live NSV'),
                Tab(text: 'Budget Diagram'),
                Tab(text: 'Extent Gauge'),
                Tab(text: 'Inheritance'),
                Tab(text: 'Correct vs Bug'),
                Tab(text: 'API Surface'),
                Tab(text: 'Scroll Timeline'),
                Tab(text: 'Pitfalls'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              _HeroTab(),
              _LiveNestedScrollViewTab(),
              _BudgetDiagramTab(),
              _ExtentGaugeTab(),
              _InheritanceTab(),
              _CorrectVsBugTab(),
              _ApiSurfaceTab(),
              _ScrollTimelineTab(),
              _PitfallsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Hero banner
// ===========================================================================
class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── gradient banner ────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.layers_rounded, size: 48, color: cs.onPrimary),
                const SizedBox(height: 12),
                Text(
                  'RenderNestedScrollViewViewport',
                  style: tt.headlineSmall?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The RenderObject that powers NestedScrollView\'s inner viewport.',
                  style: tt.bodyLarge?.copyWith(color: cs.onPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── what it is ────────────────────────────────────────────────
          _SectionTitle(
            icon: Icons.info_outline,
            label: 'What is RenderNestedScrollViewViewport?',
          ),
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RenderNestedScrollViewViewport is the concrete RenderObject '
                  'used internally by NestedScrollView for its inner (body) '
                  'viewport. It extends RenderViewport and adds one critical '
                  'extra responsibility: it holds a reference to a '
                  'SliverOverlapAbsorberHandle.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'The handle is a shared bookkeeping object. When the outer '
                  'scroll view\'s SliverOverlapAbsorber performs layout, it '
                  'records how many pixels of the pinned/floating SliverAppBar '
                  'overlap the inner viewport into handle.extent. The inner '
                  'viewport then exposes that value so that a '
                  'SliverOverlapInjector can reintroduce an equivalent gap at '
                  'the top of the inner sliver list, preventing content from '
                  'being hidden behind the floating header.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── class location ────────────────────────────────────────────
          _SectionTitle(icon: Icons.folder_outlined, label: 'Where to find it'),
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _MonoLine('flutter/src/widgets/nested_scroll_view.dart'),
                const SizedBox(height: 8),
                Text(
                  'It is a private-ish framework class. You interact with it '
                  'indirectly through NestedScrollView, SliverOverlapAbsorber, '
                  'SliverOverlapInjector, and SliverOverlapAbsorberHandle.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── educational disclaimer ────────────────────────────────────
          _SectionTitle(
            icon: Icons.school_outlined,
            label: 'Educational nature of this demo',
          ),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.lightbulb_outline,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Because RenderNestedScrollViewViewport is a framework '
                      'internals class not directly instantiated in user code, '
                      'this demo teaches its concepts through observable '
                      'NestedScrollView behavior, live overlap-handle '
                      'measurements, custom painters, and side-by-side '
                      'correct-vs-incorrect examples.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── key concepts grid ─────────────────────────────────────────
          _SectionTitle(
            icon: Icons.grid_view_rounded,
            label: 'Key concepts at a glance',
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: const <Widget>[
              _ConceptTile(
                icon: Icons.swap_vert,
                title: 'Overlap Handle',
                body: 'Shared state: absorber writes, injector reads.',
              ),
              _ConceptTile(
                icon: Icons.link,
                title: 'handle.extent',
                body: 'Pixels of header overlapping the body viewport.',
              ),
              _ConceptTile(
                icon: Icons.tune,
                title: 'Extends RenderViewport',
                body: 'All RenderViewport layout & painting logic applies.',
              ),
              _ConceptTile(
                icon: Icons.sync_alt,
                title: 'Scroll Coordination',
                body: 'Outer header ↔ inner list via SliverPhysics delegates.',
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Live NestedScrollView with overlap handle badge
// ===========================================================================
class _LiveNestedScrollViewTab extends StatelessWidget {
  const _LiveNestedScrollViewTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Column(
      children: <Widget>[
        // explanation strip
        Container(
          width: double.infinity,
          color: cs.surfaceContainerHighest,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Scroll the list. The badge shows handle.extent tracked via '
                  'ScrollNotification.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              _LiveNSV(overlapNotifier: _overlapExtent),
              // floating badge
              Positioned(
                top: 8,
                right: 12,
                child: ValueListenableBuilder<double>(
                  valueListenable: _overlapExtent,
                  builder: (BuildContext ctx, double val, Widget? _) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 120),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'handle.extent  ${val.toStringAsFixed(1)} px',
                        style: Theme.of(ctx).textTheme.labelMedium?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LiveNSV extends StatelessWidget {
  const _LiveNSV({required this.overlapNotifier});
  final ValueNotifier<double> overlapNotifier;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification note) {
        // Approximate handle.extent from the shrinking SliverAppBar:
        // When pinned+floating, extent ≈ expanded height - current scroll
        // We read it from the metrics of the outer scroll position.
        if (note is ScrollUpdateNotification &&
            note.metrics.axis == Axis.vertical) {
          final double raw = note.metrics.extentBefore;
          // clamp to [0, 200] — the expandedHeight of our SliverAppBar
          overlapNotifier.value = raw.clamp(0.0, 200.0);
        }
        return false;
      },
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverAppBar(
                title: const Text('Live NestedScrollView'),
                expandedHeight: 200,
                pinned: true,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.expand, color: Colors.white, size: 32),
                          SizedBox(height: 8),
                          Text(
                            'Expand / Collapse Me',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Text('${index + 1}'),
                        ),
                        title: Text('Inner list item ${index + 1}'),
                        subtitle: Text(
                          'Scroll position drives handle.extent via absorber',
                        ),
                      );
                    },
                    childCount: 40,
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

// ===========================================================================
// TAB 3 — Overlap budget diagram (CustomPainter)
// ===========================================================================
class _BudgetDiagramTab extends StatelessWidget {
  const _BudgetDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.account_tree_outlined,
            label: 'Overlap Budget: Render-Level Flow',
          ),
          Text(
            'The diagram below shows how overlap budget flows from the '
            'SliverAppBar through the absorber handle into '
            'RenderNestedScrollViewViewport, and finally back via the injector.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 420,
            child: CustomPaint(
              painter: _BudgetFlowPainter(cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.description_outlined,
            label: 'Step-by-step explanation',
          ),
          _StepCard(
            step: 1,
            title: 'SliverAppBar lays out',
            body: 'The pinned/floating SliverAppBar occupies N pixels at the '
                'top of the outer CustomScrollView.',
          ),
          _StepCard(
            step: 2,
            title: 'SliverOverlapAbsorber records overlap',
            body: 'During performLayout, it writes the overlap amount into '
                'handle.extent. This is the pixel count that the header '
                '"steals" from the inner scroll area.',
          ),
          _StepCard(
            step: 3,
            title: 'RenderNestedScrollViewViewport receives the handle',
            body: 'The handle is set on the RenderObject. It does not paint '
                'or clip based on the handle directly — it simply makes the '
                'value available to child slivers.',
          ),
          _StepCard(
            step: 4,
            title: 'SliverOverlapInjector restores the gap',
            body: 'Inside the inner CustomScrollView (body), the injector '
                'reads handle.extent and produces a phantom sliver of that '
                'height, pushing real content below the header.',
          ),
          _StepCard(
            step: 5,
            title: 'Inner content is fully visible',
            body: 'Because the injector gap equals the absorber overlap, '
                'nothing is hidden behind the floating header.',
          ),
        ],
      ),
    );
  }
}

class _BudgetFlowPainter extends CustomPainter {
  const _BudgetFlowPainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double boxW = 220;
    const double boxH = 48;
    const double gapY = 28;
    const double startY = 20;

    final List<String> labels = <String>[
      'SliverAppBar\n(outer header)',
      'SliverOverlapAbsorber\nwrites → handle.extent',
      'RenderNestedScrollViewViewport\nholds the handle',
      'SliverOverlapInjector\nreads ← handle.extent',
      'Inner sliver content\n(correctly offset)',
    ];

    final List<Color> boxColors = <Color>[
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.secondaryContainer,
      cs.primaryContainer,
    ];

    final Paint fillPaint = Paint()..style = PaintingStyle.fill;
    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint arrowPaint = Paint()
      ..color = cs.outline
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < labels.length; i++) {
      final double y = startY + i * (boxH + gapY);
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, y + boxH / 2),
        width: boxW,
        height: boxH,
      );
      final RRect rRect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(8),
      );

      fillPaint.color = boxColors[i];
      strokePaint.color = cs.outline.withValues(alpha: 0.4);

      canvas.drawRRect(rRect, fillPaint);
      canvas.drawRRect(rRect, strokePaint);

      // label
      final TextSpan span = TextSpan(
        text: labels[i],
        style: TextStyle(
          fontSize: 11,
          color: cs.onSurface,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 16);
      tp.paint(
        canvas,
        Offset(
          cx - tp.width / 2,
          y + boxH / 2 - tp.height / 2,
        ),
      );

      // arrow to next box
      if (i < labels.length - 1) {
        final double arrowTop = y + boxH + 4;
        final double arrowBot = arrowTop + gapY - 8;
        canvas.drawLine(
          Offset(cx, arrowTop),
          Offset(cx, arrowBot),
          arrowPaint,
        );
        // arrowhead
        final Path head = Path()
          ..moveTo(cx - 6, arrowBot - 8)
          ..lineTo(cx, arrowBot)
          ..lineTo(cx + 6, arrowBot - 8);
        canvas.drawPath(head, arrowPaint);
      }
    }

    // side annotation: overlap budget label
    final double midY =
        startY + 1 * (boxH + gapY) + boxH / 2 + (boxH + gapY) / 2;
    final TextSpan budgetSpan = TextSpan(
      text: 'overlap\nbudget',
      style: TextStyle(
        fontSize: 10,
        color: cs.primary,
        fontWeight: FontWeight.bold,
      ),
    );
    final TextPainter btp = TextPainter(
      text: budgetSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    btp.paint(canvas, Offset(cx + boxW / 2 + 12, midY - btp.height / 2));

    // horizontal brace line
    final Paint bracePaint = Paint()
      ..color = cs.primary
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final double braceX = cx + boxW / 2 + 8;
    canvas.drawLine(
      Offset(braceX, startY + boxH),
      Offset(braceX, startY + 2 * (boxH + gapY)),
      bracePaint,
    );
  }

  @override
  bool shouldRepaint(_BudgetFlowPainter old) => old.cs != cs;
}

// ===========================================================================
// TAB 4 — Handle extent visualizer (gauge)
// ===========================================================================
class _ExtentGaugeTab extends StatelessWidget {
  const _ExtentGaugeTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Scroll the NestedScrollView below. The gauge card tracks the '
            'approximate handle.extent in real time.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        // Gauge card
        Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<double>(
            valueListenable: _overlapExtent2,
            builder: (BuildContext ctx, double val, Widget? _) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Current handle.extent',
                        style: Theme.of(ctx).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: val / 200.0,
                                minHeight: 20,
                                backgroundColor: Theme.of(
                                  ctx,
                                ).colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(ctx).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 72,
                            child: Text(
                              '${val.toStringAsFixed(1)} px',
                              style: Theme.of(
                                ctx,
                              ).textTheme.titleMedium?.copyWith(
                                fontFamily: 'monospace',
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '0 px',
                            style: Theme.of(ctx).textTheme.bodySmall,
                          ),
                          Text(
                            '200 px (expandedHeight)',
                            style: Theme.of(ctx).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _HandleStateChip(extent: val),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification note) {
              if (note is ScrollUpdateNotification &&
                  note.metrics.axis == Axis.vertical) {
                _overlapExtent2.value =
                    note.metrics.extentBefore.clamp(0.0, 200.0);
              }
              return false;
            },
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    sliver: SliverAppBar(
                      title: const Text('Gauge Demo'),
                      expandedHeight: 200,
                      pinned: true,
                      floating: false,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          color: Theme.of(context).colorScheme.tertiary,
                          child: const Center(
                            child: Text(
                              'Scroll down to reduce extent',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
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
                        handle:
                            NestedScrollView.sliverOverlapAbsorberHandleFor(
                              ctx,
                            ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ListTile(
                              leading: const Icon(Icons.drag_handle),
                              title: Text('Item $index'),
                            );
                          },
                          childCount: 30,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HandleStateChip extends StatelessWidget {
  const _HandleStateChip({required this.extent});
  final double extent;

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color color;
    final IconData icon;

    if (extent >= 190) {
      label = 'Fully expanded — max overlap';
      color = Colors.orange;
      icon = Icons.expand;
    } else if (extent <= 10) {
      label = 'Collapsed — zero overlap';
      color = Colors.green;
      icon = Icons.compress;
    } else {
      label = 'Transitioning — partial overlap';
      color = Theme.of(context).colorScheme.primary;
      icon = Icons.swap_vert;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
    );
  }
}

// ===========================================================================
// TAB 5 — RenderViewport inheritance chain
// ===========================================================================
class _InheritanceTab extends StatelessWidget {
  const _InheritanceTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final List<_InheritanceNode> chain = <_InheritanceNode>[
      _InheritanceNode(
        name: 'RenderObject',
        subtitle: 'Base: hit testing, semantics, scheduling',
        color: cs.surfaceContainerHighest,
      ),
      _InheritanceNode(
        name: 'RenderBox',
        subtitle: 'Adds: constraints → size, local coords',
        color: cs.primaryContainer.withValues(alpha: 0.4),
      ),
      _InheritanceNode(
        name: 'RenderAbstractViewport',
        subtitle: 'Mixin: getOffsetToReveal, viewport interface',
        color: cs.primaryContainer.withValues(alpha: 0.6),
      ),
      _InheritanceNode(
        name: 'RenderViewport',
        subtitle: 'Adds: anchor, offset, sliver layout, clip',
        color: cs.primaryContainer.withValues(alpha: 0.8),
      ),
      _InheritanceNode(
        name: 'RenderNestedScrollViewViewport',
        subtitle: 'Adds: SliverOverlapAbsorberHandle, handle.extent',
        color: cs.primary,
        isTarget: true,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.account_tree,
            label: 'RenderObject Inheritance Chain',
          ),
          const SizedBox(height: 8),
          Text(
            'Each level adds capabilities. RenderNestedScrollViewViewport '
            'only adds handle management on top of RenderViewport.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < chain.length; i++) ...<Widget>[
            _InheritanceTile(
              node: chain[i],
              level: i,
              isLast: i == chain.length - 1,
            ),
            if (i < chain.length - 1) ...<Widget>[
              Padding(
                padding: EdgeInsets.only(left: 24.0 + i * 12),
                child: Icon(Icons.south, size: 20, color: cs.outline),
              ),
            ],
          ],
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.difference_outlined,
            label: 'What RenderNestedScrollViewViewport adds',
          ),
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _BulletPoint(
                  'A handle property of type SliverOverlapAbsorberHandle.',
                ),
                _BulletPoint(
                  'Override of markNeedsLayout() — calls handle._markNeedsLayout() '
                  'to schedule layout on handle listeners when the handle changes.',
                ),
                _BulletPoint(
                  'No additional painting or hit-testing — all inherited from '
                  'RenderViewport.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            icon: Icons.code,
            label: 'Conceptual pseudo-code',
          ),
          _CodeBlock(
            '''class RenderNestedScrollViewViewport extends RenderViewport {
  SliverOverlapAbsorberHandle get handle => _handle;
  SliverOverlapAbsorberHandle _handle;

  set handle(SliverOverlapAbsorberHandle value) {
    if (_handle == value) return;
    _handle.removeListener(markNeedsLayout);
    _handle = value;
    _handle.addListener(markNeedsLayout);
    markNeedsLayout();
  }

  @override
  void dispose() {
    _handle.removeListener(markNeedsLayout);
    super.dispose();
  }
}''',
          ),
        ],
      ),
    );
  }
}

class _InheritanceNode {
  const _InheritanceNode({
    required this.name,
    required this.subtitle,
    required this.color,
    this.isTarget = false,
  });
  final String name;
  final String subtitle;
  final Color color;
  final bool isTarget;
}

class _InheritanceTile extends StatelessWidget {
  const _InheritanceTile({
    required this.node,
    required this.level,
    required this.isLast,
  });
  final _InheritanceNode node;
  final int level;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 12.0),
      child: Card(
        color: node.isTarget
            ? node.color
            : node.color,
        child: ListTile(
          leading: Icon(
            isLast ? Icons.star_rounded : Icons.check_box_outline_blank,
            color: node.isTarget
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            node.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: node.isTarget
                  ? Theme.of(context).colorScheme.onPrimary
                  : null,
            ),
          ),
          subtitle: Text(
            node.subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: node.isTarget
                  ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — Correct vs Incorrect usage
// ===========================================================================
class _CorrectVsBugTab extends StatelessWidget {
  const _CorrectVsBugTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.compare_arrows,
            label: 'Correct vs Missing Injector',
          ),
          Text(
            'Left: correct — SliverOverlapInjector present. '
            'Right: bug — injector missing, content hidden behind header.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(child: _CorrectNSV()),
              const SizedBox(width: 12),
              Expanded(child: _BuggyNSV()),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.bug_report_outlined,
            label: 'The bug explained',
          ),
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _BulletPoint(
                  'Without SliverOverlapInjector, the inner list starts at y=0 '
                  'of the inner viewport.',
                ),
                _BulletPoint(
                  'The pinned header (height = N px) occludes the first N pixels '
                  'of the inner list.',
                ),
                _BulletPoint(
                  'The user cannot scroll to reveal the hidden items '
                  '(they are behind the header).',
                ),
                _BulletPoint(
                  'SliverOverlapAbsorberHandle.extent is still set correctly — '
                  'the fix is just adding the injector.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            icon: Icons.check_circle_outline,
            label: 'Fix checklist',
          ),
          _ChecklistCard(
            items: const <String>[
              'Wrap SliverAppBar with SliverOverlapAbsorber in header builder.',
              'Pass handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context).',
              'Add SliverOverlapInjector as first sliver in body CustomScrollView.',
              'Use the same handle from Builder context inside the body.',
              'Never call handleFor() from a context above NestedScrollView.',
            ],
          ),
        ],
      ),
    );
  }
}

class _CorrectNSV extends StatelessWidget {
  const _CorrectNSV();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 380,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: cs.primaryContainer,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check_circle, color: cs.primary, size: 16),
                const SizedBox(width: 4),
                Text(
                  'CORRECT',
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    sliver: SliverAppBar(
                      title: const Text(
                        'With Injector',
                        style: TextStyle(fontSize: 13),
                      ),
                      expandedHeight: 80,
                      pinned: true,
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (BuildContext ctx) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle:
                            NestedScrollView.sliverOverlapAbsorberHandleFor(
                              ctx,
                            ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) => ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 12,
                              backgroundColor: cs.primaryContainer,
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            title: Text(
                              'Item ${i + 1} — visible',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          childCount: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuggyNSV extends StatelessWidget {
  const _BuggyNSV();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 380,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: cs.errorContainer,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.bug_report, color: cs.error, size: 16),
                const SizedBox(width: 4),
                Text(
                  'BUG: No Injector',
                  style: TextStyle(
                    color: cs.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    sliver: SliverAppBar(
                      title: const Text(
                        'No Injector',
                        style: TextStyle(fontSize: 13),
                      ),
                      expandedHeight: 80,
                      pinned: true,
                      backgroundColor: cs.error,
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (BuildContext ctx) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      // NO SliverOverlapInjector — this is the bug
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int i) => ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 12,
                              backgroundColor: cs.errorContainer,
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            title: Text(
                              i == 0 ? 'Item 1 — HIDDEN!' : 'Item ${i + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                color: i == 0 ? cs.error : null,
                              ),
                            ),
                          ),
                          childCount: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — API surface (styled monospace)
// ===========================================================================
class _ApiSurfaceTab extends StatelessWidget {
  const _ApiSurfaceTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.api_outlined,
            label: 'SliverOverlapAbsorberHandle API',
          ),
          _ApiMethodTile(
            signature: 'handle = NestedScrollView\n  .sliverOverlapAbsorberHandleFor(context)',
            description: 'Retrieves the SliverOverlapAbsorberHandle from the '
                'nearest SliverOverlapAbsorber ancestor. Must be called from '
                'a BuildContext that is a descendant of the NestedScrollView\'s '
                'header builder context.',
          ),
          _ApiMethodTile(
            signature: 'double get handle.extent',
            description: 'The number of pixels that the SliverOverlapAbsorber '
                'has absorbed on behalf of the SliverAppBar. This is the '
                'overlap budget that the injector must restore.',
          ),
          _ApiMethodTile(
            signature: 'double get handle.layoutExtent',
            description: 'The layout extent of the sliver overlap absorber. '
                'Reflects how much space the absorber itself consumes in '
                'the sliver layout protocol.',
          ),
          _ApiMethodTile(
            signature: 'void handle.addListener(VoidCallback)',
            description: 'Registers a listener that fires whenever extent '
                'changes. RenderNestedScrollViewViewport uses this internally '
                'to call markNeedsLayout when the handle updates.',
          ),
          _ApiMethodTile(
            signature: 'void handle.removeListener(VoidCallback)',
            description: 'Deregisters a previously added listener. Always '
                'call in dispose() to avoid memory leaks.',
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.view_in_ar_outlined,
            label: 'RenderNestedScrollViewViewport API',
          ),
          _ApiMethodTile(
            signature: 'SliverOverlapAbsorberHandle get handle',
            description: 'The handle this viewport uses. Settable — when '
                'changed, the viewport re-registers listeners and schedules '
                'a layout.',
          ),
          _ApiMethodTile(
            signature: 'set handle(SliverOverlapAbsorberHandle value)',
            description: 'Replaces the current handle. Old listeners removed, '
                'new listeners added, markNeedsLayout called.',
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.code,
            label: 'Minimal correct usage pattern',
          ),
          _CodeBlock(
            '''NestedScrollView(
  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          title: Text('Title'),
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: MyHeroImage(),
          ),
        ),
      ),
    ];
  },
  body: Builder(
    builder: (BuildContext context) {
      return CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(title: Text('Item \$i')),
              childCount: 50,
            ),
          ),
        ],
      );
    },
  ),
)''',
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.table_chart_outlined,
            label: 'Property comparison table',
          ),
          _PropertyTable(
            headers: const <String>[
              'Property',
              'Set by',
              'Read by',
              'Purpose',
            ],
            rows: const <List<String>>[
              <String>[
                'handle.extent',
                'SliverOverlapAbsorber (performLayout)',
                'SliverOverlapInjector (performLayout)',
                'Overlap pixel count',
              ],
              <String>[
                'handle.layoutExtent',
                'SliverOverlapAbsorber (performLayout)',
                'SliverOverlapInjector',
                'Absorber layout extent',
              ],
              <String>[
                'handle',
                'RenderNestedScrollViewViewport constructor/setter',
                'Internal (listeners)',
                'Viewport → handle link',
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — Scroll coordination animation (CustomPainter)
// ===========================================================================
class _ScrollTimelineTab extends StatelessWidget {
  const _ScrollTimelineTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.timeline,
            label: 'Outer → Inner Scroll Handoff Timeline',
          ),
          Text(
            'The outer scroll absorbs header movement first. Once the header '
            'is pinned, the inner scroll takes over. The overlap budget '
            'changes throughout this process.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 480,
            child: CustomPaint(
              painter: _TimelinePainter(cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(icon: Icons.list_alt, label: 'Phase descriptions'),
          _PhaseCard(
            phase: 'Phase 1',
            title: 'Header expanding (user at top)',
            body: 'Both outer and inner scroll positions are at zero. '
                'handle.extent = expandedHeight (full overlap budget).',
            color: cs.primaryContainer,
          ),
          _PhaseCard(
            phase: 'Phase 2',
            title: 'User scrolls — outer absorbs',
            body: 'The outer scroll position increases. The flexible space '
                'collapses. handle.extent decreases from expandedHeight → '
                'collapsedHeight.',
            color: cs.secondaryContainer,
          ),
          _PhaseCard(
            phase: 'Phase 3',
            title: 'Header fully pinned',
            body: 'SliverAppBar is collapsed and pinned. handle.extent = '
                'collapsedHeight (toolbar height only). Outer scroll does not '
                'consume more scroll budget.',
            color: cs.tertiaryContainer,
          ),
          _PhaseCard(
            phase: 'Phase 4',
            title: 'Inner list scrolls',
            body: 'Subsequent scroll events are forwarded to the inner '
                'CustomScrollView. handle.extent stays constant. '
                'SliverOverlapInjector gap remains fixed.',
            color: cs.primaryContainer,
          ),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter(this.cs);
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPad = 60;
    const double rightPad = 24;
    final double trackW = size.width - leftPad - rightPad;
    const double topPad = 40.0;
    const double rowH = 80.0;
    const double timelineY = topPad + 20;

    // Draw horizontal timeline axis
    final Paint axisPaint = Paint()
      ..color = cs.outline
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(leftPad, timelineY),
      Offset(leftPad + trackW, timelineY),
      axisPaint,
    );

    // Arrowhead on timeline
    final Path arrow = Path()
      ..moveTo(leftPad + trackW - 10, timelineY - 6)
      ..lineTo(leftPad + trackW, timelineY)
      ..lineTo(leftPad + trackW - 10, timelineY + 6);
    canvas.drawPath(arrow, axisPaint);

    // 4 phases, evenly spaced
    final List<String> phases = <String>[
      'Phase 1\nExpanded',
      'Phase 2\nCollapsing',
      'Phase 3\nPinned',
      'Phase 4\nInner scroll',
    ];
    final List<String> extents = <String>[
      'extent =\nmax',
      'extent\n↓',
      'extent =\nmin',
      'extent\nstable',
    ];
    final List<Color> phaseColors = <Color>[
      cs.primary,
      cs.secondary,
      cs.tertiary,
      cs.primary.withValues(alpha: 0.7),
    ];

    const double phaseSpacing = 1.0 / 3.0;

    for (int i = 0; i < phases.length; i++) {
      final double x = leftPad + i * (trackW * phaseSpacing);

      // Vertical tick
      canvas.drawLine(
        Offset(x, timelineY - 10),
        Offset(x, timelineY + 10),
        Paint()
          ..color = phaseColors[i]
          ..strokeWidth = 2.5,
      );

      // Phase dot
      canvas.drawCircle(
        Offset(x, timelineY),
        8,
        Paint()
          ..color = phaseColors[i]
          ..style = PaintingStyle.fill,
      );

      // Phase label (above)
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: phases[i],
          style: TextStyle(
            fontSize: 10,
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 80);
      tp.paint(canvas, Offset(x - tp.width / 2, timelineY - 50));

      // Extent label (below)
      final TextPainter ep = TextPainter(
        text: TextSpan(
          text: extents[i],
          style: TextStyle(
            fontSize: 10,
            color: phaseColors[i],
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 80);
      ep.paint(canvas, Offset(x - ep.width / 2, timelineY + 18));
    }

    // Draw "scroll" label below axis
    final TextPainter scrollLabel = TextPainter(
      text: TextSpan(
        text: 'User scroll progress  →',
        style: TextStyle(
          fontSize: 11,
          color: cs.outline,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    scrollLabel.paint(
      canvas,
      Offset(
        leftPad + trackW / 2 - scrollLabel.width / 2,
        timelineY + 65,
      ),
    );

    // Draw two tracks: outer scroll (above) and inner scroll (below)
    const double track1Y = topPad + rowH * 2 + 30;
    const double track2Y = topPad + rowH * 3 + 30;

    _drawTrack(
      canvas,
      'Outer scroll',
      track1Y,
      leftPad,
      trackW,
      cs,
      cs.primary,
      activeUntil: 0.7,
    );
    _drawTrack(
      canvas,
      'Inner scroll',
      track2Y,
      leftPad,
      trackW,
      cs,
      cs.secondary,
      activeFrom: 0.65,
    );
  }

  void _drawTrack(
    Canvas canvas,
    String label,
    double y,
    double leftPad,
    double trackW,
    ColorScheme cs,
    Color color, {
    double activeFrom = 0.0,
    double activeUntil = 1.0,
  }) {
    // background track
    final RRect bgRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(leftPad, y, trackW, 14),
      const Radius.circular(7),
    );
    canvas.drawRRect(
      bgRRect,
      Paint()..color = cs.surfaceContainerHighest,
    );

    // active segment
    final double activeStart = leftPad + activeFrom * trackW;
    final double activeEnd = leftPad + activeUntil * trackW;
    final RRect activeRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(activeStart, y, activeEnd - activeStart, 14),
      const Radius.circular(7),
    );
    canvas.drawRRect(
      activeRRect,
      Paint()..color = color.withValues(alpha: 0.8),
    );

    // label
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 10,
          color: cs.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(leftPad - tp.width - 6, y + 1));
  }

  @override
  bool shouldRepaint(_TimelinePainter old) => old.cs != cs;
}

// ===========================================================================
// TAB 9 — Pitfalls
// ===========================================================================
class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(icon: Icons.warning_amber_rounded, label: 'Common Pitfalls'),
          const SizedBox(height: 8),

          // Pitfall 1
          _PitfallCard(
            number: 1,
            title: 'Missing SliverOverlapInjector',
            danger: 'Content is hidden behind the pinned header.',
            fix: 'Add SliverOverlapInjector as the first sliver in the '
                'body\'s CustomScrollView, using the same handle from '
                'the Builder context.',
            code: '// In body Builder:\nSliverOverlapInjector(\n'
                '  handle: NestedScrollView\n'
                '    .sliverOverlapAbsorberHandleFor(context),\n)',
          ),

          // Pitfall 2
          _PitfallCard(
            number: 2,
            title: 'Wrong context for handleFor()',
            danger: 'FlutterError: "Multiple widgets used the same '
                'GlobalKey" or assertion failure.',
            fix: 'Always call sliverOverlapAbsorberHandleFor() from '
                'the BuildContext provided by the headerSliverBuilder '
                'callback (or the Builder in the body). Never from '
                'the parent widget\'s context.',
            code: '// WRONG — parent context:\nfinal h = NestedScrollView\n'
                '  .sliverOverlapAbsorberHandleFor(context); // ❌\n\n'
                '// CORRECT — builder context:\nheaderSliverBuilder:\n'
                '  (BuildContext ctx, bool _) {\n'
                '    final h = NestedScrollView\n'
                '      .sliverOverlapAbsorberHandleFor(ctx); // ✓\n  }',
          ),

          // Pitfall 3
          _PitfallCard(
            number: 3,
            title: 'Multiple SliverOverlapAbsorbers',
            danger: 'Only one absorber is supported per NestedScrollView. '
                'Having multiple causes undefined overlap budget behavior.',
            fix: 'Use exactly one SliverOverlapAbsorber wrapping the '
                'SliverAppBar. Any additional pinned slivers should be '
                'placed outside the absorber.',
            code: '// WRONG:\nSliverOverlapAbsorber(handle: h, sliver: SA1),\n'
                'SliverOverlapAbsorber(handle: h, sliver: SA2), // ❌\n\n'
                '// CORRECT:\nSliverOverlapAbsorber(handle: h, sliver: SA1),\n'
                'SA2, // not wrapped',
          ),

          // Pitfall 4
          _PitfallCard(
            number: 4,
            title: 'Forgetting SliverOverlapAbsorber entirely',
            danger: 'handle.extent is never set. SliverOverlapInjector '
                'produces a zero-height gap. Content appears correct at '
                'first but breaks when the app bar is pinned.',
            fix: 'Always wrap the SliverAppBar inside SliverOverlapAbsorber '
                'when using NestedScrollView with a pinned or floating header.',
            code: '// WRONG:\nSliverAppBar(title: ...), // ❌ — no absorber\n\n'
                '// CORRECT:\nSliverOverlapAbsorber(\n'
                '  handle: NestedScrollView\n'
                '    .sliverOverlapAbsorberHandleFor(ctx),\n'
                '  sliver: SliverAppBar(title: ...),\n)',
          ),

          // Pitfall 5
          _PitfallCard(
            number: 5,
            title: 'Not using Builder in the body',
            danger: 'The body\'s BuildContext is not a descendant of '
                'NestedScrollView, so handleFor() returns the outer handle.',
            fix: 'Wrap the body\'s CustomScrollView in a Builder widget '
                'to obtain a BuildContext that is a descendant of the '
                'NestedScrollView.',
            code: 'body: Builder(\n'
                '  builder: (BuildContext context) {\n'
                '    return CustomScrollView(\n'
                '      slivers: [\n'
                '        SliverOverlapInjector(\n'
                '          handle: NestedScrollView\n'
                '            .sliverOverlapAbsorberHandleFor(context),\n'
                '        ),\n'
                '        // ...\n'
                '      ],\n'
                '    );\n'
                '  },\n)',
          ),

          const SizedBox(height: 24),
          _SectionTitle(
            icon: Icons.menu_book_outlined,
            label: 'API Cheat Sheet',
          ),
          _InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RenderNestedScrollViewViewport',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _MonoLine('  → extends RenderViewport'),
                _MonoLine('  → handle: SliverOverlapAbsorberHandle'),
                _MonoLine('  → set handle: re-registers listeners, schedules layout'),
                const SizedBox(height: 12),
                Text(
                  'SliverOverlapAbsorberHandle',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _MonoLine('  → extent: double  (overlap pixel count)'),
                _MonoLine('  → layoutExtent: double  (absorber layout extent)'),
                _MonoLine('  → addListener(VoidCallback)'),
                _MonoLine('  → removeListener(VoidCallback)'),
                const SizedBox(height: 12),
                Text(
                  'NestedScrollView (widget-level entry points)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _MonoLine(
                  '  NestedScrollView.sliverOverlapAbsorberHandleFor(context)',
                ),
                _MonoLine('  → returns: SliverOverlapAbsorberHandle'),
                _MonoLine('  → context must be inside header builder or body Builder'),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ===========================================================================
// Shared helper widgets
// ===========================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

class _MonoLine extends StatelessWidget {
  const _MonoLine(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '• ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(body, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.body,
  });
  final int step;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundColor: cs.primaryContainer,
            child: Text(
              '$step',
              style: TextStyle(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 13,
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
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(body, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({
    required this.phase,
    required this.title,
    required this.body,
    required this.color,
  });
  final String phase;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Chip(
                    label: Text(
                      phase,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(body, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.danger,
    required this.fix,
    required this.code,
  });
  final int number;
  final String title;
  final String danger;
  final String fix;
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: cs.errorContainer,
                    child: Text(
                      '$number',
                      style: TextStyle(
                        color: cs.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _LabelRow(
                icon: Icons.dangerous_outlined,
                label: 'Danger',
                color: cs.error,
                text: danger,
              ),
              const SizedBox(height: 6),
              _LabelRow(
                icon: Icons.healing_outlined,
                label: 'Fix',
                color: cs.primary,
                text: fix,
              ),
              const SizedBox(height: 10),
              _CodeBlock(code),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.text,
  });
  final IconData icon;
  final String label;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final String item in items) ...<Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_box_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}

class _ApiMethodTile extends StatelessWidget {
  const _ApiMethodTile({required this.signature, required this.description});
  final String signature;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  signature,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: cs.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyTable extends StatelessWidget {
  const _PropertyTable({required this.headers, required this.rows});
  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(
              color: cs.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.primaryContainer),
                children: <Widget>[
                  for (final String h in headers)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        h,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              for (final List<String> row in rows)
                TableRow(
                  children: <Widget>[
                    for (int i = 0; i < row.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Text(
                          row[i],
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontFamily: i == 0 ? 'monospace' : null,
                              ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
