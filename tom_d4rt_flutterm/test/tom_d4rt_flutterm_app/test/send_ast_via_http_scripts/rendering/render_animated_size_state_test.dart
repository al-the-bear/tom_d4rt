import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'harbor',
    name: 'Harbor Lab',
    description: 'Oceanic profile for studying size interpolation and motion rhythm.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Workshop',
    description: 'Warm profile for explain-and-demo walkthrough sessions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Inspector',
    description: 'Dark profile that makes changing bounds easier to perceive.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'grove',
    name: 'Grove Stage',
    description: 'Balanced profile for long-form render-state diagnostics.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioPreset> _scenarios = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'theater',
    title: 'State Theater',
    subtitle: 'Primary animated stage with state labels and timeline markers.',
  ),
  _ScenarioPreset(
    id: 'constraints',
    title: 'Constraint Lab',
    subtitle: 'Loose/tight/ratio pressure boards to observe transition behavior.',
  ),
  _ScenarioPreset(
    id: 'axes',
    title: 'Axis Emphasis',
    subtitle: 'Width-dominant vs height-dominant child changes for state insight.',
  ),
  _ScenarioPreset(
    id: 'reverse',
    title: 'Reverse Timing',
    subtitle: 'Forward/reverse duration strategy and return-path behavior.',
  ),
  _ScenarioPreset(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Counters, diagnostics, and timeline for repeatable verification.',
  ),
];

const List<_DurationPreset> _durationPresets = <_DurationPreset>[
  _DurationPreset(label: 'Snappy', forwardMs: 280, reverseMs: 180, note: 'Quick transitions for reactive UIs.'),
  _DurationPreset(label: 'Balanced', forwardMs: 640, reverseMs: 360, note: 'General-purpose, easy to follow.'),
  _DurationPreset(label: 'Expressive', forwardMs: 1200, reverseMs: 820, note: 'Long transitions for demos and tutorials.'),
  _DurationPreset(label: 'Slow Return', forwardMs: 750, reverseMs: 1450, note: 'Highlights asymmetric reverse behavior.'),
  _DurationPreset(label: 'Fast Return', forwardMs: 1050, reverseMs: 280, note: 'Shows rapid convergence after expansion.'),
];

const List<_CurvePreset> _curvePresets = <_CurvePreset>[
  _CurvePreset(label: 'Linear', curve: Curves.linear, note: 'Constant interpolation rate.'),
  _CurvePreset(label: 'EaseInOut', curve: Curves.easeInOut, note: 'Balanced ease on both ends.'),
  _CurvePreset(label: 'FastOutSlowIn', curve: Curves.fastOutSlowIn, note: 'Material default feeling.'),
  _CurvePreset(label: 'EaseOutCubic', curve: Curves.easeOutCubic, note: 'Quick start with gentle settle.'),
  _CurvePreset(label: 'Decelerate', curve: Curves.decelerate, note: 'Useful for content reveal growth.'),
];

const List<String> _intro = <String>[
  'RenderAnimatedSizeState is the internal state machine for RenderAnimatedSize size interpolation behavior.',
  'This demo focuses on visual transitions and runtime interaction in the interpreter instead of assertion-heavy API checks.',
  'AnimatedSize is used as the public entry point to drive the underlying render state behavior.',
  'State labels in this studio represent transition phases teams reason about while debugging layout motion.',
  'Constraint and axis boards reveal how parent limits influence the perceived transition quality.',
  'Timeline, counters, and diagnostics allow repeatable verification while tuning animation parameters.',
];

