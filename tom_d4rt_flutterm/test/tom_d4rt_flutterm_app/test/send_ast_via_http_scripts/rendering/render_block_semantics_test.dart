import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'signal',
    name: 'Signal Desk',
    description: 'Crisp profile for inspecting semantics visibility transitions.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Control',
    description: 'Warm profile highlighting blocked vs active semantics lanes.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Access',
    description: 'Dark profile for high contrast accessibility board review.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'cobalt',
    name: 'Cobalt Studio',
    description: 'Balanced profile for long semantics diagnostics sessions.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioPreset> _scenarioPresets = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'stage',
    title: 'Semantics Stage',
    subtitle: 'Upstream, barrier, and downstream zones with live block semantics behavior.',
  ),
  _ScenarioPreset(
    id: 'queue',
    title: 'Spoken Queue',
    subtitle: 'Simulated screen-reader order under different barrier modes.',
  ),
  _ScenarioPreset(
    id: 'overlay',
    title: 'Overlay Lane',
    subtitle: 'Modal overlay examples where previous semantics are intentionally blocked.',
  ),
  _ScenarioPreset(
    id: 'compare',
    title: 'Compare Board',
    subtitle: 'BlockSemantics, ExcludeSemantics, and MergeSemantics behavior side by side.',
  ),
  _ScenarioPreset(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Metrics, diagnostics snapshot, and reproducible timeline.',
  ),
];

const List<_FaqEntry> _faq = <_FaqEntry>[
  _FaqEntry(
    question: 'What does BlockSemantics do?',
    answer: 'It blocks semantics of previous siblings in the same container, making earlier content unavailable to accessibility traversal.',
  ),
  _FaqEntry(
    question: 'Where is it most useful?',
    answer: 'Modal overlays, transient dialogs, and temporary barriers where previous UI should not be announced.',
  ),
  _FaqEntry(
    question: 'How is it different from ExcludeSemantics?',
    answer: 'ExcludeSemantics removes semantics from its own subtree, while BlockSemantics hides previous siblings instead.',
  ),
  _FaqEntry(
    question: 'Can it be nested?',
    answer: 'Yes, but nested barriers should be designed carefully to avoid confusing accessibility order.',
  ),
];

const List<String> _guideBullets = <String>[
  'BlockSemantics is intended for intentional accessibility barriers, not general visibility control.',
  'Use it when earlier content should be hidden from semantic traversal while an overlay is active.',
  'Pair with clear visual and focus cues so users understand the current active context.',
  'Keep barrier lifetimes short and predictable to avoid trapping users in ambiguous states.',
  'Prefer explicit close/dismiss controls and announce state transitions where appropriate.',
  'Verify semantics order manually with tools and scripted scenarios across assistive technologies.',
  'Avoid stacking too many barriers unless each layer has distinct interaction semantics.',
  'Compare with ExcludeSemantics and MergeSemantics before choosing the right mechanism.',
  'Document expected spoken order in shared components to prevent regressions.',
  'Always test multilingual labels and dynamic content updates under active barriers.',
];

