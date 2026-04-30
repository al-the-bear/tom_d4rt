import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'harbor',
    name: 'Harbor Ops',
    description: 'Balanced tones for layering and clipping diagnostics.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'sunset',
    name: 'Sunset Surface',
    description: 'Warm profile for embed lifecycle and hit-testing studies.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Glass',
    description: 'Dark profile for contrast-heavy composition checks.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(id: _ScenarioMode.lifecycle, title: 'Lifecycle', subtitle: 'Creation, attach, detach, and focus-state simulation for Darwin platform views.'),
  _Scenario(id: _ScenarioMode.composition, title: 'Composition', subtitle: 'Texture/hybrid layering concepts with Flutter overlays.'),
  _Scenario(id: _ScenarioMode.gestures, title: 'Gestures', subtitle: 'Gesture arbitration and event tunneling around platform view regions.'),
  _Scenario(id: _ScenarioMode.transforms, title: 'Transforms', subtitle: 'Clip, transform, and opacity effects around embedded surfaces.'),
  _Scenario(id: _ScenarioMode.safeArea, title: 'Safe Areas', subtitle: 'Insets, notches, and host container constraints for native surfaces.'),
];

const List<String> _guideBullets = <String>[
  'RenderDarwinPlatformView is the render backend for Darwin-hosted platform view widgets.',
  'UiKitView is the high-level widget used to embed native iOS views in Flutter.',
  'Embedding platform views introduces composition and gesture-routing trade-offs.',
  'Use clipping and transforms carefully because native surfaces have platform constraints.',
  'Focus and lifecycle transitions should be visualized and logged for troubleshooting.',
  'Hybrid composition and texture-like paths can differ in performance and z-order behavior.',
  'Always provide graceful non-Darwin fallbacks in cross-platform demos and development tools.',
  'Overlay diagnostics are valuable to reason about coordinate transforms and hit regions.',
  'Safe-area and insets handling is crucial when embedding full-bleed native content.',
  'Keep host contracts explicit: viewType, creation params, gesture policy, and lifecycle events.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'When should I use UiKitView?',
    answer: 'Use it to embed existing native iOS views that are hard or costly to reimplement in Flutter.',
  ),
  _FaqItem(
    question: 'Can I run Darwin platform views on non-Darwin hosts?',
    answer: 'No real native view will mount there; provide a visual fallback and keep flow testable.',
  ),
  _FaqItem(
    question: 'Why are gestures tricky with platform views?',
    answer: 'Gesture recognizers may compete between Flutter and the embedded native surface.',
  ),
  _FaqItem(
    question: 'What should I log during integration?',
    answer: 'Lifecycle events, focus changes, composition mode switches, and geometry updates.',
  ),
  _FaqItem(
    question: 'How do I keep layouts reliable?',
    answer: 'Track host constraints, safe insets, and transformation boundaries in diagnostics overlays.',
  ),
];

enum _ScenarioMode {
  lifecycle,
  composition,
  gestures,
  transforms,
  safeArea,
}

enum _CompositionMode {
  textureLike,
  hybridLike,
}

