import 'package:flutter/material.dart';

const _shellBg = Color(0xFFF4F7FA);
const _ink = Color(0xFF162E44);
const _ocean = Color(0xFF23638A);
const _forest = Color(0xFF2D7D66);
const _amber = Color(0xFFB6863A);
const _coral = Color(0xFFAA5A58);
const _violet = Color(0xFF695CB0);

dynamic build(BuildContext context) {
  return const _ListWheelViewportDeepDemoApp();
}

class _ListWheelViewportDeepDemoApp extends StatelessWidget {
  const _ListWheelViewportDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _ocean),
        scaffoldBackgroundColor: _shellBg,
      ),
      home: const _ListWheelViewportDeepDemoPage(),
    );
  }
}

class _ListWheelViewportDeepDemoPage extends StatefulWidget {
  const _ListWheelViewportDeepDemoPage();

  @override
  State<_ListWheelViewportDeepDemoPage> createState() => _ListWheelViewportDeepDemoPageState();
}

class _ListWheelViewportDeepDemoPageState extends State<_ListWheelViewportDeepDemoPage> {
  bool _compact = false;
  bool _showGuide = true;
  bool _showNotes = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 90,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelViewport Deep Demo'),
              Text(
                'raw wheel viewport composition | scroll pipeline | delegate control | practical wheel consoles',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.84), fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopDeck(
                compact: _compact,
                showGuide: _showGuide,
                showNotes: _showNotes,
                rtl: _rtl,
                globalScale: _globalScale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _showGuide = v),
                onNotesChanged: (v) => setState(() => _showNotes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _globalScale = v),
              ),
              const SizedBox(height: 12),
              _SceneContainer(
                index: 1,
                tone: _ocean,
                title: 'Raw Viewport Foundations',
                subtitle:
                    'Build a wheel directly from Scrollable + viewportBuilder + ListWheelViewport, without ListWheelScrollView wrapper.',
                child: _RawFoundationsScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes, globalScale: _globalScale),
              ),
              const SizedBox(height: 12),
              _SceneContainer(
                index: 2,
                tone: _forest,
                title: 'Geometry Forge',
                subtitle:
                    'Tune wheel projection parameters to understand how ListWheelViewport shapes depth, focus, and spatial feel.',
                child: _GeometryForgeScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneContainer(
                index: 3,
                tone: _amber,
                title: 'Delegate Workshop',
                subtitle:
                    'Compare list, builder, and looping delegates rendered through the same raw viewport pipeline.',
                child: _DelegateWorkshopScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneContainer(
                index: 4,
                tone: _coral,
                title: 'Scroll Pipeline Lab',
                subtitle:
                    'Use controller commands and physics changes to inspect wheel behavior at the viewport level.',
                child: _ScrollPipelineScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneContainer(
                index: 5,
                tone: _violet,
                title: 'Practical Wheel Console',
                subtitle:
                    'Compose synchronized wheels (time, lane, priority) into a production-style command planning panel.',
                child: _PracticalConsoleScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
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

class _TopDeck extends StatelessWidget {
  const _TopDeck({
    required this.compact,
    required this.showGuide,
    required this.showNotes,
    required this.rtl,
    required this.globalScale,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGuide;
  final bool showNotes;
  final bool rtl;
  final double globalScale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF152E45), Color(0xFF205274), Color(0xFF317163), Color(0xFF5A5DA9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ListWheelViewport Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
          ),
          const SizedBox(height: 6),
          const Text(
            'ListWheelViewport is the low-level wheel viewport widget. '
            'It is useful when you need custom Scrollable composition, specialized controllers, '
            'or tailored rendering pipelines beyond the convenience wrapper.',
            style: TextStyle(color: Color(0xFFDEEBF7), height: 1.35),
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
                  title: const Text('Compact mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showGuide,
                  onChanged: onGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide grids', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showNotes,
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
                  title: const Text('RTL direction', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Global scene scale: ${globalScale.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: globalScale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneContainer extends StatelessWidget {
  const _SceneContainer({
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 7)),
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
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3B5266), height: 1.34)),
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

enum _ChildDelegateKind {
  list,
  builder,
  looping,
}

class _ViewportWheel extends StatefulWidget {
  const _ViewportWheel({
    super.key,
    required this.itemExtent,
    required this.items,
    required this.childDelegateKind,
    required this.tone,
    required this.onSelectedChanged,
    required this.onPixelsChanged,
    this.initialIndex = 0,
    this.physics,
    this.diameterRatio = 2.0,
    this.perspective = 0.002,
    this.offAxisFraction = 0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.overAndUnderCenterOpacity = 1.0,
    this.showCenterOverlay = true,
  });

  final double itemExtent;
  final List<String> items;
  final _ChildDelegateKind childDelegateKind;
  final Color tone;
  final ValueChanged<int> onSelectedChanged;
  final ValueChanged<double> onPixelsChanged;
  final int initialIndex;
  final ScrollPhysics? physics;
  final double diameterRatio;
  final double perspective;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final double overAndUnderCenterOpacity;
  final bool showCenterOverlay;

  @override
  State<_ViewportWheel> createState() => _ViewportWheelState();
}

class _ViewportWheelState extends State<_ViewportWheel> {
  late ScrollController _controller;
  int _selected = 0;

  ScrollController get controller => _controller;
  int get selectedIndex => _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex.clamp(0, widget.items.length - 1);
    _controller = ScrollController(initialScrollOffset: _selected * widget.itemExtent);
    _controller.addListener(_syncSelectionFromPixels);
  }

  @override
  void didUpdateWidget(covariant _ViewportWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemExtent != widget.itemExtent) {
      _controller
        ..removeListener(_syncSelectionFromPixels)
        ..dispose();
      _controller = ScrollController(initialScrollOffset: _selected * widget.itemExtent);
      _controller.addListener(_syncSelectionFromPixels);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_syncSelectionFromPixels);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scrollable(
          controller: _controller,
          axisDirection: AxisDirection.down,
          physics: widget.physics ?? const FixedExtentScrollPhysics(),
          viewportBuilder: (context, offset) {
            return ListWheelViewport(
              offset: offset,
              itemExtent: widget.itemExtent,
              diameterRatio: widget.diameterRatio,
              perspective: widget.perspective,
              offAxisFraction: widget.offAxisFraction,
              useMagnifier: widget.useMagnifier,
              magnification: widget.magnification,
              overAndUnderCenterOpacity: widget.overAndUnderCenterOpacity,
              childDelegate: _buildDelegate(),
            );
          },
        ),
        if (widget.showCenterOverlay)
          IgnorePointer(
            child: Center(
              child: Container(
                height: widget.itemExtent + 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.44), width: 2),
                  color: widget.tone.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> animateToIndex(int index, {Duration? duration, Curve? curve}) async {
    final clamped = index.clamp(0, widget.items.length - 1);
    await _controller.animateTo(
      clamped * widget.itemExtent,
      duration: duration ?? const Duration(milliseconds: 300),
      curve: curve ?? Curves.easeOutCubic,
    );
  }

  void jumpToIndex(int index) {
    final clamped = index.clamp(0, widget.items.length - 1);
    _controller.jumpTo(clamped * widget.itemExtent);
  }

  ListWheelChildDelegate _buildDelegate() {
    switch (widget.childDelegateKind) {
      case _ChildDelegateKind.list:
        return ListWheelChildListDelegate(
          children: List<Widget>.generate(
            widget.items.length,
            (i) => _WheelCell(
              label: widget.items[i],
              index: i,
              selected: i == _selected,
              tone: widget.tone,
            ),
          ),
        );
      case _ChildDelegateKind.builder:
        return ListWheelChildBuilderDelegate(
          childCount: widget.items.length,
          builder: (context, index) {
            if (index < 0 || index >= widget.items.length) {
              return null;
            }
            return _WheelCell(
              label: widget.items[index],
              index: index,
              selected: index == _selected,
              tone: widget.tone,
            );
          },
        );
      case _ChildDelegateKind.looping:
        return ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(
            widget.items.length,
            (i) => _WheelCell(
              label: widget.items[i],
              index: i,
              selected: i == (_selected % widget.items.length),
              tone: widget.tone,
            ),
          ),
        );
    }
  }

  void _syncSelectionFromPixels() {
    widget.onPixelsChanged(_controller.offset);
    final next = (_controller.offset / widget.itemExtent).round().clamp(0, widget.items.length - 1);
    if (next != _selected) {
      setState(() => _selected = next);
      widget.onSelectedChanged(next);
    }
  }
}

class _RawFoundationsScene extends StatefulWidget {
  const _RawFoundationsScene({required this.compact, required this.showGuide, required this.showNotes, required this.globalScale});

  final bool compact;
  final bool showGuide;
  final bool showNotes;
  final double globalScale;

  @override
  State<_RawFoundationsScene> createState() => _RawFoundationsSceneState();
}

class _RawFoundationsSceneState extends State<_RawFoundationsScene> {
  final GlobalKey<_ViewportWheelState> _wheelKey = GlobalKey<_ViewportWheelState>();
  int _selected = 6;
  double _pixels = 0;
  bool _overlay = true;

  final List<String> _stops = List<String>.generate(24, (i) => 'Dock ${i + 1}');

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 760.0 : 920.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Foundation controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _wheelKey.currentState?.animateToIndex((_selected - 1).clamp(0, _stops.length - 1)),
                            child: const Text('Animate -1'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _wheelKey.currentState?.animateToIndex((_selected + 1).clamp(0, _stops.length - 1)),
                            child: const Text('Animate +1'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _wheelKey.currentState?.jumpToIndex(0),
                            child: const Text('Jump first'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _wheelKey.currentState?.jumpToIndex(_stops.length - 1),
                            child: const Text('Jump last'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show center lane overlay'),
                      ),
                      const SizedBox(height: 8),
                      _KeyValueTable(
                        rows: [
                          _KeyValue('selected index', '$_selected'),
                          _KeyValue('selected label', _stops[_selected]),
                          _KeyValue('pixel offset', _pixels.toStringAsFixed(1)),
                          _KeyValue('computed item', (_pixels / 60).toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionCard(
                          tone: _ocean,
                          lines: const [
                            'ListWheelViewport does not create its own Scrollable. You provide one using Scrollable(viewportBuilder: ...).',
                            'The ViewportOffset from Scrollable drives the wheel position and determines selected item center.',
                            'This is useful when custom scroll pipelines, bespoke controllers, or advanced nesting are needed.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.globalScale,
                  alignment: Alignment.topCenter,
                  child: _ViewportWheel(
                    key: _wheelKey,
                    itemExtent: 60,
                    initialIndex: _selected,
                    items: _stops,
                    tone: _ocean,
                    childDelegateKind: _ChildDelegateKind.builder,
                    showCenterOverlay: _overlay,
                    onPixelsChanged: (p) => setState(() => _pixels = p),
                    onSelectedChanged: (i) => setState(() => _selected = i),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GeometryForgeScene extends StatefulWidget {
  const _GeometryForgeScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_GeometryForgeScene> createState() => _GeometryForgeSceneState();
}

class _GeometryForgeSceneState extends State<_GeometryForgeScene> {
  int _selected = 4;
  double _pixels = 0;

  double _diameterRatio = 2.0;
  double _perspective = 0.002;
  double _offAxis = 0;
  bool _useMagnifier = true;
  double _magnification = 1.17;
  double _opacity = 0.75;

  final List<String> _labels = const [
    'North',
    'North-East',
    'East',
    'South-East',
    'South',
    'South-West',
    'West',
    'North-West',
    'Zenith',
    'Nadir',
    'Orbit',
    'Core',
  ];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 820.0 : 980.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Geometry controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _LabeledSlider(
                        label: 'diameterRatio',
                        value: _diameterRatio,
                        min: 1.1,
                        max: 3.6,
                        onChanged: (v) => setState(() => _diameterRatio = v),
                      ),
                      _LabeledSlider(
                        label: 'perspective',
                        value: _perspective,
                        min: 0.0005,
                        max: 0.01,
                        onChanged: (v) => setState(() => _perspective = v),
                      ),
                      _LabeledSlider(
                        label: 'offAxisFraction',
                        value: _offAxis,
                        min: -0.9,
                        max: 0.9,
                        onChanged: (v) => setState(() => _offAxis = v),
                      ),
                      _LabeledSlider(
                        label: 'magnification',
                        value: _magnification,
                        min: 1.0,
                        max: 1.7,
                        onChanged: (v) => setState(() => _magnification = v),
                      ),
                      _LabeledSlider(
                        label: 'center opacity',
                        value: _opacity,
                        min: 0.2,
                        max: 1.0,
                        onChanged: (v) => setState(() => _opacity = v),
                      ),
                      SwitchListTile(
                        value: _useMagnifier,
                        onChanged: (v) => setState(() => _useMagnifier = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable center magnifier'),
                      ),
                      const SizedBox(height: 8),
                      _KeyValueTable(
                        rows: [
                          _KeyValue('selected', _labels[_selected]),
                          _KeyValue('index', '$_selected'),
                          _KeyValue('offset px', _pixels.toStringAsFixed(1)),
                          _KeyValue('diameter', _diameterRatio.toStringAsFixed(2)),
                          _KeyValue('perspective', _perspective.toStringAsFixed(4)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionCard(
                          tone: _forest,
                          lines: const [
                            'Higher diameterRatio flattens the wheel arc; lower values increase curvature.',
                            'Perspective controls projection depth. Very high values may feel visually harsh.',
                            'offAxisFraction shifts the cylinder center sideways, useful for asymmetric layouts.',
                            'Magnifier settings can prioritize center readability for selection-heavy interfaces.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _ViewportWheel(
                  itemExtent: 58,
                  initialIndex: _selected,
                  items: _labels,
                  tone: _forest,
                  childDelegateKind: _ChildDelegateKind.list,
                  diameterRatio: _diameterRatio,
                  perspective: _perspective,
                  offAxisFraction: _offAxis,
                  useMagnifier: _useMagnifier,
                  magnification: _magnification,
                  overAndUnderCenterOpacity: _opacity,
                  onPixelsChanged: (p) => setState(() => _pixels = p),
                  onSelectedChanged: (i) => setState(() => _selected = i),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DelegateWorkshopScene extends StatefulWidget {
  const _DelegateWorkshopScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_DelegateWorkshopScene> createState() => _DelegateWorkshopSceneState();
}

class _DelegateWorkshopSceneState extends State<_DelegateWorkshopScene> {
  int _listSelected = 2;
  int _builderSelected = 5;
  int _loopingSelected = 1;
  double _listPixels = 0;
  double _builderPixels = 0;
  double _loopingPixels = 0;

  final List<String> _series = const [
    'Aster',
    'Beryl',
    'Cinder',
    'Dahlia',
    'Elm',
    'Fable',
    'Garnet',
    'Haven',
    'Iris',
    'Juniper',
    'Knot',
    'Larch',
  ];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 820.0 : 980.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delegate comparison', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _KeyValueTable(
                        rows: [
                          _KeyValue('list delegate', _series[_listSelected]),
                          _KeyValue('builder delegate', 'row ${_builderSelected + 1}'),
                          _KeyValue('looping delegate', _series[_loopingSelected % _series.length]),
                          _KeyValue('list px', _listPixels.toStringAsFixed(1)),
                          _KeyValue('builder px', _builderPixels.toStringAsFixed(1)),
                          _KeyValue('looping px', _loopingPixels.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'List delegate is straightforward for bounded, static child sets.',
                            'Builder delegate is efficient for large or data-driven collections where building on demand matters.',
                            'Looping delegate repeats finite content endlessly for cyclic controls like dials and selectors.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _DelegateColumn(
                        title: 'ListWheelChildListDelegate',
                        tone: _ocean,
                        child: _ViewportWheel(
                          itemExtent: 54,
                          initialIndex: _listSelected,
                          items: _series,
                          tone: _ocean,
                          childDelegateKind: _ChildDelegateKind.list,
                          onPixelsChanged: (p) => setState(() => _listPixels = p),
                          onSelectedChanged: (i) => setState(() => _listSelected = i),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DelegateColumn(
                        title: 'ListWheelChildBuilderDelegate',
                        tone: _forest,
                        child: _ViewportWheel(
                          itemExtent: 54,
                          initialIndex: _builderSelected,
                          items: List<String>.generate(40, (i) => 'Metric ${i + 1}'),
                          tone: _forest,
                          childDelegateKind: _ChildDelegateKind.builder,
                          onPixelsChanged: (p) => setState(() => _builderPixels = p),
                          onSelectedChanged: (i) => setState(() => _builderSelected = i),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DelegateColumn(
                        title: 'ListWheelChildLoopingListDelegate',
                        tone: _amber,
                        child: _ViewportWheel(
                          itemExtent: 54,
                          initialIndex: _loopingSelected,
                          items: _series,
                          tone: _amber,
                          childDelegateKind: _ChildDelegateKind.looping,
                          onPixelsChanged: (p) => setState(() => _loopingPixels = p),
                          onSelectedChanged: (i) => setState(() => _loopingSelected = i),
                        ),
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
}

class _DelegateColumn extends StatelessWidget {
  const _DelegateColumn({required this.title, required this.tone, required this.child});

  final String title;
  final Color tone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

enum _PipelinePhysics {
  fixed,
  bouncing,
  clamping,
}

class _ScrollPipelineScene extends StatefulWidget {
  const _ScrollPipelineScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_ScrollPipelineScene> createState() => _ScrollPipelineSceneState();
}

class _ScrollPipelineSceneState extends State<_ScrollPipelineScene> {
  final GlobalKey<_ViewportWheelState> _wheelKey = GlobalKey<_ViewportWheelState>();

  int _selected = 8;
  double _pixels = 0;
  _PipelinePhysics _physics = _PipelinePhysics.fixed;
  final List<String> _log = <String>[];

  final List<String> _frames = List<String>.generate(64, (i) => 'Frame ${i + 1}');

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 860.0 : 1040.0;
    final physics = switch (_physics) {
      _PipelinePhysics.fixed => const FixedExtentScrollPhysics(),
      _PipelinePhysics.bouncing => const BouncingScrollPhysics(parent: FixedExtentScrollPhysics()),
      _PipelinePhysics.clamping => const ClampingScrollPhysics(parent: FixedExtentScrollPhysics()),
    };

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pipeline controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {
                              final next = (_selected - 6).clamp(0, _frames.length - 1);
                              _wheelKey.currentState?.jumpToIndex(next);
                              _pushLog('jumpToIndex($next)');
                            },
                            child: const Text('Jump -6'),
                          ),
                          FilledButton.tonal(
                            onPressed: () {
                              final next = (_selected + 6).clamp(0, _frames.length - 1);
                              _wheelKey.currentState?.jumpToIndex(next);
                              _pushLog('jumpToIndex($next)');
                            },
                            child: const Text('Jump +6'),
                          ),
                          FilledButton.tonal(
                            onPressed: () async {
                              final next = (_selected - 1).clamp(0, _frames.length - 1);
                              await _wheelKey.currentState?.animateToIndex(next);
                              _pushLog('animateToIndex($next)');
                            },
                            child: const Text('Animate -1'),
                          ),
                          FilledButton.tonal(
                            onPressed: () async {
                              final next = (_selected + 1).clamp(0, _frames.length - 1);
                              await _wheelKey.currentState?.animateToIndex(next);
                              _pushLog('animateToIndex($next)');
                            },
                            child: const Text('Animate +1'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<_PipelinePhysics>(
                        segments: const [
                          ButtonSegment(value: _PipelinePhysics.fixed, label: Text('Fixed')),
                          ButtonSegment(value: _PipelinePhysics.bouncing, label: Text('Bouncing')),
                          ButtonSegment(value: _PipelinePhysics.clamping, label: Text('Clamping')),
                        ],
                        selected: {_physics},
                        onSelectionChanged: (v) => setState(() => _physics = v.first),
                      ),
                      const SizedBox(height: 8),
                      _KeyValueTable(
                        rows: [
                          _KeyValue('selected', '$_selected'),
                          _KeyValue('label', _frames[_selected]),
                          _KeyValue('offset px', _pixels.toStringAsFixed(1)),
                          _KeyValue('physics', _physics.name),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionCard(
                          tone: _coral,
                          lines: const [
                            'When composing ListWheelViewport manually, Scrollable physics and controller strategy are explicit decisions.',
                            'Using viewport-level composition allows additional instrumentation and synchronization in complex UIs.',
                            'A wheel can be made deterministic with jump/animate commands while retaining natural gesture scrolling.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _ViewportWheel(
                        key: _wheelKey,
                        itemExtent: 56,
                        initialIndex: _selected,
                        items: _frames,
                        tone: _coral,
                        childDelegateKind: _ChildDelegateKind.builder,
                        physics: physics,
                        onPixelsChanged: (p) => setState(() => _pixels = p),
                        onSelectedChanged: (i) {
                          setState(() => _selected = i);
                          _pushLog('selected changed -> $i');
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 4,
                      child: _LogCard(logs: _log),
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

  void _pushLog(String entry) {
    setState(() {
      _log.insert(0, '${_clock()} | $entry');
      if (_log.length > 32) {
        _log.removeRange(32, _log.length);
      }
    });
  }
}

class _PracticalConsoleScene extends StatefulWidget {
  const _PracticalConsoleScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_PracticalConsoleScene> createState() => _PracticalConsoleSceneState();
}

class _PracticalConsoleSceneState extends State<_PracticalConsoleScene> {
  final GlobalKey<_ViewportWheelState> _hourKey = GlobalKey<_ViewportWheelState>();
  final GlobalKey<_ViewportWheelState> _slotKey = GlobalKey<_ViewportWheelState>();
  final GlobalKey<_ViewportWheelState> _priorityKey = GlobalKey<_ViewportWheelState>();

  int _hour = 8;
  int _slot = 2;
  int _priority = 1;
  bool _overlay = true;
  bool _eventPanel = true;

  final List<String> _events = <String>[];
  final List<String> _hours = List<String>.generate(24, (i) => i.toString().padLeft(2, '0'));
  final List<String> _slots = const ['Plan', 'Build', 'Review', 'Deploy', 'Observe', 'Refactor', 'Sync', 'Publish'];
  final List<String> _priorities = const ['Low', 'Normal', 'High', 'Critical'];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1000.0 : 1220.0;
    final minute = (_slot * 7) % 60;
    final timeline = '${_hours[_hour]}:${minute.toString().padLeft(2, '0')}';

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _Panel(
              showGuide: widget.showGuide,
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
                          onPressed: () async {
                            await _preset(hour: 9, slot: 1, priority: 2, name: 'Morning Build Window');
                          },
                          child: const Text('Preset: Morning Build'),
                        ),
                        FilledButton.tonal(
                          onPressed: () async {
                            await _preset(hour: 14, slot: 3, priority: 1, name: 'Afternoon Deploy Window');
                          },
                          child: const Text('Preset: Afternoon Deploy'),
                        ),
                        FilledButton.tonal(
                          onPressed: () async {
                            await _preset(hour: 20, slot: 5, priority: 3, name: 'Evening Critical Review');
                          },
                          child: const Text('Preset: Critical Review'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _overlay,
                          label: const Text('Center overlays'),
                          onSelected: (v) => setState(() => _overlay = v),
                        ),
                        FilterChip(
                          selected: _eventPanel,
                          label: const Text('Show event panel'),
                          onSelected: (v) => setState(() => _eventPanel = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _workspaceCard(
                              timeline: timeline,
                              priority: _priorities[_priority],
                              slot: _slots[_slot],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: _insightCard(
                              timeline: timeline,
                              priority: _priorities[_priority],
                              slot: _slots[_slot],
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
            child: _Panel(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Console notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _KeyValueTable(
                      rows: [
                        _KeyValue('time', timeline),
                        _KeyValue('slot', _slots[_slot]),
                        _KeyValue('priority', _priorities[_priority]),
                        _KeyValue('overlay', _overlay ? 'on' : 'off'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.showNotes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'Multiple raw ListWheelViewport controls can be synchronized to produce one combined command state.',
                          'This pattern is useful for schedule pickers, dial-style control surfaces, and constrained operations consoles.',
                          'Viewport-level composition lets each wheel choose its own delegate, geometry, and physics profile.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Recent events', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: _eventPanel
                          ? _events.isEmpty
                              ? const Text('No events yet.', style: TextStyle(color: Color(0xFF61788D)))
                              : ListView.builder(
                                  itemCount: _events.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(_events[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                                    );
                                  },
                                )
                          : const Text('Event panel hidden.', style: TextStyle(color: Color(0xFF61788D))),
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

  Widget _workspaceCard({required String timeline, required String slot, required String priority}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC9DAEC)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _violet.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text('Ops Planner | $timeline | $slot | $priority', style: const TextStyle(color: _ink, fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ViewportWheel(
                      key: _hourKey,
                      itemExtent: 54,
                      initialIndex: _hour,
                      items: _hours,
                      tone: _amber,
                      childDelegateKind: _ChildDelegateKind.builder,
                      showCenterOverlay: _overlay,
                      onPixelsChanged: (_) {},
                      onSelectedChanged: (i) {
                        setState(() => _hour = i);
                        _push('hour -> ${_hours[i]}');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ViewportWheel(
                      key: _slotKey,
                      itemExtent: 54,
                      initialIndex: _slot,
                      items: _slots,
                      tone: _forest,
                      childDelegateKind: _ChildDelegateKind.looping,
                      showCenterOverlay: _overlay,
                      onPixelsChanged: (_) {},
                      onSelectedChanged: (i) {
                        setState(() => _slot = i % _slots.length);
                        _push('slot -> ${_slots[i % _slots.length]}');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ViewportWheel(
                      key: _priorityKey,
                      itemExtent: 54,
                      initialIndex: _priority,
                      items: _priorities,
                      tone: _coral,
                      childDelegateKind: _ChildDelegateKind.list,
                      showCenterOverlay: _overlay,
                      onPixelsChanged: (_) {},
                      onSelectedChanged: (i) {
                        setState(() => _priority = i);
                        _push('priority -> ${_priorities[i]}');
                      },
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

  Widget _insightCard({required String timeline, required String slot, required String priority}) {
    final urgency = (_priority + 1) / _priorities.length;
    final load = ((_hour / 23) * 0.55) + ((_slot + 1) / _slots.length * 0.45);
    final readiness = (urgency * 0.45) + (load * 0.55);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD4E2EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Live Insight', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          _KeyValueTable(
            rows: [
              _KeyValue('timeline', timeline),
              _KeyValue('slot', slot),
              _KeyValue('priority', priority),
              _KeyValue('queue estimate', '${(_hour * 2) + (_slot * 3) + _priority * 5} items'),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Execution readiness', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: _violet.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: readiness.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: _violet, borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.45,
              children: [
                _metricTile('Latency', '${60 + (_slot * 5)}ms', _ocean),
                _metricTile('Threads', '${2 + (_priority * 2)}', _forest),
                _metricTile('Load', '${(load * 100).toStringAsFixed(0)}%', _amber),
                _metricTile('Urgency', '${(urgency * 100).toStringAsFixed(0)}%', _coral),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricTile(String name, String value, Color tone) {
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.34)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(color: tone, fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(color: _ink, fontSize: 17, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Future<void> _preset({required int hour, required int slot, required int priority, required String name}) async {
    await _hourKey.currentState?.animateToIndex(hour);
    await _slotKey.currentState?.animateToIndex(slot);
    await _priorityKey.currentState?.animateToIndex(priority);
    if (!mounted) {
      return;
    }
    setState(() {
      _hour = hour;
      _slot = slot;
      _priority = priority;
    });
    _push('preset -> $name');
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      if (_events.length > 36) {
        _events.removeRange(36, _events.length);
      }
    });
  }
}

class _WheelCell extends StatelessWidget {
  const _WheelCell({required this.label, required this.index, required this.selected, required this.tone});

  final String label;
  final int index;
  final bool selected;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected ? tone.withValues(alpha: 0.72) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? tone : tone.withValues(alpha: 0.35),
            width: selected ? 2 : 1.2,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: tone.withValues(alpha: 0.23),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              '#${index + 1}',
              style: TextStyle(color: selected ? Colors.black : tone, fontWeight: FontWeight.w700, fontSize: 12),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.black : const Color(0xFF31485E),
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.showGuide, required this.child});

  final bool showGuide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuide) const CustomPaint(painter: _GuidePainter()),
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
    final linePaint = Paint()..color = const Color(0x10000000);
    const step = 24.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KeyValue {
  const _KeyValue(this.key, this.value);

  final String key;
  final String value;
}

class _KeyValueTable extends StatelessWidget {
  const _KeyValueTable({required this.rows});

  final List<_KeyValue> rows;

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
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 130, child: Text(row.key, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    Expanded(child: Text(row.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(3)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
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
        color: tone.withValues(alpha: 0.94),
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
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBDE5FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFE8F5FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.logs});

  final List<String> logs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scroll Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: logs.isEmpty
                ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
                : ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(logs[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      );
                    },
                  ),
          ),
        ],
      ),
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
        color: const Color(0xFF14354C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: ListWheelViewport', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ListWheelViewport is the low-level building block behind wheel-style scrolling UIs. '
            'When you need custom scroll orchestration, direct viewport composition, and precise delegate/geometry control, '
            'it provides a flexible foundation while preserving the familiar wheel interaction model.',
            style: TextStyle(color: Color(0xFFD7E8F7), height: 1.35),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
