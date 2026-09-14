import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'coast',
    name: 'Coast Studio',
    description: 'Balanced profile for sliver grouping and background decoration.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Board',
    description: 'Warm profile for stripes, gradients, and inset emphasis.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Canvas',
    description: 'Dark profile for contrast and layered sliver backgrounds.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(id: _ScenarioMode.heroBands, title: 'Hero Bands', subtitle: 'DecoratedSliver around hero and intro blocks with layered gradients.'),
  _Scenario(id: _ScenarioMode.groupedList, title: 'Grouped List', subtitle: 'Section groups wrapped by decorated sliver backgrounds.'),
  _Scenario(id: _ScenarioMode.mosaic, title: 'Mosaic Grid', subtitle: 'Decorated grid slivers with dynamic shape and contrast controls.'),
  _Scenario(id: _ScenarioMode.insetStripes, title: 'Inset Stripes', subtitle: 'Padding and inset composition to isolate decorated content lanes.'),
  _Scenario(id: _ScenarioMode.diagnostics, title: 'Diagnostics', subtitle: 'Pinned diagnostics panel with sliver decoration state snapshots.'),
];

const List<String> _guideBullets = <String>[
  'DecoratedSliver wraps another sliver with a Decoration for background styling.',
  'RenderDecoratedSliver is useful when a sliver section needs visual grouping.',
  'Combine SliverPadding and DecoratedSliver to control visual breathing room.',
  'Use gradients, borders, and radius to communicate section hierarchy in scroll UIs.',
  'DecoratedSliver is valuable for dashboards, feeds, and editorial lane styling.',
  'Pinned SliverAppBar + decorated sections creates clear navigational rhythm.',
  'Keep decoration contrast readable while scrolling and when content overlaps.',
  'Use diagnostics lanes to track scroll state and decoration parameter changes.',
  'Prefer explicit section wrappers over ad-hoc container styling in large scroll trees.',
  'Document which content slivers are decoration-backed to keep designs maintainable.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'When should I use DecoratedSliver?',
    answer: 'When a whole sliver section needs background decoration instead of styling each child individually.',
  ),
  _FaqItem(
    question: 'Can I decorate grids and lists the same way?',
    answer: 'Yes, DecoratedSliver can wrap different sliver types uniformly.',
  ),
  _FaqItem(
    question: 'How do I keep decorated lanes readable?',
    answer: 'Balance opacity, border contrast, and content padding so text remains clear.',
  ),
  _FaqItem(
    question: 'Does this replace SliverPadding?',
    answer: 'No, they work together: padding controls spacing, decoration controls visuals.',
  ),
  _FaqItem(
    question: 'How can I debug decorated sliver structure?',
    answer: 'Capture scroll metrics, section toggles, and decoration values in a diagnostics panel.',
  ),
];

enum _ScenarioMode {
  heroBands,
  groupedList,
  mosaic,
  insetStripes,
  diagnostics,
}

enum _DecorShape {
  rounded,
  stadium,
  beveled,
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

class _DecorSnapshot {
  const _DecorSnapshot({
    required this.scrollPixels,
    required this.scenario,
    required this.opacity,
    required this.radius,
  });

  final double scrollPixels;
  final String scenario;
  final double opacity;
  final double radius;
}

dynamic build(BuildContext context) {
  return const _RenderDecoratedSliverStudio();
}

class _RenderDecoratedSliverStudio extends StatefulWidget {
  const _RenderDecoratedSliverStudio();

