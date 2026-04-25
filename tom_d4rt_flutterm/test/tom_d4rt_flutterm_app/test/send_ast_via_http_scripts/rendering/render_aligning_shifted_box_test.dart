import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'atlas',
    name: 'Atlas Grid',
    description: 'Technical board style with high readability for alignment diagnostics.',
    seed: Color(0xFF0E7490),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'ember',
    name: 'Ember Studio',
    description: 'Warm accent profile useful in workshops and walkthrough sessions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'quartz',
    name: 'Quartz Night',
    description: 'Dark profile for spotlighting geometry and offset overlays.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'mint',
    name: 'Mint Diagram',
    description: 'Calm profile for long teaching sessions and team review boards.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = <_Scenario>[
  _Scenario(
    id: 'fundamentals',
    title: 'Alignment Fundamentals',
    subtitle: 'Study how resolved alignment drives child offset in a host box.',
  ),
  _Scenario(
    id: 'factor-lab',
    title: 'Factor Laboratory',
    subtitle: 'Explore widthFactor and heightFactor interactions with constraints.',
  ),
  _Scenario(
    id: 'rtl-ltr',
    title: 'Text Direction Study',
    subtitle: 'Compare directional alignments in LTR and RTL contexts.',
  ),
  _Scenario(
    id: 'operations',
    title: 'Operations Console',
    subtitle: 'Run integrated diagnostics with timeline, snapshots, and guide rails.',
  ),
];

const List<_PresetAlignment> _alignmentPresets = <_PresetAlignment>[
  _PresetAlignment(id: 'center', label: 'Center', x: 0, y: 0, note: 'Neutral placement for baseline checks.'),
  _PresetAlignment(id: 'tl', label: 'Top Left', x: -1, y: -1, note: 'Pins child to top-left corner.'),
  _PresetAlignment(id: 'tr', label: 'Top Right', x: 1, y: -1, note: 'Pins child to top-right corner.'),
  _PresetAlignment(id: 'bl', label: 'Bottom Left', x: -1, y: 1, note: 'Pins child to bottom-left corner.'),
  _PresetAlignment(id: 'br', label: 'Bottom Right', x: 1, y: 1, note: 'Pins child to bottom-right corner.'),
  _PresetAlignment(id: 'axisX', label: 'Axis X', x: 1, y: 0, note: 'Horizontal shift, vertical center.'),
  _PresetAlignment(id: 'axisY', label: 'Axis Y', x: 0, y: 1, note: 'Vertical shift, horizontal center.'),
  _PresetAlignment(id: 'diag', label: 'Diagonal', x: 0.68, y: -0.42, note: 'Mixed vector for nuanced studies.'),
];

const List<String> _introBullets = <String>[
  'RenderAligningShiftedBox is the alignment-focused base class for several single-child render boxes.',
  'It resolves AlignmentGeometry with TextDirection and positions the child by writing BoxParentData offset.',
  'widthFactor and heightFactor can make the host size track child size proportionally before constraint clamping.',
  'This demo intentionally favors visual instrumentation over assertion-only checks.',
  'You can inspect child offset, resolved alignment, size factors, and directionality in one place.',
  'The render host below is a custom subclass that exposes standard base-class behavior clearly.',
];