enum _LifecycleStage {
  idle,
  creating,
  attached,
  focused,
  detached,
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

class _TimelineEvent {
  const _TimelineEvent({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

class _MetricEntry {
  const _MetricEntry({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _Snapshot {
  const _Snapshot({
    required this.lifecycle,
    required this.composition,
    required this.hostSize,
    required this.probe,
  });

  final String lifecycle;
  final String composition;
  final Size hostSize;
  final Offset probe;
}

dynamic build(BuildContext context) {
  return const _RenderDarwinPlatformViewStudio();
}

class _RenderDarwinPlatformViewStudio extends StatefulWidget {
  const _RenderDarwinPlatformViewStudio();

  @override
  State<_RenderDarwinPlatformViewStudio> createState() => _RenderDarwinPlatformViewStudioState();
}

class _RenderDarwinPlatformViewStudioState extends State<_RenderDarwinPlatformViewStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scroll = ScrollController();

  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8400),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _CompositionMode _compositionMode = _CompositionMode.hybridLike;
  _LifecycleStage _lifecycle = _LifecycleStage.idle;

  double _hostWidth = 760;
  double _hostHeight = 390;
  double _safeTop = 20;
  double _safeRight = 12;
  double _safeBottom = 16;
  double _safeLeft = 12;
  double _overlayOpacity = 0.42;
  double _transformRotation = 0;
  double _transformScale = 1;
  double _borderRadius = 18;
  double _zOverlay = 0.54;
  double _textureDensity = 0.38;

  bool _animate = true;
  bool _showGrid = true;
  bool _showBounds = true;
  bool _showSafeArea = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showProbe = true;
  bool _showRealMount = true;

  int _scenarioSwitches = 0;
  int _themeSwitches = 0;
  int _compositionSwitches = 0;
  int _lifecycleChanges = 0;
  int _tapCount = 0;
  int _controlEdits = 0;

  String _phase = 'idle';
  Offset _probe = const Offset(0.5, 0.5);

  _Snapshot _snapshot = const _Snapshot(
    lifecycle: 'idle',
    composition: 'hybridLike',
    hostSize: Size.zero,
    probe: Offset(0.5, 0.5),
  );

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  bool get _isDarwinHost {
    final TargetPlatform platform = defaultTargetPlatform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'Darwin platform-view studio initialized.');
    });
  }

  @override
  void dispose() {
    _motion.dispose();
    _scroll.dispose();
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

  void _bumpControl() {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
  }

  void _reset() {
    setState(() {
      _scenarioIndex = 0;
      _compositionMode = _CompositionMode.hybridLike;
      _lifecycle = _LifecycleStage.idle;
      _hostWidth = 760;
      _hostHeight = 390;
      _safeTop = 20;
      _safeRight = 12;
      _safeBottom = 16;
      _safeLeft = 12;
      _overlayOpacity = 0.42;
      _transformRotation = 0;
      _transformScale = 1;
      _borderRadius = 18;
      _zOverlay = 0.54;
      _textureDensity = 0.38;
      _animate = true;
      _showGrid = true;
      _showBounds = true;
      _showSafeArea = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showProbe = true;
      _showRealMount = true;
      _phase = 'reset';
      _probe = const Offset(0.5, 0.5);
      _timeline = const <_TimelineEvent>[];
      _snapshot = const _Snapshot(
        lifecycle: 'idle',
        composition: 'hybridLike',
        hostSize: Size.zero,
        probe: Offset(0.5, 0.5),
      );
    });
    _motion.repeat();
    _pushTimeline('Reset', 'Studio values returned to defaults.');
  }

  void _setToggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'animate':
          _animate = next;
          break;
        case 'grid':
          _showGrid = next;
          break;
        case 'bounds':
          _showBounds = next;
          break;
        case 'safe':
          _showSafeArea = next;
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
        case 'probe':
          _showProbe = next;
          break;
        case 'real':
          _showRealMount = next;
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

  void _setLifecycle(_LifecycleStage stage) {
    setState(() {
      _lifecycle = stage;
      _lifecycleChanges += 1;
      _phase = 'lifecycle';
    });
    _pushTimeline('Lifecycle', 'Lifecycle switched to ${stage.name}.');
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
            child: Scrollbar(
              controller: _scroll,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scroll,
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
                        _buildHostStageBoard(scheme),
                        const SizedBox(height: 14),
                        _buildLifecycleBoard(scheme),
                        const SizedBox(height: 14),
                        _buildCompositionBoard(scheme),
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
                Icon(Icons.smart_display_outlined, color: scheme.primary, size: 26),
                Text('RenderDarwinPlatformView Host Composition Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Visual deep demo for embedding Darwin platform views: lifecycle, composition layering, gesture routing, transforms, and safe-area integration with Flutter overlays.',
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
                Text('Host Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Control native host region, overlay behavior, transform, insets, and composition mode.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Host Width',
              value: _hostWidth,
              min: 440,
              max: 1120,
              divisions: 340,
              onChanged: (double v) => setState(() => _hostWidth = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Host Width', 'Set host width to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Host Height',
              value: _hostHeight,
              min: 240,
              max: 680,
              divisions: 220,
              onChanged: (double v) => setState(() => _hostHeight = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Host Height', 'Set host height to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Safe Top',
              value: _safeTop,
              min: 0,
              max: 120,
              divisions: 120,
              onChanged: (double v) => setState(() => _safeTop = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Safe Top', 'Set top inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Safe Right',
              value: _safeRight,
              min: 0,
              max: 120,
              divisions: 120,
              onChanged: (double v) => setState(() => _safeRight = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Safe Right', 'Set right inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Safe Bottom',
              value: _safeBottom,
              min: 0,
              max: 120,
              divisions: 120,
              onChanged: (double v) => setState(() => _safeBottom = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Safe Bottom', 'Set bottom inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Safe Left',
              value: _safeLeft,
              min: 0,
              max: 120,
              divisions: 120,
              onChanged: (double v) => setState(() => _safeLeft = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Safe Left', 'Set left inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Overlay Opacity',
              value: _overlayOpacity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _overlayOpacity = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Overlay', 'Set overlay opacity to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Rotation',
              value: _transformRotation,
              min: -25,
              max: 25,
              divisions: 100,
              onChanged: (double v) => setState(() => _transformRotation = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Transform', 'Set rotation to ${v.toStringAsFixed(1)} deg.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Scale',
              value: _transformScale,
              min: 0.6,
              max: 1.4,
              divisions: 80,
              onChanged: (double v) => setState(() => _transformScale = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Transform', 'Set scale to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Border Radius',
              value: _borderRadius,
              min: 0,
              max: 56,
              divisions: 56,
              onChanged: (double v) => setState(() => _borderRadius = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Clip', 'Set border radius to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Overlay Z Bias',
              value: _zOverlay,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _zOverlay = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Z Overlay', 'Set overlay bias to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Texture Density',
              value: _textureDensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _textureDensity = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Texture', 'Set texture density to ${v.toStringAsFixed(2)}.');
              },
            ),
            const SizedBox(height: 8),
            Text('Composition Mode', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _CompositionMode.values.map(( _CompositionMode mode) {
                return ChoiceChip(
                  selected: _compositionMode == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _compositionMode = mode;
                      _compositionSwitches += 1;
                      _phase = 'composition';
                    });
                    _pushTimeline('Composition', 'Composition mode switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _setToggle('animate', v), child: const Text('Animate surface')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _setToggle('grid', v), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showBounds, onChanged: (bool? v) => _setToggle('bounds', v), child: const Text('Show host bounds')),
                CheckboxMenuButton(value: _showSafeArea, onChanged: (bool? v) => _setToggle('safe', v), child: const Text('Show safe-area guides')),
                CheckboxMenuButton(value: _showProbe, onChanged: (bool? v) => _setToggle('probe', v), child: const Text('Show probe marker')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _setToggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _setToggle('guide', v), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _setToggle('timeline', v), child: const Text('Show timeline board')),
                CheckboxMenuButton(value: _showRealMount, onChanged: (bool? v) => _setToggle('real', v), child: const Text('Show real UiKitView lane')),
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

  Widget _buildHostStageBoard(ColorScheme scheme) {
    final double motion = _animate ? _motion.value : 0;
    final double radians = _transformRotation * math.pi / 180;

    final _Snapshot snap = _Snapshot(
      lifecycle: _lifecycle.name,
      composition: _compositionMode.name,
      hostSize: Size(_hostWidth, _hostHeight),
      probe: _probe,
    );
    _snapshot = snap;

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Host Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Visual host surface showing layered Flutter content around a Darwin platform-view region.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final Offset local = details.localPosition;
                  setState(() {
                    _probe = Offset((local.dx / _hostWidth).clamp(0.0, 1.0), (local.dy / _hostHeight).clamp(0.0, 1.0));
                    _tapCount += 1;
                    _phase = 'stage-tap';
                  });
                  _pushTimeline('Probe', 'Probe moved to ${_probe.dx.toStringAsFixed(2)}, ${_probe.dy.toStringAsFixed(2)}.');
                },
                child: SizedBox(
                  width: _hostWidth,
                  height: _hostHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: Transform.rotate(
                      angle: radians,
                      child: Transform.scale(
                        scale: _transformScale,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            CustomPaint(
                              painter: _BackdropPainter(
                                progress: motion,
                                density: _textureDensity,
                                showGrid: _showGrid,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(_safeLeft, _safeTop, _safeRight, _safeBottom),
                              child: _buildNativeSurfaceLane(scheme),
                            ),
                            Positioned.fill(
                              child: IgnorePointer(
                                child: CustomPaint(
                                  painter: _OverlayPainter(
                                    opacity: _overlayOpacity,
                                    showBounds: _showBounds,
                                    showSafe: _showSafeArea,
                                    showProbe: _showProbe,
                                    probe: _probe,
                                    insets: EdgeInsets.fromLTRB(_safeLeft, _safeTop, _safeRight, _safeBottom),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment(0, (0.8 - (_zOverlay * 1.6)).clamp(-1.0, 1.0)),
                                child: IgnorePointer(
                                  child: Container(
                                    width: _hostWidth * 0.62,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: (0.22 + (_zOverlay * 0.34)).clamp(0.05, 0.56)),
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(color: Colors.white.withValues(alpha: 0.42)),
                                    ),
                                    child: const Center(
                                      child: Text('Flutter Overlay HUD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _pill('lifecycle ${_lifecycle.name}'),
                _pill('composition ${_compositionMode.name}'),
                _pill('host ${_hostWidth.toStringAsFixed(0)}x${_hostHeight.toStringAsFixed(0)}'),
                _pill('probe ${_probe.dx.toStringAsFixed(2)},${_probe.dy.toStringAsFixed(2)}'),
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
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildNativeSurfaceLane(ColorScheme scheme) {
    if (_showRealMount && _isDarwinHost) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: scheme.outlineVariant),
          color: scheme.surfaceContainerHighest,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const UiKitView(viewType: 'demo.darwin.surface', creationParamsCodec: StandardMessageCodec()),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(999)),
                child: const Text('Real UiKitView lane', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
              ),
            ),
          ],
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: 0.22), scheme.secondary.withValues(alpha: 0.20)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _FallbackTexturePainter(density: _textureDensity)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.phone_iphone_outlined, size: 44, color: scheme.primary),
                const SizedBox(height: 8),
                Text('Darwin Platform View Fallback', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  _showRealMount
                      ? 'Real UiKitView is only mountable on Darwin hosts.'
                      : 'Real mount lane disabled. Showing simulated native surface.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Lifecycle Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Drive lifecycle states and observe logging behavior for embed flows.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _LifecycleStage.values.map(( _LifecycleStage stage) {
                return ChoiceChip(
                  selected: _lifecycle == stage,
                  label: Text(stage.name),
                  onSelected: (_) => _setLifecycle(stage),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            DecoratedBox(
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
                    Text('Current Stage: ${_lifecycle.name}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(_lifecycleExplanation(_lifecycle), style: TextStyle(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _lifecycleExplanation(_LifecycleStage stage) {
    switch (stage) {
      case _LifecycleStage.idle:
        return 'No platform view attached yet. Host container is ready for allocation.';
      case _LifecycleStage.creating:
        return 'Native view creation requested; channel negotiation and host resource allocation in progress.';
      case _LifecycleStage.attached:
        return 'Native surface attached to render tree and participating in composition.';
      case _LifecycleStage.focused:
        return 'Platform view has input focus; gesture routing prioritizes native interaction region.';
      case _LifecycleStage.detached:
        return 'View detached and resources should be released or pooled for future reuse.';
    }
  }

  Widget _buildCompositionBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Composition Comparison', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Compare host composition strategies and their interaction with Flutter overlays.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget texture = _comparisonCard(
                  scheme: scheme,
                  title: 'Texture-like',
                  subtitle: 'Flutter texture path with simpler overlay blending semantics.',
                  color: const Color(0xFF1D4ED8),
                  icon: Icons.texture_outlined,
                );
                final Widget hybrid = _comparisonCard(
                  scheme: scheme,
                  title: 'Hybrid-like',
                  subtitle: 'Native view composited in host hierarchy with robust interop.',
                  color: const Color(0xFF0F766E),
                  icon: Icons.layers_outlined,
                );
                final Widget fallback = _comparisonCard(
                  scheme: scheme,
                  title: 'Fallback Mock',
                  subtitle: 'Cross-platform stand-in for visual validation in non-Darwin runs.',
                  color: const Color(0xFFB45309),
                  icon: Icons.integration_instructions_outlined,
                );
                if (narrow) {
                  return Column(children: <Widget>[texture, const SizedBox(height: 10), hybrid, const SizedBox(height: 10), fallback]);
                }
                return Row(children: <Widget>[Expanded(child: texture), const SizedBox(width: 10), Expanded(child: hybrid), const SizedBox(width: 10), Expanded(child: fallback)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required Color color, required IconData icon}) {
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
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.62)),
              ),
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
                    childAspectRatio: columns == 1 ? 2.75 : 2.05,
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
      _MetricEntry(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active host exploration lane.', icon: Icons.route_outlined),
      _MetricEntry(label: 'Theme', value: _themes[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Lifecycle', value: _lifecycle.name, note: 'Embed lifecycle stage.', icon: Icons.settings_ethernet_outlined),
      _MetricEntry(label: 'Composition', value: _compositionMode.name, note: 'Layering strategy model.', icon: Icons.layers_outlined),
      _MetricEntry(label: 'Host', value: '${_hostWidth.toStringAsFixed(0)} x ${_hostHeight.toStringAsFixed(0)}', note: 'Host region dimensions.', icon: Icons.crop_square_outlined),
      _MetricEntry(label: 'Safe Insets', value: '${_safeTop.toStringAsFixed(0)}, ${_safeRight.toStringAsFixed(0)}, ${_safeBottom.toStringAsFixed(0)}, ${_safeLeft.toStringAsFixed(0)}', note: 'Top, right, bottom, left insets.', icon: Icons.safety_check_outlined),
      _MetricEntry(label: 'Transform', value: '${_transformRotation.toStringAsFixed(1)} deg @ ${_transformScale.toStringAsFixed(2)}', note: 'Rotation and scale around host stage.', icon: Icons.transform_outlined),
      _MetricEntry(label: 'Overlay', value: '${_overlayOpacity.toStringAsFixed(2)} / ${_zOverlay.toStringAsFixed(2)}', note: 'Opacity and z-bias for Flutter HUD.', icon: Icons.filter_none_outlined),
      _MetricEntry(label: 'Probe', value: '${_probe.dx.toStringAsFixed(2)}, ${_probe.dy.toStringAsFixed(2)}', note: 'Last interaction point in normalized coordinates.', icon: Icons.pin_drop_outlined),
      _MetricEntry(label: 'Switches', value: 'scenario=$_scenarioSwitches theme=$_themeSwitches', note: 'Scenario and theme changes.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Lifecycle Changes', value: '$_lifecycleChanges', note: 'Lifecycle stage transitions.', icon: Icons.loop_outlined),
      _MetricEntry(label: 'Composition Changes', value: '$_compositionSwitches', note: 'Composition mode transitions.', icon: Icons.view_stream_outlined),
      _MetricEntry(label: 'Control Edits', value: '$_controlEdits', note: 'Slider and toggle updates.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Stage Taps', value: '$_tapCount', note: 'Probe interactions on host stage.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Darwin Host', value: _isDarwinHost ? 'yes' : 'no', note: 'Whether true Darwin mount is possible.', icon: Icons.phone_iphone_outlined),
      _MetricEntry(label: 'Real Mount Lane', value: _showRealMount ? 'enabled' : 'disabled', note: 'Toggle for real UiKitView attempt.', icon: Icons.integration_instructions_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Most recent interaction class.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Snapshot', value: '${_snapshot.lifecycle} / ${_snapshot.composition}', note: 'Latest stage snapshot.', icon: Icons.camera_outlined),
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
            Text('theme=${_themes[_themeIndex].id} scenario=${_scenarios[_scenarioIndex].id.name} phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('lifecycle=${_lifecycle.name} composition=${_compositionMode.name} hostDarwin=$_isDarwinHost', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('host=${_hostWidth.toStringAsFixed(0)}x${_hostHeight.toStringAsFixed(0)} insets=${_safeTop.toStringAsFixed(0)},${_safeRight.toStringAsFixed(0)},${_safeBottom.toStringAsFixed(0)},${_safeLeft.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('transform rot=${_transformRotation.toStringAsFixed(1)} scale=${_transformScale.toStringAsFixed(2)} radius=${_borderRadius.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('overlay opacity=${_overlayOpacity.toStringAsFixed(2)} z=${_zOverlay.toStringAsFixed(2)} texture=${_textureDensity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('probe=${_probe.dx.toStringAsFixed(2)},${_probe.dy.toStringAsFixed(2)} switches s=$_scenarioSwitches t=$_themeSwitches c=$_compositionSwitches l=$_lifecycleChanges', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological stream of lifecycle, composition, and host interaction events.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _BackdropPainter extends CustomPainter {
  const _BackdropPainter({required this.progress, required this.density, required this.showGrid});

  final double progress;
  final double density;
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF22C55E), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF8B5CF6), const Color(0xFF3B82F6), (math.cos(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.sin(progress * math.pi * 4) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.17)
      ..strokeWidth = 1;
    final double step = (28 - (density * 18)).clamp(7, 28);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), stripe);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white.withValues(alpha: 0.14)
        ..strokeWidth = 1;
      const double g = 24;
      for (double x = 0; x <= size.width; x += g) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += g) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.density != density || oldDelegate.showGrid != showGrid;
  }
}

class _OverlayPainter extends CustomPainter {
  const _OverlayPainter({
    required this.opacity,
    required this.showBounds,
    required this.showSafe,
    required this.showProbe,
    required this.probe,
    required this.insets,
  });

  final double opacity;
  final bool showBounds;
  final bool showSafe;
  final bool showProbe;
  final Offset probe;
  final EdgeInsets insets;

  @override
  void paint(Canvas canvas, Size size) {
    if (showBounds) {
      final Paint border = Paint()
        ..color = Colors.white.withValues(alpha: (0.58 * opacity).clamp(0.08, 0.60))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawRect(Offset.zero & size, border);
    }

    if (showSafe) {
      final Rect safeRect = Rect.fromLTWH(
        insets.left,
        insets.top,
        size.width - insets.horizontal,
        size.height - insets.vertical,
      );
      final Paint fill = Paint()
        ..color = Colors.white.withValues(alpha: (0.10 * opacity).clamp(0.02, 0.14))
        ..style = PaintingStyle.fill;
      final Paint stroke = Paint()
        ..color = Colors.white.withValues(alpha: (0.66 * opacity).clamp(0.08, 0.70))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawRect(safeRect, fill);
      canvas.drawRect(safeRect, stroke);
    }

    if (showProbe) {
      final Offset p = Offset(size.width * probe.dx, size.height * probe.dy);
      final Paint ring = Paint()
        ..color = Colors.white.withValues(alpha: 0.88)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(p, 11, ring);
      canvas.drawLine(Offset(p.dx - 15, p.dy), Offset(p.dx + 15, p.dy), ring);
      canvas.drawLine(Offset(p.dx, p.dy - 15), Offset(p.dx, p.dy + 15), ring);
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.opacity != opacity ||
        oldDelegate.showBounds != showBounds ||
        oldDelegate.showSafe != showSafe ||
        oldDelegate.showProbe != showProbe ||
        oldDelegate.probe != probe ||
        oldDelegate.insets != insets;
  }
}

class _FallbackTexturePainter extends CustomPainter {
  const _FallbackTexturePainter({required this.density});

  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.20)
      ..strokeWidth = 1;
    final double step = (22 - (density * 14)).clamp(6, 22);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FallbackTexturePainter oldDelegate) {
    return oldDelegate.density != density;
  }
}
