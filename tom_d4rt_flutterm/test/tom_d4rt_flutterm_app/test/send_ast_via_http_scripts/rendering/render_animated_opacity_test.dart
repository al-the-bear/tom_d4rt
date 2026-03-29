import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemeTrack> _themeTracks = <_ThemeTrack>[
  _ThemeTrack(
    id: 'lagoon',
    name: 'Lagoon Instrument',
    description: 'Cool profile for alpha transition precision and chart readability.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemeTrack(
    id: 'solar',
    name: 'Solar Workshop',
    description: 'Warm profile for presentation-style walkthroughs.',
    seed: Color(0xFFC2410C),
    brightness: Brightness.light,
  ),
  _ThemeTrack(
    id: 'slate',
    name: 'Slate Night',
    description: 'Dark profile to surface subtle opacity deltas.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemeTrack(
    id: 'meadow',
    name: 'Meadow Board',
    description: 'Balanced profile for extended diagnostics sessions.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioTrack> _scenarioTracks = <_ScenarioTrack>[
  _ScenarioTrack(
    id: 'render-host',
    title: 'Render Host Studio',
    subtitle: 'Direct RenderAnimatedOpacity usage with live alpha controls.',
  ),
  _ScenarioTrack(
    id: 'transition-rail',
    title: 'Transition Rail',
    subtitle: 'Timed transitions with staged checkpoints and alpha strip.',
  ),
  _ScenarioTrack(
    id: 'comparison',
    title: 'Comparison Gallery',
    subtitle: 'Render host vs AnimatedOpacity vs FadeTransition samples.',
  ),
  _ScenarioTrack(
    id: 'semantics',
    title: 'Semantics Behavior',
    subtitle: 'alwaysIncludeSemantics continuity and accessibility context.',
  ),
  _ScenarioTrack(
    id: 'operations',
    title: 'Operations Console',
    subtitle: 'Metrics, timeline, diagnostics, and reproducible controls.',
  ),
];

const List<_CurveTrack> _curveTracks = <_CurveTrack>[
  _CurveTrack(id: 'linear', label: 'Linear', curve: Curves.linear, note: 'Constant velocity alpha movement.'),
  _CurveTrack(id: 'in', label: 'Ease In', curve: Curves.easeIn, note: 'Delayed fade with late acceleration.'),
  _CurveTrack(id: 'out', label: 'Ease Out', curve: Curves.easeOut, note: 'Fast fade then gentle settle.'),
  _CurveTrack(id: 'inout', label: 'Ease InOut', curve: Curves.easeInOut, note: 'Balanced transitions across both ends.'),
  _CurveTrack(id: 'material', label: 'FastOutSlowIn', curve: Curves.fastOutSlowIn, note: 'Material motion emphasis profile.'),
  _CurveTrack(id: 'bounce', label: 'EaseOutBack', curve: Curves.easeOutBack, note: 'Expressive transition for showcase boards.'),
];

const List<_OpacityPreset> _opacityPresets = <_OpacityPreset>[
  _OpacityPreset(label: 'Invisible', value: 0),
  _OpacityPreset(label: 'Ghost', value: 0.15),
  _OpacityPreset(label: 'Hint', value: 0.35),
  _OpacityPreset(label: 'Balanced', value: 0.55),
  _OpacityPreset(label: 'Strong', value: 0.8),
  _OpacityPreset(label: 'Opaque', value: 1),
];

const List<String> _introduction = <String>[
  'RenderAnimatedOpacity is the render-object primitive that animates child alpha over time.',
  'It is used by higher-level widgets such as AnimatedOpacity and FadeTransition.',
  'This demo focuses on interpreter interaction and visual verification rather than assert-heavy checks.',
  'Multiple boards expose animation flow, semantics behavior, performance hints, and comparison lanes.',
  'You can drive transitions manually, apply curves, scrub controller values, and inspect resulting alpha.',
  'The timeline logs operations so rendering behavior can be audited while exploring controls.',
];

const List<String> _bestPractices = <String>[
  'Choose a curve that matches the interaction context and readability goals.',
  'Keep a direct render lane when diagnosing bridge-level animation behavior.',
  'Use manual scrubbing to inspect intermediate alpha values that auto playback can skip.',
  'Evaluate alwaysIncludeSemantics carefully when elements may become visually hidden.',
  'Avoid stacking many semi-transparent layers in critical performance paths without profiling.',
  'Use timeline logs to correlate control changes with unexpected transition outcomes.',
  'Compare render-level and widget-level lanes to spot behavior divergence quickly.',
  'Expose checkpoints and preset targets to reproduce known transition states reliably.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'How is RenderAnimatedOpacity different from Opacity?',
    answer:
        'RenderAnimatedOpacity consumes an animation and transitions alpha over time, while static Opacity applies a fixed value.',
  ),
  _FaqItem(
    question: 'Why keep a direct render host in this test?',
    answer:
        'Direct usage validates rendering bridge behavior at the same abstraction layer used internally by widgets.',
  ),
  _FaqItem(
    question: 'When should alwaysIncludeSemantics be true?',
    answer:
        'When accessibility continuity is needed even during near-invisible states.',
  ),
  _FaqItem(
    question: 'Why include AnimatedOpacity and FadeTransition lanes?',
    answer: 'They provide practical reference points for teams that typically work at widget level.',
  ),
];