const List<String> _bestPractices = <String>[
  'Choose AlignmentDirectional when horizontal meaning should follow locale direction.',
  'When using widthFactor/heightFactor, always reason about final constraints after scaling.',
  'Keep diagnostics visible when teaching render behavior to avoid hidden assumptions.',
  'Test both LTR and RTL in visual dashboards to prevent direction-specific regressions.',
  'Prefer explicit timeline logging while tuning alignment interactively.',
  'Use low-level demos to validate interpreter bridge behavior against Flutter runtime expectations.',
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

class _PresetAlignment {
  const _PresetAlignment({
    required this.id,
    required this.label,
    required this.x,
    required this.y,
    required this.note,
  });

  final String id;
  final String label;
  final double x;
  final double y;
  final String note;
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

class _Snapshot {
  const _Snapshot({
    required this.hostSize,
    required this.childSize,
    required this.childOffset,
    required this.alignment,
    required this.direction,
    required this.widthFactor,
    required this.heightFactor,
  });

  final Size hostSize;
  final Size childSize;
  final Offset childOffset;
  final Alignment alignment;
  final TextDirection direction;
  final double? widthFactor;
  final double? heightFactor;
}

dynamic build(BuildContext context) {
  return const _RenderAligningShiftedBoxStudio();
}

class _RenderAligningShiftedBoxStudio extends StatefulWidget {
  const _RenderAligningShiftedBoxStudio();

  @override
  State<_RenderAligningShiftedBoxStudio> createState() => _RenderAligningShiftedBoxStudioState();
}

class _RenderAligningShiftedBoxStudioState extends State<_RenderAligningShiftedBoxStudio> {
  final GlobalKey _hostKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  double _alignX = 0;
  double _alignY = 0;
  double _hostWidth = 360;
  double _hostHeight = 220;
  double _childWidth = 120;
  double _childHeight = 84;

  bool _useWidthFactor = false;
  bool _useHeightFactor = false;
  double _widthFactor = 1.2;
  double _heightFactor = 1.3;

  bool _directional = false;
  bool _rtl = false;
  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _animatePulse = true;

  int _applyCount = 0;
  int _snapshotCount = 0;
  int _toggleCount = 0;

  _Snapshot? _snapshot;
  List<_TimelineEntry> _timeline = const <_TimelineEntry>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureSnapshot('Initial layout captured.');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    final List<_TimelineEntry> next = <_TimelineEntry>[
      _TimelineEntry(time: DateTime.now(), title: title, message: message),
      ..._timeline,
    ];
    setState(() {
      _timeline = next.take(36).toList(growable: false);
    });
  }

  void _captureSnapshot(String reason) {
    final BuildContext? hostContext = _hostKey.currentContext;
    if (hostContext == null || !hostContext.mounted) {
      return;
    }

    final RenderObject? object = hostContext.findRenderObject();
    if (object is! _DemoRenderAligningShiftedBox) {
      return;
    }

    final RenderBox? child = object.child;
    final BoxParentData? parentData = child?.parentData as BoxParentData?;
    final Alignment resolved = object.alignment.resolve(object.textDirection ?? TextDirection.ltr);
    final _Snapshot data = _Snapshot(
      hostSize: object.size,
      childSize: child?.size ?? Size.zero,
      childOffset: parentData?.offset ?? Offset.zero,
      alignment: resolved,
      direction: object.textDirection ?? TextDirection.ltr,
      widthFactor: object.widthFactor,
      heightFactor: object.heightFactor,
    );

    setState(() {
      _snapshot = data;
      _snapshotCount += 1;
    });
    _addTimeline('Snapshot', reason);
  }

  void _applyPreset(_PresetAlignment preset) {
    setState(() {
      _alignX = preset.x;
      _alignY = preset.y;
      _applyCount += 1;
    });
    _addTimeline('Preset ${preset.label}', preset.note);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureSnapshot('Applied preset ${preset.label}.');
    });
  }

  void _resetControls() {
    setState(() {
      _alignX = 0;
      _alignY = 0;
      _hostWidth = 360;
      _hostHeight = 220;
      _childWidth = 120;
      _childHeight = 84;
      _useWidthFactor = false;
      _useHeightFactor = false;
      _widthFactor = 1.2;
      _heightFactor = 1.3;
      _directional = false;
      _rtl = false;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _animatePulse = true;
      _toggleCount += 1;
    });
    _addTimeline('Reset', 'Controls restored to default values.');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureSnapshot('Captured after reset.');
    });
  }

  AlignmentGeometry _alignmentGeometry() {
    if (_directional) {
      return AlignmentDirectional(_alignX, _alignY);
    }
    return Alignment(_alignX, _alignY);
  }

  List<_Metric> _buildMetrics(ColorScheme scheme) {
    final _Snapshot? s = _snapshot;
    final String host = s == null
        ? '--'
        : '${s.hostSize.width.toStringAsFixed(1)} x ${s.hostSize.height.toStringAsFixed(1)}';
    final String child = s == null
        ? '--'
        : '${s.childSize.width.toStringAsFixed(1)} x ${s.childSize.height.toStringAsFixed(1)}';
    final String offset = s == null
        ? '--'
        : '(${s.childOffset.dx.toStringAsFixed(1)}, ${s.childOffset.dy.toStringAsFixed(1)})';
    final String resolved = s == null
        ? '--'
        : '(${s.alignment.x.toStringAsFixed(2)}, ${s.alignment.y.toStringAsFixed(2)})';

    return <_Metric>[
      _Metric(label: 'Host Size', value: host, note: 'Final constrained size of host render box.', icon: Icons.fit_screen),
      _Metric(label: 'Child Size', value: child, note: 'Measured child size used for alignment.', icon: Icons.crop_square),
      _Metric(label: 'Child Offset', value: offset, note: 'BoxParentData offset written by alignChild().', icon: Icons.open_with),
      _Metric(label: 'Resolved', value: resolved, note: 'Resolved alignment after directionality processing.', icon: Icons.my_location),
      _Metric(label: 'Snapshots', value: '$_snapshotCount', note: 'Total render snapshots collected.', icon: Icons.camera_alt_outlined),
      _Metric(label: 'Preset Applies', value: '$_applyCount', note: 'How many preset applications were executed.', icon: Icons.checklist_rtl_outlined),
      _Metric(label: 'Toggles', value: '$_toggleCount', note: 'Count of reset/toggle operations.', icon: Icons.tune),
      _Metric(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Visual profile currently active.', icon: Icons.palette_outlined),
      _Metric(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Narrative track currently selected.', icon: Icons.dashboard_customize_outlined),
      _Metric(label: 'Direction', value: _rtl ? 'RTL' : 'LTR', note: 'Direction that resolves directional alignment.', icon: Icons.swap_horiz),
      _Metric(label: 'Width Factor', value: _useWidthFactor ? _widthFactor.toStringAsFixed(2) : 'disabled', note: 'Host width scales with child width when enabled.', icon: Icons.width_normal),
      _Metric(label: 'Height Factor', value: _useHeightFactor ? _heightFactor.toStringAsFixed(2) : 'disabled', note: 'Host height scales with child height when enabled.', icon: Icons.height),
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
      child: DefaultTextStyle(
        style: TextStyle(color: scheme.onSurface, fontSize: 14),
        child: Directionality(
          textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
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
                            _buildThemeAndScenarioBar(scheme),
                            const SizedBox(height: 16),
                            _buildMainConsole(scheme),
                            const SizedBox(height: 16),
                            _buildPresetRibbon(scheme),
                            const SizedBox(height: 16),
                            _buildMetricsGrid(scheme),
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
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: <Widget>[
                Icon(Icons.align_horizontal_left_rounded, color: scheme.primary, size: 24),
                Text(
                  'RenderAligningShiftedBox Deep Demo',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
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
              'A render-layer exploration of alignment resolution, child offset math, and directional behavior.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAndScenarioBar(ColorScheme scheme) {
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
                final bool selected = index == _themeIndex;
                return ChoiceChip(
                  selected: selected,
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
            const SizedBox(height: 12),
            Text(
              _themePresets[_themeIndex].description,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildMainConsole(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        if (narrow) {
          return Column(
            children: <Widget>[
              _buildRenderHostPanel(scheme),
              const SizedBox(height: 16),
              _buildControlPanel(scheme),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: _buildRenderHostPanel(scheme)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _buildControlPanel(scheme)),
          ],
        );
      },
    );
  }

  Widget _buildRenderHostPanel(ColorScheme scheme) {
    final AlignmentGeometry geometry = _alignmentGeometry();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Render Host',
              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              'Live host driven by a custom subclass of RenderAligningShiftedBox.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: _hostWidth,
                height: _hostHeight,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Stack(
                  children: <Widget>[
                    if (_showGrid) Positioned.fill(child: CustomPaint(painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.24)))),
                    Positioned.fill(
                      child: Center(
                        child: _RenderAligningShiftedBoxHost(
                          key: _hostKey,
                          alignment: geometry,
                          textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
                          widthFactor: _useWidthFactor ? _widthFactor : null,
                          heightFactor: _useHeightFactor ? _heightFactor : null,
                          child: _buildChildNode(scheme),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: scheme.outlineVariant),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Text(
                            _rtl ? 'Direction: RTL' : 'Direction: LTR',
                            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () => _captureSnapshot('Manual snapshot request.'),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Capture Snapshot'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _rtl = !_rtl;
                      _toggleCount += 1;
                    });
                    _addTimeline('Direction Toggle', _rtl ? 'Switched to RTL.' : 'Switched to LTR.');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _captureSnapshot('Captured after direction toggle.');
                    });
                  },
                  icon: const Icon(Icons.swap_horiz),
                  label: Text(_rtl ? 'Switch to LTR' : 'Switch to RTL'),
                ),
                FilledButton.icon(
                  onPressed: _resetControls,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset Console'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildNode(ColorScheme scheme) {
    final Widget childBody = Container(
      width: _childWidth,
      height: _childHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: scheme.primary.withValues(alpha: 0.22), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.adjust_rounded, color: scheme.onPrimaryContainer),
            const SizedBox(height: 4),
            Text(
              '${_childWidth.toStringAsFixed(0)} x ${_childHeight.toStringAsFixed(0)}',
              style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );

    if (!_animatePulse) {
      return childBody;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.96, end: 1.0),
      duration: const Duration(milliseconds: 680),
      curve: Curves.easeInOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(scale: value, child: child);
      },
      child: childBody,
    );
  }

  Widget _buildControlPanel(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Tune alignment, factors, host and child dimensions, and diagnostics overlays.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            _sliderRow(
              scheme: scheme,
              label: 'Alignment X',
              value: _alignX,
              min: -1,
              max: 1,
              divisions: 40,
              onChanged: (double value) {
                setState(() {
                  _alignX = value;
                });
              },
              onChangeEnd: (_) => _captureSnapshot('Alignment X changed.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Alignment Y',
              value: _alignY,
              min: -1,
              max: 1,
              divisions: 40,
              onChanged: (double value) {
                setState(() {
                  _alignY = value;
                });
              },
              onChangeEnd: (_) => _captureSnapshot('Alignment Y changed.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Host Width',
              value: _hostWidth,
              min: 240,
              max: 640,
              divisions: 80,
              onChanged: (double value) => setState(() => _hostWidth = value),
              onChangeEnd: (_) => _captureSnapshot('Host width changed.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Host Height',
              value: _hostHeight,
              min: 160,
              max: 420,
              divisions: 65,
              onChanged: (double value) => setState(() => _hostHeight = value),
              onChangeEnd: (_) => _captureSnapshot('Host height changed.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Width',
              value: _childWidth,
              min: 40,
              max: 260,
              divisions: 55,
              onChanged: (double value) => setState(() => _childWidth = value),
              onChangeEnd: (_) => _captureSnapshot('Child width changed.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Height',
              value: _childHeight,
              min: 28,
              max: 220,
              divisions: 48,
              onChanged: (double value) => setState(() => _childHeight = value),
              onChangeEnd: (_) => _captureSnapshot('Child height changed.'),
            ),
            const Divider(height: 24),
            SwitchListTile(
              value: _useWidthFactor,
              contentPadding: EdgeInsets.zero,
              title: const Text('Enable widthFactor'),
              subtitle: const Text('Host width tracks child width x factor.'),
              onChanged: (bool value) {
                setState(() {
                  _useWidthFactor = value;
                  _toggleCount += 1;
                });
                _captureSnapshot('widthFactor toggled.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'widthFactor',
              value: _widthFactor,
              min: 0.4,
              max: 2.8,
              divisions: 48,
              enabled: _useWidthFactor,
              onChanged: (double value) => setState(() => _widthFactor = value),
              onChangeEnd: (_) => _captureSnapshot('widthFactor changed.'),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              value: _useHeightFactor,
              contentPadding: EdgeInsets.zero,
              title: const Text('Enable heightFactor'),
              subtitle: const Text('Host height tracks child height x factor.'),
              onChanged: (bool value) {
                setState(() {
                  _useHeightFactor = value;
                  _toggleCount += 1;
                });
                _captureSnapshot('heightFactor toggled.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'heightFactor',
              value: _heightFactor,
              min: 0.4,
              max: 2.8,
              divisions: 48,
              enabled: _useHeightFactor,
              onChanged: (double value) => setState(() => _heightFactor = value),
              onChangeEnd: (_) => _captureSnapshot('heightFactor changed.'),
            ),
            const Divider(height: 24),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _directional,
              title: const Text('Use AlignmentDirectional'),
              subtitle: const Text('Resolve horizontal meaning against TextDirection.'),
              onChanged: (bool? value) {
                setState(() {
                  _directional = value ?? false;
                  _toggleCount += 1;
                });
                _captureSnapshot('Alignment geometry mode changed.');
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showGrid,
              title: const Text('Show host grid'),
              onChanged: (bool? value) => setState(() => _showGrid = value ?? true),
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
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _showDiagnostics,
              title: const Text('Show diagnostics board'),
              onChanged: (bool? value) => setState(() => _showDiagnostics = value ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _animatePulse,
              title: const Text('Pulse child node'),
              onChanged: (bool? value) => setState(() => _animatePulse = value ?? true),
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
    bool enabled = true,
  }) {
    final TextStyle labelStyle = TextStyle(color: enabled ? scheme.onSurface : scheme.onSurfaceVariant);
    return Opacity(
      opacity: enabled ? 1 : 0.48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(label, style: labelStyle)),
              Text(value.toStringAsFixed(2), style: TextStyle(color: scheme.onSurfaceVariant)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: enabled ? onChanged : null,
            onChangeEnd: enabled ? onChangeEnd : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPresetRibbon(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Alignment Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Quick jumps for common render alignment vectors.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _alignmentPresets.map((_) {
                return const SizedBox.shrink();
              }).toList(),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _alignmentPresets.map(( _PresetAlignment preset) {
                return ActionChip(
                  avatar: CircleAvatar(
                    radius: 12,
                    backgroundColor: scheme.primaryContainer,
                    child: Text(
                      preset.label.characters.first,
                      style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                  label: Text(preset.label),
                  onPressed: () => _applyPreset(preset),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(ColorScheme scheme) {
    final List<_Metric> metrics = _buildMetrics(scheme);
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
                final int count = constraints.maxWidth > 1180
                    ? 4
                    : constraints.maxWidth > 860
                        ? 3
                        : constraints.maxWidth > 560
                            ? 2
                            : 1;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: count == 1 ? 2.7 : 1.85,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _Metric metric = metrics[index];
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
                                Expanded(
                                  child: Text(
                                    metric.label,
                                    style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              metric.value,
                              style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              metric.note,
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
            if (_showDiagnostics) _buildSnapshotPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapshotPanel(ColorScheme scheme) {
    final _Snapshot? s = _snapshot;
    final String primary = s == null
        ? 'Snapshot unavailable. Click Capture Snapshot after first frame.'
        : 'Host ${s.hostSize.width.toStringAsFixed(1)} x ${s.hostSize.height.toStringAsFixed(1)}  |  '
            'Child ${s.childSize.width.toStringAsFixed(1)} x ${s.childSize.height.toStringAsFixed(1)}';
    final String secondary = s == null
        ? 'No render inspection data yet.'
        : 'Offset (${s.childOffset.dx.toStringAsFixed(2)}, ${s.childOffset.dy.toStringAsFixed(2)})  |  '
            'Resolved (${s.alignment.x.toStringAsFixed(2)}, ${s.alignment.y.toStringAsFixed(2)})  |  '
            'Direction ${s.direction.name.toUpperCase()}';

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
                Icon(Icons.memory_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Latest Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            Text(primary, style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text(secondary, style: TextStyle(color: scheme.onSurfaceVariant)),
            if (s != null) const SizedBox(height: 8),
            if (s != null)
              Text(
                'Factors width=${s.widthFactor?.toStringAsFixed(2) ?? 'disabled'} '
                'height=${s.heightFactor?.toStringAsFixed(2) ?? 'disabled'}',
                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
              ),
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
            ..._introBullets.map((String entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
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
                      child: Icon(Icons.check_circle_outline, size: 14, color: scheme.secondary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(entry, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
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
            const SizedBox(height: 6),
            Text(
              'Chronological log of actions, snapshots, and scenario adjustments.',
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
                    'Timeline is empty. Interact with controls to populate operational events.',
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

class _RenderAligningShiftedBoxHost extends SingleChildRenderObjectWidget {
  const _RenderAligningShiftedBoxHost({
    super.key,
    required this.alignment,
    required this.textDirection,
    this.widthFactor,
    this.heightFactor,
    super.child,
  });

  final AlignmentGeometry alignment;
  final TextDirection textDirection;
  final double? widthFactor;
  final double? heightFactor;

  @override
  _DemoRenderAligningShiftedBox createRenderObject(BuildContext context) {
    return _DemoRenderAligningShiftedBox(
      alignment: alignment,
      textDirection: textDirection,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _DemoRenderAligningShiftedBox renderObject) {
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection
      ..widthFactor = widthFactor
      ..heightFactor = heightFactor;
  }
}

class _DemoRenderAligningShiftedBox extends RenderAligningShiftedBox {
  _DemoRenderAligningShiftedBox({
    required super.alignment,
    required super.textDirection,
    double? widthFactor,
    double? heightFactor,
  })  : _widthFactor = widthFactor,
        _heightFactor = heightFactor;

  double? _widthFactor;
  double? _heightFactor;

  double? get widthFactor => _widthFactor;

  set widthFactor(double? value) {
    if (value == _widthFactor) {
      return;
    }
    _widthFactor = value;
    markNeedsLayout();
  }

  double? get heightFactor => _heightFactor;

  set heightFactor(double? value) {
    if (value == _heightFactor) {
      return;
    }
    _heightFactor = value;
    markNeedsLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final RenderBox? c = child;
    if (c == null) {
      return constraints.smallest;
    }
    final Size childSize = c.getDryLayout(constraints.loosen());
    final double width = _widthFactor == null ? childSize.width : childSize.width * _widthFactor!;
    final double height = _heightFactor == null ? childSize.height : childSize.height * _heightFactor!;
    return constraints.constrain(Size(width, height));
  }

  @override
  void performLayout() {
    final RenderBox? c = child;
    if (c == null) {
      size = constraints.smallest;
      return;
    }

    c.layout(constraints.loosen(), parentUsesSize: true);
    final Size childSize = c.size;
    final double width = _widthFactor == null ? childSize.width : childSize.width * _widthFactor!;
    final double height = _heightFactor == null ? childSize.height : childSize.height * _heightFactor!;
    size = constraints.constrain(Size(width, height));
    alignChild();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final RenderBox? c = child;
    if (c == null) {
      return 0;
    }
    final double base = c.getMinIntrinsicWidth(height);
    return _widthFactor == null ? base : base * _widthFactor!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final RenderBox? c = child;
    if (c == null) {
      return 0;
    }
    final double base = c.getMaxIntrinsicWidth(height);
    return _widthFactor == null ? base : base * _widthFactor!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final RenderBox? c = child;
    if (c == null) {
      return 0;
    }
    final double base = c.getMinIntrinsicHeight(width);
    return _heightFactor == null ? base : base * _heightFactor!;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final RenderBox? c = child;
    if (c == null) {
      return 0;
    }
    final double base = c.getMaxIntrinsicHeight(width);
    return _heightFactor == null ? base : base * _heightFactor!;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? c = child;
    if (c == null) {
      return;
    }
    final BoxParentData parentData = c.parentData! as BoxParentData;
    context.paintChild(c, offset + parentData.offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? c = child;
    if (c == null) {
      return false;
    }
    final BoxParentData parentData = c.parentData! as BoxParentData;
    return result.addWithPaintOffset(
      offset: parentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        return c.hitTest(result, position: transformed);
      },
    );
  }
}
