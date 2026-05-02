// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// RenderSliverBoxChildManager Deep Demo
// ============================================================================
//
// RenderSliverBoxChildManager is the abstract render-side interface that lets
// a RenderSliverMultiBoxAdaptor (the foundation under SliverList, SliverGrid,
// SliverFixedExtentList) produce its children on demand during layout. It is
// not something application authors usually touch directly; the framework
// provides a concrete implementation via the SliverMultiBoxAdaptorElement
// that backs SliverChildBuilderDelegate / SliverChildListDelegate.
//
// This demo focuses on the user-facing surface (SliverChildBuilderDelegate,
// SliverChildListDelegate, SliverList, SliverGrid, SliverFixedExtentList) and
// explains how those constructs sit on top of the box-child manager.
//
// API surface of the manager (informational — not user-callable):
//   * createChild(int index, {RenderBox? after})
//   * removeChild(RenderBox child)
//   * estimateMaxScrollOffset(SliverConstraints, {int firstIndex, ...})
//   * int? get childCount
//   * void didStartLayout()
//   * void didFinishLayout()
//   * void setDidUnderflow(bool value)
//
// Sections:
//   1.  Hero intro (with painter)
//   2.  SliverChildBuilderDelegate basic
//   3.  SliverChildListDelegate basic
//   4.  Infinite scroll with null childCount
//   5.  Build counter (lazy-build proof)
//   6.  Cache extent comparison
//   7.  SliverGrid example
//   8.  SliverFixedExtentList
//   9.  Adding/removing items by id
//   10. Heterogeneous list (header/row alternation)
//   11. Scroll-to-index via ensureVisible
//   12. Estimating scroll offset (explainer)
//   13. Common pitfalls
//   14. Decision card
//   15. Architecture card
//   16. Reference table
//   17. Footer
// ============================================================================

dynamic build(BuildContext context) {
  print('=== RenderSliverBoxChildManager Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderSliverBoxChildManager Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderSliverBoxChildManager — Deep Demo'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SectionHero(),
              SizedBox(height: 24),
              _SectionBuilderBasic(),
              SizedBox(height: 24),
              _SectionListDelegateBasic(),
              SizedBox(height: 24),
              _SectionInfiniteScroll(),
              SizedBox(height: 24),
              _SectionBuildCounter(),
              SizedBox(height: 24),
              _SectionCacheExtent(),
              SizedBox(height: 24),
              _SectionSliverGrid(),
              SizedBox(height: 24),
              _SectionFixedExtentList(),
              SizedBox(height: 24),
              _SectionAddRemoveItems(),
              SizedBox(height: 24),
              _SectionHeterogeneous(),
              SizedBox(height: 24),
              _SectionScrollToIndex(),
              SizedBox(height: 24),
              _SectionEstimateOffset(),
              SizedBox(height: 24),
              _SectionPitfalls(),
              SizedBox(height: 24),
              _SectionDecisionCard(),
              SizedBox(height: 24),
              _SectionArchitecture(),
              SizedBox(height: 24),
              _SectionReferenceTable(),
              SizedBox(height: 24),
              _SectionFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// Common helpers
// ============================================================================

class _SectionFrame extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Widget child;

  const _SectionFrame({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
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
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }
}

class _Explanation extends StatelessWidget {
  final String text;
  const _Explanation(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.45),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: Color(0xFFD4D4D4),
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.4,
        ),
      ),
    );
  }
}

// ============================================================================
// 1. Hero intro
// ============================================================================

class _SectionHero extends StatefulWidget {
  @override
  State<_SectionHero> createState() => _SectionHeroState();
}

