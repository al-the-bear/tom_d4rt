import 'package:flutter/material.dart';

const _canvas = Color(0xFFF4F8FC);
const _ink = Color(0xFF143146);
const _atlas = Color(0xFF2567A7);
const _mint = Color(0xFF2E8671);
const _amber = Color(0xFFB07D33);
const _clay = Color(0xFF96556E);
const _indigo = Color(0xFF6058B5);

dynamic build(BuildContext context) {
  return const _NestedScrollViewportDeepDemoApp();
}

class _NestedScrollViewportDeepDemoApp extends StatelessWidget {
  const _NestedScrollViewportDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _atlas),
        scaffoldBackgroundColor: _canvas,
      ),
      home: const _NestedScrollViewportDeepDemoPage(),
    );
  }
}

class _NestedScrollViewportDeepDemoPage extends StatefulWidget {
  const _NestedScrollViewportDeepDemoPage();

  @override
  State<_NestedScrollViewportDeepDemoPage> createState() => _NestedScrollViewportDeepDemoPageState();
}

class _NestedScrollViewportDeepDemoPageState extends State<_NestedScrollViewportDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _rtl = false;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 96,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('NestedScrollViewViewport Deep Demo'),
              Text(
                'custom viewport composition | overlap coordination | practical nested scroll shells',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.86),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GlobalDeck(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                rtl: _rtl,
                zoom: _zoom,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuidesChanged: (v) => setState(() => _guides = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onZoomChanged: (v) => setState(() => _zoom = v),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 1,
                tone: _atlas,
                title: 'Viewport Anatomy Workshop',
                subtitle:
                    'Build NestedScrollViewViewport directly through Scrollable.viewportBuilder and observe axis, anchor, center, and clipping effects in real time.',
                child: _ViewportAnatomyScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                tone: _mint,
                title: 'Nested Coordinator Studio',
                subtitle:
                    'A full NestedScrollView stack with overlap absorber/injector, tabbed content panes, and pinned/floating behavior controls.',
                child: _CoordinatorScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                tone: _amber,
                title: 'Overlap Comparison Lab',
                subtitle:
                    'Side-by-side lanes compare with-injector and no-injector behavior to make overlap geometry differences visually obvious.',
                child: _OverlapComparisonScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                tone: _clay,
                title: 'Anchor and Clip Lab',
                subtitle:
                    'Interactive anchor and clip behavior tests with intentionally overflowing slivers show how viewport cropping and centering work.',
                child: _AnchorClipScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                tone: _indigo,
                title: 'Practical Blueprint Console',
                subtitle:
                    'Realistic module shells demonstrate product-style nested scroll patterns powered by NestedScrollViewViewport internals.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalDeck extends StatelessWidget {
  const _GlobalDeck({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.rtl,
    required this.zoom,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onZoomChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool rtl;
  final double zoom;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF17344A), Color(0xFF2B699F), Color(0xFF328472), Color(0xFF655CB0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NestedScrollViewViewport Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 29),
          ),
          const SizedBox(height: 6),
          const Text(
            'NestedScrollViewViewport is the viewport implementation used by NestedScrollView to coordinate '
            'outer and inner slivers while honoring overlap handles. This demo visualizes how viewport decisions '
            'shape scroll composition and route-level UX.',
            style: TextStyle(color: Color(0xFFE1F0FA), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text(
            'Scene zoom: ${zoom.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: zoom,
            min: 0.80,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontSize: 19, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F62), height: 1.35)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _ViewportAnatomyScene extends StatefulWidget {
  const _ViewportAnatomyScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_ViewportAnatomyScene> createState() => _ViewportAnatomySceneState();
}

class _ViewportAnatomySceneState extends State<_ViewportAnatomyScene> {
  final SliverOverlapAbsorberHandle _handle = SliverOverlapAbsorberHandle();
  final GlobalKey _centerKey = GlobalKey();
  final List<String> _events = <String>[];

  AxisDirection _axisDirection = AxisDirection.down;
  Clip _clipBehavior = Clip.hardEdge;
  double _anchor = 0.0;
  bool _useCenter = false;
  bool _showGrid = true;
  bool _showTimeline = true;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1180.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Viewport controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _EnumDropdown<AxisDirection>(
                        label: 'Axis direction',
                        value: _axisDirection,
                        values: const [AxisDirection.down, AxisDirection.up],
                        labelBuilder: (v) => v.name,
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _axisDirection = v);
                            _push('axisDirection=${v.name}');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _EnumDropdown<Clip>(
                        label: 'Clip behavior',
                        value: _clipBehavior,
                        values: const [Clip.none, Clip.hardEdge, Clip.antiAlias],
                        labelBuilder: (v) => v.name,
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _clipBehavior = v);
                            _push('clipBehavior=${v.name}');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('Anchor: ${_anchor.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Slider(
                        value: _anchor,
                        min: 0.0,
                        max: 1.0,
                        divisions: 20,
                        onChanged: (v) {
                          setState(() => _anchor = v);
                        },
                        onChangeEnd: (v) => _push('anchor=${v.toStringAsFixed(2)}'),
                      ),
                      SwitchListTile(
                        value: _useCenter,
                        onChanged: (v) {
                          setState(() => _useCenter = v);
                          _push('center sliver=${v ? 'enabled' : 'disabled'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use center key'),
                      ),
                      SwitchListTile(
                        value: _showGrid,
                        onChanged: (v) {
                          setState(() => _showGrid = v);
                          _push('grid sliver=${v ? 'shown' : 'hidden'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show grid sliver'),
                      ),
                      SwitchListTile(
                        value: _showTimeline,
                        onChanged: (v) => setState(() => _showTimeline = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show event timeline'),
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactItem('viewport class', 'NestedScrollViewViewport'),
                        _FactItem('axisDirection', _axisDirection.name),
                        _FactItem('clipBehavior', _clipBehavior.name),
                        _FactItem('anchor', _anchor.toStringAsFixed(2)),
                        _FactItem('center', _useCenter ? 'configured' : 'null'),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _atlas,
                          lines: const [
                            'NestedScrollViewViewport is a viewport that coordinates overlap for nested scrolling scenarios.',
                            'anchor changes where the zero scroll offset is placed relative to the viewport extent.',
                            'center selects the sliver used as the viewport center reference for growth in both directions.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      if (_showTimeline) ...[
                        const Text('Anatomy timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        SizedBox(height: 180, child: _EventLog(lines: _events)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Transform.scale(
                scale: widget.zoom,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Direct viewport composition', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _atlas.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _atlas.withValues(alpha: 0.26)),
                          ),
                          child: Scrollable(
                            axisDirection: _axisDirection,
                            viewportBuilder: (context, offset) {
                              return NestedScrollViewViewport(
                                axisDirection: _axisDirection,
                                anchor: _anchor,
                                offset: offset,
                                center: _useCenter ? _centerKey : null,
                                handle: _handle,
                                clipBehavior: _clipBehavior,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: _HeroBanner(
                                      tone: _atlas,
                                      title: 'Viewport Header',
                                      subtitle:
                                          'This card sits in the leading sliver. Scroll to observe clipping and anchor behavior.',
                                    ),
                                  ),
                                  if (_showGrid)
                                    SliverPadding(
                                      padding: const EdgeInsets.all(10),
                                      sliver: SliverGrid.count(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.35,
                                        children: const [
                                          _GridPanel(index: 1, tone: _mint, title: 'Overlap-ready'),
                                          _GridPanel(index: 2, tone: _amber, title: 'Center-aware'),
                                          _GridPanel(index: 3, tone: _clay, title: 'Anchor-tuned'),
                                          _GridPanel(index: 4, tone: _indigo, title: 'Clip-controlled'),
                                        ],
                                      ),
                                    ),
                                  SliverToBoxAdapter(
                                    key: _centerKey,
                                    child: _HeroBanner(
                                      tone: _mint,
                                      title: 'Center Candidate Sliver',
                                      subtitle: 'Enable center to use this sliver as the viewport reference pivot.',
                                    ),
                                  ),
                                  SliverList.list(
                                    children: const [
                                      _ListPanel(index: 1, tone: _atlas, title: 'Telemetry panel'),
                                      _ListPanel(index: 2, tone: _mint, title: 'Interaction panel'),
                                      _ListPanel(index: 3, tone: _amber, title: 'Recovery panel'),
                                      _ListPanel(index: 4, tone: _clay, title: 'Summary panel'),
                                      _ListPanel(index: 5, tone: _indigo, title: 'Footer panel'),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 46);
    });
  }
}

class _CoordinatorScene extends StatefulWidget {
  const _CoordinatorScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_CoordinatorScene> createState() => _CoordinatorSceneState();
}

class _CoordinatorSceneState extends State<_CoordinatorScene> {
  bool _pinned = true;
  bool _floating = false;
  bool _snap = false;
  bool _showAbsorber = true;
  int _tabIndex = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 990.0 : 1210.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Coordinator controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _pinned,
                        onChanged: (v) {
                          setState(() => _pinned = v);
                          _push('app bar pinned=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Pinned app bar'),
                      ),
                      SwitchListTile(
                        value: _floating,
                        onChanged: (v) {
                          setState(() {
                            _floating = v;
                            if (!_floating) {
                              _snap = false;
                            }
                          });
                          _push('app bar floating=$v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Floating app bar'),
                      ),
                      SwitchListTile(
                        value: _snap,
                        onChanged: _floating
                            ? (v) {
                                setState(() => _snap = v);
                                _push('app bar snap=$v');
                              }
                            : null,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Snap (requires floating)'),
                      ),
                      SwitchListTile(
                        value: _showAbsorber,
                        onChanged: (v) {
                          setState(() => _showAbsorber = v);
                          _push('overlap absorber=${v ? 'enabled' : 'disabled'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use overlap absorber/injector'),
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactItem('viewport backing', 'NestedScrollViewViewport'),
                        _FactItem('pinned', _pinned.toString()),
                        _FactItem('floating', _floating.toString()),
                        _FactItem('snap', _snap.toString()),
                        _FactItem('active tab', '$_tabIndex'),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _mint,
                          lines: const [
                            'NestedScrollView composes outer and inner slivers using a shared overlap handle.',
                            'SliverOverlapAbsorber captures overlap from the outer header; SliverOverlapInjector restores spacing in inner lists.',
                            'Without injector, inner content can start under headers, causing visual and hit-test confusion.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Coordinator timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 190, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _CoordinatorHost(
                  pinned: _pinned,
                  floating: _floating,
                  snap: _snap,
                  useAbsorber: _showAbsorber,
                  onTabChanged: (i) {
                    setState(() => _tabIndex = i);
                    _push('tab changed to $i');
                  },
                  onEvent: _push,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 46);
    });
  }
}

class _CoordinatorHost extends StatefulWidget {
  const _CoordinatorHost({
    required this.pinned,
    required this.floating,
    required this.snap,
    required this.useAbsorber,
    required this.onTabChanged,
    required this.onEvent,
  });

  final bool pinned;
  final bool floating;
  final bool snap;
  final bool useAbsorber;
  final ValueChanged<int> onTabChanged;
  final ValueChanged<String> onEvent;

  @override
  State<_CoordinatorHost> createState() => _CoordinatorHostState();
}

class _CoordinatorHostState extends State<_CoordinatorHost> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabs.addListener(_onTabUpdate);
  }

  @override
  void dispose() {
    _tabs.removeListener(_onTabUpdate);
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _mint.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          final appBar = SliverAppBar(
            expandedHeight: 172,
            pinned: widget.pinned,
            floating: widget.floating,
            snap: widget.snap,
            backgroundColor: _mint,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 56),
              title: Text(
                innerBoxIsScrolled ? 'Coordinator (inner scrolled)' : 'Coordinator (outer zone)',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              background: const _FlexibleBackdrop(
                tone: _mint,
                title: 'Nested Coordinator Header',
                subtitle: 'Overlap-aware app bar orchestrates inner panes through handle-based geometry.',
              ),
            ),
            bottom: TabBar(
              controller: _tabs,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Signals'),
                Tab(text: 'Recovery'),
              ],
            ),
          );
          if (widget.useAbsorber) {
            return [SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context), sliver: appBar)];
          }
          return [appBar];
        },
        body: TabBarView(
          controller: _tabs,
          children: [
            _CoordinatorTab(
              tone: _atlas,
              title: 'Overview Pane',
              useInjector: widget.useAbsorber,
              onEvent: widget.onEvent,
            ),
            _CoordinatorTab(
              tone: _amber,
              title: 'Signals Pane',
              useInjector: widget.useAbsorber,
              onEvent: widget.onEvent,
            ),
            _CoordinatorTab(
              tone: _clay,
              title: 'Recovery Pane',
              useInjector: widget.useAbsorber,
              onEvent: widget.onEvent,
            ),
          ],
        ),
      ),
    );
  }

  void _onTabUpdate() {
    if (!_tabs.indexIsChanging) {
      widget.onTabChanged(_tabs.index);
    }
  }
}

