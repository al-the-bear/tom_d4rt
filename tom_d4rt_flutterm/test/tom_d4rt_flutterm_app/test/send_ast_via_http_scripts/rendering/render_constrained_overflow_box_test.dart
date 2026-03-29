import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'lagoon',
    name: 'Lagoon Lab',
    description: 'Balanced profile for studying child overflow against parent constraints.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Desk',
    description: 'Warm profile for clip and edge intersection visibility checks.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ocean',
    name: 'Ocean Scope',
    description: 'Cool profile for constraint geometry and alignment diagnostics.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Audit',
    description: 'Dark profile for high-contrast overflow contour analysis.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ScenarioLane> _scenarioLanes = <_ScenarioLane>[
  _ScenarioLane(
    id: 'hero',
    title: 'Hero Overflow Stage',
    subtitle: 'Interactive parent-vs-child constraints with explicit overflow behavior.',
  ),
  _ScenarioLane(
    id: 'alignment',
    title: 'Alignment Explorer',
    subtitle: 'Directional and anchored overflow behavior using alignment controls.',
  ),
  _ScenarioLane(
    id: 'fit',
    title: 'Fit and Limits',
    subtitle: 'Custom overflow fit modes and min/max combinations across varying parent bounds.',
  ),
  _ScenarioLane(
    id: 'compare',
    title: 'Widget Comparison',
    subtitle: 'OverflowBox vs SizedOverflowBox vs regular constrained layout behavior.',
  ),
  _ScenarioLane(
    id: 'ops',
    title: 'Ops Diagnostics',
    subtitle: 'Metrics, snapshots, and timeline for reproducible overflow investigations.',
  ),
];

const List<_AlignmentOption> _alignmentOptions = <_AlignmentOption>[
  _AlignmentOption(label: 'Center', value: Alignment.center),
  _AlignmentOption(label: 'Top Left', value: Alignment.topLeft),
  _AlignmentOption(label: 'Top Center', value: Alignment.topCenter),
  _AlignmentOption(label: 'Top Right', value: Alignment.topRight),
  _AlignmentOption(label: 'Center Left', value: Alignment.centerLeft),
  _AlignmentOption(label: 'Center Right', value: Alignment.centerRight),
  _AlignmentOption(label: 'Bottom Left', value: Alignment.bottomLeft),
  _AlignmentOption(label: 'Bottom Center', value: Alignment.bottomCenter),
  _AlignmentOption(label: 'Bottom Right', value: Alignment.bottomRight),
];

const List<String> _guideBullets = <String>[
  'RenderConstrainedOverflowBox is used by OverflowBox to permit child size outside parent constraints.',
  'Use overflow only when visual intent is explicit, such as callouts, decorative badges, or intentionally escaping surfaces.',
  'Alignment controls where the overflowing child extends relative to the constrained parent.',
  'Min/max width and height parameters shape the child constraints independently of parent tightness.',
  'Overflow fit strategy can tune the effective min/max overrides before child layout.',
  'Pair with clipping decisions deliberately: visible overflow and clipped overflow communicate different UX intent.',
  'Track hit targets when overflow extends outside expected parent geometry.',
  'Use diagnostics snapshots to preserve reproducible combinations of parent size, child size, and limits.',
  'Compare OverflowBox with SizedOverflowBox for fixed-size parent proxies and with ConstrainedBox for strict layout.',
  'Avoid accidental overflow in production components by documenting which overflows are intentional.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'What does RenderConstrainedOverflowBox do?',
    answer: 'It lays out a child with adjusted constraints that can exceed the parent, enabling controlled visual overflow.',
  ),
  _FaqItem(
    question: 'Is overflow always visible?',
    answer: 'Only if an ancestor does not clip the child; clipping strategy determines whether escaped regions are shown.',
  ),
  _FaqItem(
    question: 'How is it different from SizedOverflowBox?',
    answer: 'SizedOverflowBox reports a fixed size while allowing a differently sized child; OverflowBox adjusts child constraints directly.',
  ),
  _FaqItem(
    question: 'When should I avoid it?',
    answer: 'Avoid it for accidental layout fixes; prefer explicit constraints unless overflow is truly part of the design.',
  ),
  _FaqItem(
    question: 'How can I debug overflow intent?',
    answer: 'Use overlays showing parent bounds, child bounds, and active clip settings to validate behavior quickly.',
  ),
];

