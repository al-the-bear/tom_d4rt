import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePack> _themePacks = <_ThemePack>[
  _ThemePack(
    id: 'ocean',
    name: 'Ocean Pipeline',
    subtitle: 'Cool tones for tracing modifier stages and child proxies.',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
  ),
  _ThemePack(
    id: 'amber',
    name: 'Amber Layers',
    subtitle: 'Warm profile for visualizing depth and filter interactions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePack(
    id: 'graphite',
    name: 'Graphite Stack',
    subtitle: 'Dark profile for strong proxy contrast and diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ScenarioPack> _scenarioPacks = <_ScenarioPack>[
  _ScenarioPack(
    mode: _ScenarioMode.pipeline,
    title: 'Pipeline Lane',
    subtitle: 'Sequential proxy modifiers around one child node.',
  ),
  _ScenarioPack(
    mode: _ScenarioMode.chainGrid,
    title: 'Chain Grid',
    subtitle: 'Multiple modifier chains comparing wrapper combinations.',
  ),
  _ScenarioPack(
    mode: _ScenarioMode.overlayLab,
    title: 'Overlay Lab',
    subtitle: 'Proxy wrappers with overlay, clip, and alignment routing.',
  ),
  _ScenarioPack(
    mode: _ScenarioMode.interactionDeck,
    title: 'Interaction Deck',
    subtitle: 'Pointer and semantics guard wrappers in layered layouts.',
  ),
  _ScenarioPack(
    mode: _ScenarioMode.performanceBoard,
    title: 'Performance Board',
    subtitle: 'Repaint and transform style wrappers with visual markers.',
  ),
  _ScenarioPack(
    mode: _ScenarioMode.analytics,
    title: 'Analytics',
    subtitle: 'Guided metrics and snapshot traces for proxy behavior.',
  ),
];

const List<String> _guideNotes = <String>[
  'RenderProxyBoxMixin is a render-layer pattern for render objects that wrap exactly one child.',
  'Many widgets indirectly use proxy-box behavior: padding, transform, opacity, clip, semantics, and pointer guards.',
  'Proxy wrappers modify layout, paint, hit testing, or semantics while forwarding child responsibility.',
  'A modifier chain can be understood as stacked proxy layers around one core child widget.',
  'The order of wrappers matters: transform before clip differs from clip before transform.',
  'Visual demos should isolate each modifier and then show combinations for clarity.',
  'Use diagnostics to track which stages are active and what they changed.',
  'Proxy wrappers are great for reusable behavior composition without changing child internals.',
  'Avoid over-stacking wrappers without purpose; pipeline complexity can reduce maintainability.',
  'Side-by-side compare boards help teach when to apply specific proxy modifications.',
];

const List<_Faq> _faqItems = <_Faq>[
  _Faq(
    question: 'What is RenderProxyBoxMixin in practice?',
    answer: 'It is the foundational single-child render object pattern used by many modifier-style widgets.',
  ),
  _Faq(
    question: 'Why use wrapper chains?',
    answer: 'Chains let you combine orthogonal behaviors such as padding, clip, opacity, and transforms safely.',
  ),
  _Faq(
    question: 'How do I choose wrapper order?',
    answer: 'Start from desired layout impact, then paint effects, then hit-test semantics; verify visually.',
  ),
  _Faq(
    question: 'Can wrappers affect interaction?',
    answer: 'Yes, pointer and semantics proxy wrappers can alter event routing and accessibility behavior.',
  ),
  _Faq(
    question: 'How should I debug proxy stacks?',
    answer: 'Use stage labels, snapshots, and compare lanes that isolate each active modifier.',
  ),
];

enum _ScenarioMode {
  pipeline,
  chainGrid,
  overlayLab,
  interactionDeck,
  performanceBoard,
  analytics,
}

class _ThemePack {
  const _ThemePack({
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

class _ScenarioPack {
  const _ScenarioPack({required this.mode, required this.title, required this.subtitle});

  final _ScenarioMode mode;
  final String title;
  final String subtitle;
}

class _Faq {
  const _Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _Metric {
  const _Metric({required this.title, required this.value, required this.note, required this.icon});

  final String title;
  final String value;
  final String note;
  final IconData icon;
}

class _Event {
  const _Event({required this.time, required this.action, required this.stage, required this.note});

  final DateTime time;
  final String action;
  final String stage;
  final String note;
}

class _Snapshot {
  const _Snapshot({
    required this.scenario,
    required this.wrapperCount,
    required this.stage,
    required this.opacity,
  });

  final String scenario;
  final int wrapperCount;
  final String stage;
  final double opacity;
}

dynamic build(BuildContext context) {
  return const _RenderProxyBoxMixinStudio();
}

class _RenderProxyBoxMixinStudio extends StatefulWidget {
  const _RenderProxyBoxMixinStudio();

  @override
  State<_RenderProxyBoxMixinStudio> createState() => _RenderProxyBoxMixinStudioState();
}

class _RenderProxyBoxMixinStudioState extends State<_RenderProxyBoxMixinStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9200),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  bool _animate = true;
  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showLabels = true;
  bool _showShadow = true;
  bool _showClip = true;
  bool _showBorder = true;
  bool _allowInteraction = true;
  bool _showSemanticsHint = true;

  bool _usePadding = true;
  bool _useAlign = true;
  bool _useTransform = true;
  bool _useOpacity = true;
  bool _useClip = true;
  bool _useDecorated = true;
  bool _useConstrained = true;
  bool _usePointerGuard = false;

  double _stageHeight = 580;
  double _padding = 16;
  double _opacity = 0.88;
  double _rotationTurns = 0.02;
  double _scale = 1.0;
  double _translateX = 0;
  double _translateY = 0;
  double _clipRadius = 22;
  double _cardRadius = 18;
  double _shadowAlpha = 0.32;
  double _drift = 0.34;
  double _borderWidth = 1.8;
  double _minWidth = 180;
  double _minHeight = 120;

  int _themeChanges = 0;
  int _scenarioChanges = 0;
  int _controlEdits = 0;
  int _tapCount = 0;
  int _wrapperInteractions = 0;

  String _phase = 'idle';
  String _lastAction = 'none';

  _Snapshot _snapshot = const _Snapshot(scenario: 'pipeline', wrapperCount: 0, stage: 'idle', opacity: 0.88);
  List<_Event> _events = const <_Event>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _log('init', 'studio', 'RenderProxyBoxMixin studio initialized.');
    });
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  void _log(String action, String stage, String note) {
    setState(() {
      _lastAction = action;
      _events = <_Event>[
        _Event(time: DateTime.now(), action: action, stage: stage, note: note),
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
        case 'labels':
          _showLabels = next;
          break;
        case 'shadow':
          _showShadow = next;
          break;
        case 'clip':
          _showClip = next;
          break;
        case 'border':
          _showBorder = next;
          break;
        case 'interaction':
          _allowInteraction = next;
          break;
        case 'semantics':
          _showSemanticsHint = next;
          break;
        case 'paddingWrapper':
          _usePadding = next;
          break;
        case 'alignWrapper':
          _useAlign = next;
          break;
        case 'transformWrapper':
          _useTransform = next;
          break;
        case 'opacityWrapper':
          _useOpacity = next;
          break;
        case 'clipWrapper':
          _useClip = next;
          break;
        case 'decoratedWrapper':
          _useDecorated = next;
          break;
        case 'constrainedWrapper':
          _useConstrained = next;
          break;
        case 'pointerWrapper':
          _usePointerGuard = next;
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
    _log('toggle:$key', 'control', '$next');
  }

  void _onSlider(String name, double value) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _log('slider:$name', 'control', value.toStringAsFixed(2));
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _animate = true;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showLabels = true;
      _showShadow = true;
      _showClip = true;
      _showBorder = true;
      _allowInteraction = true;
      _showSemanticsHint = true;
      _usePadding = true;
      _useAlign = true;
      _useTransform = true;
      _useOpacity = true;
      _useClip = true;
      _useDecorated = true;
      _useConstrained = true;
      _usePointerGuard = false;
      _stageHeight = 580;
      _padding = 16;
      _opacity = 0.88;
      _rotationTurns = 0.02;
      _scale = 1.0;
      _translateX = 0;
      _translateY = 0;
      _clipRadius = 22;
      _cardRadius = 18;
      _shadowAlpha = 0.32;
      _drift = 0.34;
      _borderWidth = 1.8;
      _minWidth = 180;
      _minHeight = 120;
      _phase = 'reset';
      _tapCount = 0;
      _wrapperInteractions = 0;
      _events = const <_Event>[];
      _lastAction = 'reset';
      _snapshot = const _Snapshot(scenario: 'pipeline', wrapperCount: 0, stage: 'reset', opacity: 0.88);
    });
    _clock.repeat();
    _log('reset', 'system', 'Studio reset to defaults');
  }

  int get _wrapperCount {
    int count = 0;
    if (_usePadding) count += 1;
    if (_useAlign) count += 1;
    if (_useTransform) count += 1;
    if (_useOpacity) count += 1;
    if (_useClip) count += 1;
    if (_useDecorated) count += 1;
    if (_useConstrained) count += 1;
    if (_usePointerGuard) count += 1;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePack theme = _themePacks[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    _snapshot = _Snapshot(
      scenario: _scenarioPacks[_scenarioIndex].mode.name,
      wrapperCount: _wrapperCount,
      stage: _phase,
      opacity: _opacity,
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
                Icon(Icons.account_tree_outlined, color: scheme.primary, size: 26),
                Text('RenderProxyBoxMixin Modifier Pipeline Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioPacks[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual demos showing how single-child proxy wrappers compose around one child to modify layout, paint, interaction, and semantics.',
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
              children: List<Widget>.generate(_themePacks.length, (int index) {
                final _ThemePack pack = _themePacks[index];
                return ChoiceChip(
                  selected: _themeIndex == index,
                  label: Text(pack.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                      _themeChanges += 1;
                      _phase = 'theme';
                    });
                    _log('theme', 'control', pack.id);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePacks[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioPacks.length, (int index) {
                final _ScenarioPack lane = _scenarioPacks[index];
                return FilterChip(
                  selected: _scenarioIndex == index,
                  label: Text(lane.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                      _scenarioChanges += 1;
                      _phase = 'scenario';
                    });
                    _log('scenario', 'control', lane.mode.name);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarioPacks[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Proxy Wrapper Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Toggle wrapper stages and tune visual parameters to inspect modifier order effects.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 430,
              max: 960,
              divisions: 265,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _onSlider('stageHeight', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Padding',
              value: _padding,
              min: 0,
              max: 48,
              divisions: 96,
              onChanged: (double v) => setState(() => _padding = v),
              onChangeEnd: (double v) => _onSlider('padding', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Opacity',
              value: _opacity,
              min: 0.15,
              max: 1,
              divisions: 85,
              onChanged: (double v) => setState(() => _opacity = v),
              onChangeEnd: (double v) => _onSlider('opacity', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Rotation Turns',
              value: _rotationTurns,
              min: -0.2,
              max: 0.2,
              divisions: 80,
              onChanged: (double v) => setState(() => _rotationTurns = v),
              onChangeEnd: (double v) => _onSlider('rotationTurns', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Scale',
              value: _scale,
              min: 0.6,
              max: 1.4,
              divisions: 80,
              onChanged: (double v) => setState(() => _scale = v),
              onChangeEnd: (double v) => _onSlider('scale', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Translate X',
              value: _translateX,
              min: -80,
              max: 80,
              divisions: 160,
              onChanged: (double v) => setState(() => _translateX = v),
              onChangeEnd: (double v) => _onSlider('translateX', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Translate Y',
              value: _translateY,
              min: -80,
              max: 80,
              divisions: 160,
              onChanged: (double v) => setState(() => _translateY = v),
              onChangeEnd: (double v) => _onSlider('translateY', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Clip Radius',
              value: _clipRadius,
              min: 0,
              max: 60,
              divisions: 120,
              onChanged: (double v) => setState(() => _clipRadius = v),
              onChangeEnd: (double v) => _onSlider('clipRadius', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Card Radius',
              value: _cardRadius,
              min: 0,
              max: 36,
              divisions: 72,
              onChanged: (double v) => setState(() => _cardRadius = v),
              onChangeEnd: (double v) => _onSlider('cardRadius', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Shadow Alpha',
              value: _shadowAlpha,
              min: 0,
              max: 0.8,
              divisions: 80,
              onChanged: (double v) => setState(() => _shadowAlpha = v),
              onChangeEnd: (double v) => _onSlider('shadowAlpha', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Background Drift',
              value: _drift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _drift = v),
              onChangeEnd: (double v) => _onSlider('drift', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Border Width',
              value: _borderWidth,
              min: 0,
              max: 6,
              divisions: 60,
              onChanged: (double v) => setState(() => _borderWidth = v),
              onChangeEnd: (double v) => _onSlider('borderWidth', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Min Width',
              value: _minWidth,
              min: 100,
              max: 360,
              divisions: 130,
              onChanged: (double v) => setState(() => _minWidth = v),
              onChangeEnd: (double v) => _onSlider('minWidth', v),
            ),
            _slider(
              scheme: scheme,
              label: 'Min Height',
              value: _minHeight,
              min: 80,
              max: 260,
              divisions: 90,
              onChanged: (double v) => setState(() => _minHeight = v),
              onChangeEnd: (double v) => _onSlider('minHeight', v),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _usePadding, onChanged: (bool? v) => _toggle('paddingWrapper', v), child: const Text('Padding')),
                CheckboxMenuButton(value: _useAlign, onChanged: (bool? v) => _toggle('alignWrapper', v), child: const Text('Align')),
                CheckboxMenuButton(value: _useTransform, onChanged: (bool? v) => _toggle('transformWrapper', v), child: const Text('Transform')),
                CheckboxMenuButton(value: _useOpacity, onChanged: (bool? v) => _toggle('opacityWrapper', v), child: const Text('Opacity')),
                CheckboxMenuButton(value: _useClip, onChanged: (bool? v) => _toggle('clipWrapper', v), child: const Text('Clip')),
                CheckboxMenuButton(value: _useDecorated, onChanged: (bool? v) => _toggle('decoratedWrapper', v), child: const Text('Decorated')),
                CheckboxMenuButton(value: _useConstrained, onChanged: (bool? v) => _toggle('constrainedWrapper', v), child: const Text('Constrained')),
                CheckboxMenuButton(value: _usePointerGuard, onChanged: (bool? v) => _toggle('pointerWrapper', v), child: const Text('Pointer Guard')),
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Grid')),
                CheckboxMenuButton(value: _showLabels, onChanged: (bool? v) => _toggle('labels', v), child: const Text('Labels')),
                CheckboxMenuButton(value: _showShadow, onChanged: (bool? v) => _toggle('shadow', v), child: const Text('Shadow')),
                CheckboxMenuButton(value: _showClip, onChanged: (bool? v) => _toggle('clip', v), child: const Text('Clip Display')),
                CheckboxMenuButton(value: _showBorder, onChanged: (bool? v) => _toggle('border', v), child: const Text('Border')),
                CheckboxMenuButton(value: _allowInteraction, onChanged: (bool? v) => _toggle('interaction', v), child: const Text('Allow Interaction')),
                CheckboxMenuButton(value: _showSemanticsHint, onChanged: (bool? v) => _toggle('semantics', v), child: const Text('Semantics Hint')),
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
            Text('Proxy Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Live stage demonstrating how wrapper chains affect one shared child component.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                      if (_showGrid) CustomPaint(painter: _GridPainter(progress: pulse, drift: _drift)),
                      _buildScenarioLayer(scheme, pulse),
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
    switch (_scenarioPacks[_scenarioIndex].mode) {
      case _ScenarioMode.pipeline:
        return _pipelineScene(scheme, pulse);
      case _ScenarioMode.chainGrid:
        return _chainGridScene(scheme, pulse);
      case _ScenarioMode.overlayLab:
        return _overlayLabScene(scheme, pulse);
      case _ScenarioMode.interactionDeck:
        return _interactionDeckScene(scheme, pulse);
      case _ScenarioMode.performanceBoard:
        return _performanceBoardScene(scheme, pulse);
      case _ScenarioMode.analytics:
        return _analyticsScene(scheme, pulse);
    }
  }

  Widget _pipelineScene(ColorScheme scheme, double pulse) {
    return Center(
      child: _applyProxyChain(
        scheme: scheme,
        label: 'Primary Pipeline',
        child: _demoCard(scheme: scheme, title: 'Core Child', subtitle: 'Wrapped by active proxy chain', colorA: scheme.primary, colorB: scheme.secondary),
      ),
    );
  }

  Widget _chainGridScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: <Widget>[
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain A',
            forcePadding: true,
            forceTransform: true,
            child: _demoCard(scheme: scheme, title: 'A', subtitle: 'padding + transform', colorA: scheme.primary, colorB: scheme.tertiary),
          ),
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain B',
            forceOpacity: true,
            forceClip: true,
            child: _demoCard(scheme: scheme, title: 'B', subtitle: 'opacity + clip', colorA: scheme.secondary, colorB: scheme.primary),
          ),
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain C',
            forceDecorated: true,
            forceConstrained: true,
            child: _demoCard(scheme: scheme, title: 'C', subtitle: 'decorated + constrained', colorA: scheme.tertiary, colorB: scheme.secondary),
          ),
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain D',
            forceAlign: true,
            forcePadding: true,
            child: _demoCard(scheme: scheme, title: 'D', subtitle: 'align + padding', colorA: scheme.primary, colorB: scheme.secondary),
          ),
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain E',
            forcePointer: true,
            forceTransform: true,
            child: _demoCard(scheme: scheme, title: 'E', subtitle: 'pointer guard + transform', colorA: scheme.secondary, colorB: scheme.tertiary),
          ),
          _applyProxyChain(
            scheme: scheme,
            label: 'Chain F',
            forceClip: true,
            forceDecorated: true,
            forceOpacity: true,
            child: _demoCard(scheme: scheme, title: 'F', subtitle: 'clip + decorated + opacity', colorA: scheme.tertiary, colorB: scheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _overlayLabScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 420,
              height: 240,
              child: _applyProxyChain(
                scheme: scheme,
                label: 'Top Left Overlay',
                forceAlign: true,
                forceTransform: true,
                child: _demoCard(scheme: scheme, title: 'TL', subtitle: 'align+transform overlay', colorA: scheme.primary, colorB: scheme.secondary),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 420,
              height: 240,
              child: _applyProxyChain(
                scheme: scheme,
                label: 'Top Right Overlay',
                forceClip: true,
                forceDecorated: true,
                child: _demoCard(scheme: scheme, title: 'TR', subtitle: 'clip+decorated overlay', colorA: scheme.tertiary, colorB: scheme.primary),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 420,
              height: 240,
              child: _applyProxyChain(
                scheme: scheme,
                label: 'Bottom Left Overlay',
                forcePadding: true,
                forceConstrained: true,
                child: _demoCard(scheme: scheme, title: 'BL', subtitle: 'padding+constraints overlay', colorA: scheme.secondary, colorB: scheme.tertiary),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 420,
              height: 240,
              child: _applyProxyChain(
                scheme: scheme,
                label: 'Bottom Right Overlay',
                forceOpacity: true,
                forcePointer: true,
                child: _demoCard(scheme: scheme, title: 'BR', subtitle: 'opacity+pointer overlay', colorA: scheme.primary, colorB: scheme.tertiary),
              ),
            ),
          ),
          if (_showSemanticsHint)
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 520,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.32), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.44))),
                child: const Text(
                  'Overlay Lab: wrapper order and alignment produce different visual and hit-test outcomes even with identical child content.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _interactionDeckScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Interaction Left',
                    forcePointer: true,
                    child: _interactiveCard(scheme, 'Left Deck', 'Tap buttons to test pointer proxy wrappers'),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Interaction Right',
                    forcePointer: true,
                    forceTransform: true,
                    child: _interactiveCard(scheme, 'Right Deck', 'Transform + pointer guard chain'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.34))),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Interaction Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('allowInteraction=$_allowInteraction', style: const TextStyle(color: Colors.white70)),
                  Text('usePointerGuard=$_usePointerGuard', style: const TextStyle(color: Colors.white70)),
                  Text('wrapperInteractions=$_wrapperInteractions', style: const TextStyle(color: Colors.white70)),
                  Text('tapCount=$_tapCount', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  const Text('If interaction is disabled, pointer guard wrappers absorb taps but still show visual state.', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _interactiveCard(ColorScheme scheme, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: 0.86), scheme.tertiary.withValues(alpha: 0.86)]),
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton(
                onPressed: !_allowInteraction
                    ? null
                    : () {
                        setState(() {
                          _wrapperInteractions += 1;
                          _phase = 'interaction';
                        });
                        _log('tap:primary', 'interaction', title);
                      },
                child: const Text('Primary'),
              ),
              OutlinedButton(
                onPressed: !_allowInteraction
                    ? null
                    : () {
                        setState(() {
                          _wrapperInteractions += 1;
                          _phase = 'interaction';
                        });
                        _log('tap:secondary', 'interaction', title);
                      },
                child: const Text('Secondary'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _performanceBoardScene(ColorScheme scheme, double pulse) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Repaint Lane',
                    forceTransform: true,
                    forceOpacity: true,
                    child: RepaintBoundary(
                      child: _demoCard(scheme: scheme, title: 'Repaint', subtitle: 'Boundary + proxy wrappers', colorA: scheme.primary, colorB: scheme.secondary),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Raster Lane',
                    forceClip: true,
                    forceDecorated: true,
                    child: _demoCard(scheme: scheme, title: 'Raster', subtitle: 'Clip/decorated wrapper stress', colorA: scheme.tertiary, colorB: scheme.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Constraint Lane',
                    forceConstrained: true,
                    forcePadding: true,
                    child: _demoCard(scheme: scheme, title: 'Constraint', subtitle: 'ConstrainedBox style proxy', colorA: scheme.secondary, colorB: scheme.tertiary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Semantics Lane',
                    forceAlign: true,
                    forcePointer: true,
                    child: Semantics(
                      label: 'Proxy semantics card',
                      child: _demoCard(scheme: scheme, title: 'Semantics', subtitle: 'Semantics + pointer wrappers', colorA: scheme.primary, colorB: scheme.tertiary),
                    ),
                  ),
                ),
              ],
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
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _applyProxyChain(
                    scheme: scheme,
                    label: 'Analytics Left',
                    child: _demoCard(scheme: scheme, title: 'Metrics Probe', subtitle: 'Tap to populate event stream', colorA: scheme.primary, colorB: scheme.secondary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.34))),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Verification Checklist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        const Text('1. Wrapper toggles update stage behavior immediately.', style: TextStyle(color: Colors.white70)),
                        const Text('2. Chain order changes visuals and interaction affordances.', style: TextStyle(color: Colors.white70)),
                        const Text('3. Diagnostics reflect live stage and wrapper count.', style: TextStyle(color: Colors.white70)),
                        const Text('4. Timeline captures actions from controls and taps.', style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            _badge('wrappers=$_wrapperCount'),
                            _badge('phase=$_phase'),
                            _badge('action=$_lastAction'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _applyProxyChain(
              scheme: scheme,
              label: 'Analytics Bottom',
              forceTransform: true,
              forceOpacity: true,
              child: _demoCard(scheme: scheme, title: 'Bottom Insight Lane', subtitle: 'Combined wrappers under analytics mode', colorA: scheme.secondary, colorB: scheme.tertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withValues(alpha: 0.4))),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _applyProxyChain({
    required ColorScheme scheme,
    required String label,
    required Widget child,
    bool forcePadding = false,
    bool forceAlign = false,
    bool forceTransform = false,
    bool forceOpacity = false,
    bool forceClip = false,
    bool forceDecorated = false,
    bool forceConstrained = false,
    bool forcePointer = false,
  }) {
    Widget current = child;

    final bool usePadding = _usePadding || forcePadding;
    final bool useAlign = _useAlign || forceAlign;
    final bool useTransform = _useTransform || forceTransform;
    final bool useOpacity = _useOpacity || forceOpacity;
    final bool useClip = (_useClip || forceClip) && _showClip;
    final bool useDecorated = _useDecorated || forceDecorated;
    final bool useConstrained = _useConstrained || forceConstrained;
    final bool usePointer = _usePointerGuard || forcePointer;

    if (useConstrained) {
      current = ConstrainedBox(
        constraints: BoxConstraints(minWidth: _minWidth, minHeight: _minHeight),
        child: current,
      );
    }
    if (usePadding) {
      current = Padding(padding: EdgeInsets.all(_padding), child: current);
    }
    if (useAlign) {
      current = Align(alignment: Alignment.center, child: current);
    }
    if (useDecorated) {
      current = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardRadius),
          border: _showBorder ? Border.all(color: Colors.white.withValues(alpha: 0.45), width: _borderWidth) : null,
          boxShadow: _showShadow
              ? <BoxShadow>[BoxShadow(color: Colors.black.withValues(alpha: _shadowAlpha), blurRadius: 18, offset: const Offset(0, 8))]
              : const <BoxShadow>[],
        ),
        child: current,
      );
    }
    if (useClip) {
      current = ClipRRect(borderRadius: BorderRadius.circular(_clipRadius), child: current);
    }
    if (useOpacity) {
      current = Opacity(opacity: _opacity, child: current);
    }
    if (useTransform) {
      current = Transform.translate(
        offset: Offset(_translateX, _translateY),
        child: Transform.rotate(
          angle: _rotationTurns * math.pi * 2,
          child: Transform.scale(scale: _scale, child: current),
        ),
      );
    }
    if (usePointer) {
      current = AbsorbPointer(absorbing: !_allowInteraction, child: current);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _tapCount += 1;
          _phase = 'tap';
          _wrapperInteractions += 1;
        });
        _log('tap', 'stage', label);
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: current),
          if (_showLabels)
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.32), borderRadius: BorderRadius.circular(999)),
                child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _demoCard({required ColorScheme scheme, required String title, required String subtitle, required Color colorA, required Color colorB}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[colorA.withValues(alpha: 0.86), colorB.withValues(alpha: 0.86)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.4 + 0.45 * (0.5 + 0.5 * math.sin((_animate ? _clock.value : 0) * math.pi * 2)),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
                child: Text('wrappers $_wrapperCount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
              ),
            ],
          ),
        ],
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
            Text('Wrapper Pattern Comparison', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Conceptual map of common proxy-box style wrappers.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget a = _comparisonCard(
                  scheme: scheme,
                  title: 'Layout Proxy',
                  note: 'Padding, Align, ConstrainedBox adjust layout around the child.',
                  color: const Color(0xFF0F766E),
                  icon: Icons.space_dashboard_outlined,
                );
                final Widget b = _comparisonCard(
                  scheme: scheme,
                  title: 'Paint Proxy',
                  note: 'Opacity, Clip, Decorated wrappers modify painted output.',
                  color: const Color(0xFF1D4ED8),
                  icon: Icons.brush_outlined,
                );
                final Widget c = _comparisonCard(
                  scheme: scheme,
                  title: 'Interaction Proxy',
                  note: 'Pointer guards and semantics wrappers alter event semantics.',
                  color: const Color(0xFFB45309),
                  icon: Icons.touch_app_outlined,
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

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String note, required Color color, required IconData icon}) {
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
              child: Center(child: Icon(icon, color: color, size: 34)),
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
                                Expanded(child: Text(m.title, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
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
      _Metric(title: 'Scenario', value: _scenarioPacks[_scenarioIndex].title, note: 'Active proxy demo lane.', icon: Icons.route_outlined),
      _Metric(title: 'Theme', value: _themePacks[_themeIndex].name, note: 'Current color profile.', icon: Icons.palette_outlined),
      _Metric(title: 'Wrapper Count', value: '$_wrapperCount', note: 'Active wrapper stages.', icon: Icons.layers_outlined),
      _Metric(title: 'Interaction', value: _allowInteraction ? 'enabled' : 'guarded', note: 'Pointer guard state.', icon: Icons.touch_app_outlined),
      _Metric(title: 'Tap Count', value: '$_tapCount', note: 'Tap events on stage wrappers.', icon: Icons.ads_click_outlined),
      _Metric(title: 'Wrapper Interactions', value: '$_wrapperInteractions', note: 'Button and stage actions recorded.', icon: Icons.gesture_outlined),
      _Metric(title: 'Opacity', value: _opacity.toStringAsFixed(2), note: 'Opacity wrapper parameter.', icon: Icons.opacity_outlined),
      _Metric(title: 'Transform', value: 'r=${_rotationTurns.toStringAsFixed(2)} s=${_scale.toStringAsFixed(2)}', note: 'Transform wrapper parameters.', icon: Icons.transform_outlined),
      _Metric(title: 'Translate', value: 'x=${_translateX.toStringAsFixed(1)} y=${_translateY.toStringAsFixed(1)}', note: 'Translation offsets.', icon: Icons.open_with_outlined),
      _Metric(title: 'Clip Radius', value: _clipRadius.toStringAsFixed(1), note: 'Clip wrapper radius.', icon: Icons.crop_square_outlined),
      _Metric(title: 'Card Radius', value: _cardRadius.toStringAsFixed(1), note: 'Decorated wrapper corner radius.', icon: Icons.rounded_corner_outlined),
      _Metric(title: 'Shadow', value: _shadowAlpha.toStringAsFixed(2), note: 'Shadow alpha for decorated stage.', icon: Icons.dark_mode_outlined),
      _Metric(title: 'Constraints', value: '${_minWidth.toStringAsFixed(0)} x ${_minHeight.toStringAsFixed(0)}', note: 'Constrained wrapper minima.', icon: Icons.fit_screen_outlined),
      _Metric(title: 'Stage Height', value: _stageHeight.toStringAsFixed(0), note: 'Stage container height.', icon: Icons.height_outlined),
      _Metric(title: 'Switches', value: 'theme=$_themeChanges scenario=$_scenarioChanges controls=$_controlEdits', note: 'Config change counters.', icon: Icons.swap_horiz_outlined),
      _Metric(title: 'Snapshot', value: '${_snapshot.scenario} wrappers=${_snapshot.wrapperCount} ${_snapshot.stage}', note: 'Current snapshot line.', icon: Icons.camera_outlined),
      _Metric(title: 'Last Action', value: _lastAction, note: 'Most recent logged action.', icon: Icons.history_outlined),
      _Metric(title: 'Events', value: '${_events.length}', note: 'Bounded timeline event size.', icon: Icons.list_alt_outlined),
      _Metric(title: 'Semantics Hint', value: _showSemanticsHint.toString(), note: 'Semantics guidance visibility.', icon: Icons.record_voice_over_outlined),
      _Metric(title: 'Phase', value: _phase, note: 'Latest activity phase.', icon: Icons.flag_outlined),
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
                Text('Runtime Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('theme=${_themePacks[_themeIndex].id} scenario=${_scenarioPacks[_scenarioIndex].mode.name} wrappers=$_wrapperCount phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('padding=${_padding.toStringAsFixed(1)} opacity=${_opacity.toStringAsFixed(2)} rotate=${_rotationTurns.toStringAsFixed(2)} scale=${_scale.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('translate=(${_translateX.toStringAsFixed(1)}, ${_translateY.toStringAsFixed(1)}) clipRadius=${_clipRadius.toStringAsFixed(1)} cardRadius=${_cardRadius.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('shadow=${_shadowAlpha.toStringAsFixed(2)} borderWidth=${_borderWidth.toStringAsFixed(2)} min=(${_minWidth.toStringAsFixed(0)}, ${_minHeight.toStringAsFixed(0)})', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags grid=$_showGrid labels=$_showLabels shadow=$_showShadow clip=$_showClip border=$_showBorder interaction=$_allowInteraction semantics=$_showSemanticsHint', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('wrappers padding=$_usePadding align=$_useAlign transform=$_useTransform opacity=$_useOpacity clip=$_useClip decorated=$_useDecorated constrained=$_useConstrained pointer=$_usePointerGuard', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            ..._guideNotes.map((String line) {
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
            ..._faqItems.map(( _Faq faq) {
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
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _events = const <_Event>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological event stream of controls, interactions, and scenario transitions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_events.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with controls and scene elements to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _events.take(44).map(( _Event event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(event.action.characters.first.toUpperCase(), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text('${event.action} | ${event.stage}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
                      subtitle: Text('$stamp  |  ${event.note}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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
  const _GridPainter({required this.progress, required this.drift});

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
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}
