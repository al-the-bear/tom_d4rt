import 'package:flutter/material.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'cobalt',
    name: 'Cobalt Deck',
    description: 'High-clarity profile for watching size interpolation and alignment shifts.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Studio',
    description: 'Warm profile for training and walkthrough sessions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'graphite',
    name: 'Graphite Night',
    description: 'Dark profile that highlights clipping and bounds transitions.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'pine',
    name: 'Pine Lab',
    description: 'Balanced profile for long-duration diagnostics sessions.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioPreset> _scenarioPresets = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'alignment',
    title: 'Alignment Cockpit',
    subtitle: 'Observe how RenderAnimatedSize alignment anchors shape during transitions.',
  ),
  _ScenarioPreset(
    id: 'clip',
    title: 'Clip Gallery',
    subtitle: 'Compare clipBehavior variants with oversized animated children.',
  ),
  _ScenarioPreset(
    id: 'timing',
    title: 'Timing Runway',
    subtitle: 'Forward/reverse duration asymmetry with repeated expansion and collapse.',
  ),
  _ScenarioPreset(
    id: 'constraints',
    title: 'Constraint Stress',
    subtitle: 'Tight vs loose parent spaces and adaptive transition outcomes.',
  ),
  _ScenarioPreset(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Metrics, lifecycle timeline, and reproducible control surfaces.',
  ),
];

const List<_CurvePreset> _curvePresets = <_CurvePreset>[
  _CurvePreset(label: 'Linear', curve: Curves.linear, note: 'Uniform interpolation progress.'),
  _CurvePreset(label: 'Ease InOut', curve: Curves.easeInOut, note: 'Balanced start and settle profile.'),
  _CurvePreset(label: 'FastOutSlowIn', curve: Curves.fastOutSlowIn, note: 'Material-like acceleration and settle.'),
  _CurvePreset(label: 'EaseOutCubic', curve: Curves.easeOutCubic, note: 'Fast acceleration with smooth final approach.'),
  _CurvePreset(label: 'Decelerate', curve: Curves.decelerate, note: 'Helpful when emphasizing final-state stability.'),
];

const List<_DurationPreset> _durationPresets = <_DurationPreset>[
  _DurationPreset(label: 'Snappy', forwardMs: 260, reverseMs: 180, note: 'Quick adaptive interfaces.'),
  _DurationPreset(label: 'Balanced', forwardMs: 620, reverseMs: 420, note: 'General-purpose demonstration profile.'),
  _DurationPreset(label: 'Expressive', forwardMs: 1100, reverseMs: 780, note: 'Long transitions for educational demos.'),
  _DurationPreset(label: 'Slow Return', forwardMs: 760, reverseMs: 1360, note: 'Reverse path clearly slower than forward.'),
  _DurationPreset(label: 'Fast Return', forwardMs: 1050, reverseMs: 300, note: 'Reverse path intentionally accelerated.'),
];

const List<String> _intro = <String>[
  'RenderAnimatedSize is the render-layer class behind AnimatedSize transitions.',
  'It animates between previous and current child sizes while respecting alignment and constraints.',
  'This deep demo is visual-first, focused on interpreter behavior instead of assert-heavy correctness tests.',
  'Different boards highlight alignment anchoring, clipping, duration asymmetry, and parent-constraint influence.',
  'Lifecycle counters and timeline logs provide operational visibility during interactive exploration.',
  'Guidance and FAQ sections connect visual behavior to practical usage choices in app code.',
];

const List<String> _bestPractices = <String>[
  'Tune forward and reverse durations independently when collapse and expansion should feel different.',
  'Use alignment intentionally to communicate where growth originates during transitions.',
  'Validate transitions under both tight and loose constraints before shipping reusable components.',
  'Enable clipping deliberately when child overflow can appear during motion.',
  'Use scenario presets to reproduce transition states consistently while debugging regressions.',
  'Pair transition visuals with timeline logs to diagnose unexpected size jumps.',
  'Avoid overusing large animated size regions in dense lists without profiling frame stability.',
  'Document expected transition phase behavior for team members maintaining shared widgets.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'How is RenderAnimatedSize typically used?',
    answer: 'Most apps access it through AnimatedSize, which configures and drives the underlying render object.',
  ),
  _FaqItem(
    question: 'Why does alignment matter during size change?',
    answer: 'Alignment defines the visual anchor, affecting whether content appears to grow from top, center, or edges.',
  ),
  _FaqItem(
    question: 'When should reverseDuration differ from duration?',
    answer: 'When user experience benefits from faster collapse or slower return transitions.',
  ),
  _FaqItem(
    question: 'What common issue does clipBehavior address?',
    answer: 'Temporary overflow artifacts while child and parent sizes are not yet synchronized during interpolation.',
  ),
];