const List<String> _bestPractices = <String>[
  'Choose forward and reverse durations deliberately when collapse speed should differ from expansion speed.',
  'Validate transitions under both tight and loose parent constraints to avoid surprise clipping or jumps.',
  'Track state-like phases (stable, expanding, shrinking, settling) for easier collaboration during debugging.',
  'Use animated size sparingly in dense lists unless motion semantics clearly help users orient themselves.',
  'Keep visual instrumentation nearby when validating interpreter rendering behavior.',
  'Pair curve choice with duration; aggressive curves can mask subtle content resizing artifacts.',
  'Test width-heavy and height-heavy mutations separately to uncover axis-specific issues.',
  'Document expected lifecycle transitions for reusable UI components using AnimatedSize.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'What is RenderAnimatedSizeState in practice?',
    answer:
        'It is the internal render-layer state progression used while AnimatedSize interpolates between old and new child sizes.',
  ),
  _FaqItem(
    question: 'Why demonstrate with AnimatedSize instead of direct render construction?',
    answer:
        'AnimatedSize is the stable public API that activates the same render behavior safely in app-level code.',
  ),
  _FaqItem(
    question: 'What should teams inspect first when a transition looks wrong?',
    answer: 'Check parent constraints, duration asymmetry, and whether child size changes are abrupt or phased.',
  ),
  _FaqItem(
    question: 'How does reverseDuration help?',
    answer: 'It lets collapse or rollback timing differ from expansion, improving interaction feel and predictability.',
  ),
];

