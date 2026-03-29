import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'marine',
    name: 'Marine Deck',
    description: 'Balanced palette for slot geometry and delegate tracing.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Desk',
    description: 'Warm palette for overlap and sequencing diagnostics.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'cobalt',
    name: 'Cobalt View',
    description: 'Cool palette for spatial layouts and alignment reviews.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Ops',
    description: 'Dark palette for high-contrast layout boundary analysis.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ScenarioLane> _scenarioLanes = <_ScenarioLane>[
  _ScenarioLane(
    id: 'dashboard',
    title: 'Dashboard Shell',
    subtitle: 'Header, rail, content, and footer slots in a structured shell layout.',
  ),
  _ScenarioLane(
    id: 'orbit',
    title: 'Orbit Layout',
    subtitle: 'Center anchor and orbiting slots to demonstrate free-form delegate positioning.',
  ),
  _ScenarioLane(
    id: 'waterfall',
    title: 'Waterfall Lanes',
    subtitle: 'Column distribution and staggered vertical placement through delegate logic.',
  ),
  _ScenarioLane(
    id: 'overlap',
    title: 'Overlap Stage',
    subtitle: 'Intentional z-order overlap and anchor offsets for layered presentation.',
  ),
  _ScenarioLane(
    id: 'bands',
    title: 'Adaptive Bands',
    subtitle: 'Responsive slot bands for width-dependent arrangement patterns.',
  ),
];

const List<String> _guideBullets = <String>[
  'RenderCustomMultiChildLayoutBox is the render object behind CustomMultiChildLayout.',
  'A MultiChildLayoutDelegate defines each slot ID, its constraints, and its offset.',
  'Use hasChild before layoutChild/positionChild to support optional slot visibility.',
  'Slot IDs should be stable so layout updates remain predictable and debuggable.',
  'Custom delegates are ideal when relationship between children is semantic rather than linear.',
  'Keep delegate state minimal and deterministic; use relayout only when values actually change.',
  'Pair custom delegates with visual boundaries to verify slot collisions and spacing intent.',
  'Use per-slot metrics and timeline logging to reproduce layout regressions quickly.',
  'For heavily adaptive designs, compare custom delegate output to simpler layout widgets first.',
  'Document slot contracts clearly so shared components can evolve without breaking layout assumptions.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'When should I use CustomMultiChildLayout?',
    answer: 'When child placement depends on semantic slot relationships not easily modeled by Row, Column, or Stack alone.',
  ),
  _FaqItem(
    question: 'How do delegates handle optional children?',
    answer: 'Check hasChild(slotId) before layoutChild or positionChild to avoid exceptions and support dynamic visibility.',
  ),
  _FaqItem(
    question: 'What triggers relayout?',
    answer: 'Delegate changes where shouldRelayout returns true, or value notifiers passed as relayout signals.',
  ),
  _FaqItem(
    question: 'Can delegates overlap children intentionally?',
    answer: 'Yes, delegates can place children anywhere in the parent space, including overlapping positions.',
  ),
  _FaqItem(
    question: 'How can I debug slot placement quickly?',
    answer: 'Show slot bounds, capture metrics for each slot, and record configuration snapshots with timeline events.',
  ),
];

const List<_SlotSpec> _slotSpecs = <_SlotSpec>[
  _SlotSpec(id: 'header', label: 'Header', colorA: Color(0xFF0EA5E9), colorB: Color(0xFF38BDF8), note: 'Primary top region'),
  _SlotSpec(id: 'rail', label: 'Rail', colorA: Color(0xFF22C55E), colorB: Color(0xFF16A34A), note: 'Side navigation lane'),
  _SlotSpec(id: 'content', label: 'Content', colorA: Color(0xFFF59E0B), colorB: Color(0xFFF97316), note: 'Main working area'),
  _SlotSpec(id: 'footer', label: 'Footer', colorA: Color(0xFF8B5CF6), colorB: Color(0xFF6366F1), note: 'Bottom status lane'),
  _SlotSpec(id: 'badge', label: 'Badge', colorA: Color(0xFFF43F5E), colorB: Color(0xFFFB7185), note: 'Floating marker slot'),
  _SlotSpec(id: 'aux', label: 'Aux', colorA: Color(0xFF14B8A6), colorB: Color(0xFF06B6D4), note: 'Auxiliary support slot'),
];

enum _DelegateMode {
  dashboard,
  orbit,
  waterfall,
  overlap,
  bands,
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

class _SlotSpec {
  const _SlotSpec({required this.id, required this.label, required this.colorA, required this.colorB, required this.note});