class _SectionHeroState extends State<_SectionHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '1. Slivers and the box-child manager',
          subtitle: 'Why scroll views need on-demand child creation',
          color: const Color(0xFF1565C0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'A sliver is a portion of a scrollable area whose layout is '
                'driven by SliverConstraints (scrollOffset, remainingPaintExtent, '
                'cacheOrigin, ...). For lists with many items it would be wasteful '
                'to materialize every child eagerly: most are off screen most of '
                'the time. Flutter solves this with RenderSliverMultiBoxAdaptor — '
                'a render object that asks a RenderSliverBoxChildManager to '
                'create or remove children on demand as the visible window moves.',
              ),
              const _Explanation(
                'You almost never implement RenderSliverBoxChildManager directly. '
                'You hand a SliverChildBuilderDelegate or SliverChildListDelegate '
                'to SliverList / SliverGrid / SliverFixedExtentList and the '
                'framework wires up the manager for you via '
                'SliverMultiBoxAdaptorElement.',
              ),
              SizedBox(
                height: 220,
                child: CustomPaint(
                  painter: _ArchitectureDiagramPainter(_ctrl),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 8),
              const _CodeBlock(
                'CustomScrollView(\n'
                '  slivers: [\n'
                '    SliverList(\n'
                '      delegate: SliverChildBuilderDelegate(\n'
                '        (context, index) => ListTile(title: Text("\$index")),\n'
                '        childCount: 1000, // or null for unknown\n'
                '      ),\n'
                '    ),\n'
                '  ],\n'
                ')',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArchitectureDiagramPainter extends CustomPainter {
  final Animation<double> animation;
  _ArchitectureDiagramPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFE3F2FD);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
      bg,
    );

    // Draw the "viewport" rectangle.
    final viewportRect = Rect.fromLTWH(
      20,
      20,
      size.width * 0.45,
      size.height - 40,
    );
    final viewportPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final viewportBorder = Paint()
      ..color = const Color(0xFF1565C0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(viewportRect, viewportPaint);
    canvas.drawRect(viewportRect, viewportBorder);

    // Sliver children inside viewport — animate scrolling.
    final t = animation.value;
    final scrollOffset = (t * 200) % 80;
    canvas.save();
    canvas.clipRect(viewportRect);
    for (int i = 0; i < 12; i++) {
      final y = viewportRect.top + i * 30 - scrollOffset;
      final isVisible =
          y + 28 >= viewportRect.top && y <= viewportRect.bottom;
      final color = isVisible
          ? const Color(0xFF1565C0).withOpacity(0.7)
          : const Color(0xFFB0BEC5);
      final paint = Paint()..color = color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(viewportRect.left + 8, y, viewportRect.width - 16, 24),
          const Radius.circular(4),
        ),
        paint,
      );
    }
    canvas.restore();

    // Cache window arrow.
    final cacheTop = viewportRect.top - 12;
    final cacheBottom = viewportRect.bottom + 12;
    final cachePaint = Paint()
      ..color = const Color(0xFFFFA726).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(
        viewportRect.left - 4,
        cacheTop,
        viewportRect.width + 8,
        cacheBottom - cacheTop,
      ),
      cachePaint,
    );

    // Manager box on right.
    final mgrRect = Rect.fromLTWH(
      size.width * 0.55,
      40,
      size.width * 0.4,
      size.height - 80,
    );
    final mgrPaint = Paint()..color = const Color(0xFFFFF8E1);
    final mgrBorder = Paint()
      ..color = const Color(0xFFFFA000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(mgrRect, const Radius.circular(8)),
      mgrPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(mgrRect, const Radius.circular(8)),
      mgrBorder,
    );

    final tp = TextPainter(
      text: const TextSpan(
        text: 'RenderSliverBoxChildManager\n\n'
            ' • createChild(index, after)\n'
            ' • removeChild(child)\n'
            ' • estimateMaxScrollOffset\n'
            ' • didStartLayout/didFinishLayout',
        style: TextStyle(
          color: Color(0xFF424242),
          fontSize: 11,
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mgrRect.width - 16);
    tp.paint(canvas, Offset(mgrRect.left + 8, mgrRect.top + 8));

    // Arrow from viewport to manager.
    final arrowPaint = Paint()
      ..color = const Color(0xFF424242)
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(viewportRect.right, viewportRect.center.dy),
      Offset(mgrRect.left, mgrRect.center.dy),
      arrowPaint,
    );

    final viewportLabel = TextPainter(
      text: const TextSpan(
        text: 'Viewport',
        style: TextStyle(color: Color(0xFF1565C0), fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    viewportLabel.paint(canvas, Offset(viewportRect.left, viewportRect.top - 14));
  }

  @override
  bool shouldRepaint(_ArchitectureDiagramPainter oldDelegate) => true;
}

// ============================================================================
// 2. SliverChildBuilderDelegate basic
// ============================================================================

class _SectionBuilderBasic extends StatefulWidget {
  @override
  State<_SectionBuilderBasic> createState() => _SectionBuilderBasicState();
}

class _SectionBuilderBasicState extends State<_SectionBuilderBasic> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '2. SliverChildBuilderDelegate (the lazy default)',
          subtitle: 'A builder callback runs only when an index is needed',
          color: const Color(0xFF2E7D32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'SliverChildBuilderDelegate takes a builder of the form '
                '(BuildContext, int) → Widget?. Internally, the '
                'SliverMultiBoxAdaptorElement asks the box-child manager to '
                'create child #i; the manager calls the builder, inflates the '
                'returned widget, and inserts the resulting RenderBox into '
                'the sliver. Indices outside the cache window are recycled.',
              ),
              const _CodeBlock(
                'SliverList(\n'
                '  delegate: SliverChildBuilderDelegate(\n'
                '    (context, index) => ListTile(title: Text("Row \$index")),\n'
                '    childCount: 30,\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 320,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF2E7D32)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color(0xFF2E7D32).withOpacity(0.15),
                              child: Text('${index + 1}'),
                            ),
                            title: Text('Row ${index + 1}'),
                            subtitle: Text('built lazily by the delegate'),
                            dense: true,
                          ),
                          childCount: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const _Explanation(
                'Scroll the list above. With childCount = 30 the framework '
                'knows the maximum scroll extent without estimation, so the '
                'scrollbar is exact. The builder still runs only for visible '
                '+ cached indices.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 3. SliverChildListDelegate basic
// ============================================================================

class _SectionListDelegateBasic extends StatefulWidget {
  @override
  State<_SectionListDelegateBasic> createState() =>
      _SectionListDelegateBasicState();
}

class _SectionListDelegateBasicState extends State<_SectionListDelegateBasic> {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      for (int i = 0; i < 15; i++)
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: Text('Hand-written child #${i + 1}'),
          subtitle: const Text('all built up front by SliverChildListDelegate'),
        ),
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '3. SliverChildListDelegate (eager, fine for small lists)',
          subtitle: 'Hand-written children built once and kept alive',
          color: const Color(0xFF6A1B9A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'SliverChildListDelegate accepts a List<Widget>. Every entry '
                'is constructed before the sliver is laid out; the box-child '
                'manager simply hands them to the sliver as they enter the '
                'cache window. This is the right choice for a small, fixed '
                'set of items where lazy build is unnecessary overhead.',
              ),
              const _CodeBlock(
                'SliverList(\n'
                '  delegate: SliverChildListDelegate(<Widget>[\n'
                '    ListTile(title: Text("First")),\n'
                '    ListTile(title: Text("Second")),\n'
                '    // ...\n'
                '  ]),\n'
                ')',
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 320,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF6A1B9A)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(children),
                      ),
                    ],
                  ),
                ),
              ),
              const _Explanation(
                'For 15 items this is fine. For 15,000 it would be a problem: '
                'every tile would be inflated up front, regardless of '
                'visibility, defeating the purpose of slivers entirely.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 4. Infinite scroll with null childCount
// ============================================================================

class _SectionInfiniteScroll extends StatefulWidget {
  @override
  State<_SectionInfiniteScroll> createState() => _SectionInfiniteScrollState();
}

class _SectionInfiniteScrollState extends State<_SectionInfiniteScroll> {
  int _highWater = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '4. Infinite scroll: null childCount',
          subtitle: 'estimateMaxScrollOffset takes over for unknown lengths',
          color: const Color(0xFFD84315),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'Pass null (or omit) the childCount on '
                'SliverChildBuilderDelegate to model a list of unknown length. '
                'The box-child manager keeps calling createChild as long as '
                'the builder returns non-null widgets. The render object asks '
                'the manager to estimateMaxScrollOffset based on already-laid '
                'children so the scrollbar can show a reasonable thumb size.',
              ),
              const _CodeBlock(
                'SliverList(\n'
                '  delegate: SliverChildBuilderDelegate(\n'
                '    (context, index) => Tile(index: index),\n'
                '    // childCount omitted == infinite (until builder returns null)\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 12),
              Card(
                color: const Color(0xFFFFF3E0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Highest index built so far: $_highWater',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD84315),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 360,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD84315)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // Track the high-water mark of indices the
                            // manager has asked the builder for.
                            if (index > _highWater) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!mounted) return;
                                setState(() => _highWater = index);
                              });
                            }
                            return ListTile(
                              dense: true,
                              leading: Text('#$index'),
                              title: Text('Synthetic row $index'),
                              subtitle: Text(
                                'pretend this came from a paginated API',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 5. Build counter (lazy-build proof)
// ============================================================================

class _SectionBuildCounter extends StatefulWidget {
  @override
  State<_SectionBuildCounter> createState() => _SectionBuildCounterState();
}

class _SectionBuildCounterState extends State<_SectionBuildCounter> {
  final Set<int> _builtIndices = <int>{};

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '5. Build counter — proof of laziness',
          subtitle: 'Track which indices the box-child manager has materialized',
          color: const Color(0xFF00838F),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'The Set<int> below records every index the builder runs for. '
                'On first frame, only a small window is built; as you scroll, '
                'the manager calls createChild for new indices and (depending '
                'on cache extent) destroys old ones. The number on the right '
                'shows the cumulative set of indices that have been touched.',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 360,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF00838F)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CustomScrollView(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: false,
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if (!_builtIndices.contains(index)) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (!mounted) return;
                                      setState(() => _builtIndices.add(index));
                                    });
                                  }
                                  return Container(
                                    height: 56,
                                    color: index.isEven
                                        ? const Color(0xFFE0F7FA)
                                        : Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text('Index $index'),
                                  );
                                },
                                childCount: 200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: const Color(0xFFE0F7FA),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Built indices',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00838F),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${_builtIndices.length} of 200 ever built',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF006064),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _builtIndices.isEmpty
                                  ? '(scroll the list to build more)'
                                  : (_builtIndices.toList()..sort())
                                      .take(40)
                                      .join(', '),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _Explanation(
                'Note: indices are not "uninserted" from the set even after '
                'the manager destroys the corresponding RenderBox. The point '
                'is to demonstrate that, despite a list of 200 items, only a '
                'small fraction of indices get the builder invoked at all '
                'unless the user scrolls.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 6. Cache extent comparison
// ============================================================================

class _SectionCacheExtent extends StatefulWidget {
  @override
  State<_SectionCacheExtent> createState() => _SectionCacheExtentState();
}

class _SectionCacheExtentState extends State<_SectionCacheExtent>
    with SingleTickerProviderStateMixin {
  final Set<int> _builtDefault = <int>{};
  final Set<int> _builtZero = <int>{};
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _buildList({
    required double? cacheExtent,
    required Set<int> sink,
    required Color color,
  }) {
    return SizedBox(
      height: 320,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: false,
          cacheExtent: cacheExtent,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (!sink.contains(index)) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      setState(() => sink.add(index));
                    });
                  }
                  return Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: index.isEven ? Colors.white : color.withOpacity(0.05),
                    child: Text('row $index'),
                  );
                },
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '6. Cache extent — what stays built around the viewport',
          subtitle: 'Default vs cacheExtent: 0',
          color: const Color(0xFF455A64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'cacheExtent is the number of logical pixels of children kept '
                'live above and below the visible viewport. A larger cache '
                'reduces flicker when scrolling fast but means the box-child '
                'manager has more children alive at any moment. cacheExtent: 0 '
                'shrinks the manager\'s window to the visible viewport only.',
              ),
              SizedBox(
                height: 90,
                child: CustomPaint(
                  painter: _CacheWindowPainter(_ctrl),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Default cacheExtent',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'built: ${_builtDefault.length}',
                          style: const TextStyle(color: Color(0xFF455A64)),
                        ),
                        const SizedBox(height: 6),
                        _buildList(
                          cacheExtent: null,
                          sink: _builtDefault,
                          color: const Color(0xFF455A64),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'cacheExtent: 0',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'built: ${_builtZero.length}',
                          style: const TextStyle(color: Color(0xFF455A64)),
                        ),
                        const SizedBox(height: 6),
                        _buildList(
                          cacheExtent: 0,
                          sink: _builtZero,
                          color: const Color(0xFF607D8B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const _Explanation(
                'Scroll both lists. The "default" version typically reports a '
                'higher built-count because the manager keeps a few off-screen '
                'rows alive on either side of the viewport.',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CacheWindowPainter extends CustomPainter {
  final Animation<double> animation;
  _CacheWindowPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFECEFF1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(6),
      ),
      bg,
    );

    final t = animation.value;
    final viewportLeft = 40 + t * 60;
    final viewportRect =
        Rect.fromLTWH(viewportLeft, 24, size.width * 0.35, size.height - 48);

    // Cache window around viewport.
    final cacheRect = Rect.fromLTWH(
      viewportRect.left - 30,
      viewportRect.top,
      viewportRect.width + 60,
      viewportRect.height,
    );
    final cachePaint = Paint()
      ..color = const Color(0xFFFFA726).withOpacity(0.3);
    canvas.drawRect(cacheRect, cachePaint);

    final viewportPaint = Paint()..color = const Color(0xFF1565C0).withOpacity(0.5);
    canvas.drawRect(viewportRect, viewportPaint);

    final tp1 = TextPainter(
      text: const TextSpan(
        text: 'cache window (default)',
        style: TextStyle(color: Color(0xFFE65100), fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp1.paint(canvas, Offset(cacheRect.left, cacheRect.top - 14));

    final tp2 = TextPainter(
      text: const TextSpan(
        text: 'viewport',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp2.paint(canvas, Offset(viewportRect.left + 4, viewportRect.center.dy - 6));

    final tp3 = TextPainter(
      text: const TextSpan(
        text: 'cacheExtent: 0  →  cache == viewport',
        style: TextStyle(color: Color(0xFF263238), fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp3.paint(canvas, Offset(cacheRect.right + 16, viewportRect.center.dy - 6));
  }

  @override
  bool shouldRepaint(_CacheWindowPainter oldDelegate) => true;
}

// ============================================================================
// 7. SliverGrid example
// ============================================================================

class _SectionSliverGrid extends StatefulWidget {
  @override
  State<_SectionSliverGrid> createState() => _SectionSliverGridState();
}

class _SectionSliverGridState extends State<_SectionSliverGrid> {
  int _crossAxis = 3;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '7. SliverGrid with a builder delegate',
          subtitle: 'Same manager, two-axis layout',
          color: const Color(0xFFAD1457),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'SliverGrid uses the same SliverChildBuilderDelegate. The '
                'render object is RenderSliverGrid, which still talks to a '
                'RenderSliverBoxChildManager but additionally consults a '
                'SliverGridDelegate (e.g. SliverGridDelegateWithFixedCrossAxisCount) '
                'to compute the geometry of each tile.',
              ),
              Row(
                children: <Widget>[
                  const Text('Cross axis count: '),
                  for (final n in <int>[2, 3, 4, 5])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text('$n'),
                        selected: _crossAxis == n,
                        onSelected: (_) => setState(() => _crossAxis = n),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 360,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFAD1457)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _crossAxis,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          childAspectRatio: 1.2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                            decoration: BoxDecoration(
                              color: HSLColor.fromAHSL(
                                1,
                                (index * 17) % 360,
                                0.45,
                                0.7,
                              ).toColor(),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '#$index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          childCount: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 8. SliverFixedExtentList
// ============================================================================

class _SectionFixedExtentList extends StatefulWidget {
  @override
  State<_SectionFixedExtentList> createState() =>
      _SectionFixedExtentListState();
}

class _SectionFixedExtentListState extends State<_SectionFixedExtentList> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '8. SliverFixedExtentList — the fast-path sliver',
          subtitle: 'Constant per-child extent skips re-measurement',
          color: const Color(0xFF4527A0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'When every child has the same height (or width, in a '
                'horizontal scroll), use SliverFixedExtentList. Its render '
                'object is RenderSliverFixedExtentList, which can compute the '
                'sliver geometry without inflating any child first: '
                'maxScrollExtent is just itemExtent × childCount, and '
                'index-from-offset is a single division. The box-child '
                'manager only inflates children when they enter the cache '
                'window.',
              ),
              const _CodeBlock(
                'SliverFixedExtentList(\n'
                '  itemExtent: 56,\n'
                '  delegate: SliverChildBuilderDelegate(\n'
                '    (context, i) => Tile(i),\n'
                '    childCount: 1000,\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 360,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF4527A0)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: 56,
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                            color: index.isEven
                                ? const Color(0xFFEDE7F6)
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor:
                                      const Color(0xFF4527A0).withOpacity(0.2),
                                  radius: 16,
                                  child: Text('${index % 10}'),
                                ),
                                const SizedBox(width: 12),
                                Text('Fixed-extent row $index'),
                              ],
                            ),
                          ),
                          childCount: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const _Explanation(
                'Why this matters at scale: SliverList has to ask the '
                'manager for child #N, lay it out, then read its actual '
                'height to know where #N+1 starts. A 100k-row SliverList '
                'with variable extents pays this cost on every scroll. '
                'SliverFixedExtentList sidesteps that entirely.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 9. Adding/removing items by id
// ============================================================================

class _SectionAddRemoveItems extends StatefulWidget {
  @override
  State<_SectionAddRemoveItems> createState() => _SectionAddRemoveItemsState();
}

class _SectionAddRemoveItemsState extends State<_SectionAddRemoveItems> {
  final List<int> _ids = <int>[for (int i = 1; i <= 8; i++) i];
  int _nextId = 9;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '9. Adding/removing items by id',
          subtitle: 'Items disappear without rebuilding survivors',
          color: const Color(0xFF00695C),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'The builder returns a real widget for indices whose id is '
                'still present in the visible set, and uses keys to keep '
                'state. When you remove an id, the box-child manager is told '
                'the new childCount; it removes the orphaned RenderBox. '
                'Surviving children, which are keyed, are not rebuilt — '
                'their state is preserved.',
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Append item'),
                    onPressed: () {
                      setState(() {
                        _ids.add(_nextId++);
                      });
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Insert at top'),
                    onPressed: () {
                      setState(() {
                        _ids.insert(0, _nextId++);
                      });
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.remove_circle_outline),
                    label: const Text('Remove first'),
                    onPressed: _ids.isEmpty
                        ? null
                        : () {
                            setState(() {
                              _ids.removeAt(0);
                            });
                          },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.remove_circle),
                    label: const Text('Remove last'),
                    onPressed: _ids.isEmpty
                        ? null
                        : () {
                            setState(() {
                              _ids.removeLast();
                            });
                          },
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    onPressed: () {
                      setState(() {
                        _ids
                          ..clear()
                          ..addAll(<int>[for (int i = 1; i <= 8; i++) i]);
                        _nextId = 9;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 320,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00695C)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final id = _ids[index];
                            return ListTile(
                              key: ValueKey<int>(id),
                              leading: CircleAvatar(
                                backgroundColor:
                                    const Color(0xFF00695C).withOpacity(0.2),
                                child: Text('$id'),
                              ),
                              title: Text('Item with id #$id'),
                              subtitle: Text('Position $index in the list'),
                            );
                          },
                          childCount: _ids.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const _Explanation(
                'Use ValueKey or ObjectKey on items so the framework can '
                'match RenderBoxes across rebuilds when ids reorder. '
                'Without keys, removing an id from the middle would force '
                'the manager to recreate every following child, defeating '
                'state preservation (form input, animation phase, etc.).',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 10. Heterogeneous list (header / row alternation)
// ============================================================================

class _SectionHeterogeneous extends StatefulWidget {
  @override
  State<_SectionHeterogeneous> createState() => _SectionHeterogeneousState();
}

class _SectionHeterogeneousState extends State<_SectionHeterogeneous> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '10. Heterogeneous list — different widget per index',
          subtitle: 'A single delegate can return any widget for any index',
          color: const Color(0xFFEF6C00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'The builder is just a function. Returning a header at even '
                'indices and a row at odd indices is perfectly fine; the '
                'box-child manager does not care what kind of RenderBox you '
                'hand back, only that you do hand back a RenderBox of '
                'measurable extent. Mixing Sliver*-typed widgets is the only '
                'thing forbidden — those belong directly under '
                'CustomScrollView.slivers, not inside another sliver\'s '
                'delegate.',
              ),
              SizedBox(
                height: 380,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEF6C00)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index.isEven) {
                              return Container(
                                height: 36,
                                color: const Color(0xFFFFF3E0),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Header for group ${index ~/ 2 + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEF6C00),
                                  ),
                                ),
                              );
                            }
                            return ListTile(
                              dense: true,
                              leading: const Icon(Icons.subdirectory_arrow_right),
                              title: Text('Row body #${index ~/ 2 + 1}'),
                              subtitle: const Text(
                                'lives between two header rows',
                              ),
                            );
                          },
                          childCount: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const _Explanation(
                'For more complex pinned-headers behavior use '
                'SliverPersistentHeader or SliverStickyHeader, which are '
                'separate slivers wired into the CustomScrollView, not '
                'children of a SliverList delegate.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 11. Scroll-to-index via ensureVisible
// ============================================================================

class _SectionScrollToIndex extends StatefulWidget {
  @override
  State<_SectionScrollToIndex> createState() => _SectionScrollToIndexState();
}

class _SectionScrollToIndexState extends State<_SectionScrollToIndex> {
  static const int _count = 60;
  final ScrollController _controller = ScrollController();
  final List<GlobalKey> _keys =
      List<GlobalKey>.generate(_count, (i) => GlobalKey());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _jumpTo(int index) {
    final key = _keys[index];
    final ctx = key.currentContext;
    if (ctx == null) {
      // Not built yet — the manager has not materialized this index.
      // For a robust scroll-to-index in production, use the
      // scroll_to_index package or compute offset manually.
      _controller.animateTo(
        index * 56.0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      return;
    }
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '11. Scroll-to-index — and the laziness gotcha',
          subtitle: 'Scrollable.ensureVisible only works for built children',
          color: const Color(0xFF1976D2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'Each row owns a GlobalKey. Tapping a "jump" button calls '
                'Scrollable.ensureVisible against that key\'s context — but '
                'only if the box-child manager has already inflated that '
                'index. If the target is far off-screen the manager has not '
                'asked the builder for it yet, so the GlobalKey has no '
                'context, and we fall back to a manual offset jump.',
              ),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: <Widget>[
                  for (final i in <int>[0, 5, 12, 25, 40, 55])
                    OutlinedButton(
                      onPressed: () => _jumpTo(i),
                      child: Text('jump → $i'),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 360,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF1976D2)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomScrollView(
                    controller: _controller,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: 56,
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                            key: _keys[index],
                            color: index.isEven
                                ? const Color(0xFFE3F2FD)
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '#$index',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text('row body'),
                              ],
                            ),
                          ),
                          childCount: _count,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 12. Estimating scroll offset (explainer)
// ============================================================================

class _SectionEstimateOffset extends StatefulWidget {
  @override
  State<_SectionEstimateOffset> createState() => _SectionEstimateOffsetState();
}

class _SectionEstimateOffsetState extends State<_SectionEstimateOffset> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '12. estimateMaxScrollOffset — guesses, then refines',
          subtitle: 'How the manager produces a scroll extent it does not know',
          color: const Color(0xFF5D4037),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'When childCount is null, the sliver does not know the total '
                'scroll extent ahead of time. To paint the scrollbar and to '
                'support overscroll physics, the render object asks the '
                'manager:',
              ),
              const _CodeBlock(
                'double estimateMaxScrollOffset(\n'
                '  SliverConstraints constraints, {\n'
                '  required int firstIndex,\n'
                '  required int lastIndex,\n'
                '  required double leadingScrollOffset,\n'
                '  required double trailingScrollOffset,\n'
                '});',
              ),
              const _Explanation(
                'The default implementation extrapolates: it averages the '
                'extent of children that have already been laid out and '
                'multiplies by the remaining unknown count (or returns '
                'double.infinity when truly unbounded). A custom delegate '
                'can override the estimator to return a more accurate '
                'value if you happen to know the true total length but '
                'not the per-item heights.',
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEBE9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Practical effect: with null childCount, the scrollbar '
                  'thumb resizes as you scroll because each frame the '
                  'estimator gets a slightly better sample of average row '
                  'heights. This is fine. If it looks jumpy, switch to '
                  'SliverFixedExtentList or supply a real childCount.',
                  style: TextStyle(fontSize: 13, height: 1.45),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 13. Common pitfalls
// ============================================================================

class _SectionPitfalls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '13. Common pitfalls',
      subtitle: 'Things that quietly defeat the point of slivers',
      color: const Color(0xFFC62828),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PitfallCard(
            title: 'SliverChildListDelegate for huge lists',
            body: 'It builds every child up front. For more than ~100 items '
                'always switch to SliverChildBuilderDelegate so the '
                'box-child manager can do its job lazily.',
          ),
          _PitfallCard(
            title: 'Forgetting addAutomaticKeepAlives: false',
            body: 'By default both delegates wrap children with '
                'AutomaticKeepAlive. If your children never call '
                'updateKeepAlive(true), this is harmless overhead; if they '
                'do, scrolling away will not destroy them and the manager '
                'will keep them in memory longer than expected.',
          ),
          _PitfallCard(
            title: 'Forgetting addRepaintBoundaries: false',
            body: 'Each child gets a RepaintBoundary by default. Usually '
                'good, but if your children are trivially cheap to paint '
                'the boundaries can themselves cost more than they save. '
                'Profile before disabling.',
          ),
          _PitfallCard(
            title: 'Unkeyed children plus reordering',
            body: 'Without keys, removing item #3 forces every child after '
                'it to be torn down and rebuilt — losing animation phase, '
                'TextField cursor, video player position, etc.',
          ),
          _PitfallCard(
            title: 'Variable extents in long lists',
            body: 'A 50,000-row SliverList with variable heights pays a '
                'real layout cost every scroll because the manager must '
                'inflate each child to measure it. Use '
                'SliverFixedExtentList or SliverPrototypeExtentList '
                'whenever you can.',
          ),
          _PitfallCard(
            title: 'Wrapping a CustomScrollView in another scroller',
            body: 'A SingleChildScrollView containing a shrinkWrapped '
                'CustomScrollView forces the inner sliver to lay out all '
                'its children to compute its own intrinsic size — '
                'completely defeating lazy materialization. Constrain '
                'height with SizedBox or Expanded instead.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final String body;
  const _PitfallCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          border: Border(
            left: BorderSide(color: const Color(0xFFC62828), width: 4),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFC62828),
              ),
            ),
            const SizedBox(height: 4),
            Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 14. Decision card
// ============================================================================

class _SectionDecisionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '14. Which sliver should I use?',
      subtitle: 'A quick decision tree',
      color: const Color(0xFF37474F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _DecisionRow(
            choice: 'SliverChildBuilderDelegate',
            when: 'Long, scrolling list. Default choice. Pair with SliverList, '
                'SliverGrid, or SliverFixedExtentList.',
          ),
          _DecisionRow(
            choice: 'SliverChildListDelegate',
            when: 'Small (< ~50) hand-written set of children.',
          ),
          _DecisionRow(
            choice: 'SliverList',
            when: 'Variable-extent items, no special layout.',
          ),
          _DecisionRow(
            choice: 'SliverFixedExtentList',
            when: 'Every child has the same main-axis extent. Big perf win '
                'over SliverList.',
          ),
          _DecisionRow(
            choice: 'SliverPrototypeExtentList',
            when: 'Same extent for all children, but the value is hard to '
                'compute manually — supply a prototype widget instead.',
          ),
          _DecisionRow(
            choice: 'SliverGrid',
            when: 'Two-axis tile layout. Combine with SliverGridDelegate.',
          ),
          _DecisionRow(
            choice: 'Custom RenderSliverBoxChildManager',
            when: 'Almost never. Reach for it only if you are building a '
                'novel sliver primitive (e.g. a varying-grid).',
          ),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  final String choice;
  final String when;
  const _DecisionRow({required this.choice, required this.when});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFCFD8DC),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              choice,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF263238),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(when, style: const TextStyle(fontSize: 13, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 15. Architecture card
// ============================================================================

class _SectionArchitecture extends StatefulWidget {
  @override
  State<_SectionArchitecture> createState() => _SectionArchitectureState();
}

class _SectionArchitectureState extends State<_SectionArchitecture>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return _SectionFrame(
          title: '15. Architecture: where does the manager live?',
          subtitle: 'Widget ⇄ Element ⇄ RenderObject layers',
          color: const Color(0xFF283593),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _Explanation(
                'In Flutter\'s three-tree architecture each layer has its own '
                'responsibility. For slivers:',
              ),
              SizedBox(
                height: 280,
                child: CustomPaint(
                  painter: _LayersPainter(_ctrl),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 8),
              const _Explanation(
                'SliverList (widget) configures the delegate. '
                'SliverMultiBoxAdaptorElement (element) implements '
                'RenderSliverBoxChildManager and bridges between the '
                'widget delegate\'s build callback and the render tree. '
                'RenderSliverList (render object, a subclass of '
                'RenderSliverMultiBoxAdaptor) calls back into that element '
                'whenever it needs another child.',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LayersPainter extends CustomPainter {
  final Animation<double> animation;
  _LayersPainter(this.animation) : super(repaint: animation);

  void _drawBox(
    Canvas canvas,
    Rect rect,
    Color fill,
    Color stroke,
    String title,
    String subtitle,
  ) {
    final paint = Paint()..color = fill;
    final border = Paint()
      ..color = stroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      border,
    );

    final tp = TextPainter(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              color: stroke,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: subtitle,
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 16);
    tp.paint(canvas, Offset(rect.left + 8, rect.top + 8));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final boxW = size.width / 3 - 12;
    final widgetRect = Rect.fromLTWH(8, 24, boxW, size.height - 48);
    final elementRect = Rect.fromLTWH(8 + boxW + 12, 24, boxW, size.height - 48);
    final renderRect =
        Rect.fromLTWH(8 + (boxW + 12) * 2, 24, boxW, size.height - 48);

    _drawBox(
      canvas,
      widgetRect,
      const Color(0xFFE8EAF6),
      const Color(0xFF283593),
      'Widget',
      'SliverList\n• holds delegate\n• immutable\n• rebuilt freely',
    );
    _drawBox(
      canvas,
      elementRect,
      const Color(0xFFFFF8E1),
      const Color(0xFFFF8F00),
      'Element',
      'SliverMultiBox-\nAdaptorElement\n• implements\n  RenderSliverBox-\n  ChildManager\n• calls delegate',
    );
    _drawBox(
      canvas,
      renderRect,
      const Color(0xFFFCE4EC),
      const Color(0xFFAD1457),
      'RenderObject',
      'RenderSliverList\n(extends Render-\nSliverMultiBox-\nAdaptor)\n• calls\n  createChild()\n• calls\n  removeChild()',
    );

    // Animated arrows.
    final t = animation.value;
    final arrowPaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1.5;

    void drawArrow(Offset from, Offset to, double phase) {
      canvas.drawLine(from, to, arrowPaint);
      final headSize = 5.0;
      canvas.drawLine(
        to,
        to + Offset(-headSize, -headSize),
        arrowPaint,
      );
      canvas.drawLine(
        to,
        to + Offset(-headSize, headSize),
        arrowPaint,
      );
      // Animated dot moving along the line.
      final dotT = (t + phase) % 1.0;
      final dot = Offset.lerp(from, to, dotT)!;
      canvas.drawCircle(dot, 3, Paint()..color = const Color(0xFFFF8F00));
    }

    drawArrow(
      Offset(widgetRect.right, size.height / 2),
      Offset(elementRect.left, size.height / 2),
      0,
    );
    drawArrow(
      Offset(elementRect.right, size.height / 2),
      Offset(renderRect.left, size.height / 2),
      0.5,
    );

    final tp = TextPainter(
      text: const TextSpan(
        text: 'createChild(i) flows right →   built RenderBox flows left ←',
        style: TextStyle(color: Colors.black87, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(8, size.height - 16));
  }

  @override
  bool shouldRepaint(_LayersPainter oldDelegate) => true;
}

// ============================================================================
// 16. Reference table
// ============================================================================

class _SectionReferenceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '16. Reference: RenderSliverBoxChildManager surface',
      subtitle: 'Method, role, when called',
      color: const Color(0xFF455A64),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            columns: const <DataColumn>[
              DataColumn(label: Text('Method')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('When called')),
            ],
            rows: const <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text('createChild(i, {after})')),
                DataCell(Text('Inflate child #i and insert after the given')),
                DataCell(Text('During layout, when sliver needs a new index')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('removeChild(child)')),
                DataCell(Text('Tear down a RenderBox no longer needed')),
                DataCell(Text('When the cache window shrinks past it')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('estimateMaxScrollOffset(...)')),
                DataCell(Text('Guess total scroll extent from samples')),
                DataCell(Text('Each layout pass when childCount is null')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('childCount')),
                DataCell(Text('Total number of children, or null')),
                DataCell(Text('Read by sliver to bound iteration')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('didStartLayout()')),
                DataCell(Text('Notification: layout pass starting')),
                DataCell(Text('Beginning of every performLayout')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('didFinishLayout()')),
                DataCell(Text('Notification: layout pass complete')),
                DataCell(Text('End of every performLayout')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('setDidUnderflow(bool)')),
                DataCell(Text('Sliver tells manager it ran out of children')),
                DataCell(Text('Used to drive infinite-scroll fallback')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('SliverChildBuilderDelegate.build')),
                DataCell(Text('User-facing callback for index → widget')),
                DataCell(Text('Indirectly invoked from createChild')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('SliverChildListDelegate.build')),
                DataCell(Text('User-facing list-based child source')),
                DataCell(Text('Indirectly invoked from createChild')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 17. Footer
// ============================================================================

class _SectionFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '17. References & further reading',
      subtitle: 'Where to go next',
      color: const Color(0xFF424242),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Flutter API: RenderSliverBoxChildManager'),
            subtitle: Text(
              'package:flutter/rendering.dart — abstract child manager '
              'for RenderSliverMultiBoxAdaptor',
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Flutter API: SliverChildBuilderDelegate'),
            subtitle: Text(
              'package:flutter/widgets.dart — primary user-facing entry point '
              'into the box-child manager',
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Flutter API: SliverChildListDelegate'),
            subtitle: Text(
              'package:flutter/widgets.dart — eager list variant, fine for '
              'small static collections',
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Flutter API: SliverList / SliverGrid / '
                'SliverFixedExtentList / SliverPrototypeExtentList'),
            subtitle: Text(
              'Concrete sliver widgets that consume a delegate and drive '
              'the box-child manager',
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Flutter source: rendering/sliver_multi_box_adaptor.dart'),
            subtitle: Text(
              'Read-along for createChild, removeChild, estimateMaxScrollOffset',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Text(
              'TL;DR — You will almost never implement '
              'RenderSliverBoxChildManager. You will use '
              'SliverChildBuilderDelegate (lazy) for big lists and '
              'SliverChildListDelegate (eager) for small ones, picking the '
              'right concrete sliver (List / FixedExtentList / Grid) based on '
              'whether your children share an extent and how many of them '
              'there are.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xFF424242),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
