import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemePalette> _themePalettes = <_ThemePalette>[
  _ThemePalette(
    id: 'ocean-lab',
    name: 'Ocean Lab',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
    subtitle: 'High-contrast repaint overlays for comparing isolated and non-isolated regions.',
  ),
  _ThemePalette(
    id: 'citrus-grid',
    name: 'Citrus Grid',
    seed: Color(0xFFEA580C),
    brightness: Brightness.light,
    subtitle: 'Warm palette optimized for animation stress scenes and snapshot demos.',
  ),
  _ThemePalette(
    id: 'midnight-ops',
    name: 'Midnight Ops',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
    subtitle: 'Dark console style for dense timeline and metrics diagnostics.',
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    mode: _ScenarioMode.isolationArena,
    title: 'Isolation Arena',
    description: 'Side-by-side animated lanes comparing wrapped vs unwrapped repaint regions.',
  ),
  _Scenario(
    mode: _ScenarioMode.captureStudio,
    title: 'Capture Studio',
    description: 'Interactive RepaintBoundary image capture workflow with render metadata.',
  ),
  _Scenario(
    mode: _ScenarioMode.scrollBoard,
    title: 'Scroll Board',
    description: 'Scrollable content where selected cards are isolated by explicit boundaries.',
  ),
  _Scenario(
    mode: _ScenarioMode.dashboardPulse,
    title: 'Dashboard Pulse',
    description: 'Dashboard widgets with repaint pressure controls and selective isolation.',
  ),
  _Scenario(
    mode: _ScenarioMode.heatGrid,
    title: 'Heat Grid',
    description: 'Grid-based repaint intensity visualization with boundary lane toggles.',
  ),
  _Scenario(
    mode: _ScenarioMode.verification,
    title: 'Verification',
    description: 'Checklist board, expected outcomes, and debugging timeline for interpreter runs.',
  ),
];

const List<String> _guideLines = <String>[
  'RenderRepaintBoundary isolates a subtree into its own layer to reduce unnecessary repaints in siblings and ancestors.',
  'Use boundaries around expensive, frequently changing visuals to avoid repainting large static regions.',
  'Overusing repaint boundaries can increase memory/layer overhead, so isolate where pressure is proven.',
  'Capture workflows rely on RepaintBoundary and toImage to export visual regions for diagnostics or previews.',
  'Animation stress tests help identify whether isolation meaningfully reduces redraw pressure.',
  'Scrollable dashboards benefit from selective boundaries on high-frequency tiles instead of all tiles.',
  'Pair visual demonstrations with counters and timelines so behavior can be validated during interpreter runs.',
  'When comparing scenarios, keep one lane unwrapped to provide a baseline for relative repaint activity.',
  'Use toggles to inspect how boundary placement changes responsiveness and perceived smoothness.',
  'In production, profile before and after introducing boundaries to validate net improvements.',
];

class _Faq {
  const _Faq({required this.question, required this.answer});
  final String question;
  final String answer;
}

const List<_Faq> _faqs = <_Faq>[
  _Faq(
    question: 'When should I add a RepaintBoundary?',
    answer: 'Add it around subtrees that repaint often while nearby content is mostly static and expensive to repaint.',
  ),
  _Faq(
    question: 'Can I wrap everything in boundaries?',
    answer: 'You can, but doing so may hurt memory and compositing; selective use is usually better.',
  ),
  _Faq(
    question: 'How do I verify boundary impact?',
    answer: 'Create controlled visual stress scenarios and compare repaint counters/timelines with and without isolation.',
  ),
  _Faq(
    question: 'What is toImage used for?',
    answer: 'It captures a boundary subtree as an image, useful for previews, exports, and diagnostics snapshots.',
  ),
  _Faq(
    question: 'Is this only about performance?',
    answer: 'Mostly performance and diagnostics, but capture-based workflows are also practical product features.',
  ),
];

enum _ScenarioMode {
  isolationArena,
  captureStudio,
  scrollBoard,
  dashboardPulse,
  heatGrid,
  verification,
}

