import 'package:flutter/material.dart';

class _DemoTheme {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _DemoTheme({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
  });
}

const _themes = <_DemoTheme>[
  _DemoTheme(
    name: 'Navy Ember',
    primary: Color(0xFF1E3A8A),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF0D9488),
    background: Color(0xFFF4F7FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _DemoTheme(
    name: 'Pine Rose',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFBE123C),
    accent: Color(0xFF2563EB),
    background: Color(0xFFF2FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1C312D),
    muted: Color(0xFF5C6E68),
  ),
  _DemoTheme(
    name: 'Graphite Lime',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF6B7280),
  ),
];

enum _Stage {
  fundamentals,
  rulerLab,
  mixedStory,
  axisArena,
  performanceTheater,
  verificationAtlas,
}

enum _AxisChoice {
  vertical,
  horizontal,
}

class _ShellProfile {
  final String label;
  final double height;
  final double extent;
  final int count;

  const _ShellProfile({
    required this.label,
    required this.height,
    required this.extent,
    required this.count,
  });
}

const _presetProfiles = <_ShellProfile>[
  _ShellProfile(label: 'Compact', height: 430, extent: 82, count: 10),
  _ShellProfile(label: 'Balanced', height: 560, extent: 96, count: 12),
  _ShellProfile(label: 'Large', height: 700, extent: 112, count: 14),
];

dynamic build(BuildContext context) {
  return const _FixedExtentBoxAdaptorStudio();
}

class _FixedExtentBoxAdaptorStudio extends StatefulWidget {
  const _FixedExtentBoxAdaptorStudio();

  @override
  State<_FixedExtentBoxAdaptorStudio> createState() =>
      _FixedExtentBoxAdaptorStudioState();
}

