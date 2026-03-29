import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'signal',
    name: 'Signal Deck',
    description: 'Precision profile for observing animated alpha transitions.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Stage',
    description: 'Warm profile for teaching animation semantics and layering.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Analyzer',
    description: 'Dark profile for clearer contrast in opacity transitions.',
    seed: Color(0xFF1E293B),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'atlas',
    name: 'Atlas Mint',
    description: 'Balanced profile for long-form visual verification sessions.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    id: 'core',
    title: 'Core Alpha Stage',
    subtitle: 'Direct RenderAnimatedOpacity host driven by controller and curve.',
  ),
  _Scenario(
    id: 'comparison',
    title: 'Comparison Matrix',
    subtitle: 'Render host vs AnimatedOpacity vs FadeTransition side-by-side.',
  ),
  _Scenario(
    id: 'semantics',
    title: 'Semantics Continuity',
    subtitle: 'alwaysIncludeSemantics behavior and visibility semantics notes.',
  ),
  _Scenario(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Instrumentation board with timeline, snapshots, and metrics.',
  ),
];

const List<_CurvePreset> _curvePresets = <_CurvePreset>[
  _CurvePreset(id: 'linear', label: 'Linear', curve: Curves.linear, note: 'Constant progression over time.'),
  _CurvePreset(id: 'easeIn', label: 'Ease In', curve: Curves.easeIn, note: 'Starts slowly and accelerates.'),
  _CurvePreset(id: 'easeOut', label: 'Ease Out', curve: Curves.easeOut, note: 'Starts quickly and eases near end.'),
  _CurvePreset(id: 'easeInOut', label: 'Ease InOut', curve: Curves.easeInOut, note: 'Balanced acceleration and deceleration.'),
  _CurvePreset(id: 'fastOutSlowIn', label: 'FastOutSlowIn', curve: Curves.fastOutSlowIn, note: 'Material-style emphasis curve.'),
  _CurvePreset(id: 'decelerate', label: 'Decelerate', curve: Curves.decelerate, note: 'Quick start with gradual settling.'),
];

const List<String> _intro = <String>[
  'RenderAnimatedOpacityMixin powers render-layer alpha animation logic used by RenderAnimatedOpacity.',
  'This demo is visual-first: instead of asserting API rules, it reveals behavior through live animation boards.',
  'A direct render object host demonstrates mixin-driven transitions at the rendering layer.',
  'Comparison boards show how RenderAnimatedOpacity aligns with AnimatedOpacity and FadeTransition behavior.',
  'Semantics controls illustrate why alwaysIncludeSemantics matters for accessibility continuity.',
  'Timeline and metrics help validate interpreter interaction fidelity under manual controls.',
];

const List<String> _bestPractices = <String>[
  'Use curves intentionally to match motion tone and readability of opacity transitions.',
  'Treat very low opacity values carefully when interactive semantics should remain available.',
  'Keep direct render diagnostics visible during bridge verification sessions.',
  'Compare direct render usage against widget-level APIs to identify integration drift quickly.',
  'Log controller lifecycle events to diagnose stalled or unexpectedly looping animations.',
  'Use consistent stage visuals to make subtle alpha changes easier to inspect.',
  'Expose manual scrubbing to validate intermediate alpha states that automatic playback may skip.',
  'Pair semantics notes with visuals so teams understand user-facing accessibility implications.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'What class actually mixes in RenderAnimatedOpacityMixin?',
    answer:
        'RenderAnimatedOpacity uses this mixin to animate alpha and repaint behavior for a single child render object.',
  ),
  _FaqItem(
    question: 'Why include AnimatedOpacity and FadeTransition comparisons?',
    answer:
        'They are common widget-level APIs built on related concepts, making behavior contrasts practical and instructive.',
  ),
  _FaqItem(
    question: 'What does alwaysIncludeSemantics influence?',
    answer:
        'It controls whether semantics remain included even when visual opacity approaches invisibility.',
  ),
  _FaqItem(
    question: 'Why does this file avoid assert-heavy checks?',
    answer:
        'This suite validates interpreter interaction and visual behavior rather than Flutter engine API correctness.',
  ),
];

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

  final String id;
  final String title;
  final String subtitle;
}

class _CurvePreset {
  const _CurvePreset({
    required this.id,
    required this.label,
    required this.curve,
    required this.note,
  });

