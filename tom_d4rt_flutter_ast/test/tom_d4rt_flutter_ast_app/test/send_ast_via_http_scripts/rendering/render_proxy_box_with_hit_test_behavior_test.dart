import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const List<_ThemeProfile> _themes = <_ThemeProfile>[
  _ThemeProfile(
    id: 'teal-grid',
    name: 'Teal Grid',
    subtitle: 'High clarity for event-route overlays and stack tracing.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'sunset-mesh',
    name: 'Sunset Mesh',
    subtitle: 'Warm contrast for overlapping behavior zones.',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'midnight-radar',
    name: 'Midnight Radar',
    subtitle: 'Dark profile for dense hit-test diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    mode: _ScenarioMode.layerStack,
    title: 'Layer Stack',
    description: 'Overlapping zones with different hit-test behaviors in one stack.',
  ),
  _Scenario(
    mode: _ScenarioMode.passThroughLab,
    title: 'Pass-Through Lab',
    description: 'Transparent regions where behavior choice changes event forwarding.',
  ),
  _Scenario(
    mode: _ScenarioMode.nestedArena,
    title: 'Nested Arena',
    description: 'Outer/inner proxy hierarchy showing route priority and capture.',
  ),
  _Scenario(
    mode: _ScenarioMode.signalTower,
    title: 'Signal Tower',
    description: 'Pointer-signal and hover channels across stacked behavior gates.',
  ),
  _Scenario(
    mode: _ScenarioMode.mapBoard,
    title: 'Map Board',
    description: 'Spatial map of event paths and captured zone frequency.',
  ),
  _Scenario(
    mode: _ScenarioMode.analytics,
    title: 'Analytics',
    description: 'Route summaries, behavior comparisons, and verification checklist.',
  ),
];

const List<String> _guide = <String>[
  'RenderProxyBoxWithHitTestBehavior is used by proxy render objects that need configurable hit-test behavior.',
  'Behavior.opaque captures hits for bounds even when pixels are visually transparent.',
  'Behavior.translucent receives hits and can also allow targets behind to be hit.',
  'Behavior.deferToChild only reports hits when a child reports hit.',
  'Overlapping layers are the best way to observe practical behavior differences.',
  'Transparent visual regions can still be interactive depending on hit-test behavior.',
  'Pointer logs should capture both zone and behavior to debug routing quickly.',
  'Signal and hover events may route differently than tap/drag events in stacked layers.',
  'Use stage labels and color lanes to show which layer actually captured the event.',
  'Always pair behavior changes with diagnostics to avoid invisible interaction bugs.',
];

const List<_Faq> _faqs = <_Faq>[
  _Faq(
    question: 'When do I need RenderProxyBoxWithHitTestBehavior concepts?',
    answer: 'When building wrappers that alter hit testing without owning a completely custom render tree.',
  ),
  _Faq(
    question: 'Which behavior is safest by default?',
    answer: 'Opaque is predictable for full-region interaction, but choose based on pass-through needs.',
  ),
  _Faq(
    question: 'Why use translucent?',
    answer: 'It is useful for overlays that must observe events while not fully blocking content beneath.',
  ),
  _Faq(
    question: 'What does deferToChild solve?',
    answer: 'It keeps wrapper interaction conditional on whether children are hit, reducing accidental interception.',
  ),
  _Faq(
    question: 'How can I verify behavior under overlap?',
    answer: 'Build stacked zones with distinct labels and log every event with zone + behavior metadata.',
  ),
];

enum _ScenarioMode {
  layerStack,
  passThroughLab,
  nestedArena,
  signalTower,
  mapBoard,
  analytics,
}