class _CoordinatorTab extends StatelessWidget {
  const _CoordinatorTab({
    required this.tone,
    required this.title,
    required this.useInjector,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final bool useInjector;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[];
    if (useInjector) {
      slivers.add(SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)));
    }
    slivers.add(
      SliverToBoxAdapter(
        child: _HeroBanner(
          tone: tone,
          title: title,
          subtitle: useInjector
              ? 'Injector is active: inner pane starts below absorbed overlap.'
              : 'Injector is disabled: notice how content can ride under the app bar overlap zone.',
        ),
      ),
    );
    slivers.add(
      SliverList.list(
        children: [
          _SignalTile(
            tone: tone,
            label: 'Panel 1',
            note: 'Viewport-backed inner list panel with overlap awareness.',
            onTap: () => onEvent('$title panel 1 tapped'),
          ),
          _SignalTile(
            tone: tone,
            label: 'Panel 2',
            note: 'Use this lane to inspect whether top spacing remains stable.',
            onTap: () => onEvent('$title panel 2 tapped'),
          ),
          _SignalTile(
            tone: tone,
            label: 'Panel 3',
            note: 'NestedScrollViewViewport mediates this relation between outer and inner geometry.',
            onTap: () => onEvent('$title panel 3 tapped'),
          ),
          _SignalTile(
            tone: tone,
            label: 'Panel 4',
            note: 'Interaction cards remain touchable in both absorber modes.',
            onTap: () => onEvent('$title panel 4 tapped'),
          ),
        ],
      ),
    );
    slivers.add(
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tone.withValues(alpha: 0.3)),
          ),
          child: const Text(
            'Tip: toggle absorber/injector in the parent controls to see how this inner scroll start position changes.',
            style: TextStyle(height: 1.35),
          ),
        ),
      ),
    );

    return CustomScrollView(
      key: PageStorageKey<String>('tab-$title-$useInjector'),
      slivers: slivers,
    );
  }
}

