import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'atlas',
    name: 'Atlas Board',
    description: 'Balanced contrast for delegate geometry and offsets.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'studio',
    name: 'Studio Amber',
    description: 'Warm palette for anchoring and docking experiments.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Blueprint',
    description: 'Dark profile for boundary and insets diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ModeDescriptor> _modes = <_ModeDescriptor>[
  _ModeDescriptor(id: _LayoutMode.anchor, title: 'Anchor', subtitle: 'Pin child to normalized anchor point with bias offsets.'),
  _ModeDescriptor(id: _LayoutMode.orbit, title: 'Orbit', subtitle: 'Move single child on a radial trajectory around parent center.'),
  _ModeDescriptor(id: _LayoutMode.dock, title: 'Dock', subtitle: 'Dock child to selected edge with configurable margin and fit.'),
  _ModeDescriptor(id: _LayoutMode.fit, title: 'Aspect Fit', subtitle: 'Constrain child by parent bounds while preserving visual ratio.'),
  _ModeDescriptor(id: _LayoutMode.insets, title: 'Adaptive Insets', subtitle: 'Allocate child box from dynamic insets and balance factors.'),
];

const List<String> _guideBullets = <String>[
  'CustomSingleChildLayout is rendered by RenderCustomSingleChildLayoutBox.',
  'A SingleChildLayoutDelegate controls child constraints and offset.',
  'getSize decides parent size when parent constraints allow flexibility.',
  'getConstraintsForChild should produce consistent bounds for the child.',
  'getPositionForChild computes final child offset in parent coordinates.',
  'shouldRelayout must return true only for meaningful parameter changes.',
  'Single-child delegates are ideal for bespoke positioning rules beyond Align.',
  'Use visual guides to validate offset, margins, and clipping risk quickly.',
  'When animating layouts, feed values through setState and delegate fields.',
  'Document the layout contract to keep custom placement predictable in teams.',
];

const List<_FaqItem> _faq = <_FaqItem>[
  _FaqItem(
    question: 'When should I prefer CustomSingleChildLayout over Align?',
    answer: 'Use it when constraints and positioning rules are more complex than a simple alignment model.',
  ),
  _FaqItem(
    question: 'Can I make parent size dynamic with this widget?',
    answer: 'Yes. Delegate getSize can define parent size when constraints permit flexibility.',
  ),
  _FaqItem(
    question: 'How do I avoid unnecessary relayouts?',
    answer: 'Keep delegate fields immutable and compare them carefully in shouldRelayout.',
  ),
  _FaqItem(
    question: 'Is this good for animation?',
    answer: 'Yes. Updating delegate parameters over time creates smooth custom motion paths.',
  ),
  _FaqItem(
    question: 'How can I debug clipping and overflow?',
    answer: 'Render child and parent bounds overlays and inspect margins with probe labels.',
  ),
];

enum _LayoutMode {
  anchor,
  orbit,
  dock,
  fit,
  insets,
}

enum _DockEdge {
  top,
  right,
  bottom,
  left,
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

class _ModeDescriptor {
  const _ModeDescriptor({required this.id, required this.title, required this.subtitle});

  final _LayoutMode id;
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

class _LayoutSnapshot {
  const _LayoutSnapshot({
    required this.mode,
    required this.parentSize,
    required this.childSize,
    required this.offset,
  });

  final String mode;
  final Size parentSize;
  final Size childSize;
  final Offset offset;
}

dynamic build(BuildContext context) {
  return const _RenderCustomSingleChildLayoutBoxStudio();
}

class _RenderCustomSingleChildLayoutBoxStudio extends StatefulWidget {
  const _RenderCustomSingleChildLayoutBoxStudio();