enum _BarrierMode {
  off,
  modal,
  curtain,
  stacked,
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

class _FaqEntry {
  const _FaqEntry({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _SemanticsNodeSpec {
  const _SemanticsNodeSpec({
    required this.id,
    required this.label,
    required this.zone,
    required this.priority,
    required this.isDecorative,
    required this.color,
  });

  final String id;
  final String label;
  final String zone;
  final int priority;
  final bool isDecorative;
  final Color color;
}

class _MetricEntry {
  const _MetricEntry({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _TimelineEvent {
  const _TimelineEvent({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

dynamic build(BuildContext context) {
  return const _RenderBlockSemanticsStudio();
}

class _RenderBlockSemanticsStudio extends StatefulWidget {
  const _RenderBlockSemanticsStudio();

  @override
  State<_RenderBlockSemanticsStudio> createState() => _RenderBlockSemanticsStudioState();
}

class _RenderBlockSemanticsStudioState extends State<_RenderBlockSemanticsStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _motionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7600),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _BarrierMode _barrierMode = _BarrierMode.modal;

  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showDecorativeNodes = false;
  bool _overlayVisible = true;
  bool _focusTrapEnabled = true;
  bool _animatedBackdrop = true;

  double _overlayOpacity = 0.42;
  double _barrierRadius = 18;
  double _stageHeight = 250;
  double _panelPadding = 12;

  int _modeSwitchCount = 0;
  int _overlayToggleCount = 0;
  int _focusToggleCount = 0;
  int _decorativeToggleCount = 0;
  int _queueAdvanceCount = 0;
  int _tapCount = 0;
  int _themeSwitchCount = 0;

  int _queueCursor = 0;
  String _phase = 'steady';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  final List<_SemanticsNodeSpec> _upstreamNodes = <_SemanticsNodeSpec>[
    const _SemanticsNodeSpec(id: 'search', label: 'Search field', zone: 'upstream', priority: 1, isDecorative: false, color: Color(0xFF0284C7)),
    const _SemanticsNodeSpec(id: 'filter', label: 'Filter chips', zone: 'upstream', priority: 2, isDecorative: false, color: Color(0xFF2563EB)),
    const _SemanticsNodeSpec(id: 'banner', label: 'Decorative hero banner', zone: 'upstream', priority: 3, isDecorative: true, color: Color(0xFF7C3AED)),
    const _SemanticsNodeSpec(id: 'stats', label: 'Statistics summary', zone: 'upstream', priority: 4, isDecorative: false, color: Color(0xFF9333EA)),
  ];

  final List<_SemanticsNodeSpec> _barrierNodes = <_SemanticsNodeSpec>[
    const _SemanticsNodeSpec(id: 'dialogTitle', label: 'Dialog title', zone: 'barrier', priority: 10, isDecorative: false, color: Color(0xFFEA580C)),
    const _SemanticsNodeSpec(id: 'dialogBody', label: 'Dialog body', zone: 'barrier', priority: 11, isDecorative: false, color: Color(0xFFF97316)),
    const _SemanticsNodeSpec(id: 'dialogImage', label: 'Decorative modal image', zone: 'barrier', priority: 12, isDecorative: true, color: Color(0xFFFB7185)),
    const _SemanticsNodeSpec(id: 'dialogAction', label: 'Primary action button', zone: 'barrier', priority: 13, isDecorative: false, color: Color(0xFFDC2626)),
  ];

  final List<_SemanticsNodeSpec> _downstreamNodes = <_SemanticsNodeSpec>[
    const _SemanticsNodeSpec(id: 'snack', label: 'Snackbar message', zone: 'downstream', priority: 20, isDecorative: false, color: Color(0xFF059669)),
    const _SemanticsNodeSpec(id: 'toast', label: 'Toast action', zone: 'downstream', priority: 21, isDecorative: false, color: Color(0xFF16A34A)),
    const _SemanticsNodeSpec(id: 'sparkle', label: 'Decorative sparkle', zone: 'downstream', priority: 22, isDecorative: true, color: Color(0xFF14B8A6)),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderBlockSemantics Accessibility Barrier Studio initialized.');
    });
  }

  @override
  void dispose() {
    _motionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(64).toList(growable: false);
    });
  }

  List<_SemanticsNodeSpec> _visibleQueue() {
    final List<_SemanticsNodeSpec> queue = <_SemanticsNodeSpec>[];

    final Iterable<_SemanticsNodeSpec> upstream = _showDecorativeNodes
        ? _upstreamNodes
        : _upstreamNodes.where(( _SemanticsNodeSpec n) => !n.isDecorative);
    final Iterable<_SemanticsNodeSpec> barrier = _showDecorativeNodes
        ? _barrierNodes
        : _barrierNodes.where(( _SemanticsNodeSpec n) => !n.isDecorative);
    final Iterable<_SemanticsNodeSpec> downstream = _showDecorativeNodes
        ? _downstreamNodes
        : _downstreamNodes.where(( _SemanticsNodeSpec n) => !n.isDecorative);

    switch (_barrierMode) {
      case _BarrierMode.off:
        queue.addAll(upstream);
        if (_overlayVisible) {
          queue.addAll(barrier);
        }
        queue.addAll(downstream);
        break;
      case _BarrierMode.modal:
        if (_overlayVisible) {
          queue.addAll(barrier);
          queue.addAll(downstream);
        } else {
          queue.addAll(upstream);
          queue.addAll(downstream);
        }
        break;
      case _BarrierMode.curtain:
        if (_overlayVisible) {
          queue.addAll(barrier.where(( _SemanticsNodeSpec n) => !n.isDecorative));
          queue.addAll(downstream.where(( _SemanticsNodeSpec n) => !n.isDecorative));
        } else {
          queue.addAll(upstream.where(( _SemanticsNodeSpec n) => !n.isDecorative));
          queue.addAll(downstream.where(( _SemanticsNodeSpec n) => !n.isDecorative));
        }
        break;
      case _BarrierMode.stacked:
        if (_overlayVisible) {
          queue.addAll(barrier.take(2));
          queue.addAll(downstream.take(1));
        } else {
          queue.addAll(upstream);
          queue.addAll(downstream);
        }
        break;
    }

    return queue;
  }

  List<_MetricEntry> _metrics() {
    final List<_SemanticsNodeSpec> queue = _visibleQueue();
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarioPresets[_scenarioIndex].title, note: 'Current exploration lane.', icon: Icons.dashboard_customize_outlined),
      _MetricEntry(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Visual profile for contrast.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Barrier Mode', value: _barrierMode.name, note: 'Active semantics barrier strategy.', icon: Icons.block_outlined),
      _MetricEntry(label: 'Overlay Visible', value: _overlayVisible ? 'true' : 'false', note: 'Modal surface visibility status.', icon: Icons.layers_outlined),
      _MetricEntry(label: 'Focus Trap', value: _focusTrapEnabled ? 'enabled' : 'disabled', note: 'Simulated focus containment mode.', icon: Icons.center_focus_strong_outlined),
      _MetricEntry(label: 'Visible Nodes', value: '${queue.length}', note: 'Current spoken queue size.', icon: Icons.hearing_outlined),
      _MetricEntry(label: 'Queue Cursor', value: '$_queueCursor', note: 'Current queue pointer index.', icon: Icons.play_arrow_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Current interaction phase label.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Mode Switches', value: '$_modeSwitchCount', note: 'Barrier mode changes.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Overlay Toggles', value: '$_overlayToggleCount', note: 'Overlay visibility toggles.', icon: Icons.visibility_outlined),
      _MetricEntry(label: 'Focus Toggles', value: '$_focusToggleCount', note: 'Focus-trap setting changes.', icon: Icons.filter_center_focus_outlined),
      _MetricEntry(label: 'Decorative Toggles', value: '$_decorativeToggleCount', note: 'Decorative node visibility toggles.', icon: Icons.brush_outlined),
      _MetricEntry(label: 'Queue Advances', value: '$_queueAdvanceCount', note: 'Manual spoken queue stepping.', icon: Icons.skip_next_outlined),
      _MetricEntry(label: 'Interactions', value: '$_tapCount', note: 'Tap interactions on semantics cards.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Theme Switches', value: '$_themeSwitchCount', note: 'Theme profile changes.', icon: Icons.color_lens_outlined),
    ];
  }

  void _resetStudio() {
    setState(() {
      _scenarioIndex = 0;
      _barrierMode = _BarrierMode.modal;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showDecorativeNodes = false;
      _overlayVisible = true;
      _focusTrapEnabled = true;
      _animatedBackdrop = true;
      _overlayOpacity = 0.42;
      _barrierRadius = 18;
      _stageHeight = 250;
      _panelPadding = 12;
      _modeSwitchCount = 0;
      _overlayToggleCount = 0;
      _focusToggleCount = 0;
      _decorativeToggleCount = 0;
      _queueAdvanceCount = 0;
      _tapCount = 0;
      _themeSwitchCount = 0;
      _queueCursor = 0;
      _phase = 'steady';
      _timeline = const <_TimelineEvent>[];
    });
    if (_animatedBackdrop) {
      _motionController.repeat();
    }
    _pushTimeline('Reset', 'BlockSemantics studio reset to defaults.');
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
                    constraints: const BoxConstraints(maxWidth: 1340),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildSemanticsStageBoard(scheme),
                        const SizedBox(height: 16),
                        _buildQueueBoard(scheme),
                        const SizedBox(height: 16),
                        _buildOverlayLaneBoard(scheme),
                        const SizedBox(height: 16),
                        _buildComparisonBoard(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showTimeline) const SizedBox(height: 16),
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
                Icon(Icons.accessibility_new_outlined, color: scheme.primary, size: 26),
                Text('RenderBlockSemantics Accessibility Barrier Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioPresets[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual deep visual demo for understanding how BlockSemantics changes accessibility visibility and spoken order in layered interfaces.',
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
              children: List<Widget>.generate(_themePresets.length, (int i) {
                final _ThemePreset preset = _themePresets[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(preset.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitchCount += 1;
                    });
                    _pushTimeline('Theme', 'Switched to ${preset.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioPresets.length, (int i) {
                final _ScenarioPreset scenario = _scenarioPresets[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(scenario.title),
                  onSelected: (_) {
                    setState(() => _scenarioIndex = i);
                    _pushTimeline('Scenario', scenario.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarioPresets[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => setState(() => _showGrid = v ?? true), child: const Text('Show stage grid')),
                CheckboxMenuButton(
                  value: _showDecorativeNodes,
                  onChanged: (bool? v) {
                    setState(() {
                      _showDecorativeNodes = v ?? false;
                      _decorativeToggleCount += 1;
                    });
                    _pushTimeline('Decorative Nodes', _showDecorativeNodes ? 'Decorative nodes included.' : 'Decorative nodes hidden.');
                  },
                  child: const Text('Include decorative semantics'),
                ),
                CheckboxMenuButton(
                  value: _focusTrapEnabled,
                  onChanged: (bool? v) {
                    setState(() {
                      _focusTrapEnabled = v ?? true;
                      _focusToggleCount += 1;
                    });
                    _pushTimeline('Focus Trap', _focusTrapEnabled ? 'Focus trap enabled.' : 'Focus trap disabled.');
                  },
                  child: const Text('Focus trap simulation'),
                ),
                CheckboxMenuButton(
                  value: _animatedBackdrop,
                  onChanged: (bool? v) {
                    final bool next = v ?? true;
                    setState(() => _animatedBackdrop = next);
                    if (next) {
                      _motionController.repeat();
                    } else {
                      _motionController.stop();
                    }
                    _pushTimeline('Backdrop', next ? 'Animated backdrop enabled.' : 'Animated backdrop paused.');
                  },
                  child: const Text('Animate backdrop'),
                ),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true), child: const Text('Show diagnostics')),                
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => setState(() => _showGuide = v ?? true), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => setState(() => _showTimeline = v ?? true), child: const Text('Show timeline board')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemanticsStageBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: EdgeInsets.all(_panelPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Semantics Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetStudio, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Visual stage with upstream controls, active barrier, and downstream notifications.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _BarrierMode.values.map(( _BarrierMode mode) {
                      return ChoiceChip(
                        selected: _barrierMode == mode,
                        label: Text(mode.name),
                        onSelected: (_) {
                          setState(() {
                            _barrierMode = mode;
                            _modeSwitchCount += 1;
                            _phase = 'mode';
                          });
                          _pushTimeline('Barrier Mode', 'Changed mode to ${mode.name}.');
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 230,
                  child: Row(
                    children: <Widget>[
                      const Expanded(child: Text('Overlay Opacity')),
                      Text(_overlayOpacity.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ],
            ),
            Slider(
              value: _overlayOpacity,
              min: 0,
              max: 0.85,
              divisions: 85,
              onChanged: (double v) => setState(() => _overlayOpacity = v),
              onChangeEnd: (double v) => _pushTimeline('Overlay', 'Overlay opacity set to ${v.toStringAsFixed(2)}.'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SwitchListTile(
                    value: _overlayVisible,
                    title: const Text('Overlay Visible'),
                    subtitle: const Text('Toggle active barrier layer.'),
                    onChanged: (bool value) {
                      setState(() {
                        _overlayVisible = value;
                        _overlayToggleCount += 1;
                      });
                      _pushTimeline('Overlay Visibility', value ? 'Overlay shown.' : 'Overlay hidden.');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _sliderRow(
                    scheme: scheme,
                    label: 'Barrier Radius',
                    value: _barrierRadius,
                    min: 0,
                    max: 42,
                    divisions: 42,
                    onChanged: (double v) => setState(() => _barrierRadius = v),
                    onChangeEnd: (double v) => _pushTimeline('Barrier Radius', 'Barrier radius set to ${v.toStringAsFixed(0)}.'),
                  ),
                ),
              ],
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 180,
              max: 360,
              divisions: 90,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Stage', 'Stage height set to ${v.toStringAsFixed(0)}.'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: _stageHeight,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: _AnimatedBackdrop(
                      controller: _motionController,
                      showGrid: _showGrid,
                      enabled: _animatedBackdrop,
                      overlayOpacity: _overlayOpacity * 0.22,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: _zonePanel(scheme, 'Upstream', _upstreamNodes, blocked: _overlayVisible && _barrierMode != _BarrierMode.off)),
                          const SizedBox(width: 10),
                          Expanded(child: _barrierPanel(scheme)),
                          const SizedBox(width: 10),
                          Expanded(child: _zonePanel(scheme, 'Downstream', _downstreamNodes, blocked: false)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

  Widget _zonePanel(ColorScheme scheme, String title, List<_SemanticsNodeSpec> nodes, {required bool blocked}) {
    final Iterable<_SemanticsNodeSpec> visible = _showDecorativeNodes ? nodes : nodes.where(( _SemanticsNodeSpec n) => !n.isDecorative);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: blocked ? scheme.errorContainer.withValues(alpha: 0.45) : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blocked ? scheme.error : scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                const Spacer(),
                if (blocked) Icon(Icons.block, color: scheme.error, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            ...visible.map(( _SemanticsNodeSpec node) => _nodeChip(scheme, node, blocked: blocked)),
          ],
        ),
      ),
    );
  }

  Widget _barrierPanel(ColorScheme scheme) {
    final Widget pane = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: _overlayVisible ? 0.88 : 0.42),
        borderRadius: BorderRadius.circular(_barrierRadius),
        border: Border.all(color: scheme.secondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Barrier Zone', style: TextStyle(color: scheme.onSecondaryContainer, fontWeight: FontWeight.w700)),
                const Spacer(),
                Icon(Icons.shield_outlined, color: scheme.onSecondaryContainer, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            ..._barrierNodes
                .where(( _SemanticsNodeSpec n) => _showDecorativeNodes || !n.isDecorative)
                .map(( _SemanticsNodeSpec node) => _nodeChip(scheme, node, blocked: !_overlayVisible))
              ,
          ],
        ),
      ),
    );

    if (!_overlayVisible || _barrierMode == _BarrierMode.off) {
      return pane;
    }

    return BlockSemantics(
      blocking: true,
      child: pane,
    );
  }

  Widget _nodeChip(ColorScheme scheme, _SemanticsNodeSpec node, {required bool blocked}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: blocked ? scheme.surface.withValues(alpha: 0.55) : node.color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: blocked ? scheme.outline : node.color.withValues(alpha: 0.70)),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        leading: Icon(node.isDecorative ? Icons.auto_awesome_outlined : Icons.record_voice_over_outlined, size: 18, color: blocked ? scheme.outline : node.color),
        title: Text(node.label, style: TextStyle(color: blocked ? scheme.outline : scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 12)),
        subtitle: Text('priority ${node.priority}  •  ${node.zone}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
        trailing: Icon(blocked ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 16, color: blocked ? scheme.outline : scheme.primary),
        onTap: () {
          setState(() {
            _tapCount += 1;
            _phase = 'tap';
          });
          _pushTimeline('Node Tap', '${node.label} tapped in ${node.zone}.');
        },
      ),
    );
  }

  Widget _buildQueueBoard(ColorScheme scheme) {
    final List<_SemanticsNodeSpec> queue = _visibleQueue();
    final int cursor = queue.isEmpty ? 0 : _queueCursor % queue.length;
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
                Text('Spoken Queue Simulator', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: queue.isEmpty
                      ? null
                      : () {
                          setState(() {
                            _queueCursor = (cursor + 1) % queue.length;
                            _queueAdvanceCount += 1;
                            _phase = 'queue';
                          });
                          _pushTimeline('Queue Advance', 'Advanced spoken queue to index $_queueCursor.');
                        },
                  icon: const Icon(Icons.skip_next_outlined),
                  label: const Text('Next Node'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Simulated assistive traversal order after applying current barrier mode and visibility rules.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (queue.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('No visible semantic nodes for current settings.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List<Widget>.generate(queue.length, (int i) {
                  final _SemanticsNodeSpec node = queue[i];
                  final bool active = i == cursor;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: active ? scheme.primaryContainer : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: active ? scheme.primary : scheme.outlineVariant),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${i + 1}.', style: TextStyle(color: active ? scheme.onPrimaryContainer : scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        Text(node.label, style: TextStyle(color: active ? scheme.onPrimaryContainer : scheme.onSurface, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayLaneBoard(ColorScheme scheme) {
    final bool blocksPrevious = _overlayVisible && _barrierMode != _BarrierMode.off;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Modal Overlay Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Practical example: temporary modal context that blocks previous semantics when active.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            SizedBox(
              height: 210,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[scheme.primaryContainer.withValues(alpha: 0.42), scheme.tertiaryContainer.withValues(alpha: 0.33)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Background controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: <Widget>[
                                Chip(label: Text(blocksPrevious ? 'hidden from semantics' : 'available in semantics')),
                                Chip(label: Text(_focusTrapEnabled ? 'focus trapped' : 'focus free')),
                              ],
                            ),
                            const Spacer(),
                            Text('This panel simulates content that should not be announced while modal context is active.', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_overlayVisible)
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: BlockSemantics(
                          blocking: _barrierMode != _BarrierMode.off,
                          child: Container(
                            decoration: BoxDecoration(
                              color: scheme.surface.withValues(alpha: 0.90),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: scheme.primary),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 16, offset: const Offset(0, 8)),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Active Modal Semantics Scope', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 8),
                                  Text('When BlockSemantics is active, previous siblings are removed from semantic traversal.', style: TextStyle(color: scheme.onSurfaceVariant)),
                                  const Spacer(),
                                  Row(
                                    children: <Widget>[
                                      FilledButton(
                                        onPressed: () {
                                          setState(() {
                                            _overlayVisible = false;
                                            _overlayToggleCount += 1;
                                          });
                                          _pushTimeline('Overlay Dismiss', 'Modal overlay dismissed.');
                                        },
                                        child: const Text('Dismiss'),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            _phase = 'modal-action';
                                            _tapCount += 1;
                                          });
                                          _pushTimeline('Modal Action', 'Primary modal action triggered.');
                                        },
                                        child: const Text('Primary Action'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
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
            Text('Comparison Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Behavior comparison: BlockSemantics vs ExcludeSemantics vs MergeSemantics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget block = _compareCard(
                  scheme: scheme,
                  title: 'BlockSemantics',
                  subtitle: 'Blocks previous siblings when active.',
                  color: const Color(0xFFB91C1C),
                  child: BlockSemantics(
                    blocking: true,
                    child: Semantics(label: 'Block semantics active region', button: true, child: const Icon(Icons.block_outlined, size: 34)),
                  ),
                );
                final Widget exclude = _compareCard(
                  scheme: scheme,
                  title: 'ExcludeSemantics',
                  subtitle: 'Removes semantics in its own subtree.',
                  color: const Color(0xFF0F766E),
                  child: ExcludeSemantics(child: const Icon(Icons.visibility_off_outlined, size: 34)),
                );
                final Widget merge = _compareCard(
                  scheme: scheme,
                  title: 'MergeSemantics',
                  subtitle: 'Merges descendants into one semantic node.',
                  color: const Color(0xFF1D4ED8),
                  child: MergeSemantics(
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.merge_type_outlined, size: 30),
                        SizedBox(width: 6),
                        Text('Merged node'),
                      ],
                    ),
                  ),
                );
                if (narrow) {
                  return Column(children: <Widget>[block, const SizedBox(height: 10), exclude, const SizedBox(height: 10), merge]);
                }
                return Row(children: <Widget>[Expanded(child: block), const SizedBox(width: 10), Expanded(child: exclude), const SizedBox(width: 10), Expanded(child: merge)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareCard({required ColorScheme scheme, required String title, required String subtitle, required Color color, required Widget child}) {
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
              height: 92,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.65)),
              ),
              child: Center(child: child),
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
                    childAspectRatio: columns == 1 ? 2.7 : 1.9,
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

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    final List<_SemanticsNodeSpec> queue = _visibleQueue();
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
            Text('theme=${_themePresets[_themeIndex].id} scenario=${_scenarioPresets[_scenarioIndex].id} mode=${_barrierMode.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('overlayVisible=$_overlayVisible focusTrap=$_focusTrapEnabled decorative=$_showDecorativeNodes', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('queueLength=${queue.length} cursor=$_queueCursor phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('overlayOpacity=${_overlayOpacity.toStringAsFixed(2)} radius=${_barrierRadius.toStringAsFixed(1)} stageHeight=${_stageHeight.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches mode=$_modeSwitchCount overlay=$_overlayToggleCount focus=$_focusToggleCount decorative=$_decorativeToggleCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('queueAdvances=$_queueAdvanceCount interactions=$_tapCount themeSwitches=$_themeSwitchCount', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            ..._faq.map(( _FaqEntry entry) {
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
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _timeline = const <_TimelineEvent>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of barrier transitions, queue changes, and interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('Timeline is empty. Interact with controls to populate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEvent event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
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

class _AnimatedBackdrop extends StatelessWidget {
  const _AnimatedBackdrop({
    required this.controller,
    required this.showGrid,
    required this.enabled,
    required this.overlayOpacity,
  });

  final Animation<double> controller;
  final bool showGrid;
  final bool enabled;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final double t = enabled ? controller.value : 0;
        return CustomPaint(
          painter: _BackdropPainter(progress: t, showGrid: showGrid, overlayOpacity: overlayOpacity),
        );
      },
    );
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({required this.progress, required this.showGrid, required this.overlayOpacity});

  final double progress;
  final bool showGrid;
  final double overlayOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> palette = <Color>[
      Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF3B82F6), (math.sin(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(const Color(0xFF14B8A6), const Color(0xFF22C55E), (math.cos(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(const Color(0xFFF97316), const Color(0xFFE11D48), (math.sin(progress * math.pi * 4) + 1) / 2)!,
    ];
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: palette,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint circles = Paint();
    for (int i = 0; i < 12; i += 1) {
      final double wave = progress * math.pi * 2 + (i * 0.45);
      final double x = size.width * 0.5 + math.cos(wave) * size.width * 0.40;
      final double y = size.height * 0.5 + math.sin(wave * 1.3) * size.height * 0.34;
      circles.color = palette[i % palette.length].withValues(alpha: 0.24 + ((i % 3) * 0.08));
      canvas.drawCircle(Offset(x, y), 14 + ((i % 4) * 8), circles);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white.withValues(alpha: 0.14)
        ..strokeWidth = 1;
      const double step = 22;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Paint overlay = Paint()..color = Colors.black.withValues(alpha: overlayOpacity);
    canvas.drawRect(Offset.zero & size, overlay);
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.showGrid != showGrid || oldDelegate.overlayOpacity != overlayOpacity;
  }
}