  final String id;
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

class _SlotGeometry {
  const _SlotGeometry({required this.id, required this.rect});

  final String id;
  final Rect rect;
}

class _LayoutSnapshot {
  const _LayoutSnapshot({
    required this.mode,
    required this.visibleCount,
    required this.bounds,
  });

  final String mode;
  final int visibleCount;
  final List<_SlotGeometry> bounds;
}

dynamic build(BuildContext context) {
  return const _RenderCustomMultiChildLayoutBoxStudio();
}

class _RenderCustomMultiChildLayoutBoxStudio extends StatefulWidget {
  const _RenderCustomMultiChildLayoutBoxStudio();

  @override
  State<_RenderCustomMultiChildLayoutBoxStudio> createState() => _RenderCustomMultiChildLayoutBoxStudioState();
}

class _RenderCustomMultiChildLayoutBoxStudioState extends State<_RenderCustomMultiChildLayoutBoxStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _motionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7200),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _DelegateMode _mode = _DelegateMode.dashboard;

  bool _showGrid = true;
  bool _showBounds = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _animateBackdrop = true;
  bool _animateOrbit = false;
  bool _compactSlots = false;

  bool _showHeader = true;
  bool _showRail = true;
  bool _showContent = true;
  bool _showFooter = true;
  bool _showBadge = true;
  bool _showAux = true;

  double _canvasWidth = 640;
  double _canvasHeight = 360;
  double _gap = 16;
  double _orbitRadius = 120;
  double _waterfallStagger = 28;
  double _overlapFactor = 0.34;
  double _bandBias = 0.52;
  double _overlayDensity = 0.38;
  double _panelPadding = 14;

  int _modeSwitchCount = 0;
  int _themeSwitchCount = 0;
  int _scenarioSwitchCount = 0;
  int _slotToggleCount = 0;
  int _canvasTapCount = 0;

  String _phase = 'idle';
  String _lastTappedSlot = 'none';