  @override
  State<_RenderCustomSingleChildLayoutBoxStudio> createState() => _RenderCustomSingleChildLayoutBoxStudioState();
}

class _RenderCustomSingleChildLayoutBoxStudioState extends State<_RenderCustomSingleChildLayoutBoxStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7800),
  )..repeat();

  final ScrollController _scroll = ScrollController();

  int _themeIndex = 0;
  _LayoutMode _mode = _LayoutMode.anchor;
  _DockEdge _dockEdge = _DockEdge.bottom;

  double _parentWidth = 720;
  double _parentHeight = 360;
  double _anchorX = 0.5;
  double _anchorY = 0.5;
  double _biasX = 0;
  double _biasY = 0;
  double _orbitRadius = 116;
  double _orbitSpeed = 1.0;
  double _margin = 18;
  double _childBaseW = 220;
  double _childBaseH = 120;
  double _fitFactor = 0.78;
  double _insetTop = 18;
  double _insetRight = 24;
  double _insetBottom = 22;
  double _insetLeft = 20;
  double _guideOpacity = 0.55;
  double _textureDensity = 0.44;

  bool _animateOrbit = true;
  bool _showGrid = true;
  bool _showBounds = true;
  bool _showCenter = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showLegend = true;

  int _modeSwitches = 0;
  int _themeSwitches = 0;
  int _controlEdits = 0;
  int _stageTaps = 0;

  String _phase = 'idle';
  Offset _probe = const Offset(0.5, 0.5);

  _LayoutSnapshot _snapshot = const _LayoutSnapshot(
    mode: 'anchor',
    parentSize: Size.zero,
    childSize: Size.zero,
    offset: Offset.zero,
  );

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'Single-child delegate studio initialized.');
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
      ].take(90).toList(growable: false);
    });
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _mode = _LayoutMode.anchor;
      _dockEdge = _DockEdge.bottom;
      _parentWidth = 720;
      _parentHeight = 360;
      _anchorX = 0.5;
      _anchorY = 0.5;
      _biasX = 0;
      _biasY = 0;
      _orbitRadius = 116;
      _orbitSpeed = 1.0;
      _margin = 18;
      _childBaseW = 220;
      _childBaseH = 120;
      _fitFactor = 0.78;
      _insetTop = 18;
      _insetRight = 24;
      _insetBottom = 22;
      _insetLeft = 20;
      _guideOpacity = 0.55;
      _textureDensity = 0.44;
      _animateOrbit = true;
      _showGrid = true;
      _showBounds = true;
      _showCenter = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showLegend = true;
      _phase = 'reset';
      _probe = const Offset(0.5, 0.5);
      _timeline = const <_TimelineEvent>[];
      _snapshot = const _LayoutSnapshot(
        mode: 'anchor',
        parentSize: Size.zero,
        childSize: Size.zero,
        offset: Offset.zero,
      );
    });
    _motion.repeat();
    _pushTimeline('Reset', 'Studio values returned to defaults.');
  }

  void _bumpControl() {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
  }

  void _setToggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'animate':
          _animateOrbit = next;
          break;
        case 'grid':
          _showGrid = next;
          break;
        case 'bounds':
          _showBounds = next;
          break;
        case 'center':
          _showCenter = next;
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
        case 'legend':
          _showLegend = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animateOrbit) {
      _motion.repeat();
    } else {
      _motion.stop();
    }
    _pushTimeline('Toggle', '$key set to $next.');
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Mode', value: _mode.name, note: 'Active layout delegate strategy.', icon: Icons.account_tree_outlined),
      _MetricEntry(label: 'Theme', value: _themes[_themeIndex].name, note: 'Visual profile for the studio.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Parent', value: '${_parentWidth.toStringAsFixed(0)} x ${_parentHeight.toStringAsFixed(0)}', note: 'CustomSingleChildLayout parent size.', icon: Icons.crop_square_outlined),
      _MetricEntry(label: 'Child Base', value: '${_childBaseW.toStringAsFixed(0)} x ${_childBaseH.toStringAsFixed(0)}', note: 'Desired child baseline size.', icon: Icons.widgets_outlined),
      _MetricEntry(label: 'Anchor', value: '${_anchorX.toStringAsFixed(2)}, ${_anchorY.toStringAsFixed(2)}', note: 'Normalized anchor point in parent.', icon: Icons.control_point_outlined),
      _MetricEntry(label: 'Bias', value: '${_biasX.toStringAsFixed(0)}, ${_biasY.toStringAsFixed(0)}', note: 'Offset bias added after anchor.', icon: Icons.compare_arrows_outlined),
      _MetricEntry(label: 'Orbit', value: '${_orbitRadius.toStringAsFixed(1)} @ ${_orbitSpeed.toStringAsFixed(2)}', note: 'Orbit radius and speed multipliers.', icon: Icons.radar_outlined),
      _MetricEntry(label: 'Margin', value: _margin.toStringAsFixed(1), note: 'Dock and fit safety margin.', icon: Icons.margin_outlined),
      _MetricEntry(label: 'Fit Factor', value: _fitFactor.toStringAsFixed(2), note: 'Constraint scale in aspect-fit mode.', icon: Icons.fit_screen_outlined),
      _MetricEntry(label: 'Insets', value: '${_insetTop.toStringAsFixed(0)}, ${_insetRight.toStringAsFixed(0)}, ${_insetBottom.toStringAsFixed(0)}, ${_insetLeft.toStringAsFixed(0)}', note: 'Top, right, bottom, left inset values.', icon: Icons.view_sidebar_outlined),
      _MetricEntry(label: 'Switches', value: 'mode=$_modeSwitches theme=$_themeSwitches', note: 'Mode and theme changes.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Control Edits', value: '$_controlEdits', note: 'Slider and toggle updates.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Stage Taps', value: '$_stageTaps', note: 'Probe interactions on stage.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Latest user action category.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Snapshot Mode', value: _snapshot.mode, note: 'Last delegate mode in snapshot.', icon: Icons.camera_outlined),
      _MetricEntry(label: 'Snapshot Child', value: '${_snapshot.childSize.width.toStringAsFixed(0)} x ${_snapshot.childSize.height.toStringAsFixed(0)}', note: 'Actual child size from delegate layout.', icon: Icons.straighten_outlined),
      _MetricEntry(label: 'Snapshot Offset', value: '${_snapshot.offset.dx.toStringAsFixed(1)}, ${_snapshot.offset.dy.toStringAsFixed(1)}', note: 'Final child offset in parent.', icon: Icons.pin_drop_outlined),
    ];
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
                    constraints: const BoxConstraints(maxWidth: 1460),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 14),
                        _buildThemeModeBoard(scheme),
                        const SizedBox(height: 14),
                        _buildControlBoard(scheme),
                        const SizedBox(height: 14),
                        _buildStageBoard(scheme),
                        const SizedBox(height: 14),
                        _buildModeGalleryBoard(scheme),
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
                Icon(Icons.space_dashboard_outlined, color: scheme.primary, size: 26),
                Text('RenderCustomSingleChildLayoutBox Studio', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_mode.name, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual exploration of single-child custom layout delegates: constraints negotiation, offset computation, docking behavior, fitting, and adaptive inset contracts.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeBoard(ColorScheme scheme) {
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
              children: List<Widget>.generate(_themes.length, (int index) {
                final _ThemePreset t = _themes[index];
                return ChoiceChip(
                  selected: _themeIndex == index,
                  label: Text(t.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
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
            Text('Layout Modes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _modes.map(( _ModeDescriptor descriptor) {
                return FilterChip(
                  selected: _mode == descriptor.id,
                  label: Text(descriptor.title),
                  onSelected: (_) {
                    setState(() {
                      _mode = descriptor.id;
                      _modeSwitches += 1;
                      _phase = 'mode';
                    });
                    _pushTimeline('Mode', descriptor.subtitle);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(_modes.firstWhere(( _ModeDescriptor d) => d.id == _mode).subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Delegate Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune parent bounds, child constraints, anchor offsets, and mode-specific parameters.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Parent Width',
              value: _parentWidth,
              min: 420,
              max: 1100,
              divisions: 340,
              onChanged: (double v) => setState(() => _parentWidth = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Parent Width', 'Set parent width to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Parent Height',
              value: _parentHeight,
              min: 220,
              max: 680,
              divisions: 230,
              onChanged: (double v) => setState(() => _parentHeight = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Parent Height', 'Set parent height to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Base Width',
              value: _childBaseW,
              min: 80,
              max: 420,
              divisions: 170,
              onChanged: (double v) => setState(() => _childBaseW = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Child Width', 'Set child base width to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Child Base Height',
              value: _childBaseH,
              min: 60,
              max: 280,
              divisions: 110,
              onChanged: (double v) => setState(() => _childBaseH = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Child Height', 'Set child base height to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Anchor X',
              value: _anchorX,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _anchorX = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Anchor X', 'Set anchor X to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Anchor Y',
              value: _anchorY,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _anchorY = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Anchor Y', 'Set anchor Y to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Bias X',
              value: _biasX,
              min: -240,
              max: 240,
              divisions: 240,
              onChanged: (double v) => setState(() => _biasX = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Bias X', 'Set bias X to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Bias Y',
              value: _biasY,
              min: -240,
              max: 240,
              divisions: 240,
              onChanged: (double v) => setState(() => _biasY = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Bias Y', 'Set bias Y to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Orbit Radius',
              value: _orbitRadius,
              min: 20,
              max: 280,
              divisions: 130,
              onChanged: (double v) => setState(() => _orbitRadius = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Orbit Radius', 'Set orbit radius to ${v.toStringAsFixed(1)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Orbit Speed',
              value: _orbitSpeed,
              min: 0.2,
              max: 3,
              divisions: 140,
              onChanged: (double v) => setState(() => _orbitSpeed = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Orbit Speed', 'Set orbit speed to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Margin',
              value: _margin,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (double v) => setState(() => _margin = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Margin', 'Set margin to ${v.toStringAsFixed(1)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Fit Factor',
              value: _fitFactor,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _fitFactor = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Fit Factor', 'Set fit factor to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Inset Top',
              value: _insetTop,
              min: 0,
              max: 160,
              divisions: 160,
              onChanged: (double v) => setState(() => _insetTop = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Inset Top', 'Set top inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Inset Right',
              value: _insetRight,
              min: 0,
              max: 160,
              divisions: 160,
              onChanged: (double v) => setState(() => _insetRight = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Inset Right', 'Set right inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Inset Bottom',
              value: _insetBottom,
              min: 0,
              max: 160,
              divisions: 160,
              onChanged: (double v) => setState(() => _insetBottom = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Inset Bottom', 'Set bottom inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Inset Left',
              value: _insetLeft,
              min: 0,
              max: 160,
              divisions: 160,
              onChanged: (double v) => setState(() => _insetLeft = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Inset Left', 'Set left inset to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Guide Opacity',
              value: _guideOpacity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _guideOpacity = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _pushTimeline('Guide Opacity', 'Set guide opacity to ${v.toStringAsFixed(2)}.');
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
            Text('Dock Edge', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _DockEdge.values.map(( _DockEdge edge) {
                return ChoiceChip(
                  selected: _dockEdge == edge,
                  label: Text(edge.name),
                  onSelected: (_) {
                    setState(() {
                      _dockEdge = edge;
                      _controlEdits += 1;
                      _phase = 'dock-edge';
                    });
                    _pushTimeline('Dock Edge', 'Dock edge switched to ${edge.name}.');
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animateOrbit, onChanged: (bool? v) => _setToggle('animate', v), child: const Text('Animate orbit')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _setToggle('grid', v), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showBounds, onChanged: (bool? v) => _setToggle('bounds', v), child: const Text('Show bounds')),
                CheckboxMenuButton(value: _showCenter, onChanged: (bool? v) => _setToggle('center', v), child: const Text('Show center cross')),                
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _setToggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _setToggle('guide', v), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _setToggle('timeline', v), child: const Text('Show timeline board')),
                CheckboxMenuButton(value: _showLegend, onChanged: (bool? v) => _setToggle('legend', v), child: const Text('Show legend chips')),
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

  Widget _buildStageBoard(ColorScheme scheme) {
    final double progress = _animateOrbit ? _motion.value : 0;
    final _DelegateConfig config = _DelegateConfig(
      mode: _mode,
      progress: progress,
      anchor: Offset(_anchorX, _anchorY),
      bias: Offset(_biasX, _biasY),
      orbitRadius: _orbitRadius,
      orbitSpeed: _orbitSpeed,
      margin: _margin,
      dockEdge: _dockEdge,
      fitFactor: _fitFactor,
      insets: EdgeInsets.fromLTRB(_insetLeft, _insetTop, _insetRight, _insetBottom),
      childBaseSize: Size(_childBaseW, _childBaseH),
      onSnapshot: _setSnapshot,
    );

    final SingleChildLayoutDelegate delegate = _buildDelegate(config);

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Delegate Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Live CustomSingleChildLayout board with parent guides and delegate-computed child position.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final Offset local = details.localPosition;
                  final Offset normalized = Offset(
                    (local.dx / _parentWidth).clamp(0.0, 1.0),
                    (local.dy / _parentHeight).clamp(0.0, 1.0),
                  );
                  setState(() {
                    _probe = normalized;
                    _anchorX = normalized.dx;
                    _anchorY = normalized.dy;
                    _stageTaps += 1;
                    _phase = 'stage-tap';
                  });
                  _pushTimeline('Stage Tap', 'Anchor moved to ${normalized.dx.toStringAsFixed(2)}, ${normalized.dy.toStringAsFixed(2)}.');
                },
                child: SizedBox(
                  width: _parentWidth,
                  height: _parentHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CustomPaint(
                        painter: _ParentBackdropPainter(
                          showGrid: _showGrid,
                          showCenter: _showCenter,
                          guideOpacity: _guideOpacity,
                          density: _textureDensity,
                        ),
                      ),
                      CustomSingleChildLayout(
                        delegate: delegate,
                        child: _DemoChildCard(mode: _mode, density: _textureDensity, probe: _probe),
                      ),
                      if (_showBounds)
                        IgnorePointer(
                          child: CustomPaint(
                            painter: _OverlayBoundsPainter(snapshot: _snapshot, showCenter: _showCenter, opacity: _guideOpacity),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (_showLegend) const SizedBox(height: 10),
            if (_showLegend)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _chip('mode ${_mode.name}', scheme.primary),
                  _chip('anchor ${_anchorX.toStringAsFixed(2)}, ${_anchorY.toStringAsFixed(2)}', scheme.secondary),
                  _chip('child ${_snapshot.childSize.width.toStringAsFixed(0)}x${_snapshot.childSize.height.toStringAsFixed(0)}', scheme.tertiary),
                  _chip('offset ${_snapshot.offset.dx.toStringAsFixed(1)}, ${_snapshot.offset.dy.toStringAsFixed(1)}', scheme.primary),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _setSnapshot(_LayoutSnapshot snapshot) {
    if (!mounted) {
      return;
    }
    setState(() => _snapshot = snapshot);
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999), border: Border.all(color: color.withValues(alpha: 0.65))),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  SingleChildLayoutDelegate _buildDelegate(_DelegateConfig config) {
    switch (_mode) {
      case _LayoutMode.anchor:
        return _AnchorDelegate(config: config);
      case _LayoutMode.orbit:
        return _OrbitDelegate(config: config);
      case _LayoutMode.dock:
        return _DockDelegate(config: config);
      case _LayoutMode.fit:
        return _FitDelegate(config: config);
      case _LayoutMode.insets:
        return _InsetsDelegate(config: config);
    }
  }

  Widget _buildModeGalleryBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Mode Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Quick preview cards for each delegate strategy.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1280
                    ? 5
                    : constraints.maxWidth > 980
                        ? 4
                        : constraints.maxWidth > 760
                            ? 3
                            : constraints.maxWidth > 520
                                ? 2
                                : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _modes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _ModeDescriptor descriptor = _modes[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _mode = descriptor.id;
                          _modeSwitches += 1;
                          _phase = 'gallery-mode';
                        });
                        _pushTimeline('Gallery', 'Picked ${descriptor.title} mode from gallery.');
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _mode == descriptor.id ? scheme.primary : scheme.outlineVariant, width: _mode == descriptor.id ? 2 : 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(descriptor.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(descriptor.subtitle, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
                              const SizedBox(height: 8),
                              Expanded(child: _ModeMiniPreview(mode: descriptor.id, density: _textureDensity)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
            Text('Contrast delegate-driven single-child layout with common alternatives.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget custom = _comparisonCard(
                  scheme: scheme,
                  title: 'CustomSingleChildLayout',
                  subtitle: 'Custom constraints + offset formula in delegate.',
                  color: const Color(0xFF0F766E),
                  icon: Icons.account_tree_outlined,
                );
                final Widget align = _comparisonCard(
                  scheme: scheme,
                  title: 'Align',
                  subtitle: 'Simple alignment without full delegate logic.',
                  color: const Color(0xFF1D4ED8),
                  icon: Icons.align_horizontal_center_outlined,
                );
                final Widget fitted = _comparisonCard(
                  scheme: scheme,
                  title: 'FittedBox',
                  subtitle: 'Scales child to fit but with different constraints model.',
                  color: const Color(0xFFB45309),
                  icon: Icons.fit_screen_outlined,
                );
                if (narrow) {
                  return Column(children: <Widget>[custom, const SizedBox(height: 10), align, const SizedBox(height: 10), fitted]);
                }
                return Row(children: <Widget>[Expanded(child: custom), const SizedBox(width: 10), Expanded(child: align), const SizedBox(width: 10), Expanded(child: fitted)]);
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
              decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.65))),
              child: Center(child: Icon(icon, size: 36, color: color)),
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
            Text('theme=${_themes[_themeIndex].id} mode=${_mode.name} dock=${_dockEdge.name} phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('parent=${_parentWidth.toStringAsFixed(0)}x${_parentHeight.toStringAsFixed(0)} child=${_childBaseW.toStringAsFixed(0)}x${_childBaseH.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('anchor=${_anchorX.toStringAsFixed(2)},${_anchorY.toStringAsFixed(2)} bias=${_biasX.toStringAsFixed(0)},${_biasY.toStringAsFixed(0)} orbit=${_orbitRadius.toStringAsFixed(1)}@${_orbitSpeed.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('margin=${_margin.toStringAsFixed(1)} fit=${_fitFactor.toStringAsFixed(2)} insets=${_insetTop.toStringAsFixed(0)},${_insetRight.toStringAsFixed(0)},${_insetBottom.toStringAsFixed(0)},${_insetLeft.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags grid=$_showGrid bounds=$_showBounds center=$_showCenter animate=$_animateOrbit guide=$_showGuide timeline=$_showTimeline', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches mode=$_modeSwitches theme=$_themeSwitches controls=$_controlEdits taps=$_stageTaps', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('snapshot parent=${_snapshot.parentSize.width.toStringAsFixed(0)}x${_snapshot.parentSize.height.toStringAsFixed(0)} child=${_snapshot.childSize.width.toStringAsFixed(0)}x${_snapshot.childSize.height.toStringAsFixed(0)} offset=${_snapshot.offset.dx.toStringAsFixed(1)},${_snapshot.offset.dy.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(onPressed: () => setState(() => _timeline = const <_TimelineEvent>[]), icon: const Icon(Icons.clear_all), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of layout interactions and delegate parameter edits.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _ModeMiniPreview extends StatelessWidget {
  const _ModeMiniPreview({required this.mode, required this.density});

  final _LayoutMode mode;
  final double density;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
        gradient: LinearGradient(
          colors: <Color>[scheme.primary.withValues(alpha: 0.16), scheme.secondary.withValues(alpha: 0.10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _MiniTexturePainter(density: density)),
          Center(child: Icon(_iconForMode(mode), color: scheme.primary, size: 26)),
        ],
      ),
    );
  }

  IconData _iconForMode(_LayoutMode mode) {
    switch (mode) {
      case _LayoutMode.anchor:
        return Icons.control_point;
      case _LayoutMode.orbit:
        return Icons.radar;
      case _LayoutMode.dock:
        return Icons.dock;
      case _LayoutMode.fit:
        return Icons.fit_screen;
      case _LayoutMode.insets:
        return Icons.view_sidebar;
    }
  }
}

class _MiniTexturePainter extends CustomPainter {
  const _MiniTexturePainter({required this.density});

  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 1;
    final double step = (26 - (density * 18)).clamp(7, 26);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MiniTexturePainter oldDelegate) => oldDelegate.density != density;
}

class _DemoChildCard extends StatelessWidget {
  const _DemoChildCard({required this.mode, required this.density, required this.probe});

  final _LayoutMode mode;
  final double density;
  final Offset probe;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Color> colors = _colorsForMode(mode);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: Colors.black.withValues(alpha: 0.20)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _MiniTexturePainter(density: density)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.widgets_outlined, color: Colors.white.withValues(alpha: 0.94), size: 16),
                    const SizedBox(width: 6),
                    Expanded(child: Text('Demo Child', style: TextStyle(color: Colors.white.withValues(alpha: 0.96), fontWeight: FontWeight.w800, fontSize: 12))),
                    Text(mode.name, style: TextStyle(color: Colors.white.withValues(alpha: 0.90), fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
                const Spacer(),
                Text('probe ${probe.dx.toStringAsFixed(2)}, ${probe.dy.toStringAsFixed(2)}', style: TextStyle(color: Colors.white.withValues(alpha: 0.90), fontSize: 10)),
                const SizedBox(height: 2),
                Text('RenderCustomSingleChildLayoutBox', style: TextStyle(color: Colors.white.withValues(alpha: 0.84), fontSize: 10)),
              ],
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(color: scheme.surface.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withValues(alpha: 0.68))),
              child: const Icon(Icons.adjust, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _colorsForMode(_LayoutMode mode) {
    switch (mode) {
      case _LayoutMode.anchor:
        return const <Color>[Color(0xFF0EA5E9), Color(0xFF22C55E)];
      case _LayoutMode.orbit:
        return const <Color>[Color(0xFF8B5CF6), Color(0xFF3B82F6)];
      case _LayoutMode.dock:
        return const <Color>[Color(0xFFF59E0B), Color(0xFFEF4444)];
      case _LayoutMode.fit:
        return const <Color>[Color(0xFF14B8A6), Color(0xFF0EA5E9)];
      case _LayoutMode.insets:
        return const <Color>[Color(0xFF6366F1), Color(0xFF8B5CF6)];
    }
  }
}

class _ParentBackdropPainter extends CustomPainter {
  const _ParentBackdropPainter({required this.showGrid, required this.showCenter, required this.guideOpacity, required this.density});

  final bool showGrid;
  final bool showCenter;
  final double guideOpacity;
  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[const Color(0xFF0EA5E9), const Color(0xFF8B5CF6), const Color(0xFFF59E0B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint wash = Paint()..color = Colors.black.withValues(alpha: 0.28);
    canvas.drawRect(Offset.zero & size, wash);

    final Paint stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 1;
    final double step = (30 - (density * 20)).clamp(8, 30);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), stripe);
    }

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white.withValues(alpha: (guideOpacity * 0.26).clamp(0.06, 0.28))
        ..strokeWidth = 1;
      const double g = 24;
      for (double x = 0; x <= size.width; x += g) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += g) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    if (showCenter) {
      final Paint center = Paint()
        ..color = Colors.white.withValues(alpha: (guideOpacity * 0.65).clamp(0.10, 0.65))
        ..strokeWidth = 1.2;
      final Offset c = Offset(size.width / 2, size.height / 2);
      canvas.drawLine(Offset(0, c.dy), Offset(size.width, c.dy), center);
      canvas.drawLine(Offset(c.dx, 0), Offset(c.dx, size.height), center);
      canvas.drawCircle(c, 5, center);
    }
  }

  @override
  bool shouldRepaint(covariant _ParentBackdropPainter oldDelegate) {
    return oldDelegate.showGrid != showGrid || oldDelegate.showCenter != showCenter || oldDelegate.guideOpacity != guideOpacity || oldDelegate.density != density;
  }
}

class _OverlayBoundsPainter extends CustomPainter {
  const _OverlayBoundsPainter({required this.snapshot, required this.showCenter, required this.opacity});

  final _LayoutSnapshot snapshot;
  final bool showCenter;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect childRect = snapshot.offset & snapshot.childSize;
    final Paint stroke = Paint()
      ..color = Colors.white.withValues(alpha: (opacity * 0.92).clamp(0.12, 0.92))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final Paint fill = Paint()
      ..color = Colors.white.withValues(alpha: (opacity * 0.10).clamp(0.02, 0.10))
      ..style = PaintingStyle.fill;

    canvas.drawRect(childRect, fill);
    canvas.drawRect(childRect, stroke);

    if (showCenter) {
      final Offset p = childRect.center;
      canvas.drawCircle(p, 5, stroke);
      canvas.drawLine(Offset(p.dx - 14, p.dy), Offset(p.dx + 14, p.dy), stroke);
      canvas.drawLine(Offset(p.dx, p.dy - 14), Offset(p.dx, p.dy + 14), stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayBoundsPainter oldDelegate) {
    return oldDelegate.snapshot != snapshot || oldDelegate.showCenter != showCenter || oldDelegate.opacity != opacity;
  }
}

class _DelegateConfig {
  const _DelegateConfig({
    required this.mode,
    required this.progress,
    required this.anchor,
    required this.bias,
    required this.orbitRadius,
    required this.orbitSpeed,
    required this.margin,
    required this.dockEdge,
    required this.fitFactor,
    required this.insets,
    required this.childBaseSize,
    required this.onSnapshot,
  });

  final _LayoutMode mode;
  final double progress;
  final Offset anchor;
  final Offset bias;
  final double orbitRadius;
  final double orbitSpeed;
  final double margin;
  final _DockEdge dockEdge;
  final double fitFactor;
  final EdgeInsets insets;
  final Size childBaseSize;
  final ValueChanged<_LayoutSnapshot> onSnapshot;
}

abstract class _BaseDelegate extends SingleChildLayoutDelegate {
  _BaseDelegate({required this.config, required this.modeName});

  final _DelegateConfig config;
  final String modeName;

  void pushSnapshot(Size parentSize, Size childSize, Offset offset) {
    config.onSnapshot(_LayoutSnapshot(mode: modeName, parentSize: parentSize, childSize: childSize, offset: offset));
  }
}

class _AnchorDelegate extends _BaseDelegate {
  _AnchorDelegate({required super.config}) : super(modeName: 'anchor');

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxW = (constraints.maxWidth - (config.margin * 2)).clamp(40, constraints.maxWidth);
    final double maxH = (constraints.maxHeight - (config.margin * 2)).clamp(40, constraints.maxHeight);
    final double w = config.childBaseSize.width.clamp(40, maxW);
    final double h = config.childBaseSize.height.clamp(40, maxH);
    return BoxConstraints.tight(Size(w, h));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset anchorPoint = Offset(size.width * config.anchor.dx, size.height * config.anchor.dy);
    final Offset centered = anchorPoint - Offset(childSize.width / 2, childSize.height / 2);
    final Offset withBias = centered + config.bias;
    final Offset clamped = Offset(
      withBias.dx.clamp(config.margin, size.width - childSize.width - config.margin),
      withBias.dy.clamp(config.margin, size.height - childSize.height - config.margin),
    );
    pushSnapshot(size, childSize, clamped);
    return clamped;
  }

  @override
  bool shouldRelayout(covariant _AnchorDelegate oldDelegate) {
    return oldDelegate.config.anchor != config.anchor ||
        oldDelegate.config.bias != config.bias ||
        oldDelegate.config.margin != config.margin ||
        oldDelegate.config.childBaseSize != config.childBaseSize;
  }
}

class _OrbitDelegate extends _BaseDelegate {
  _OrbitDelegate({required super.config}) : super(modeName: 'orbit');

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxW = (constraints.maxWidth * 0.38).clamp(50, constraints.maxWidth);
    final double maxH = (constraints.maxHeight * 0.38).clamp(50, constraints.maxHeight);
    final double w = config.childBaseSize.width.clamp(48, maxW);
    final double h = config.childBaseSize.height.clamp(48, maxH);
    return BoxConstraints.tight(Size(w, h));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angle = config.progress * math.pi * 2 * config.orbitSpeed;
    final Offset orbitPoint = Offset(center.dx + math.cos(angle) * config.orbitRadius, center.dy + math.sin(angle) * config.orbitRadius);
    final Offset offset = orbitPoint - Offset(childSize.width / 2, childSize.height / 2);
    final Offset clamped = Offset(
      offset.dx.clamp(config.margin, size.width - childSize.width - config.margin),
      offset.dy.clamp(config.margin, size.height - childSize.height - config.margin),
    );
    pushSnapshot(size, childSize, clamped);
    return clamped;
  }

  @override
  bool shouldRelayout(covariant _OrbitDelegate oldDelegate) {
    return oldDelegate.config.progress != config.progress ||
        oldDelegate.config.orbitRadius != config.orbitRadius ||
        oldDelegate.config.orbitSpeed != config.orbitSpeed ||
        oldDelegate.config.childBaseSize != config.childBaseSize ||
        oldDelegate.config.margin != config.margin;
  }
}

class _DockDelegate extends _BaseDelegate {
  _DockDelegate({required super.config}) : super(modeName: 'dock');

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxW = (constraints.maxWidth - (config.margin * 2)).clamp(60, constraints.maxWidth);
    final double maxH = (constraints.maxHeight - (config.margin * 2)).clamp(60, constraints.maxHeight);
    final double w = config.childBaseSize.width.clamp(60, maxW);
    final double h = config.childBaseSize.height.clamp(60, maxH);
    return BoxConstraints.tight(Size(w, h));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    late Offset offset;
    switch (config.dockEdge) {
      case _DockEdge.top:
        offset = Offset((size.width - childSize.width) / 2, config.margin);
        break;
      case _DockEdge.right:
        offset = Offset(size.width - childSize.width - config.margin, (size.height - childSize.height) / 2);
        break;
      case _DockEdge.bottom:
        offset = Offset((size.width - childSize.width) / 2, size.height - childSize.height - config.margin);
        break;
      case _DockEdge.left:
        offset = Offset(config.margin, (size.height - childSize.height) / 2);
        break;
    }
    final Offset withBias = offset + config.bias;
    final Offset clamped = Offset(
      withBias.dx.clamp(config.margin, size.width - childSize.width - config.margin),
      withBias.dy.clamp(config.margin, size.height - childSize.height - config.margin),
    );
    pushSnapshot(size, childSize, clamped);
    return clamped;
  }

  @override
  bool shouldRelayout(covariant _DockDelegate oldDelegate) {
    return oldDelegate.config.dockEdge != config.dockEdge ||
        oldDelegate.config.margin != config.margin ||
        oldDelegate.config.bias != config.bias ||
        oldDelegate.config.childBaseSize != config.childBaseSize;
  }
}

class _FitDelegate extends _BaseDelegate {
  _FitDelegate({required super.config}) : super(modeName: 'fit');

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxW = (constraints.maxWidth - (config.margin * 2)) * config.fitFactor;
    final double maxH = (constraints.maxHeight - (config.margin * 2)) * config.fitFactor;
    final double ratio = config.childBaseSize.width / config.childBaseSize.height;
    double width = maxW;
    double height = width / ratio;
    if (height > maxH) {
      height = maxH;
      width = height * ratio;
    }
    width = width.clamp(40, constraints.maxWidth);
    height = height.clamp(40, constraints.maxHeight);
    return BoxConstraints.tight(Size(width, height));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset centered = Offset((size.width - childSize.width) / 2, (size.height - childSize.height) / 2);
    final Offset withBias = centered + config.bias;
    final Offset clamped = Offset(
      withBias.dx.clamp(config.margin, size.width - childSize.width - config.margin),
      withBias.dy.clamp(config.margin, size.height - childSize.height - config.margin),
    );
    pushSnapshot(size, childSize, clamped);
    return clamped;
  }

  @override
  bool shouldRelayout(covariant _FitDelegate oldDelegate) {
    return oldDelegate.config.fitFactor != config.fitFactor ||
        oldDelegate.config.margin != config.margin ||
        oldDelegate.config.bias != config.bias ||
        oldDelegate.config.childBaseSize != config.childBaseSize;
  }
}

class _InsetsDelegate extends _BaseDelegate {
  _InsetsDelegate({required super.config}) : super(modeName: 'insets');

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double width = (constraints.maxWidth - config.insets.horizontal).clamp(40, constraints.maxWidth);
    final double height = (constraints.maxHeight - config.insets.vertical).clamp(40, constraints.maxHeight);
    return BoxConstraints.tight(Size(width, height));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset offset = Offset(config.insets.left, config.insets.top);
    final Offset withBias = offset + (config.bias * 0.2);
    final Offset clamped = Offset(
      withBias.dx.clamp(0, size.width - childSize.width),
      withBias.dy.clamp(0, size.height - childSize.height),
    );
    pushSnapshot(size, childSize, clamped);
    return clamped;
  }

  @override
  bool shouldRelayout(covariant _InsetsDelegate oldDelegate) {
    return oldDelegate.config.insets != config.insets ||
        oldDelegate.config.bias != config.bias ||
        oldDelegate.config.childBaseSize != config.childBaseSize;
  }
}