const List<_DemoTileModel> _demoTiles = <_DemoTileModel>[
  _DemoTileModel(label: 'Signal', colorA: Color(0xFF0EA5E9), colorB: Color(0xFF14B8A6), note: 'Center overflow with mild expansion'),
  _DemoTileModel(label: 'Beacon', colorA: Color(0xFF22C55E), colorB: Color(0xFF16A34A), note: 'Right-anchored escape behavior'),
  _DemoTileModel(label: 'Cinder', colorA: Color(0xFFF59E0B), colorB: Color(0xFFEF4444), note: 'Top spill with aggressive width'),
  _DemoTileModel(label: 'Iris', colorA: Color(0xFF8B5CF6), colorB: Color(0xFF6366F1), note: 'Diagonal overflow under clip'),
  _DemoTileModel(label: 'Rose', colorA: Color(0xFFF43F5E), colorB: Color(0xFFFB7185), note: 'Bottom offset with narrow parent'),
  _DemoTileModel(label: 'Slate', colorA: Color(0xFF475569), colorB: Color(0xFF1E293B), note: 'Constrained limits stress-test'),
];

enum _OverflowScene {
  center,
  leftSpill,
  rightSpill,
  topSpill,
  bottomSpill,
  diagonal,
  dual,
}

enum _OverflowFitMode {
  loose,
  balanced,
  tight,
}