  _LayoutSnapshot _snapshot = const _LayoutSnapshot(mode: 'dashboard', visibleCount: 0, bounds: <_SlotGeometry>[]);
  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderCustomMultiChildLayoutBox delegate lab initialized.');
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
      ].take(80).toList(growable: false);
    });
  }

  Set<String> _visibleSlots() {
    final Set<String> slots = <String>{};
    if (_showHeader) {
      slots.add('header');
    }
    if (_showRail) {
      slots.add('rail');
    }
    if (_showContent) {
      slots.add('content');
    }
    if (_showFooter) {
      slots.add('footer');
    }
    if (_showBadge) {
      slots.add('badge');
    }
    if (_showAux) {
      slots.add('aux');
    }
    return slots;
  }

  void _reset() {
    setState(() {
      _scenarioIndex = 0;
      _mode = _DelegateMode.dashboard;
      _showGrid = true;
      _showBounds = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _animateBackdrop = true;
      _animateOrbit = false;
      _compactSlots = false;
      _showHeader = true;
      _showRail = true;
      _showContent = true;
      _showFooter = true;
      _showBadge = true;
      _showAux = true;
      _canvasWidth = 640;
      _canvasHeight = 360;
      _gap = 16;
      _orbitRadius = 120;
      _waterfallStagger = 28;
      _overlapFactor = 0.34;
      _bandBias = 0.52;
      _overlayDensity = 0.38;
      _panelPadding = 14;
      _modeSwitchCount = 0;
      _themeSwitchCount = 0;
      _scenarioSwitchCount = 0;
      _slotToggleCount = 0;
      _canvasTapCount = 0;
      _phase = 'idle';
      _lastTappedSlot = 'none';
      _snapshot = const _LayoutSnapshot(mode: 'dashboard', visibleCount: 0, bounds: <_SlotGeometry>[]);
      _timeline = const <_TimelineEvent>[];
    });
    _motionController.repeat();
    _pushTimeline('Reset', 'Delegate lab reset to defaults.');
  }

  _DelegateMode _effectiveMode() {
    switch (_scenarioIndex) {
      case 0:
        return _DelegateMode.dashboard;
      case 1:
        return _DelegateMode.orbit;
      case 2:
        return _DelegateMode.waterfall;
      case 3:
        return _DelegateMode.overlap;
      case 4:
        return _DelegateMode.bands;
    }
    return _mode;
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarioLanes[_scenarioIndex].title, note: 'Current delegate exploration lane.', icon: Icons.dashboard_customize_outlined),
      _MetricEntry(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Active visual profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Mode', value: _effectiveMode().name, note: 'Delegate strategy in use.', icon: Icons.account_tree_outlined),
      _MetricEntry(label: 'Visible Slots', value: '${_snapshot.visibleCount}', note: 'Slots currently laid out by delegate.', icon: Icons.widgets_outlined),
      _MetricEntry(label: 'Canvas', value: '${_canvasWidth.toStringAsFixed(0)} x ${_canvasHeight.toStringAsFixed(0)}', note: 'Multi-child layout canvas size.', icon: Icons.crop_square_outlined),
      _MetricEntry(label: 'Gap', value: _gap.toStringAsFixed(1), note: 'Base spacing used by delegates.', icon: Icons.space_bar_outlined),
      _MetricEntry(label: 'Orbit Radius', value: _orbitRadius.toStringAsFixed(1), note: 'Orbit delegate radial distance.', icon: Icons.radar_outlined),
      _MetricEntry(label: 'Waterfall Stagger', value: _waterfallStagger.toStringAsFixed(1), note: 'Lane offset in waterfall mode.', icon: Icons.waterfall_chart_outlined),
      _MetricEntry(label: 'Overlap Factor', value: _overlapFactor.toStringAsFixed(2), note: 'Overlap intensity for layered mode.', icon: Icons.layers_outlined),
      _MetricEntry(label: 'Band Bias', value: _bandBias.toStringAsFixed(2), note: 'Adaptive split bias for band mode.', icon: Icons.view_week_outlined),
      _MetricEntry(label: 'Mode Switches', value: '$_modeSwitchCount', note: 'Manual mode control changes.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Theme Switches', value: '$_themeSwitchCount', note: 'Theme profile changes.', icon: Icons.color_lens_outlined),
      _MetricEntry(label: 'Scenario Switches', value: '$_scenarioSwitchCount', note: 'Scenario lane changes.', icon: Icons.route_outlined),
      _MetricEntry(label: 'Slot Toggles', value: '$_slotToggleCount', note: 'Visibility toggles for slots.', icon: Icons.toggle_on_outlined),
      _MetricEntry(label: 'Canvas Taps', value: '$_canvasTapCount', note: 'Interactions on layout canvas.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Current interaction phase.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Last Slot Tap', value: _lastTappedSlot, note: 'Most recently tapped slot.', icon: Icons.pin_drop_outlined),
      _MetricEntry(label: 'Snapshot Mode', value: _snapshot.mode, note: 'Latest delegate mode captured in snapshot.', icon: Icons.camera_outlined),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: preset.seed, brightness: preset.brightness);

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
                        _buildDelegateStageBoard(scheme),
                        const SizedBox(height: 16),
                        _buildSlotGalleryBoard(scheme),
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
                Icon(Icons.dashboard_customize_outlined, color: scheme.primary, size: 26),
                Text('RenderCustomMultiChildLayoutBox Delegate Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioLanes[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual exploration of CustomMultiChildLayout delegates and slot-based layout orchestration, powered by RenderCustomMultiChildLayoutBox at the rendering layer.',
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
                final _ThemePreset preset = _themePresets[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(preset.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitchCount += 1;
                      _phase = 'theme';
                    });
                    _pushTimeline('Theme', 'Theme switched to ${preset.name}.');
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
                final _ScenarioLane lane = _scenarioLanes[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(lane.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _phase = 'scenario';
                      _scenarioSwitchCount += 1;
                    });
                    _pushTimeline('Scenario', lane.subtitle);
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
                Text('Delegate Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Adjust canvas geometry, delegate strategy, slot visibility, and motion parameters.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _DelegateMode.values.map(( _DelegateMode mode) {
                return ChoiceChip(
                  selected: _mode == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _mode = mode;
                      _modeSwitchCount += 1;
                      _phase = 'mode';
                    });
                    _pushTimeline('Mode', 'Manual delegate mode switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            _sliderRow(
              scheme: scheme,
              label: 'Canvas Width',
              value: _canvasWidth,
              min: 420,
              max: 980,
              divisions: 280,
              onChanged: (double v) => setState(() => _canvasWidth = v),
              onChangeEnd: (double v) => _pushTimeline('Canvas Width', 'Canvas width set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Canvas Height',
              value: _canvasHeight,
              min: 240,
              max: 560,
              divisions: 160,
              onChanged: (double v) => setState(() => _canvasHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Canvas Height', 'Canvas height set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Gap',
              value: _gap,
              min: 2,
              max: 42,
              divisions: 80,
              onChanged: (double v) => setState(() => _gap = v),
              onChangeEnd: (double v) => _pushTimeline('Gap', 'Gap set to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Orbit Radius',
              value: _orbitRadius,
              min: 24,
              max: 220,
              divisions: 98,
              onChanged: (double v) => setState(() => _orbitRadius = v),
              onChangeEnd: (double v) => _pushTimeline('Orbit Radius', 'Orbit radius set to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Waterfall Stagger',
              value: _waterfallStagger,
              min: 0,
              max: 92,
              divisions: 92,
              onChanged: (double v) => setState(() => _waterfallStagger = v),
              onChangeEnd: (double v) => _pushTimeline('Waterfall', 'Stagger set to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Overlap Factor',
              value: _overlapFactor,
              min: 0,
              max: 0.9,
              divisions: 90,
              onChanged: (double v) => setState(() => _overlapFactor = v),
              onChangeEnd: (double v) => _pushTimeline('Overlap', 'Overlap factor set to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Band Bias',
              value: _bandBias,
              min: 0.2,
              max: 0.8,
              divisions: 60,
              onChanged: (double v) => setState(() => _bandBias = v),
              onChangeEnd: (double v) => _pushTimeline('Bands', 'Band bias set to ${v.toStringAsFixed(2)}.'),
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
                CheckboxMenuButton(value: _showHeader, onChanged: (bool? v) => _toggleSlot(v, 'header'), child: const Text('Header slot')),
                CheckboxMenuButton(value: _showRail, onChanged: (bool? v) => _toggleSlot(v, 'rail'), child: const Text('Rail slot')),
                CheckboxMenuButton(value: _showContent, onChanged: (bool? v) => _toggleSlot(v, 'content'), child: const Text('Content slot')),
                CheckboxMenuButton(value: _showFooter, onChanged: (bool? v) => _toggleSlot(v, 'footer'), child: const Text('Footer slot')),
                CheckboxMenuButton(value: _showBadge, onChanged: (bool? v) => _toggleSlot(v, 'badge'), child: const Text('Badge slot')),
                CheckboxMenuButton(value: _showAux, onChanged: (bool? v) => _toggleSlot(v, 'aux'), child: const Text('Aux slot')),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => setState(() => _showGrid = v ?? true), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showBounds, onChanged: (bool? v) => setState(() => _showBounds = v ?? true), child: const Text('Show slot bounds')),
                CheckboxMenuButton(value: _animateOrbit, onChanged: (bool? v) => setState(() => _animateOrbit = v ?? false), child: const Text('Animate orbit')),
                CheckboxMenuButton(value: _compactSlots, onChanged: (bool? v) => setState(() => _compactSlots = v ?? false), child: const Text('Compact slot cards')),
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

  void _toggleSlot(bool? value, String id) {
    final bool next = value ?? false;
    setState(() {
      switch (id) {
        case 'header':
          _showHeader = next;
          break;
        case 'rail':
          _showRail = next;
          break;
        case 'content':
          _showContent = next;
          break;
        case 'footer':
          _showFooter = next;
          break;
        case 'badge':
          _showBadge = next;
          break;
        case 'aux':
          _showAux = next;
          break;
      }
      _slotToggleCount += 1;
      _phase = 'slot-toggle';
    });
    _pushTimeline('Slot Toggle', '$id slot ${next ? 'enabled' : 'disabled'}.');
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

  Widget _buildDelegateStageBoard(ColorScheme scheme) {
    final Set<String> visible = _visibleSlots();
    final _DelegateMode mode = _effectiveMode();
    final double orbitAngle = _animateOrbit ? _motionController.value * math.pi * 2 : 0;

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Delegate Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('CustomMultiChildLayout board showing active slot contracts and delegate positioning.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _canvasTapCount += 1;
                    _phase = 'canvas';
                  });
                  _pushTimeline('Canvas Tap', 'Delegate stage tapped while in ${mode.name} mode.');
                },
                child: SizedBox(
                  width: _canvasWidth,
                  height: _canvasHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (_showGrid)
                          CustomPaint(
                            painter: _BackdropPainter(
                              progress: _animateBackdrop ? _motionController.value : 0,
                              overlayDensity: _overlayDensity,
                            ),
                          ),
                        CustomMultiChildLayout(
                          delegate: _delegateForMode(mode, orbitAngle),
                          children: _slotChildren(scheme, visible),
                        ),
                        if (_showBounds)
                          IgnorePointer(
                            child: _SlotBoundsOverlay(bounds: _snapshot.bounds, color: scheme.onSurface.withValues(alpha: 0.62)),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _pill('mode: ${mode.name}'),
                _pill('slots: ${visible.length}'),
                _pill('canvas: ${_canvasWidth.toStringAsFixed(0)}x${_canvasHeight.toStringAsFixed(0)}'),
                _pill('gap: ${_gap.toStringAsFixed(1)}'),
                _pill('orbit: ${_orbitRadius.toStringAsFixed(1)}'),
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
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.20), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  List<Widget> _slotChildren(ColorScheme scheme, Set<String> visible) {
    final List<Widget> children = <Widget>[];
    for (final _SlotSpec spec in _slotSpecs) {
      if (!visible.contains(spec.id)) {
        continue;
      }
      children.add(
        LayoutId(
          id: spec.id,
          child: _SlotCard(
            spec: spec,
            compact: _compactSlots,
            onTap: () {
              setState(() {
                _lastTappedSlot = spec.id;
                _phase = 'slot-tap';
              });
              _pushTimeline('Slot Tap', 'Tapped slot ${spec.id}.');
            },
          ),
        ),
      );
    }
    return children;
  }

  MultiChildLayoutDelegate _delegateForMode(_DelegateMode mode, double orbitAngle) {
    void onSnapshot(_LayoutSnapshot snap) {
      if (mounted) {
        setState(() => _snapshot = snap);
      }
    }
    switch (mode) {
      case _DelegateMode.dashboard:
        return _DashboardDelegate(gap: _gap, onSnapshot: onSnapshot);
      case _DelegateMode.orbit:
        return _OrbitDelegate(radius: _orbitRadius, baseAngle: orbitAngle, gap: _gap, onSnapshot: onSnapshot);
      case _DelegateMode.waterfall:
        return _WaterfallDelegate(gap: _gap, stagger: _waterfallStagger, onSnapshot: onSnapshot);
      case _DelegateMode.overlap:
        return _OverlapDelegate(gap: _gap, overlapFactor: _overlapFactor, onSnapshot: onSnapshot);
      case _DelegateMode.bands:
        return _BandDelegate(gap: _gap, bias: _bandBias, onSnapshot: onSnapshot);
    }
  }

  Widget _buildSlotGalleryBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Slot Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Slot cards and notes used across delegate modes, with quick identity and intent references.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  itemCount: _slotSpecs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.2 : 1.3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _SlotSpec spec = _slotSpecs[index];
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
                                Expanded(child: Text(spec.label, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700))),
                                Text(spec.id, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(spec.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                            const SizedBox(height: 8),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _lastTappedSlot = spec.id;
                                    _phase = 'gallery-slot';
                                  });
                                  _pushTimeline('Gallery Slot Tap', 'Tapped slot gallery card ${spec.id}.');
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: <Color>[spec.colorA, spec.colorB], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      CustomPaint(painter: _StripePainter(density: 0.34 + (index * 0.06), color: Colors.white.withValues(alpha: 0.20))),
                                      Center(child: Text(spec.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
            Text('Contrast custom delegate-driven layout with Stack and Wrap for placement strategy decisions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget custom = _comparisonCard(
                  scheme: scheme,
                  title: 'CustomMultiChildLayout',
                  subtitle: 'Semantic slot contract with explicit delegate placement.',
                  color: const Color(0xFF0F766E),
                  child: const Text('Delegate-controlled', textAlign: TextAlign.center),
                );
                final Widget stack = _comparisonCard(
                  scheme: scheme,
                  title: 'Stack',
                  subtitle: 'Layered positioning with a simpler widget-level API.',
                  color: const Color(0xFF1D4ED8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const <Widget>[Icon(Icons.crop_square, size: 44), Icon(Icons.layers_outlined, size: 26)],
                  ),
                );
                final Widget wrap = _comparisonCard(
                  scheme: scheme,
                  title: 'Wrap',
                  subtitle: 'Flow layout without custom slot contracts.',
                  color: const Color(0xFFB45309),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: const <Widget>[Chip(label: Text('A')), Chip(label: Text('B')), Chip(label: Text('C'))],
                  ),
                );
                if (narrow) {
                  return Column(children: <Widget>[custom, const SizedBox(height: 10), stack, const SizedBox(height: 10), wrap]);
                }
                return Row(children: <Widget>[Expanded(child: custom), const SizedBox(width: 10), Expanded(child: stack), const SizedBox(width: 10), Expanded(child: wrap)]);
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
              height: 100,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.70))),
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
                    childAspectRatio: columns == 1 ? 2.65 : 1.95,
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
            Text('theme=${_themePresets[_themeIndex].id} scenario=${_scenarioLanes[_scenarioIndex].id} mode=${_effectiveMode().name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('canvas=${_canvasWidth.toStringAsFixed(0)}x${_canvasHeight.toStringAsFixed(0)} gap=${_gap.toStringAsFixed(1)} compact=$_compactSlots', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('orbit=${_orbitRadius.toStringAsFixed(1)} waterfall=${_waterfallStagger.toStringAsFixed(1)} overlap=${_overlapFactor.toStringAsFixed(2)} bands=${_bandBias.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('slots header=$_showHeader rail=$_showRail content=$_showContent footer=$_showFooter badge=$_showBadge aux=$_showAux', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches mode=$_modeSwitchCount scenario=$_scenarioSwitchCount theme=$_themeSwitchCount slot=$_slotToggleCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('canvasTap=$_canvasTapCount phase=$_phase lastTap=$_lastTappedSlot visible=${_snapshot.visibleCount}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological log of delegate mode changes, slot toggles, and stage interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _SlotCard extends StatelessWidget {
  const _SlotCard({required this.spec, required this.compact, required this.onTap});

  final _SlotSpec spec;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: compact ? 94 : 132,
          height: compact ? 64 : 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: <Color>[spec.colorA, spec.colorB], begin: Alignment.topLeft, end: Alignment.bottomRight),
            border: Border.all(color: Colors.black.withValues(alpha: 0.16)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CustomPaint(painter: _StripePainter(density: compact ? 0.52 : 0.38, color: Colors.white.withValues(alpha: 0.22))),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(spec.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                    const Spacer(),
                    Text(spec.id, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlotBoundsOverlay extends StatelessWidget {
  const _SlotBoundsOverlay({required this.bounds, required this.color});

  final List<_SlotGeometry> bounds;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SlotBoundsPainter(bounds: bounds, color: color),
    );
  }
}

class _SlotBoundsPainter extends CustomPainter {
  _SlotBoundsPainter({required this.bounds, required this.color});

  final List<_SlotGeometry> bounds;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint fill = Paint()..color = color.withValues(alpha: 0.10);

    for (final _SlotGeometry geometry in bounds) {
      final RRect r = RRect.fromRectAndRadius(geometry.rect, const Radius.circular(8));
      canvas.drawRRect(r, fill);
      canvas.drawRRect(r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SlotBoundsPainter oldDelegate) {
    return oldDelegate.bounds != bounds || oldDelegate.color != color;
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({required this.progress, required this.overlayDensity});

  final double progress;
  final double overlayDensity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF14B8A6), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF3B82F6), (math.sin(progress * math.pi * 4) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..strokeWidth = 1;
    const double step = 24;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Paint wash = Paint()..color = Colors.black.withValues(alpha: overlayDensity * 0.46);
    canvas.drawRect(Offset.zero & size, wash);
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter oldDelegate) {
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
      ..strokeWidth = 1.0;
    final double step = (26 - (density * 20)).clamp(6, 26);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.density != density || oldDelegate.color != color;
  }
}

abstract class _BaseDelegate extends MultiChildLayoutDelegate {
  _BaseDelegate({required this.gap, required this.modeName, required this.onSnapshot});

  final double gap;
  final String modeName;
  final ValueChanged<_LayoutSnapshot> onSnapshot;

  List<_SlotGeometry> collectSnapshot(Map<String, Rect> map) {
    final List<_SlotGeometry> bounds = map.entries.map((MapEntry<String, Rect> e) => _SlotGeometry(id: e.key, rect: e.value)).toList(growable: false);
    onSnapshot(_LayoutSnapshot(mode: modeName, visibleCount: bounds.length, bounds: bounds));
    return bounds;
  }

  Size layoutLooseChild(String id, BoxConstraints constraints) {
    return layoutChild(id, constraints);
  }
}

class _DashboardDelegate extends _BaseDelegate {
  _DashboardDelegate({required super.gap, required super.onSnapshot}) : super(modeName: 'dashboard');

  @override
  void performLayout(Size size) {
    final Map<String, Rect> rects = <String, Rect>{};
    final double headerH = size.height * 0.18;
    final double footerH = size.height * 0.16;
    final double railW = size.width * 0.22;

    if (hasChild('header')) {
      final Size s = layoutLooseChild('header', BoxConstraints.tightFor(width: size.width - (gap * 2), height: headerH - gap));
      final Offset o = Offset(gap, gap);
      positionChild('header', o);
      rects['header'] = o & s;
    }
    if (hasChild('rail')) {
      final Size s = layoutLooseChild('rail', BoxConstraints.tightFor(width: railW - gap, height: size.height - headerH - footerH - (gap * 2)));
      final Offset o = Offset(gap, headerH + gap);
      positionChild('rail', o);
      rects['rail'] = o & s;
    }
    if (hasChild('content')) {
      final double contentW = size.width - railW - (gap * 3);
      final double contentH = size.height - headerH - footerH - (gap * 2);
      final Size s = layoutLooseChild('content', BoxConstraints.tightFor(width: contentW, height: contentH));
      final Offset o = Offset(railW + (gap * 2), headerH + gap);
      positionChild('content', o);
      rects['content'] = o & s;
    }
    if (hasChild('footer')) {
      final Size s = layoutLooseChild('footer', BoxConstraints.tightFor(width: size.width - (gap * 2), height: footerH - gap));
      final Offset o = Offset(gap, size.height - footerH);
      positionChild('footer', o);
      rects['footer'] = o & s;
    }
    if (hasChild('badge')) {
      final Size s = layoutLooseChild('badge', const BoxConstraints.tightFor(width: 88, height: 56));
      final Offset o = Offset(size.width - s.width - (gap * 1.2), gap * 1.5);
      positionChild('badge', o);
      rects['badge'] = o & s;
    }
    if (hasChild('aux')) {
      final Size s = layoutLooseChild('aux', const BoxConstraints.tightFor(width: 120, height: 62));
      final Offset o = Offset(size.width - s.width - (gap * 1.4), size.height - s.height - footerH - (gap * 0.6));
      positionChild('aux', o);
      rects['aux'] = o & s;
    }

    collectSnapshot(rects);
  }

  @override
  bool shouldRelayout(covariant _DashboardDelegate oldDelegate) => oldDelegate.gap != gap;
}

class _OrbitDelegate extends _BaseDelegate {
  _OrbitDelegate({required this.radius, required this.baseAngle, required super.gap, required super.onSnapshot}) : super(modeName: 'orbit');

  final double radius;
  final double baseAngle;

  @override
  void performLayout(Size size) {
    final Map<String, Rect> rects = <String, Rect>{};
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);

    if (hasChild('content')) {
      final Size s = layoutLooseChild('content', const BoxConstraints.tightFor(width: 190, height: 120));
      final Offset o = Offset(center.dx - (s.width * 0.5), center.dy - (s.height * 0.5));
      positionChild('content', o);
      rects['content'] = o & s;
    }

    final List<String> orbiters = <String>['header', 'rail', 'footer', 'badge', 'aux'];
    int orbiterIndex = 0;
    for (final String id in orbiters) {
      if (!hasChild(id)) {
        continue;
      }
      final Size s = layoutLooseChild(id, const BoxConstraints.tightFor(width: 120, height: 74));
      final double angle = baseAngle + ((orbiterIndex / math.max(1, orbiters.length)) * math.pi * 2);
      final Offset o = Offset(center.dx + math.cos(angle) * radius - (s.width * 0.5), center.dy + math.sin(angle) * radius - (s.height * 0.5));
      positionChild(id, o);
      rects[id] = o & s;
      orbiterIndex += 1;
    }

    collectSnapshot(rects);
  }

  @override
  bool shouldRelayout(covariant _OrbitDelegate oldDelegate) {
    return oldDelegate.gap != gap || oldDelegate.radius != radius || oldDelegate.baseAngle != baseAngle;
  }
}

class _WaterfallDelegate extends _BaseDelegate {
  _WaterfallDelegate({required this.stagger, required super.gap, required super.onSnapshot}) : super(modeName: 'waterfall');

  final double stagger;

  @override
  void performLayout(Size size) {
    final Map<String, Rect> rects = <String, Rect>{};
    final List<String> ids = <String>['header', 'rail', 'content', 'footer', 'badge', 'aux'];
    const int lanes = 3;
    final double laneW = (size.width - (gap * (lanes + 1))) / lanes;

    int i = 0;
    for (final String id in ids) {
      if (!hasChild(id)) {
        continue;
      }
      final int lane = i % lanes;
      final double laneX = gap + (lane * (laneW + gap));
      final double yBase = gap + (i * 18) + (lane * stagger * 0.4);
      final Size s = layoutLooseChild(id, BoxConstraints.tightFor(width: laneW, height: 70 + ((i % 3) * 24)));
      final Offset o = Offset(laneX, yBase.clamp(gap, size.height - s.height - gap));
      positionChild(id, o);
      rects[id] = o & s;
      i += 1;
    }

    collectSnapshot(rects);
  }

  @override
  bool shouldRelayout(covariant _WaterfallDelegate oldDelegate) {
    return oldDelegate.gap != gap || oldDelegate.stagger != stagger;
  }
}

class _OverlapDelegate extends _BaseDelegate {
  _OverlapDelegate({required this.overlapFactor, required super.gap, required super.onSnapshot}) : super(modeName: 'overlap');

  final double overlapFactor;

  @override
  void performLayout(Size size) {
    final Map<String, Rect> rects = <String, Rect>{};
    final List<String> ids = <String>['content', 'header', 'rail', 'footer', 'badge', 'aux'];
    final double baseW = size.width * 0.42;
    final double baseH = size.height * 0.30;
    int index = 0;
    for (final String id in ids) {
      if (!hasChild(id)) {
        continue;
      }
      final Size s = layoutLooseChild(id, BoxConstraints.tightFor(width: baseW, height: baseH - ((index % 3) * 10)));
      final double shift = (index * baseW * overlapFactor * 0.32);
      final Offset o = Offset(
        (gap + shift).clamp(gap, size.width - s.width - gap),
        (gap + (index * 24)).clamp(gap, size.height - s.height - gap),
      );
      positionChild(id, o);
      rects[id] = o & s;
      index += 1;
    }

    collectSnapshot(rects);
  }

  @override
  bool shouldRelayout(covariant _OverlapDelegate oldDelegate) {
    return oldDelegate.gap != gap || oldDelegate.overlapFactor != overlapFactor;
  }
}

class _BandDelegate extends _BaseDelegate {
  _BandDelegate({required this.bias, required super.gap, required super.onSnapshot}) : super(modeName: 'bands');

  final double bias;

  @override
  void performLayout(Size size) {
    final Map<String, Rect> rects = <String, Rect>{};
    final double topBand = size.height * bias;
    final double bottomBand = size.height - topBand;

    if (hasChild('header')) {
      final Size s = layoutLooseChild('header', BoxConstraints.tightFor(width: size.width * 0.46, height: topBand - gap));
      const Offset o = Offset(0, 0);
      positionChild('header', o);
      rects['header'] = o & s;
    }
    if (hasChild('content')) {
      final Size s = layoutLooseChild('content', BoxConstraints.tightFor(width: size.width * 0.54, height: topBand - gap));
      final Offset o = Offset(size.width - s.width, 0);
      positionChild('content', o);
      rects['content'] = o & s;
    }
    if (hasChild('rail')) {
      final Size s = layoutLooseChild('rail', BoxConstraints.tightFor(width: size.width * 0.28, height: bottomBand));
      final Offset o = Offset(0, topBand);
      positionChild('rail', o);
      rects['rail'] = o & s;
    }
    if (hasChild('footer')) {
      final Size s = layoutLooseChild('footer', BoxConstraints.tightFor(width: size.width * 0.42, height: bottomBand));
      final Offset o = Offset(size.width * 0.28, topBand);
      positionChild('footer', o);
      rects['footer'] = o & s;
    }
    if (hasChild('aux')) {
      final Size s = layoutLooseChild('aux', BoxConstraints.tightFor(width: size.width * 0.30, height: bottomBand));
      final Offset o = Offset(size.width - s.width, topBand);
      positionChild('aux', o);
      rects['aux'] = o & s;
    }
    if (hasChild('badge')) {
      final Size s = layoutLooseChild('badge', const BoxConstraints.tightFor(width: 90, height: 56));
      final Offset o = Offset(size.width - s.width - gap, gap);
      positionChild('badge', o);
      rects['badge'] = o & s;
    }

    collectSnapshot(rects);
  }

  @override
  bool shouldRelayout(covariant _BandDelegate oldDelegate) {
    return oldDelegate.gap != gap || oldDelegate.bias != bias;
  }
}