class _OverlapComparisonScene extends StatefulWidget {
  const _OverlapComparisonScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_OverlapComparisonScene> createState() => _OverlapComparisonSceneState();
}

class _OverlapComparisonSceneState extends State<_OverlapComparisonScene> {
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1160.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comparison guide', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                      'Both lanes use similar nested layouts. Left lane injects overlap back into the inner list. '
                      'Right lane does not inject and therefore demonstrates overlay drift under the header region.',
                      style: TextStyle(height: 1.35),
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _amber,
                        lines: const [
                          'Overlap handling is a geometry contract between outer and inner slivers.',
                          'When overlap is absorbed but not injected, visual alignment often appears incorrect near top boundaries.',
                          'Use side-by-side comparisons in design reviews to quickly validate nested scroll behavior.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Comparison timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _EventLog(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _OverlapLane(
                        tone: _mint,
                        title: 'With Injector',
                        useInjector: true,
                        onEvent: (e) => _push('with injector: $e'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _OverlapLane(
                        tone: _clay,
                        title: 'Without Injector',
                        useInjector: false,
                        onEvent: (e) => _push('without injector: $e'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 54);
    });
  }
}

class _OverlapLane extends StatelessWidget {
  const _OverlapLane({
    required this.tone,
    required this.title,
    required this.useInjector,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final bool useInjector;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          final appBar = SliverAppBar(
            expandedHeight: 132,
            pinned: true,
            backgroundColor: tone,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 12, bottom: 44),
              title: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              background: _FlexibleBackdrop(
                tone: tone,
                title: title,
                subtitle: useInjector ? 'Injector lane keeps spacing aligned.' : 'No-injector lane shows overlap pressure.',
              ),
            ),
          );
          return [SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context), sliver: appBar)];
        },
        body: CustomScrollView(
          slivers: [
            if (useInjector) SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  useInjector
                      ? 'This pane injects overlap and starts after header geometry.'
                      : 'This pane omits injector and may start under the header overlap.',
                ),
              ),
            ),
            SliverList.list(
              children: [
                _SignalTile(
                  tone: tone,
                  label: 'Tile A',
                  note: 'Observe top spacing while you scroll from start.',
                  onTap: () => onEvent('$title tile A'),
                ),
                _SignalTile(
                  tone: tone,
                  label: 'Tile B',
                  note: 'Compare where this tile starts in both lanes.',
                  onTap: () => onEvent('$title tile B'),
                ),
                _SignalTile(
                  tone: tone,
                  label: 'Tile C',
                  note: 'The viewport itself is nested-scroll aware.',
                  onTap: () => onEvent('$title tile C'),
                ),
                _SignalTile(
                  tone: tone,
                  label: 'Tile D',
                  note: 'Use this pair for teaching overlap contracts to teams.',
                  onTap: () => onEvent('$title tile D'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnchorClipScene extends StatefulWidget {
  const _AnchorClipScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_AnchorClipScene> createState() => _AnchorClipSceneState();
}

class _AnchorClipSceneState extends State<_AnchorClipScene> {
  final SliverOverlapAbsorberHandle _handle = SliverOverlapAbsorberHandle();
  final List<String> _events = <String>[];

  double _anchor = 0.0;
  Clip _clip = Clip.hardEdge;
  bool _overflow = true;
  bool _longHeader = true;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 960.0 : 1160.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Anchor and clip controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Anchor: ${_anchor.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                      Slider(
                        value: _anchor,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        onChanged: (v) => setState(() => _anchor = v),
                        onChangeEnd: (v) => _push('anchor=${v.toStringAsFixed(2)}'),
                      ),
                      _EnumDropdown<Clip>(
                        label: 'Clip behavior',
                        value: _clip,
                        values: const [Clip.none, Clip.hardEdge, Clip.antiAlias],
                        labelBuilder: (v) => v.name,
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _clip = v);
                            _push('clip=${v.name}');
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _overflow,
                        onChanged: (v) {
                          setState(() => _overflow = v);
                          _push('overflow cards=${v ? 'enabled' : 'disabled'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable overflow cards'),
                      ),
                      SwitchListTile(
                        value: _longHeader,
                        onChanged: (v) {
                          setState(() => _longHeader = v);
                          _push('long header=${v ? 'on' : 'off'}');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Long leading header block'),
                      ),
                      const SizedBox(height: 8),
                      _FactTable(rows: [
                        _FactItem('anchor', _anchor.toStringAsFixed(2)),
                        _FactItem('clip behavior', _clip.name),
                        _FactItem('overflow cards', _overflow.toString()),
                        _FactItem('long header', _longHeader.toString()),
                      ]),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _clay,
                          lines: const [
                            'anchor shifts the effective zero point inside the viewport extent.',
                            'clipBehavior determines whether children painting outside viewport bounds are cropped.',
                            'Overflowing child visuals are useful for validating clipping and scroll geometry interactions.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Anchor/clip timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 180, child: _EventLog(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: _clay.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _clay.withValues(alpha: 0.26)),
                  ),
                  child: Scrollable(
                    axisDirection: AxisDirection.down,
                    viewportBuilder: (context, offset) {
                      return NestedScrollViewViewport(
                        axisDirection: AxisDirection.down,
                        offset: offset,
                        anchor: _anchor,
                        handle: _handle,
                        clipBehavior: _clip,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: _clay.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _clay.withValues(alpha: 0.32)),
                              ),
                              child: Text(
                                _longHeader
                                    ? 'Long header: this intentionally occupies more vertical space so anchor changes are easier to read visually.'
                                    : 'Short header: compact top section for quick anchor checks.',
                                style: const TextStyle(height: 1.35),
                              ),
                            ),
                          ),
                          if (_longHeader)
                            SliverToBoxAdapter(
                              child: Container(
                                height: 190,
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _clay.withValues(alpha: 0.2),
                                      _indigo.withValues(alpha: 0.2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text('Extended lead region', style: TextStyle(fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ),
                          SliverList.list(
                            children: [
                              _OverflowCard(tone: _atlas, title: 'Primary overflow card', overflow: _overflow),
                              _OverflowCard(tone: _mint, title: 'Secondary overflow card', overflow: _overflow),
                              _OverflowCard(tone: _amber, title: 'Tertiary overflow card', overflow: _overflow),
                              _OverflowCard(tone: _indigo, title: 'Quaternary overflow card', overflow: _overflow),
                              _OverflowCard(tone: _clay, title: 'Final overflow card', overflow: _overflow),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 44);
    });
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  int _revision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1240.0 : 1460.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | snapshot captured');
                              _trim(_events, 64);
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear timeline'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalModule(
                              tone: _atlas,
                              title: 'Dashboard Shell',
                              subtitle: 'KPI and drilldown stack with overlap-aware feed routing.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _mint,
                              title: 'Operations Shell',
                              subtitle: 'Action lanes and runbook feed under dynamic headers.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _indigo,
                              title: 'Release Shell',
                              subtitle: 'Checklist flow with predictable nested overlap behavior.',
                              revision: _revision,
                              onEvent: (e) => _push('release: $e'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _indigo,
                        lines: const [
                          'In complex screens, nested scroll behavior is often a UX-critical contract.',
                          'Use overlap absorber/injector in each shell where app bars and inner lists intersect.',
                          'NestedScrollViewViewport keeps those sliver relationships consistent across modules.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _FactTable(rows: [
                      _FactItem('revision', '$_revision'),
                      _FactItem('timeline entries', '${_events.length}'),
                      _FactItem('clock', _clock()),
                    ]),
                    const SizedBox(height: 8),
                    const Text('Practical timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _EventLog(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      _trim(_events, 64);
    });
  }
}

class _PracticalModule extends StatefulWidget {
  const _PracticalModule({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.revision,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalModule> createState() => _PracticalModuleState();
}

class _PracticalModuleState extends State<_PracticalModule> {
  bool _pinned = true;
  bool _floating = false;
  bool _inject = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
              _ToneBadge(tone: widget.tone, text: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 3),
          Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              FilterChip(
                label: const Text('Pinned'),
                selected: _pinned,
                onSelected: (v) {
                  setState(() => _pinned = v);
                  widget.onEvent('${widget.title}: pinned=$v');
                },
              ),
              FilterChip(
                label: const Text('Floating'),
                selected: _floating,
                onSelected: (v) {
                  setState(() => _floating = v);
                  widget.onEvent('${widget.title}: floating=$v');
                },
              ),
              FilterChip(
                label: const Text('Injector'),
                selected: _inject,
                onSelected: (v) {
                  setState(() => _inject = v);
                  widget.onEvent('${widget.title}: injector=$v');
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.tone.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  final appBar = SliverAppBar(
                    expandedHeight: 118,
                    pinned: _pinned,
                    floating: _floating,
                    backgroundColor: widget.tone,
                    foregroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(start: 10, bottom: 34),
                      title: Text(widget.title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                      background: _FlexibleBackdrop(
                        tone: widget.tone,
                        title: widget.title,
                        subtitle: _inject ? 'Injector active' : 'Injector inactive',
                      ),
                    ),
                  );
                  return [SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context), sliver: appBar)];
                },
                body: CustomScrollView(
                  slivers: [
                    if (_inject) SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
                        ),
                        child: Text(
                          _inject
                              ? 'Inner content begins after overlap restoration.'
                              : 'Inner content may render under the app bar overlap area.',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SliverList.list(
                      children: [
                        _SignalTile(
                          tone: widget.tone,
                          label: 'Module tile 1',
                          note: 'Operational item routed through nested viewport geometry.',
                          onTap: () => widget.onEvent('${widget.title}: tile 1 tapped'),
                        ),
                        _SignalTile(
                          tone: widget.tone,
                          label: 'Module tile 2',
                          note: 'Compare movement when pinned/floating toggles change.',
                          onTap: () => widget.onEvent('${widget.title}: tile 2 tapped'),
                        ),
                        _SignalTile(
                          tone: widget.tone,
                          label: 'Module tile 3',
                          note: 'Demonstrates stable nested scroll composition across shells.',
                          onTap: () => widget.onEvent('${widget.title}: tile 3 tapped'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.tone, required this.title, required this.subtitle});

  final Color tone;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.2),
            tone.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontSize: 19, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(height: 1.35)),
        ],
      ),
    );
  }
}

class _GridPanel extends StatelessWidget {
  const _GridPanel({required this.index, required this.tone, required this.title});

  final int index;
  final Color tone;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.34)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Grid $index', style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            const Text(
              'Viewport-backed sliver block used for visual scanning and spacing checks.',
              style: TextStyle(fontSize: 12, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPanel extends StatelessWidget {
  const _ListPanel({required this.index, required this.tone, required this.title});

  final int index;
  final Color tone;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: tone,
            foregroundColor: Colors.white,
            child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                const Text('Large list sliver item for viewport continuity and scroll-depth demonstration.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalTile extends StatelessWidget {
  const _SignalTile({required this.tone, required this.label, required this.note, required this.onTap});

  final Color tone;
  final String label;
  final String note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w800))),
              IconButton(
                tooltip: 'Log interaction',
                onPressed: onTap,
                icon: Icon(Icons.bolt, color: tone),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(note, style: const TextStyle(height: 1.32)),
        ],
      ),
    );
  }
}

class _OverflowCard extends StatelessWidget {
  const _OverflowCard({required this.tone, required this.title, required this.overflow});

  final Color tone;
  final String title;
  final bool overflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: tone.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text(
                  'Overflow boxes below intentionally paint beyond container edges to demonstrate viewport clipping behavior.',
                  style: TextStyle(height: 1.35),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
          if (overflow)
            Positioned(
              right: -18,
              top: 42,
              child: Container(
                width: 120,
                height: 54,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Center(
                  child: Text('Overflow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FlexibleBackdrop extends StatelessWidget {
  const _FlexibleBackdrop({required this.tone, required this.title, required this.subtitle});

  final Color tone;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.95),
            tone.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFFE7F2FF), height: 1.3, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guides, required this.child});

  final bool guides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7D8E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guides) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x13000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FactItem {
  const _FactItem(this.label, this.value);

  final String label;
  final String value;
}

class _FactTable extends StatelessWidget {
  const _FactTable({required this.rows});

  final List<_FactItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 165, child: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                    Expanded(child: Text(item.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCEDDEB)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF60798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
            ),
    );
  }
}

class _EnumDropdown<T> extends StatelessWidget {
  const _EnumDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
        Expanded(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: values
                .map(
                  (v) => DropdownMenuItem<T>(
                    value: v,
                    child: Text(labelBuilder(v)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ToneBadge extends StatelessWidget {
  const _ToneBadge({required this.tone, required this.text});

  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF14374E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: NestedScrollViewViewport', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'NestedScrollViewViewport is the viewport layer that enables NestedScrollView to coordinate outer and inner slivers through overlap handles. '
            'When configured correctly with absorber/injector pairs, it supports reliable and explainable nested scrolling behavior in complex Flutter interfaces.',
            style: TextStyle(color: Color(0xFFD8EAF6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