class _FixedExtentBoxAdaptorStudioState
    extends State<_FixedExtentBoxAdaptorStudio> {
  _Stage _stage = _Stage.fundamentals;
  int _themeIndex = 0;
  bool _verbose = false;

  double _fundamentalExtent = 92;
  double _fundamentalCount = 11;
  bool _fundamentalShowChips = true;
  bool _fundamentalPad = true;

  double _rulerExtent = 88;
  double _rulerCount = 8;
  bool _rulerShowGrid = true;
  bool _rulerShowMarkers = true;

  double _storyLeadCount = 2;
  double _storyExtent = 100;
  bool _storyPinned = true;
  bool _storyFloating = false;
  bool _storyShowFooter = true;

  _AxisChoice _axisChoice = _AxisChoice.vertical;
  double _axisExtent = 96;
  double _axisCount = 10;
  double _axisGap = 8;
  bool _axisPad = true;
  bool _axisShowLegend = true;

  bool _theaterTriView = true;
  double _theaterCustomHeight = 620;
  double _theaterCustomExtent = 104;
  double _theaterCustomCount = 12;
  bool _theaterShowMetrics = true;

  static const _stageNames = <String>[
    '1 Fixed-Extent Fundamentals',
    '2 Precision Ruler Lab',
    '3 Mixed Sliver Storyline',
    '4 Axis and Density Arena',
    '5 Device Performance Theater',
    '6 Verification Atlas',
  ];

  _DemoTheme get _t => _themes[_themeIndex];

  Axis get _axis =>
      _axisChoice == _AxisChoice.vertical ? Axis.vertical : Axis.horizontal;

  void _log(String text) {
    if (_verbose) {
      debugPrint('[RenderSliverFixedExtentBoxAdaptorDemo] $text');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _t.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _topToolbar(),
            Expanded(child: _stageBody()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_t.primary, _t.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.straighten_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'RenderSliverFixedExtentBoxAdaptor Studio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Fixed Main-Axis Extent Mechanics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'RenderSliverFixedExtentBoxAdaptor underpins fixed-extent sliver '
            'lists where each child has the same main-axis size. This demo '
            'explores precision sizing, composition patterns, axis behavior, '
            'and responsive viewport outcomes.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.5,
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _topToolbar() {
    return Container(
      width: double.infinity,
      color: _t.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(
              color: _t.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _stageNames.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _t.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _t.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              onSelected: (_) {
                setState(() => _stage = _Stage.values[i]);
                _log('stage => ${_stage.name}');
              },
            ),
          const SizedBox(width: 10),
          Text(
            'Palette',
            style: TextStyle(
              color: _t.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _themes.length; i++)
            GestureDetector(
              onTap: () => setState(() => _themeIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _themes[i].primary,
                  border: Border.all(
                    color: _themeIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(color: _t.ink, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _t.accent,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.fundamentals:
        return _fundamentalsStage();
      case _Stage.rulerLab:
        return _rulerLabStage();
      case _Stage.mixedStory:
        return _mixedStoryStage();
      case _Stage.axisArena:
        return _axisArenaStage();
      case _Stage.performanceTheater:
        return _performanceTheaterStage();
      case _Stage.verificationAtlas:
        return _verificationAtlasStage();
    }
  }

  Widget _fundamentalsStage() {
    final count = _fundamentalCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Fixed-Extent Fundamentals'),
          const SizedBox(height: 8),
          Text(
            'This baseline scene demonstrates the key idea: each child in '
            'SliverFixedExtentList gets exactly the same main-axis extent. '
            'RenderSliverFixedExtentBoxAdaptor powers this efficient layout model.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Fundamental Controls',
            subtitle: 'Adjust extent and child count.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'itemExtent',
                  value: _fundamentalExtent,
                  min: 56,
                  max: 160,
                  divisions: 13,
                  color: _t.primary,
                  display: _fundamentalExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _fundamentalExtent = v),
                ),
                _sliderRow(
                  label: 'item count',
                  value: _fundamentalCount,
                  min: 4,
                  max: 18,
                  divisions: 14,
                  color: _t.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _fundamentalCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _fundamentalShowChips,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _fundamentalShowChips = v ?? true),
                    ),
                    Text('show metric chips',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _fundamentalPad,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _fundamentalPad = v ?? true),
                    ),
                    Text('outer padding rail',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('extent', _fundamentalExtent.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _chip('count', '$count', _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Fundamental Viewport',
            subtitle: 'Inspect equal-height lanes and spacing rhythm.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 580,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _banner(
                            icon: Icons.linear_scale_rounded,
                            text: 'RenderSliverFixedExtentBoxAdaptor via SliverFixedExtentList',
                          ),
                        ),
                        SliverPadding(
                          padding: _fundamentalPad
                              ? const EdgeInsets.fromLTRB(10, 4, 10, 8)
                              : EdgeInsets.zero,
                          sliver: SliverFixedExtentList.builder(
                            itemExtent: _fundamentalExtent,
                            itemCount: count,
                            itemBuilder: (context, index) =>
                                _fundamentalTile(index),
                          ),
                        ),
                      ],
                    ),
                    if (_fundamentalShowChips)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip(
                          'mode',
                          'fixed-extent',
                          _t.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'Every row stays the same size regardless of content. That '
            'predictability supports smooth scrolling and efficient child '
            'position calculations.',
          ),
        ],
      ),
    );
  }

  Widget _fundamentalTile(int index) {
    final color = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.33),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fixed Tile ${index + 1}',
                  style: TextStyle(
                    color: _t.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Main-axis extent locked by itemExtent.',
                  style: TextStyle(
                    color: _t.muted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${_fundamentalExtent.toStringAsFixed(0)} px',
              style: TextStyle(
                color: _t.ink,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rulerLabStage() {
    final count = _rulerCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Precision Ruler Lab'),
          const SizedBox(height: 8),
          Text(
            'This lab overlays visual guides so fixed extents are easy to '
            'inspect. It helps validate that each child occupies a consistent '
            'main-axis band regardless of interior content density.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Ruler Controls',
            subtitle: 'Tune guide visibility and extent.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'ruler extent',
                  value: _rulerExtent,
                  min: 64,
                  max: 140,
                  divisions: 19,
                  color: _t.primary,
                  display: _rulerExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _rulerExtent = v),
                ),
                _sliderRow(
                  label: 'ruler cards',
                  value: _rulerCount,
                  min: 4,
                  max: 14,
                  divisions: 10,
                  color: _t.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _rulerCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rulerShowGrid,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _rulerShowGrid = v ?? true),
                    ),
                    Text('show interval grid',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _rulerShowMarkers,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _rulerShowMarkers = v ?? true),
                    ),
                    Text('show extent markers',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('extent', _rulerExtent.toStringAsFixed(0), _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Ruler Viewport',
            subtitle: 'Overlay lines show consistent extent increments.',
            tint: _t.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _banner(
                            icon: Icons.architecture_rounded,
                            text: 'Ruler guide for fixed-extent interval checks',
                          ),
                        ),
                        SliverFixedExtentList.builder(
                          itemExtent: _rulerExtent,
                          itemCount: count,
                          itemBuilder: (context, index) =>
                              _rulerTile(index, _rulerExtent),
                        ),
                      ],
                    ),
                    if (_rulerShowGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _ExtentGridPainter(
                              color: _t.primary.withValues(alpha: 0.16),
                              spacing: _rulerExtent,
                            ),
                          ),
                        ),
                      ),
                    if (_rulerShowMarkers)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _chip('extent', '${_rulerExtent.toStringAsFixed(0)} px',
                                _t.secondary),
                            const SizedBox(height: 6),
                            _chip('children', '$count', _t.primary),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Lab Notes',
            subtitle: 'What this reveals.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Each row boundary aligns to a predictable extent interval.'),
                _bullet('Content richness does not alter outer lane size.'),
                _bullet('Fixed extents simplify scroll offset math and index mapping.'),
                _bullet('Great for chat rows, logs, and consistently sized dashboard strips.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rulerTile(int index, double extent) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.view_agenda_rounded, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Ruler lane ${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontWeight: FontWeight.w700,
                fontSize: 12.2,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${extent.toStringAsFixed(0)} px',
              style: TextStyle(
                color: _t.ink,
                fontFamily: 'monospace',
                fontSize: 10.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mixedStoryStage() {
    final lead = _storyLeadCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Mixed Sliver Storyline'),
          const SizedBox(height: 8),
          Text(
            'A realistic page combines multiple sliver types. This scene puts '
            'a fixed-extent segment between lead context and optional footer to '
            'show how the adaptor participates in larger compositions.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Storyline Controls',
            subtitle: 'Header behavior and fixed lane sizing.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'lead cards',
                  value: _storyLeadCount,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  color: _t.primary,
                  display: '$lead',
                  onChanged: (v) => setState(() => _storyLeadCount = v),
                ),
                _sliderRow(
                  label: 'fixed extent',
                  value: _storyExtent,
                  min: 72,
                  max: 144,
                  divisions: 18,
                  color: _t.secondary,
                  display: _storyExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _storyExtent = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _storyPinned,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _storyPinned = v ?? true),
                    ),
                    Text('pinned header',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _storyFloating,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _storyFloating = v ?? false),
                    ),
                    Text('floating header',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _storyShowFooter,
                      activeColor: _t.accent,
                      onChanged: (v) =>
                          setState(() => _storyShowFooter = v ?? true),
                    ),
                    Text('show footer',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('extent', _storyExtent.toStringAsFixed(0), _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Storyline Viewport',
            subtitle: 'AppBar + lead slivers + fixed-extent run + footer.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 620,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: _storyPinned,
                      floating: _storyFloating,
                      expandedHeight: 120,
                      backgroundColor: _t.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text('Mixed Sliver Narrative',
                            style: TextStyle(fontSize: 13)),
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [_t.primary, _t.secondary],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _banner(
                        icon: Icons.timeline_rounded,
                        text: 'Lead context before fixed-extent chapter',
                      ),
                    ),
                    SliverList.builder(
                      itemCount: lead,
                      itemBuilder: (context, index) => _leadCard(index),
                    ),
                    SliverToBoxAdapter(
                      child: _banner(
                        icon: Icons.view_stream_rounded,
                        text: 'Fixed-extent chapter using adaptor-backed sliver',
                      ),
                    ),
                    SliverFixedExtentList.builder(
                      itemExtent: _storyExtent,
                      itemCount: 8,
                      itemBuilder: (context, index) => _storyFixedTile(index),
                    ),
                    if (_storyShowFooter)
                      SliverToBoxAdapter(
                        child: _storyFooter(),
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

  Widget _leadCard(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: _t.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lead context ${index + 1}',
            style: TextStyle(
              color: _t.ink,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Non-fixed sliver content that precedes a fixed-extent segment.',
            style: TextStyle(color: _t.muted, fontSize: 11.1),
          ),
        ],
      ),
    );
  }

  Widget _storyFixedTile(int index) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tone.withValues(alpha: 0.34),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Fixed story tile ${index + 1} (extent ${_storyExtent.toStringAsFixed(0)})',
              style: TextStyle(
                color: _t.ink,
                fontSize: 11.8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storyFooter() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _t.accent.withValues(alpha: 0.17),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _t.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Storyline footer',
            style: TextStyle(
              color: _t.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Fixed-extent segments pair well with regular sliver sections '
            'for structured, multi-part interfaces.',
            style: TextStyle(color: _t.muted, fontSize: 11.4, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _axisArenaStage() {
    final count = _axisCount.round();
    final horizontal = _axis == Axis.horizontal;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Axis and Density Arena'),
          const SizedBox(height: 8),
          Text(
            'Fixed-extent behavior applies in both directions. This arena '
            'demonstrates vertical rows and horizontal strips, with gap and '
            'density controls for layout tuning.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Arena Controls',
            subtitle: 'Axis, extent, count, and spacing.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _choice('Vertical', _axisChoice == _AxisChoice.vertical,
                        () {
                      setState(() => _axisChoice = _AxisChoice.vertical);
                    }),
                    _choice('Horizontal',
                        _axisChoice == _AxisChoice.horizontal, () {
                      setState(() => _axisChoice = _AxisChoice.horizontal);
                    }),
                  ],
                ),
                _sliderRow(
                  label: 'item extent',
                  value: _axisExtent,
                  min: 64,
                  max: 160,
                  divisions: 12,
                  color: _t.primary,
                  display: _axisExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _axisExtent = v),
                ),
                _sliderRow(
                  label: 'item count',
                  value: _axisCount,
                  min: 4,
                  max: 16,
                  divisions: 12,
                  color: _t.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _axisCount = v),
                ),
                _sliderRow(
                  label: 'tile gap',
                  value: _axisGap,
                  min: 0,
                  max: 20,
                  divisions: 10,
                  color: _t.accent,
                  display: _axisGap.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _axisGap = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _axisPad,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _axisPad = v ?? true),
                    ),
                    Text('apply sliver padding',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _axisShowLegend,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _axisShowLegend = v ?? true),
                    ),
                    Text('legend chip',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('axis', horizontal ? 'horizontal' : 'vertical', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: horizontal
                ? 'Horizontal Fixed-Extent Strip'
                : 'Vertical Fixed-Extent Strip',
            subtitle: horizontal
                ? 'Main-axis extent is width for each tile.'
                : 'Main-axis extent is height for each tile.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: horizontal ? 330 : 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      scrollDirection: _axis,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        if (!horizontal)
                          SliverToBoxAdapter(
                            child: _banner(
                              icon: Icons.swap_vert_rounded,
                              text: 'Vertical fixed-extent lanes',
                            ),
                          ),
                        SliverPadding(
                          padding: _axisPad
                              ? EdgeInsets.all(_axisGap)
                              : EdgeInsets.zero,
                          sliver: SliverFixedExtentList.builder(
                            itemExtent: _axisExtent,
                            itemCount: count,
                            itemBuilder: (context, index) =>
                                _axisTile(index, horizontal),
                          ),
                        ),
                      ],
                    ),
                    if (_axisShowLegend)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip(
                          'extent',
                          '${_axisExtent.toStringAsFixed(0)} px',
                          _t.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Arena Guidance',
            subtitle: 'Interpretation pointers.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Vertical mode is ideal for consistent row feeds.'),
                _bullet('Horizontal mode is ideal for card rails and strips.'),
                _bullet('Extent value controls readability and information density.'),
                _bullet('Gap and padding tune breathing space without changing extent math.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _axisTile(int index, bool horizontal) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: horizontal ? 10 : _axisGap / 2,
          horizontal: horizontal ? _axisGap / 2 : 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tone.withValues(alpha: 0.84), _t.accent.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              horizontal ? Icons.swap_horiz_rounded : Icons.swap_vert_rounded,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 6),
            Text(
              horizontal ? 'Strip ${index + 1}' : 'Row ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_axisExtent.toStringAsFixed(0)} px fixed extent',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.93),
                fontSize: 11.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _performanceTheaterStage() {
    final customCount = _theaterCustomCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Device Performance Theater'),
          const SizedBox(height: 8),
          Text(
            'This theater compares device shell profiles with different '
            'heights and extents. It helps evaluate fixed-extent readability '
            'and pacing across responsive viewports.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Theater Controls',
            subtitle: 'Preset trio or custom profile.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _theaterTriView,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _theaterTriView = v ?? true),
                    ),
                    Text('show preset trio',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('mode', _theaterTriView ? 'trio' : 'custom', _t.primary),
                  ],
                ),
                _sliderRow(
                  label: 'custom height',
                  value: _theaterCustomHeight,
                  min: 420,
                  max: 760,
                  divisions: 17,
                  color: _t.primary,
                  display: _theaterCustomHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _theaterCustomHeight = v),
                ),
                _sliderRow(
                  label: 'custom extent',
                  value: _theaterCustomExtent,
                  min: 72,
                  max: 150,
                  divisions: 13,
                  color: _t.secondary,
                  display: _theaterCustomExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _theaterCustomExtent = v),
                ),
                _sliderRow(
                  label: 'custom count',
                  value: _theaterCustomCount,
                  min: 6,
                  max: 18,
                  divisions: 12,
                  color: _t.accent,
                  display: '$customCount',
                  onChanged: (v) => setState(() => _theaterCustomCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _theaterShowMetrics,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _theaterShowMetrics = v ?? true),
                    ),
                    Text('show profile metrics',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_theaterTriView)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final profile in _presetProfiles)
                  _shellViewportCard(profile: profile),
              ],
            )
          else
            _shellViewportCard(
              profile: _ShellProfile(
                label: 'Custom',
                height: _theaterCustomHeight,
                extent: _theaterCustomExtent,
                count: customCount,
              ),
            ),
          const SizedBox(height: 12),
          _panel(
            title: 'Theater Findings',
            subtitle: 'Responsive behavior notes.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Smaller shells favor lower extents for readable density.'),
                _bullet('Larger shells can use taller extents for calm visual cadence.'),
                _bullet('Fixed extents simplify consistency across device classes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shellViewportCard({required _ShellProfile profile}) {
    return SizedBox(
      width: 400,
      child: _panel(
        title: '${profile.label} shell',
        subtitle:
            'height ${profile.height.toStringAsFixed(0)} | extent ${profile.extent.toStringAsFixed(0)} | count ${profile.count}',
        tint: _t.primary.withValues(alpha: 0.04),
        child: SizedBox(
          height: profile.height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
            ),
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _banner(
                        icon: Icons.devices_rounded,
                        text: '${profile.label} profile showcase',
                      ),
                    ),
                    SliverFixedExtentList.builder(
                      itemExtent: profile.extent,
                      itemCount: profile.count,
                      itemBuilder: (context, index) =>
                          _profileTile(index, profile.label),
                    ),
                  ],
                ),
                if (_theaterShowMetrics)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _chip(
                      'extent',
                      profile.extent.toStringAsFixed(0),
                      _t.secondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileTile(int index, String label) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.speed_rounded, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label lane ${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontSize: 12.1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'fixed',
              style: TextStyle(
                color: _t.ink,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 10.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verificationAtlasStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Atlas'),
          const SizedBox(height: 12),
          _panel(
            title: 'Behavior Matrix',
            subtitle: 'RenderSliverFixedExtentBoxAdaptor understanding map.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Class role',
                  value:
                      'Base render strategy for slivers with equal child main-axis extents.',
                ),
                _matrixRow(
                  keyText: 'Typical widget path',
                  value:
                      'Used through SliverFixedExtentList and related fixed-extent patterns.',
                ),
                _matrixRow(
                  keyText: 'Key input',
                  value:
                      'itemExtent determines the exact size each child receives along the scroll axis.',
                ),
                _matrixRow(
                  keyText: 'Value proposition',
                  value:
                      'Predictable geometry, efficient offset calculations, and steady visual rhythm.',
                ),
                _matrixRow(
                  keyText: 'Best use cases',
                  value:
                      'Logs, consistent feed rows, timetable lanes, and metric dashboards.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Practical integration guidance.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use fixed extent for uniform row systems',
                  detail:
                      'Improves rhythm and keeps scroll behavior stable across long lists.',
                ),
                _doDont(
                  good: false,
                  title: 'Use fixed extent for highly variable content heights',
                  detail:
                      'Variable-height slivers are usually better when row heights differ significantly.',
                ),
                _doDont(
                  good: true,
                  title: 'Tune extent by viewport and readability',
                  detail:
                      'Pick extents that match target devices and interaction goals.',
                ),
                _doDont(
                  good: false,
                  title: 'Mix inconsistent extents in one visual lane',
                  detail:
                      'Use one fixed value per lane for coherent presentation.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common implementation questions.',
            child: Column(
              children: [
                _qa(
                  q: 'What does this render class optimize?',
                  a: 'It optimizes sliver layout when all child extents are '
                      'equal along the main axis.',
                ),
                _qa(
                  q: 'How is it different from SliverList?',
                  a: 'SliverList supports variable extents; fixed-extent '
                      'paths trade flexibility for predictable geometry.',
                ),
                _qa(
                  q: 'Can I use it horizontally?',
                  a: 'Yes. In a horizontal CustomScrollView, fixed extent '
                      'represents item width instead of height.',
                ),
                _qa(
                  q: 'When is fixed extent a bad fit?',
                  a: 'When content requires truly dynamic heights or width '
                      'driven by data length.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo acceptance points.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Fundamentals stage demonstrates fixed extent and item count controls.'),
                _check('Ruler lab shows visual interval verification overlays.'),
                _check('Mixed storyline integrates fixed-extent lanes with other slivers.'),
                _check('Axis arena covers vertical and horizontal fixed-extent behavior.'),
                _check('Performance theater validates responsive shell outcomes.'),
                _check('Atlas includes matrix, do/dont, FAQ, and verification checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'RenderSliverFixedExtentBoxAdaptor is the engine behind stable, '
            'uniform sliver lanes. Use it whenever consistent main-axis '
            'sizing and predictable scrolling are core requirements.',
          ),
        ],
      ),
    );
  }

  Widget _choice(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      selected: selected,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: selected ? Colors.white : _t.ink,
        fontSize: 11.4,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => onTap(),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required String display,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 220,
          child: Text(
            '$label: $display',
            style: TextStyle(color: _t.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _t.ink,
          fontFamily: 'monospace',
          fontSize: 10.4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _banner({required IconData icon, required String text}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _t.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: _t.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _t.ink,
                fontSize: 11.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matrixRow({required String keyText, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 190,
            child: Text(
              keyText,
              style: TextStyle(
                color: _t.primary,
                fontFamily: 'monospace',
                fontSize: 11.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _t.ink, fontSize: 11.4, height: 1.32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doDont({
    required bool good,
    required String title,
    required String detail,
  }) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.27)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel,
              color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _t.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: TextStyle(color: _t.muted, fontSize: 11.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _t.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _t.muted, fontSize: 11.4, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _t.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _note(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _t.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _t.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _t.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _t.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: _t.ink,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _t.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _t.ink,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(color: _t.muted, fontSize: 11.4),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _t.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageNames[_stage.index],
            style: TextStyle(
              color: _t.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_t.name}',
            style: TextStyle(color: _t.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ExtentGridPainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _ExtentGridPainter({
    required this.color,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _ExtentGridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
