import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'lagoon',
    name: 'Lagoon Depth',
    description: 'Balanced palette for depth and clipping diagnostics.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'sunrise',
    name: 'Sunrise Layer',
    description: 'Warm profile for shadow and elevation transitions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'midnight',
    name: 'Midnight Relief',
    description: 'Dark profile for high-contrast physical surface studies.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(id: _ScenarioMode.cardStack, title: 'Card Stack', subtitle: 'Layered PhysicalModel cards with depth ordering and tint controls.'),
  _Scenario(id: _ScenarioMode.portalClip, title: 'Portal Clip', subtitle: 'Clipped portal surfaces to show clip behavior and child overflow limits.'),
  _Scenario(id: _ScenarioMode.chipCloud, title: 'Chip Cloud', subtitle: 'Small physical surfaces in dense layouts with varying elevations.'),
  _Scenario(id: _ScenarioMode.ramp, title: 'Elevation Ramp', subtitle: 'Animated elevation sweeps with color and shadow transitions.'),
  _Scenario(id: _ScenarioMode.diagnostics, title: 'Diagnostics', subtitle: 'Comparison and render metrics for physical model behavior.'),
];

const List<String> _guideBullets = <String>[
  'PhysicalModel paints a shape with elevation, color, and shadow to model depth.',
  'RenderPhysicalModel handles clipping and shadow rendering for that surface.',
  'Elevation affects shadow softness and perceived layer hierarchy.',
  'Shape + border radius determines shadow contour and clip path geometry.',
  'Clip behavior controls whether children can paint outside model bounds.',
  'Animated elevation is useful for lift interactions and active states.',
  'PhysicalModel differs from simple box decoration because it models z-depth.',
  'Use diagnostics overlays to validate clipping, offsets, and depth tiers.',
  'Shadow color tuning helps align design language across themes and surfaces.',
  'Keep physical layers meaningful: too many depth levels can reduce clarity.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'When should I use PhysicalModel?',
    answer: 'When you need explicit clipping and elevation-based shadow behavior from a shaped surface.',
  ),
  _FaqItem(
    question: 'How is this different from Material?',
    answer: 'Material adds semantic/theming behavior, while PhysicalModel is a focused rendering primitive.',
  ),
  _FaqItem(
    question: 'Why does clipBehavior matter?',
    answer: 'It controls whether child content can extend beyond the model shape and affects visual correctness.',
  ),
  _FaqItem(
    question: 'Can I animate elevation and color together?',
    answer: 'Yes, this is common for hover/press states and motion-driven depth transitions.',
  ),
  _FaqItem(
    question: 'How can I debug layer ordering?',
    answer: 'Capture per-surface depth metrics and visualize stacking in a dedicated board.',
  ),
];

enum _ScenarioMode {
  cardStack,
  portalClip,
  chipCloud,
  ramp,
  diagnostics,
}

enum _ShapeMode {
  rectangle,
  rounded,
  stadium,
  circle,
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

class _Scenario {
  const _Scenario({required this.id, required this.title, required this.subtitle});

  final _ScenarioMode id;
  final String title;
  final String subtitle;
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

class _Snapshot {
  const _Snapshot({
    required this.scenario,
    required this.elevation,
    required this.radius,
    required this.clip,
  });

  final String scenario;
  final double elevation;
  final double radius;
  final String clip;
}

dynamic build(BuildContext context) {
  return const _RenderPhysicalModelStudio();
}

class _RenderPhysicalModelStudio extends StatefulWidget {
  const _RenderPhysicalModelStudio();

  @override
  State<_RenderPhysicalModelStudio> createState() => _RenderPhysicalModelStudioState();
}

class _RenderPhysicalModelStudioState extends State<_RenderPhysicalModelStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8200),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _ShapeMode _shape = _ShapeMode.rounded;
  Clip _clip = Clip.antiAlias;

  double _stageHeight = 560;
  double _baseElevation = 8;
  double _elevationSpread = 14;
  double _radius = 18;
  double _surfaceOpacity = 0.92;
  double _shadowAlpha = 0.44;
  double _gradientShift = 0.28;
  double _chipDensity = 0.52;
  double _portalInset = 22;
  double _stackGap = 30;
  double _tileScale = 1.0;

  bool _animate = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showPortalOverflow = true;
  bool _showChipLabels = true;
  bool _showRampLabels = true;

