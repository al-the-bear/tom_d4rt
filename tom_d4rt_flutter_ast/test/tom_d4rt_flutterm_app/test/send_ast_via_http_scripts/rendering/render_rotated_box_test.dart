import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePack> _themes = <_ThemePack>[
  _ThemePack(
    id: 'studio-blue',
    name: 'Studio Blue',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
    subtitle: 'Clean contrast for quarter-turn comparisons and layout tracking.',
  ),
  _ThemePack(
    id: 'warm-paper',
    name: 'Warm Paper',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
    subtitle: 'Editorial palette for typographic rotation demonstrations.',
  ),
  _ThemePack(
    id: 'night-console',
    name: 'Night Console',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
    subtitle: 'Dark diagnostics profile for dense interaction and timeline boards.',
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    mode: _ScenarioMode.fundamentals,
    title: 'Fundamentals',
    description: 'Core quarter-turn behavior with visual geometry overlays and side-by-side baselines.',
  ),
  _Scenario(
    mode: _ScenarioMode.typography,
    title: 'Typography',
    description: 'Rotated labels and editorial strips showing text orientation usage patterns.',
  ),
  _Scenario(
    mode: _ScenarioMode.dashboard,
    title: 'Dashboard',
    description: 'Data-style tiles where rotated markers and labels support compact layouts.',
  ),
  _Scenario(
    mode: _ScenarioMode.interaction,
    title: 'Interaction',
    description: 'Tap and drag board to test rotated hit surfaces and event signaling.',
  ),
  _Scenario(
    mode: _ScenarioMode.gridLab,
    title: 'Grid Lab',
    description: 'Matrix lab for comparing many quarterTurns combinations at once.',
  ),
  _Scenario(
    mode: _ScenarioMode.verification,
    title: 'Verification',
    description: 'Interpreter checklist and practical usage notes for RenderRotatedBox behavior.',
  ),
];

const List<String> _guide = <String>[
  'RenderRotatedBox rotates its child in quarter-turn increments during layout and paint.',
  'Use quarterTurns values where 1 equals 90°, 2 equals 180°, and 3 equals 270°.',
  'Unlike transform-based arbitrary rotation, RotatedBox affects layout dimensions based on rotation parity.',
  'Quarter-turn rotation is ideal for compact labels, side headers, and directional indicators.',
  'Compare rotated and non-rotated peers to understand size and alignment implications.',
  'In dense dashboards, rotating short labels can improve horizontal space usage.',
  'Use diagnostics to ensure readability is preserved when rotating text-heavy content.',
  'Interactive scenarios help verify gesture behavior on rotated visual regions.',
  'A matrix of quarter-turn values is useful to validate all supported orientations.',
  'Always pair rotation demos with usage guidance, not just static visuals.',
];

class _Faq {
  const _Faq({required this.question, required this.answer});
  final String question;
  final String answer;
}

const List<_Faq> _faqs = <_Faq>[
  _Faq(
    question: 'When should I prefer RotatedBox over Transform.rotate?',
    answer: 'Use RotatedBox for exact quarter-turn rotations that should participate in layout sizing decisions.',
  ),
  _Faq(
    question: 'Does RotatedBox support arbitrary angles?',
    answer: 'No. It is designed for quarter turns only; arbitrary angles belong to transform-based approaches.',
  ),
  _Faq(
    question: 'Why demonstrate quarter turns in a grid?',
    answer: 'A grid quickly verifies all orientation states and reveals layout changes for each value.',
  ),
  _Faq(
    question: 'Can rotated text hurt readability?',
    answer: 'Yes. Keep content short and purpose-driven, especially for vertical labels and compact dashboards.',
  ),
  _Faq(
    question: 'How do I validate behavior in an interpreter environment?',
    answer: 'Use controlled visuals, interaction counters, and timeline logs while toggling quarter-turn settings.',
  ),
];

enum _ScenarioMode {
  fundamentals,
  typography,
  dashboard,
  interaction,
  gridLab,
  verification,
}

class _ThemePack {
  const _ThemePack({
    required this.id,
    required this.name,
    required this.seed,
    required this.brightness,
    required this.subtitle,
  });