enum _MorphMode {
  compact,
  card,
  panel,
  banner,
  tall,
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

class _CurvePreset {
  const _CurvePreset({required this.label, required this.curve, required this.note});

  final String label;
  final Curve curve;
  final String note;
}

class _DurationPreset {
  const _DurationPreset({required this.label, required this.forwardMs, required this.reverseMs, required this.note});

  final String label;
  final int forwardMs;
  final int reverseMs;
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
  return const _RenderAnimatedSizeStudio();
}

class _RenderAnimatedSizeStudio extends StatefulWidget {
  const _RenderAnimatedSizeStudio();

  @override
  State<_RenderAnimatedSizeStudio> createState() => _RenderAnimatedSizeStudioState();
}

class _RenderAnimatedSizeStudioState extends State<_RenderAnimatedSizeStudio> {
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _curveIndex = 2;
  int _durationPresetIndex = 1;

  _MorphMode _mode = _MorphMode.card;
  _MorphMode _clipMode = _MorphMode.panel;
  _MorphMode _tightMode = _MorphMode.banner;
  _MorphMode _looseMode = _MorphMode.tall;

  Alignment _alignment = Alignment.center;
  Clip _clipBehavior = Clip.hardEdge;

  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showOverlay = true;

  double _stageWidth = 390;
  double _stageHeight = 230;
  double _tightness = 0.38;
  double _tileScale = 1;
  double _overlayOpacity = 0.24;
  double _cornerRadius = 18;

  Duration _duration = const Duration(milliseconds: 620);
  Duration _reverseDuration = const Duration(milliseconds: 420);

  int _toggleCount = 0;
  int _expandCount = 0;
  int _collapseCount = 0;
  int _onEndCount = 0;
  int _curveSwitchCount = 0;
  int _alignmentSwitchCount = 0;
  int _clipSwitchCount = 0;
  int _presetCount = 0;

  String _phase = 'stable';
  List<_TimelineItem> _timeline = const <_TimelineItem>[];