enum _MorphMode {
  compact,
  card,
  panel,
  banner,
  stack,
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

class _ScenarioPreset {
  const _ScenarioPreset({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _DurationPreset {
  const _DurationPreset({required this.label, required this.forwardMs, required this.reverseMs, required this.note});

  final String label;
  final int forwardMs;
  final int reverseMs;
  final String note;
}

class _CurvePreset {
  const _CurvePreset({required this.label, required this.curve, required this.note});

  final String label;
  final Curve curve;
  final String note;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _MetricItem {
  const _MetricItem({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _TimelineItem {
  const _TimelineItem({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

dynamic build(BuildContext context) {
  return const _RenderAnimatedSizeStateObservatory();
}

class _RenderAnimatedSizeStateObservatory extends StatefulWidget {
  const _RenderAnimatedSizeStateObservatory();

  @override
  State<_RenderAnimatedSizeStateObservatory> createState() => _RenderAnimatedSizeStateObservatoryState();
}

class _RenderAnimatedSizeStateObservatoryState extends State<_RenderAnimatedSizeStateObservatory>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _curveIndex = 2;
  int _durationPresetIndex = 1;

  _MorphMode _mode = _MorphMode.card;
  _MorphMode _axisWideMode = _MorphMode.banner;
  _MorphMode _axisTallMode = _MorphMode.stack;

  bool _alwaysFixedWidth = false;
  bool _alwaysFixedHeight = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showOverlay = true;
  bool _pulseAccent = true;

  double _tightness = 0.45;
  double _stageWidth = 380;
  double _stageHeight = 230;
  double _tileScale = 1;
  double _overlayOpacity = 0.22;
  double _cornerRadius = 18;

  Duration _duration = const Duration(milliseconds: 640);
  Duration _reverseDuration = const Duration(milliseconds: 360);

  int _toggleCount = 0;
  int _expandCount = 0;
  int _collapseCount = 0;
  int _settleCount = 0;
  int _curveSwitchCount = 0;
  int _presetApplyCount = 0;
  int _constraintSwitchCount = 0;
  int _sizePhaseCount = 0;

  String _phaseLabel = 'stable';
  Size _lastMeasuredSize = const Size(0, 0);
  DateTime _lastMeasureTime = DateTime.now();

  List<_TimelineItem> _timeline = const <_TimelineItem>[];

  @override
  void initState() {
    super.initState();
    _applyDurationPreset(_durationPresets[_durationPresetIndex], silent: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTimeline('Init', 'RenderAnimatedSizeState observatory initialized.');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    final List<_TimelineItem> next = <_TimelineItem>[
      _TimelineItem(time: DateTime.now(), title: title, message: message),
      ..._timeline,
    ];
    setState(() {
      _timeline = next.take(44).toList(growable: false);
    });
  }

  void _applyDurationPreset(_DurationPreset preset, {bool silent = false}) {
    setState(() {
      _duration = Duration(milliseconds: preset.forwardMs);
      _reverseDuration = Duration(milliseconds: preset.reverseMs);
    });
    if (!silent) {
      _presetApplyCount += 1;
      _addTimeline('Duration Preset', '${preset.label} applied (${preset.forwardMs}/${preset.reverseMs} ms).');
    }
  }

  void _switchMode(_MorphMode mode) {
    if (_mode == mode) {
      return;
    }
    setState(() {
      _mode = mode;
      _toggleCount += 1;
    });
    _addTimeline('Morph Mode', 'Primary stage changed to ${mode.name}.');
  }

  void _onPrimaryEnd() {
    _settleCount += 1;
    _setPhase('settled');
    _addTimeline('Animation End', 'Primary AnimatedSize onEnd reached.');
  }

  void _setPhase(String phase) {
    setState(() {
      _phaseLabel = phase;
      _sizePhaseCount += 1;
    });
  }

  void _classifySize(Size size) {
    final DateTime now = DateTime.now();
    final Duration delta = now.difference(_lastMeasureTime);
    if (delta.inMilliseconds < 36) {
      return;
    }
    final double areaOld = _lastMeasuredSize.width * _lastMeasuredSize.height;
    final double areaNew = size.width * size.height;

    String nextPhase = 'stable';
    if ((areaNew - areaOld).abs() > 0.8) {
      if (areaNew > areaOld) {
        nextPhase = 'expanding';
        _expandCount += 1;
      } else {
        nextPhase = 'shrinking';
        _collapseCount += 1;
      }
    } else {
      nextPhase = 'stabilizing';
    }

    _lastMeasuredSize = size;
    _lastMeasureTime = now;

    if (_phaseLabel != nextPhase) {
      _setPhase(nextPhase);
      _addTimeline('Phase', 'Phase changed to $nextPhase (${size.width.toStringAsFixed(1)} x ${size.height.toStringAsFixed(1)}).');
    }
  }

  BoxConstraints _buildPrimaryConstraints() {
    final double minW = 180 + (_tightness * 90);
    final double maxW = 460 - (_tightness * 70);
    final double minH = 120 + (_tightness * 70);
    final double maxH = 320 - (_tightness * 40);
    return BoxConstraints(
      minWidth: minW,
      maxWidth: maxW,
      minHeight: minH,
      maxHeight: maxH,
    );
  }

  Size _modeSize(_MorphMode mode) {
    return switch (mode) {
      _MorphMode.compact => const Size(86, 52),
      _MorphMode.card => const Size(146, 96),
      _MorphMode.panel => const Size(214, 138),
      _MorphMode.banner => const Size(260, 82),
      _MorphMode.stack => const Size(132, 168),
    };
  }

  List<_MetricItem> _metrics() {
    final Size modeSize = _modeSize(_mode);
    return <_MetricItem>[
      _MetricItem(
        label: 'Current Phase',
        value: _phaseLabel,
        note: 'Heuristic phase label reflecting transition behavior.',
        icon: Icons.route,
      ),
      _MetricItem(
        label: 'Mode',
        value: _mode.name,
        note: 'Current primary child shape mode.',
        icon: Icons.widgets_outlined,
      ),
      _MetricItem(
        label: 'Mode Size',
        value: '${modeSize.width.toStringAsFixed(0)} x ${modeSize.height.toStringAsFixed(0)}',
        note: 'Target child footprint for current mode.',
        icon: Icons.aspect_ratio,
      ),
      _MetricItem(
        label: 'Duration',
        value: '${_duration.inMilliseconds} ms',
        note: 'Forward transition duration.',
        icon: Icons.timer_outlined,
      ),
      _MetricItem(
        label: 'Reverse',
        value: '${_reverseDuration.inMilliseconds} ms',
        note: 'Reverse transition duration.',
        icon: Icons.replay,
      ),
      _MetricItem(
        label: 'Curve',
        value: _curvePresets[_curveIndex].label,
        note: _curvePresets[_curveIndex].note,
        icon: Icons.show_chart,
      ),
      _MetricItem(
        label: 'Constraint Tightness',
        value: _tightness.toStringAsFixed(2),
        note: 'Controls how much parent constraints squeeze transitions.',
        icon: Icons.compress,
      ),
      _MetricItem(
        label: 'Toggles',
        value: '$_toggleCount',
        note: 'Primary mode changes performed.',
        icon: Icons.swap_horiz,
      ),
      _MetricItem(
        label: 'Expands',
        value: '$_expandCount',
        note: 'Expanding phases observed.',
        icon: Icons.open_in_full,
      ),
      _MetricItem(
        label: 'Shrinks',
        value: '$_collapseCount',
        note: 'Shrinking phases observed.',
        icon: Icons.close_fullscreen,
      ),
      _MetricItem(
        label: 'Settles',
        value: '$_settleCount',
        note: 'AnimatedSize onEnd settle callbacks.',
        icon: Icons.check_circle_outline,
      ),
      _MetricItem(
        label: 'Curve Switches',
        value: '$_curveSwitchCount',
        note: 'Number of curve profile changes.',
        icon: Icons.change_circle_outlined,
      ),
      _MetricItem(
        label: 'Presets Applied',
        value: '$_presetApplyCount',
        note: 'Duration preset selection count.',
        icon: Icons.bookmark_added_outlined,
      ),
      _MetricItem(
        label: 'Constraint Switches',
        value: '$_constraintSwitchCount',
        note: 'Constraint mode toggles recorded.',
        icon: Icons.space_dashboard_outlined,
      ),
      _MetricItem(
        label: 'Phase Updates',
        value: '$_sizePhaseCount',
        note: 'Number of phase label updates.',
        icon: Icons.timeline,
      ),
      _MetricItem(
        label: 'Theme',
        value: _themePresets[_themeIndex].name,
        note: 'Current visual profile.',
        icon: Icons.palette_outlined,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset theme = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: theme.brightness),
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
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _header(scheme),
                        const SizedBox(height: 16),
                        _profileAndScenario(scheme),
                        const SizedBox(height: 16),
                        _primaryDeck(scheme),
                        const SizedBox(height: 16),
                        _constraintLab(scheme),
                        const SizedBox(height: 16),
                        _axisBoard(scheme),
                        const SizedBox(height: 16),
                        _reverseBoard(scheme),
                        const SizedBox(height: 16),
                        _metricsBoard(scheme),
                        const SizedBox(height: 16),
                        if (_showGuide) _guideBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showTimeline) _timelineBoard(scheme),
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

  Widget _header(ColorScheme scheme) {
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
                Icon(Icons.stacked_line_chart, color: scheme.primary, size: 24),
                Text(
                  'RenderAnimatedSizeState Observatory',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
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
              'Visual state-tracking demo for AnimatedSize transitions representing RenderAnimatedSizeState behavior.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileAndScenario(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themePresets.length, (int index) {
                final _ThemePreset preset = _themePresets[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(preset.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                    });
                    _addTimeline('Theme', 'Switched to ${preset.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 14),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                final _ScenarioPreset scenario = _scenarios[index];
                return FilterChip(
                  selected: index == _scenarioIndex,
                  label: Text(scenario.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                    });
                    _addTimeline('Scenario', scenario.subtitle);
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

  Widget _primaryDeck(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        if (narrow) {
          return Column(
            children: <Widget>[
              _stateTheater(scheme),
              const SizedBox(height: 16),
              _controlConsole(scheme),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _stateTheater(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _controlConsole(scheme)),
          ],
        );
      },
    );
  }

  Widget _stateTheater(ColorScheme scheme) {
    final BoxConstraints primaryConstraints = _buildPrimaryConstraints();

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
                Text('State Theater', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _mode = _MorphMode.card;
                      _phaseLabel = 'stable';
                    });
                    _addTimeline('Theater', 'Primary stage returned to card mode.');
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Normalize'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Primary AnimatedSize lane with phase labeling and adjustable constraints.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: _stageWidth,
                height: _stageHeight,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(_cornerRadius),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Stack(
                  children: <Widget>[
                    if (_showGrid)
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.24)),
                        ),
                      ),
                    if (_showOverlay)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: <Color>[
                                scheme.primary.withValues(alpha: _overlayOpacity),
                                scheme.surface.withValues(alpha: 0),
                              ],
                              radius: 1.12,
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: primaryConstraints,
                          child: _MeasureBox(
                            onLayout: _classifySize,
                            child: AnimatedSize(
                              duration: _duration,
                              reverseDuration: _reverseDuration,
                              curve: _curvePresets[_curveIndex].curve,
                              alignment: Alignment.center,
                              clipBehavior: Clip.hardEdge,
                              onEnd: _onPrimaryEnd,
                              child: _primaryMorphTile(scheme, _mode),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _chip(scheme, 'phase $_phaseLabel', Icons.flag_circle),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _chip(scheme, _curvePresets[_curveIndex].label, Icons.show_chart),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: _chip(scheme, '${_duration.inMilliseconds}/${_reverseDuration.inMilliseconds}ms', Icons.timer_outlined),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _MorphMode.values.map(( _MorphMode mode) {
                return ChoiceChip(
                  selected: mode == _mode,
                  label: Text(mode.name),
                  onSelected: (_) => _switchMode(mode),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(ColorScheme scheme, String text, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.92),
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

  Widget _primaryMorphTile(ColorScheme scheme, _MorphMode mode) {
    final Size size = _modeSize(mode);
    final double wobble = _pulseAccent ? (math.sin(DateTime.now().millisecond / 999 * math.pi * 2) * 0.04) : 0;

    return Transform.scale(
      scale: _tileScale + wobble,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _alwaysFixedWidth ? 180 : size.width,
        height: _alwaysFixedHeight ? 108 : size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: scheme.primary.withValues(alpha: 0.7)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: scheme.primary.withValues(alpha: 0.22), blurRadius: 14, offset: const Offset(0, 7)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('mode ${mode.name}', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(
                '${(_alwaysFixedWidth ? 180 : size.width).toStringAsFixed(0)} x ${(_alwaysFixedHeight ? 108 : size.height).toStringAsFixed(0)}',
                style: TextStyle(color: scheme.onPrimaryContainer),
              ),
              const SizedBox(height: 2),
              Text('phase $_phaseLabel', style: TextStyle(color: scheme.onPrimaryContainer)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controlConsole(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Control Console', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Tune duration, curves, constraints, stage geometry, and fixed-axis behavior.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            _slider(
              scheme: scheme,
              label: 'Constraint Tightness',
              value: _tightness,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _tightness = value),
              onChangeEnd: (double value) {
                _constraintSwitchCount += 1;
                _addTimeline('Constraints', 'Tightness set to ${value.toStringAsFixed(2)}.');
              },
            ),
            _slider(
              scheme: scheme,
              label: 'Stage Width',
              value: _stageWidth,
              min: 260,
              max: 640,
              divisions: 76,
              onChanged: (double value) => setState(() => _stageWidth = value),
              onChangeEnd: (double value) => _addTimeline('Stage', 'Width set to ${value.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 170,
              max: 420,
              divisions: 50,
              onChanged: (double value) => setState(() => _stageHeight = value),
              onChangeEnd: (double value) => _addTimeline('Stage', 'Height set to ${value.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Tile Scale',
              value: _tileScale,
              min: 0.5,
              max: 1.8,
              divisions: 52,
              onChanged: (double value) => setState(() => _tileScale = value),
              onChangeEnd: (double value) => _addTimeline('Tile', 'Scale set to ${value.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Overlay Opacity',
              value: _overlayOpacity,
              min: 0,
              max: 0.6,
              divisions: 30,
              onChanged: (double value) => setState(() => _overlayOpacity = value),
              onChangeEnd: (double value) => _addTimeline('Overlay', 'Opacity set to ${value.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Corner Radius',
              value: _cornerRadius,
              min: 0,
              max: 38,
              divisions: 38,
              onChanged: (double value) => setState(() => _cornerRadius = value),
              onChangeEnd: (double value) => _addTimeline('Stage', 'Corner radius set to ${value.toStringAsFixed(0)}.'),
            ),
            const Divider(height: 24),
            Text('Duration Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_durationPresets.length, (int index) {
                final _DurationPreset preset = _durationPresets[index];
                return ChoiceChip(
                  selected: index == _durationPresetIndex,
                  label: Text(preset.label),
                  onSelected: (_) {
                    setState(() {
                      _durationPresetIndex = index;
                    });
                    _applyDurationPreset(preset);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_durationPresets[_durationPresetIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            Text('Curve Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
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
                    });
                    _addTimeline('Curve', 'Switched to ${preset.label}.');
                  },
                );
              }),
            ),
            const Divider(height: 24),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _alwaysFixedWidth,
              title: const Text('Fix width to 180'),
              subtitle: const Text('Locks width to demonstrate height-only transitions.'),
              onChanged: (bool? value) {
                setState(() {
                  _alwaysFixedWidth = value ?? false;
                });
                _addTimeline('Axis Lock', _alwaysFixedWidth ? 'Width lock enabled.' : 'Width lock disabled.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _alwaysFixedHeight,
              title: const Text('Fix height to 108'),
              subtitle: const Text('Locks height to demonstrate width-only transitions.'),
              onChanged: (bool? value) {
                setState(() {
                  _alwaysFixedHeight = value ?? false;
                });
                _addTimeline('Axis Lock', _alwaysFixedHeight ? 'Height lock enabled.' : 'Height lock disabled.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _pulseAccent,
              title: const Text('Pulse accent'),
              onChanged: (bool? value) => setState(() => _pulseAccent = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGrid,
              title: const Text('Show background grid'),
              onChanged: (bool? value) => setState(() => _showGrid = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showOverlay,
              title: const Text('Show radial overlay'),
              onChanged: (bool? value) => setState(() => _showOverlay = value ?? true),
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

  Widget _constraintLab(ColorScheme scheme) {
    final List<_ConstraintCard> cards = <_ConstraintCard>[
      _ConstraintCard(
        title: 'Loose Envelope',
        note: 'Lets child expand naturally before settling.',
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 340, minHeight: 80, maxHeight: 240),
      ),
      _ConstraintCard(
        title: 'Tight Corridor',
        note: 'Narrow width with strong vertical pressure.',
        constraints: const BoxConstraints(minWidth: 210, maxWidth: 230, minHeight: 90, maxHeight: 220),
      ),
      _ConstraintCard(
        title: 'Wide Shelf',
        note: 'Roomy horizontal area with shallow height range.',
        constraints: const BoxConstraints(minWidth: 250, maxWidth: 390, minHeight: 70, maxHeight: 130),
      ),
    ];

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Constraint Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Three boards highlight how different parent constraints affect AnimatedSize transitions.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < 980) {
                  return Column(
                    children: cards.map(( _ConstraintCard card) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _constraintCardWidget(scheme, card),
                      );
                    }).toList(),
                  );
                }

                return Row(
                  children: cards.map(( _ConstraintCard card) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _constraintCardWidget(scheme, card),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _constraintCardWidget(ColorScheme scheme, _ConstraintCard card) {
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
            Text(card.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(card.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: card.constraints,
                  child: AnimatedSize(
                    duration: _duration,
                    reverseDuration: _reverseDuration,
                    curve: _curvePresets[_curveIndex].curve,
                    alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    onEnd: () {
                      _setPhase('settled');
                    },
                    child: _primaryMorphTile(scheme, _mode),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _axisBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Axis Emphasis Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Compare width-focused and height-focused transitions to reason about state changes.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 900;
                final Widget wide = _axisLane(
                  scheme: scheme,
                  title: 'Width Dominant',
                  mode: _axisWideMode,
                  onCycle: () {
                    setState(() {
                      _axisWideMode = _nextMode(_axisWideMode);
                    });
                    _addTimeline('Axis Lane', 'Width dominant lane switched to ${_axisWideMode.name}.');
                  },
                );
                final Widget tall = _axisLane(
                  scheme: scheme,
                  title: 'Height Dominant',
                  mode: _axisTallMode,
                  onCycle: () {
                    setState(() {
                      _axisTallMode = _nextMode(_axisTallMode);
                    });
                    _addTimeline('Axis Lane', 'Height dominant lane switched to ${_axisTallMode.name}.');
                  },
                );

                if (narrow) {
                  return Column(children: <Widget>[wide, const SizedBox(height: 10), tall]);
                }
                return Row(children: <Widget>[Expanded(child: wide), const SizedBox(width: 10), Expanded(child: tall)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  _MorphMode _nextMode(_MorphMode mode) {
    final int index = _MorphMode.values.indexOf(mode);
    return _MorphMode.values[(index + 1) % _MorphMode.values.length];
  }

  Widget _axisLane({required ColorScheme scheme, required String title, required _MorphMode mode, required VoidCallback onCycle}) {
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
                Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                const Spacer(),
                TextButton(onPressed: onCycle, child: const Text('Cycle')),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(
                child: AnimatedSize(
                  duration: _duration,
                  reverseDuration: _reverseDuration,
                  curve: _curvePresets[_curveIndex].curve,
                  alignment: Alignment.center,
                  child: _primaryMorphTile(scheme, mode),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reverseBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reverse Timing Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Observe asymmetric forward/reverse durations using paired expand and collapse actions.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _switchMode(_MorphMode.panel);
                      _addTimeline('Reverse Board', 'Expanded to panel for forward timing observation.');
                    },
                    icon: const Icon(Icons.open_in_full),
                    label: const Text('Expand'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _switchMode(_MorphMode.compact);
                      _addTimeline('Reverse Board', 'Collapsed to compact for reverse timing observation.');
                    },
                    icon: const Icon(Icons.close_fullscreen),
                    label: const Text('Collapse'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                    Text('Forward ${_duration.inMilliseconds} ms  |  Reverse ${_reverseDuration.inMilliseconds} ms',
                        style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(
                      'Use duration presets to test how return-path timing changes the perceived RenderAnimatedSizeState lifecycle.',
                      style: TextStyle(color: scheme.onSurfaceVariant),
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

  Widget _metricsBoard(ColorScheme scheme) {
    final List<_MetricItem> items = _metrics();

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
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
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.7 : 1.86,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricItem item = items[index];
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
                                  child: Text(item.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
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
            if (_showDiagnostics) _diagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _diagnosticsPanel(ColorScheme scheme) {
    final BoxConstraints c = _buildPrimaryConstraints();
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
                Icon(Icons.terminal, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Diagnostics Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('phase = $_phaseLabel', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('mode = ${_mode.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('curve = ${_curvePresets[_curveIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('duration = ${_duration.inMilliseconds}ms / reverse ${_reverseDuration.inMilliseconds}ms', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('constraints = ${c.minWidth.toStringAsFixed(0)}..${c.maxWidth.toStringAsFixed(0)} x ${c.minHeight.toStringAsFixed(0)}..${c.maxHeight.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('fixedWidth = $_alwaysFixedWidth, fixedHeight = $_alwaysFixedHeight', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _guideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._intro.map((String entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, color: scheme.primary, size: 8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(entry, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            Text('Best Practices', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._bestPractices.map((String entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Icon(Icons.check_circle_outline, color: scheme.secondary, size: 14),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(entry, style: TextStyle(color: scheme.onSurfaceVariant))),
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

  Widget _timelineBoard(ColorScheme scheme) {
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
                      _timeline = const <_TimelineItem>[];
                    });
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of transition state observations and control changes.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  child: Text('Timeline is empty. Trigger transitions to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
                ),
              )
            else
              Column(
                children: _timeline.map(( _TimelineItem item) {
                  final String stamp =
                      '${item.time.hour.toString().padLeft(2, '0')}:${item.time.minute.toString().padLeft(2, '0')}:${item.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text(item.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${item.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _ConstraintCard {
  const _ConstraintCard({required this.title, required this.note, required this.constraints});

  final String title;
  final String note;
  final BoxConstraints constraints;
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
      ..color = color.withValues(alpha: 0.82)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), centerPaint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), centerPaint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _MeasureBox extends SingleChildRenderObjectWidget {
  const _MeasureBox({required this.onLayout, super.child});

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMeasureBox(onLayout);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderMeasureBox renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMeasureBox extends RenderProxyBox {
  _RenderMeasureBox(this.onLayout);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}