class _ThemePreset {
  const _ThemePreset({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String description;
  final Color seed;
  final Brightness brightness;
}

class _ScenarioLane {
  const _ScenarioLane({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _AlignmentOption {
  const _AlignmentOption({required this.label, required this.value});

  final String label;
  final Alignment value;
}

class _DemoTileModel {
  const _DemoTileModel({required this.label, required this.colorA, required this.colorB, required this.note});

  final String label;
  final Color colorA;
  final Color colorB;
  final String note;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _MetricEntry {
  const _MetricEntry({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _TimelineEvent {
  const _TimelineEvent({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

dynamic build(BuildContext context) {
  return const _RenderConstrainedOverflowBoxStudio();
}

class _RenderConstrainedOverflowBoxStudio extends StatefulWidget {
  const _RenderConstrainedOverflowBoxStudio();

  @override
  State<_RenderConstrainedOverflowBoxStudio> createState() => _RenderConstrainedOverflowBoxStudioState();
}

class _RenderConstrainedOverflowBoxStudioState extends State<_RenderConstrainedOverflowBoxStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _motionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8200),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _OverflowScene _scene = _OverflowScene.center;
  _OverflowFitMode _fitMode = _OverflowFitMode.balanced;

  Alignment _alignment = Alignment.center;

  bool _showGrid = true;
  bool _showBounds = true;
  bool _showClip = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _animateBackdrop = true;
  bool _animateChild = false;

  bool _useMinWidth = false;
  bool _useMaxWidth = false;
  bool _useMinHeight = false;
  bool _useMaxHeight = false;

  double _parentWidth = 360;
  double _parentHeight = 220;
  double _childWidth = 420;
  double _childHeight = 260;

  double _minWidth = 120;
  double _maxWidth = 520;
  double _minHeight = 80;
  double _maxHeight = 360;

  double _overlayDensity = 0.42;
  double _panelPadding = 14;

  int _sceneSwitchCount = 0;
  int _fitSwitchCount = 0;
  int _alignmentSwitchCount = 0;
  int _heroTapCount = 0;
  int _tileTapCount = 0;
  int _themeSwitchCount = 0;

  String _phase = 'idle';
  String _lastTile = 'none';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderConstrainedOverflowBox Constraint Escape Lab initialized.');
    });
  }

  @override
  void dispose() {
    _motionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(70).toList(growable: false);
    });
  }

  void _reset() {
    setState(() {
      _scenarioIndex = 0;
      _scene = _OverflowScene.center;
      _fitMode = _OverflowFitMode.balanced;
      _alignment = Alignment.center;
      _showGrid = true;
      _showBounds = true;
      _showClip = false;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _animateBackdrop = true;
      _animateChild = false;
      _useMinWidth = false;
      _useMaxWidth = false;
      _useMinHeight = false;
      _useMaxHeight = false;
      _parentWidth = 360;
      _parentHeight = 220;
      _childWidth = 420;
      _childHeight = 260;
      _minWidth = 120;
      _maxWidth = 520;
      _minHeight = 80;
      _maxHeight = 360;
      _overlayDensity = 0.42;
      _panelPadding = 14;
      _sceneSwitchCount = 0;
      _fitSwitchCount = 0;
      _alignmentSwitchCount = 0;
      _heroTapCount = 0;
      _tileTapCount = 0;
      _themeSwitchCount = 0;
      _phase = 'idle';
      _lastTile = 'none';
      _timeline = const <_TimelineEvent>[];
    });
    _motionController.repeat();
    _pushTimeline('Reset', 'Overflow lab reset to default settings.');
  }

  Size _sceneChildSize() {
    final double wave = (math.sin(_motionController.value * math.pi * 2) + 1) / 2;
    final double animScale = _animateChild ? (0.86 + wave * 0.38) : 1;
    switch (_scene) {
      case _OverflowScene.center:
        return Size(_childWidth * animScale, _childHeight * animScale);
      case _OverflowScene.leftSpill:
        return Size(_childWidth * 1.12 * animScale, (_childHeight * 0.86) * animScale);
      case _OverflowScene.rightSpill:
        return Size((_childWidth * 1.08) * animScale, (_childHeight * 0.92) * animScale);
      case _OverflowScene.topSpill:
        return Size((_childWidth * 0.92) * animScale, (_childHeight * 1.24) * animScale);
      case _OverflowScene.bottomSpill:
        return Size((_childWidth * 0.94) * animScale, (_childHeight * 1.18) * animScale);
      case _OverflowScene.diagonal:
        return Size((_childWidth * 1.18) * animScale, (_childHeight * 1.16) * animScale);
      case _OverflowScene.dual:
        return Size((_childWidth * 1.26) * animScale, (_childHeight * 1.12) * animScale);
    }
  }

  Alignment _sceneAlignment() {
    switch (_scene) {
      case _OverflowScene.center:
        return _alignment;
      case _OverflowScene.leftSpill:
        return Alignment.centerLeft;
      case _OverflowScene.rightSpill:
        return Alignment.centerRight;
      case _OverflowScene.topSpill:
        return Alignment.topCenter;
      case _OverflowScene.bottomSpill:
        return Alignment.bottomCenter;
      case _OverflowScene.diagonal:
        return Alignment.topLeft;
      case _OverflowScene.dual:
        return Alignment.bottomRight;
    }
  }

  List<_MetricEntry> _metrics() {
    final Size child = _sceneChildSize();
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarioLanes[_scenarioIndex].title, note: 'Current exploration lane.', icon: Icons.view_carousel_outlined),
      _MetricEntry(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Active visual profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Scene', value: _scene.name, note: 'Current overflow scene model.', icon: Icons.animation_outlined),
      _MetricEntry(label: 'Fit Mode', value: _fitMode.name, note: 'Effective scaling profile for min/max overrides.', icon: Icons.fit_screen_outlined),
      _MetricEntry(label: 'Alignment', value: _alignmentOptions.firstWhere(( _AlignmentOption o) => o.value == _alignment).label, note: 'Base alignment selection.', icon: Icons.align_horizontal_center_outlined),
      _MetricEntry(label: 'Parent Size', value: '${_parentWidth.toStringAsFixed(0)} x ${_parentHeight.toStringAsFixed(0)}', note: 'Parent container dimensions.', icon: Icons.crop_square_outlined),
      _MetricEntry(label: 'Child Size', value: '${child.width.toStringAsFixed(0)} x ${child.height.toStringAsFixed(0)}', note: 'Effective child dimensions in scene.', icon: Icons.open_in_full_outlined),
      _MetricEntry(label: 'Min Width', value: _useMinWidth ? _minWidth.toStringAsFixed(0) : 'off', note: 'minWidth override state.', icon: Icons.horizontal_rule_outlined),
      _MetricEntry(label: 'Max Width', value: _useMaxWidth ? _maxWidth.toStringAsFixed(0) : 'off', note: 'maxWidth override state.', icon: Icons.width_normal_outlined),
      _MetricEntry(label: 'Min Height', value: _useMinHeight ? _minHeight.toStringAsFixed(0) : 'off', note: 'minHeight override state.', icon: Icons.vertical_align_top_outlined),
      _MetricEntry(label: 'Max Height', value: _useMaxHeight ? _maxHeight.toStringAsFixed(0) : 'off', note: 'maxHeight override state.', icon: Icons.height_outlined),
      _MetricEntry(label: 'Clip Parent', value: _showClip ? 'enabled' : 'disabled', note: 'Parent clipping visibility mode.', icon: Icons.content_cut_outlined),
      _MetricEntry(label: 'Scene Switches', value: '$_sceneSwitchCount', note: 'Scene mode changes.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Fit Switches', value: '$_fitSwitchCount', note: 'Overflow fit mode changes.', icon: Icons.change_circle_outlined),
      _MetricEntry(label: 'Alignment Switches', value: '$_alignmentSwitchCount', note: 'Alignment changes.', icon: Icons.align_horizontal_left_outlined),
      _MetricEntry(label: 'Hero Taps', value: '$_heroTapCount', note: 'Primary stage interaction count.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Tile Taps', value: '$_tileTapCount', note: 'Gallery interaction count.', icon: Icons.grid_view_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Current interaction phase label.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Last Tile', value: _lastTile, note: 'Most recently selected gallery tile.', icon: Icons.push_pin_outlined),
    ];
  }

  double _fitScale() {
    switch (_fitMode) {
      case _OverflowFitMode.loose:
        return 0.78;
      case _OverflowFitMode.balanced:
        return 1.0;
      case _OverflowFitMode.tight:
        return 1.24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: preset.seed,
      brightness: preset.brightness,
    );

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: preset.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[scheme.surface, scheme.surfaceContainerLowest, scheme.surfaceContainerLow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildControlBoard(scheme),
                        const SizedBox(height: 16),
                        _buildHeroBoard(scheme),
                        const SizedBox(height: 16),
                        _buildSceneGalleryBoard(scheme),
                        const SizedBox(height: 16),
                        _buildComparisonBoard(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showTimeline) const SizedBox(height: 16),
                        if (_showTimeline) _buildTimelineBoard(scheme),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Icon(Icons.open_in_full_outlined, color: scheme.primary, size: 26),
                Text('RenderConstrainedOverflowBox Constraint Escape Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioLanes[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Comprehensive visual demo of constrained overflow behavior through OverflowBox and related patterns, focusing on alignment, constraints, fit modes, clipping, and practical composition guidance.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeScenarioBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themePresets.length, (int i) {
                final _ThemePreset p = _themePresets[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitchCount += 1;
                      _phase = 'theme';
                    });
                    _pushTimeline('Theme', 'Theme switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioLanes.length, (int i) {
                final _ScenarioLane s = _scenarioLanes[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _phase = 'scenario';
                    });
                    _pushTimeline('Scenario', s.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarioLanes[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: EdgeInsets.all(_panelPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Constraint Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune parent and child geometry, overflow fit strategy, and optional min/max limit overrides.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _OverflowScene.values.map(( _OverflowScene scene) {
                return ChoiceChip(
                  selected: _scene == scene,
                  label: Text(scene.name),
                  onSelected: (_) {
                    setState(() {
                      _scene = scene;
                      _sceneSwitchCount += 1;
                      _phase = 'scene';
                    });
                    _pushTimeline('Scene', 'Scene switched to ${scene.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _OverflowFitMode.values.map(( _OverflowFitMode fit) {
                return ChoiceChip(
                  selected: _fitMode == fit,
                  label: Text(fit.name),
                  onSelected: (_) {
                    setState(() {
                      _fitMode = fit;
                      _fitSwitchCount += 1;
                      _phase = 'fit';
                    });
                    _pushTimeline('Fit', 'Overflow fit mode changed to ${fit.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text('Base Alignment: ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<Alignment>(
                    initialValue: _alignment,
                    decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
                    items: _alignmentOptions
                        .map(( _AlignmentOption opt) => DropdownMenuItem<Alignment>(value: opt.value, child: Text(opt.label)))
                        .toList(),
                    onChanged: (Alignment? next) {
                      if (next == null) {
                        return;
                      }
                      setState(() {
                        _alignment = next;
                        _alignmentSwitchCount += 1;
                        _phase = 'alignment';
                      });
                      _pushTimeline('Alignment', 'Alignment changed to ${_alignmentOptions.firstWhere(( _AlignmentOption o) => o.value == next).label}.');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _sliderRow(
              scheme: scheme,
              label: 'Parent Width',
              value: _parentWidth,
              min: 180,
              max: 560,
              divisions: 190,
              onChanged: (double v) => setState(() => _parentWidth = v),
              onChangeEnd: (double v) => _pushTimeline('Parent Width', 'Parent width set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Parent Height',
              value: _parentHeight,
              min: 140,
              max: 400,
              divisions: 130,
              onChanged: (double v) => setState(() => _parentHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Parent Height', 'Parent height set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Width',
              value: _childWidth,
              min: 120,
              max: 640,
              divisions: 260,
              onChanged: (double v) => setState(() => _childWidth = v),
              onChangeEnd: (double v) => _pushTimeline('Child Width', 'Child width set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Height',
              value: _childHeight,
              min: 100,
              max: 460,
              divisions: 180,
              onChanged: (double v) => setState(() => _childHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Child Height', 'Child height set to ${v.toStringAsFixed(0)}.'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _useMinWidth, onChanged: (bool? v) => setState(() => _useMinWidth = v ?? false), child: const Text('Enable minWidth')),
                CheckboxMenuButton(value: _useMaxWidth, onChanged: (bool? v) => setState(() => _useMaxWidth = v ?? false), child: const Text('Enable maxWidth')),
                CheckboxMenuButton(value: _useMinHeight, onChanged: (bool? v) => setState(() => _useMinHeight = v ?? false), child: const Text('Enable minHeight')),
                CheckboxMenuButton(value: _useMaxHeight, onChanged: (bool? v) => setState(() => _useMaxHeight = v ?? false), child: const Text('Enable maxHeight')),
              ],
            ),
            _sliderRow(
              scheme: scheme,
              label: 'minWidth',
              value: _minWidth,
              min: 0,
              max: 520,
              divisions: 130,
              onChanged: (double v) => setState(() => _minWidth = v),
              onChangeEnd: (double v) => _pushTimeline('minWidth', 'minWidth set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'maxWidth',
              value: _maxWidth,
              min: 80,
              max: 720,
              divisions: 160,
              onChanged: (double v) => setState(() => _maxWidth = v),
              onChangeEnd: (double v) => _pushTimeline('maxWidth', 'maxWidth set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'minHeight',
              value: _minHeight,
              min: 0,
              max: 360,
              divisions: 120,
              onChanged: (double v) => setState(() => _minHeight = v),
              onChangeEnd: (double v) => _pushTimeline('minHeight', 'minHeight set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'maxHeight',
              value: _maxHeight,
              min: 60,
              max: 560,
              divisions: 125,
              onChanged: (double v) => setState(() => _maxHeight = v),
              onChangeEnd: (double v) => _pushTimeline('maxHeight', 'maxHeight set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Backdrop Overlay Density',
              value: _overlayDensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _overlayDensity = v),
              onChangeEnd: (double v) => _pushTimeline('Backdrop', 'Overlay density set to ${v.toStringAsFixed(2)}.'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => setState(() => _showGrid = v ?? true), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showBounds, onChanged: (bool? v) => setState(() => _showBounds = v ?? true), child: const Text('Show bounds overlays')),
                CheckboxMenuButton(value: _showClip, onChanged: (bool? v) => setState(() => _showClip = v ?? false), child: const Text('Clip parent')),                
                CheckboxMenuButton(value: _animateChild, onChanged: (bool? v) => setState(() => _animateChild = v ?? false), child: const Text('Animate child size')),
                CheckboxMenuButton(
                  value: _animateBackdrop,
                  onChanged: (bool? v) {
                    final bool next = v ?? true;
                    setState(() => _animateBackdrop = next);
                    if (next) {
                      _motionController.repeat();
                    } else {
                      _motionController.stop();
                    }
                    _pushTimeline('Backdrop', next ? 'Backdrop animation enabled.' : 'Backdrop animation paused.');
                  },
                  child: const Text('Animate backdrop'),
                ),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => setState(() => _showGuide = v ?? true), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => setState(() => _showTimeline = v ?? true), child: const Text('Show timeline board')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderRow({
    required ColorScheme scheme,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onChangeEnd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(color: scheme.onSurface))),
            Text(value.toStringAsFixed(2), style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, onChangeEnd: onChangeEnd),
      ],
    );
  }

  Widget _buildHeroBoard(ColorScheme scheme) {
    final Size childSize = _sceneChildSize();
    final Alignment sceneAlignment = _sceneAlignment();

    Widget stage = SizedBox(
      width: _parentWidth,
      height: _parentHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (_showGrid)
              CustomPaint(
                painter: _GridPainter(
                  progress: _animateBackdrop ? _motionController.value : 0,
                  overlayDensity: _overlayDensity,
                ),
              ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _heroTapCount += 1;
                    _phase = 'hero';
                  });
                  _pushTimeline('Hero Tap', 'Hero stage tapped in ${_scene.name} scene.');
                },
                child: OverflowBox(
                  alignment: sceneAlignment,
                  minWidth: _useMinWidth ? _minWidth * _fitScale() : null,
                  maxWidth: _useMaxWidth ? _maxWidth * _fitScale() : null,
                  minHeight: _useMinHeight ? _minHeight * _fitScale() : null,
                  maxHeight: _useMaxHeight ? _maxHeight * _fitScale() : null,
                  child: _OverflowChildSurface(
                    width: childSize.width,
                    height: childSize.height,
                    scene: _scene,
                    showBounds: _showBounds,
                    colorA: scheme.primary,
                    colorB: scheme.tertiary,
                  ),
                ),
              ),
            ),
            if (_showBounds)
              IgnorePointer(
                child: CustomPaint(
                  painter: _BoundsPainter(
                    parentColor: scheme.error.withValues(alpha: 0.85),
                    childColor: scheme.primary.withValues(alpha: 0.70),
                    parentSize: Size(_parentWidth, _parentHeight),
                    childSize: childSize,
                    alignment: sceneAlignment,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (_showClip) {
      stage = ClipRect(child: stage);
    }

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hero Overflow Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Primary visual board for parent constraints, child overflow, alignment, and clip decisions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Center(child: stage),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _pill('scene: ${_scene.name}'),
                _pill('fitMode: ${_fitMode.name}'),
                _pill('parent: ${_parentWidth.toStringAsFixed(0)}x${_parentHeight.toStringAsFixed(0)}'),
                _pill('child: ${childSize.width.toStringAsFixed(0)}x${childSize.height.toStringAsFixed(0)}'),
                _pill('clip: ${_showClip ? 'on' : 'off'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildSceneGalleryBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Overflow Scene Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Multiple illustrative use cases of intentional overflow under different scene presets.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1200
                    ? 3
                    : constraints.maxWidth > 760
                        ? 2
                        : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _demoTiles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.2 : 1.30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _DemoTileModel tile = _demoTiles[index];
                    return _sceneTile(scheme, tile, index);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sceneTile(ColorScheme scheme, _DemoTileModel tile, int index) {
    final _OverflowScene localScene = _OverflowScene.values[index % _OverflowScene.values.length];
    final Alignment localAlignment = _alignmentOptions[index % _alignmentOptions.length].value;
    final Size localChild = Size(220 + (index * 16), 130 + (index * 14));
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text(tile.label, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700))),
                Text(localScene.name, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 4),
            Text(tile.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tileTapCount += 1;
                    _lastTile = tile.label;
                    _phase = 'tile';
                  });
                  _pushTimeline('Tile Tap', 'Tapped gallery tile ${tile.label} (${localScene.name}).');
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Center(
                        child: OverflowBox(
                          alignment: localAlignment,
                          minWidth: _useMinWidth ? (_minWidth * 0.6) * _fitScale() : null,
                          maxWidth: _useMaxWidth ? (_maxWidth * 0.7) * _fitScale() : null,
                          minHeight: _useMinHeight ? (_minHeight * 0.6) * _fitScale() : null,
                          maxHeight: _useMaxHeight ? (_maxHeight * 0.7) * _fitScale() : null,
                          child: Container(
                            width: localChild.width,
                            height: localChild.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: <Color>[tile.colorA, tile.colorB],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                CustomPaint(painter: _StripePainter(density: 0.34 + (index * 0.07).clamp(0, 0.5), color: Colors.white.withValues(alpha: 0.20))),
                                Center(
                                  child: Text(tile.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_showBounds)
                        IgnorePointer(
                          child: CustomPaint(
                            painter: _BoundsPainter(
                              parentColor: scheme.error.withValues(alpha: 0.75),
                              childColor: scheme.primary.withValues(alpha: 0.70),
                              parentSize: const Size(280, 150),
                              childSize: localChild,
                              alignment: localAlignment,
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
      ),
    );
  }

  Widget _buildComparisonBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Comparison Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Contrast intentional overflow behavior with neighboring constraint widgets.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget overflow = _comparisonCard(
                  scheme: scheme,
                  title: 'OverflowBox',
                  subtitle: 'Child can exceed parent constraints via min/max and fit.',
                  color: const Color(0xFF0F766E),
                  child: OverflowBox(
                    alignment: _sceneAlignment(),
                    minWidth: _useMinWidth ? (_minWidth * 0.5) * _fitScale() : null,
                    maxWidth: _useMaxWidth ? (_maxWidth * 0.6) * _fitScale() : null,
                    minHeight: _useMinHeight ? (_minHeight * 0.5) * _fitScale() : null,
                    maxHeight: _useMaxHeight ? (_maxHeight * 0.6) * _fitScale() : null,
                    child: Container(width: 190, height: 130, color: const Color(0xFF14B8A6), alignment: Alignment.center, child: const Text('Overflow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                  ),
                );
                final Widget sizedOverflow = _comparisonCard(
                  scheme: scheme,
                  title: 'SizedOverflowBox',
                  subtitle: 'Reports fixed size but allows child to paint larger.',
                  color: const Color(0xFF1D4ED8),
                  child: SizedOverflowBox(
                    size: const Size(120, 80),
                    child: Container(width: 190, height: 130, color: const Color(0xFF3B82F6), alignment: Alignment.center, child: const Text('SizedOverflow', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11))),
                  ),
                );
                final Widget constrained = _comparisonCard(
                  scheme: scheme,
                  title: 'ConstrainedBox',
                  subtitle: 'Strictly applies constraints without overflow escape behavior.',
                  color: const Color(0xFFB45309),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 120, height: 80),
                    child: Container(color: const Color(0xFFF59E0B), alignment: Alignment.center, child: const Text('Constrained', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                  ),
                );
                if (narrow) {
                  return Column(children: <Widget>[overflow, const SizedBox(height: 10), sizedOverflow, const SizedBox(height: 10), constrained]);
                }
                return Row(children: <Widget>[Expanded(child: overflow), const SizedBox(width: 10), Expanded(child: sizedOverflow), const SizedBox(width: 10), Expanded(child: constrained)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required Color color, required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.70))),
              child: Center(child: child),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricEntry> metrics = _metrics();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Metrics and Diagnostics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1180
                    ? 4
                    : constraints.maxWidth > 860
                        ? 3
                        : constraints.maxWidth > 560
                            ? 2
                            : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.6 : 1.95,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricEntry m = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(m.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(m.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(m.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(m.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 12),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    final Size child = _sceneChildSize();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('theme=${_themePresets[_themeIndex].id} scenario=${_scenarioLanes[_scenarioIndex].id} scene=${_scene.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('fitMode=${_fitMode.name} alignment=${_alignmentOptions.firstWhere(( _AlignmentOption o) => o.value == _alignment).label}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('parent=${_parentWidth.toStringAsFixed(0)}x${_parentHeight.toStringAsFixed(0)} child=${child.width.toStringAsFixed(0)}x${child.height.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('minW=${_useMinWidth ? _minWidth.toStringAsFixed(0) : 'off'} maxW=${_useMaxWidth ? _maxWidth.toStringAsFixed(0) : 'off'} minH=${_useMinHeight ? _minHeight.toStringAsFixed(0) : 'off'} maxH=${_useMaxHeight ? _maxHeight.toStringAsFixed(0) : 'off'}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('clip=$_showClip bounds=$_showBounds grid=$_showGrid animateChild=$_animateChild', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('sceneSwitch=$_sceneSwitchCount fitSwitch=$_fitSwitchCount alignSwitch=$_alignmentSwitchCount themeSwitch=$_themeSwitchCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('heroTap=$_heroTapCount tileTap=$_tileTapCount phase=$_phase lastTile=$_lastTile', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide and FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._guideBullets.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 4), child: Icon(Icons.circle, size: 8, color: scheme.primary)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            ..._faqItems.map(( _FaqItem item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(item.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(onPressed: () => setState(() => _timeline = const <_TimelineEvent>[]), icon: const Icon(Icons.clear_all), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of scene changes, fit toggles, and interaction events.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with controls to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEvent e) {
                  final String stamp = '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}:${e.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text(e.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${e.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _OverflowChildSurface extends StatelessWidget {
  const _OverflowChildSurface({
    required this.width,
    required this.height,
    required this.scene,
    required this.showBounds,
    required this.colorA,
    required this.colorB,
  });

  final double width;
  final double height;
  final _OverflowScene scene;
  final bool showBounds;
  final Color colorA;
  final Color colorB;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: <Color>[colorA, colorB],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _StripePainter(density: 0.38 + (scene.index * 0.05), color: Colors.white.withValues(alpha: 0.22))),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.open_in_full_outlined, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Overflow Scene: ${scene.name}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Child size ${width.toStringAsFixed(0)} x ${height.toStringAsFixed(0)}', style: TextStyle(color: Colors.white.withValues(alpha: 0.92))),
                const Spacer(),
                if (showBounds)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
                    child: const Text('Bounds overlay active', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.progress, required this.overlayDensity});

  final double progress;
  final double overlayDensity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF14B8A6), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..strokeWidth = 1;
    const double step = 24;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Paint wash = Paint()..color = Colors.black.withValues(alpha: overlayDensity * 0.40);
    canvas.drawRect(Offset.zero & size, wash);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.overlayDensity != overlayDensity;
  }
}

class _StripePainter extends CustomPainter {
  _StripePainter({required this.density, required this.color});

  final double density;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.1;
    final double step = (26 - (density * 18)).clamp(6, 26);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.density != density || oldDelegate.color != color;
  }
}

class _BoundsPainter extends CustomPainter {
  _BoundsPainter({
    required this.parentColor,
    required this.childColor,
    required this.parentSize,
    required this.childSize,
    required this.alignment,
  });

  final Color parentColor;
  final Color childColor;
  final Size parentSize;
  final Size childSize;
  final Alignment alignment;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect parentRect = Offset.zero & size;
    final Paint parent = Paint()
      ..color = parentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawRect(parentRect, parent);

    final Rect childRect = alignment.inscribe(childSize, parentRect);
    final Paint child = Paint()
      ..color = childColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRect(childRect, child);
  }

  @override
  bool shouldRepaint(covariant _BoundsPainter oldDelegate) {
    return oldDelegate.parentColor != parentColor || oldDelegate.childColor != childColor || oldDelegate.parentSize != parentSize || oldDelegate.childSize != childSize || oldDelegate.alignment != alignment;
  }
}