class _ThemePalette {
  const _ThemePalette({
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

class _TimelineEvent {
  const _TimelineEvent({
    required this.time,
    required this.channel,
    required this.message,
    required this.tick,
  });

  final DateTime time;
  final String channel;
  final String message;
  final int tick;
}

class _MetricCard {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

dynamic build(BuildContext context) {
  return const _RenderRepaintBoundaryObservatory();
}

class _RenderRepaintBoundaryObservatory extends StatefulWidget {
  const _RenderRepaintBoundaryObservatory();

  @override
  State<_RenderRepaintBoundaryObservatory> createState() => _RenderRepaintBoundaryObservatoryState();
}

class _RenderRepaintBoundaryObservatoryState extends State<_RenderRepaintBoundaryObservatory> with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9200),
  )..repeat();

  final GlobalKey _captureKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  bool _animate = true;
  bool _showGrid = true;
  bool _showDiagnostics = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showHeat = true;
  bool _wrapStaticPanel = true;
  bool _wrapDynamicPanel = true;
  bool _wrapScrollCards = true;
  bool _wrapDashboardCharts = true;
  bool _enableStress = true;

  double _stageHeight = 620;
  double _isolationStrength = 0.62;
  double _animationSpeed = 1.0;
  double _tileRoundness = 18;
  double _tileOpacity = 0.88;
  double _noise = 0.35;
  double _heatIntensity = 0.58;
  double _captureScale = 1.0;
  double _gridDensity = 28;

  int _frameTick = 0;
  int _paintTick = 0;
  int _scrollTick = 0;
  int _interactionTick = 0;
  int _scenarioSwitches = 0;
  int _themeSwitches = 0;
  int _controlEdits = 0;
  int _captureAttempts = 0;
  int _captureSuccess = 0;
  int _captureFailure = 0;

  String _lastChannel = 'none';
  String _lastMessage = 'none';
  String _captureInfo = 'No capture yet';

  int _capturedWidth = 0;
  int _capturedHeight = 0;
  int _capturedBytes = 0;

  final Map<String, int> _laneHits = <String, int>{};
  final List<Offset> _heatPoints = <Offset>[];
  final List<_TimelineEvent> _timeline = <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    _clock.addListener(_onTick);
    _scrollController.addListener(_onScroll);
    _pushEvent('system', 'Repaint observatory initialized');
  }