  @override
  void initState() {
    super.initState();
    _applyDurationPreset(_durationPresets[_durationPresetIndex], silent: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTimeline('Init', 'RenderAnimatedSize dynamics studio initialized.');
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

  void _setMode(_MorphMode mode) {
    if (_mode == mode) {
      return;
    }
    final Size previous = _sizeForMode(_mode);
    final Size next = _sizeForMode(mode);
    setState(() {
      _mode = mode;
      _toggleCount += 1;
    });
    if ((next.width * next.height) > (previous.width * previous.height)) {
      _expandCount += 1;
      _phase = 'expanding';
    } else {
      _collapseCount += 1;
      _phase = 'shrinking';
    }
    _addTimeline('Mode', 'Primary mode changed to ${mode.name}.');
  }

  void _onEnd() {
    _onEndCount += 1;
    setState(() {
      _phase = 'settled';
    });
    _addTimeline('onEnd', 'AnimatedSize transition reached settle point.');
  }

  Size _sizeForMode(_MorphMode mode) {
    return switch (mode) {
      _MorphMode.compact => const Size(90, 58),
      _MorphMode.card => const Size(150, 98),
      _MorphMode.panel => const Size(220, 142),
      _MorphMode.banner => const Size(264, 84),
      _MorphMode.tall => const Size(136, 180),
    };
  }

  Widget _morphTile(ColorScheme scheme, _MorphMode mode, {bool emphasizeOverflow = false}) {
    final Size size = _sizeForMode(mode);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: size.width,
      height: size.height,
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
      child: Stack(
        children: <Widget>[
          if (emphasizeOverflow)
            Positioned(
              right: -16,
              bottom: -10,
              child: Container(width: 52, height: 52, decoration: BoxDecoration(color: scheme.tertiary.withValues(alpha: 0.5), shape: BoxShape.circle)),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('mode ${mode.name}', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text('${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)}', style: TextStyle(color: scheme.onPrimaryContainer)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applyDurationPreset(_DurationPreset preset, {bool silent = false}) {
    setState(() {
      _duration = Duration(milliseconds: preset.forwardMs);
      _reverseDuration = Duration(milliseconds: preset.reverseMs);
    });
    if (!silent) {
      _presetCount += 1;
      _addTimeline('Duration Preset', '${preset.label} applied (${preset.forwardMs}/${preset.reverseMs} ms).');
    }
  }

  void _resetConsole() {
    setState(() {
      _scenarioIndex = 0;
      _curveIndex = 2;
      _durationPresetIndex = 1;
      _mode = _MorphMode.card;
      _clipMode = _MorphMode.panel;
      _tightMode = _MorphMode.banner;
      _looseMode = _MorphMode.tall;
      _alignment = Alignment.center;
      _clipBehavior = Clip.hardEdge;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showOverlay = true;
      _stageWidth = 390;
      _stageHeight = 230;
      _tightness = 0.38;
      _tileScale = 1;
      _overlayOpacity = 0.24;
      _cornerRadius = 18;
      _toggleCount = 0;
      _expandCount = 0;
      _collapseCount = 0;
      _onEndCount = 0;
      _curveSwitchCount = 0;
      _alignmentSwitchCount = 0;
      _clipSwitchCount = 0;
      _presetCount = 0;
      _phase = 'stable';
      _timeline = const <_TimelineItem>[];
    });
    _applyDurationPreset(_durationPresets[_durationPresetIndex], silent: true);
    _addTimeline('Reset', 'RenderAnimatedSize console reset to defaults.');
  }

  BoxConstraints _tightConstraints() {
    final double minW = 170 + (40 * _tightness);
    final double maxW = 220 + (20 * _tightness);
    final double minH = 80 + (40 * _tightness);
    final double maxH = 140 + (40 * _tightness);
    return BoxConstraints(minWidth: minW, maxWidth: maxW, minHeight: minH, maxHeight: maxH);
  }

  BoxConstraints _looseConstraints() {
    final double maxW = 320 + (80 * (1 - _tightness));
    final double maxH = 250 + (70 * (1 - _tightness));
    return BoxConstraints(minWidth: 90, maxWidth: maxW, minHeight: 70, maxHeight: maxH);
  }

  List<_MetricItem> _metrics() {
    return <_MetricItem>[
      _MetricItem(label: 'Phase', value: _phase, note: 'Current transition phase label.', icon: Icons.route),
      _MetricItem(label: 'Mode', value: _mode.name, note: 'Current primary morph mode.', icon: Icons.widgets_outlined),
      _MetricItem(label: 'Duration', value: '${_duration.inMilliseconds} ms', note: 'Forward transition duration.', icon: Icons.timer_outlined),
      _MetricItem(label: 'Reverse', value: '${_reverseDuration.inMilliseconds} ms', note: 'Reverse transition duration.', icon: Icons.replay),
      _MetricItem(label: 'Curve', value: _curvePresets[_curveIndex].label, note: _curvePresets[_curveIndex].note, icon: Icons.show_chart),
      _MetricItem(label: 'Alignment', value: '(${_alignment.x.toStringAsFixed(1)}, ${_alignment.y.toStringAsFixed(1)})', note: 'AnimatedSize anchor alignment.', icon: Icons.my_location_outlined),
      _MetricItem(label: 'Clip', value: _clipBehavior.name, note: 'Clip behavior for overflow during transitions.', icon: Icons.crop),
      _MetricItem(label: 'Constraint Tightness', value: _tightness.toStringAsFixed(2), note: 'Pressure level in constraint lab.', icon: Icons.compress),
      _MetricItem(label: 'Toggles', value: '$_toggleCount', note: 'Primary mode toggle count.', icon: Icons.swap_horiz),
      _MetricItem(label: 'Expands', value: '$_expandCount', note: 'Expanding transitions observed.', icon: Icons.open_in_full),
      _MetricItem(label: 'Shrinks', value: '$_collapseCount', note: 'Shrinking transitions observed.', icon: Icons.close_fullscreen),
      _MetricItem(label: 'onEnd Calls', value: '$_onEndCount', note: 'AnimatedSize onEnd callback count.', icon: Icons.check_circle_outline),
      _MetricItem(label: 'Curve Switches', value: '$_curveSwitchCount', note: 'Curve profile changes.', icon: Icons.change_circle_outlined),
      _MetricItem(label: 'Alignment Switches', value: '$_alignmentSwitchCount', note: 'Alignment toggles applied.', icon: Icons.align_horizontal_center),
      _MetricItem(label: 'Clip Switches', value: '$_clipSwitchCount', note: 'Clip behavior changes.', icon: Icons.content_cut),
      _MetricItem(label: 'Preset Uses', value: '$_presetCount', note: 'Duration preset usage count.', icon: Icons.bookmark_added_outlined),
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
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildProfileScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildPrimaryDeck(scheme),
                        const SizedBox(height: 16),
                        _buildClipGallery(scheme),
                        const SizedBox(height: 16),
                        _buildConstraintStressBoard(scheme),
                        const SizedBox(height: 16),
                        _buildTimingRunway(scheme),
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
                Icon(Icons.animation_outlined, color: scheme.primary, size: 24),
                Text(
                  'RenderAnimatedSize Dynamics Studio',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioPresets[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Visual and interactive demonstration of size transitions representing RenderAnimatedSize behavior through AnimatedSize.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileScenarioBoard(ColorScheme scheme) {
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
              children: List<Widget>.generate(_scenarioPresets.length, (int index) {
                final _ScenarioPreset scenario = _scenarioPresets[index];
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
            Text(_scenarioPresets[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryDeck(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        if (narrow) {
          return Column(children: <Widget>[_buildAlignmentCockpit(scheme), const SizedBox(height: 16), _buildControlConsole(scheme)]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _buildAlignmentCockpit(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _buildControlConsole(scheme)),
          ],
        );
      },
    );
  }

  Widget _buildAlignmentCockpit(ColorScheme scheme) {
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
                Text('Alignment Cockpit', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetConsole, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Primary AnimatedSize stage demonstrating alignment anchoring and lifecycle callbacks.',
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
                      Positioned.fill(child: CustomPaint(painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.24)))),
                    if (_showOverlay)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: <Color>[scheme.primary.withValues(alpha: _overlayOpacity), scheme.surface.withValues(alpha: 0)],
                              radius: 1.1,
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Center(
                        child: AnimatedSize(
                          duration: _duration,
                          reverseDuration: _reverseDuration,
                          curve: _curvePresets[_curveIndex].curve,
                          alignment: _alignment,
                          clipBehavior: _clipBehavior,
                          onEnd: _onEnd,
                          child: Transform.scale(scale: _tileScale, child: _morphTile(scheme, _mode)),
                        ),
                      ),
                    ),
                    Positioned(top: 10, left: 10, child: _buildChip(scheme, 'phase $_phase', Icons.flag_circle)),
                    Positioned(top: 10, right: 10, child: _buildChip(scheme, _curvePresets[_curveIndex].label, Icons.show_chart)),
                    Positioned(bottom: 10, right: 10, child: _buildChip(scheme, _clipBehavior.name, Icons.crop)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _MorphMode.values.map(( _MorphMode mode) {
                return ChoiceChip(selected: mode == _mode, label: Text(mode.name), onSelected: (_) => _setMode(mode));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(ColorScheme scheme, String label, IconData icon) {
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
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildControlConsole(ColorScheme scheme) {
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
              'Tune durations, curves, alignment, clipping, and stage geometry.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
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
              label: 'Constraint Tightness',
              value: _tightness,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _tightness = value),
              onChangeEnd: (double value) => _addTimeline('Constraints', 'Tightness set to ${value.toStringAsFixed(2)}.'),
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
            Text('Curves', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
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
            Text('Alignment Anchors', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <MapEntry<String, Alignment>>[
                const MapEntry<String, Alignment>('TopLeft', Alignment.topLeft),
                const MapEntry<String, Alignment>('TopCenter', Alignment.topCenter),
                const MapEntry<String, Alignment>('Center', Alignment.center),
                const MapEntry<String, Alignment>('BottomCenter', Alignment.bottomCenter),
                const MapEntry<String, Alignment>('BottomRight', Alignment.bottomRight),
              ].map((MapEntry<String, Alignment> e) {
                return ChoiceChip(
                  selected: _alignment == e.value,
                  label: Text(e.key),
                  onSelected: (_) {
                    setState(() {
                      _alignment = e.value;
                      _alignmentSwitchCount += 1;
                    });
                    _addTimeline('Alignment', 'Changed alignment to ${e.key}.');
                  },
                );
              }).toList(),
            ),
            const Divider(height: 24),
            Text('Clip Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SegmentedButton<Clip>(
              segments: const <ButtonSegment<Clip>>[
                ButtonSegment<Clip>(value: Clip.none, label: Text('None')),
                ButtonSegment<Clip>(value: Clip.hardEdge, label: Text('HardEdge')),
                ButtonSegment<Clip>(value: Clip.antiAlias, label: Text('AntiAlias')),
                ButtonSegment<Clip>(value: Clip.antiAliasWithSaveLayer, label: Text('SaveLayer')),
              ],
              selected: <Clip>{_clipBehavior},
              onSelectionChanged: (Set<Clip> values) {
                setState(() {
                  _clipBehavior = values.first;
                  _clipSwitchCount += 1;
                });
                _addTimeline('Clip', 'Changed clip behavior to ${_clipBehavior.name}.');
              },
            ),
            const Divider(height: 24),
            CheckboxListTile(contentPadding: EdgeInsets.zero, value: _showGrid, title: const Text('Show grid'), onChanged: (bool? v) => setState(() => _showGrid = v ?? true)),
            CheckboxListTile(contentPadding: EdgeInsets.zero, value: _showOverlay, title: const Text('Show overlay'), onChanged: (bool? v) => setState(() => _showOverlay = v ?? true)),
            CheckboxListTile(contentPadding: EdgeInsets.zero, value: _showDiagnostics, title: const Text('Show diagnostics panel'), onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true)),
            CheckboxListTile(contentPadding: EdgeInsets.zero, value: _showGuide, title: const Text('Show guide board'), onChanged: (bool? v) => setState(() => _showGuide = v ?? true)),
            CheckboxListTile(contentPadding: EdgeInsets.zero, value: _showTimeline, title: const Text('Show timeline board'), onChanged: (bool? v) => setState(() => _showTimeline = v ?? true)),
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

  Widget _buildClipGallery(ColorScheme scheme) {
    final List<Clip> clips = <Clip>[Clip.none, Clip.hardEdge, Clip.antiAlias, Clip.antiAliasWithSaveLayer];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Clip Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Visual comparison of clipBehavior choices with intentionally overflowing animated content.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: clips.map((Clip clip) {
                final bool selected = clip == _clipBehavior;
                return SizedBox(
                  width: 300,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected ? scheme.secondaryContainer.withValues(alpha: 0.3) : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: selected ? scheme.secondary : scheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(clip.name, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          ClipRRect(
                            clipBehavior: clip,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 120,
                              color: scheme.surface,
                              child: Center(
                                child: AnimatedSize(
                                  duration: _duration,
                                  reverseDuration: _reverseDuration,
                                  curve: _curvePresets[_curveIndex].curve,
                                  alignment: _alignment,
                                  clipBehavior: clip,
                                  child: _morphTile(scheme, _clipMode, emphasizeOverflow: true),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _clipMode = _nextMode(_clipMode);
                                    });
                                    _addTimeline('Clip Gallery', '${clip.name} lane cycled to ${_clipMode.name}.');
                                  },
                                  child: const Text('Cycle Child'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _clipBehavior = clip;
                                    });
                                    _addTimeline('Clip', 'Global clip set to ${clip.name}.');
                                  },
                                  child: Text(selected ? 'Active' : 'Use'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  _MorphMode _nextMode(_MorphMode mode) {
    final int i = _MorphMode.values.indexOf(mode);
    return _MorphMode.values[(i + 1) % _MorphMode.values.length];
  }

  Widget _buildConstraintStressBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Constraint Stress Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Tight and loose parent regions demonstrate constraint influence on RenderAnimatedSize behavior.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget tight = _constraintLane(
                  scheme: scheme,
                  title: 'Tight Region',
                  constraints: _tightConstraints(),
                  mode: _tightMode,
                  onCycle: () {
                    setState(() {
                      _tightMode = _nextMode(_tightMode);
                    });
                    _addTimeline('Constraint', 'Tight lane cycled to ${_tightMode.name}.');
                  },
                );
                final Widget loose = _constraintLane(
                  scheme: scheme,
                  title: 'Loose Region',
                  constraints: _looseConstraints(),
                  mode: _looseMode,
                  onCycle: () {
                    setState(() {
                      _looseMode = _nextMode(_looseMode);
                    });
                    _addTimeline('Constraint', 'Loose lane cycled to ${_looseMode.name}.');
                  },
                );

                if (narrow) {
                  return Column(children: <Widget>[tight, const SizedBox(height: 10), loose]);
                }
                return Row(children: <Widget>[Expanded(child: tight), const SizedBox(width: 10), Expanded(child: loose)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _constraintLane({required ColorScheme scheme, required String title, required BoxConstraints constraints, required _MorphMode mode, required VoidCallback onCycle}) {
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
            Text(
              'min ${constraints.minWidth.toStringAsFixed(0)} x ${constraints.minHeight.toStringAsFixed(0)}  /  max ${constraints.maxWidth.toStringAsFixed(0)} x ${constraints.maxHeight.toStringAsFixed(0)}',
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: constraints,
                  child: AnimatedSize(
                    duration: _duration,
                    reverseDuration: _reverseDuration,
                    curve: _curvePresets[_curveIndex].curve,
                    alignment: _alignment,
                    clipBehavior: _clipBehavior,
                    onEnd: _onEnd,
                    child: _morphTile(scheme, mode),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingRunway(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Timing Runway', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Trigger paired expand/collapse actions to inspect forward/reverse asymmetry.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _setMode(_MorphMode.panel);
                      _addTimeline('Runway', 'Expand action triggered.');
                    },
                    icon: const Icon(Icons.open_in_full),
                    label: const Text('Expand'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _setMode(_MorphMode.compact);
                      _addTimeline('Runway', 'Collapse action triggered.');
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
                    Text('Forward ${_duration.inMilliseconds} ms  |  Reverse ${_reverseDuration.inMilliseconds} ms', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(
                      'Use duration presets above to evaluate feel and stability when transition directions use different timing.',
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

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricItem> metrics = _metrics();
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
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.7 : 1.88,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricItem metric = metrics[index];
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
                                Icon(metric.icon, color: scheme.primary, size: 18),
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
            if (_showDiagnostics) const SizedBox(height: 14),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    final BoxConstraints tight = _tightConstraints();
    final BoxConstraints loose = _looseConstraints();
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
            Text('phase=$_phase mode=${_mode.name} curve=${_curvePresets[_curveIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('duration=${_duration.inMilliseconds} reverse=${_reverseDuration.inMilliseconds} clip=${_clipBehavior.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('alignment=(${_alignment.x.toStringAsFixed(1)}, ${_alignment.y.toStringAsFixed(1)})', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('tight=[${tight.minWidth.toStringAsFixed(0)}..${tight.maxWidth.toStringAsFixed(0)} x ${tight.minHeight.toStringAsFixed(0)}..${tight.maxHeight.toStringAsFixed(0)}]', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('loose=[${loose.minWidth.toStringAsFixed(0)}..${loose.maxWidth.toStringAsFixed(0)} x ${loose.minHeight.toStringAsFixed(0)}..${loose.maxHeight.toStringAsFixed(0)}]', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Guide', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._intro.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
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
            Text('Best Practices', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._bestPractices.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 3), child: Icon(Icons.check_circle_outline, size: 14, color: scheme.secondary)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
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
            Text('Chronological record of transitions and control adjustments.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  child: Text('Timeline is empty. Interact with controls to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer))),
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

    final Paint center = Paint()
      ..color = color.withValues(alpha: 0.82)
      ..strokeWidth = 1.8;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), center);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), center);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
