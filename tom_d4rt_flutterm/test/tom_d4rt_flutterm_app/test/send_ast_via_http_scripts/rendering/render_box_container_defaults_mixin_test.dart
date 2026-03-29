import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemeProfile> _profiles = <_ThemeProfile>[
  _ThemeProfile(
    id: 'lab',
    name: 'Lab Signal',
    description: 'Balanced profile for tracing paint and hit-test behavior.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'amber',
    name: 'Amber Console',
    description: 'Warm profile that highlights z-order and active hit regions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'ice',
    name: 'Ice Grid',
    description: 'Cool profile for spatial layout tuning and baseline review.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'night',
    name: 'Night Ops',
    description: 'Dark profile for high-contrast diagnostics sessions.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    id: 'stage',
    title: 'Layout Stage',
    subtitle: 'Observe how custom offsets are assigned to each child in linked-list order.',
  ),
  _Scenario(
    id: 'paint',
    title: 'Paint Pass',
    subtitle: 'Inspect painting order and optional child bounds overlays.',
  ),
  _Scenario(
    id: 'hit',
    title: 'Hit Testing',
    subtitle: 'Tap overlapping regions to validate front-to-back hit behavior.',
  ),
  _Scenario(
    id: 'traversal',
    title: 'Traversal',
    subtitle: 'Track firstChild, lastChild, and childCount snapshots from the render object.',
  ),
  _Scenario(
    id: 'compare',
    title: 'Comparisons',
    subtitle: 'Contrast this mixin-driven render object with Stack and Wrap widgets.',
  ),
];

const List<_NodeModel> _nodes = <_NodeModel>[
  _NodeModel(id: 'A', label: 'Anchor', color: Color(0xFF0EA5E9), hint: 'Primary reference node'),
  _NodeModel(id: 'B', label: 'Beacon', color: Color(0xFF22C55E), hint: 'Secondary lane probe'),
  _NodeModel(id: 'C', label: 'Core', color: Color(0xFFF59E0B), hint: 'Center marker for overlaps'),
  _NodeModel(id: 'D', label: 'Delta', color: Color(0xFFF43F5E), hint: 'High-priority overlap card'),
  _NodeModel(id: 'E', label: 'Echo', color: Color(0xFF8B5CF6), hint: 'Trailing child in linked list'),
  _NodeModel(id: 'F', label: 'Flux', color: Color(0xFF14B8A6), hint: 'Rhythm card for wave mode'),
  _NodeModel(id: 'G', label: 'Grid', color: Color(0xFF3B82F6), hint: 'Edge card for bounds checks'),
];

const List<String> _guideBullets = <String>[
  'RenderBoxContainerDefaultsMixin provides reusable traversal logic for RenderBox containers.',
  'defaultPaint paints children in linked-list order using each child parent-data offset.',
  'defaultHitTestChildren checks children in reverse paint order, so top-most visuals are hit first.',
  'ContainerRenderObjectMixin gives firstChild/lastChild and sibling pointers for efficient walking.',
  'Always set up parent data in setupParentData so each child has compatible offset storage.',
  'Use explicit layout policies in performLayout and keep painting/hit testing delegated when possible.',
  'Diagnostics snapshots are useful to verify order assumptions during interpreter integration.',
  'When children overlap, hit testing behavior is often the first regression signal to monitor.',
  'Pair custom render objects with clear UI controls to make behavior understandable for other developers.',
  'Prefer stable child identity labels when logging traversal to avoid confusion in reordered sets.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'Why use RenderBoxContainerDefaultsMixin?',
    answer: 'It avoids reimplementing paint and hit-test loops for multi-child RenderBox containers.',
  ),
  _FaqItem(
    question: 'What does the mixin assume?',
    answer: 'Children are managed with ContainerRenderObjectMixin and use compatible parent data with offsets.',
  ),
  _FaqItem(
    question: 'When should I override defaultPaint?',
    answer: 'Only when paint order or effects differ from normal child traversal behavior.',
  ),
  _FaqItem(
    question: 'Can this replace Stack?',
    answer: 'Not directly; this is a render-layer utility for building custom containers, while Stack is a widget abstraction.',
  ),
  _FaqItem(
    question: 'How do I debug hit testing?',
    answer: 'Log hit events and toggle overlap-heavy layouts to validate front-most child resolution.',
  ),
];

