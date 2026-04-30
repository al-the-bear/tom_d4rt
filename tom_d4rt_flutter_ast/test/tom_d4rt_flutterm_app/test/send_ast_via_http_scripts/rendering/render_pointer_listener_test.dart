import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const List<_ThemePreset> _pointerThemes = <_ThemePreset>[
  _ThemePreset(
    id: 'coast',
    name: 'Coast Lab',
    subtitle: 'Cool palette for event traces and hover density visuals.',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Console',
    subtitle: 'Warm palette for pointer pressure and event bursts.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Matrix',
    subtitle: 'Dark profile for high-contrast hit-test diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_SceneSpec> _sceneSpecs = <_SceneSpec>[
  _SceneSpec(
    mode: _SceneMode.introPad,
    title: 'Intro Pad',
    description: 'Pointer down/move/up/cancel flow in large tracked pads.',
  ),
  _SceneSpec(
    mode: _SceneMode.hoverField,
    title: 'Hover Field',
    description: 'Dense hover and movement capture with spatial overlays.',
  ),
  _SceneSpec(
    mode: _SceneMode.dragDeck,
    title: 'Drag Deck',
    description: 'Pointer motion trails, velocity feel, and device categories.',
  ),
  _SceneSpec(
    mode: _SceneMode.hitTestArena,
    title: 'Hit-Test Arena',
    description: 'Compare HitTestBehavior choices for stacked listeners.',
  ),
  _SceneSpec(
    mode: _SceneMode.signalBoard,
    title: 'Signal Board',
    description: 'Mouse wheel/trackpad signal event logging and summaries.',
  ),
  _SceneSpec(
    mode: _SceneMode.analytics,
    title: 'Analytics',
    description: 'Aggregated metrics, diagnostics snapshots, and guidance.',
  ),
];

const List<String> _guideItems = <String>[
  'Listener maps directly to low-level pointer events and is built on RenderPointerListener.',
  'Use onPointerDown/move/up/cancel when you need raw pointer stream control.',
  'Use onPointerHover for desktop/mouse hover experiences.',
  'Use onPointerSignal for wheel and platform signal events.',
  'HitTestBehavior controls whether your listener captures transparent areas and event pass-through.',
  'Raw pointer handling is ideal for custom controls, canvas tools, and analytics overlays.',
  'Prefer gesture widgets when semantic gestures are enough; use Listener for raw access.',
  'Visual traces and timelines help verify interpreter delivery order and event integrity.',
  'Pointer device kinds can drive adaptive interactions and UI hints.',
  'Keep event logs bounded and summarize counters for stable runtime diagnostics.',
];

const List<_FaqEntry> _faqEntries = <_FaqEntry>[
  _FaqEntry(
    question: 'When should I use Listener instead of GestureDetector?',
    answer: 'Use Listener when you need raw pointer granularity rather than semantic gestures.',
  ),
  _FaqEntry(
    question: 'How does HitTestBehavior impact pointer events?',
    answer: 'It determines whether transparent regions receive events and whether events pass through.',
  ),
  _FaqEntry(
    question: 'Can I observe scroll wheel input?',
    answer: 'Yes, via onPointerSignal, typically as PointerScrollEvent with scrollDelta.',
  ),
  _FaqEntry(
    question: 'Does Listener support hover separately from move?',
    answer: 'Yes, onPointerHover is triggered when no button is pressed and pointer moves in region.',
  ),
  _FaqEntry(
    question: 'How can I test event ordering?',
    answer: 'Record timestamped logs in a timeline and compare down/move/up/cancel sequences.',
  ),
];

enum _SceneMode {
  introPad,
  hoverField,
  dragDeck,
  hitTestArena,
  signalBoard,
  analytics,
}

class _ThemePreset {
  const _ThemePreset({
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

class _SceneSpec {
  const _SceneSpec({required this.mode, required this.title, required this.description});

  final _SceneMode mode;
  final String title;
  final String description;
}

class _FaqEntry {
  const _FaqEntry({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _EventSample {
  const _EventSample({
    required this.time,
    required this.zone,
    required this.kind,
    required this.type,
    required this.local,
    required this.delta,
    required this.buttons,
    required this.pointer,
  });

  final DateTime time;
  final String zone;
  final String kind;
  final String type;
  final Offset local;
  final Offset delta;
  final int buttons;
  final int pointer;
}

class _MetricTile {
  const _MetricTile({required this.title, required this.value, required this.note, required this.icon});

  final String title;
  final String value;
  final String note;
  final IconData icon;
}

class _StageSnapshot {
  const _StageSnapshot({
    required this.scene,
    required this.behavior,
    required this.maxTrail,
    required this.activePointerCount,
  });

  final String scene;
  final String behavior;
  final int maxTrail;
  final int activePointerCount;
}

dynamic build(BuildContext context) {
  return const _RenderPointerListenerStudio();
}

class _RenderPointerListenerStudio extends StatefulWidget {
  const _RenderPointerListenerStudio();

  @override
  State<_RenderPointerListenerStudio> createState() => _RenderPointerListenerStudioState();
}

class _RenderPointerListenerStudioState extends State<_RenderPointerListenerStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8800),
  )..repeat();

  int _themeIndex = 0;
  int _sceneIndex = 0;

  HitTestBehavior _behavior = HitTestBehavior.opaque;

  bool _animate = true;
  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showTrail = true;
  bool _showHoverHeat = true;
  bool _showRawCoordinates = true;
  bool _showSignalHints = true;

  double _stageHeight = 560;
  double _trailFade = 0.78;
  double _trailThickness = 2.4;
  double _hoverStrength = 0.48;
  double _zoneRoundness = 18;
  double _zoneOpacity = 0.92;
  double _drift = 0.34;
  double _padScale = 1.0;
  double _signalGain = 1.0;
  int _maxTrailPoints = 240;

  int _themeChanges = 0;
  int _sceneChanges = 0;
  int _behaviorChanges = 0;
  int _controlEdits = 0;
  int _stageTaps = 0;

  int _downCount = 0;
  int _moveCount = 0;
  int _upCount = 0;
  int _cancelCount = 0;
  int _hoverCount = 0;
  int _signalCount = 0;

  double _signalX = 0;
  double _signalY = 0;

  String _phase = 'idle';
  String _lastDeviceKind = 'unknown';
  String _lastType = 'none';
  Offset _lastLocal = Offset.zero;
  Offset _lastDelta = Offset.zero;

  _StageSnapshot _snapshot = const _StageSnapshot(
    scene: 'introPad',
    behavior: 'opaque',
    maxTrail: 240,
    activePointerCount: 0,
  );

  final Map<int, List<Offset>> _pointerTrails = <int, List<Offset>>{};
  final Map<int, Offset> _hoverPoints = <int, Offset>{};
  List<_EventSample> _events = const <_EventSample>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appendSyntheticEvent('system', 'init', 'studio', Offset.zero, Offset.zero, 0, -1);
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _appendSyntheticEvent(String zone, String kind, String type, Offset local, Offset delta, int buttons, int pointer) {
    setState(() {
      _events = <_EventSample>[
        _EventSample(
          time: DateTime.now(),
          zone: zone,
          kind: kind,
          type: type,
          local: local,
          delta: delta,
          buttons: buttons,
          pointer: pointer,
        ),
        ..._events,
      ].take(160).toList(growable: false);
    });
  }

  void _recordPointer({required String zone, required PointerEvent event, required String type}) {
    final String kind = event.kind.name;
    setState(() {
      _lastDeviceKind = kind;
      _lastType = type;
      _lastLocal = event.localPosition;
      _lastDelta = event.delta;
      _phase = 'event';

      if (event is PointerDownEvent) {
        _downCount += 1;
      } else if (event is PointerMoveEvent) {
        _moveCount += 1;
      } else if (event is PointerUpEvent) {
        _upCount += 1;
      } else if (event is PointerCancelEvent) {
        _cancelCount += 1;
      } else if (event is PointerHoverEvent) {
        _hoverCount += 1;
      } else if (event is PointerSignalEvent) {
        _signalCount += 1;
        if (event is PointerScrollEvent) {
          _signalX += event.scrollDelta.dx * _signalGain;
          _signalY += event.scrollDelta.dy * _signalGain;
        }
      }

      final List<Offset> trail = _pointerTrails.putIfAbsent(event.pointer, () => <Offset>[]);
      trail.add(event.localPosition);
      if (trail.length > _maxTrailPoints) {
        trail.removeRange(0, trail.length - _maxTrailPoints);
      }

      if (event is PointerHoverEvent) {
        _hoverPoints[event.pointer] = event.localPosition;
      }
      if (event is PointerUpEvent || event is PointerCancelEvent) {
        _hoverPoints.remove(event.pointer);
      }

      _events = <_EventSample>[
        _EventSample(
          time: DateTime.now(),
          zone: zone,
          kind: kind,
          type: type,
          local: event.localPosition,
          delta: event.delta,
          buttons: event.buttons,
          pointer: event.pointer,
        ),
        ..._events,
      ].take(160).toList(growable: false);
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
        case 'guide':
          _showGuide = next;
          break;
        case 'timeline':
          _showTimeline = next;
          break;
        case 'diagnostics':
          _showDiagnostics = next;
          break;
        case 'trail':
          _showTrail = next;
          break;
        case 'hover':
          _showHoverHeat = next;
          break;
        case 'coords':
          _showRawCoordinates = next;
          break;
        case 'signal':
          _showSignalHints = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animate) {
      _pulse.repeat();
    } else {
      _pulse.stop();
    }
    _appendSyntheticEvent('control', 'toggle', key, Offset.zero, Offset.zero, next ? 1 : 0, -1);
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _sceneIndex = 0;
      _behavior = HitTestBehavior.opaque;
      _animate = true;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showTrail = true;
      _showHoverHeat = true;
      _showRawCoordinates = true;
      _showSignalHints = true;
      _stageHeight = 560;
      _trailFade = 0.78;
      _trailThickness = 2.4;
      _hoverStrength = 0.48;
      _zoneRoundness = 18;
      _zoneOpacity = 0.92;
      _drift = 0.34;
      _padScale = 1.0;
      _signalGain = 1.0;
      _maxTrailPoints = 240;
      _phase = 'reset';
      _lastDeviceKind = 'unknown';
      _lastType = 'none';
      _lastLocal = Offset.zero;
      _lastDelta = Offset.zero;
      _pointerTrails.clear();
      _hoverPoints.clear();
      _events = const <_EventSample>[];
      _downCount = 0;
      _moveCount = 0;
      _upCount = 0;
      _cancelCount = 0;
      _hoverCount = 0;
      _signalCount = 0;
      _signalX = 0;
      _signalY = 0;
      _snapshot = const _StageSnapshot(scene: 'introPad', behavior: 'opaque', maxTrail: 240, activePointerCount: 0);
    });
    _pulse.repeat();
    _appendSyntheticEvent('system', 'reset', 'defaults', Offset.zero, Offset.zero, 0, -1);
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset profile = _pointerThemes[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: profile.seed, brightness: profile.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: profile.brightness),
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
                  constraints: const BoxConstraints(maxWidth: 1520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeAndSceneBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildStageBoard(scheme),
                      const SizedBox(height: 14),
                      _buildBehaviorBoard(scheme),
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
                Icon(Icons.touch_app_outlined, size: 26, color: scheme.primary),
                Text(
                  'RenderPointerListener Interaction Observatory',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_sceneSpecs[_sceneIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual demo for low-level pointer streams, hover/signal handling, and hit-test behavior based on Listener/RenderPointerListener.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAndSceneBoard(ColorScheme scheme) {
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
              children: List<Widget>.generate(_pointerThemes.length, (int i) {
                final _ThemePreset p = _pointerThemes[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeChanges += 1;
                      _phase = 'theme';
                    });
                    _appendSyntheticEvent('control', 'theme', p.id, Offset.zero, Offset.zero, 0, -1);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_pointerThemes[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Pointer Scenes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_sceneSpecs.length, (int i) {
                final _SceneSpec s = _sceneSpecs[i];
                return FilterChip(
                  selected: _sceneIndex == i,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _sceneIndex = i;
                      _sceneChanges += 1;
                      _phase = 'scene';
                    });
                    _appendSyntheticEvent('control', 'scene', s.mode.name, Offset.zero, Offset.zero, 0, -1);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_sceneSpecs[_sceneIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Pointer Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune stage and tracing parameters to inspect raw pointer behavior.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 420,
              max: 900,
              divisions: 240,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _bumpControl('stage', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Trail Fade',
              value: _trailFade,
              min: 0.1,
              max: 1,
              divisions: 90,
              onChanged: (double v) => setState(() => _trailFade = v),
              onChangeEnd: (double v) => _bumpControl('trailFade', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Trail Thickness',
              value: _trailThickness,
              min: 0.6,
              max: 8,
              divisions: 148,
              onChanged: (double v) => setState(() => _trailThickness = v),
              onChangeEnd: (double v) => _bumpControl('trailThickness', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Hover Strength',
              value: _hoverStrength,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _hoverStrength = v),
              onChangeEnd: (double v) => _bumpControl('hoverStrength', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Zone Roundness',
              value: _zoneRoundness,
              min: 0,
              max: 42,
              divisions: 84,
              onChanged: (double v) => setState(() => _zoneRoundness = v),
              onChangeEnd: (double v) => _bumpControl('zoneRoundness', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Zone Opacity',
              value: _zoneOpacity,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _zoneOpacity = v),
              onChangeEnd: (double v) => _bumpControl('zoneOpacity', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Background Drift',
              value: _drift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _drift = v),
              onChangeEnd: (double v) => _bumpControl('drift', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Pad Scale',
              value: _padScale,
              min: 0.7,
              max: 1.4,
              divisions: 70,
              onChanged: (double v) => setState(() => _padScale = v),
              onChangeEnd: (double v) => _bumpControl('padScale', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Signal Gain',
              value: _signalGain,
              min: 0.2,
              max: 2,
              divisions: 90,
              onChanged: (double v) => setState(() => _signalGain = v),
              onChangeEnd: (double v) => _bumpControl('signalGain', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Max Trail Points',
              value: _maxTrailPoints.toDouble(),
              min: 50,
              max: 500,
              divisions: 90,
              onChanged: (double v) => setState(() => _maxTrailPoints = v.round()),
              onChangeEnd: (double v) => _bumpControl('maxTrailPoints', v),
            ),
            const SizedBox(height: 8),
            Text('HitTestBehavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HitTestBehavior.values.map((HitTestBehavior b) {
                return ChoiceChip(
                  selected: _behavior == b,
                  label: Text(b.name),
                  onSelected: (_) {
                    setState(() {
                      _behavior = b;
                      _behaviorChanges += 1;
                      _phase = 'behavior';
                    });
                    _appendSyntheticEvent('control', 'behavior', b.name, Offset.zero, Offset.zero, 0, -1);
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate background')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showTrail, onChanged: (bool? v) => _toggle('trail', v), child: const Text('Show trails')),
                CheckboxMenuButton(value: _showHoverHeat, onChanged: (bool? v) => _toggle('hover', v), child: const Text('Show hover heat')),
                CheckboxMenuButton(value: _showRawCoordinates, onChanged: (bool? v) => _toggle('coords', v), child: const Text('Show coordinates')),
                CheckboxMenuButton(value: _showSignalHints, onChanged: (bool? v) => _toggle('signal', v), child: const Text('Show signal hints')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Show guide')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Show timeline')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _bumpControl(String name, double value) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _appendSyntheticEvent('control', 'slider', '$name=${value.toStringAsFixed(2)}', Offset.zero, Offset.zero, 0, -1);
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
    final double progress = _animate ? _pulse.value : 0;
    _snapshot = _StageSnapshot(
      scene: _sceneSpecs[_sceneIndex].mode.name,
      behavior: _behavior.name,
      maxTrail: _maxTrailPoints,
      activePointerCount: _pointerTrails.length,
    );

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Pointer Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Interact directly with the stage to generate raw pointer streams.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _stageTaps += 1;
                  _phase = 'tap';
                });
                _appendSyntheticEvent('stage', 'tap', 'gesture', Offset.zero, Offset.zero, 0, -1);
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
                        if (_showGrid) CustomPaint(painter: _StageGridPainter(progress: progress, drift: _drift)),
                        _buildSceneLayer(scheme, progress),
                        if (_showTrail)
                          IgnorePointer(
                            child: CustomPaint(
                              painter: _TrailPainter(
                                trails: _pointerTrails,
                                fade: _trailFade,
                                thickness: _trailThickness,
                                pulse: progress,
                              ),
                            ),
                          ),
                        if (_showHoverHeat)
                          IgnorePointer(
                            child: CustomPaint(
                              painter: _HoverHeatPainter(
                                points: _hoverPoints.values.toList(growable: false),
                                strength: _hoverStrength,
                              ),
                            ),
                          ),
                        if (_showRawCoordinates)
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: _coordBadge(scheme),
                          ),
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

  Widget _coordBadge(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.36), borderRadius: BorderRadius.circular(10)),
      child: Text(
        'type=$_lastType kind=$_lastDeviceKind\nlocal=(${_lastLocal.dx.toStringAsFixed(1)}, ${_lastLocal.dy.toStringAsFixed(1)}) delta=(${_lastDelta.dx.toStringAsFixed(1)}, ${_lastDelta.dy.toStringAsFixed(1)})',
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildSceneLayer(ColorScheme scheme, double progress) {
    switch (_sceneSpecs[_sceneIndex].mode) {
      case _SceneMode.introPad:
        return _introPadScene(scheme);
      case _SceneMode.hoverField:
        return _hoverFieldScene(scheme, progress);
      case _SceneMode.dragDeck:
        return _dragDeckScene(scheme, progress);
      case _SceneMode.hitTestArena:
        return _hitTestArenaScene(scheme, progress);
      case _SceneMode.signalBoard:
        return _signalBoardScene(scheme, progress);
      case _SceneMode.analytics:
        return _analyticsScene(scheme, progress);
    }
  }

  Widget _introPadScene(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _pointerZone(scheme: scheme, zone: 'intro-left', title: 'Primary Pad', colorA: scheme.primary, colorB: scheme.secondary)),
                const SizedBox(width: 12),
                Expanded(child: _pointerZone(scheme: scheme, zone: 'intro-right', title: 'Secondary Pad', colorA: scheme.tertiary, colorB: scheme.primary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _pointerZone(scheme: scheme, zone: 'intro-mini-1', title: 'Mini A', colorA: scheme.secondary, colorB: scheme.tertiary)),
                const SizedBox(width: 12),
                Expanded(child: _pointerZone(scheme: scheme, zone: 'intro-mini-2', title: 'Mini B', colorA: scheme.primary, colorB: scheme.secondary)),
                const SizedBox(width: 12),
                Expanded(child: _pointerZone(scheme: scheme, zone: 'intro-mini-3', title: 'Mini C', colorA: scheme.tertiary, colorB: scheme.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hoverFieldScene(ColorScheme scheme, double progress) {
    final List<Widget> fields = <Widget>[];
    for (int i = 0; i < 12; i += 1) {
      final double x = 26 + (i % 4) * 260;
      final double y = 26 + (i ~/ 4) * 170;
      fields.add(
        Positioned(
          left: x,
          top: y,
          child: _pointerZone(
            scheme: scheme,
            zone: 'hover-$i',
            title: 'Hover Cell ${i + 1}',
            width: 236 * _padScale,
            height: 146 * _padScale,
            colorA: Color.lerp(scheme.primary, scheme.secondary, (i % 4) / 4)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, ((i + 2) % 5) / 5)!,
            labelMode: 'hover',
          ),
        ),
      );
    }
    return Stack(children: fields);
  }

  Widget _dragDeckScene(ColorScheme scheme, double progress) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _pointerZone(
                    scheme: scheme,
                    zone: 'drag-main',
                    title: 'Drag Surface',
                    colorA: scheme.primary,
                    colorB: scheme.secondary,
                    hint: 'Drag with finger/mouse to build trails',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _pointerZone(
                    scheme: scheme,
                    zone: 'drag-alt',
                    title: 'Alternate Surface',
                    colorA: scheme.tertiary,
                    colorB: scheme.primary,
                    hint: 'Try quick strokes and observe deltas',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _deviceCard(scheme: scheme, title: 'Mouse', value: '${_countByKind(PointerDeviceKind.mouse)} events', icon: Icons.mouse_outlined)),
                const SizedBox(width: 10),
                Expanded(child: _deviceCard(scheme: scheme, title: 'Touch', value: '${_countByKind(PointerDeviceKind.touch)} events', icon: Icons.pan_tool_outlined)),
                const SizedBox(width: 10),
                Expanded(child: _deviceCard(scheme: scheme, title: 'Stylus', value: '${_countByKind(PointerDeviceKind.stylus)} events', icon: Icons.edit_outlined)),
                const SizedBox(width: 10),
                Expanded(child: _deviceCard(scheme: scheme, title: 'Trackpad', value: '${_countByKind(PointerDeviceKind.trackpad)} events', icon: Icons.laptop_mac_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hitTestArenaScene(ColorScheme scheme, double progress) {
    final Color base = scheme.primary.withValues(alpha: 0.26);
    return Center(
      child: SizedBox(
        width: 840,
        height: 460,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (PointerDownEvent e) => _recordPointer(zone: 'arena-bottom', event: e, type: 'down'),
                onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: 'arena-bottom', event: e, type: 'move'),
                onPointerUp: (PointerUpEvent e) => _recordPointer(zone: 'arena-bottom', event: e, type: 'up'),
                onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: 'arena-bottom', event: e, type: 'hover'),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(20), border: Border.all(color: scheme.primary, width: 2)),
                  child: const Center(child: Text('Bottom translucent listener', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                ),
              ),
            ),
            Positioned(
              left: 110,
              top: 70,
              right: 110,
              bottom: 70,
              child: Listener(
                behavior: _behavior,
                onPointerDown: (PointerDownEvent e) => _recordPointer(zone: 'arena-middle', event: e, type: 'down'),
                onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: 'arena-middle', event: e, type: 'move'),
                onPointerUp: (PointerUpEvent e) => _recordPointer(zone: 'arena-middle', event: e, type: 'up'),
                onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: 'arena-middle', event: e, type: 'hover'),
                onPointerCancel: (PointerCancelEvent e) => _recordPointer(zone: 'arena-middle', event: e, type: 'cancel'),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[scheme.secondary.withValues(alpha: 0.88), scheme.tertiary.withValues(alpha: 0.88)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Middle listener', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                        const SizedBox(height: 6),
                        Text('behavior: ${_behavior.name}', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 250,
              top: 170,
              right: 250,
              bottom: 170,
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: (PointerDownEvent e) => _recordPointer(zone: 'arena-top', event: e, type: 'down'),
                onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: 'arena-top', event: e, type: 'move'),
                onPointerUp: (PointerUpEvent e) => _recordPointer(zone: 'arena-top', event: e, type: 'up'),
                onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: 'arena-top', event: e, type: 'hover'),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.38), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.66))),
                  child: const Center(child: Text('Top opaque listener', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                ),
              ),
            ),
            if (_showSignalHints)
              Positioned(
                right: 12,
                top: 12,
                child: _smallHint(
                  scheme,
                  'Pointer paths reveal which layer received events with each behavior mode.',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _signalBoardScene(ColorScheme scheme, double progress) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Listener(
              behavior: _behavior,
              onPointerSignal: (PointerSignalEvent e) => _recordPointer(zone: 'signal-main', event: e, type: 'signal'),
              onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: 'signal-main', event: e, type: 'hover'),
              onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: 'signal-main', event: e, type: 'move'),
              onPointerDown: (PointerDownEvent e) => _recordPointer(zone: 'signal-main', event: e, type: 'down'),
              onPointerUp: (PointerUpEvent e) => _recordPointer(zone: 'signal-main', event: e, type: 'up'),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _zoneOpacity), scheme.secondary.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(_zoneRoundness),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.52)),
                ),
                child: Stack(
                  children: <Widget>[
                    const Positioned(
                      left: 14,
                      top: 12,
                      child: Text('Signal Capture Surface', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                    ),
                    if (_showSignalHints)
                      Positioned(
                        right: 14,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(999)),
                          child: const Text('Use mouse wheel / trackpad scroll', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                        ),
                      ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('signalX=${_signalX.toStringAsFixed(1)} signalY=${_signalY.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                          const SizedBox(height: 8),
                          Text('signal events: $_signalCount', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: _pointerZone(
                    scheme: scheme,
                    zone: 'signal-side-a',
                    title: 'Support Zone A',
                    colorA: scheme.tertiary,
                    colorB: scheme.primary,
                    hint: 'Cross-check pointer and signal ordering',
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _pointerZone(
                    scheme: scheme,
                    zone: 'signal-side-b',
                    title: 'Support Zone B',
                    colorA: scheme.secondary,
                    colorB: scheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyticsScene(ColorScheme scheme, double progress) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _pointerZone(scheme: scheme, zone: 'analytics-main', title: 'Analytics Tap Zone', colorA: scheme.primary, colorB: scheme.secondary)),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.35))),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Interpreter Verification Focus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(height: 8),
                      const Text('1. Raw pointer streams arrive in ordered timeline', style: TextStyle(color: Colors.white70)),
                      const Text('2. HitTest behavior toggles observable routing changes', style: TextStyle(color: Colors.white70)),
                      const Text('3. Hover and signal channels remain distinct', style: TextStyle(color: Colors.white70)),
                      const Text('4. Event counters update predictably across devices', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 8),
                      Text('lastType=$_lastType lastKind=$_lastDeviceKind', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Listener(
              behavior: _behavior,
              onPointerDown: (PointerDownEvent e) => _recordPointer(zone: 'analytics-floor', event: e, type: 'down'),
              onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: 'analytics-floor', event: e, type: 'move'),
              onPointerUp: (PointerUpEvent e) => _recordPointer(zone: 'analytics-floor', event: e, type: 'up'),
              onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: 'analytics-floor', event: e, type: 'hover'),
              onPointerSignal: (PointerSignalEvent e) => _recordPointer(zone: 'analytics-floor', event: e, type: 'signal'),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[scheme.tertiary.withValues(alpha: 0.86), scheme.primary.withValues(alpha: 0.86)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
                ),
                child: const Center(
                  child: Text('Analytics Floor Listener', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pointerZone({
    required ColorScheme scheme,
    required String zone,
    required String title,
    required Color colorA,
    required Color colorB,
    double width = double.infinity,
    double height = double.infinity,
    String? hint,
    String labelMode = 'default',
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Listener(
        behavior: _behavior,
        onPointerDown: (PointerDownEvent e) => _recordPointer(zone: zone, event: e, type: 'down'),
        onPointerMove: (PointerMoveEvent e) => _recordPointer(zone: zone, event: e, type: 'move'),
        onPointerUp: (PointerUpEvent e) => _recordPointer(zone: zone, event: e, type: 'up'),
        onPointerCancel: (PointerCancelEvent e) => _recordPointer(zone: zone, event: e, type: 'cancel'),
        onPointerHover: (PointerHoverEvent e) => _recordPointer(zone: zone, event: e, type: 'hover'),
        onPointerSignal: (PointerSignalEvent e) => _recordPointer(zone: zone, event: e, type: 'signal'),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[colorA.withValues(alpha: _zoneOpacity), colorB.withValues(alpha: _zoneOpacity)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(_zoneRoundness),
            border: Border.all(color: Colors.white.withValues(alpha: 0.48), width: 1.6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                const SizedBox(height: 4),
                Text('behavior: ${_behavior.name}', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 12)),
                if (hint != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(hint, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
                const Spacer(),
                Text('events here: ${_countByZone(zone)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                if (labelMode == 'hover') Text('hover events: ${_countByZoneAndType(zone, 'hover')}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _deviceCard({required ColorScheme scheme, required String title, required String value, required IconData icon}) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700))),
              ],
            ),
            const Spacer(),
            Text(value, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _smallHint(ColorScheme scheme, String text) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }

  int _countByZone(String zone) {
    return _events.where(( _EventSample e) => e.zone == zone).length;
  }

  int _countByZoneAndType(String zone, String type) {
    return _events.where(( _EventSample e) => e.zone == zone && e.type == type).length;
  }

  int _countByKind(PointerDeviceKind kind) {
    return _events.where(( _EventSample e) => e.kind == kind.name).length;
  }

  Widget _buildBehaviorBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hit-Test Behavior Guide', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Behavior affects event routing in transparent and stacked regions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget a = _behaviorCard(
                  scheme: scheme,
                  title: 'opaque',
                  note: 'Always hit-test within bounds, even transparent areas.',
                  color: const Color(0xFF0F766E),
                );
                final Widget b = _behaviorCard(
                  scheme: scheme,
                  title: 'translucent',
                  note: 'Receives events and allows targets behind to also receive.',
                  color: const Color(0xFF1D4ED8),
                );
                final Widget c = _behaviorCard(
                  scheme: scheme,
                  title: 'deferToChild',
                  note: 'Only receives events when a child is hit.',
                  color: const Color(0xFFB45309),
                );
                if (narrow) {
                  return Column(children: <Widget>[a, const SizedBox(height: 10), b, const SizedBox(height: 10), c]);
                }
                return Row(children: <Widget>[Expanded(child: a), const SizedBox(width: 10), Expanded(child: b), const SizedBox(width: 10), Expanded(child: c)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _behaviorCard({required ColorScheme scheme, required String title, required String note, required Color color}) {
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
              height: 92,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.64))),
              child: Center(child: Text('active=${_behavior.name == title}', style: TextStyle(color: color, fontWeight: FontWeight.w800))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricTile> tiles = _buildMetrics();
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
                  itemCount: tiles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.75 : 2.06,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricTile tile = tiles[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(tile.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(tile.title, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(tile.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(tile.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 12),
            if (_showDiagnostics) _buildSnapshotPane(scheme),
          ],
        ),
      ),
    );
  }

  List<_MetricTile> _buildMetrics() {
    return <_MetricTile>[
      _MetricTile(title: 'Scene', value: _sceneSpecs[_sceneIndex].title, note: 'Active pointer demo scene.', icon: Icons.view_in_ar_outlined),
      _MetricTile(title: 'Theme', value: _pointerThemes[_themeIndex].name, note: 'Visual profile for current run.', icon: Icons.palette_outlined),
      _MetricTile(title: 'Behavior', value: _behavior.name, note: 'Current hit-test behavior.', icon: Icons.track_changes_outlined),
      _MetricTile(title: 'Stage Height', value: _stageHeight.toStringAsFixed(0), note: 'Height of interaction stage.', icon: Icons.height_outlined),
      _MetricTile(title: 'Counters', value: 'down=$_downCount move=$_moveCount up=$_upCount', note: 'Primary pointer event counts.', icon: Icons.countertops_outlined),
      _MetricTile(title: 'Secondary', value: 'hover=$_hoverCount cancel=$_cancelCount signal=$_signalCount', note: 'Hover/cancel/signal counts.', icon: Icons.insights_outlined),
      _MetricTile(title: 'Signal Drift', value: 'x=${_signalX.toStringAsFixed(1)} y=${_signalY.toStringAsFixed(1)}', note: 'Accumulated scroll signal totals.', icon: Icons.swipe_vertical_outlined),
      _MetricTile(title: 'Trails', value: '${_pointerTrails.length} pointers', note: 'Distinct pointer trail maps stored.', icon: Icons.timeline_outlined),
      _MetricTile(title: 'Hover Points', value: '${_hoverPoints.length}', note: 'Live hover points in view.', icon: Icons.blur_on_outlined),
      _MetricTile(title: 'Trail Config', value: 'max=$_maxTrailPoints fade=${_trailFade.toStringAsFixed(2)} width=${_trailThickness.toStringAsFixed(1)}', note: 'Trail visualization settings.', icon: Icons.gesture_outlined),
      _MetricTile(title: 'Changes', value: 'theme=$_themeChanges scene=$_sceneChanges behavior=$_behaviorChanges', note: 'Major mode switch counters.', icon: Icons.swap_horiz_outlined),
      _MetricTile(title: 'Edits', value: 'controls=$_controlEdits taps=$_stageTaps', note: 'Interaction edits and stage taps.', icon: Icons.tune_outlined),
      _MetricTile(title: 'Last Event', value: '$_lastType / $_lastDeviceKind', note: 'Most recent event channel and device kind.', icon: Icons.fiber_manual_record_outlined),
      _MetricTile(title: 'Last Position', value: '(${_lastLocal.dx.toStringAsFixed(1)}, ${_lastLocal.dy.toStringAsFixed(1)})', note: 'Latest local pointer coordinates.', icon: Icons.my_location_outlined),
      _MetricTile(title: 'Last Delta', value: '(${_lastDelta.dx.toStringAsFixed(1)}, ${_lastDelta.dy.toStringAsFixed(1)})', note: 'Latest pointer delta vector.', icon: Icons.open_with_outlined),
      _MetricTile(title: 'Snapshot', value: '${_snapshot.scene} ${_snapshot.behavior} active=${_snapshot.activePointerCount}', note: 'Current snapshot summary.', icon: Icons.camera_outlined),
      _MetricTile(title: 'Phase', value: _phase, note: 'Latest interaction phase.', icon: Icons.flag_outlined),
      _MetricTile(title: 'Event Log Size', value: '${_events.length}', note: 'Bounded timeline event count.', icon: Icons.list_alt_outlined),
    ];
  }

  Widget _buildSnapshotPane(ColorScheme scheme) {
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
                Text('Runtime Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('theme=${_pointerThemes[_themeIndex].id} scene=${_sceneSpecs[_sceneIndex].mode.name} behavior=${_behavior.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stage=${_stageHeight.toStringAsFixed(0)} trailFade=${_trailFade.toStringAsFixed(2)} trailThickness=${_trailThickness.toStringAsFixed(2)} maxTrail=$_maxTrailPoints', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('hoverStrength=${_hoverStrength.toStringAsFixed(2)} zoneRound=${_zoneRoundness.toStringAsFixed(1)} zoneOpacity=${_zoneOpacity.toStringAsFixed(2)} drift=${_drift.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('padScale=${_padScale.toStringAsFixed(2)} signalGain=${_signalGain.toStringAsFixed(2)} signalX=${_signalX.toStringAsFixed(1)} signalY=${_signalY.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags animate=$_animate grid=$_showGrid trail=$_showTrail hover=$_showHoverHeat coords=$_showRawCoordinates signal=$_showSignalHints', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('counts down=$_downCount move=$_moveCount up=$_upCount cancel=$_cancelCount hover=$_hoverCount signal=$_signalCount', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            ..._guideItems.map((String line) {
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
            ..._faqEntries.map(( _FaqEntry entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(entry.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(entry.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                TextButton.icon(
                  onPressed: () => setState(() => _events = const <_EventSample>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological raw pointer events recorded by Listener zones.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_events.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with the stage to capture events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _events.take(40).map(( _EventSample e) {
                  final String ts = '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}:${e.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(e.type.characters.first.toUpperCase(), style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                      ),
                      title: Text('${e.zone}  |  ${e.type} (${e.kind})', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
                      subtitle: Text(
                        '$ts  local=(${e.local.dx.toStringAsFixed(1)}, ${e.local.dy.toStringAsFixed(1)}) delta=(${e.delta.dx.toStringAsFixed(1)}, ${e.delta.dy.toStringAsFixed(1)}) buttons=${e.buttons} pointer=${e.pointer}',
                        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                      ),
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

class _StageGridPainter extends CustomPainter {
  const _StageGridPainter({required this.progress, required this.drift});

  final double progress;
  final double drift;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF22C55E), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF2563EB), const Color(0xFF7C3AED), drift)!,
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
    const double step = 26;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _StageGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}

class _TrailPainter extends CustomPainter {
  const _TrailPainter({
    required this.trails,
    required this.fade,
    required this.thickness,
    required this.pulse,
  });

  final Map<int, List<Offset>> trails;
  final double fade;
  final double thickness;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> palette = <Color>[
      const Color(0xFF22D3EE),
      const Color(0xFF34D399),
      const Color(0xFFF59E0B),
      const Color(0xFFF43F5E),
      const Color(0xFFA78BFA),
      const Color(0xFF60A5FA),
    ];

    int index = 0;
    for (final List<Offset> points in trails.values) {
      if (points.length < 2) {
        index += 1;
        continue;
      }
      final Color c = palette[index % palette.length].withValues(alpha: fade * (0.7 + 0.3 * math.sin(pulse * math.pi * 2 + index)));
      final Paint paint = Paint()
        ..color = c
        ..strokeWidth = thickness
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final Path path = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i += 1) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
      index += 1;
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter oldDelegate) {
    return oldDelegate.trails != trails || oldDelegate.fade != fade || oldDelegate.thickness != thickness || oldDelegate.pulse != pulse;
  }
}

class _HoverHeatPainter extends CustomPainter {
  const _HoverHeatPainter({required this.points, required this.strength});

  final List<Offset> points;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Offset p in points) {
      final Rect rect = Rect.fromCircle(center: p, radius: 42);
      final Paint glow = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFF38BDF8).withValues(alpha: 0.22 + strength * 0.5),
            const Color(0xFF38BDF8).withValues(alpha: 0),
          ],
        ).createShader(rect);
      canvas.drawCircle(p, 42, glow);
      canvas.drawCircle(
        p,
        4,
        Paint()..color = Colors.white.withValues(alpha: 0.8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HoverHeatPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.strength != strength;
  }
}