  @override
  State<_RenderDecoratedSliverStudio> createState() => _RenderDecoratedSliverStudioState();
}

class _RenderDecoratedSliverStudioState extends State<_RenderDecoratedSliverStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scroll = ScrollController();

  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9000),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _DecorShape _shape = _DecorShape.rounded;

  double _panelHeight = 620;
  double _sectionPadding = 12;
  double _laneRadius = 16;
  double _laneBorder = 1.2;
  double _laneOpacity = 0.32;
  double _gradientShift = 0.24;
  double _stripeDensity = 0.34;
  double _itemSpacing = 10;
  double _tileAspect = 1.25;

  bool _animate = true;
  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showHeroLane = true;
  bool _showGroupLane = true;
  bool _showGridLane = true;
  bool _showInsetLane = true;

  int _themeSwitches = 0;
  int _scenarioSwitches = 0;
  int _shapeSwitches = 0;
  int _controlEdits = 0;
  int _scrollSamples = 0;

  String _phase = 'idle';

  _DecorSnapshot _snapshot = const _DecorSnapshot(
    scrollPixels: 0,
    scenario: 'heroBands',
    opacity: 0.32,
    radius: 16,
  );
  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'DecoratedSliver design lab initialized.');
    });
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _motion.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _snapshot = _DecorSnapshot(
        scrollPixels: _scroll.hasClients ? _scroll.offset : 0,
        scenario: _scenarios[_scenarioIndex].id.name,
        opacity: _laneOpacity,
        radius: _laneRadius,
      );
      _scrollSamples += 1;
    });
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(100).toList(growable: false);
    });
  }

  void _bumpControl(String title, String message) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _pushTimeline(title, message);
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
        case 'hero':
          _showHeroLane = next;
          break;
        case 'group':
          _showGroupLane = next;
          break;
        case 'gridlane':
          _showGridLane = next;
          break;
        case 'inset':
          _showInsetLane = next;
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

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _shape = _DecorShape.rounded;
      _panelHeight = 620;
      _sectionPadding = 12;
      _laneRadius = 16;
      _laneBorder = 1.2;
      _laneOpacity = 0.32;
      _gradientShift = 0.24;
      _stripeDensity = 0.34;
      _itemSpacing = 10;
      _tileAspect = 1.25;
      _animate = true;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showHeroLane = true;
      _showGroupLane = true;
      _showGridLane = true;
      _showInsetLane = true;
      _phase = 'reset';
      _timeline = const <_TimelineEvent>[];
      _snapshot = const _DecorSnapshot(scrollPixels: 0, scenario: 'heroBands', opacity: 0.32, radius: 16);
    });
    _motion.repeat();
    _pushTimeline('Reset', 'DecoratedSliver lab reset to defaults.');
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeScenarioBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildSliverStageBoard(scheme),
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
                Icon(Icons.view_stream_outlined, color: scheme.primary, size: 26),
                Text('RenderDecoratedSliver Design Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Interactive deep demo of DecoratedSliver usage patterns for lists, grids, lanes, and diagnostics-rich scrolling surfaces.',
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
                Text('Decor Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Adjust decorated lane geometry, opacity, spacing, and section visibility.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Stage Height',
              value: _panelHeight,
              min: 420,
              max: 920,
              divisions: 250,
              onChanged: (double v) => setState(() => _panelHeight = v),
              onChangeEnd: (double v) => _bumpControl('Stage Height', 'Set stage height to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Section Padding',
              value: _sectionPadding,
              min: 0,
              max: 34,
              divisions: 68,
              onChanged: (double v) => setState(() => _sectionPadding = v),
              onChangeEnd: (double v) => _bumpControl('Padding', 'Set section padding to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Lane Radius',
              value: _laneRadius,
              min: 0,
              max: 48,
              divisions: 96,
              onChanged: (double v) => setState(() => _laneRadius = v),
              onChangeEnd: (double v) => _bumpControl('Radius', 'Set lane radius to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Lane Border',
              value: _laneBorder,
              min: 0,
              max: 6,
              divisions: 60,
              onChanged: (double v) => setState(() => _laneBorder = v),
              onChangeEnd: (double v) => _bumpControl('Border', 'Set lane border to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Lane Opacity',
              value: _laneOpacity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _laneOpacity = v),
              onChangeEnd: (double v) => _bumpControl('Opacity', 'Set lane opacity to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Gradient Shift',
              value: _gradientShift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _gradientShift = v),
              onChangeEnd: (double v) => _bumpControl('Gradient', 'Set gradient shift to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stripe Density',
              value: _stripeDensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _stripeDensity = v),
              onChangeEnd: (double v) => _bumpControl('Stripes', 'Set stripe density to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Item Spacing',
              value: _itemSpacing,
              min: 0,
              max: 26,
              divisions: 52,
              onChanged: (double v) => setState(() => _itemSpacing = v),
              onChangeEnd: (double v) => _bumpControl('Spacing', 'Set item spacing to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Tile Aspect',
              value: _tileAspect,
              min: 0.6,
              max: 2.2,
              divisions: 160,
              onChanged: (double v) => setState(() => _tileAspect = v),
              onChangeEnd: (double v) => _bumpControl('Aspect', 'Set tile aspect to ${v.toStringAsFixed(2)}.'),
            ),
            const SizedBox(height: 8),
            Text('Decoration Shape', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _DecorShape.values.map(( _DecorShape shape) {
                return ChoiceChip(
                  selected: _shape == shape,
                  label: Text(shape.name),
                  onSelected: (_) {
                    setState(() {
                      _shape = shape;
                      _shapeSwitches += 1;
                      _phase = 'shape';
                    });
                    _pushTimeline('Shape', 'Decoration shape switched to ${shape.name}.');
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate gradients')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Show stage grid')),
                CheckboxMenuButton(value: _showHeroLane, onChanged: (bool? v) => _toggle('hero', v), child: const Text('Hero lane')),
                CheckboxMenuButton(value: _showGroupLane, onChanged: (bool? v) => _toggle('group', v), child: const Text('Grouped list lane')),
                CheckboxMenuButton(value: _showGridLane, onChanged: (bool? v) => _toggle('gridlane', v), child: const Text('Mosaic lane')),
                CheckboxMenuButton(value: _showInsetLane, onChanged: (bool? v) => _toggle('inset', v), child: const Text('Inset lane')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Show timeline board')),
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

  Widget _buildSliverStageBoard(ColorScheme scheme) {
    final double progress = _animate ? _motion.value : 0;
    final BoxDecoration laneDecor = _laneDecoration(progress, scheme);

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('DecoratedSliver Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Scrollable stage with multiple decorated lanes wrapping list and grid slivers.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            SizedBox(
              height: _panelHeight,
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
                      if (_showGrid)
                        CustomPaint(
                          painter: _StageGridPainter(progress: progress, density: _stripeDensity),
                        ),
                      CustomScrollView(
                        controller: _scroll,
                        slivers: <Widget>[
                          SliverAppBar(
                            pinned: true,
                            backgroundColor: scheme.surface.withValues(alpha: 0.92),
                            title: Text('DecoratedSliver Playground • ${_scenarios[_scenarioIndex].title}'),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Text(
                                    'scroll ${_snapshot.scrollPixels.toStringAsFixed(1)}',
                                    style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_showHeroLane)
                            SliverPadding(
                              padding: EdgeInsets.all(_sectionPadding),
                              sliver: DecoratedSliver(
                                decoration: laneDecor,
                                sliver: SliverToBoxAdapter(
                                  child: _heroCard(scheme),
                                ),
                              ),
                            ),
                          if (_showGroupLane)
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: _sectionPadding, vertical: _sectionPadding * 0.8),
                              sliver: DecoratedSliver(
                                decoration: laneDecor,
                                sliver: SliverList.builder(
                                  itemCount: 12,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, index == 11 ? 12 : _itemSpacing),
                                      child: _listItem(scheme, index),
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (_showGridLane)
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: _sectionPadding, vertical: _sectionPadding * 0.7),
                              sliver: DecoratedSliver(
                                decoration: laneDecor,
                                sliver: SliverPadding(
                                  padding: const EdgeInsets.all(10),
                                  sliver: SliverGrid.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: _itemSpacing,
                                      mainAxisSpacing: _itemSpacing,
                                      childAspectRatio: _tileAspect,
                                    ),
                                    itemCount: 18,
                                    itemBuilder: (BuildContext context, int index) {
                                      return _mosaicTile(scheme, index);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          if (_showInsetLane)
                            SliverPadding(
                              padding: EdgeInsets.fromLTRB(_sectionPadding + 20, _sectionPadding, _sectionPadding + 20, _sectionPadding * 1.6),
                              sliver: DecoratedSliver(
                                decoration: laneDecor,
                                sliver: SliverList.builder(
                                  itemCount: 6,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, index == 5 ? 12 : 8),
                                      child: _insetStripeCard(scheme, index),
                                    );
                                  },
                                ),
                              ),
                            ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: 18 + (_sectionPadding * 0.4)),
                          ),
                        ],
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

  BoxDecoration _laneDecoration(double progress, ColorScheme scheme) {
    final BorderRadius borderRadius = _shapeBorderRadius(_shape, _laneRadius);
    final List<Color> colors = <Color>[
      Color.lerp(scheme.primary.withValues(alpha: _laneOpacity), scheme.secondary.withValues(alpha: _laneOpacity), (math.sin(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(scheme.tertiary.withValues(alpha: _laneOpacity), scheme.primary.withValues(alpha: _laneOpacity), (math.cos(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(scheme.secondary.withValues(alpha: _laneOpacity), scheme.tertiary.withValues(alpha: _laneOpacity), (_gradientShift + progress).clamp(0, 1))!,
    ];

    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(color: scheme.outline.withValues(alpha: 0.70), width: _laneBorder),
      gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
    );
  }

  BorderRadius _shapeBorderRadius(_DecorShape shape, double r) {
    switch (shape) {
      case _DecorShape.rounded:
        return BorderRadius.circular(r);
      case _DecorShape.stadium:
        return BorderRadius.circular(999);
      case _DecorShape.beveled:
        return BorderRadius.only(
          topLeft: Radius.circular(r * 0.2),
          topRight: Radius.circular(r * 1.1),
          bottomLeft: Radius.circular(r * 1.1),
          bottomRight: Radius.circular(r * 0.2),
        );
    }
  }

  Widget _heroCard(ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: scheme.surface.withValues(alpha: 0.74),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hero Decorated Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Text('This lane demonstrates how a broad intro section can be visually grouped using DecoratedSliver.', style: TextStyle(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('shape ${_shape.name}', scheme.primary),
              _chip('opacity ${_laneOpacity.toStringAsFixed(2)}', scheme.secondary),
              _chip('radius ${_laneRadius.toStringAsFixed(1)}', scheme.tertiary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999), border: Border.all(color: color.withValues(alpha: 0.62))),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _listItem(ColorScheme scheme, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              backgroundColor: scheme.primaryContainer,
              child: Text('${index + 1}', style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Decorated List Item ${index + 1}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text('Grouped inside a DecoratedSliver to provide lane-level styling.', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _mosaicTile(ColorScheme scheme, int index) {
    final Color a = Color.lerp(scheme.primary, scheme.secondary, (index % 5) / 5)!;
    final Color b = Color.lerp(scheme.tertiary, scheme.primary, ((index + 2) % 7) / 7)!;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: <Color>[a, b], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: Colors.black.withValues(alpha: 0.16)),
      ),
      child: Center(
        child: Text('Tile ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _insetStripeCard(ColorScheme scheme, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: scheme.surface.withValues(alpha: 0.78),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: SizedBox(
        height: 72,
        child: Row(
          children: <Widget>[
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: Color.lerp(scheme.primary, scheme.secondary, (index % 6) / 6),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text('Inset lane sample ${index + 1} with lane-level decoration context.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Contrast DecoratedSliver lane styling with alternatives used in sliver trees.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget decorated = _comparisonCard(
                  scheme: scheme,
                  title: 'DecoratedSliver',
                  subtitle: 'Applies decoration once around a sliver section.',
                  icon: Icons.view_stream_outlined,
                  color: const Color(0xFF0F766E),
                );
                final Widget perItem = _comparisonCard(
                  scheme: scheme,
                  title: 'Per-item Decor',
                  subtitle: 'Decorating each child separately can be repetitive.',
                  icon: Icons.view_list_outlined,
                  color: const Color(0xFF1D4ED8),
                );
                final Widget plain = _comparisonCard(
                  scheme: scheme,
                  title: 'Plain Sliver',
                  subtitle: 'No lane-level background grouping applied.',
                  icon: Icons.format_list_bulleted_outlined,
                  color: const Color(0xFFB45309),
                );
                if (narrow) {
                  return Column(children: <Widget>[decorated, const SizedBox(height: 10), perItem, const SizedBox(height: 10), plain]);
                }
                return Row(children: <Widget>[Expanded(child: decorated), const SizedBox(width: 10), Expanded(child: perItem), const SizedBox(width: 10), Expanded(child: plain)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required IconData icon, required Color color}) {
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
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.62))),
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
                    childAspectRatio: columns == 1 ? 2.85 : 2.10,
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
      _MetricEntry(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active sliver lane scenario.', icon: Icons.route_outlined),
      _MetricEntry(label: 'Theme', value: _themes[_themeIndex].name, note: 'Current design profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Shape', value: _shape.name, note: 'Decoration border shape preset.', icon: Icons.rounded_corner_outlined),
      _MetricEntry(label: 'Stage Height', value: _panelHeight.toStringAsFixed(0), note: 'Visible custom scroll stage height.', icon: Icons.height_outlined),
      _MetricEntry(label: 'Padding', value: _sectionPadding.toStringAsFixed(1), note: 'Outer padding around decorated sections.', icon: Icons.padding_outlined),
      _MetricEntry(label: 'Radius', value: _laneRadius.toStringAsFixed(1), note: 'Decorated lane corner radius.', icon: Icons.circle_outlined),
      _MetricEntry(label: 'Border', value: _laneBorder.toStringAsFixed(2), note: 'Lane border stroke width.', icon: Icons.border_all_outlined),
      _MetricEntry(label: 'Opacity', value: _laneOpacity.toStringAsFixed(2), note: 'Background opacity of lane decoration.', icon: Icons.opacity_outlined),
      _MetricEntry(label: 'Gradient Shift', value: _gradientShift.toStringAsFixed(2), note: 'Color blend bias for gradients.', icon: Icons.gradient_outlined),
      _MetricEntry(label: 'Stripe Density', value: _stripeDensity.toStringAsFixed(2), note: 'Pattern intensity in stage background.', icon: Icons.texture_outlined),
      _MetricEntry(label: 'Item Spacing', value: _itemSpacing.toStringAsFixed(1), note: 'List/grid spacing in lanes.', icon: Icons.space_bar_outlined),
      _MetricEntry(label: 'Tile Aspect', value: _tileAspect.toStringAsFixed(2), note: 'Mosaic grid tile aspect ratio.', icon: Icons.grid_view_outlined),
      _MetricEntry(label: 'Switches', value: 'theme=$_themeSwitches scenario=$_scenarioSwitches shape=$_shapeSwitches', note: 'Key control switch counts.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Control Edits', value: '$_controlEdits', note: 'Slider and toggle interactions.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Scroll Samples', value: '$_scrollSamples', note: 'Captured scroll listener samples.', icon: Icons.timeline_outlined),
      _MetricEntry(label: 'Scroll Pixels', value: _snapshot.scrollPixels.toStringAsFixed(1), note: 'Current stage scroll offset.', icon: Icons.vertical_align_bottom_outlined),
      _MetricEntry(label: 'Snapshot', value: '${_snapshot.scenario} / o=${_snapshot.opacity.toStringAsFixed(2)} / r=${_snapshot.radius.toStringAsFixed(1)}', note: 'Last decoration snapshot values.', icon: Icons.camera_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Most recent interaction phase.', icon: Icons.flag_outlined),
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
            Text('theme=${_themes[_themeIndex].id} scenario=${_scenarios[_scenarioIndex].id.name} shape=${_shape.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stage=${_panelHeight.toStringAsFixed(0)} pad=${_sectionPadding.toStringAsFixed(1)} radius=${_laneRadius.toStringAsFixed(1)} border=${_laneBorder.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('opacity=${_laneOpacity.toStringAsFixed(2)} shift=${_gradientShift.toStringAsFixed(2)} stripes=${_stripeDensity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('spacing=${_itemSpacing.toStringAsFixed(1)} aspect=${_tileAspect.toStringAsFixed(2)} scroll=${_snapshot.scrollPixels.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('lanes hero=$_showHeroLane group=$_showGroupLane grid=$_showGridLane inset=$_showInsetLane', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches t=$_themeSwitches s=$_scenarioSwitches sh=$_shapeSwitches edits=$_controlEdits samples=$_scrollSamples', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological stream of scenario and decoration control events.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _StageGridPainter extends CustomPainter {
  const _StageGridPainter({required this.progress, required this.density});

  final double progress;
  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wash = Paint()..color = Colors.black.withValues(alpha: 0.14);
    canvas.drawRect(Offset.zero & size, wash);

    final Paint stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    final double step = (30 - (density * 20)).clamp(8, 30);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x + (progress * 20), 0), Offset(x + size.height + (progress * 20), size.height), stripe);
    }

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..strokeWidth = 1;
    const double g = 28;
    for (double x = 0; x <= size.width; x += g) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += g) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _StageGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.density != density;
  }
}