class _ThemeProfile {
  const _ThemeProfile({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String subtitle;
  final Color seed;
  final Brightness brightness;
}

class _Scenario {
  const _Scenario({required this.mode, required this.title, required this.description});

  final _ScenarioMode mode;
  final String title;
  final String description;
}

class _Faq {
  const _Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _EventRow {
  const _EventRow({
    required this.time,
    required this.zone,
    required this.behavior,
    required this.type,
    required this.kind,
    required this.local,
    required this.note,
  });

  final DateTime time;
  final String zone;
  final HitTestBehavior behavior;
  final String type;
  final PointerDeviceKind kind;
  final Offset local;
  final String note;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _Snapshot {
  const _Snapshot({
    required this.scenario,
    required this.primaryBehavior,
    required this.secondaryBehavior,
    required this.events,
  });

  final String scenario;
  final String primaryBehavior;
  final String secondaryBehavior;
  final int events;
}

dynamic build(BuildContext context) {
  return const _RenderProxyBoxWithHitTestBehaviorStudio();
}

class _RenderProxyBoxWithHitTestBehaviorStudio extends StatefulWidget {
  const _RenderProxyBoxWithHitTestBehaviorStudio();

  @override
  State<_RenderProxyBoxWithHitTestBehaviorStudio> createState() => _RenderProxyBoxWithHitTestBehaviorStudioState();
}

class _RenderProxyBoxWithHitTestBehaviorStudioState extends State<_RenderProxyBoxWithHitTestBehaviorStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8600),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  HitTestBehavior _primaryBehavior = HitTestBehavior.opaque;
  HitTestBehavior _secondaryBehavior = HitTestBehavior.translucent;
  HitTestBehavior _tertiaryBehavior = HitTestBehavior.deferToChild;

  bool _animate = true;
  bool _showGrid = true;
  bool _showTrail = true;
  bool _showHeat = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showLabels = true;
  bool _showSignals = true;

  double _stageHeight = 590;
  double _zoneRound = 20;
  double _zoneOpacity = 0.88;
  double _overlayAlpha = 0.28;
  double _trailWidth = 2.2;
  double _trailFade = 0.74;
  double _heatStrength = 0.56;
  double _drift = 0.36;
  double _signalGain = 1.0;

  int _themeSwitches = 0;
  int _scenarioSwitches = 0;
  int _behaviorSwitches = 0;
  int _controlEdits = 0;

  int _downCount = 0;
  int _moveCount = 0;
  int _upCount = 0;
  int _hoverCount = 0;
  int _signalCount = 0;
  int _cancelCount = 0;

  double _signalX = 0;
  double _signalY = 0;

  String _phase = 'idle';
  String _lastZone = 'none';
  String _lastType = 'none';
  PointerDeviceKind _lastKind = PointerDeviceKind.unknown;

  final Map<String, int> _zoneHits = <String, int>{};
  final Map<int, List<Offset>> _trails = <int, List<Offset>>{};
  List<Offset> _heat = const <Offset>[];
  List<_EventRow> _events = const <_EventRow>[];

  _Snapshot _snapshot = const _Snapshot(
    scenario: 'layerStack',
    primaryBehavior: 'opaque',
    secondaryBehavior: 'translucent',
    events: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logSynthetic(zone: 'system', behavior: _primaryBehavior, type: 'init', note: 'Hit-test behavior studio initialized.');
    });
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  void _logSynthetic({required String zone, required HitTestBehavior behavior, required String type, required String note}) {
    setState(() {
      _events = <_EventRow>[
        _EventRow(
          time: DateTime.now(),
          zone: zone,
          behavior: behavior,
          type: type,
          kind: PointerDeviceKind.unknown,
          local: Offset.zero,
          note: note,
        ),
        ..._events,
      ].take(180).toList(growable: false);
    });
  }

  void _record({
    required String zone,
    required HitTestBehavior behavior,
    required PointerEvent event,
    required String type,
    String note = '',
  }) {
    setState(() {
      _phase = 'event';
      _lastZone = zone;
      _lastType = type;
      _lastKind = event.kind;

      _zoneHits[zone] = (_zoneHits[zone] ?? 0) + 1;

      if (event is PointerDownEvent) {
        _downCount += 1;
      } else if (event is PointerMoveEvent) {
        _moveCount += 1;
      } else if (event is PointerUpEvent) {
        _upCount += 1;
      } else if (event is PointerHoverEvent) {
        _hoverCount += 1;
      } else if (event is PointerCancelEvent) {
        _cancelCount += 1;
      } else if (event is PointerSignalEvent) {
        _signalCount += 1;
        if (event is PointerScrollEvent) {
          _signalX += event.scrollDelta.dx * _signalGain;
          _signalY += event.scrollDelta.dy * _signalGain;
        }
      }

      final List<Offset> trail = _trails.putIfAbsent(event.pointer, () => <Offset>[]);
      trail.add(event.localPosition);
      if (trail.length > 260) {
        trail.removeRange(0, trail.length - 260);
      }

      _heat = <Offset>[event.localPosition, ..._heat].take(120).toList(growable: false);

      _events = <_EventRow>[
        _EventRow(
          time: DateTime.now(),
          zone: zone,
          behavior: behavior,
          type: type,
          kind: event.kind,
          local: event.localPosition,
          note: note,
        ),
        ..._events,
      ].take(180).toList(growable: false);
    });
  }

  void _toggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'animate':
          _animate = next;
          break;
        case 'grid':
          _showGrid = next;
          break;
        case 'trail':
          _showTrail = next;
          break;
        case 'heat':
          _showHeat = next;
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
        case 'labels':
          _showLabels = next;
          break;
        case 'signals':
          _showSignals = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animate) {
      _clock.repeat();
    } else {
      _clock.stop();
    }
    _logSynthetic(zone: 'control', behavior: _primaryBehavior, type: 'toggle:$key', note: '$next');
  }

  void _onSlider(String key, double value) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _logSynthetic(zone: 'control', behavior: _primaryBehavior, type: 'slider:$key', note: value.toStringAsFixed(2));
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _primaryBehavior = HitTestBehavior.opaque;
      _secondaryBehavior = HitTestBehavior.translucent;
      _tertiaryBehavior = HitTestBehavior.deferToChild;

      _animate = true;
      _showGrid = true;
      _showTrail = true;
      _showHeat = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showLabels = true;
      _showSignals = true;

      _stageHeight = 590;
      _zoneRound = 20;
      _zoneOpacity = 0.88;
      _overlayAlpha = 0.28;
      _trailWidth = 2.2;
      _trailFade = 0.74;
      _heatStrength = 0.56;
      _drift = 0.36;
      _signalGain = 1.0;

      _phase = 'reset';
      _lastZone = 'none';
      _lastType = 'none';
      _lastKind = PointerDeviceKind.unknown;

      _zoneHits.clear();
      _trails.clear();
      _heat = const <Offset>[];
      _events = const <_EventRow>[];

      _downCount = 0;
      _moveCount = 0;
      _upCount = 0;
      _hoverCount = 0;
      _signalCount = 0;
      _cancelCount = 0;
      _signalX = 0;
      _signalY = 0;

      _snapshot = const _Snapshot(scenario: 'layerStack', primaryBehavior: 'opaque', secondaryBehavior: 'translucent', events: 0);
    });
    _clock.repeat();
    _logSynthetic(zone: 'system', behavior: _primaryBehavior, type: 'reset', note: 'Reset to defaults');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeProfile theme = _themes[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    _snapshot = _Snapshot(
      scenario: _scenarios[_scenarioIndex].mode.name,
      primaryBehavior: _primaryBehavior.name,
      secondaryBehavior: _secondaryBehavior.name,
      events: _events.length,
    );

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
                  constraints: const BoxConstraints(maxWidth: 1560),
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
                Icon(Icons.filter_frames_outlined, color: scheme.primary, size: 26),
                Text('RenderProxyBoxWithHitTestBehavior Routing Arena', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Visual deep demo for configurable hit-test behavior in proxy-box render patterns with overlapping event zones.',
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
                final _ThemeProfile t = _themes[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(t.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitches += 1;
                      _phase = 'theme';
                    });
                    _logSynthetic(zone: 'control', behavior: _primaryBehavior, type: 'theme', note: t.id);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themes[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int i) {
                final _Scenario s = _scenarios[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _scenarioSwitches += 1;
                      _phase = 'scenario';
                    });
                    _logSynthetic(zone: 'control', behavior: _primaryBehavior, type: 'scenario', note: s.mode.name);
                  },
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
                Text('Behavior Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune behavior channels, visual overlays, and route diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _slider(scheme: scheme, label: 'Stage Height', value: _stageHeight, min: 430, max: 940, divisions: 255, onChanged: (double v) => setState(() => _stageHeight = v), onChangeEnd: (double v) => _onSlider('stageHeight', v)),
            _slider(scheme: scheme, label: 'Zone Roundness', value: _zoneRound, min: 0, max: 48, divisions: 96, onChanged: (double v) => setState(() => _zoneRound = v), onChangeEnd: (double v) => _onSlider('zoneRound', v)),
            _slider(scheme: scheme, label: 'Zone Opacity', value: _zoneOpacity, min: 0.2, max: 1, divisions: 80, onChanged: (double v) => setState(() => _zoneOpacity = v), onChangeEnd: (double v) => _onSlider('zoneOpacity', v)),
            _slider(scheme: scheme, label: 'Overlay Alpha', value: _overlayAlpha, min: 0, max: 0.8, divisions: 80, onChanged: (double v) => setState(() => _overlayAlpha = v), onChangeEnd: (double v) => _onSlider('overlayAlpha', v)),
            _slider(scheme: scheme, label: 'Trail Width', value: _trailWidth, min: 0.6, max: 8, divisions: 74, onChanged: (double v) => setState(() => _trailWidth = v), onChangeEnd: (double v) => _onSlider('trailWidth', v)),
            _slider(scheme: scheme, label: 'Trail Fade', value: _trailFade, min: 0.1, max: 1, divisions: 90, onChanged: (double v) => setState(() => _trailFade = v), onChangeEnd: (double v) => _onSlider('trailFade', v)),
            _slider(scheme: scheme, label: 'Heat Strength', value: _heatStrength, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _heatStrength = v), onChangeEnd: (double v) => _onSlider('heatStrength', v)),
            _slider(scheme: scheme, label: 'Background Drift', value: _drift, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _drift = v), onChangeEnd: (double v) => _onSlider('drift', v)),
            _slider(scheme: scheme, label: 'Signal Gain', value: _signalGain, min: 0.2, max: 2, divisions: 90, onChanged: (double v) => setState(() => _signalGain = v), onChangeEnd: (double v) => _onSlider('signalGain', v)),
            const SizedBox(height: 8),
            Text('Primary Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HitTestBehavior.values.map((HitTestBehavior b) {
                return ChoiceChip(
                  selected: _primaryBehavior == b,
                  label: Text('P:${b.name}'),
                  onSelected: (_) {
                    setState(() {
                      _primaryBehavior = b;
                      _behaviorSwitches += 1;
                      _phase = 'behavior';
                    });
                    _logSynthetic(zone: 'control', behavior: b, type: 'primaryBehavior', note: b.name);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text('Secondary Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HitTestBehavior.values.map((HitTestBehavior b) {
                return ChoiceChip(
                  selected: _secondaryBehavior == b,
                  label: Text('S:${b.name}'),
                  onSelected: (_) {
                    setState(() {
                      _secondaryBehavior = b;
                      _behaviorSwitches += 1;
                      _phase = 'behavior';
                    });
                    _logSynthetic(zone: 'control', behavior: b, type: 'secondaryBehavior', note: b.name);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text('Tertiary Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HitTestBehavior.values.map((HitTestBehavior b) {
                return ChoiceChip(
                  selected: _tertiaryBehavior == b,
                  label: Text('T:${b.name}'),
                  onSelected: (_) {
                    setState(() {
                      _tertiaryBehavior = b;
                      _behaviorSwitches += 1;
                      _phase = 'behavior';
                    });
                    _logSynthetic(zone: 'control', behavior: b, type: 'tertiaryBehavior', note: b.name);
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Grid')),
                CheckboxMenuButton(value: _showTrail, onChanged: (bool? v) => _toggle('trail', v), child: const Text('Trail')),
                CheckboxMenuButton(value: _showHeat, onChanged: (bool? v) => _toggle('heat', v), child: const Text('Heat')),
                CheckboxMenuButton(value: _showLabels, onChanged: (bool? v) => _toggle('labels', v), child: const Text('Labels')),
                CheckboxMenuButton(value: _showSignals, onChanged: (bool? v) => _toggle('signals', v), child: const Text('Signal Hints')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Guide')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Timeline')),
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
    final double pulse = _animate ? _clock.value : 0;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Routing Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Interact with overlapping zones to observe hit-test behavior routing in real time.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            SizedBox(
              height: _stageHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: scheme.outlineVariant)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (_showGrid) CustomPaint(painter: _ArenaGridPainter(progress: pulse, drift: _drift)),
                      _buildScenarioLayer(scheme, pulse),
                      if (_showTrail)
                        IgnorePointer(
                          child: CustomPaint(
                            painter: _TrailPainter(trails: _trails, width: _trailWidth, fade: _trailFade, pulse: pulse),
                          ),
                        ),
                      if (_showHeat)
                        IgnorePointer(
                          child: CustomPaint(
                            painter: _HeatPainter(points: _heat, strength: _heatStrength),
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

  Widget _buildScenarioLayer(ColorScheme scheme, double pulse) {
    switch (_scenarios[_scenarioIndex].mode) {
      case _ScenarioMode.layerStack:
        return _layerStackScene(scheme, pulse);
      case _ScenarioMode.passThroughLab:
        return _passThroughScene(scheme, pulse);
      case _ScenarioMode.nestedArena:
        return _nestedArenaScene(scheme, pulse);
      case _ScenarioMode.signalTower:
        return _signalTowerScene(scheme, pulse);
      case _ScenarioMode.mapBoard:
        return _mapBoardScene(scheme, pulse);
      case _ScenarioMode.analytics:
        return _analyticsScene(scheme, pulse);
    }
  }

  Widget _layerStackScene(ColorScheme scheme, double pulse) {
    return Stack(
      children: <Widget>[
        _behaviorZone(
          scheme: scheme,
          zone: 'stack-bottom',
          behavior: _tertiaryBehavior,
          rect: const Rect.fromLTWH(60, 60, 860, 500),
          colors: <Color>[scheme.primary, scheme.secondary],
          label: 'Bottom Layer',
        ),
        _behaviorZone(
          scheme: scheme,
          zone: 'stack-middle',
          behavior: _secondaryBehavior,
          rect: const Rect.fromLTWH(180, 120, 760, 420),
          colors: <Color>[scheme.tertiary, scheme.primary],
          label: 'Middle Layer',
        ),
        _behaviorZone(
          scheme: scheme,
          zone: 'stack-top',
          behavior: _primaryBehavior,
          rect: const Rect.fromLTWH(310, 190, 520, 280),
          colors: <Color>[scheme.secondary, scheme.tertiary],
          label: 'Top Layer',
        ),
        if (_showSignals)
          Positioned(
            right: 12,
            top: 12,
            child: _hint('Tap or hover in overlaps to see capture priority by behavior.'),
          ),
      ],
    );
  }

  Widget _passThroughScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _behaviorZone(
              scheme: scheme,
              zone: 'pass-left',
              behavior: _primaryBehavior,
              rect: const Rect.fromLTWH(0, 0, 10000, 10000),
              colors: <Color>[scheme.primary, scheme.secondary],
              label: 'Primary Pass Lane',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: _behaviorZone(
                    scheme: scheme,
                    zone: 'pass-right-base',
                    behavior: _secondaryBehavior,
                    rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                    colors: <Color>[scheme.tertiary, scheme.primary],
                    label: 'Secondary Base',
                  ),
                ),
                Positioned(
                  left: 60,
                  top: 60,
                  right: 60,
                  bottom: 60,
                  child: _behaviorZone(
                    scheme: scheme,
                    zone: 'pass-right-overlay',
                    behavior: _tertiaryBehavior,
                    rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                    colors: <Color>[scheme.secondary, scheme.tertiary],
                    label: 'Tertiary Overlay',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nestedArenaScene(ColorScheme scheme, double pulse) {
    return Center(
      child: SizedBox(
        width: 920,
        height: 520,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _behaviorZone(
                scheme: scheme,
                zone: 'nested-outer',
                behavior: _primaryBehavior,
                rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                colors: <Color>[scheme.primary, scheme.secondary],
                label: 'Outer Proxy',
              ),
            ),
            Positioned(
              left: 120,
              top: 90,
              right: 120,
              bottom: 90,
              child: _behaviorZone(
                scheme: scheme,
                zone: 'nested-middle',
                behavior: _secondaryBehavior,
                rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                colors: <Color>[scheme.tertiary, scheme.primary],
                label: 'Middle Proxy',
              ),
            ),
            Positioned(
              left: 250,
              top: 180,
              right: 250,
              bottom: 180,
              child: _behaviorZone(
                scheme: scheme,
                zone: 'nested-inner',
                behavior: _tertiaryBehavior,
                rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                colors: <Color>[scheme.secondary, scheme.tertiary],
                label: 'Inner Proxy',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signalTowerScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Listener(
              behavior: _primaryBehavior,
              onPointerSignal: (PointerSignalEvent e) => _record(zone: 'signal-main', behavior: _primaryBehavior, event: e, type: 'signal', note: 'signal-main'),
              onPointerHover: (PointerHoverEvent e) => _record(zone: 'signal-main', behavior: _primaryBehavior, event: e, type: 'hover'),
              onPointerDown: (PointerDownEvent e) => _record(zone: 'signal-main', behavior: _primaryBehavior, event: e, type: 'down'),
              onPointerMove: (PointerMoveEvent e) => _record(zone: 'signal-main', behavior: _primaryBehavior, event: e, type: 'move'),
              onPointerUp: (PointerUpEvent e) => _record(zone: 'signal-main', behavior: _primaryBehavior, event: e, type: 'up'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _zoneOpacity), scheme.secondary.withValues(alpha: _zoneOpacity)]),
                  borderRadius: BorderRadius.circular(_zoneRound),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.48)),
                ),
                child: Stack(
                  children: <Widget>[
                    if (_showLabels)
                      const Positioned(
                        left: 14,
                        top: 12,
                        child: Text('Signal Tower Main', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                      ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('signalX=${_signalX.toStringAsFixed(1)} signalY=${_signalY.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                          const SizedBox(height: 8),
                          Text('signals=$_signalCount hover=$_hoverCount', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    if (_showSignals)
                      Positioned(right: 12, top: 12, child: _hint('Use wheel/trackpad scroll here')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: _behaviorZone(
                    scheme: scheme,
                    zone: 'signal-side-a',
                    behavior: _secondaryBehavior,
                    rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                    colors: <Color>[scheme.tertiary, scheme.primary],
                    label: 'Side A',
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _behaviorZone(
                    scheme: scheme,
                    zone: 'signal-side-b',
                    behavior: _tertiaryBehavior,
                    rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                    colors: <Color>[scheme.secondary, scheme.tertiary],
                    label: 'Side B',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapBoardScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _behaviorZone(
              scheme: scheme,
              zone: 'map-board',
              behavior: _primaryBehavior,
              rect: const Rect.fromLTWH(0, 0, 10000, 10000),
              colors: <Color>[scheme.primary, scheme.secondary],
              label: 'Map Capture Surface',
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final List<MapEntry<String, int>> entries = _zoneHits.entries.toList()..sort((MapEntry<String, int> a, MapEntry<String, int> b) => b.value.compareTo(a.value));
                if (entries.isEmpty) {
                  return Container(
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.3))),
                    child: const Center(child: Text('Interact with stage to populate map frequencies', style: TextStyle(color: Colors.white70))),
                  );
                }
                return GridView.builder(
                  itemCount: entries.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.7),
                  itemBuilder: (BuildContext context, int index) {
                    final MapEntry<String, int> entry = entries[index];
                    return Container(
                      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.24), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withValues(alpha: 0.38))),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(entry.key, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                          Text(entry.value.toString(), style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyticsScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _behaviorZone(
                  scheme: scheme,
                  zone: 'analytics-left',
                  behavior: _primaryBehavior,
                  rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                  colors: <Color>[scheme.primary, scheme.secondary],
                  label: 'Analytics Probe A',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _behaviorZone(
                  scheme: scheme,
                  zone: 'analytics-right',
                  behavior: _secondaryBehavior,
                  rect: const Rect.fromLTWH(0, 0, 10000, 10000),
                  colors: <Color>[scheme.tertiary, scheme.primary],
                  label: 'Analytics Probe B',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[scheme.secondary.withValues(alpha: _zoneOpacity), scheme.tertiary.withValues(alpha: _zoneOpacity)]),
                borderRadius: BorderRadius.circular(_zoneRound),
                border: Border.all(color: Colors.white.withValues(alpha: 0.44)),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Interpreter Verification Checklist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                  const SizedBox(height: 8),
                  const Text('1. Toggle behaviors and verify route changes in timeline.', style: TextStyle(color: Colors.white70)),
                  const Text('2. Confirm overlap capture differs between opaque/translucent/deferToChild.', style: TextStyle(color: Colors.white70)),
                  const Text('3. Observe signal and hover channels in stacked zones.', style: TextStyle(color: Colors.white70)),
                  const Text('4. Validate zone frequency map updates consistently.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _chip('primary=${_primaryBehavior.name}'),
                      _chip('secondary=${_secondaryBehavior.name}'),
                      _chip('tertiary=${_tertiaryBehavior.name}'),
                      _chip('events=${_events.length}'),
                      _chip('phase=$_phase'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _behaviorZone({
    required ColorScheme scheme,
    required String zone,
    required HitTestBehavior behavior,
    required Rect rect,
    required List<Color> colors,
    required String label,
  }) {
    return Positioned.fromRect(
      rect: rect,
      child: Listener(
        behavior: behavior,
        onPointerDown: (PointerDownEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'down'),
        onPointerMove: (PointerMoveEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'move'),
        onPointerUp: (PointerUpEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'up'),
        onPointerHover: (PointerHoverEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'hover'),
        onPointerCancel: (PointerCancelEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'cancel'),
        onPointerSignal: (PointerSignalEvent e) => _record(zone: zone, behavior: behavior, event: e, type: 'signal'),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[colors.first.withValues(alpha: _zoneOpacity), colors.last.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(_zoneRound),
            border: Border.all(color: Colors.white.withValues(alpha: 0.46)),
          ),
          child: Stack(
            children: <Widget>[
              if (_showLabels)
                Positioned(
                  left: 10,
                  top: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                      Text('behavior=${behavior.name}', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 11)),
                    ],
                  ),
                ),
              if (_showLabels)
                Positioned(
                  right: 10,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: _overlayAlpha), borderRadius: BorderRadius.circular(999)),
                    child: Text('hits=${_zoneHits[zone] ?? 0}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hint(String text) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.36), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.26), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withValues(alpha: 0.4))),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
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
            Text('Behavior Reference', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Quick visual summary of behavior semantics in proxy wrappers.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget opaque = _behaviorCard(scheme, 'opaque', 'Captures entire bounds for hit testing.', const Color(0xFF0F766E));
                final Widget translucent = _behaviorCard(scheme, 'translucent', 'Receives hits and may allow behind targets too.', const Color(0xFF1D4ED8));
                final Widget defer = _behaviorCard(scheme, 'deferToChild', 'Only hits when child reports a hit.', const Color(0xFFB45309));
                if (narrow) {
                  return Column(children: <Widget>[opaque, const SizedBox(height: 10), translucent, const SizedBox(height: 10), defer]);
                }
                return Row(children: <Widget>[Expanded(child: opaque), const SizedBox(width: 10), Expanded(child: translucent), const SizedBox(width: 10), Expanded(child: defer)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _behaviorCard(ColorScheme scheme, String title, String note, Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
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
              decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.65))),
              child: Center(child: Text('selected=${_primaryBehavior.name == title || _secondaryBehavior.name == title || _tertiaryBehavior.name == title}', style: TextStyle(color: color, fontWeight: FontWeight.w800))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_Metric> metrics = _metrics();
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
                    final _Metric m = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
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
            if (_showDiagnostics) _buildSnapshotPanel(scheme),
          ],
        ),
      ),
    );
  }

  List<_Metric> _metrics() {
    return <_Metric>[
      _Metric(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active routing scenario.', icon: Icons.route_outlined),
      _Metric(label: 'Theme', value: _themes[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _Metric(label: 'Primary', value: _primaryBehavior.name, note: 'Primary behavior selection.', icon: Icons.looks_one_outlined),
      _Metric(label: 'Secondary', value: _secondaryBehavior.name, note: 'Secondary behavior selection.', icon: Icons.looks_two_outlined),
      _Metric(label: 'Tertiary', value: _tertiaryBehavior.name, note: 'Tertiary behavior selection.', icon: Icons.looks_3_outlined),
      _Metric(label: 'Events', value: '${_events.length}', note: 'Total timeline entries captured.', icon: Icons.list_alt_outlined),
      _Metric(label: 'Counters', value: 'd=$_downCount m=$_moveCount u=$_upCount', note: 'Down/move/up counts.', icon: Icons.countertops_outlined),
      _Metric(label: 'Secondary Counts', value: 'h=$_hoverCount s=$_signalCount c=$_cancelCount', note: 'Hover/signal/cancel counts.', icon: Icons.insights_outlined),
      _Metric(label: 'Signal Drift', value: 'x=${_signalX.toStringAsFixed(1)} y=${_signalY.toStringAsFixed(1)}', note: 'Accumulated scroll delta totals.', icon: Icons.swipe_vertical_outlined),
      _Metric(label: 'Trails', value: '${_trails.length} pointers', note: 'Active pointer trail maps.', icon: Icons.timeline_outlined),
      _Metric(label: 'Heat', value: '${_heat.length} points', note: 'Heat-map samples retained.', icon: Icons.blur_on_outlined),
      _Metric(label: 'Stage Height', value: _stageHeight.toStringAsFixed(0), note: 'Stage display height.', icon: Icons.height_outlined),
      _Metric(label: 'Zone Style', value: 'round=${_zoneRound.toStringAsFixed(1)} opacity=${_zoneOpacity.toStringAsFixed(2)}', note: 'Zone visual styling.', icon: Icons.style_outlined),
      _Metric(label: 'Trail Style', value: 'width=${_trailWidth.toStringAsFixed(2)} fade=${_trailFade.toStringAsFixed(2)}', note: 'Trail drawing settings.', icon: Icons.gesture_outlined),
      _Metric(label: 'Switches', value: 'theme=$_themeSwitches scenario=$_scenarioSwitches behavior=$_behaviorSwitches', note: 'Major switch counts.', icon: Icons.swap_horiz_outlined),
      _Metric(label: 'Controls', value: '$_controlEdits', note: 'Control edit count.', icon: Icons.tune_outlined),
      _Metric(label: 'Last Zone', value: _lastZone, note: 'Most recent event zone.', icon: Icons.place_outlined),
      _Metric(label: 'Last Type', value: _lastType, note: 'Most recent pointer type.', icon: Icons.fiber_manual_record_outlined),
      _Metric(label: 'Last Kind', value: _lastKind.name, note: 'Most recent device kind.', icon: Icons.devices_outlined),
      _Metric(label: 'Phase', value: _phase, note: 'Current interaction phase.', icon: Icons.flag_outlined),
    ];
  }

  Widget _buildSnapshotPanel(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
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
            Text('theme=${_themes[_themeIndex].id} scenario=${_snapshot.scenario} primary=${_snapshot.primaryBehavior} secondary=${_snapshot.secondaryBehavior}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('tertiary=${_tertiaryBehavior.name} events=${_snapshot.events} phase=$_phase lastZone=$_lastZone lastType=$_lastType', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stage=${_stageHeight.toStringAsFixed(0)} zoneRound=${_zoneRound.toStringAsFixed(1)} zoneOpacity=${_zoneOpacity.toStringAsFixed(2)} overlay=${_overlayAlpha.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('trailWidth=${_trailWidth.toStringAsFixed(2)} trailFade=${_trailFade.toStringAsFixed(2)} heat=${_heatStrength.toStringAsFixed(2)} drift=${_drift.toStringAsFixed(2)} signalGain=${_signalGain.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags animate=$_animate grid=$_showGrid trail=$_showTrail heat=$_showHeat labels=$_showLabels signals=$_showSignals', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(faq.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(faq.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Event Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(onPressed: () => setState(() => _events = const <_EventRow>[]), icon: const Icon(Icons.clear_all), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological list of captured pointer events and behavior metadata.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_events.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with the stage to collect event routes.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _events.take(44).map(( _EventRow e) {
                  final String stamp = '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}:${e.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(e.type.characters.first.toUpperCase(), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text('${e.zone} | ${e.type} | ${e.behavior.name}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
                      subtitle: Text('$stamp  local=(${e.local.dx.toStringAsFixed(1)}, ${e.local.dy.toStringAsFixed(1)}) kind=${e.kind.name}  ${e.note}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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

class _ArenaGridPainter extends CustomPainter {
  const _ArenaGridPainter({required this.progress, required this.drift});

  final double progress;
  final double drift;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF22D3EE), const Color(0xFF34D399), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF3B82F6), const Color(0xFF8B5CF6), drift)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withValues(alpha: 0.2));

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    const double step = 28;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}

class _TrailPainter extends CustomPainter {
  const _TrailPainter({required this.trails, required this.width, required this.fade, required this.pulse});

  final Map<int, List<Offset>> trails;
  final double width;
  final double fade;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> palette = <Color>[
      const Color(0xFF22D3EE),
      const Color(0xFF34D399),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFFA78BFA),
      const Color(0xFF60A5FA),
    ];
    int index = 0;
    for (final List<Offset> points in trails.values) {
      if (points.length < 2) {
        index += 1;
        continue;
      }
      final Color c = palette[index % palette.length].withValues(alpha: fade * (0.7 + 0.3 * math.sin((pulse * math.pi * 2) + index)));
      final Paint p = Paint()
        ..color = c
        ..strokeWidth = width
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final Path path = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i += 1) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, p);
      index += 1;
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter oldDelegate) {
    return oldDelegate.trails != trails || oldDelegate.width != width || oldDelegate.fade != fade || oldDelegate.pulse != pulse;
  }
}

class _HeatPainter extends CustomPainter {
  const _HeatPainter({required this.points, required this.strength});

  final List<Offset> points;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i += 1) {
      final double alpha = (1 - (i / math.max(points.length, 1))) * strength;
      final Offset p = points[i];
      final Rect rect = Rect.fromCircle(center: p, radius: 36);
      final Paint glow = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFDE047).withValues(alpha: alpha),
            const Color(0xFFF97316).withValues(alpha: alpha * 0.35),
            const Color(0xFFF97316).withValues(alpha: 0),
          ],
        ).createShader(rect);
      canvas.drawCircle(p, 36, glow);
    }
  }

  @override
  bool shouldRepaint(covariant _HeatPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.strength != strength;
  }
}