  final String id;
  final String label;
  final Curve curve;
  final String note;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _TimelineEntry {
  const _TimelineEntry({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

dynamic build(BuildContext context) {
  return const _RenderAnimatedOpacityMixinStudio();
}

class _RenderAnimatedOpacityMixinStudio extends StatefulWidget {
  const _RenderAnimatedOpacityMixinStudio();

  @override
  State<_RenderAnimatedOpacityMixinStudio> createState() => _RenderAnimatedOpacityMixinStudioState();
}

class _RenderAnimatedOpacityMixinStudioState extends State<_RenderAnimatedOpacityMixinStudio>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _curveIndex = 3;

  bool _alwaysIncludeSemantics = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _autoMirror = true;

  double _targetOpacity = 0.28;
  double _stageWidth = 360;
  double _stageHeight = 220;
  double _tileScale = 1;
  double _overlayOpacity = 0.22;
  double _durationMs = 1500;

  int _playCount = 0;
  int _pauseCount = 0;
  int _reverseCount = 0;
  int _scrubCount = 0;
  int _curveSwitchCount = 0;
  int _semanticsSwitchCount = 0;

  List<_TimelineEntry> _timeline = const <_TimelineEntry>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationMs.round()),
      value: 1,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: _curvePresets[_curveIndex].curve,
    );
    _controller.addListener(_onTick);
    _controller.addStatusListener(_onStatus);
    _addTimeline('Init', 'Controller initialized at value 1.00.');
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTick() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _onStatus(AnimationStatus status) {
    final String label = switch (status) {
      AnimationStatus.dismissed => 'dismissed',
      AnimationStatus.forward => 'forward',
      AnimationStatus.reverse => 'reverse',
      AnimationStatus.completed => 'completed',
    };

    _addTimeline('AnimationStatus', 'Controller status changed to $label.');

    if (_autoMirror && status == AnimationStatus.completed) {
      _controller.reverse();
      _addTimeline('AutoMirror', 'Auto reverse started after completion.');
    } else if (_autoMirror && status == AnimationStatus.dismissed) {
      _controller.forward();
      _addTimeline('AutoMirror', 'Auto forward started after dismissal.');
    }
  }

  void _addTimeline(String title, String message) {
    final List<_TimelineEntry> next = <_TimelineEntry>[
      _TimelineEntry(time: DateTime.now(), title: title, message: message),
      ..._timeline,
    ];
    setState(() {
      _timeline = next.take(42).toList(growable: false);
    });
  }

  void _rebuildCurve() {
    _curvedAnimation.dispose();
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: _curvePresets[_curveIndex].curve);
  }

  void _setDuration(double ms) {
    setState(() {
      _durationMs = ms;
      _controller.duration = Duration(milliseconds: ms.round());
    });
    _addTimeline('Duration', 'Controller duration changed to ${ms.toStringAsFixed(0)} ms.');
  }

  void _playToTarget() {
    _playCount += 1;
    _addTimeline('Play', 'Animating toward target opacity ${_targetOpacity.toStringAsFixed(2)}.');
    _controller.animateTo(_targetOpacity, duration: Duration(milliseconds: _durationMs.round()));
  }

  void _reverseToVisible() {
    _reverseCount += 1;
    _addTimeline('Reverse', 'Animating toward fully visible state (1.0).');
    _controller.animateTo(1, duration: Duration(milliseconds: _durationMs.round()));
  }

  void _pauseAnimation() {
    _pauseCount += 1;
    _controller.stop();
    _addTimeline('Pause', 'Controller stop() invoked.');
  }

  void _scrubTo(double value) {
    _scrubCount += 1;
    _controller.value = value;
    _addTimeline('Scrub', 'Controller value set to ${value.toStringAsFixed(2)}.');
  }

  void _resetDemo() {
    setState(() {
      _scenarioIndex = 0;
      _curveIndex = 3;
      _alwaysIncludeSemantics = false;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _autoMirror = true;
      _targetOpacity = 0.28;
      _stageWidth = 360;
      _stageHeight = 220;
      _tileScale = 1;
      _overlayOpacity = 0.22;
      _durationMs = 1500;
      _playCount = 0;
      _pauseCount = 0;
      _reverseCount = 0;
      _scrubCount = 0;
      _curveSwitchCount = 0;
      _semanticsSwitchCount = 0;
      _timeline = const <_TimelineEntry>[];
      _controller.duration = Duration(milliseconds: _durationMs.round());
      _controller.value = 1;
      _rebuildCurve();
    });
    _addTimeline('Reset', 'Opacity motion lab reset to defaults.');
  }

