import 'package:flutter/material.dart';

class _ThemeProfile {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _ThemeProfile({
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

const _profiles = <_ThemeProfile>[
  _ThemeProfile(
    name: 'Azure Ember',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF0D9488),
    background: Color(0xFFF4F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _ThemeProfile(
    name: 'Sea Rose',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFBE123C),
    accent: Color(0xFF2563EB),
    background: Color(0xFFF2FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1B302D),
    muted: Color(0xFF5E7069),
  ),
  _ThemeProfile(
    name: 'Slate Lime',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF6B7280),
  ),
];

enum _Scene {
  fundamentals,
  densityMixer,
  narrative,
  axisTheater,
  shellGallery,
  compendium,
}

enum _AxisMode {
  vertical,
  horizontal,
}

enum _DensityPreset {
  sparse,
  normal,
  dense,
}

class _ShellModel {
  final String label;
  final double height;
  final double extent;
  final int count;

  const _ShellModel({
    required this.label,
    required this.height,
    required this.extent,
    required this.count,
  });
}

const _shellPresets = <_ShellModel>[
  _ShellModel(label: 'Pocket', height: 430, extent: 78, count: 11),
  _ShellModel(label: 'Default', height: 560, extent: 92, count: 12),
  _ShellModel(label: 'Studio', height: 700, extent: 108, count: 13),
];

dynamic build(BuildContext context) {
  return const _FixedExtentListLab();
}

class _FixedExtentListLab extends StatefulWidget {
  const _FixedExtentListLab();

  @override
  State<_FixedExtentListLab> createState() => _FixedExtentListLabState();
}

class _FixedExtentListLabState extends State<_FixedExtentListLab> {
  _Scene _scene = _Scene.fundamentals;
  int _themeIndex = 0;
  bool _verbose = false;

  double _baseExtent = 94;
  double _baseCount = 12;
  bool _baseShowHint = true;
  bool _basePadding = true;

  _DensityPreset _density = _DensityPreset.normal;
  double _mixExtent = 88;
  double _mixCount = 11;
  double _mixGap = 6;
  bool _mixShowOverlay = true;
  bool _mixShowDensityBadge = true;

  double _narrativeLead = 2;
  double _narrativeExtent = 100;
  bool _narrativePinned = true;
  bool _narrativeFloating = false;
  bool _narrativeFooter = true;

  _AxisMode _axisMode = _AxisMode.vertical;
  double _axisExtent = 96;
  double _axisCount = 10;
  double _axisSpacing = 8;
  bool _axisPadding = true;
  bool _axisLegend = true;

  bool _shellTrio = true;
  double _shellCustomHeight = 620;
  double _shellCustomExtent = 104;
  double _shellCustomCount = 12;
  bool _shellMetrics = true;

  static const _sceneTitles = <String>[
    '1 Extent Fundamentals Board',
    '2 Density Mixer Lab',
    '3 Sectioned Scroll Narrative',
    '4 Axis Contrast Theater',
    '5 Responsive Shell Gallery',
    '6 Verification Compendium',
  ];

  _ThemeProfile get _t => _profiles[_themeIndex];

  Axis get _axis => _axisMode == _AxisMode.vertical ? Axis.vertical : Axis.horizontal;

  void _trace(String msg) {
    if (_verbose) {
      debugPrint('[RenderSliverFixedExtentListDemo] $msg');
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
            _toolbar(),
            Expanded(child: _sceneBody()),
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
              const Icon(Icons.table_rows_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'RenderSliverFixedExtentList Demo Lab',
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
                  'SliverFixedExtentList Visual Guide',
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
            'SliverFixedExtentList uses a uniform main-axis itemExtent. '
            'This studio explores sizing, density tradeoffs, axis usage, '
            'composition patterns, and responsive shell behavior.',
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

  Widget _toolbar() {
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
            'Scene',
            style: TextStyle(
              color: _t.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _sceneTitles.length; i++)
            ChoiceChip(
              selected: _scene.index == i,
              selectedColor: _t.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _scene.index == i ? Colors.white : _t.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              onSelected: (_) {
                setState(() => _scene = _Scene.values[i]);
                _trace('scene => ${_scene.name}');
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
          for (var i = 0; i < _profiles.length; i++)
            GestureDetector(
              onTap: () => setState(() => _themeIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _profiles[i].primary,
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

  Widget _sceneBody() {
    switch (_scene) {
      case _Scene.fundamentals:
        return _fundamentalsScene();
      case _Scene.densityMixer:
        return _densityMixerScene();
      case _Scene.narrative:
        return _narrativeScene();
      case _Scene.axisTheater:
        return _axisTheaterScene();
      case _Scene.shellGallery:
        return _shellGalleryScene();
      case _Scene.compendium:
        return _compendiumScene();
    }
  }

  Widget _fundamentalsScene() {
    final count = _baseCount.round();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Extent Fundamentals Board'),
          const SizedBox(height: 8),
          Text(
            'SliverFixedExtentList gives every child the same extent along '
            'the scroll axis. This board demonstrates the uniform rhythm and '
            'predictable geometry that result.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Board Controls',
            subtitle: 'Adjust extent and list size.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'itemExtent',
                  value: _baseExtent,
                  min: 56,
                  max: 160,
                  divisions: 13,
                  color: _t.primary,
                  display: _baseExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _baseExtent = v),
                ),
                _sliderRow(
                  label: 'item count',
                  value: _baseCount,
                  min: 4,
                  max: 18,
                  divisions: 14,
                  color: _t.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _baseCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _baseShowHint,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _baseShowHint = v ?? true),
                    ),
                    Text('show extent badge',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _basePadding,
                      activeColor: _t.secondary,
                      onChanged: (v) => setState(() => _basePadding = v ?? true),
                    ),
                    Text('sliver padding',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('extent', _baseExtent.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _chip('count', '$count', _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Fundamental Lane',
            subtitle: 'Uniform row heights with steady cadence.',
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
                            icon: Icons.view_stream_rounded,
                            text: 'Uniform extent applied to every child',
                          ),
                        ),
                        SliverPadding(
                          padding: _basePadding
                              ? const EdgeInsets.fromLTRB(10, 4, 10, 8)
                              : EdgeInsets.zero,
                          sliver: SliverFixedExtentList.builder(
                            itemExtent: _baseExtent,
                            itemCount: count,
                            itemBuilder: (context, index) => _fundRow(index),
                          ),
                        ),
                      ],
                    ),
                    if (_baseShowHint)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip('mode', 'fixed extent', _t.secondary),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'With fixed extents, the render pipeline can map offsets to rows '
            'with predictable arithmetic, improving consistency and scrolling feel.',
          ),
        ],
      ),
    );
  }

  Widget _fundRow(int index) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
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
              color: tone.withValues(alpha: 0.33),
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
                  'Extent Lane ${index + 1}',
                  style: TextStyle(
                    color: _t.ink,
                    fontSize: 12.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Main-axis size held constant by itemExtent.',
                  style: TextStyle(color: _t.muted, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.77),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${_baseExtent.toStringAsFixed(0)} px',
              style: TextStyle(
                color: _t.ink,
                fontSize: 10.2,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _densityMixerScene() {
    final count = _mixCount.round();
    final extent = _densityExtent();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Density Mixer Lab'),
          const SizedBox(height: 8),
          Text(
            'Density presets help tune readability and information capacity. '
            'This lab blends presets, manual extent, and gap controls in one '
            'interactive viewport.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mixer Controls',
            subtitle: 'Preset + custom fine tuning.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _presetChip('Sparse', _DensityPreset.sparse),
                    _presetChip('Normal', _DensityPreset.normal),
                    _presetChip('Dense', _DensityPreset.dense),
                  ],
                ),
                _sliderRow(
                  label: 'manual extent',
                  value: _mixExtent,
                  min: 60,
                  max: 130,
                  divisions: 14,
                  color: _t.primary,
                  display: _mixExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _mixExtent = v),
                ),
                _sliderRow(
                  label: 'item count',
                  value: _mixCount,
                  min: 5,
                  max: 20,
                  divisions: 15,
                  color: _t.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _mixCount = v),
                ),
                _sliderRow(
                  label: 'row gap',
                  value: _mixGap,
                  min: 0,
                  max: 18,
                  divisions: 9,
                  color: _t.accent,
                  display: _mixGap.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _mixGap = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _mixShowOverlay,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _mixShowOverlay = v ?? true),
                    ),
                    Text('show interval lines',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _mixShowDensityBadge,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _mixShowDensityBadge = v ?? true),
                    ),
                    Text('show density badge',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('active extent', extent.toStringAsFixed(0), _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mixer Viewport',
            subtitle: 'Observe how density changes lane rhythm.',
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
                            icon: Icons.tune_rounded,
                            text: 'Density preset + manual extent controls',
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(10, 4, 10, _mixGap),
                          sliver: SliverFixedExtentList.builder(
                            itemExtent: extent,
                            itemCount: count,
                            itemBuilder: (context, index) => _mixTile(index, extent),
                          ),
                        ),
                      ],
                    ),
                    if (_mixShowOverlay)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _IntervalPainter(
                              color: _t.primary.withValues(alpha: 0.16),
                              interval: extent,
                            ),
                          ),
                        ),
                      ),
                    if (_mixShowDensityBadge)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip(
                          'preset',
                          _density.name,
                          _t.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mixer Guidance',
            subtitle: 'Read while testing controls.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Sparse increases scan comfort for rich card content.'),
                _bullet('Dense raises information throughput for compact dashboards.'),
                _bullet('Uniform extent remains stable across all density states.'),
                _bullet('Use one extent policy per lane to keep rhythm coherent.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _densityExtent() {
    switch (_density) {
      case _DensityPreset.sparse:
        return _mixExtent + 18;
      case _DensityPreset.normal:
        return _mixExtent;
      case _DensityPreset.dense:
        return (_mixExtent - 16).clamp(48, 200);
    }
  }

  Widget _presetChip(String label, _DensityPreset preset) {
    return ChoiceChip(
      selected: _density == preset,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == preset ? Colors.white : _t.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.4,
      ),
      onSelected: (_) => setState(() => _density = preset),
    );
  }

  Widget _mixTile(int index, double extent) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: EdgeInsets.fromLTRB(0, _mixGap / 2, 0, _mixGap / 2),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.layers_rounded, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Density row ${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontWeight: FontWeight.w700,
                fontSize: 12.1,
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
                fontWeight: FontWeight.w700,
                fontSize: 10.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _narrativeScene() {
    final lead = _narrativeLead.round();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Sectioned Scroll Narrative'),
          const SizedBox(height: 8),
          Text(
            'This scene places a fixed-extent list between lead and trailing '
            'slivers, illustrating how SliverFixedExtentList behaves in '
            'realistic multi-section scroll experiences.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Narrative Controls',
            subtitle: 'Header behavior and chapter size.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'lead cards',
                  value: _narrativeLead,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  color: _t.primary,
                  display: '$lead',
                  onChanged: (v) => setState(() => _narrativeLead = v),
                ),
                _sliderRow(
                  label: 'chapter extent',
                  value: _narrativeExtent,
                  min: 72,
                  max: 148,
                  divisions: 19,
                  color: _t.secondary,
                  display: _narrativeExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _narrativeExtent = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _narrativePinned,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _narrativePinned = v ?? true),
                    ),
                    Text('pinned app bar',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _narrativeFloating,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _narrativeFloating = v ?? false),
                    ),
                    Text('floating app bar',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _narrativeFooter,
                      activeColor: _t.accent,
                      onChanged: (v) =>
                          setState(() => _narrativeFooter = v ?? true),
                    ),
                    Text('show footer',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('extent', _narrativeExtent.toStringAsFixed(0), _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Narrative Viewport',
            subtitle: 'Header + lead + fixed-extent chapter + footer.',
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
                      pinned: _narrativePinned,
                      floating: _narrativeFloating,
                      expandedHeight: 120,
                      backgroundColor: _t.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text('Narrative Flow',
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
                        icon: Icons.menu_book_rounded,
                        text: 'Lead context before fixed chapter lane',
                      ),
                    ),
                    SliverList.builder(
                      itemCount: lead,
                      itemBuilder: (context, index) => _leadPanel(index),
                    ),
                    SliverToBoxAdapter(
                      child: _banner(
                        icon: Icons.view_day_rounded,
                        text: 'Fixed-extent chapter segment',
                      ),
                    ),
                    SliverFixedExtentList.builder(
                      itemExtent: _narrativeExtent,
                      itemCount: 9,
                      itemBuilder: (context, index) => _chapterTile(index),
                    ),
                    if (_narrativeFooter)
                      SliverToBoxAdapter(
                        child: _narrativeFooterPanel(),
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

  Widget _leadPanel(int index) {
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
            'Context sliver before fixed-extent chapter cards.',
            style: TextStyle(color: _t.muted, fontSize: 11.1),
          ),
        ],
      ),
    );
  }

  Widget _chapterTile(int index) {
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
              'Chapter tile ${index + 1} (${_narrativeExtent.toStringAsFixed(0)} px)',
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

  Widget _narrativeFooterPanel() {
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
            'Narrative summary',
            style: TextStyle(
              color: _t.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Fixed-extent rows integrate cleanly with other sliver types in '
            'complex page stories.',
            style: TextStyle(color: _t.muted, fontSize: 11.4, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _axisTheaterScene() {
    final count = _axisCount.round();
    final horizontal = _axis == Axis.horizontal;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Axis Contrast Theater'),
          const SizedBox(height: 8),
          Text(
            'Compare fixed-extent behavior in vertical and horizontal '
            'orientations. Main-axis extent maps to height in vertical mode '
            'and width in horizontal mode.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Theater Controls',
            subtitle: 'Axis, extent, count, spacing, and legends.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _axisChoiceChip('Vertical', _AxisMode.vertical),
                    _axisChoiceChip('Horizontal', _AxisMode.horizontal),
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
                  label: 'spacing',
                  value: _axisSpacing,
                  min: 0,
                  max: 20,
                  divisions: 10,
                  color: _t.accent,
                  display: _axisSpacing.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _axisSpacing = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _axisPadding,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _axisPadding = v ?? true),
                    ),
                    Text('apply sliver padding',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _axisLegend,
                      activeColor: _t.secondary,
                      onChanged: (v) => setState(() => _axisLegend = v ?? true),
                    ),
                    Text('show legend chip',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('axis', horizontal ? 'horizontal' : 'vertical', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: horizontal ? 'Horizontal Fixed Tiles' : 'Vertical Fixed Rows',
            subtitle: horizontal
                ? 'Extent defines tile width.'
                : 'Extent defines row height.',
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
                              text: 'Vertical extent lane',
                            ),
                          ),
                        SliverPadding(
                          padding: _axisPadding
                              ? EdgeInsets.all(_axisSpacing)
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
                    if (_axisLegend)
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
          _card(
            title: 'Theater Notes',
            subtitle: 'When to use each mode.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Vertical fixed rows suit logs, forms, and data feeds.'),
                _bullet('Horizontal fixed tiles suit media strips and selector rails.'),
                _bullet('Use spacing and padding for rhythm without breaking extent consistency.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _axisChoiceChip(String label, _AxisMode mode) {
    return ChoiceChip(
      selected: _axisMode == mode,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _axisMode == mode ? Colors.white : _t.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.4,
      ),
      onSelected: (_) => setState(() => _axisMode = mode),
    );
  }

  Widget _axisTile(int index, bool horizontal) {
    final tone = index.isEven ? _t.primary : _t.secondary;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: horizontal ? 10 : _axisSpacing / 2,
          horizontal: horizontal ? _axisSpacing / 2 : 0),
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
              horizontal ? 'Tile ${index + 1}' : 'Row ${index + 1}',
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

  Widget _shellGalleryScene() {
    final customCount = _shellCustomCount.round();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Responsive Shell Gallery'),
          const SizedBox(height: 8),
          Text(
            'Different viewport heights and extents affect visual density. '
            'This gallery compares preset shells and a custom shell profile '
            'to tune fixed-extent behavior across device contexts.',
            style: TextStyle(color: _t.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Controls',
            subtitle: 'Preset trio and custom shell controls.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _shellTrio,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _shellTrio = v ?? true),
                    ),
                    Text('show preset trio',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('mode', _shellTrio ? 'trio' : 'custom', _t.primary),
                  ],
                ),
                _sliderRow(
                  label: 'custom height',
                  value: _shellCustomHeight,
                  min: 420,
                  max: 760,
                  divisions: 17,
                  color: _t.primary,
                  display: _shellCustomHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _shellCustomHeight = v),
                ),
                _sliderRow(
                  label: 'custom extent',
                  value: _shellCustomExtent,
                  min: 72,
                  max: 150,
                  divisions: 13,
                  color: _t.secondary,
                  display: _shellCustomExtent.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _shellCustomExtent = v),
                ),
                _sliderRow(
                  label: 'custom count',
                  value: _shellCustomCount,
                  min: 6,
                  max: 18,
                  divisions: 12,
                  color: _t.accent,
                  display: '$customCount',
                  onChanged: (v) => setState(() => _shellCustomCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _shellMetrics,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _shellMetrics = v ?? true),
                    ),
                    Text('show shell metrics',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_shellTrio)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final shell in _shellPresets) _shellCard(shell),
              ],
            )
          else
            _shellCard(
              _ShellModel(
                label: 'Custom',
                height: _shellCustomHeight,
                extent: _shellCustomExtent,
                count: customCount,
              ),
            ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Insights',
            subtitle: 'Responsive tuning observations.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Compact shells often need tighter extents to fit more context.'),
                _bullet('Larger shells can support larger extents for calmer pacing.'),
                _bullet('Fixed extents keep row cadence predictable across shell classes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shellCard(_ShellModel shell) {
    return SizedBox(
      width: 400,
      child: _card(
        title: '${shell.label} shell',
        subtitle:
            'height ${shell.height.toStringAsFixed(0)} | extent ${shell.extent.toStringAsFixed(0)} | count ${shell.count}',
        tint: _t.primary.withValues(alpha: 0.04),
        child: SizedBox(
          height: shell.height,
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
                        text: '${shell.label} responsive profile',
                      ),
                    ),
                    SliverFixedExtentList.builder(
                      itemExtent: shell.extent,
                      itemCount: shell.count,
                      itemBuilder: (context, index) =>
                          _shellTile(index, shell.label),
                    ),
                  ],
                ),
                if (_shellMetrics)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _chip('extent', shell.extent.toStringAsFixed(0), _t.secondary),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shellTile(int index, String label) {
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
              '$label row ${index + 1}',
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

  Widget _compendiumScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _card(
            title: 'Behavior Matrix',
            subtitle: 'RenderSliverFixedExtentList summary map.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Core behavior',
                  value:
                      'Every child receives the same main-axis extent set by itemExtent.',
                ),
                _matrixRow(
                  keyText: 'Rendering benefit',
                  value:
                      'Predictable geometry and simpler offset/index relationships.',
                ),
                _matrixRow(
                  keyText: 'Typical implementation',
                  value:
                      'Used when rows/tiles should be uniformly sized across long scroll runs.',
                ),
                _matrixRow(
                  keyText: 'Axis support',
                  value:
                      'Works in vertical and horizontal CustomScrollView pipelines.',
                ),
                _matrixRow(
                  keyText: 'Good targets',
                  value:
                      'Logs, queue lanes, repetitive cards, and metric strips.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical usage boundaries.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use for consistent visual cadence',
                  detail:
                      'Uniform extents make long lists easier to scan and maintain.',
                ),
                _doDont(
                  good: false,
                  title: 'Use for heavily variable item heights',
                  detail:
                      'Variable-size content is generally better served by other sliver types.',
                ),
                _doDont(
                  good: true,
                  title: 'Adjust extent to content density goals',
                  detail:
                      'Choose extents based on readability, context, and device profile.',
                ),
                _doDont(
                  good: false,
                  title: 'Mix arbitrary extents in one lane conceptually',
                  detail:
                      'Pick one extent strategy per lane for predictable rhythm.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common questions when applying fixed extents.',
            child: Column(
              children: [
                _qa(
                  q: 'Why choose SliverFixedExtentList over SliverList?',
                  a: 'Choose it when child heights can remain uniform and you '
                      'want predictable geometry and rhythm.',
                ),
                _qa(
                  q: 'Does it support horizontal scroll?',
                  a: 'Yes. In horizontal mode, itemExtent controls tile width.',
                ),
                _qa(
                  q: 'Can I still style each row differently?',
                  a: 'Absolutely. Visual style can vary while outer extent stays fixed.',
                ),
                _qa(
                  q: 'When is this a poor fit?',
                  a: 'When content requires organic, data-driven height changes per item.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion criteria.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Fundamentals board covers extent and count behavior.'),
                _check('Density mixer demonstrates presets and interval overlays.'),
                _check('Sectioned narrative shows integration with other slivers.'),
                _check('Axis theater compares vertical and horizontal modes.'),
                _check('Responsive shell gallery validates device adaptation.'),
                _check('Compendium includes matrix, do/dont, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'RenderSliverFixedExtentList is ideal when you need stable, '
            'highly readable, uniform lanes in sliver-based interfaces.',
          ),
        ],
      ),
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

  Widget _card({
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
            _sceneTitles[_scene.index],
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

class _IntervalPainter extends CustomPainter {
  final Color color;
  final double interval;

  const _IntervalPainter({required this.color, required this.interval});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += interval;
    }
  }

  @override
  bool shouldRepaint(covariant _IntervalPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.interval != interval;
  }
}