class _ThemeTrack {
  const _ThemeTrack({
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

class _ScenarioTrack {
  const _ScenarioTrack({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _CurveTrack {
  const _CurveTrack({required this.id, required this.label, required this.curve, required this.note});

  final String id;
  final String label;
  final Curve curve;
  final String note;
}

class _OpacityPreset {
  const _OpacityPreset({required this.label, required this.value});

  final String label;
  final double value;
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
  return const _RenderAnimatedOpacityObservatory();
}

class _RenderAnimatedOpacityObservatory extends StatefulWidget {
  const _RenderAnimatedOpacityObservatory();

  @override
  State<_RenderAnimatedOpacityObservatory> createState() => _RenderAnimatedOpacityObservatoryState();
}

class _RenderAnimatedOpacityObservatoryState extends State<_RenderAnimatedOpacityObservatory>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _controller;
  late CurvedAnimation _curved;

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _curveIndex = 3;

  bool _alwaysIncludeSemantics = false;
  bool _autoPingPong = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showOverlay = true;

  double _targetAlpha = 0.22;
  double _durationMs = 1400;
  double _stageWidth = 360;
  double _stageHeight = 220;
  double _tileScale = 1;
  double _overlayOpacity = 0.24;

  int _playCount = 0;
  int _pauseCount = 0;
  int _forwardCount = 0;
  int _reverseCount = 0;
  int _scrubCount = 0;
  int _presetCount = 0;
  int _curveSwitchCount = 0;
  int _semanticsSwitchCount = 0;

  List<_TimelineItem> _timeline = const <_TimelineItem>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationMs.round()),
      value: 1,
    );
    _curved = CurvedAnimation(parent: _controller, curve: _curveTracks[_curveIndex].curve);
    _controller.addListener(_onControllerTick);
    _controller.addStatusListener(_onStatus);
    _addTimeline('Init', 'Animation controller initialized with value 1.00.');
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerTick);
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    _curved.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onControllerTick() {
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

    _addTimeline('Status', 'Controller status changed to $label.');

    if (_autoPingPong && status == AnimationStatus.dismissed) {
      _controller.forward();
      _addTimeline('Auto PingPong', 'Forward started after dismissed endpoint.');
    } else if (_autoPingPong && status == AnimationStatus.completed) {
      _controller.reverse();
      _addTimeline('Auto PingPong', 'Reverse started after completed endpoint.');
    }
  }

  void _addTimeline(String title, String message) {
    final List<_TimelineItem> next = <_TimelineItem>[
      _TimelineItem(time: DateTime.now(), title: title, message: message),
      ..._timeline,
    ];
    setState(() {
      _timeline = next.take(40).toList(growable: false);
    });
  }

  void _swapCurve(int index) {
    setState(() {
      _curveIndex = index;
      _curveSwitchCount += 1;
      _curved.dispose();
      _curved = CurvedAnimation(parent: _controller, curve: _curveTracks[_curveIndex].curve);
    });
    _addTimeline('Curve', 'Switched curve to ${_curveTracks[_curveIndex].label}.');
  }

  void _playToTarget() {
    _playCount += 1;
    _addTimeline('Play', 'Animating to target alpha ${_targetAlpha.toStringAsFixed(2)}.');
    _controller.animateTo(_targetAlpha, duration: Duration(milliseconds: _durationMs.round()));
  }

  void _pause() {
    _pauseCount += 1;
    _controller.stop();
    _addTimeline('Pause', 'Controller stop() requested.');
  }

  void _forwardFull() {
    _forwardCount += 1;
    _addTimeline('Forward', 'Animating to fully visible alpha 1.00.');
    _controller.animateTo(1, duration: Duration(milliseconds: _durationMs.round()));
  }

  void _reverseFull() {
    _reverseCount += 1;
    _addTimeline('Reverse', 'Animating to fully transparent alpha 0.00.');
    _controller.animateTo(0, duration: Duration(milliseconds: _durationMs.round()));
  }

  void _scrub(double value) {
    _scrubCount += 1;
    _controller.value = value;
    _addTimeline('Scrub', 'Controller value manually set to ${value.toStringAsFixed(2)}.');
  }

  void _applyAlphaPreset(_OpacityPreset preset) {
    _presetCount += 1;
    setState(() {
      _targetAlpha = preset.value;
      _controller.value = preset.value;
    });
    _addTimeline('Preset', '${preset.label} applied at alpha ${preset.value.toStringAsFixed(2)}.');
  }

  void _updateDuration(double ms) {
    setState(() {
      _durationMs = ms;
      _controller.duration = Duration(milliseconds: ms.round());
    });
    _addTimeline('Duration', 'Duration changed to ${ms.toStringAsFixed(0)} ms.');
  }

  void _resetAll() {
    setState(() {
      _scenarioIndex = 0;
      _curveIndex = 3;
      _alwaysIncludeSemantics = false;
      _autoPingPong = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showOverlay = true;
      _targetAlpha = 0.22;
      _durationMs = 1400;
      _stageWidth = 360;
      _stageHeight = 220;
      _tileScale = 1;
      _overlayOpacity = 0.24;
      _playCount = 0;
      _pauseCount = 0;
      _forwardCount = 0;
      _reverseCount = 0;
      _scrubCount = 0;
      _presetCount = 0;
      _curveSwitchCount = 0;
      _semanticsSwitchCount = 0;
      _timeline = const <_TimelineItem>[];
      _controller.duration = Duration(milliseconds: _durationMs.round());
      _controller.value = 1;
      _curved.dispose();
      _curved = CurvedAnimation(parent: _controller, curve: _curveTracks[_curveIndex].curve);
    });
    _addTimeline('Reset', 'RenderAnimatedOpacity observatory reset to defaults.');
  }

  List<_MetricItem> _buildMetrics() {
    return <_MetricItem>[
      _MetricItem(
        label: 'Controller Value',
        value: _controller.value.toStringAsFixed(3),
        note: 'Raw controller output before curve transformation.',
        icon: Icons.speed,
      ),
      _MetricItem(
        label: 'Curved Alpha',
        value: _curved.value.toStringAsFixed(3),
        note: 'Alpha used by RenderAnimatedOpacity painting path.',
        icon: Icons.opacity,
      ),
      _MetricItem(
        label: 'Target Alpha',
        value: _targetAlpha.toStringAsFixed(2),
        note: 'Goal alpha used by Play action.',
        icon: Icons.flag_outlined,
      ),
      _MetricItem(
        label: 'Duration',
        value: '${_durationMs.toStringAsFixed(0)} ms',
        note: 'Animation duration used for transition commands.',
        icon: Icons.timer_outlined,
      ),
      _MetricItem(
        label: 'Curve',
        value: _curveTracks[_curveIndex].label,
        note: _curveTracks[_curveIndex].note,
        icon: Icons.show_chart,
      ),
      _MetricItem(
        label: 'Semantics',
        value: _alwaysIncludeSemantics ? 'Always Included' : 'Default',
        note: 'Accessibility policy while alpha drops.',
        icon: Icons.accessibility_new,
      ),
      _MetricItem(
        label: 'Play Count',
        value: '$_playCount',
        note: 'Manual play commands sent to controller.',
        icon: Icons.play_arrow,
      ),
      _MetricItem(
        label: 'Pause Count',
        value: '$_pauseCount',
        note: 'Manual stop commands.',
        icon: Icons.pause,
      ),
      _MetricItem(
        label: 'Forward Count',
        value: '$_forwardCount',
        note: 'Transitions to alpha 1.0.',
        icon: Icons.arrow_upward,
      ),
      _MetricItem(
        label: 'Reverse Count',
        value: '$_reverseCount',
        note: 'Transitions to alpha 0.0.',
        icon: Icons.arrow_downward,
      ),
      _MetricItem(
        label: 'Scrubs',
        value: '$_scrubCount',
        note: 'Manual value scrub interactions.',
        icon: Icons.tune,
      ),
      _MetricItem(
        label: 'Preset Uses',
        value: '$_presetCount',
        note: 'Times alpha presets were applied.',
        icon: Icons.bookmark_added_outlined,
      ),
      _MetricItem(
        label: 'Curve Switches',
        value: '$_curveSwitchCount',
        note: 'How often curve profile changed.',
        icon: Icons.swap_horiz,
      ),
      _MetricItem(
        label: 'Semantics Toggles',
        value: '$_semanticsSwitchCount',
        note: 'alwaysIncludeSemantics toggles recorded.',
        icon: Icons.toggle_on,
      ),
      _MetricItem(
        label: 'Theme',
        value: _themeTracks[_themeIndex].name,
        note: 'Current visual profile.',
        icon: Icons.palette_outlined,
      ),
      _MetricItem(
        label: 'Scenario',
        value: _scenarioTracks[_scenarioIndex].title,
        note: 'Current narrative lane.',
        icon: Icons.view_quilt_outlined,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeTrack track = _themeTracks[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: track.seed, brightness: track.brightness);

    return Theme(
      data: ThemeData(colorScheme: scheme, useMaterial3: true, brightness: track.brightness),
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
                        _profileScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _primaryDeck(scheme),
                        const SizedBox(height: 16),
                        _transitionRailBoard(scheme),
                        const SizedBox(height: 16),
                        _comparisonBoard(scheme),
                        const SizedBox(height: 16),
                        _semanticsBoard(scheme),
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
                Icon(Icons.opacity_rounded, color: scheme.primary, size: 24),
                Text(
                  'RenderAnimatedOpacity Transition Observatory',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _scenarioTracks[_scenarioIndex].title,
                    style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'A deep visual demo for render-layer animated opacity, semantics behavior, and transition diagnostics.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileScenarioBoard(ColorScheme scheme) {
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
              children: List<Widget>.generate(_themeTracks.length, (int index) {
                final _ThemeTrack t = _themeTracks[index];
                return ChoiceChip(
                  selected: index == _themeIndex,
                  label: Text(t.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                    });
                    _addTimeline('Theme', 'Switched to ${t.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(_themeTracks[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 14),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioTracks.length, (int index) {
                final _ScenarioTrack s = _scenarioTracks[index];
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
            Text(_scenarioTracks[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
              _renderHostBoard(scheme),
              const SizedBox(height: 16),
              _controlBoard(scheme),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _renderHostBoard(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _controlBoard(scheme)),
          ],
        );
      },
    );
  }

  Widget _renderHostBoard(ColorScheme scheme) {
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
                Text('Render Host Studio', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _resetAll,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Direct RenderAnimatedOpacity host using the same animation source as all companion boards.',
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
                          painter: _GridOverlayPainter(color: scheme.outlineVariant.withValues(alpha: 0.24)),
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
                              radius: 1.1,
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Center(
                        child: _RenderAnimatedOpacityHost(
                          opacity: _curved,
                          alwaysIncludeSemantics: _alwaysIncludeSemantics,
                          child: Transform.scale(scale: _tileScale, child: _stageTile(scheme)),
                        ),
                      ),
                    ),
                    Positioned(top: 10, left: 10, child: _tagChip(scheme, 'alpha ${_curved.value.toStringAsFixed(2)}', Icons.opacity)),
                    Positioned(top: 10, right: 10, child: _tagChip(scheme, _curveTracks[_curveIndex].label, Icons.show_chart)),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: _tagChip(
                        scheme,
                        _alwaysIncludeSemantics ? 'Semantics Always' : 'Semantics Default',
                        Icons.accessibility_new,
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
                FilledButton.icon(onPressed: _playToTarget, icon: const Icon(Icons.play_arrow), label: const Text('Play To Target')),
                OutlinedButton.icon(onPressed: _pause, icon: const Icon(Icons.pause), label: const Text('Pause')),
                OutlinedButton.icon(onPressed: _forwardFull, icon: const Icon(Icons.arrow_upward), label: const Text('To 1.0')),
                OutlinedButton.icon(onPressed: _reverseFull, icon: const Icon(Icons.arrow_downward), label: const Text('To 0.0')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagChip(ColorScheme scheme, String label, IconData icon) {
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
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _stageTile(ColorScheme scheme) {
    return Container(
      width: 154,
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: scheme.primary.withValues(alpha: 0.3), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('RenderAnimatedOpacity', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 12)),
            const Spacer(),
            Text('controller ${_controller.value.toStringAsFixed(2)}', style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 12)),
            const SizedBox(height: 2),
            Text('curved ${_curved.value.toStringAsFixed(2)}', style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _controlBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Control Console', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              'Tune transitions, scale, semantics, and stage visuals in real time.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            _sliderLine(
              scheme: scheme,
              label: 'Scrub Value',
              value: _controller.value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _controller.value = value),
              onChangeEnd: _scrub,
            ),
            _sliderLine(
              scheme: scheme,
              label: 'Target Alpha',
              value: _targetAlpha,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _targetAlpha = value),
              onChangeEnd: (double value) => _addTimeline('Target', 'Target alpha set to ${value.toStringAsFixed(2)}.'),
            ),
            _sliderLine(
              scheme: scheme,
              label: 'Duration (ms)',
              value: _durationMs,
              min: 180,
              max: 3600,
              divisions: 76,
              onChanged: (double value) => setState(() => _durationMs = value),
              onChangeEnd: _updateDuration,
            ),
            _sliderLine(
              scheme: scheme,
              label: 'Stage Width',
              value: _stageWidth,
              min: 240,
              max: 620,
              divisions: 76,
              onChanged: (double value) => setState(() => _stageWidth = value),
              onChangeEnd: (double value) => _addTimeline('Stage Width', 'Stage width set to ${value.toStringAsFixed(0)}.'),
            ),
            _sliderLine(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 160,
              max: 420,
              divisions: 65,
              onChanged: (double value) => setState(() => _stageHeight = value),
              onChangeEnd: (double value) => _addTimeline('Stage Height', 'Stage height set to ${value.toStringAsFixed(0)}.'),
            ),
            _sliderLine(
              scheme: scheme,
              label: 'Tile Scale',
              value: _tileScale,
              min: 0.5,
              max: 1.8,
              divisions: 52,
              onChanged: (double value) => setState(() => _tileScale = value),
              onChangeEnd: (double value) => _addTimeline('Tile Scale', 'Tile scale set to ${value.toStringAsFixed(2)}.'),
            ),
            _sliderLine(
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
            Text('Curve Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_curveTracks.length, (int index) {
                final _CurveTrack c = _curveTracks[index];
                return ChoiceChip(selected: index == _curveIndex, label: Text(c.label), onSelected: (_) => _swapCurve(index));
              }),
            ),
            const SizedBox(height: 8),
            Text(_curveTracks[_curveIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 24),
            Text('Alpha Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _opacityPresets.map(( _OpacityPreset preset) {
                return ActionChip(
                  label: Text('${preset.label} ${preset.value.toStringAsFixed(2)}'),
                  onPressed: () => _applyAlphaPreset(preset),
                );
              }).toList(),
            ),
            const Divider(height: 24),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _alwaysIncludeSemantics,
              title: const Text('alwaysIncludeSemantics'),
              subtitle: const Text('Keep semantics when alpha approaches zero.'),
              onChanged: (bool? value) {
                setState(() {
                  _alwaysIncludeSemantics = value ?? false;
                  _semanticsSwitchCount += 1;
                });
                _addTimeline('Semantics', _alwaysIncludeSemantics ? 'alwaysIncludeSemantics enabled.' : 'alwaysIncludeSemantics disabled.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _autoPingPong,
              title: const Text('Auto ping-pong'),
              onChanged: (bool? value) {
                setState(() => _autoPingPong = value ?? false);
                _addTimeline('Auto PingPong', _autoPingPong ? 'Auto ping-pong enabled.' : 'Auto ping-pong disabled.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGrid,
              title: const Text('Show stage grid'),
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

  Widget _sliderLine({
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

  Widget _transitionRailBoard(ColorScheme scheme) {
    final List<double> checkpoints = <double>[1, 0.75, 0.5, 0.25, 0];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Transition Rail', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Checkpoint strip for repeatable alpha states and visual transition sweeps.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: checkpoints.map((double value) {
                return ElevatedButton(
                  onPressed: () {
                    _scrub(value);
                  },
                  child: Text('Set ${value.toStringAsFixed(2)}'),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Container(
              height: 72,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Row(
                children: List<Widget>.generate(20, (int index) {
                  final double alpha = index / 19;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: scheme.primary.withValues(alpha: alpha),
                      ),
                      child: index % 5 == 0
                          ? Center(
                              child: Text(
                                alpha.toStringAsFixed(2),
                                style: TextStyle(color: scheme.onPrimary, fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            )
                          : null,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Comparison Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Three coordinated lanes using the same animation source for behavior comparison.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1020;
                final List<Widget> cards = <Widget>[
                  _comparisonCard(
                    scheme: scheme,
                    title: 'RenderAnimatedOpacity',
                    subtitle: 'Direct render object path.',
                    child: _RenderAnimatedOpacityHost(
                      opacity: _curved,
                      alwaysIncludeSemantics: _alwaysIncludeSemantics,
                      child: _comparisonTile(scheme, 'Render Host'),
                    ),
                  ),
                  _comparisonCard(
                    scheme: scheme,
                    title: 'AnimatedOpacity',
                    subtitle: 'Widget-driven implicit path.',
                    child: AnimatedOpacity(
                      opacity: _curved.value,
                      duration: Duration(milliseconds: _durationMs.round()),
                      child: _comparisonTile(scheme, 'AnimatedOpacity'),
                    ),
                  ),
                  _comparisonCard(
                    scheme: scheme,
                    title: 'FadeTransition',
                    subtitle: 'Transition widget with explicit animation.',
                    child: FadeTransition(
                      opacity: _curved,
                      child: _comparisonTile(scheme, 'FadeTransition'),
                    ),
                  ),
                ];

                if (narrow) {
                  return Column(
                    children: <Widget>[
                      cards[0],
                      const SizedBox(height: 10),
                      cards[1],
                      const SizedBox(height: 10),
                      cards[2],
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Expanded(child: cards[0]),
                    const SizedBox(width: 10),
                    Expanded(child: cards[1]),
                    const SizedBox(width: 10),
                    Expanded(child: cards[2]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required Widget child}) {
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
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: scheme.surface,
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(child: child),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonTile(ColorScheme scheme, String label) {
    return Container(
      width: 120,
      height: 82,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.7)),
      ),
      child: Center(
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _semanticsBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Semantics Behavior Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Side-by-side lanes highlighting semantics policy under low-opacity states.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 900;
                final Widget left = _semanticsLane(scheme: scheme, title: 'Default Semantics', enabled: false);
                final Widget right = _semanticsLane(scheme: scheme, title: 'Always Include Semantics', enabled: true);
                if (narrow) {
                  return Column(children: <Widget>[left, const SizedBox(height: 10), right]);
                }
                return Row(children: <Widget>[Expanded(child: left), const SizedBox(width: 10), Expanded(child: right)]);
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
                  ? 'Semantics tree remains available even as alpha approaches zero.'
                  : 'Semantics follow default visibility behavior at very low alpha.',
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
                  opacity: _curved,
                  alwaysIncludeSemantics: enabled,
                  child: Container(
                    width: 128,
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

  Widget _metricsBoard(ColorScheme scheme) {
    final List<_MetricItem> metrics = _buildMetrics();
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
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.8 : 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricItem m = metrics[index];
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
                                Icon(m.icon, color: scheme.primary, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(m.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              m.value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              m.note,
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
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
            Text('controller.value = ${_controller.value.toStringAsFixed(3)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('curved.value = ${_curved.value.toStringAsFixed(3)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('target alpha = ${_targetAlpha.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('duration = ${_durationMs.toStringAsFixed(0)} ms', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('alwaysIncludeSemantics = $_alwaysIncludeSemantics', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('curve = ${_curveTracks[_curveIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _guideBoard(ColorScheme scheme) {
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
            ..._introduction.map((String item) {
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

  Widget _timelineBoard(ColorScheme scheme) {
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
                      _timeline = const <_TimelineItem>[];
                    });
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of animation and control interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  child: Text('Timeline is empty. Interact with controls to generate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                      color: scheme.surfaceContainerLow,
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

class _GridOverlayPainter extends CustomPainter {
  _GridOverlayPainter({required this.color});

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

    final Paint cross = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), cross);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), cross);
  }

  @override
  bool shouldRepaint(covariant _GridOverlayPainter oldDelegate) {
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
    return RenderAnimatedOpacity(opacity: opacity, alwaysIncludeSemantics: alwaysIncludeSemantics);
  }

  @override
  void updateRenderObject(BuildContext context, RenderAnimatedOpacity renderObject) {
    renderObject
      ..opacity = opacity
      ..alwaysIncludeSemantics = alwaysIncludeSemantics;
  }
}
