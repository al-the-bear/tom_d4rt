import 'package:flutter/material.dart';

const _bg = Color(0xFFF0F5FB);
const _ink = Color(0xFF163247);
const _blue = Color(0xFF2D5E8B);
const _teal = Color(0xFF2A8A81);
const _amber = Color(0xFFB98B47);
const _rose = Color(0xFF9A5E7B);
const _violet = Color(0xFF6A5FB2);

dynamic build(BuildContext context) {
  return const _ListWheelDeepDemoApp();
}

class _ListWheelDeepDemoApp extends StatelessWidget {
  const _ListWheelDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _ListWheelDeepDemoPage(),
    );
  }
}

class _ListWheelDeepDemoPage extends StatefulWidget {
  const _ListWheelDeepDemoPage();

  @override
  State<_ListWheelDeepDemoPage> createState() => _ListWheelDeepDemoPageState();
}

class _ListWheelDeepDemoPageState extends State<_ListWheelDeepDemoPage> {
  bool _compact = false;
  bool _guide = true;
  bool _tips = true;
  bool _rtl = false;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 86,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ListWheelScrollView Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'cylindrical list projection | geometry tuning | delegate strategies | controller-driven interaction',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                guide: _guide,
                tips: _tips,
                rtl: _rtl,
                scale: _scale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _guide = v),
                onTipsChanged: (v) => setState(() => _tips = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _scale = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'Wheel Fundamentals Theater',
                subtitle:
                    'Core ListWheelScrollView behavior with fixed item extent, selected index reporting, and centered selection lane.',
                child: _FundamentalsScene(compact: _compact, guide: _guide, tips: _tips, scale: _scale),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Geometry Parameter Lab',
                subtitle:
                    'Interactive controls for diameterRatio, perspective, squeeze, offAxisFraction, magnifier, and overAndUnderCenterOpacity.',
                child: _GeometryScene(compact: _compact, guide: _guide, tips: _tips),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Delegate Strategies Gallery',
                subtitle:
                    'Compares direct children, builder delegate, and looping delegate while preserving the same wheel semantics.',
                child: _DelegateScene(compact: _compact, guide: _guide, tips: _tips),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Physics and Controller Desk',
                subtitle:
                    'Uses FixedExtentScrollController with jump/animate controls and physics variants to demonstrate deterministic wheel control.',
                child: _PhysicsScene(compact: _compact, guide: _guide, tips: _tips),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Wheel Compositions',
                subtitle:
                    'Real examples: schedule picker, command dial, and wheel-driven dashboard controls integrated into one workspace.',
                child: _PracticalScene(compact: _compact, guide: _guide, tips: _tips),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.guide,
    required this.tips,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onTipsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool guide;
  final bool tips;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onTipsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF18384D), Color(0xFF2E5E7F), Color(0xFF4E6E90), Color(0xFF6D60A9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ListWheel Interaction Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'ListWheelScrollView creates a cylindrical projection for fixed-extent items. '
            'Use this when focused selection and rotational depth cues are useful for dense option sets.',
            style: TextStyle(color: Color(0xFFDEECF8), height: 1.35),
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
                  value: guide,
                  onChanged: onGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: tips,
                  onChanged: onTipsChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show tips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
          const SizedBox(height: 4),
          Text('Visual scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: scale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.30),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 7)),
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
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F60), height: 1.34)),
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

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guide, required this.tips, required this.scale});

  final bool compact;
  final bool guide;
  final bool tips;
  final double scale;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  late final FixedExtentScrollController _controller;
  int _selected = 8;
  bool _showCenterLine = true;

  final List<String> _items = List<String>.generate(30, (i) => 'Station ${i + 1}');

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: _selected);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 700.0 : 840.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fundamental controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => _animateTo((_selected - 1).clamp(0, _items.length - 1)),
                        child: const Text('Select previous'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => _animateTo((_selected + 1).clamp(0, _items.length - 1)),
                        child: const Text('Select next'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => _animateTo(0),
                        child: const Text('Jump to first'),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _showCenterLine,
                        onChanged: (v) => setState(() => _showCenterLine = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show center selection lane'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'selected index', value: '$_selected'),
                          _InfoRow(label: 'selected label', value: _items[_selected]),
                          _InfoRow(label: 'itemExtent', value: '62 px'),
                          _InfoRow(label: 'controller item', value: '${_controller.selectedItem}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.tips)
                        _Tips(
                          lines: const [
                            'ListWheelScrollView requires fixed item extent for all children.',
                            'onSelectedItemChanged fires as the centered item changes.',
                            'FixedExtentScrollController provides reliable jump/animate-to-index behavior.',
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
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.scale,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ListWheelScrollView.useDelegate(
                          controller: _controller,
                          itemExtent: 62,
                          diameterRatio: 2.1,
                          perspective: 0.002,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) => setState(() => _selected = i),
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index >= _items.length) {
                                return null;
                              }
                              return _WheelCard(
                                title: _items[index],
                                index: index,
                                selected: index == _selected,
                                tone: _blue,
                              );
                            },
                            childCount: _items.length,
                          ),
                        ),
                      ),
                      if (_showCenterLine)
                        IgnorePointer(
                          child: Center(
                            child: Container(
                              height: 66,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _blue.withValues(alpha: 0.46), width: 2),
                                color: _blue.withValues(alpha: 0.08),
                              ),
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

  Future<void> _animateTo(int index) async {
    await _controller.animateToItem(index, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
  }
}

class _GeometryScene extends StatefulWidget {
  const _GeometryScene({required this.compact, required this.guide, required this.tips});

  final bool compact;
  final bool guide;
  final bool tips;

  @override
  State<_GeometryScene> createState() => _GeometrySceneState();
}

class _GeometrySceneState extends State<_GeometryScene> {
  late final FixedExtentScrollController _controller;
  int _selected = 5;

  double _diameterRatio = 1.9;
  double _perspective = 0.002;
  double _squeeze = 1.1;
  double _offAxis = 0.0;
  bool _magnifier = true;
  double _magnification = 1.15;
  double _centerOpacity = 0.72;

  final List<String> _samples = const [
    'Aurora',
    'Borealis',
    'Cirrus',
    'Dune',
    'Ember',
    'Flux',
    'Glint',
    'Helix',
    'Ion',
    'Jade',
    'Kite',
    'Lumen',
  ];

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: _selected);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 760.0 : 900.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Geometry controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderRow(label: 'diameterRatio', value: _diameterRatio, min: 1.1, max: 3.2, onChanged: (v) => setState(() => _diameterRatio = v)),
                      _SliderRow(label: 'perspective', value: _perspective, min: 0.0005, max: 0.01, onChanged: (v) => setState(() => _perspective = v)),
                      _SliderRow(label: 'squeeze', value: _squeeze, min: 0.7, max: 1.8, onChanged: (v) => setState(() => _squeeze = v)),
                      _SliderRow(label: 'offAxisFraction', value: _offAxis, min: -0.8, max: 0.8, onChanged: (v) => setState(() => _offAxis = v)),
                      _SliderRow(label: 'magnification', value: _magnification, min: 1.0, max: 1.7, onChanged: (v) => setState(() => _magnification = v)),
                      _SliderRow(label: 'center opacity', value: _centerOpacity, min: 0.2, max: 1.0, onChanged: (v) => setState(() => _centerOpacity = v)),
                      SwitchListTile(
                        value: _magnifier,
                        onChanged: (v) => setState(() => _magnifier = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('useMagnifier'),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'selected', value: _samples[_selected]),
                          _InfoRow(label: 'index', value: '$_selected'),
                          _InfoRow(label: 'diameter', value: _diameterRatio.toStringAsFixed(2)),
                          _InfoRow(label: 'offAxis', value: _offAxis.toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.tips)
                        _Tips(
                          lines: const [
                            'diameterRatio controls wheel curvature depth.',
                            'perspective adjusts projection strength; too high can feel distorted.',
                            'offAxisFraction shifts wheel center horizontally for asymmetrical layouts.',
                            'useMagnifier + magnification enlarges centered item for stronger selection emphasis.',
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
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ListWheelScrollView(
                        controller: _controller,
                        itemExtent: 58,
                        diameterRatio: _diameterRatio,
                        perspective: _perspective,
                        squeeze: _squeeze,
                        offAxisFraction: _offAxis,
                        useMagnifier: _magnifier,
                        magnification: _magnification,
                        overAndUnderCenterOpacity: _centerOpacity,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (i) => setState(() => _selected = i),
                        children: List<Widget>.generate(
                          _samples.length,
                          (i) => _WheelCard(
                            title: _samples[i],
                            index: i,
                            selected: i == _selected,
                            tone: _teal,
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Center(
                        child: Container(
                          height: 62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _teal.withValues(alpha: 0.46), width: 2),
                            color: _teal.withValues(alpha: 0.08),
                          ),
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

class _DelegateScene extends StatefulWidget {
  const _DelegateScene({required this.compact, required this.guide, required this.tips});

  final bool compact;
  final bool guide;
  final bool tips;

  @override
  State<_DelegateScene> createState() => _DelegateSceneState();
}

class _DelegateSceneState extends State<_DelegateScene> {
  late final FixedExtentScrollController _listController;
  late final FixedExtentScrollController _builderController;
  late final FixedExtentScrollController _loopController;

  int _listIndex = 3;
  int _builderIndex = 5;
  int _loopIndex = 1;

  final List<String> _fixed = const [
    'Atlas',
    'Beacon',
    'Comet',
    'Delta',
    'Echo',
    'Fjord',
    'Grove',
    'Harbor',
    'Isle',
    'Jet',
    'Keel',
    'Lagoon',
  ];

  @override
  void initState() {
    super.initState();
    _listController = FixedExtentScrollController(initialItem: _listIndex);
    _builderController = FixedExtentScrollController(initialItem: _builderIndex);
    _loopController = FixedExtentScrollController(initialItem: _loopIndex);
  }

  @override
  void dispose() {
    _listController.dispose();
    _builderController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 760.0 : 900.0;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delegate overview', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'List delegate', value: _fixed[_listIndex]),
                          _InfoRow(label: 'Builder delegate', value: 'Item ${_builderIndex + 1}'),
                          _InfoRow(label: 'Looping delegate', value: _fixed[_loopIndex % _fixed.length]),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.tips)
                        _Tips(
                          lines: const [
                            'children: simple for known static lists.',
                            'useDelegate + ListWheelChildBuilderDelegate: efficient for large or virtualized data.',
                            'ListWheelChildLoopingListDelegate: repeats a finite child set endlessly.',
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
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _DelegateColumn(
                        title: 'children',
                        tone: _blue,
                        child: ListWheelScrollView(
                          controller: _listController,
                          itemExtent: 54,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) => setState(() => _listIndex = i),
                          children: List<Widget>.generate(
                            _fixed.length,
                            (i) => _WheelCard(title: _fixed[i], index: i, selected: i == _listIndex, tone: _blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DelegateColumn(
                        title: 'builder delegate',
                        tone: _teal,
                        child: ListWheelScrollView.useDelegate(
                          controller: _builderController,
                          itemExtent: 54,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) => setState(() => _builderIndex = i),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 40,
                            builder: (context, index) {
                              if (index < 0 || index >= 40) {
                                return null;
                              }
                              final label = 'Metric ${index + 1}';
                              return _WheelCard(title: label, index: index, selected: index == _builderIndex, tone: _teal);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DelegateColumn(
                        title: 'looping delegate',
                        tone: _amber,
                        child: ListWheelScrollView.useDelegate(
                          controller: _loopController,
                          itemExtent: 54,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) => setState(() => _loopIndex = i),
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              _fixed.length,
                              (i) => _WheelCard(title: _fixed[i], index: i, selected: i == (_loopIndex % _fixed.length), tone: _amber),
                            ),
                          ),
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
        border: Border.all(color: tone.withValues(alpha: 0.40)),
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
            child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

enum _PhysicsMode {
  fixed,
  bouncing,
  clamping,
}

class _PhysicsScene extends StatefulWidget {
  const _PhysicsScene({required this.compact, required this.guide, required this.tips});

  final bool compact;
  final bool guide;
  final bool tips;

  @override
  State<_PhysicsScene> createState() => _PhysicsSceneState();
}

class _PhysicsSceneState extends State<_PhysicsScene> {
  late final FixedExtentScrollController _controller;
  int _selected = 10;
  _PhysicsMode _physics = _PhysicsMode.fixed;
  final List<String> _log = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: _selected);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 780.0 : 920.0;
    final physicsWidget = switch (_physics) {
      _PhysicsMode.fixed => const FixedExtentScrollPhysics(),
      _PhysicsMode.bouncing => const BouncingScrollPhysics(parent: FixedExtentScrollPhysics()),
      _PhysicsMode.clamping => const ClampingScrollPhysics(parent: FixedExtentScrollPhysics()),
    };

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _Panel(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Controller actions', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _jumpTo((_selected - 5).clamp(0, 59)),
                            child: const Text('Jump -5'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _jumpTo((_selected + 5).clamp(0, 59)),
                            child: const Text('Jump +5'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _animateTo((_selected - 1).clamp(0, 59)),
                            child: const Text('Animate -1'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _animateTo((_selected + 1).clamp(0, 59)),
                            child: const Text('Animate +1'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<_PhysicsMode>(
                        segments: const [
                          ButtonSegment(value: _PhysicsMode.fixed, label: Text('Fixed')),
                          ButtonSegment(value: _PhysicsMode.bouncing, label: Text('Bouncing')),
                          ButtonSegment(value: _PhysicsMode.clamping, label: Text('Clamping')),
                        ],
                        selected: {_physics},
                        onSelectionChanged: (s) => setState(() => _physics = s.first),
                      ),
                      const SizedBox(height: 8),
                      _InfoTable(
                        rows: [
                          _InfoRow(label: 'selected', value: '$_selected'),
                          _InfoRow(label: 'controller', value: '${_controller.selectedItem}'),
                          _InfoRow(label: 'physics', value: _physics.name),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.tips)
                        _Tips(
                          lines: const [
                            'FixedExtentScrollController works with wheel item indices, not pixel offsets.',
                            'animateToItem is ideal for guided transitions and scripted selections.',
                            'physics affects motion feel while selected-item semantics remain fixed.',
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
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ListWheelScrollView.useDelegate(
                        controller: _controller,
                        itemExtent: 56,
                        physics: physicsWidget,
                        diameterRatio: 2.0,
                        onSelectedItemChanged: (i) {
                          setState(() {
                            _selected = i;
                            _log.insert(0, '${_clock()} | selected $i');
                            if (_log.length > 28) {
                              _log.removeRange(28, _log.length);
                            }
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context, index) {
                            if (index < 0 || index >= 60) {
                              return null;
                            }
                            return _WheelCard(
                              title: 'Frame ${index + 1}',
                              index: index,
                              selected: index == _selected,
                              tone: _rose,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 4,
                      child: _LogPanel(lines: _log),
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

  void _jumpTo(int index) {
    _controller.jumpToItem(index);
    setState(() {
      _selected = index;
      _log.insert(0, '${_clock()} | jumpToItem($index)');
      if (_log.length > 28) {
        _log.removeRange(28, _log.length);
      }
    });
  }

  Future<void> _animateTo(int index) async {
    await _controller.animateToItem(index, duration: const Duration(milliseconds: 320), curve: Curves.easeInOutCubic);
    if (!mounted) {
      return;
    }
    setState(() {
      _selected = index;
      _log.insert(0, '${_clock()} | animateToItem($index)');
      if (_log.length > 28) {
        _log.removeRange(28, _log.length);
      }
    });
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guide, required this.tips});

  final bool compact;
  final bool guide;
  final bool tips;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _modeController;

  int _hour = 9;
  int _minute = 3;
  int _mode = 0;

  bool _showOverlay = true;
  bool _showEvents = true;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
    _modeController = FixedExtentScrollController(initialItem: _mode);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _modeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 980.0 : 1180.0;
    final modes = ['Calm', 'Focus', 'Rapid', 'Review'];

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _Panel(
              guide: widget.guide,
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
                          onPressed: () {
                            _animateSchedule(9, 3);
                            _animateMode(1);
                            _push('preset: morning focus');
                          },
                          child: const Text('Preset: Morning Focus'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            _animateSchedule(14, 6);
                            _animateMode(2);
                            _push('preset: afternoon rapid');
                          },
                          child: const Text('Preset: Afternoon Rapid'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            _animateSchedule(20, 10);
                            _animateMode(3);
                            _push('preset: evening review');
                          },
                          child: const Text('Preset: Evening Review'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _showOverlay,
                          label: const Text('Selection overlay'),
                          onSelected: (v) => setState(() => _showOverlay = v),
                        ),
                        FilterChip(
                          selected: _showEvents,
                          label: const Text('Show events panel'),
                          onSelected: (v) => setState(() => _showEvents = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _workspaceSurface(modes),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: _summaryPanel(modes),
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
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoTable(
                      rows: [
                        _InfoRow(label: 'hour', value: _hour.toString().padLeft(2, '0')),
                        _InfoRow(label: 'minute', value: (_minute * 5).toString().padLeft(2, '0')),
                        _InfoRow(label: 'mode', value: modes[_mode]),
                        _InfoRow(label: 'overlay', value: _showOverlay ? 'visible' : 'hidden'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.tips)
                      _Tips(
                        lines: const [
                          'Wheel pickers can replace dense dropdowns in command surfaces.',
                          'Multiple wheels can be synchronized to produce compound states.',
                          'Selection changes can drive dashboards and execution controls in real time.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Recent events', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: _showEvents
                          ? _events.isEmpty
                              ? const Text('No events yet.', style: TextStyle(color: Color(0xFF627789)))
                              : ListView.builder(
                                  itemCount: _events.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(_events[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                                    );
                                  },
                                )
                          : const Text('Event panel hidden.', style: TextStyle(color: Color(0xFF627789))),
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

  Widget _workspaceSurface(List<String> modes) {
    final timeLabel = '${_hour.toString().padLeft(2, '0')}:${(_minute * 5).toString().padLeft(2, '0')}';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC6D8EA)),
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
            child: Text('Command Console | $timeLabel | ${modes[_mode]}', style: const TextStyle(color: _ink, fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _wheelBox('Hour', _hourController, 24, _hour, _amber, (i) => setState(() => _hour = i))),
                Expanded(child: _wheelBox('Minute', _minuteController, 12, _minute, _teal, (i) => setState(() => _minute = i))),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        ListWheelScrollView.useDelegate(
                          controller: _modeController,
                          itemExtent: 54,
                          useMagnifier: true,
                          magnification: 1.10,
                          overAndUnderCenterOpacity: 0.75,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) => setState(() => _mode = i),
                          childDelegate: ListWheelChildListDelegate(
                            children: List<Widget>.generate(
                              modes.length,
                              (i) => _WheelCard(title: modes[i], index: i, selected: i == _mode, tone: _violet),
                            ),
                          ),
                        ),
                        if (_showOverlay)
                          IgnorePointer(
                            child: Center(
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: _violet.withValues(alpha: 0.42), width: 2),
                                  color: _violet.withValues(alpha: 0.08),
                                ),
                              ),
                            ),
                          ),
                      ],
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

  Widget _summaryPanel(List<String> modes) {
    final progress = ((_hour / 23) * 0.5) + ((_minute / 11) * 0.5);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FCFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Live Snapshot', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          _InfoTable(
            rows: [
              _InfoRow(label: 'time', value: '${_hour.toString().padLeft(2, '0')}:${(_minute * 5).toString().padLeft(2, '0')}'),
              _InfoRow(label: 'mode', value: modes[_mode]),
              _InfoRow(label: 'queue', value: '${_hour + (_minute * 2)} items'),
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
              widthFactor: progress.clamp(0.0, 1.0),
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
                _miniMetric('Latency', '${90 + (_minute * 3)}ms', _blue),
                _miniMetric('Threads', '${4 + (_mode * 2)}', _teal),
                _miniMetric('Load', '${(progress * 100).toStringAsFixed(0)}%', _amber),
                _miniMetric('Priority', '${_mode + 1}', _rose),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _wheelBox(
    String title,
    FixedExtentScrollController controller,
    int count,
    int selected,
    Color tone,
    ValueChanged<int> onSelected,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              children: [
                ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 54,
                  useMagnifier: true,
                  magnification: 1.12,
                  overAndUnderCenterOpacity: 0.78,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: onSelected,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: count,
                    builder: (context, index) {
                      if (index < 0 || index >= count) {
                        return null;
                      }
                      final label = title == 'Minute'
                          ? (index * 5).toString().padLeft(2, '0')
                          : index.toString().padLeft(2, '0');
                      return _WheelCard(title: label, index: index, selected: index == selected, tone: tone);
                    },
                  ),
                ),
                if (_showOverlay)
                  IgnorePointer(
                    child: Center(
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: tone.withValues(alpha: 0.42), width: 2),
                          color: tone.withValues(alpha: 0.08),
                        ),
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

  Widget _miniMetric(String label, String value, Color tone) {
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(color: _ink, fontWeight: FontWeight.w800, fontSize: 17)),
        ],
      ),
    );
  }

  Future<void> _animateSchedule(int hour, int minute) async {
    await _hourController.animateToItem(hour, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
    await _minuteController.animateToItem(minute, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
    if (!mounted) {
      return;
    }
    setState(() {
      _hour = hour;
      _minute = minute;
    });
  }

  Future<void> _animateMode(int mode) async {
    await _modeController.animateToItem(mode, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
    if (!mounted) {
      return;
    }
    setState(() => _mode = mode);
  }

  void _push(String text) {
    setState(() {
      _events.insert(0, '${_clock()} | $text');
      if (_events.length > 36) {
        _events.removeRange(36, _events.length);
      }
    });
  }
}

class _WheelCard extends StatelessWidget {
  const _WheelCard({required this.title, required this.index, required this.selected, required this.tone});

  final String title;
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
          color: selected ? tone.withValues(alpha: 0.70) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? tone : tone.withValues(alpha: 0.35), width: selected ? 2 : 1.2),
          boxShadow: [
            if (selected)
              BoxShadow(color: tone.withValues(alpha: 0.22), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              '#${index + 1}',
              style: TextStyle(
                color: selected ? Colors.black : tone,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.black : const Color(0xFF2F475D),
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
  const _Panel({required this.guide, required this.child});

  final bool guide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC4D5E6)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guide) const CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x0F000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InfoRow {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;
}

class _InfoTable extends StatelessWidget {
  const _InfoTable({required this.rows});

  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD4E2EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text(r.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

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
        Text('$label: ${value.toStringAsFixed(3)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _Tips extends StatelessWidget {
  const _Tips({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF183A53),
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
                      child: Icon(Icons.circle, size: 7, color: Color(0xFF8ED4FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFD6EAFB), height: 1.34))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogPanel extends StatelessWidget {
  const _LogPanel({required this.lines});

  final List<String> lines;

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
          const Text('Controller Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: lines.isEmpty
                ? const Text('No log events yet.', style: TextStyle(color: Color(0xFF637889)))
                : ListView.builder(
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(lines[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF14354E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: ListWheelScrollView', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ListWheelScrollView is a strong choice for focused option browsing with clear centered selection and cylindrical depth cues. '
            'Pair it with FixedExtentScrollController for deterministic index control and combine geometry parameters '
            'to tune clarity, emphasis, and spatial feel for your app context.',
            style: TextStyle(color: Color(0xFFD7E6F4), height: 1.36),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