enum _LayoutMode {
  stack,
  lanes,
  wave,
  radial,
  spiral,
}

class _ThemeProfile {
  const _ThemeProfile({
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

class _NodeModel {
  const _NodeModel({required this.id, required this.label, required this.color, required this.hint});

  final String id;
  final String label;
  final Color color;
  final String hint;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _RenderSnapshot {
  const _RenderSnapshot({
    required this.childCount,
    required this.firstLabel,
    required this.lastLabel,
    required this.layoutMode,
    required this.paintCalls,
    required this.hitCalls,
    required this.lastHit,
  });

  final int childCount;
  final String firstLabel;
  final String lastLabel;
  final String layoutMode;
  final int paintCalls;
  final int hitCalls;
  final String lastHit;
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
  return const _RenderBoxContainerDefaultsMixinStudio();
}

class _RenderBoxContainerDefaultsMixinStudio extends StatefulWidget {
  const _RenderBoxContainerDefaultsMixinStudio();

  @override
  State<_RenderBoxContainerDefaultsMixinStudio> createState() => _RenderBoxContainerDefaultsMixinStudioState();
}

class _RenderBoxContainerDefaultsMixinStudioState extends State<_RenderBoxContainerDefaultsMixinStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _motionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 6200),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _LayoutMode _layoutMode = _LayoutMode.stack;

  bool _showGrid = true;
  bool _showBounds = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _animateBackdrop = true;
  bool _denseOverlap = false;

  double _spacing = 24;
  double _amplitude = 40;
  double _rotation = 0.2;
  double _radialBias = 0.64;
  double _canvasHeight = 320;
  double _panelPadding = 14;

  int _layoutSwitchCount = 0;
  int _tapCount = 0;
  int _themeSwitchCount = 0;
  int _boundsToggleCount = 0;
  int _gridToggleCount = 0;
  int _scenarioSwitchCount = 0;

  String _lastTappedNode = 'none';
  String _phase = 'idle';

  _RenderSnapshot _snapshot = const _RenderSnapshot(
    childCount: 0,
    firstLabel: '-',
    lastLabel: '-',
    layoutMode: 'stack',
    paintCalls: 0,
    hitCalls: 0,
    lastHit: 'none',
  );

  List<_TimelineEntry> _timeline = const <_TimelineEntry>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTimeline('Init', 'RenderBoxContainerDefaultsMixin Container Render Lab initialized.');
    });
  }

  @override
  void dispose() {
    _motionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEntry>[
        _TimelineEntry(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(60).toList(growable: false);
    });
  }

  void _updateSnapshot(_RenderSnapshot next) {
    setState(() => _snapshot = next);
  }

  void _handleNodeTap(String label) {
    setState(() {
      _tapCount += 1;
      _lastTappedNode = label;
      _phase = 'tap';
    });
    _addTimeline('Node Tap', 'Tapped node $label in ${_layoutMode.name} mode.');
  }

  void _resetStudio() {
    setState(() {
      _scenarioIndex = 0;
      _layoutMode = _LayoutMode.stack;
      _showGrid = true;
      _showBounds = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _animateBackdrop = true;
      _denseOverlap = false;
      _spacing = 24;
      _amplitude = 40;
      _rotation = 0.2;
      _radialBias = 0.64;
      _canvasHeight = 320;
      _panelPadding = 14;
      _layoutSwitchCount = 0;
      _tapCount = 0;
      _themeSwitchCount = 0;
      _boundsToggleCount = 0;
      _gridToggleCount = 0;
      _scenarioSwitchCount = 0;
      _lastTappedNode = 'none';
      _phase = 'idle';
      _timeline = const <_TimelineEntry>[];
    });
    _motionController.repeat();
    _addTimeline('Reset', 'Studio reset to defaults.');
  }

  List<_Metric> _metrics() {
    return <_Metric>[
      _Metric(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Current exploration lane.', icon: Icons.view_kanban_outlined),
      _Metric(label: 'Theme', value: _profiles[_themeIndex].name, note: 'Color profile for this session.', icon: Icons.palette_outlined),
      _Metric(label: 'Layout Mode', value: _layoutMode.name, note: 'Custom offset strategy in performLayout.', icon: Icons.grid_view_outlined),
      _Metric(label: 'Child Count', value: '${_snapshot.childCount}', note: 'Linked-list children managed by container mixin.', icon: Icons.widgets_outlined),
      _Metric(label: 'firstChild', value: _snapshot.firstLabel, note: 'First child in traversal order.', icon: Icons.first_page_outlined),
      _Metric(label: 'lastChild', value: _snapshot.lastLabel, note: 'Last child in traversal order.', icon: Icons.last_page_outlined),
      _Metric(label: 'Paint Calls', value: '${_snapshot.paintCalls}', note: 'Render object paint invocations.', icon: Icons.brush_outlined),
      _Metric(label: 'Hit Calls', value: '${_snapshot.hitCalls}', note: 'Hit-test passes through defaultHitTestChildren.', icon: Icons.ads_click_outlined),
      _Metric(label: 'Last Hit', value: _snapshot.lastHit, note: 'Latest child resolved by hit testing.', icon: Icons.touch_app_outlined),
      _Metric(label: 'Last Tap', value: _lastTappedNode, note: 'UI callback from tapped visual node.', icon: Icons.gesture_outlined),
      _Metric(label: 'Layout Switches', value: '$_layoutSwitchCount', note: 'Mode changes by controls.', icon: Icons.swap_horiz_outlined),
      _Metric(label: 'Scenario Switches', value: '$_scenarioSwitchCount', note: 'Scenario lane changes.', icon: Icons.route_outlined),
      _Metric(label: 'Theme Switches', value: '$_themeSwitchCount', note: 'Theme profile changes.', icon: Icons.tonality_outlined),
      _Metric(label: 'Bounds Toggles', value: '$_boundsToggleCount', note: 'Bounding-rect overlay toggles.', icon: Icons.crop_square_outlined),
      _Metric(label: 'Grid Toggles', value: '$_gridToggleCount', note: 'Background grid visibility toggles.', icon: Icons.grid_on_outlined),
      _Metric(label: 'Phase', value: _phase, note: 'Most recent interaction phase.', icon: Icons.flag_outlined),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeProfile profile = _profiles[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: profile.seed,
      brightness: profile.brightness,
    );

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        brightness: profile.brightness,
      ),
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
                    constraints: const BoxConstraints(maxWidth: 1360),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildControlBoard(scheme),
                        const SizedBox(height: 16),
                        _buildCanvasBoard(scheme),
                        const SizedBox(height: 16),
                        _buildTraversalBoard(scheme),
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
                Icon(Icons.account_tree_outlined, color: scheme.primary, size: 26),
                Text(
                  'RenderBoxContainerDefaultsMixin Container Render Lab',
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
              'Deep visual demonstration of a custom multi-child RenderBox using ContainerRenderObjectMixin + RenderBoxContainerDefaultsMixin for layout, paint, and hit-testing behavior.',
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
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_profiles.length, (int index) {
                final _ThemeProfile p = _profiles[index];
                return ChoiceChip(
                  selected: _themeIndex == index,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                      _themeSwitchCount += 1;
                      _phase = 'theme';
                    });
                    _addTimeline('Theme', 'Switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_profiles[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int index) {
                final _Scenario s = _scenarios[index];
                return FilterChip(
                  selected: _scenarioIndex == index,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                      _scenarioSwitchCount += 1;
                      _phase = 'scenario';
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

  Widget _buildControlBoard(ColorScheme scheme) {
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
                Text('Render Controls', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _resetStudio,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune layout parameters that flow into the custom render object using RenderBoxContainerDefaultsMixin.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _LayoutMode.values.map(( _LayoutMode mode) {
                return ChoiceChip(
                  selected: _layoutMode == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _layoutMode = mode;
                      _layoutSwitchCount += 1;
                      _phase = 'layout';
                    });
                    _addTimeline('Layout Mode', 'Switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Spacing',
              value: _spacing,
              min: 8,
              max: 72,
              divisions: 64,
              onChanged: (double v) => setState(() => _spacing = v),
              onChangeEnd: (double v) => _addTimeline('Spacing', 'Spacing updated to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Wave/Spiral Amplitude',
              value: _amplitude,
              min: 8,
              max: 96,
              divisions: 88,
              onChanged: (double v) => setState(() => _amplitude = v),
              onChangeEnd: (double v) => _addTimeline('Amplitude', 'Amplitude updated to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Rotation',
              value: _rotation,
              min: 0,
              max: 1.4,
              divisions: 140,
              onChanged: (double v) => setState(() => _rotation = v),
              onChangeEnd: (double v) => _addTimeline('Rotation', 'Rotation updated to ${v.toStringAsFixed(2)} turns.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Radial Bias',
              value: _radialBias,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _radialBias = v),
              onChangeEnd: (double v) => _addTimeline('Radial Bias', 'Radial bias updated to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Canvas Height',
              value: _canvasHeight,
              min: 220,
              max: 460,
              divisions: 120,
              onChanged: (double v) => setState(() => _canvasHeight = v),
              onChangeEnd: (double v) => _addTimeline('Canvas Height', 'Canvas height updated to ${v.toStringAsFixed(0)}.'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _showGrid,
                  onChanged: (bool? v) {
                    setState(() {
                      _showGrid = v ?? true;
                      _gridToggleCount += 1;
                    });
                    _addTimeline('Grid', _showGrid ? 'Grid enabled.' : 'Grid disabled.');
                  },
                  child: const Text('Show backdrop grid'),
                ),
                CheckboxMenuButton(
                  value: _showBounds,
                  onChanged: (bool? v) {
                    setState(() {
                      _showBounds = v ?? true;
                      _boundsToggleCount += 1;
                    });
                    _addTimeline('Bounds', _showBounds ? 'Bounds overlay enabled.' : 'Bounds overlay disabled.');
                  },
                  child: const Text('Show child bounds'),
                ),
                CheckboxMenuButton(
                  value: _denseOverlap,
                  onChanged: (bool? v) {
                    setState(() => _denseOverlap = v ?? false);
                    _addTimeline('Overlap', _denseOverlap ? 'Dense overlap enabled.' : 'Dense overlap disabled.');
                  },
                  child: const Text('Dense overlap mode'),
                ),
                CheckboxMenuButton(
                  value: _animateBackdrop,
                  onChanged: (bool? v) {
                    final bool next = v ?? true;
                    setState(() => _animateBackdrop = next);
                    if (next) {
                      _motionController.repeat();
                    } else {
                      _motionController.stop();
                    }
                    _addTimeline('Backdrop', next ? 'Backdrop animation enabled.' : 'Backdrop animation paused.');
                  },
                  child: const Text('Animate backdrop'),
                ),
                CheckboxMenuButton(
                  value: _showDiagnostics,
                  onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true),
                  child: const Text('Show diagnostics'),
                ),
                CheckboxMenuButton(
                  value: _showGuide,
                  onChanged: (bool? v) => setState(() => _showGuide = v ?? true),
                  child: const Text('Show guide board'),
                ),
                CheckboxMenuButton(
                  value: _showTimeline,
                  onChanged: (bool? v) => setState(() => _showTimeline = v ?? true),
                  child: const Text('Show timeline board'),
                ),
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

  Widget _buildCanvasBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Custom Render Canvas', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('This board uses a custom multi-child RenderBox that delegates paint/hit loops to RenderBoxContainerDefaultsMixin.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            SizedBox(
              height: _canvasHeight,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: _AnimatedBackdrop(
                      controller: _motionController,
                      showGrid: _showGrid,
                      enabled: _animateBackdrop,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: scheme.outlineVariant),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: _DefaultsRenderHost(
                            layoutMode: _layoutMode,
                            spacing: _spacing,
                            amplitude: _amplitude,
                            rotationTurns: _rotation,
                            radialBias: _radialBias,
                            showBounds: _showBounds,
                            denseOverlap: _denseOverlap,
                            onNodeTap: _handleNodeTap,
                            onSnapshot: _updateSnapshot,
                            nodes: _nodes,
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

  Widget _buildTraversalBoard(ColorScheme scheme) {
    final List<String> ordered = _nodes.map(( _NodeModel n) => '${n.id}:${n.label}').toList(growable: false);
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Traversal and Order Inspector', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Linked-list child data from ContainerRenderObjectMixin and default traversal assumptions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ordered.map((String label) {
                final bool focus = label.startsWith(_snapshot.lastHit.isEmpty ? 'none' : _snapshot.lastHit.substring(0, 1));
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: focus ? scheme.primaryContainer : scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: focus ? scheme.primary : scheme.outlineVariant),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(color: focus ? scheme.onPrimaryContainer : scheme.onSurface, fontWeight: FontWeight.w600),
                  ),
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
                    Text('Current snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text('childCount: ${_snapshot.childCount}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('firstChild: ${_snapshot.firstLabel}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('lastChild: ${_snapshot.lastLabel}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('paintCalls: ${_snapshot.paintCalls}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('hitCalls: ${_snapshot.hitCalls}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('lastHit: ${_snapshot.lastHit}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    Text('layoutMode: ${_snapshot.layoutMode}', style: TextStyle(color: scheme.onSurfaceVariant)),
                  ],
                ),
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
            Text('Comparison Board', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('The mixin is a render-layer primitive. Here are conceptual comparisons with widget-layer APIs.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1000;
                final Widget custom = _compareCard(
                  scheme: scheme,
                  title: 'Custom RenderBox + Defaults Mixin',
                  subtitle: 'Manual layout policy with delegated paint/hit traversal.',
                  color: const Color(0xFF0F766E),
                  child: const Text('Render-layer control', textAlign: TextAlign.center),
                );
                final Widget stack = _compareCard(
                  scheme: scheme,
                  title: 'Stack',
                  subtitle: 'Widget-layer API for layered positioning and overlap.',
                  color: const Color(0xFF1D4ED8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const <Widget>[
                      Icon(Icons.crop_square, size: 44),
                      Icon(Icons.layers_outlined, size: 26),
                    ],
                  ),
                );
                final Widget wrap = _compareCard(
                  scheme: scheme,
                  title: 'Wrap',
                  subtitle: 'Flowing layout widget without custom render-object wiring.',
                  color: const Color(0xFFB45309),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: const <Widget>[
                      Chip(label: Text('A')),
                      Chip(label: Text('B')),
                      Chip(label: Text('C')),
                    ],
                  ),
                );
                if (narrow) {
                  return Column(
                    children: <Widget>[
                      custom,
                      const SizedBox(height: 10),
                      stack,
                      const SizedBox(height: 10),
                      wrap,
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    Expanded(child: custom),
                    const SizedBox(width: 10),
                    Expanded(child: stack),
                    const SizedBox(width: 10),
                    Expanded(child: wrap),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareCard({
    required ColorScheme scheme,
    required String title,
    required String subtitle,
    required Color color,
    required Widget child,
  }) {
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
              height: 94,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.70)),
              ),
              child: Center(child: child),
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
            Text('Metrics and Diagnostics', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
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
                    childAspectRatio: columns == 1 ? 2.6 : 1.9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _Metric m = metrics[index];
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
            Text('theme=${_profiles[_themeIndex].id} scenario=${_scenarios[_scenarioIndex].id}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('layoutMode=${_layoutMode.name} spacing=${_spacing.toStringAsFixed(2)} amplitude=${_amplitude.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('rotation=${_rotation.toStringAsFixed(2)} radialBias=${_radialBias.toStringAsFixed(2)} denseOverlap=$_denseOverlap', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('canvasHeight=${_canvasHeight.toStringAsFixed(0)} showBounds=$_showBounds showGrid=$_showGrid', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('childCount=${_snapshot.childCount} first=${_snapshot.firstLabel} last=${_snapshot.lastLabel}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('paintCalls=${_snapshot.paintCalls} hitCalls=${_snapshot.hitCalls} lastHit=${_snapshot.lastHit}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('tapCount=$_tapCount phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Guide and FAQ', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._guideBullets.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            ..._faq.map(( _FaqItem item) {
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
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _timeline = const <_TimelineEntry>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of control actions and render-layer state changes.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                child: Text('Timeline is empty. Interact with controls to collect events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEntry entry) {
                  final String stamp = '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')}:${entry.time.second.toString().padLeft(2, '0')}';
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

class _DefaultsRenderHost extends StatelessWidget {
  const _DefaultsRenderHost({
    required this.layoutMode,
    required this.spacing,
    required this.amplitude,
    required this.rotationTurns,
    required this.radialBias,
    required this.showBounds,
    required this.denseOverlap,
    required this.onNodeTap,
    required this.onSnapshot,
    required this.nodes,
  });

  final _LayoutMode layoutMode;
  final double spacing;
  final double amplitude;
  final double rotationTurns;
  final double radialBias;
  final bool showBounds;
  final bool denseOverlap;
  final ValueChanged<String> onNodeTap;
  final ValueChanged<_RenderSnapshot> onSnapshot;
  final List<_NodeModel> nodes;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int index = 0; index < nodes.length; index += 1) {
      final _NodeModel node = nodes[index];
      children.add(
        _NodeId(
          id: node.id,
          child: _NodeCard(
            model: node,
            dense: denseOverlap,
            onTap: () => onNodeTap('${node.id}:${node.label}'),
          ),
        ),
      );
    }

    return _DefaultsContainer(
      layoutMode: layoutMode,
      spacing: spacing,
      amplitude: amplitude,
      rotationTurns: rotationTurns,
      radialBias: radialBias,
      showBounds: showBounds,
      onSnapshot: onSnapshot,
      childIds: nodes.map(( _NodeModel n) => '${n.id}:${n.label}').toList(growable: false),
      children: children,
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.model, required this.dense, required this.onTap});

  final _NodeModel model;
  final bool dense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Material(
      color: model.color.withValues(alpha: dense ? 0.92 : 0.84),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: dense ? 90 : 124,
          height: dense ? 62 : 78,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withValues(alpha: 0.18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.26),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(model.id, style: TextStyle(color: scheme.onPrimary, fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      model.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                model.hint,
                maxLines: dense ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: scheme.onPrimary.withValues(alpha: 0.90), fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NodeId extends ParentDataWidget<_DefaultsParentData> {
  const _NodeId({required this.id, required super.child});

  final String id;

  @override
  void applyParentData(RenderObject renderObject) {
    final _DefaultsParentData parentData = renderObject.parentData! as _DefaultsParentData;
    if (parentData.id != id) {
      parentData.id = id;
      final RenderObject? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _DefaultsContainer;
}

class _DefaultsContainer extends MultiChildRenderObjectWidget {
  const _DefaultsContainer({
    required this.layoutMode,
    required this.spacing,
    required this.amplitude,
    required this.rotationTurns,
    required this.radialBias,
    required this.showBounds,
    required this.onSnapshot,
    required this.childIds,
    required super.children,
  });

  final _LayoutMode layoutMode;
  final double spacing;
  final double amplitude;
  final double rotationTurns;
  final double radialBias;
  final bool showBounds;
  final ValueChanged<_RenderSnapshot> onSnapshot;
  final List<String> childIds;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderDefaultsContainer(
      layoutMode: layoutMode,
      spacing: spacing,
      amplitude: amplitude,
      rotationTurns: rotationTurns,
      radialBias: radialBias,
      showBounds: showBounds,
      childIds: childIds,
      onSnapshot: onSnapshot,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderDefaultsContainer renderObject) {
    renderObject
      ..layoutMode = layoutMode
      ..spacing = spacing
      ..amplitude = amplitude
      ..rotationTurns = rotationTurns
      ..radialBias = radialBias
      ..showBounds = showBounds
      ..childIds = childIds
      ..onSnapshot = onSnapshot;
  }
}

class _DefaultsParentData extends ContainerBoxParentData<RenderBox> {
  String id = '?';
}

class _RenderDefaultsContainer extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DefaultsParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DefaultsParentData> {
  _RenderDefaultsContainer({
    required _LayoutMode layoutMode,
    required double spacing,
    required double amplitude,
    required double rotationTurns,
    required double radialBias,
    required bool showBounds,
    required List<String> childIds,
    required ValueChanged<_RenderSnapshot> onSnapshot,
  })  : _layoutMode = layoutMode,
        _spacing = spacing,
        _amplitude = amplitude,
        _rotationTurns = rotationTurns,
        _radialBias = radialBias,
        _showBounds = showBounds,
        _childIds = childIds,
        _onSnapshot = onSnapshot;

  _LayoutMode _layoutMode;
  double _spacing;
  double _amplitude;
  double _rotationTurns;
  double _radialBias;
  bool _showBounds;
  List<String> _childIds;
  ValueChanged<_RenderSnapshot> _onSnapshot;

  int _paintCalls = 0;
  int _hitCalls = 0;
  String _lastHit = 'none';

  _LayoutMode get layoutMode => _layoutMode;
  set layoutMode(_LayoutMode value) {
    if (_layoutMode == value) {
      return;
    }
    _layoutMode = value;
    markNeedsLayout();
  }

  double get spacing => _spacing;
  set spacing(double value) {
    if (_spacing == value) {
      return;
    }
    _spacing = value;
    markNeedsLayout();
  }

  double get amplitude => _amplitude;
  set amplitude(double value) {
    if (_amplitude == value) {
      return;
    }
    _amplitude = value;
    markNeedsLayout();
  }

  double get rotationTurns => _rotationTurns;
  set rotationTurns(double value) {
    if (_rotationTurns == value) {
      return;
    }
    _rotationTurns = value;
    markNeedsLayout();
  }

  double get radialBias => _radialBias;
  set radialBias(double value) {
    if (_radialBias == value) {
      return;
    }
    _radialBias = value;
    markNeedsLayout();
  }

  bool get showBounds => _showBounds;
  set showBounds(bool value) {
    if (_showBounds == value) {
      return;
    }
    _showBounds = value;
    markNeedsPaint();
  }

  List<String> get childIds => _childIds;
  set childIds(List<String> value) {
    _childIds = value;
    markNeedsLayout();
  }

  ValueChanged<_RenderSnapshot> get onSnapshot => _onSnapshot;
  set onSnapshot(ValueChanged<_RenderSnapshot> value) {
    _onSnapshot = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _DefaultsParentData) {
      child.parentData = _DefaultsParentData();
    }
  }

  @override
  void performLayout() {
    final Size constrained = constraints.biggest;
    final double width = constrained.width.isFinite ? constrained.width : constraints.constrainWidth(620);
    final double height = constrained.height.isFinite ? constrained.height : constraints.constrainHeight(320);
    size = Size(width, height);

    final BoxConstraints childConstraints = BoxConstraints.loose(Size(size.width, size.height));

    final List<RenderBox> childrenList = <RenderBox>[];
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(childConstraints, parentUsesSize: true);
      childrenList.add(child);
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      data.id = data.id == '?' && childrenList.length <= _childIds.length ? _childIds[childrenList.length - 1] : data.id;
      child = data.nextSibling;
    }

    if (childrenList.isEmpty) {
      _emitSnapshot();
      return;
    }

    switch (_layoutMode) {
      case _LayoutMode.stack:
        _layoutStack(childrenList);
        break;
      case _LayoutMode.lanes:
        _layoutLanes(childrenList);
        break;
      case _LayoutMode.wave:
        _layoutWave(childrenList);
        break;
      case _LayoutMode.radial:
        _layoutRadial(childrenList);
        break;
      case _LayoutMode.spiral:
        _layoutSpiral(childrenList);
        break;
    }

    _emitSnapshot();
  }

  void _layoutStack(List<RenderBox> childrenList) {
    final double startX = 12;
    final double startY = 10;
    for (int i = 0; i < childrenList.length; i += 1) {
      final RenderBox child = childrenList[i];
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final double x = startX + (_spacing * 0.58 * i).clamp(0, size.width - child.size.width);
      final double y = startY + (_spacing * 0.54 * i).clamp(0, size.height - child.size.height);
      data.offset = Offset(x, y);
    }
  }

  void _layoutLanes(List<RenderBox> childrenList) {
    final int laneCount = 3;
    final double laneHeight = size.height / laneCount;
    for (int i = 0; i < childrenList.length; i += 1) {
      final RenderBox child = childrenList[i];
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final int lane = i % laneCount;
      final double y = lane * laneHeight + (laneHeight - child.size.height) * 0.5;
      final double x = 10 + (i * _spacing * 1.8);
      data.offset = Offset(
        x.clamp(0, math.max(0, size.width - child.size.width)),
        y.clamp(0, math.max(0, size.height - child.size.height)),
      );
    }
  }

  void _layoutWave(List<RenderBox> childrenList) {
    final double centerY = size.height * 0.5;
    final double waveLength = math.max(140, size.width * 0.42);
    for (int i = 0; i < childrenList.length; i += 1) {
      final RenderBox child = childrenList[i];
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final double x = 12 + (i * _spacing * 1.9);
      final double phase = (x / waveLength) + (_rotationTurns * math.pi * 2);
      final double y = centerY + math.sin(phase) * _amplitude - (child.size.height * 0.5);
      data.offset = Offset(
        x.clamp(0, math.max(0, size.width - child.size.width)),
        y.clamp(0, math.max(0, size.height - child.size.height)),
      );
    }
  }

  void _layoutRadial(List<RenderBox> childrenList) {
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = math.min(size.width, size.height) * 0.34 * _radialBias;
    for (int i = 0; i < childrenList.length; i += 1) {
      final RenderBox child = childrenList[i];
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final double angle = ((i / childrenList.length) * math.pi * 2) + (_rotationTurns * math.pi * 2);
      final double x = center.dx + math.cos(angle) * radius - (child.size.width * 0.5);
      final double y = center.dy + math.sin(angle) * radius - (child.size.height * 0.5);
      data.offset = Offset(
        x.clamp(0, math.max(0, size.width - child.size.width)),
        y.clamp(0, math.max(0, size.height - child.size.height)),
      );
    }
  }

  void _layoutSpiral(List<RenderBox> childrenList) {
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double step = math.max(10, _spacing * 0.55);
    for (int i = 0; i < childrenList.length; i += 1) {
      final RenderBox child = childrenList[i];
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final double angle = (i * 0.86) + (_rotationTurns * math.pi * 2);
      final double radius = i * step + (_amplitude * 0.22);
      final double x = center.dx + math.cos(angle) * radius - (child.size.width * 0.5);
      final double y = center.dy + math.sin(angle) * radius - (child.size.height * 0.5);
      data.offset = Offset(
        x.clamp(0, math.max(0, size.width - child.size.width)),
        y.clamp(0, math.max(0, size.height - child.size.height)),
      );
    }
  }

  void _emitSnapshot() {
    final String first = _nodeLabel(firstChild);
    final String last = _nodeLabel(lastChild);
    onSnapshot(
      _RenderSnapshot(
        childCount: childCount,
        firstLabel: first,
        lastLabel: last,
        layoutMode: _layoutMode.name,
        paintCalls: _paintCalls,
        hitCalls: _hitCalls,
        lastHit: _lastHit,
      ),
    );
  }

  String _nodeLabel(RenderBox? child) {
    if (child == null) {
      return '-';
    }
    final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
    final String id = data.id;
    final int index = _childIds.indexWhere((String element) => element.startsWith(id));
    if (index >= 0) {
      return _childIds[index];
    }
    return id;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    _hitCalls += 1;
    final bool hit = defaultHitTestChildren(result, position: position);
    if (!hit) {
      _lastHit = 'none';
      _emitSnapshot();
      return false;
    }

    RenderBox? child = lastChild;
    while (child != null) {
      final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
      final Rect rect = data.offset & child.size;
      if (rect.contains(position)) {
        _lastHit = _nodeLabel(child);
        _emitSnapshot();
        return true;
      }
      child = data.previousSibling;
    }

    _lastHit = 'unknown';
    _emitSnapshot();
    return true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _paintCalls += 1;
    defaultPaint(context, offset);

    if (_showBounds) {
      final Paint paint = Paint()
        ..color = const Color(0xAA111827)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      RenderBox? child = firstChild;
      while (child != null) {
        final _DefaultsParentData data = child.parentData! as _DefaultsParentData;
        final Rect rect = (offset + data.offset) & child.size;
        context.canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), paint);
        child = data.nextSibling;
      }
    }

    _emitSnapshot();
  }
}

class _AnimatedBackdrop extends StatelessWidget {
  const _AnimatedBackdrop({
    required this.controller,
    required this.showGrid,
    required this.enabled,
  });

  final Animation<double> controller;
  final bool showGrid;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final double t = enabled ? controller.value : 0;
        return CustomPaint(
          painter: _BackdropPainter(progress: t, showGrid: showGrid),
        );
      },
    );
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({required this.progress, required this.showGrid});

  final double progress;
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> palette = <Color>[
      Color.lerp(const Color(0xFF22C55E), const Color(0xFF0EA5E9), (math.sin(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
      Color.lerp(const Color(0xFF6366F1), const Color(0xFF14B8A6), (math.sin(progress * math.pi * 4) + 1) / 2)!,
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
    for (int i = 0; i < 11; i += 1) {
      final double wave = progress * math.pi * 2 + (i * 0.52);
      final double x = size.width * 0.5 + math.cos(wave) * size.width * 0.42;
      final double y = size.height * 0.5 + math.sin(wave * 1.21) * size.height * 0.35;
      circles.color = palette[i % palette.length].withValues(alpha: 0.20 + ((i % 3) * 0.07));
      canvas.drawCircle(Offset(x, y), 12 + ((i % 4) * 7), circles);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white.withValues(alpha: 0.14)
        ..strokeWidth = 1;
      const double step = 24;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Paint wash = Paint()..color = Colors.black.withValues(alpha: 0.17);
    canvas.drawRect(Offset.zero & size, wash);
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.showGrid != showGrid;
  }
}