  final String id;
  final String name;
  final Color seed;
  final Brightness brightness;
  final String subtitle;
}

class _Scenario {
  const _Scenario({required this.mode, required this.title, required this.description});
  final _ScenarioMode mode;
  final String title;
  final String description;
}

class _Event {
  const _Event({required this.time, required this.channel, required this.message, required this.turn});

  final DateTime time;
  final String channel;
  final String message;
  final int turn;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

dynamic build(BuildContext context) {
  return const _RenderRotatedBoxStudio();
}

class _RenderRotatedBoxStudio extends StatefulWidget {
  const _RenderRotatedBoxStudio();

  @override
  State<_RenderRotatedBoxStudio> createState() => _RenderRotatedBoxStudioState();
}

class _RenderRotatedBoxStudioState extends State<_RenderRotatedBoxStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9000),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  int _mainQuarterTurn = 1;
  int _secondaryQuarterTurn = 3;
  int _matrixBaseTurn = 0;

  bool _animate = true;
  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showLabels = true;
  bool _showHeat = true;
  bool _showBounds = true;
  bool _stressTypography = true;
  bool _compactTiles = false;

  double _stageHeight = 610;
  double _tileRoundness = 18;
  double _tileOpacity = 0.88;
  double _motionSpeed = 1.0;
  double _gridDensity = 30;
  double _overlayAlpha = 0.26;
  double _labelScale = 1.0;
  double _heatIntensity = 0.55;

  int _tick = 0;
  int _interactionCount = 0;
  int _dragCount = 0;
  int _tapCount = 0;
  int _scenarioSwitches = 0;
  int _themeSwitches = 0;
  int _controlEdits = 0;

  String _lastChannel = 'none';
  String _lastMessage = 'none';

  final Map<String, int> _laneHits = <String, int>{};
  final List<Offset> _heatPoints = <Offset>[];
  final List<_Event> _events = <_Event>[];

  @override
  void initState() {
    super.initState();
    _clock.addListener(_onTick);
    _push('system', 'RenderRotatedBox studio initialized', _mainQuarterTurn);
  }

  @override
  void dispose() {
    _clock
      ..removeListener(_onTick)
      ..dispose();
    super.dispose();
  }

  void _onTick() {
    if (!_animate) {
      return;
    }
    setState(() {
      _tick += 1;
    });
    if (_tick % 90 == 0) {
      _push('tick', 'tick=$_tick', _mainQuarterTurn);
    }
  }

  void _push(String channel, String message, int turn) {
    setState(() {
      _lastChannel = channel;
      _lastMessage = message;
      _events.insert(0, _Event(time: DateTime.now(), channel: channel, message: message, turn: turn));
      if (_events.length > 220) {
        _events.removeRange(220, _events.length);
      }
    });
  }

  void _hit(String lane, Offset localPosition) {
    setState(() {
      _interactionCount += 1;
      _laneHits[lane] = (_laneHits[lane] ?? 0) + 1;
      _heatPoints.insert(0, localPosition);
      if (_heatPoints.length > 180) {
        _heatPoints.removeRange(180, _heatPoints.length);
      }
    });
    _push('hit', '$lane @ ${localPosition.dx.toStringAsFixed(1)},${localPosition.dy.toStringAsFixed(1)}', _mainQuarterTurn);
  }

  void _setScenario(int index) {
    setState(() {
      _scenarioIndex = index;
      _scenarioSwitches += 1;
    });
    _push('scenario', _scenarios[index].mode.name, _mainQuarterTurn);
  }

  void _setTheme(int index) {
    setState(() {
      _themeIndex = index;
      _themeSwitches += 1;
    });
    _push('theme', _themes[index].id, _mainQuarterTurn);
  }

  void _setTurn(bool main, int value) {
    setState(() {
      if (main) {
        _mainQuarterTurn = value;
      } else {
        _secondaryQuarterTurn = value;
      }
      _controlEdits += 1;
    });
    _push('turn', '${main ? 'main' : 'secondary'}=$value', value);
  }

  void _controlEdit(String key, String value) {
    setState(() {
      _controlEdits += 1;
    });
    _push('control', '$key=$value', _mainQuarterTurn);
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _mainQuarterTurn = 1;
      _secondaryQuarterTurn = 3;
      _matrixBaseTurn = 0;

      _animate = true;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showLabels = true;
      _showHeat = true;
      _showBounds = true;
      _stressTypography = true;
      _compactTiles = false;

      _stageHeight = 610;
      _tileRoundness = 18;
      _tileOpacity = 0.88;
      _motionSpeed = 1.0;
      _gridDensity = 30;
      _overlayAlpha = 0.26;
      _labelScale = 1.0;
      _heatIntensity = 0.55;

      _tick = 0;
      _interactionCount = 0;
      _dragCount = 0;
      _tapCount = 0;
      _scenarioSwitches = 0;
      _themeSwitches = 0;
      _controlEdits = 0;

      _lastChannel = 'none';
      _lastMessage = 'none';
      _laneHits.clear();
      _heatPoints.clear();
      _events.clear();
    });
    _clock.repeat();
    _push('system', 'state reset', _mainQuarterTurn);
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePack theme = _themes[_themeIndex];
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
                  constraints: const BoxConstraints(maxWidth: 1580),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeScenarioBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildStageBoard(scheme),
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
                Icon(Icons.rotate_90_degrees_ccw_outlined, size: 26, color: scheme.primary),
                Text('RenderRotatedBox Quarter-Turn Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual demo covering quarter-turn layout behavior, compact orientation patterns, and interaction diagnostics.',
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
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themes.length, (int index) {
                return ChoiceChip(
                  selected: _themeIndex == index,
                  label: Text(_themes[index].name),
                  onSelected: (_) => _setTheme(index),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themes[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Modes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                return FilterChip(
                  selected: _scenarioIndex == index,
                  label: Text(_scenarios[index].title),
                  onSelected: (_) => _setScenario(index),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarios[_scenarioIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Control Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune quarter-turn values, stage visuals, and diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 430,
              max: 980,
              divisions: 275,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _controlEdit('stageHeight', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Roundness',
              value: _tileRoundness,
              min: 0,
              max: 48,
              divisions: 96,
              onChanged: (double v) => setState(() => _tileRoundness = v),
              onChangeEnd: (double v) => _controlEdit('tileRoundness', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Opacity',
              value: _tileOpacity,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _tileOpacity = v),
              onChangeEnd: (double v) => _controlEdit('tileOpacity', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Motion Speed',
              value: _motionSpeed,
              min: 0.25,
              max: 2,
              divisions: 70,
              onChanged: (double v) => setState(() => _motionSpeed = v),
              onChangeEnd: (double v) => _controlEdit('motionSpeed', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Grid Density',
              value: _gridDensity,
              min: 14,
              max: 52,
              divisions: 38,
              onChanged: (double v) => setState(() => _gridDensity = v),
              onChangeEnd: (double v) => _controlEdit('gridDensity', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Overlay Alpha',
              value: _overlayAlpha,
              min: 0,
              max: 0.8,
              divisions: 80,
              onChanged: (double v) => setState(() => _overlayAlpha = v),
              onChangeEnd: (double v) => _controlEdit('overlayAlpha', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Label Scale',
              value: _labelScale,
              min: 0.6,
              max: 1.6,
              divisions: 100,
              onChanged: (double v) => setState(() => _labelScale = v),
              onChangeEnd: (double v) => _controlEdit('labelScale', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Heat Intensity',
              value: _heatIntensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _heatIntensity = v),
              onChangeEnd: (double v) => _controlEdit('heatIntensity', v.toStringAsFixed(2)),
            ),
            const SizedBox(height: 4),
            Text('Main Quarter Turns', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(4, (int value) {
                return ChoiceChip(
                  selected: _mainQuarterTurn == value,
                  label: Text('main=$value'),
                  onSelected: (_) => _setTurn(true, value),
                );
              }),
            ),
            const SizedBox(height: 6),
            Text('Secondary Quarter Turns', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(4, (int value) {
                return ChoiceChip(
                  selected: _secondaryQuarterTurn == value,
                  label: Text('secondary=$value'),
                  onSelected: (_) => _setTurn(false, value),
                );
              }),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) {
                  setState(() => _animate = v ?? true);
                  if (_animate) {
                    _clock.repeat();
                  } else {
                    _clock.stop();
                  }
                  _controlEdit('animate', '${v ?? true}');
                }, child: const Text('Animate')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) {
                  setState(() => _showGrid = v ?? true);
                  _controlEdit('showGrid', '${v ?? true}');
                }, child: const Text('Grid')),
                CheckboxMenuButton(value: _showHeat, onChanged: (bool? v) {
                  setState(() => _showHeat = v ?? true);
                  _controlEdit('showHeat', '${v ?? true}');
                }, child: const Text('Heat')),
                CheckboxMenuButton(value: _showLabels, onChanged: (bool? v) {
                  setState(() => _showLabels = v ?? true);
                  _controlEdit('showLabels', '${v ?? true}');
                }, child: const Text('Labels')),
                CheckboxMenuButton(value: _showBounds, onChanged: (bool? v) {
                  setState(() => _showBounds = v ?? true);
                  _controlEdit('showBounds', '${v ?? true}');
                }, child: const Text('Bounds')),
                CheckboxMenuButton(value: _stressTypography, onChanged: (bool? v) {
                  setState(() => _stressTypography = v ?? true);
                  _controlEdit('stressTypography', '${v ?? true}');
                }, child: const Text('Typography stress')),
                CheckboxMenuButton(value: _compactTiles, onChanged: (bool? v) {
                  setState(() => _compactTiles = v ?? false);
                  _controlEdit('compactTiles', '${v ?? false}');
                }, child: const Text('Compact tiles')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) {
                  setState(() => _showDiagnostics = v ?? true);
                  _controlEdit('diagnostics', '${v ?? true}');
                }, child: const Text('Diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) {
                  setState(() => _showGuide = v ?? true);
                  _controlEdit('guide', '${v ?? true}');
                }, child: const Text('Guide')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) {
                  setState(() => _showTimeline = v ?? true);
                  _controlEdit('timeline', '${v ?? true}');
                }, child: const Text('Timeline')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider({
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

  Widget _buildStageBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Scenario Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Interact with rotated samples to observe quarter-turn behavior across multiple use cases.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            SizedBox(
              height: _stageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (_showGrid)
                      CustomPaint(
                        painter: _GridPainter(
                          color: scheme.primary,
                          spacing: _gridDensity,
                          tick: _tick,
                          speed: _motionSpeed,
                        ),
                      ),
                    _buildScenarioScene(scheme),
                    if (_showHeat)
                      IgnorePointer(
                        child: CustomPaint(
                          painter: _HeatPainter(points: _heatPoints, intensity: _heatIntensity),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioScene(ColorScheme scheme) {
    switch (_scenarios[_scenarioIndex].mode) {
      case _ScenarioMode.fundamentals:
        return _fundamentals(scheme);
      case _ScenarioMode.typography:
        return _typography(scheme);
      case _ScenarioMode.dashboard:
        return _dashboard(scheme);
      case _ScenarioMode.interaction:
        return _interactionBoard(scheme);
      case _ScenarioMode.gridLab:
        return _gridLab(scheme);
      case _ScenarioMode.verification:
        return _verification(scheme);
    }
  }

  Widget _fundamentals(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _turnCard(
              scheme: scheme,
              lane: 'fund-main',
              title: 'Main Quarter Turn',
              subtitle: 'RotatedBox(quarterTurns: $_mainQuarterTurn)',
              turn: _mainQuarterTurn,
              colorA: scheme.primary,
              colorB: scheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _turnCard(
              scheme: scheme,
              lane: 'fund-second',
              title: 'Secondary Quarter Turn',
              subtitle: 'RotatedBox(quarterTurns: $_secondaryQuarterTurn)',
              turn: _secondaryQuarterTurn,
              colorA: scheme.tertiary,
              colorB: scheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _baselineCard(scheme),
          ),
        ],
      ),
    );
  }

  Widget _turnCard({
    required ColorScheme scheme,
    required String lane,
    required String title,
    required String subtitle,
    required int turn,
    required Color colorA,
    required Color colorB,
  }) {
    final Widget body = Listener(
      onPointerDown: (PointerDownEvent e) => _hit(lane, e.localPosition),
      onPointerMove: (PointerMoveEvent e) => _hit(lane, e.localPosition),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          border: Border.all(color: Colors.white.withValues(alpha: 0.46)),
          gradient: LinearGradient(colors: <Color>[colorA.withValues(alpha: _tileOpacity), colorB.withValues(alpha: _tileOpacity)]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: RotatedBox(
                    quarterTurns: turn,
                    child: Container(
                      width: _compactTiles ? 110 : 170,
                      height: _compactTiles ? 76 : 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black.withValues(alpha: 0.24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.56)),
                      ),
                      child: Center(
                        child: Text(
                          'turn=$turn',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17 * _labelScale),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showLabels)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: _overlayAlpha), borderRadius: BorderRadius.circular(999)),
                  child: Text('hits=${_laneHits[lane] ?? 0}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                ),
            ],
          ),
        ),
      ),
    );
    return body;
  }

  Widget _baselineCard(ColorScheme scheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_tileRoundness),
        border: Border.all(color: Colors.white.withValues(alpha: 0.46)),
        gradient: LinearGradient(colors: <Color>[scheme.secondary.withValues(alpha: _tileOpacity), scheme.tertiary.withValues(alpha: _tileOpacity)]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Baseline (No Rotation)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 4),
            const Text('Reference panel for direct visual comparison', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Container(
                  width: _compactTiles ? 110 : 170,
                  height: _compactTiles ? 76 : 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black.withValues(alpha: 0.22),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.56)),
                  ),
                  child: Center(
                    child: Text('turn=0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17 * _labelScale)),
                  ),
                ),
              ),
            ),
            if (_showBounds)
              const Text('Observe dimension changes between parity turns.', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _typography(ColorScheme scheme) {
    final List<String> words = <String>['ALPHA', 'BETA', 'GAMMA', 'DELTA', 'OMEGA', 'SIGMA', 'LAMBDA'];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_tileRoundness),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _tileOpacity), scheme.secondary.withValues(alpha: _tileOpacity)]),
              ),
              child: Column(
                children: List<Widget>.generate(words.length, (int index) {
                  final int turn = (_mainQuarterTurn + index) % 4;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withValues(alpha: 0.18 + (_stressTypography ? index * 0.02 : 0)),
                      ),
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: turn,
                          child: Text(
                            words[index],
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.1, fontSize: (15 + (index % 2) * 2) * _labelScale),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_tileRoundness),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                gradient: LinearGradient(colors: <Color>[scheme.tertiary.withValues(alpha: _tileOpacity), scheme.primary.withValues(alpha: _tileOpacity)]),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Editorial Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Vertical side labels are common with quarter-turn layout rotation.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: _secondaryQuarterTurn,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.26), borderRadius: BorderRadius.circular(10)),
                            child: Text('SECTION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13 * _labelScale)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withValues(alpha: 0.20),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'RotatedBox helps place short vertical labels while preserving deterministic quarter-turn layout behavior.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_showLabels)
                    Text('main=$_mainQuarterTurn secondary=$_secondaryQuarterTurn stress=$_stressTypography', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboard(ColorScheme scheme) {
    Widget tile(String lane, String title, int turn, Color a, Color b) {
      return Listener(
        onPointerDown: (PointerDownEvent e) => _hit(lane, e.localPosition),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_tileRoundness),
            gradient: LinearGradient(colors: <Color>[a.withValues(alpha: _tileOpacity), b.withValues(alpha: _tileOpacity)]),
            border: Border.all(color: Colors.white.withValues(alpha: 0.46)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                    RotatedBox(
                      quarterTurns: turn,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(999)),
                        child: Text('Q$turn', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _clock,
                    builder: (BuildContext context, Widget? child) {
                      final double t = _clock.value * _motionSpeed;
                      return CustomPaint(
                        painter: _SparkPainter(progress: t, turn: turn, alpha: _overlayAlpha),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text('hits=${_laneHits[lane] ?? 0}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: _compactTiles ? 3 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: _compactTiles ? 1.2 : 1.55,
        children: <Widget>[
          tile('dash-1', 'Flow Rate', _mainQuarterTurn, scheme.primary, scheme.secondary),
          tile('dash-2', 'Latency', _secondaryQuarterTurn, scheme.secondary, scheme.tertiary),
          tile('dash-3', 'Capacity', (_mainQuarterTurn + 1) % 4, scheme.tertiary, scheme.primary),
          tile('dash-4', 'Utilization', (_secondaryQuarterTurn + 2) % 4, scheme.primary, scheme.tertiary),
          if (_compactTiles) tile('dash-5', 'Queue', (_mainQuarterTurn + 3) % 4, scheme.secondary, scheme.primary),
          if (_compactTiles) tile('dash-6', 'Signals', (_secondaryQuarterTurn + 1) % 4, scheme.tertiary, scheme.secondary),
        ],
      ),
    );
  }

  Widget _interactionBoard(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                _tapCount += 1;
                _hit('interaction-main', details.localPosition);
              },
              onPanUpdate: (DragUpdateDetails details) {
                _dragCount += 1;
                _hit('interaction-main', details.localPosition);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_tileRoundness),
                  gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _tileOpacity), scheme.secondary.withValues(alpha: _tileOpacity)]),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                ),
                child: Stack(
                  children: <Widget>[
                    if (_showBounds)
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                            ),
                          ),
                        ),
                      ),
                    Center(
                      child: RotatedBox(
                        quarterTurns: _mainQuarterTurn,
                        child: Container(
                          width: _compactTiles ? 120 : 210,
                          height: _compactTiles ? 84 : 145,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
                          ),
                          child: Center(
                            child: Text('DRAG / TAP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20 * _labelScale)),
                          ),
                        ),
                      ),
                    ),
                    if (_showLabels)
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: _overlayAlpha), borderRadius: BorderRadius.circular(999)),
                          child: Text('tap=$_tapCount drag=$_dragCount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_tileRoundness),
                gradient: LinearGradient(colors: <Color>[scheme.tertiary.withValues(alpha: _tileOpacity), scheme.primary.withValues(alpha: _tileOpacity)]),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Interaction Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('RotatedBox affects orientation but still allows straightforward gesture handling on wrapped content.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  _miniStat('interactions', _interactionCount.toString()),
                  _miniStat('hits main', (_laneHits['interaction-main'] ?? 0).toString()),
                  _miniStat('current turn', _mainQuarterTurn.toString()),
                  _miniStat('last channel', _lastChannel),
                  const Spacer(),
                  const Text('Tip: short rotated labels remain clearer than long paragraphs.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _gridLab(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('Matrix Base Turn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(width: 10),
              Wrap(
                spacing: 8,
                children: List<Widget>.generate(4, (int v) {
                  return ChoiceChip(
                    selected: _matrixBaseTurn == v,
                    label: Text('base=$v'),
                    onSelected: (_) {
                      setState(() => _matrixBaseTurn = v);
                      _controlEdit('matrixBaseTurn', '$v');
                    },
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: 24,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _compactTiles ? 6 : 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: _compactTiles ? 1.08 : 1.22,
              ),
              itemBuilder: (BuildContext context, int index) {
                final int turn = (_matrixBaseTurn + index) % 4;
                return Listener(
                  onPointerDown: (PointerDownEvent e) => _hit('grid-$index', e.localPosition),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_tileRoundness * 0.6),
                      gradient: LinearGradient(
                        colors: <Color>[
                          scheme.primary.withValues(alpha: 0.18 + (turn * 0.12)),
                          scheme.secondary.withValues(alpha: 0.18 + ((3 - turn) * 0.12)),
                        ],
                      ),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.44)),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        Text('cell $index', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: turn,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(8)),
                            child: Text('turn=$turn', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                        ),
                        const Spacer(),
                        Text('hits=${_laneHits['grid-$index'] ?? 0}', style: const TextStyle(color: Colors.white70, fontSize: 10)),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _verification(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          gradient: LinearGradient(colors: <Color>[scheme.secondary.withValues(alpha: _tileOpacity), scheme.tertiary.withValues(alpha: _tileOpacity)]),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Interpreter Verification Checklist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 10),
            const Text('1. Switch main and secondary quarterTurns and verify visual orientation updates.', style: TextStyle(color: Colors.white70)),
            const Text('2. Compare Fundamentals cards against baseline no-rotation panel.', style: TextStyle(color: Colors.white70)),
            const Text('3. Inspect Typography and Dashboard modes for practical compact-label usage.', style: TextStyle(color: Colors.white70)),
            const Text('4. Interact with boards and confirm hit counters/timeline events update.', style: TextStyle(color: Colors.white70)),
            const Text('5. Validate matrix coverage for all quarter-turn values in Grid Lab.', style: TextStyle(color: Colors.white70)),
            const Text('6. Confirm analyzer is clean for this file.', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _chip('scenario=${_scenarios[_scenarioIndex].mode.name}'),
                _chip('main=$_mainQuarterTurn'),
                _chip('secondary=$_secondaryQuarterTurn'),
                _chip('matrixBase=$_matrixBaseTurn'),
                _chip('interactions=$_interactionCount'),
                _chip('events=${_events.length}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.black.withValues(alpha: _overlayAlpha),
        border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildComparisonBoard(ColorScheme scheme) {
    Widget card(String title, String note, Color accent, int turn) {
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
              const SizedBox(height: 6),
              Text(note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: accent.withValues(alpha: 0.14),
                    border: Border.all(color: accent.withValues(alpha: 0.72)),
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: turn,
                      child: Text('turn=$turn', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Usage Comparison', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Common quarter-turn use patterns and reference examples.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1020;
                final Widget a = card('Vertical Label', 'Ideal for short side markers and compact section tags.', const Color(0xFF0284C7), 1);
                final Widget b = card('Upside Marker', 'Useful when opposite orientation is clearer in a mirrored context.', const Color(0xFFB45309), 2);
                final Widget c = card('Trailing Side', 'Quarter turn 3 often matches right-edge annotations.', const Color(0xFF7C3AED), 3);
                if (narrow) {
                  return Column(children: <Widget>[SizedBox(height: 220, child: a), const SizedBox(height: 10), SizedBox(height: 220, child: b), const SizedBox(height: 10), SizedBox(height: 220, child: c)]);
                }
                return SizedBox(height: 230, child: Row(children: <Widget>[Expanded(child: a), const SizedBox(width: 10), Expanded(child: b), const SizedBox(width: 10), Expanded(child: c)]));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_Metric> metrics = <_Metric>[
      _Metric(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active stage mode.', icon: Icons.route_outlined),
      _Metric(label: 'Theme', value: _themes[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _Metric(label: 'Main Turn', value: '$_mainQuarterTurn', note: 'Primary RotatedBox turn.', icon: Icons.rotate_90_degrees_ccw_outlined),
      _Metric(label: 'Secondary Turn', value: '$_secondaryQuarterTurn', note: 'Secondary RotatedBox turn.', icon: Icons.rotate_90_degrees_cw_outlined),
      _Metric(label: 'Matrix Base', value: '$_matrixBaseTurn', note: 'Grid lab base turn offset.', icon: Icons.grid_on_outlined),
      _Metric(label: 'Tick', value: '$_tick', note: 'Animation tick count.', icon: Icons.timelapse_outlined),
      _Metric(label: 'Interactions', value: '$_interactionCount', note: 'Total stage interaction events.', icon: Icons.touch_app_outlined),
      _Metric(label: 'Tap Count', value: '$_tapCount', note: 'Tap gestures captured.', icon: Icons.ads_click_outlined),
      _Metric(label: 'Drag Count', value: '$_dragCount', note: 'Drag updates captured.', icon: Icons.swipe_outlined),
      _Metric(label: 'Scenario Switches', value: '$_scenarioSwitches', note: 'Scenario changes made.', icon: Icons.swap_horiz_outlined),
      _Metric(label: 'Theme Switches', value: '$_themeSwitches', note: 'Theme changes made.', icon: Icons.style_outlined),
      _Metric(label: 'Control Edits', value: '$_controlEdits', note: 'Controls adjusted.', icon: Icons.tune_outlined),
      _Metric(label: 'Stage Height', value: _stageHeight.toStringAsFixed(1), note: 'Current stage size.', icon: Icons.height_outlined),
      _Metric(label: 'Tile Style', value: 'r=${_tileRoundness.toStringAsFixed(1)} o=${_tileOpacity.toStringAsFixed(2)}', note: 'Tile appearance.', icon: Icons.widgets_outlined),
      _Metric(label: 'Motion', value: _motionSpeed.toStringAsFixed(2), note: 'Animation speed multiplier.', icon: Icons.speed_outlined),
      _Metric(label: 'Label Scale', value: _labelScale.toStringAsFixed(2), note: 'Text scaling for labels.', icon: Icons.text_fields_outlined),
      _Metric(label: 'Heat Samples', value: '${_heatPoints.length}', note: 'Heat overlay points stored.', icon: Icons.blur_on_outlined),
      _Metric(label: 'Lane Hits', value: '${_laneHits.length}', note: 'Distinct lanes receiving interactions.', icon: Icons.assessment_outlined),
      _Metric(label: 'Last Channel', value: _lastChannel, note: _lastMessage, icon: Icons.info_outline),
      _Metric(label: 'Timeline Entries', value: '${_events.length}', note: 'Captured timeline events.', icon: Icons.timeline_outlined),
    ];

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
                    childAspectRatio: columns == 1 ? 2.65 : 2.03,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _Metric m = metrics[index];
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
            if (_showDiagnostics)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text(
                  'snapshot scenario=${_scenarios[_scenarioIndex].mode.name} theme=${_themes[_themeIndex].id} '
                  'main=$_mainQuarterTurn secondary=$_secondaryQuarterTurn matrix=$_matrixBaseTurn tick=$_tick '
                  'hits=$_interactionCount taps=$_tapCount drags=$_dragCount events=${_events.length} '
                  'flags grid=$_showGrid heat=$_showHeat labels=$_showLabels bounds=$_showBounds compact=$_compactTiles',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
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
            ..._guide.map((String line) {
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
            ..._faqs.map(( _Faq faq) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(faq.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(faq.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
                  ],
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
                TextButton.icon(
                  onPressed: () {
                    setState(() => _events.clear());
                    _push('system', 'timeline cleared', _mainQuarterTurn);
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_events.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with the stage to generate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _events.take(46).map(( _Event event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(event.channel.isEmpty ? '?' : event.channel.substring(0, 1).toUpperCase(), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text('${event.channel} | turn ${event.turn}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
                      subtitle: Text('$stamp  ${event.message}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color, required this.spacing, required this.tick, required this.speed});

  final Color color;
  final double spacing;
  final int tick;
  final double speed;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = tick / 200.0 * speed;
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.28 + 0.08 * math.sin(t)),
          color.withValues(alpha: 0.12 + 0.07 * math.cos(t * 0.7)),
          color.withValues(alpha: 0.22 + 0.09 * math.sin(t * 1.1)),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withValues(alpha: 0.22));

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing || oldDelegate.tick != tick || oldDelegate.speed != speed;
  }
}

class _HeatPainter extends CustomPainter {
  const _HeatPainter({required this.points, required this.intensity});

  final List<Offset> points;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i += 1) {
      final double alpha = (1 - (i / math.max(points.length, 1))) * intensity;
      final Offset p = points[i];
      final Rect rect = Rect.fromCircle(center: p, radius: 30);
      final Paint paint = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFDE047).withValues(alpha: alpha),
            const Color(0xFFF97316).withValues(alpha: alpha * 0.34),
            const Color(0xFFF97316).withValues(alpha: 0),
          ],
        ).createShader(rect);
      canvas.drawCircle(p, 30, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeatPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.intensity != intensity;
  }
}

class _SparkPainter extends CustomPainter {
  const _SparkPainter({required this.progress, required this.turn, required this.alpha});

  final double progress;
  final int turn;
  final double alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = Colors.black.withValues(alpha: 0.18 + alpha * 0.3);
    canvas.drawRect(Offset.zero & size, bg);

    final Path p = Path();
    p.moveTo(0, size.height * 0.62);
    for (double x = 0; x <= size.width; x += 8) {
      final double t = x / size.width;
      final double y = size.height * (0.58 + 0.22 * math.sin((t + progress + turn * 0.1) * math.pi * 2));
      p.lineTo(x, y);
    }
    final Paint line = Paint()
      ..color = Colors.white.withValues(alpha: 0.74)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(p, line);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.turn != turn || oldDelegate.alpha != alpha;
  }
}