  List<_Metric> _metrics(ColorScheme scheme) {
    final double alpha = _curvedAnimation.value;
    final double percent = alpha * 100;
    return <_Metric>[
      _Metric(
        label: 'Controller Value',
        value: _controller.value.toStringAsFixed(3),
        note: 'Raw animation controller value driving the curve input.',
        icon: Icons.speed,
      ),
      _Metric(
        label: 'Curved Opacity',
        value: alpha.toStringAsFixed(3),
        note: 'Opacity actually consumed by RenderAnimatedOpacity.',
        icon: Icons.opacity,
      ),
      _Metric(
        label: 'Opacity %',
        value: '${percent.toStringAsFixed(1)}%',
        note: 'Human-readable alpha percentage for quick reviews.',
        icon: Icons.percent,
      ),
      _Metric(
        label: 'Curve',
        value: _curvePresets[_curveIndex].label,
        note: _curvePresets[_curveIndex].note,
        icon: Icons.show_chart,
      ),
      _Metric(
        label: 'Duration',
        value: '${_durationMs.toStringAsFixed(0)} ms',
        note: 'Animation duration used for animateTo operations.',
        icon: Icons.timer_outlined,
      ),
      _Metric(
        label: 'Target Opacity',
        value: _targetOpacity.toStringAsFixed(2),
        note: 'Low-opacity target used by Play button.',
        icon: Icons.flag_outlined,
      ),
      _Metric(
        label: 'Semantics Always',
        value: _alwaysIncludeSemantics ? 'ON' : 'OFF',
        note: 'Whether semantics remain included despite near-invisible content.',
        icon: Icons.accessibility_new,
      ),
      _Metric(
        label: 'Play Count',
        value: '$_playCount',
        note: 'Times play-to-target command was triggered.',
        icon: Icons.play_arrow,
      ),
      _Metric(
        label: 'Pause Count',
        value: '$_pauseCount',
        note: 'Times controller was paused manually.',
        icon: Icons.pause,
      ),
      _Metric(
        label: 'Reverse Count',
        value: '$_reverseCount',
        note: 'Times reverse-to-visible action ran.',
        icon: Icons.replay,
      ),
      _Metric(
        label: 'Scrubs',
        value: '$_scrubCount',
        note: 'Manual scrub interactions for intermediate alpha states.',
        icon: Icons.tune,
      ),
      _Metric(
        label: 'Curve Switches',
        value: '$_curveSwitchCount',
        note: 'How often the active curve was changed.',
        icon: Icons.swap_horiz,
      ),
      _Metric(
        label: 'Semantics Toggles',
        value: '$_semanticsSwitchCount',
        note: 'Number of alwaysIncludeSemantics changes.',
        icon: Icons.toggle_on_outlined,
      ),
      _Metric(
        label: 'Theme',
        value: _themePresets[_themeIndex].name,
        note: 'Active visual profile for this run.',
        icon: Icons.palette_outlined,
      ),
      _Metric(
        label: 'Scenario',
        value: _scenarios[_scenarioIndex].title,
        note: 'Current narrative lane in the studio.',
        icon: Icons.view_carousel_outlined,
      ),
      _Metric(
        label: 'Tile Scale',
        value: _tileScale.toStringAsFixed(2),
        note: 'Scale factor used by the stage sample child visuals.',
        icon: Icons.zoom_out_map,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: preset.seed,
      brightness: preset.brightness,
    );

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        brightness: preset.brightness,
      ),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.surface,
                scheme.surfaceContainerLowest,
                scheme.surfaceContainerLow,
              ],
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
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildProfilesAndScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildPrimaryConsole(scheme),
                        const SizedBox(height: 16),
                        _buildComparisonMatrix(scheme),
                        const SizedBox(height: 16),
                        _buildSemanticsBoard(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
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
                Icon(Icons.motion_photos_on_rounded, color: scheme.primary, size: 24),
                Text(
                  'RenderAnimatedOpacityMixin Motion Lab',
                  style: TextStyle(color: scheme.onSurface, fontSize: 26, fontWeight: FontWeight.w800),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _scenarios[_scenarioIndex].title,
                    style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Direct render-object demonstration of animated opacity behavior, comparisons, and semantics implications.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilesAndScenarioBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themePresets.length, (int index) {
                final _ThemePreset p = _themePresets[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                    });
                    _addTimeline('Theme', 'Switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 14),
            Text('Scenarios', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                final _Scenario s = _scenarios[index];
                return FilterChip(
                  selected: index == _scenarioIndex,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                    });
                    _addTimeline('Scenario', s.subtitle);
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

  Widget _buildPrimaryConsole(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        if (narrow) {
          return Column(
            children: <Widget>[
              _buildOpacityStageBoard(scheme),
              const SizedBox(height: 16),
              _buildControlDeck(scheme),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _buildOpacityStageBoard(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _buildControlDeck(scheme)),
          ],
        );
      },
    );
  }

  Widget _buildOpacityStageBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Direct Render Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _resetDemo,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset Lab'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'This lane uses RenderAnimatedOpacity directly through a custom render object widget host.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: _stageWidth,
                height: _stageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: scheme.outlineVariant),
                  color: scheme.surfaceContainerHighest,
                ),
                child: Stack(
                  children: <Widget>[
                    if (_showGrid)
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.22)),
                        ),
                      ),
                    Positioned.fill(
                      child: Center(
                        child: _RenderAnimatedOpacityHost(
                          opacity: _curvedAnimation,
                          alwaysIncludeSemantics: _alwaysIncludeSemantics,
                          child: Transform.scale(
                            scale: _tileScale,
                            child: _buildStageTile(scheme),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _buildChip(
                        scheme,
                        'alpha ${_curvedAnimation.value.toStringAsFixed(2)}',
                        Icons.opacity,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _buildChip(
                        scheme,
                        _alwaysIncludeSemantics ? 'Semantics ON' : 'Semantics OFF',
                        Icons.accessibility_new,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: _buildChip(
                        scheme,
                        _curvePresets[_curveIndex].label,
                        Icons.show_chart,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _playToTarget,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play To Target'),
                ),
                OutlinedButton.icon(
                  onPressed: _pauseAnimation,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                ),
                OutlinedButton.icon(
                  onPressed: _reverseToVisible,
                  icon: const Icon(Icons.replay),
                  label: const Text('Return To 1.0'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(ColorScheme scheme, String text, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: scheme.primary),
            const SizedBox(width: 6),
            Text(text, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildStageTile(ColorScheme scheme) {
    return Container(
      width: 140,
      height: 104,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: scheme.primary.withValues(alpha: 0.26), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Render Lane', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
            const Spacer(),
            Text(
              'value ${_controller.value.toStringAsFixed(2)}',
              style: TextStyle(color: scheme.onPrimaryContainer),
            ),
            const SizedBox(height: 2),
            Text(
              'alpha ${_curvedAnimation.value.toStringAsFixed(2)}',
              style: TextStyle(color: scheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlDeck(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Control Deck', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Manual controls for scrub, duration, target opacity, curve, and semantics inclusion.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            _sliderRow(
              scheme: scheme,
              label: 'Scrub Value',
              value: _controller.value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) {
                setState(() {
                  _controller.value = value;
                });
              },
              onChangeEnd: _scrubTo,
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Target Opacity',
              value: _targetOpacity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _targetOpacity = value),
              onChangeEnd: (double value) => _addTimeline('Target', 'Target opacity set to ${value.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Duration (ms)',
              value: _durationMs,
              min: 200,
              max: 3600,
              divisions: 68,
              onChanged: (double value) => setState(() => _durationMs = value),
              onChangeEnd: _setDuration,
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stage Width',
              value: _stageWidth,
              min: 240,
              max: 620,
              divisions: 76,
              onChanged: (double value) => setState(() => _stageWidth = value),
              onChangeEnd: (double value) => _addTimeline('Stage Width', 'Stage width set to ${value.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 160,
              max: 420,
              divisions: 65,
              onChanged: (double value) => setState(() => _stageHeight = value),
              onChangeEnd: (double value) => _addTimeline('Stage Height', 'Stage height set to ${value.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Tile Scale',
              value: _tileScale,
              min: 0.5,
              max: 1.8,
              divisions: 52,
              onChanged: (double value) => setState(() => _tileScale = value),
              onChangeEnd: (double value) => _addTimeline('Tile Scale', 'Tile scale set to ${value.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Overlay Opacity',
              value: _overlayOpacity,
              min: 0,
              max: 0.6,
              divisions: 30,
              onChanged: (double value) => setState(() => _overlayOpacity = value),
              onChangeEnd: (double value) => _addTimeline('Overlay', 'Overlay opacity set to ${value.toStringAsFixed(2)}.'),
            ),
            const Divider(height: 24),
            Text('Curve Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_curvePresets.length, (int index) {
                final _CurvePreset preset = _curvePresets[index];
                return ChoiceChip(
                  selected: index == _curveIndex,
                  label: Text(preset.label),
                  onSelected: (_) {
                    setState(() {
                      _curveIndex = index;
                      _curveSwitchCount += 1;
                      _rebuildCurve();
                    });
                    _addTimeline('Curve', 'Changed curve to ${preset.label}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_curvePresets[_curveIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _alwaysIncludeSemantics,
              title: const Text('alwaysIncludeSemantics'),
              subtitle: const Text('Keep semantics present even at very low opacity.'),
              onChanged: (bool? value) {
                setState(() {
                  _alwaysIncludeSemantics = value ?? false;
                  _semanticsSwitchCount += 1;
                });
                _addTimeline(
                  'Semantics',
                  _alwaysIncludeSemantics
                      ? 'alwaysIncludeSemantics enabled.'
                      : 'alwaysIncludeSemantics disabled.',
                );
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _autoMirror,
              title: const Text('Auto mirror on endpoints'),
              onChanged: (bool? value) {
                setState(() {
                  _autoMirror = value ?? false;
                });
                _addTimeline('AutoMirror', _autoMirror ? 'Auto mirror enabled.' : 'Auto mirror disabled.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGrid,
              title: const Text('Show grid backdrop'),
              onChanged: (bool? value) => setState(() => _showGrid = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showDiagnostics,
              title: const Text('Show diagnostics panel'),
              onChanged: (bool? value) => setState(() => _showDiagnostics = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGuide,
              title: const Text('Show guide board'),
              onChanged: (bool? value) => setState(() => _showGuide = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showTimeline,
              title: const Text('Show timeline board'),
              onChanged: (bool? value) => setState(() => _showTimeline = value ?? true),
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
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
        ),
      ],
    );
  }

  Widget _buildComparisonMatrix(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Comparison Matrix', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Cross-check direct render behavior against common widget-level opacity APIs.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1020;
                if (narrow) {
                  return Column(
                    children: <Widget>[
                      _comparisonCard(
                        scheme: scheme,
                        title: 'RenderAnimatedOpacity Host',
                        subtitle: 'Direct render object path using mixin-backed implementation.',
                        child: _RenderAnimatedOpacityHost(
                          opacity: _curvedAnimation,
                          alwaysIncludeSemantics: _alwaysIncludeSemantics,
                          child: _comparisonTile(scheme, 'Direct Render'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _comparisonCard(
                        scheme: scheme,
                        title: 'AnimatedOpacity Widget',
                        subtitle: 'Widget-managed opacity animation over same visual payload.',
                        child: AnimatedOpacity(
                          opacity: _curvedAnimation.value,
                          duration: Duration(milliseconds: _durationMs.round()),
                          child: _comparisonTile(scheme, 'AnimatedOpacity'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _comparisonCard(
                        scheme: scheme,
                        title: 'FadeTransition Widget',
                        subtitle: 'Animation-driven fade transition with external animation source.',
                        child: FadeTransition(
                          opacity: _curvedAnimation,
                          child: _comparisonTile(scheme, 'FadeTransition'),
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Expanded(
                      child: _comparisonCard(
                        scheme: scheme,
                        title: 'RenderAnimatedOpacity Host',
                        subtitle: 'Direct render object path using mixin-backed implementation.',
                        child: _RenderAnimatedOpacityHost(
                          opacity: _curvedAnimation,
                          alwaysIncludeSemantics: _alwaysIncludeSemantics,
                          child: _comparisonTile(scheme, 'Direct Render'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _comparisonCard(
                        scheme: scheme,
                        title: 'AnimatedOpacity Widget',
                        subtitle: 'Widget-managed opacity animation over same visual payload.',
                        child: AnimatedOpacity(
                          opacity: _curvedAnimation.value,
                          duration: Duration(milliseconds: _durationMs.round()),
                          child: _comparisonTile(scheme, 'AnimatedOpacity'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _comparisonCard(
                        scheme: scheme,
                        title: 'FadeTransition Widget',
                        subtitle: 'Animation-driven fade transition with external animation source.',
                        child: FadeTransition(
                          opacity: _curvedAnimation,
                          child: _comparisonTile(scheme, 'FadeTransition'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({
    required ColorScheme scheme,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(child: child),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonTile(ColorScheme scheme, String caption) {
    return Container(
      width: 126,
      height: 88,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.6)),
      ),
      child: Center(
        child: Text(
          caption,
          textAlign: TextAlign.center,
          style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildSemanticsBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Semantics Continuity Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Demonstrates how semantics policy can be preserved while visibility drops toward transparency.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 900;
                final Widget left = _semanticsLane(
                  scheme: scheme,
                  title: 'Semantics OFF',
                  enabled: false,
                );
                final Widget right = _semanticsLane(
                  scheme: scheme,
                  title: 'Semantics ON',
                  enabled: true,
                );

                if (narrow) {
                  return Column(
                    children: <Widget>[
                      left,
                      const SizedBox(height: 10),
                      right,
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Expanded(child: left),
                    const SizedBox(width: 10),
                    Expanded(child: right),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _semanticsLane({required ColorScheme scheme, required String title, required bool enabled}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: enabled ? scheme.secondaryContainer.withValues(alpha: 0.26) : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: enabled ? scheme.secondary : scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(
              enabled
                  ? 'Keeps semantics available while alpha transitions to very low values.'
                  : 'Semantics may be reduced when visibility becomes negligible.',
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(
                child: _RenderAnimatedOpacityHost(
                  opacity: _curvedAnimation,
                  alwaysIncludeSemantics: enabled,
                  child: Container(
                    width: 120,
                    height: 72,
                    decoration: BoxDecoration(
                      color: scheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        enabled ? 'Semantics ON' : 'Semantics OFF',
                        style: TextStyle(color: scheme.onTertiaryContainer, fontWeight: FontWeight.w700),
                      ),
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

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_Metric> items = _metrics(scheme);
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Metrics & Diagnostics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
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
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.8 : 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _Metric item = items[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(item.icon, color: scheme.primary, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              item.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.note,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 14),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Diagnostics Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            Text('controller.value = ${_controller.value.toStringAsFixed(3)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('curved.value = ${_curvedAnimation.value.toStringAsFixed(3)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('targetOpacity = ${_targetOpacity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('durationMs = ${_durationMs.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('alwaysIncludeSemantics = $_alwaysIncludeSemantics', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('curve = ${_curvePresets[_curveIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._intro.map((String item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            Text('Best Practices', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._bestPractices.map((String item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Icon(Icons.check_circle_outline, size: 14, color: scheme.secondary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            Text('FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._faq.map(( _FaqItem item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DecoratedBox(
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
      color: scheme.surfaceContainer,
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
                      _timeline = const <_TimelineEntry>[];
                    });
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Chronological log of control changes, animation statuses, and motion operations.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            if (_timeline.isEmpty)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    'Timeline is empty. Use controls to generate animation events.',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEntry entry) {
                  final String stamp =
                      '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}:${entry.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text(entry.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${entry.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
  _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final Paint centerPaint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), centerPaint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), centerPaint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _RenderAnimatedOpacityHost extends SingleChildRenderObjectWidget {
  const _RenderAnimatedOpacityHost({
    required this.opacity,
    required this.alwaysIncludeSemantics,
    super.child,
  });

  final Animation<double> opacity;
  final bool alwaysIncludeSemantics;

  @override
  RenderAnimatedOpacity createRenderObject(BuildContext context) {
    return RenderAnimatedOpacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderAnimatedOpacity renderObject) {
    renderObject
      ..opacity = opacity
      ..alwaysIncludeSemantics = alwaysIncludeSemantics;
  }
}