  int _themeSwitches = 0;
  int _scenarioSwitches = 0;
  int _shapeSwitches = 0;
  int _clipSwitches = 0;
  int _controlEdits = 0;
  int _tapCount = 0;

  String _phase = 'idle';

  _Snapshot _snapshot = const _Snapshot(
    scenario: 'cardStack',
    elevation: 8,
    radius: 18,
    clip: 'antiAlias',
  );
  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderPhysicalModel depth studio initialized.');
    });
  }

  @override
  void dispose() {
    _motion.dispose();
    super.dispose();
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(100).toList(growable: false);
    });
  }

  void _bumpControl(String title, String message) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _pushTimeline(title, message);
  }

  void _toggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'animate':
          _animate = next;
          break;
        case 'guide':
          _showGuide = next;
          break;
        case 'timeline':
          _showTimeline = next;
          break;
        case 'diagnostics':
          _showDiagnostics = next;
          break;
        case 'grid':
          _showGrid = next;
          break;
        case 'overflow':
          _showPortalOverflow = next;
          break;
        case 'chips':
          _showChipLabels = next;
          break;
        case 'ramp':
          _showRampLabels = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animate) {
      _motion.repeat();
    } else {
      _motion.stop();
    }
    _pushTimeline('Toggle', '$key set to $next.');
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _shape = _ShapeMode.rounded;
      _clip = Clip.antiAlias;
      _stageHeight = 560;
      _baseElevation = 8;
      _elevationSpread = 14;
      _radius = 18;
      _surfaceOpacity = 0.92;
      _shadowAlpha = 0.44;
      _gradientShift = 0.28;
      _chipDensity = 0.52;
      _portalInset = 22;
      _stackGap = 30;
      _tileScale = 1.0;
      _animate = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showPortalOverflow = true;
      _showChipLabels = true;
      _showRampLabels = true;
      _phase = 'reset';
      _timeline = const <_TimelineEvent>[];
      _snapshot = const _Snapshot(scenario: 'cardStack', elevation: 8, radius: 18, clip: 'antiAlias');
    });
    _motion.repeat();
    _pushTimeline('Reset', 'Depth studio reset to defaults.');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset theme = _themes[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: theme.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[scheme.surface, scheme.surfaceContainerLow, scheme.surfaceContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeScenarioBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildPhysicalStageBoard(scheme),
                      const SizedBox(height: 14),
                      _buildComparisonBoard(scheme),
                      const SizedBox(height: 14),
                      _buildMetricsBoard(scheme),
                      if (_showGuide) const SizedBox(height: 14),
                      if (_showGuide) _buildGuideBoard(scheme),
                      if (_showTimeline) const SizedBox(height: 14),
                      if (_showTimeline) _buildTimelineBoard(scheme),
                    ],
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
                Icon(Icons.layers_outlined, color: scheme.primary, size: 26),
                Text('RenderPhysicalModel Depth and Shadow Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual exploration of PhysicalModel surfaces, elevation behavior, clipping, and layered depth composition.',
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
              children: List<Widget>.generate(_themes.length, (int i) {
                final _ThemePreset t = _themes[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(t.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitches += 1;
                      _phase = 'theme';
                    });
                    _pushTimeline('Theme', 'Theme switched to ${t.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themes[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int i) {
                final _Scenario lane = _scenarios[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(lane.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _scenarioSwitches += 1;
                      _phase = 'scenario';
                    });
                    _pushTimeline('Scenario', lane.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarios[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Physical Surface Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune elevation, clipping shape, shadow intensity, and scenario visibility.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 420,
              max: 920,
              divisions: 250,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _bumpControl('Stage', 'Set stage height to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Base Elevation',
              value: _baseElevation,
              min: 0,
              max: 28,
              divisions: 140,
              onChanged: (double v) => setState(() => _baseElevation = v),
              onChangeEnd: (double v) => _bumpControl('Elevation', 'Set base elevation to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Elevation Spread',
              value: _elevationSpread,
              min: 0,
              max: 36,
              divisions: 180,
              onChanged: (double v) => setState(() => _elevationSpread = v),
              onChangeEnd: (double v) => _bumpControl('Spread', 'Set elevation spread to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Radius',
              value: _radius,
              min: 0,
              max: 64,
              divisions: 128,
              onChanged: (double v) => setState(() => _radius = v),
              onChangeEnd: (double v) => _bumpControl('Radius', 'Set radius to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Surface Opacity',
              value: _surfaceOpacity,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _surfaceOpacity = v),
              onChangeEnd: (double v) => _bumpControl('Opacity', 'Set surface opacity to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Shadow Alpha',
              value: _shadowAlpha,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _shadowAlpha = v),
              onChangeEnd: (double v) => _bumpControl('Shadow', 'Set shadow alpha to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Gradient Shift',
              value: _gradientShift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _gradientShift = v),
              onChangeEnd: (double v) => _bumpControl('Gradient', 'Set gradient shift to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Chip Density',
              value: _chipDensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _chipDensity = v),
              onChangeEnd: (double v) => _bumpControl('Chip Density', 'Set chip density to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Portal Inset',
              value: _portalInset,
              min: 0,
              max: 80,
              divisions: 80,
              onChanged: (double v) => setState(() => _portalInset = v),
              onChangeEnd: (double v) => _bumpControl('Portal', 'Set portal inset to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stack Gap',
              value: _stackGap,
              min: 0,
              max: 80,
              divisions: 80,
              onChanged: (double v) => setState(() => _stackGap = v),
              onChangeEnd: (double v) => _bumpControl('Stack Gap', 'Set stack gap to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Tile Scale',
              value: _tileScale,
              min: 0.6,
              max: 1.4,
              divisions: 80,
              onChanged: (double v) => setState(() => _tileScale = v),
              onChangeEnd: (double v) => _bumpControl('Tile Scale', 'Set tile scale to ${v.toStringAsFixed(2)}.'),
            ),
            const SizedBox(height: 8),
            Text('Shape Mode', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _ShapeMode.values.map(( _ShapeMode mode) {
                return ChoiceChip(
                  selected: _shape == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _shape = mode;
                      _shapeSwitches += 1;
                      _phase = 'shape';
                    });
                    _pushTimeline('Shape', 'Shape mode switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text('Clip Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Clip.values.map((Clip c) {
                return ChoiceChip(
                  selected: _clip == c,
                  label: Text(c.name),
                  onSelected: (_) {
                    setState(() {
                      _clip = c;
                      _clipSwitches += 1;
                      _phase = 'clip';
                    });
                    _pushTimeline('Clip', 'Clip behavior switched to ${c.name}.');
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate ramp')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Show stage grid')),
                CheckboxMenuButton(value: _showPortalOverflow, onChanged: (bool? v) => _toggle('overflow', v), child: const Text('Show portal overflow child')),
                CheckboxMenuButton(value: _showChipLabels, onChanged: (bool? v) => _toggle('chips', v), child: const Text('Show chip labels')),
                CheckboxMenuButton(value: _showRampLabels, onChanged: (bool? v) => _toggle('ramp', v), child: const Text('Show ramp labels')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Show timeline board')),
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

  Widget _buildPhysicalStageBoard(ColorScheme scheme) {
    final double progress = _animate ? _motion.value : 0;
    _snapshot = _Snapshot(
      scenario: _scenarios[_scenarioIndex].id.name,
      elevation: _baseElevation,
      radius: _radius,
      clip: _clip.name,
    );

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Physical Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Interactive depth stage with scenario-specific PhysicalModel lanes.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _tapCount += 1;
                  _phase = 'stage-tap';
                });
                _pushTimeline('Stage Tap', 'Physical stage tapped.');
              },
              child: SizedBox(
                height: _stageHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (_showGrid)
                          CustomPaint(
                            painter: _DepthGridPainter(progress: progress, shift: _gradientShift),
                          ),
                        _scenarioStage(scheme, progress),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scenarioStage(ColorScheme scheme, double progress) {
    switch (_scenarios[_scenarioIndex].id) {
      case _ScenarioMode.cardStack:
        return _cardStackLane(scheme, progress);
      case _ScenarioMode.portalClip:
        return _portalClipLane(scheme, progress);
      case _ScenarioMode.chipCloud:
        return _chipCloudLane(scheme, progress);
      case _ScenarioMode.ramp:
        return _rampLane(scheme, progress);
      case _ScenarioMode.diagnostics:
        return _diagnosticsLane(scheme, progress);
    }
  }

  Widget _cardStackLane(ColorScheme scheme, double progress) {
    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < 5; i += 1) {
      final double depth = _baseElevation + (_elevationSpread * (i / 4));
      cards.add(
        Positioned(
          left: 60 + (_stackGap * i),
          top: 90 + (_stackGap * i * 0.65),
          child: _physicalTile(
            scheme: scheme,
            width: 300,
            height: 170,
            elevation: depth,
            colorA: Color.lerp(scheme.primary, scheme.secondary, i / 5)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, i / 5)!,
            label: 'Layer ${i + 1}',
            subtitle: 'elevation ${depth.toStringAsFixed(1)}',
            showLabel: true,
          ),
        ),
      );
    }
    return Stack(children: cards);
  }

  Widget _portalClipLane(ColorScheme scheme, double progress) {
    final double wobble = math.sin(progress * math.pi * 2) * 24;
    return Center(
      child: SizedBox(
        width: 520,
        height: 320,
        child: _physicalTile(
          scheme: scheme,
          width: 520,
          height: 320,
          elevation: _baseElevation + _elevationSpread * 0.7,
          colorA: scheme.primary,
          colorB: scheme.secondary,
          label: 'Portal Clip Surface',
          subtitle: 'clip ${_clip.name}',
          showLabel: true,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: _portalInset + wobble,
                top: _portalInset,
                child: _physicalTile(
                  scheme: scheme,
                  width: 180,
                  height: 110,
                  elevation: _baseElevation * 0.6,
                  colorA: scheme.tertiary,
                  colorB: scheme.primary,
                  label: 'Inner',
                  subtitle: 'nested',
                  showLabel: false,
                ),
              ),
              if (_showPortalOverflow)
                Positioned(
                  right: -30,
                  bottom: -24,
                  child: _physicalTile(
                    scheme: scheme,
                    width: 210,
                    height: 120,
                    elevation: _baseElevation + 3,
                    colorA: scheme.secondary,
                    colorB: scheme.tertiary,
                    label: 'Overflow Child',
                    subtitle: 'tests clip',
                    showLabel: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipCloudLane(ColorScheme scheme, double progress) {
    final List<Widget> chips = <Widget>[];
    for (int i = 0; i < 28; i += 1) {
      final double x = 26 + ((i % 7) * 170) + math.sin((progress * math.pi * 2) + (i * 0.4)) * 6;
      final double y = 40 + ((i ~/ 7) * 120) + math.cos((progress * math.pi * 2) + (i * 0.28)) * 8;
      final double elevation = _baseElevation * (0.25 + ((i % 5) / 5)) * (0.6 + (_chipDensity * 0.8));
      chips.add(
        Positioned(
          left: x,
          top: y,
          child: _physicalTile(
            scheme: scheme,
            width: 140 * _tileScale,
            height: 72 * _tileScale,
            elevation: elevation,
            colorA: Color.lerp(scheme.primary, scheme.secondary, (i % 6) / 6)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, ((i + 2) % 8) / 8)!,
            label: 'Chip ${i + 1}',
            subtitle: 'e${elevation.toStringAsFixed(1)}',
            showLabel: _showChipLabels,
          ),
        ),
      );
    }
    return Stack(children: chips);
  }

  Widget _rampLane(ColorScheme scheme, double progress) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        final double t = index / 11;
        final double animated = _animate ? (0.5 + (math.sin((progress * math.pi * 2) + (t * math.pi)) * 0.5)) : 0.5;
        final double elevation = _baseElevation + (_elevationSpread * t * (0.65 + (animated * 0.35)));
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _physicalTile(
            scheme: scheme,
            width: double.infinity,
            height: 72,
            elevation: elevation,
            colorA: Color.lerp(scheme.primary, scheme.secondary, t)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, t)!,
            label: 'Elevation Ramp ${index + 1}',
            subtitle: _showRampLabels ? 'elevation ${elevation.toStringAsFixed(2)}' : 'surface',
            showLabel: true,
          ),
        );
      },
    );
  }

  Widget _diagnosticsLane(ColorScheme scheme, double progress) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('PhysicalModel Diagnostics Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 22)),
          const SizedBox(height: 10),
          Text(
            'This lane compares PhysicalModel, Material, and DecoratedBox for shadow/clipping semantics under the same palette and geometry.',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _physicalTile(
                  scheme: scheme,
                  width: double.infinity,
                  height: 180,
                  elevation: _baseElevation + _elevationSpread * 0.6,
                  colorA: scheme.primary,
                  colorB: scheme.secondary,
                  label: 'PhysicalModel',
                  subtitle: 'render primitive',
                  showLabel: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Material(
                  elevation: _baseElevation + _elevationSpread * 0.6,
                  shadowColor: scheme.shadow.withValues(alpha: _shadowAlpha),
                  borderRadius: BorderRadius.circular(_radius),
                  clipBehavior: _clip,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[scheme.secondary, scheme.tertiary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: const Center(child: Text('Material', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_radius),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: scheme.shadow.withValues(alpha: _shadowAlpha), blurRadius: (_baseElevation + _elevationSpread * 0.6) * 2),
                    ],
                    gradient: LinearGradient(colors: <Color>[scheme.tertiary, scheme.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: const Center(child: Text('DecoratedBox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _diagChip('shape ${_shape.name}', scheme.primary),
              _diagChip('clip ${_clip.name}', scheme.secondary),
              _diagChip('elevation ${_baseElevation.toStringAsFixed(1)} + ${_elevationSpread.toStringAsFixed(1)}', scheme.tertiary),
              _diagChip('opacity ${_surfaceOpacity.toStringAsFixed(2)}', scheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diagChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999), border: Border.all(color: color.withValues(alpha: 0.62))),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _physicalTile({
    required ColorScheme scheme,
    required double width,
    required double height,
    required double elevation,
    required Color colorA,
    required Color colorB,
    required String label,
    required String subtitle,
    required bool showLabel,
    Widget? child,
  }) {
    final BorderRadius radius = BorderRadius.circular(_shape == _ShapeMode.rounded ? _radius : _shape == _ShapeMode.stadium ? 999 : math.max(0, _radius * 0.4));
    final ShapeBorder shape = _shape == _ShapeMode.circle
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: radius);

    return PhysicalModel(
      color: Colors.transparent,
      shadowColor: scheme.shadow.withValues(alpha: _shadowAlpha),
      elevation: elevation,
      clipBehavior: _clip,
      borderRadius: _shape == _ShapeMode.circle ? null : radius,
      shape: _shape == _ShapeMode.circle ? BoxShape.circle : BoxShape.rectangle,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: shape,
          gradient: LinearGradient(colors: <Color>[colorA.withValues(alpha: _surfaceOpacity), colorB.withValues(alpha: _surfaceOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          shadows: <BoxShadow>[
            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 1),
          ],
        ),
        child: child ??
            (showLabel
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        const Spacer(),
                        Text(subtitle, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 12)),
                      ],
                    ),
                  )
                : const SizedBox.expand()),
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
            Text('Compare PhysicalModel usage to related surface patterns.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget physical = _comparisonCard(
                  scheme: scheme,
                  title: 'PhysicalModel',
                  subtitle: 'Dedicated render primitive for physical depth + clipping.',
                  icon: Icons.layers,
                  color: const Color(0xFF0F766E),
                );
                final Widget material = _comparisonCard(
                  scheme: scheme,
                  title: 'Material',
                  subtitle: 'Higher-level component with theme and interaction semantics.',
                  icon: Icons.widgets_outlined,
                  color: const Color(0xFF1D4ED8),
                );
                final Widget decorated = _comparisonCard(
                  scheme: scheme,
                  title: 'DecoratedBox',
                  subtitle: 'Surface styling without explicit physical model behavior.',
                  icon: Icons.crop_square_outlined,
                  color: const Color(0xFFB45309),
                );
                if (narrow) {
                  return Column(children: <Widget>[physical, const SizedBox(height: 10), material, const SizedBox(height: 10), decorated]);
                }
                return Row(children: <Widget>[Expanded(child: physical), const SizedBox(width: 10), Expanded(child: material), const SizedBox(width: 10), Expanded(child: decorated)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required IconData icon, required Color color}) {
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
              height: 96,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.62))),
              child: Center(child: Icon(icon, color: color, size: 34)),
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
                    childAspectRatio: columns == 1 ? 2.75 : 2.08,
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

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active physical surface scenario.', icon: Icons.route_outlined),
      _MetricEntry(label: 'Theme', value: _themes[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Shape', value: _shape.name, note: 'Physical surface geometry.', icon: Icons.rounded_corner_outlined),
      _MetricEntry(label: 'Clip', value: _clip.name, note: 'Child clipping behavior.', icon: Icons.content_cut_outlined),
      _MetricEntry(label: 'Stage Height', value: _stageHeight.toStringAsFixed(0), note: 'Visible stage height.', icon: Icons.height_outlined),
      _MetricEntry(label: 'Elevation', value: '${_baseElevation.toStringAsFixed(1)} + ${_elevationSpread.toStringAsFixed(1)}', note: 'Base and spread across lanes.', icon: Icons.vertical_align_top_outlined),
      _MetricEntry(label: 'Radius', value: _radius.toStringAsFixed(1), note: 'Corner rounding parameter.', icon: Icons.circle_outlined),
      _MetricEntry(label: 'Surface Opacity', value: _surfaceOpacity.toStringAsFixed(2), note: 'Tint alpha for physical surfaces.', icon: Icons.opacity_outlined),
      _MetricEntry(label: 'Shadow Alpha', value: _shadowAlpha.toStringAsFixed(2), note: 'Shadow intensity parameter.', icon: Icons.dark_mode_outlined),
      _MetricEntry(label: 'Gradient Shift', value: _gradientShift.toStringAsFixed(2), note: 'Background shift in grid painter.', icon: Icons.gradient_outlined),
      _MetricEntry(label: 'Chip Density', value: _chipDensity.toStringAsFixed(2), note: 'Density factor for chip cloud.', icon: Icons.bubble_chart_outlined),
      _MetricEntry(label: 'Portal Inset', value: _portalInset.toStringAsFixed(1), note: 'Inset used in portal clip lane.', icon: Icons.crop_free_outlined),
      _MetricEntry(label: 'Stack Gap', value: _stackGap.toStringAsFixed(1), note: 'Offset spacing for stacked cards.', icon: Icons.stacked_bar_chart_outlined),
      _MetricEntry(label: 'Tile Scale', value: _tileScale.toStringAsFixed(2), note: 'Scale factor for chip cards.', icon: Icons.photo_size_select_small_outlined),
      _MetricEntry(label: 'Switches', value: 'theme=$_themeSwitches scenario=$_scenarioSwitches shape=$_shapeSwitches clip=$_clipSwitches', note: 'Major mode switch counts.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Control Edits', value: '$_controlEdits', note: 'Slider/toggle interaction count.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Stage Taps', value: '$_tapCount', note: 'Tap interactions on stage.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Snapshot', value: '${_snapshot.scenario} e=${_snapshot.elevation.toStringAsFixed(1)} r=${_snapshot.radius.toStringAsFixed(1)} ${_snapshot.clip}', note: 'Last depth snapshot.', icon: Icons.camera_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Most recent interaction phase.', icon: Icons.flag_outlined),
    ];
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
            Text('theme=${_themes[_themeIndex].id} scenario=${_scenarios[_scenarioIndex].id.name} shape=${_shape.name} clip=${_clip.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stage=${_stageHeight.toStringAsFixed(0)} elevation=${_baseElevation.toStringAsFixed(1)} spread=${_elevationSpread.toStringAsFixed(1)} radius=${_radius.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('surfaceOpacity=${_surfaceOpacity.toStringAsFixed(2)} shadowAlpha=${_shadowAlpha.toStringAsFixed(2)} gradientShift=${_gradientShift.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('chipDensity=${_chipDensity.toStringAsFixed(2)} portalInset=${_portalInset.toStringAsFixed(1)} stackGap=${_stackGap.toStringAsFixed(1)} tileScale=${_tileScale.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags animate=$_animate grid=$_showGrid overflow=$_showPortalOverflow chips=$_showChipLabels ramp=$_showRampLabels', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches t=$_themeSwitches s=$_scenarioSwitches sh=$_shapeSwitches c=$_clipSwitches edits=$_controlEdits taps=$_tapCount', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological stream of depth and clipping interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                children: _timeline.map(( _TimelineEvent event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text(event.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${event.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _DepthGridPainter extends CustomPainter {
  const _DepthGridPainter({required this.progress, required this.shift});

  final double progress;
  final double shift;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF22C55E), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF3B82F6), (math.cos(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), shift)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint wash = Paint()..color = Colors.black.withValues(alpha: 0.18);
    canvas.drawRect(Offset.zero & size, wash);

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    const double step = 26;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _DepthGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.shift != shift;
  }
}