  @override
  void dispose() {
    _clock
      ..removeListener(_onTick)
      ..dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onTick() {
    if (!_animate) {
      return;
    }
    setState(() {
      _frameTick += 1;
      if (_enableStress) {
        _paintTick += 2;
      } else {
        _paintTick += 1;
      }
    });
    if (_frameTick % 90 == 0) {
      _pushEvent('tick', 'frame=$_frameTick paint=$_paintTick');
    }
  }

  void _onScroll() {
    setState(() {
      _scrollTick += 1;
    });
    if (_scrollTick % 6 == 0) {
      _pushEvent('scroll', 'offset=${_scrollController.offset.toStringAsFixed(1)}');
    }
  }

  void _pushEvent(String channel, String message) {
    setState(() {
      _lastChannel = channel;
      _lastMessage = message;
      _timeline.insert(
        0,
        _TimelineEvent(time: DateTime.now(), channel: channel, message: message, tick: _frameTick),
      );
      if (_timeline.length > 220) {
        _timeline.removeRange(220, _timeline.length);
      }
    });
  }

  void _hit(String lane, Offset localPosition) {
    setState(() {
      _interactionTick += 1;
      _laneHits[lane] = (_laneHits[lane] ?? 0) + 1;
      _heatPoints.insert(0, localPosition);
      if (_heatPoints.length > 180) {
        _heatPoints.removeRange(180, _heatPoints.length);
      }
    });
    _pushEvent('interaction', '$lane hit @ ${localPosition.dx.toStringAsFixed(1)},${localPosition.dy.toStringAsFixed(1)}');
  }

  Future<void> _captureBoundary() async {
    _captureAttempts += 1;
    _pushEvent('capture', 'capture requested');
    try {
      final BuildContext? context = _captureKey.currentContext;
      if (context == null) {
        setState(() {
          _captureFailure += 1;
          _captureInfo = 'Capture failed: context unavailable';
        });
        _pushEvent('capture', 'failure: no context');
        return;
      }
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) {
        setState(() {
          _captureFailure += 1;
          _captureInfo = 'Capture failed: target is not a RenderRepaintBoundary';
        });
        _pushEvent('capture', 'failure: non-boundary target');
        return;
      }

      final ui.Image image = await renderObject.toImage(pixelRatio: _captureScale.clamp(0.5, 4.0));
      final ByteData? data = await image.toByteData(format: ui.ImageByteFormat.png);
      final int bytes = data?.lengthInBytes ?? 0;

      setState(() {
        _captureSuccess += 1;
        _capturedWidth = image.width;
        _capturedHeight = image.height;
        _capturedBytes = bytes;
        _captureInfo = 'Captured ${image.width}x${image.height}, bytes=$bytes';
      });
      _pushEvent('capture', 'success ${image.width}x${image.height}, bytes=$bytes');
      image.dispose();
    } catch (error) {
      setState(() {
        _captureFailure += 1;
        _captureInfo = 'Capture error: $error';
      });
      _pushEvent('capture', 'failure: $error');
    }
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;

      _animate = true;
      _showGrid = true;
      _showDiagnostics = true;
      _showGuide = true;
      _showTimeline = true;
      _showHeat = true;
      _wrapStaticPanel = true;
      _wrapDynamicPanel = true;
      _wrapScrollCards = true;
      _wrapDashboardCharts = true;
      _enableStress = true;

      _stageHeight = 620;
      _isolationStrength = 0.62;
      _animationSpeed = 1.0;
      _tileRoundness = 18;
      _tileOpacity = 0.88;
      _noise = 0.35;
      _heatIntensity = 0.58;
      _captureScale = 1.0;
      _gridDensity = 28;

      _frameTick = 0;
      _paintTick = 0;
      _scrollTick = 0;
      _interactionTick = 0;
      _scenarioSwitches = 0;
      _themeSwitches = 0;
      _controlEdits = 0;
      _captureAttempts = 0;
      _captureSuccess = 0;
      _captureFailure = 0;

      _lastChannel = 'none';
      _lastMessage = 'none';
      _captureInfo = 'No capture yet';
      _capturedWidth = 0;
      _capturedHeight = 0;
      _capturedBytes = 0;

      _laneHits.clear();
      _heatPoints.clear();
      _timeline.clear();
    });
    _clock.repeat();
    _pushEvent('system', 'state reset');
  }

  void _setScenario(int index) {
    setState(() {
      _scenarioIndex = index;
      _scenarioSwitches += 1;
    });
    _pushEvent('scenario', 'mode=${_scenarios[index].mode.name}');
  }

  void _setTheme(int index) {
    setState(() {
      _themeIndex = index;
      _themeSwitches += 1;
    });
    _pushEvent('theme', _themePalettes[index].id);
  }

  void _controlEdit(String key, String value) {
    setState(() {
      _controlEdits += 1;
    });
    _pushEvent('control', '$key=$value');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePalette palette = _themePalettes[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: palette.seed,
      brightness: palette.brightness,
    );

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: palette.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[scheme.surface, scheme.surfaceContainerLow, scheme.surfaceContainer],
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
                      _buildConceptBoard(scheme),
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
                Icon(Icons.auto_graph_outlined, size: 26, color: scheme.primary),
                Text(
                  'RenderRepaintBoundary Performance Observatory',
                  style: TextStyle(color: scheme.onSurface, fontSize: 25, fontWeight: FontWeight.w800),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual demo for repaint isolation, subtree capture, and practical boundary placement strategy in Flutter render trees.',
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
              children: List<Widget>.generate(_themePalettes.length, (int index) {
                final _ThemePalette theme = _themePalettes[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(theme.name),
                  onSelected: (_) => _setTheme(index),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePalettes[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Modes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                final _Scenario scenario = _scenarios[index];
                return FilterChip(
                  selected: index == _scenarioIndex,
                  label: Text(scenario.title),
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
            Text('Tune repaint pressure, boundary wrapping, and visual diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 420,
              max: 980,
              divisions: 280,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _controlEdit('stageHeight', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Isolation Strength',
              value: _isolationStrength,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _isolationStrength = v),
              onChangeEnd: (double v) => _controlEdit('isolationStrength', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Animation Speed',
              value: _animationSpeed,
              min: 0.25,
              max: 2.0,
              divisions: 70,
              onChanged: (double v) => setState(() => _animationSpeed = v),
              onChangeEnd: (double v) => _controlEdit('animationSpeed', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Roundness',
              value: _tileRoundness,
              min: 0,
              max: 42,
              divisions: 84,
              onChanged: (double v) => setState(() => _tileRoundness = v),
              onChangeEnd: (double v) => _controlEdit('tileRoundness', v.toStringAsFixed(1)),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Opacity',
              value: _tileOpacity,
              min: 0.2,
              max: 1.0,
              divisions: 80,
              onChanged: (double v) => setState(() => _tileOpacity = v),
              onChangeEnd: (double v) => _controlEdit('tileOpacity', v.toStringAsFixed(2)),
            ),
            _slider(
              scheme: scheme,
              label: 'Noise',
              value: _noise,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _noise = v),
              onChangeEnd: (double v) => _controlEdit('noise', v.toStringAsFixed(2)),
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
            _slider(
              scheme: scheme,
              label: 'Capture Scale',
              value: _captureScale,
              min: 0.5,
              max: 3,
              divisions: 50,
              onChanged: (double v) => setState(() => _captureScale = v),
              onChangeEnd: (double v) => _controlEdit('captureScale', v.toStringAsFixed(2)),
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
                }, child: const Text('Heat Map')),
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
                CheckboxMenuButton(value: _wrapStaticPanel, onChanged: (bool? v) {
                  setState(() => _wrapStaticPanel = v ?? true);
                  _controlEdit('wrapStaticPanel', '${v ?? true}');
                }, child: const Text('Wrap static lane')),
                CheckboxMenuButton(value: _wrapDynamicPanel, onChanged: (bool? v) {
                  setState(() => _wrapDynamicPanel = v ?? true);
                  _controlEdit('wrapDynamicPanel', '${v ?? true}');
                }, child: const Text('Wrap dynamic lane')),
                CheckboxMenuButton(value: _wrapScrollCards, onChanged: (bool? v) {
                  setState(() => _wrapScrollCards = v ?? true);
                  _controlEdit('wrapScrollCards', '${v ?? true}');
                }, child: const Text('Wrap scroll cards')),
                CheckboxMenuButton(value: _wrapDashboardCharts, onChanged: (bool? v) {
                  setState(() => _wrapDashboardCharts = v ?? true);
                  _controlEdit('wrapDashboardCharts', '${v ?? true}');
                }, child: const Text('Wrap charts')),
                CheckboxMenuButton(value: _enableStress, onChanged: (bool? v) {
                  setState(() => _enableStress = v ?? true);
                  _controlEdit('enableStress', '${v ?? true}');
                }, child: const Text('Stress mode')),
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
            Text('Interact with each mode to observe repaint-boundary behavior in realistic UI compositions.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                          tick: _frameTick,
                          speed: _animationSpeed,
                          noise: _noise,
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
      case _ScenarioMode.isolationArena:
        return _buildIsolationArena(scheme);
      case _ScenarioMode.captureStudio:
        return _buildCaptureStudio(scheme);
      case _ScenarioMode.scrollBoard:
        return _buildScrollBoard(scheme);
      case _ScenarioMode.dashboardPulse:
        return _buildDashboardPulse(scheme);
      case _ScenarioMode.heatGrid:
        return _buildHeatGrid(scheme);
      case _ScenarioMode.verification:
        return _buildVerificationBoard(scheme);
    }
  }

  Widget _buildIsolationArena(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _lane(
              scheme: scheme,
              laneId: 'baseline-lane',
              title: 'Baseline (No Explicit Boundary)',
              subtitle: 'Animated visuals without dedicated subtree capture boundary.',
              colorA: scheme.secondary,
              colorB: scheme.tertiary,
              withBoundary: false,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _lane(
              scheme: scheme,
              laneId: 'isolated-lane',
              title: 'Isolated (RepaintBoundary)',
              subtitle: 'Animated subtree wrapped for repaint isolation and selective capture.',
              colorA: scheme.primary,
              colorB: scheme.secondary,
              withBoundary: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lane({
    required ColorScheme scheme,
    required String laneId,
    required String title,
    required String subtitle,
    required Color colorA,
    required Color colorB,
    required bool withBoundary,
  }) {
    final Widget content = Listener(
      onPointerDown: (PointerDownEvent e) => _hit(laneId, e.localPosition),
      onPointerMove: (PointerMoveEvent e) => _hit(laneId, e.localPosition),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[colorA.withValues(alpha: _tileOpacity), colorB.withValues(alpha: _tileOpacity)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 10),
              Expanded(
                child: AnimatedBuilder(
                  animation: _clock,
                  builder: (BuildContext context, Widget? child) {
                    final double t = _clock.value * _animationSpeed;
                    return Column(
                      children: List<Widget>.generate(4, (int i) {
                        final double n = (math.sin((t + i * 0.2) * math.pi * 2) + 1) / 2;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.white.withValues(alpha: 0.08 + n * 0.30),
                                    Colors.black.withValues(alpha: 0.10 + (1 - n) * 0.34),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'pulse ${(n * 100).toStringAsFixed(0)}%',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
                child: Text('hits=${_laneHits[laneId] ?? 0}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );

    if (!withBoundary) {
      return content;
    }
    return RepaintBoundary(child: content);
  }

  Widget _buildCaptureStudio(ColorScheme scheme) {
    final Widget captureSurface = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_tileRoundness),
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary.withValues(alpha: _tileOpacity),
            scheme.secondary.withValues(alpha: _tileOpacity),
            scheme.tertiary.withValues(alpha: _tileOpacity),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Capture Surface', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('This panel is wrapped in RepaintBoundary and can be exported with toImage.', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Expanded(
              child: AnimatedBuilder(
                animation: _clock,
                builder: (BuildContext context, Widget? child) {
                  final double t = _clock.value * _animationSpeed;
                  return CustomPaint(
                    painter: _CaptureWavePainter(
                      progress: t,
                      strength: _isolationStrength,
                      alpha: _tileOpacity,
                    ),
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _chip('attempts=$_captureAttempts'),
                _chip('success=$_captureSuccess'),
                _chip('failure=$_captureFailure'),
                _chip('scale=${_captureScale.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Listener(
              onPointerDown: (PointerDownEvent e) => _hit('capture-surface', e.localPosition),
              child: RepaintBoundary(key: _captureKey, child: captureSurface),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_tileRoundness),
                color: Colors.black.withValues(alpha: 0.22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Capture Console', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(_captureInfo, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _captureBoundary,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Capture boundary image'),
                  ),
                  const SizedBox(height: 10),
                  Text('last size=${_capturedWidth}x$_capturedHeight', style: const TextStyle(color: Colors.white70)),
                  Text('last bytes=$_capturedBytes', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  const Text('Practical usage samples:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  const Text('1. Export chart image previews', style: TextStyle(color: Colors.white70)),
                  const Text('2. Generate shareable snapshots', style: TextStyle(color: Colors.white70)),
                  const Text('3. Debug visual states in interpreter flows', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollBoard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Scroll this board. Alternate cards are optionally wrapped in RepaintBoundary to illustrate selective isolation.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 18,
            itemBuilder: (BuildContext context, int index) {
              final bool boundaryCandidate = index.isEven;
              final Widget tile = _scrollTile(scheme, index, boundaryCandidate);
              if (_wrapScrollCards && boundaryCandidate) {
                return RepaintBoundary(child: tile);
              }
              return tile;
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'scroll offset=${_scrollController.hasClients ? _scrollController.offset.toStringAsFixed(1) : '0.0'}',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollTile(ColorScheme scheme, int index, bool boundaryCandidate) {
    final Color base = boundaryCandidate ? scheme.primary : scheme.secondary;
    return Listener(
      onPointerDown: (PointerDownEvent e) => _hit('scroll-$index', e.localPosition),
      child: Container(
        height: 112,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          gradient: LinearGradient(
            colors: <Color>[base.withValues(alpha: _tileOpacity), scheme.tertiary.withValues(alpha: _tileOpacity)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.44)),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Scroll card ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(
                    boundaryCandidate
                        ? (_wrapScrollCards ? 'Wrapped in RepaintBoundary' : 'Candidate boundary disabled')
                        : 'Baseline sibling card',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.24), borderRadius: BorderRadius.circular(999)),
              child: Text('hits=${_laneHits['scroll-$index'] ?? 0}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardPulse(ColorScheme scheme) {
    Widget chart(String id, Color a, Color b) {
      final Widget chartWidget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          gradient: LinearGradient(colors: <Color>[a.withValues(alpha: _tileOpacity), b.withValues(alpha: _tileOpacity)]),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        ),
        child: Listener(
          onPointerDown: (PointerDownEvent e) => _hit(id, e.localPosition),
          child: AnimatedBuilder(
            animation: _clock,
            builder: (BuildContext context, Widget? child) {
              final double t = _clock.value * _animationSpeed;
              return CustomPaint(
                painter: _BarPulsePainter(progress: t, strength: _isolationStrength, noise: _noise),
                child: const SizedBox.expand(),
              );
            },
          ),
        ),
      );
      if (_wrapDashboardCharts) {
        return RepaintBoundary(child: chartWidget);
      }
      return chartWidget;
    }

    final Widget staticPanel = Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(_tileRoundness),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(12),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Static Panel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
          SizedBox(height: 6),
          Text('This region simulates mostly static UI around dynamic charts.', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text('Boundary wrapping can keep this panel from repainting excessively.', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );

    final Widget dynamicPanel = Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(_tileRoundness),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Dynamic Counters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 8),
          _counterRow('frameTick', _frameTick),
          _counterRow('paintTick', _paintTick),
          _counterRow('interactionTick', _interactionTick),
          _counterRow('scrollTick', _scrollTick),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: chart('dash-chart-1', scheme.primary, scheme.secondary)),
                const SizedBox(width: 10),
                Expanded(child: chart('dash-chart-2', scheme.secondary, scheme.tertiary)),
                const SizedBox(width: 10),
                Expanded(child: chart('dash-chart-3', scheme.tertiary, scheme.primary)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _wrapStaticPanel ? RepaintBoundary(child: staticPanel) : staticPanel),
                const SizedBox(width: 10),
                Expanded(child: _wrapDynamicPanel ? RepaintBoundary(child: dynamicPanel) : dynamicPanel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
          Text('$value', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildHeatGrid(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.builder(
        itemCount: 24,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (BuildContext context, int index) {
          final bool boundary = index.isEven;
          final Widget cell = Listener(
            onPointerDown: (PointerDownEvent e) => _hit('heat-$index', e.localPosition),
            onPointerMove: (PointerMoveEvent e) => _hit('heat-$index', e.localPosition),
            child: AnimatedBuilder(
              animation: _clock,
              builder: (BuildContext context, Widget? child) {
                final double t = (_clock.value * _animationSpeed + index * 0.07) % 1.0;
                final double pulse = (math.sin(t * math.pi * 2) + 1) / 2;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_tileRoundness * 0.6),
                    gradient: LinearGradient(
                      colors: <Color>[
                        scheme.primary.withValues(alpha: 0.22 + pulse * 0.55),
                        scheme.secondary.withValues(alpha: 0.22 + (1 - pulse) * 0.55),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                  ),
                  child: Center(
                    child: Text(
                      boundary ? 'B$index' : 'N$index',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              },
            ),
          );
          if (boundary) {
            return RepaintBoundary(child: cell);
          }
          return cell;
        },
      ),
    );
  }

  Widget _buildVerificationBoard(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_tileRoundness),
          gradient: LinearGradient(
            colors: <Color>[
              scheme.secondary.withValues(alpha: _tileOpacity),
              scheme.tertiary.withValues(alpha: _tileOpacity),
            ],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Interpreter Verification Checklist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
              const SizedBox(height: 10),
              const Text('1. Compare Isolation Arena lanes while animation runs.', style: TextStyle(color: Colors.white70)),
              const Text('2. Toggle boundary wrappers and confirm metric/timeline changes.', style: TextStyle(color: Colors.white70)),
              const Text('3. Use Capture Studio to run toImage workflow and inspect output metadata.', style: TextStyle(color: Colors.white70)),
              const Text('4. Scroll the board and test selective card boundaries.', style: TextStyle(color: Colors.white70)),
              const Text('5. Validate dashboard lane behavior with chart/static panel toggles.', style: TextStyle(color: Colors.white70)),
              const Text('6. Confirm no analyzer issues for this demo file.', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _chip('scenario=${_scenarios[_scenarioIndex].mode.name}'),
                  _chip('theme=${_themePalettes[_themeIndex].id}'),
                  _chip('frame=$_frameTick'),
                  _chip('paint=$_paintTick'),
                  _chip('hits=$_interactionTick'),
                  _chip('captures=$_captureSuccess/$_captureAttempts'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.black.withValues(alpha: 0.22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildConceptBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Concept Map', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Different practical ways RepaintBoundary appears in product UIs.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1020;
                final Widget cardA = _conceptCard(
                  scheme,
                  title: 'Animation Islands',
                  note: 'Boundary around active animation to protect static siblings from repaint churn.',
                  accent: const Color(0xFF0EA5E9),
                );
                final Widget cardB = _conceptCard(
                  scheme,
                  title: 'Snapshot Regions',
                  note: 'Boundary key used with toImage for exportable visual captures.',
                  accent: const Color(0xFFEA580C),
                );
                final Widget cardC = _conceptCard(
                  scheme,
                  title: 'Scrollable Cards',
                  note: 'Selective card-level boundaries for mixed static/dynamic feed items.',
                  accent: const Color(0xFF7C3AED),
                );
                if (narrow) {
                  return Column(children: <Widget>[cardA, const SizedBox(height: 10), cardB, const SizedBox(height: 10), cardC]);
                }
                return Row(children: <Widget>[Expanded(child: cardA), const SizedBox(width: 10), Expanded(child: cardB), const SizedBox(width: 10), Expanded(child: cardC)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _conceptCard(ColorScheme scheme, {required String title, required String note, required Color accent}) {
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
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accent.withValues(alpha: 0.16),
                border: Border.all(color: accent.withValues(alpha: 0.75)),
              ),
              child: Center(
                child: Text('Boundary candidate', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricCard> metrics = <_MetricCard>[
      _MetricCard(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Current stage mode.', icon: Icons.route_outlined),
      _MetricCard(label: 'Theme', value: _themePalettes[_themeIndex].name, note: 'Active palette.', icon: Icons.palette_outlined),
      _MetricCard(label: 'Frame Tick', value: '$_frameTick', note: 'Animation frame progression.', icon: Icons.timelapse_outlined),
      _MetricCard(label: 'Paint Tick', value: '$_paintTick', note: 'Estimated repaint pressure indicator.', icon: Icons.brush_outlined),
      _MetricCard(label: 'Scroll Tick', value: '$_scrollTick', note: 'Scroll event count.', icon: Icons.swap_vert_outlined),
      _MetricCard(label: 'Interaction Tick', value: '$_interactionTick', note: 'Pointer interactions on stage.', icon: Icons.touch_app_outlined),
      _MetricCard(label: 'Scenario Switches', value: '$_scenarioSwitches', note: 'Scenario changes.', icon: Icons.change_circle_outlined),
      _MetricCard(label: 'Theme Switches', value: '$_themeSwitches', note: 'Theme changes.', icon: Icons.color_lens_outlined),
      _MetricCard(label: 'Control Edits', value: '$_controlEdits', note: 'Control interaction count.', icon: Icons.tune_outlined),
      _MetricCard(label: 'Capture Attempts', value: '$_captureAttempts', note: 'Boundary capture requests.', icon: Icons.camera_outlined),
      _MetricCard(label: 'Capture Success', value: '$_captureSuccess', note: 'Successful captures.', icon: Icons.check_circle_outline),
      _MetricCard(label: 'Capture Failure', value: '$_captureFailure', note: 'Failed captures.', icon: Icons.error_outline),
      _MetricCard(label: 'Capture Size', value: '${_capturedWidth}x$_capturedHeight', note: 'Last capture dimensions.', icon: Icons.photo_size_select_large_outlined),
      _MetricCard(label: 'Capture Bytes', value: '$_capturedBytes', note: 'PNG byte length.', icon: Icons.data_object_outlined),
      _MetricCard(label: 'Animation Speed', value: _animationSpeed.toStringAsFixed(2), note: 'Clock multiplier.', icon: Icons.speed_outlined),
      _MetricCard(label: 'Isolation Strength', value: _isolationStrength.toStringAsFixed(2), note: 'Visual stress intensity.', icon: Icons.layers_outlined),
      _MetricCard(label: 'Tile Style', value: 'r=${_tileRoundness.toStringAsFixed(1)} o=${_tileOpacity.toStringAsFixed(2)}', note: 'Stage tile look.', icon: Icons.widgets_outlined),
      _MetricCard(label: 'Grid', value: '${_showGrid ? 'on' : 'off'} @${_gridDensity.toStringAsFixed(1)}', note: 'Background grid state.', icon: Icons.grid_on_outlined),
      _MetricCard(label: 'Heat Points', value: '${_heatPoints.length}', note: 'Current heat-map samples.', icon: Icons.blur_on_outlined),
      _MetricCard(label: 'Last Event', value: _lastChannel, note: _lastMessage, icon: Icons.info_outline),
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
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.6 : 2.02,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricCard metric = metrics[index];
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
                                Icon(metric.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(metric.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(metric.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(metric.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: scheme.surfaceContainerHighest,
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text(
                  'snapshot scenario=${_scenarios[_scenarioIndex].mode.name} theme=${_themePalettes[_themeIndex].id} '
                  'frame=$_frameTick paint=$_paintTick scroll=$_scrollTick interaction=$_interactionTick '
                  'capture=$_captureSuccess/$_captureAttempts scale=${_captureScale.toStringAsFixed(2)} '
                  'flags animate=$_animate grid=$_showGrid heat=$_showHeat staticWrap=$_wrapStaticPanel dynamicWrap=$_wrapDynamicPanel',
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
            ..._guideLines.map((String line) {
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                  color: scheme.surfaceContainerHighest,
                ),
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
                    setState(() {
                      _timeline.clear();
                    });
                    _pushEvent('system', 'timeline cleared');
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('Timeline is empty. Interact with the scenario to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.take(46).map(( _TimelineEvent event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: scheme.surfaceContainerHighest,
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(event.channel.characters.first.toUpperCase(), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text('${event.channel} | tick ${event.tick}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
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
  const _GridPainter({
    required this.color,
    required this.spacing,
    required this.tick,
    required this.speed,
    required this.noise,
  });

  final Color color;
  final double spacing;
  final int tick;
  final double speed;
  final double noise;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = (tick / 220.0) * speed;
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          color.withValues(alpha: 0.30 + 0.15 * math.sin(t * 0.5)),
          color.withValues(alpha: 0.10 + 0.12 * math.cos(t * 0.3)),
          color.withValues(alpha: 0.22 + 0.10 * math.sin(t * 0.7 + noise)),
        ],
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
    return oldDelegate.color != color ||
        oldDelegate.spacing != spacing ||
        oldDelegate.tick != tick ||
        oldDelegate.speed != speed ||
        oldDelegate.noise != noise;
  }
}

class _HeatPainter extends CustomPainter {
  const _HeatPainter({required this.points, required this.intensity});

  final List<Offset> points;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i += 1) {
      final double strength = (1 - (i / math.max(points.length, 1))) * intensity;
      final Offset p = points[i];
      final Rect rect = Rect.fromCircle(center: p, radius: 28);
      final Paint paint = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFDE047).withValues(alpha: strength),
            const Color(0xFFF97316).withValues(alpha: strength * 0.32),
            const Color(0xFFF97316).withValues(alpha: 0),
          ],
        ).createShader(rect);
      canvas.drawCircle(p, 28, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeatPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.intensity != intensity;
  }
}

class _CaptureWavePainter extends CustomPainter {
  const _CaptureWavePainter({
    required this.progress,
    required this.strength,
    required this.alpha,
  });

  final double progress;
  final double strength;
  final double alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          const Color(0xFF0891B2).withValues(alpha: 0.25 + 0.4 * alpha),
          const Color(0xFF7C3AED).withValues(alpha: 0.22 + 0.35 * alpha),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final Path path = Path();
    path.moveTo(0, size.height * 0.65);
    for (double x = 0; x <= size.width; x += 8) {
      final double t = x / size.width;
      final double y = size.height * (0.65 + (math.sin((t + progress) * math.pi * 2) * 0.16 * strength));
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white.withValues(alpha: 0.18));
  }

  @override
  bool shouldRepaint(covariant _CaptureWavePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.strength != strength || oldDelegate.alpha != alpha;
  }
}

class _BarPulsePainter extends CustomPainter {
  const _BarPulsePainter({
    required this.progress,
    required this.strength,
    required this.noise,
  });

  final double progress;
  final double strength;
  final double noise;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()..color = Colors.black.withValues(alpha: 0.18 + 0.12 * noise);
    canvas.drawRect(Offset.zero & size, base);

    final int bars = 12;
    final double bw = size.width / (bars + 2);
    for (int i = 0; i < bars; i += 1) {
      final double t = (progress + i * 0.07) % 1.0;
      final double hFactor = 0.2 + 0.75 * (0.5 + 0.5 * math.sin(t * math.pi * 2));
      final double h = size.height * hFactor * (0.3 + strength * 0.7);
      final Rect rect = Rect.fromLTWH((i + 1) * bw, size.height - h, bw * 0.65, h);
      final RRect bar = RRect.fromRectAndRadius(rect, const Radius.circular(6));
      final Color color = Color.lerp(const Color(0xFF22D3EE), const Color(0xFFF59E0B), i / bars)!;
      canvas.drawRRect(bar, Paint()..color = color.withValues(alpha: 0.72));
    }
  }

  @override
  bool shouldRepaint(covariant _BarPulsePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.strength != strength || oldDelegate.noise != noise;
  }
}
