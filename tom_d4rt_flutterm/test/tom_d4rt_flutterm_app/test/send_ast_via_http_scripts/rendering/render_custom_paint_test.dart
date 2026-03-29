import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_PaintThemePreset> _themePresets = <_PaintThemePreset>[
  _PaintThemePreset(
    id: 'seaside',
    name: 'Seaside Draft',
    description: 'Clean contrast for shape and chart painter diagnostics.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _PaintThemePreset(
    id: 'sunset',
    name: 'Sunset Lab',
    description: 'Warm palette for gradients, blends, and radial effects.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _PaintThemePreset(
    id: 'slate',
    name: 'Slate Ops',
    description: 'Dark high-contrast profile for edge and mask inspection.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<String> _guideBullets = <String>[
  'CustomPaint is backed by RenderCustomPaint and delegates drawing to CustomPainter.',
  'Use a background painter for scene surfaces and a foreground painter for overlays.',
  'Implement shouldRepaint precisely to avoid unnecessary repaints.',
  'Provide a repaint Listenable when animation should trigger paint updates.',
  'Painting runs in canvas space; use size to adapt to responsive constraints.',
  'Use saveLayer and blend modes carefully because they affect performance.',
  'When needed, keep drawing logic pure and deterministic for easier debugging.',
  'Add visual diagnostics (grids, axes, labels) to validate painter math quickly.',
  'Custom painter hit testing can be represented by pointer probes and crosshairs.',
  'Pair painter demos with instructional notes so the render intent stays clear.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'When should I use CustomPaint instead of regular widgets?',
    answer: 'Use it when visuals depend on custom canvas drawing, procedural patterns, or direct path control.',
  ),
  _FaqItem(
    question: 'How do I animate a CustomPainter?',
    answer: 'Pass a Listenable to repaint and read animation values inside paint().',
  ),
  _FaqItem(
    question: 'Should all paint values be recomputed every frame?',
    answer: 'Only recompute what changes; cache expensive path data when possible.',
  ),
  _FaqItem(
    question: 'Can I combine background and foreground painters?',
    answer: 'Yes, CustomPaint supports both and this is useful for overlays and guides.',
  ),
  _FaqItem(
    question: 'How can I debug drawing coordinates?',
    answer: 'Render a grid and axis labels and add a pointer probe marker.',
  ),
];

enum _PainterMode {
  geometry,
  signal,
  pattern,
  radial,
  pathLab,
}

class _PaintThemePreset {
  const _PaintThemePreset({
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

class _PaintSnapshot {
  const _PaintSnapshot({
    required this.mode,
    required this.complexity,
    required this.layers,
    required this.pointer,
  });

  final String mode;
  final int complexity;
  final int layers;
  final Offset pointer;
}

dynamic build(BuildContext context) {
  return const _RenderCustomPaintStudio();
}

class _RenderCustomPaintStudio extends StatefulWidget {
  const _RenderCustomPaintStudio();

  @override
  State<_RenderCustomPaintStudio> createState() => _RenderCustomPaintStudioState();
}

class _RenderCustomPaintStudioState extends State<_RenderCustomPaintStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 8600),
  )..repeat();

  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  _PainterMode _mode = _PainterMode.geometry;

  double _canvasWidth = 760;
  double _canvasHeight = 380;
  double _strokeScale = 1.0;
  double _noise = 0.45;
  double _amplitude = 0.55;
  double _frequency = 1.2;
  double _blend = 0.32;
  double _shapeRoundness = 0.40;
  double _pathWarp = 0.36;
  double _guideOpacity = 0.48;
  double _colorShift = 0.24;

  bool _animate = true;
  bool _showGrid = true;
  bool _showAxes = true;
  bool _showForeground = true;
  bool _showProbe = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showLegend = true;

  int _modeSwitches = 0;
  int _themeSwitches = 0;
  int _tapCount = 0;
  int _controlEdits = 0;

  String _phase = 'idle';
  Offset _probe = const Offset(0.5, 0.5);

  _PaintSnapshot _snapshot = const _PaintSnapshot(mode: 'geometry', complexity: 0, layers: 0, pointer: Offset(0.5, 0.5));
  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTimeline('Init', 'CustomPaint visual studio initialized.');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(90).toList(growable: false);
    });
  }

  void _reset() {
    setState(() {
      _mode = _PainterMode.geometry;
      _canvasWidth = 760;
      _canvasHeight = 380;
      _strokeScale = 1.0;
      _noise = 0.45;
      _amplitude = 0.55;
      _frequency = 1.2;
      _blend = 0.32;
      _shapeRoundness = 0.40;
      _pathWarp = 0.36;
      _guideOpacity = 0.48;
      _colorShift = 0.24;
      _animate = true;
      _showGrid = true;
      _showAxes = true;
      _showForeground = true;
      _showProbe = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showLegend = true;
      _phase = 'reset';
      _probe = const Offset(0.5, 0.5);
      _timeline = const <_TimelineEvent>[];
      _snapshot = const _PaintSnapshot(mode: 'geometry', complexity: 0, layers: 0, pointer: Offset(0.5, 0.5));
    });
    _controller.repeat();
    _addTimeline('Reset', 'Studio values returned to defaults.');
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Mode', value: _mode.name, note: 'Active painter scenario.', icon: Icons.brush_outlined),
      _MetricEntry(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Color and brightness preset.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Canvas', value: '${_canvasWidth.toStringAsFixed(0)} x ${_canvasHeight.toStringAsFixed(0)}', note: 'Painting surface dimensions.', icon: Icons.crop_square_outlined),
      _MetricEntry(label: 'Stroke Scale', value: _strokeScale.toStringAsFixed(2), note: 'Line thickness multiplier.', icon: Icons.line_weight_outlined),
      _MetricEntry(label: 'Amplitude', value: _amplitude.toStringAsFixed(2), note: 'Signal wave height.', icon: Icons.show_chart_outlined),
      _MetricEntry(label: 'Frequency', value: _frequency.toStringAsFixed(2), note: 'Signal oscillation intensity.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Blend', value: _blend.toStringAsFixed(2), note: 'Foreground blend strength.', icon: Icons.filter_b_and_w_outlined),
      _MetricEntry(label: 'Roundness', value: _shapeRoundness.toStringAsFixed(2), note: 'Corner smoothing for geometry mode.', icon: Icons.rounded_corner_outlined),
      _MetricEntry(label: 'Path Warp', value: _pathWarp.toStringAsFixed(2), note: 'Path deformation strength.', icon: Icons.timeline_outlined),
      _MetricEntry(label: 'Noise', value: _noise.toStringAsFixed(2), note: 'Pattern variation intensity.', icon: Icons.grain_outlined),
      _MetricEntry(label: 'Guide Opacity', value: _guideOpacity.toStringAsFixed(2), note: 'Grid and axis overlay opacity.', icon: Icons.grid_on_outlined),
      _MetricEntry(label: 'Color Shift', value: _colorShift.toStringAsFixed(2), note: 'Palette hue offset over time.', icon: Icons.gradient_outlined),
      _MetricEntry(label: 'Mode Switches', value: '$_modeSwitches', note: 'Number of mode transitions.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Theme Switches', value: '$_themeSwitches', note: 'Theme profile changes.', icon: Icons.color_lens_outlined),
      _MetricEntry(label: 'Control Edits', value: '$_controlEdits', note: 'Slider and toggle interactions.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Stage Taps', value: '$_tapCount', note: 'Pointer probes placed on stage.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Most recent interaction phase.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Snapshot Complexity', value: '${_snapshot.complexity}', note: 'Current painter complexity estimate.', icon: Icons.analytics_outlined),
      _MetricEntry(label: 'Snapshot Layers', value: '${_snapshot.layers}', note: 'Estimated paint layers used.', icon: Icons.layers_outlined),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _PaintThemePreset preset = _themePresets[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: preset.seed, brightness: preset.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: preset.brightness),
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
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
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
                        _buildPainterStageBoard(scheme),
                        const SizedBox(height: 14),
                        _buildPainterGalleryBoard(scheme),
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
                Icon(Icons.brush_outlined, color: scheme.primary, size: 26),
                Text('RenderCustomPaint Painter Playground', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_mode.name, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Deep visual exploration of CustomPaint and CustomPainter usage patterns: geometry, signal charts, procedural textures, radial effects, and path warping.',
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
              children: List<Widget>.generate(_themePresets.length, (int i) {
                final _PaintThemePreset preset = _themePresets[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(preset.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitches += 1;
                      _phase = 'theme';
                    });
                    _addTimeline('Theme', 'Theme switched to ${preset.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Painter Modes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _PainterMode.values.map(( _PainterMode mode) {
                return FilterChip(
                  selected: _mode == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _mode = mode;
                      _modeSwitches += 1;
                      _phase = 'mode';
                    });
                    _addTimeline('Mode', 'Painter mode switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
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
                Text('Paint Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune surface size, paint math, blend dynamics, and debugging overlays.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            _sliderRow(
              scheme: scheme,
              label: 'Canvas Width',
              value: _canvasWidth,
              min: 460,
              max: 1080,
              divisions: 310,
              onChanged: (double v) => setState(() => _canvasWidth = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Canvas Width', 'Set width to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Canvas Height',
              value: _canvasHeight,
              min: 240,
              max: 620,
              divisions: 190,
              onChanged: (double v) => setState(() => _canvasHeight = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Canvas Height', 'Set height to ${v.toStringAsFixed(0)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Stroke Scale',
              value: _strokeScale,
              min: 0.5,
              max: 3.4,
              divisions: 145,
              onChanged: (double v) => setState(() => _strokeScale = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Stroke Scale', 'Set stroke scale to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Amplitude',
              value: _amplitude,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _amplitude = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Amplitude', 'Set amplitude to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Frequency',
              value: _frequency,
              min: 0.3,
              max: 4.2,
              divisions: 195,
              onChanged: (double v) => setState(() => _frequency = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Frequency', 'Set frequency to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Noise',
              value: _noise,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _noise = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Noise', 'Set noise to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Blend',
              value: _blend,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _blend = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Blend', 'Set blend to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Roundness',
              value: _shapeRoundness,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _shapeRoundness = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Roundness', 'Set roundness to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Path Warp',
              value: _pathWarp,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _pathWarp = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Path Warp', 'Set path warp to ${v.toStringAsFixed(2)}.');
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
                _addTimeline('Guide Opacity', 'Set guide opacity to ${v.toStringAsFixed(2)}.');
              },
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Color Shift',
              value: _colorShift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _colorShift = v),
              onChangeEnd: (double v) {
                _bumpControl();
                _addTimeline('Color Shift', 'Set color shift to ${v.toStringAsFixed(2)}.');
              },
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _animate,
                  onChanged: (bool? v) {
                    final bool next = v ?? true;
                    setState(() => _animate = next);
                    if (next) {
                      _controller.repeat();
                    } else {
                      _controller.stop();
                    }
                    _bumpControl();
                    _addTimeline('Animation', next ? 'Animation enabled.' : 'Animation paused.');
                  },
                  child: const Text('Animate painter'),
                ),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _setToggle('grid', v), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showAxes, onChanged: (bool? v) => _setToggle('axes', v), child: const Text('Show axes')),
                CheckboxMenuButton(value: _showForeground, onChanged: (bool? v) => _setToggle('foreground', v), child: const Text('Show foreground painter')),
                CheckboxMenuButton(value: _showProbe, onChanged: (bool? v) => _setToggle('probe', v), child: const Text('Show probe marker')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _setToggle('diagnostics', v), child: const Text('Show diagnostics panel')),
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

  void _setToggle(String id, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (id) {
        case 'grid':
          _showGrid = next;
          break;
        case 'axes':
          _showAxes = next;
          break;
        case 'foreground':
          _showForeground = next;
          break;
        case 'probe':
          _showProbe = next;
          break;
        case 'diagnostics':
          _showDiagnostics = next;
          break;
        case 'guide':
          _showGuide = next;
          break;
        case 'timeline':
          _showTimeline = next;
          break;
        case 'legend':
          _showLegend = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    _addTimeline('Toggle', '$id set to $next.');
  }

  void _bumpControl() {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
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

  Widget _buildPainterStageBoard(ColorScheme scheme) {
    final double motion = _animate ? _controller.value : 0;
    final _SceneConfig config = _SceneConfig(
      mode: _mode,
      progress: motion,
      strokeScale: _strokeScale,
      noise: _noise,
      amplitude: _amplitude,
      frequency: _frequency,
      blend: _blend,
      shapeRoundness: _shapeRoundness,
      pathWarp: _pathWarp,
      guideOpacity: _guideOpacity,
      colorShift: _colorShift,
      probe: _probe,
      showGrid: _showGrid,
      showAxes: _showAxes,
      showProbe: _showProbe,
    );

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Painter Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Interactive CustomPaint stage with background scene and optional foreground overlays.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final RenderBox? box = context.findRenderObject() as RenderBox?;
                  if (box == null) {
                    return;
                  }
                  final Offset local = details.localPosition;
                  final Offset probe = Offset(
                    (local.dx / _canvasWidth).clamp(0.0, 1.0),
                    (local.dy / _canvasHeight).clamp(0.0, 1.0),
                  );
                  setState(() {
                    _probe = probe;
                    _tapCount += 1;
                    _phase = 'tap';
                  });
                  _addTimeline('Probe', 'Probe moved to (${probe.dx.toStringAsFixed(2)}, ${probe.dy.toStringAsFixed(2)}).');
                },
                child: SizedBox(
                  width: _canvasWidth,
                  height: _canvasHeight,
                  child: CustomPaint(
                    painter: _BackgroundScenePainter(config: config, onSnapshot: _setSnapshot),
                    foregroundPainter: _showForeground ? _ForegroundGuidePainter(config: config) : null,
                    child: const SizedBox.expand(),
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
                  _legendChip('mode ${_mode.name}', scheme.primary),
                  _legendChip('probe ${_probe.dx.toStringAsFixed(2)}, ${_probe.dy.toStringAsFixed(2)}', scheme.secondary),
                  _legendChip('blend ${_blend.toStringAsFixed(2)}', scheme.tertiary),
                  _legendChip('freq ${_frequency.toStringAsFixed(2)}', scheme.primary),
                  _legendChip('noise ${_noise.toStringAsFixed(2)}', scheme.secondary),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _setSnapshot(_PaintSnapshot snapshot) {
    if (!mounted) {
      return;
    }
    setState(() {
      _snapshot = snapshot;
    });
  }

  Widget _legendChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(999), border: Border.all(color: color.withValues(alpha: 0.60))),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildPainterGalleryBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Painter Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Small previews for each painter mode to compare composition style and complexity.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  itemCount: _PainterMode.values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _PainterMode mode = _PainterMode.values[index];
                    final _SceneConfig config = _SceneConfig(
                      mode: mode,
                      progress: _animate ? _controller.value : 0,
                      strokeScale: _strokeScale,
                      noise: _noise,
                      amplitude: _amplitude,
                      frequency: _frequency,
                      blend: _blend,
                      shapeRoundness: _shapeRoundness,
                      pathWarp: _pathWarp,
                      guideOpacity: _guideOpacity,
                      colorShift: _colorShift,
                      probe: _probe,
                      showGrid: _showGrid,
                      showAxes: false,
                      showProbe: false,
                    );
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _mode = mode;
                          _modeSwitches += 1;
                          _phase = 'gallery';
                        });
                        _addTimeline('Mode Pick', 'Selected ${mode.name} from gallery.');
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _mode == mode ? scheme.primary : scheme.outlineVariant, width: _mode == mode ? 2 : 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(mode.name, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomPaint(
                                    painter: _BackgroundScenePainter(config: config, onSnapshot: _ignoreSnapshot),
                                    foregroundPainter: _showForeground ? _ForegroundGuidePainter(config: config) : null,
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
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

  void _ignoreSnapshot(_PaintSnapshot snapshot) {
    if (snapshot.complexity < -1) {
      return;
    }
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
            Text('Composition Comparison', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('How painter layering differs from pure widget composition and decoration-only styling.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget customPaintCard = _comparisonCard(
                  scheme: scheme,
                  title: 'CustomPaint',
                  subtitle: 'Canvas-level control over paths, blending, and draw order.',
                  color: const Color(0xFF0F766E),
                  child: const Icon(Icons.brush_outlined, size: 36),
                );
                final Widget decoratedBoxCard = _comparisonCard(
                  scheme: scheme,
                  title: 'DecoratedBox',
                  subtitle: 'Great for static background decoration with lower complexity.',
                  color: const Color(0xFF1D4ED8),
                  child: const Icon(Icons.check_box_outline_blank_outlined, size: 36),
                );
                final Widget stackCard = _comparisonCard(
                  scheme: scheme,
                  title: 'Stack',
                  subtitle: 'Widget layering without custom path drawing.',
                  color: const Color(0xFFB45309),
                  child: const Icon(Icons.layers_outlined, size: 36),
                );
                if (narrow) {
                  return Column(children: <Widget>[customPaintCard, const SizedBox(height: 10), decoratedBoxCard, const SizedBox(height: 10), stackCard]);
                }
                return Row(children: <Widget>[Expanded(child: customPaintCard), const SizedBox(width: 10), Expanded(child: decoratedBoxCard), const SizedBox(width: 10), Expanded(child: stackCard)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparisonCard({required ColorScheme scheme, required String title, required String subtitle, required Color color, required Widget child}) {
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
              height: 100,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.62))),
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
                    childAspectRatio: columns == 1 ? 2.8 : 2.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricEntry entry = metrics[index];
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
                                Icon(entry.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(entry.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(entry.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(entry.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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
            Text('theme=${_themePresets[_themeIndex].id} mode=${_mode.name} phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('canvas=${_canvasWidth.toStringAsFixed(0)}x${_canvasHeight.toStringAsFixed(0)} stroke=${_strokeScale.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('noise=${_noise.toStringAsFixed(2)} amp=${_amplitude.toStringAsFixed(2)} freq=${_frequency.toStringAsFixed(2)} blend=${_blend.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('warp=${_pathWarp.toStringAsFixed(2)} round=${_shapeRoundness.toStringAsFixed(2)} guide=${_guideOpacity.toStringAsFixed(2)} shift=${_colorShift.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('toggles grid=$_showGrid axes=$_showAxes fg=$_showForeground probe=$_showProbe legend=$_showLegend', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches mode=$_modeSwitches theme=$_themeSwitches controls=$_controlEdits taps=$_tapCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('snapshot mode=${_snapshot.mode} complexity=${_snapshot.complexity} layers=${_snapshot.layers} pointer=(${_snapshot.pointer.dx.toStringAsFixed(2)}, ${_snapshot.pointer.dy.toStringAsFixed(2)})', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Interaction history for mode changes, control updates, and probe placements.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                children: _timeline.map(( _TimelineEvent e) {
                  final String stamp = '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}:${e.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text(e.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${e.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _SceneConfig {
  const _SceneConfig({
    required this.mode,
    required this.progress,
    required this.strokeScale,
    required this.noise,
    required this.amplitude,
    required this.frequency,
    required this.blend,
    required this.shapeRoundness,
    required this.pathWarp,
    required this.guideOpacity,
    required this.colorShift,
    required this.probe,
    required this.showGrid,
    required this.showAxes,
    required this.showProbe,
  });

  final _PainterMode mode;
  final double progress;
  final double strokeScale;
  final double noise;
  final double amplitude;
  final double frequency;
  final double blend;
  final double shapeRoundness;
  final double pathWarp;
  final double guideOpacity;
  final double colorShift;
  final Offset probe;
  final bool showGrid;
  final bool showAxes;
  final bool showProbe;
}

class _BackgroundScenePainter extends CustomPainter {
  _BackgroundScenePainter({required this.config, required this.onSnapshot});

  final _SceneConfig config;
  final ValueChanged<_PaintSnapshot> onSnapshot;

  @override
  void paint(Canvas canvas, Size size) {
    final int complexity;
    final int layers;

    final Rect rect = Offset.zero & size;
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          HSVColor.fromAHSV(1, 180 + (config.colorShift * 120), 0.65, 0.74).toColor(),
          HSVColor.fromAHSV(1, 260 + (config.colorShift * 120), 0.55, 0.78).toColor(),
          HSVColor.fromAHSV(1, 20 + (config.colorShift * 100), 0.60, 0.82).toColor(),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, base);

    switch (config.mode) {
      case _PainterMode.geometry:
        _paintGeometry(canvas, size);
        complexity = 42;
        layers = 5;
        break;
      case _PainterMode.signal:
        _paintSignal(canvas, size);
        complexity = 64;
        layers = 6;
        break;
      case _PainterMode.pattern:
        _paintPattern(canvas, size);
        complexity = 58;
        layers = 6;
        break;
      case _PainterMode.radial:
        _paintRadial(canvas, size);
        complexity = 51;
        layers = 7;
        break;
      case _PainterMode.pathLab:
        _paintPathLab(canvas, size);
        complexity = 72;
        layers = 7;
        break;
    }

    onSnapshot(
      _PaintSnapshot(mode: config.mode.name, complexity: complexity, layers: layers, pointer: config.probe),
    );
  }

  void _paintGeometry(Canvas canvas, Size size) {
    final double stroke = 2.2 * config.strokeScale;
    final RRect card = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.08, size.height * 0.12, size.width * 0.34, size.height * 0.30),
      Radius.circular(12 + (config.shapeRoundness * 28)),
    );

    final Paint fill = Paint()
      ..color = Colors.white.withValues(alpha: 0.20)
      ..style = PaintingStyle.fill;
    final Paint outline = Paint()
      ..color = Colors.white.withValues(alpha: 0.70)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    canvas.drawRRect(card, fill);
    canvas.drawRRect(card, outline);

    final Offset center = Offset(size.width * 0.68, size.height * 0.36);
    final double radius = math.min(size.width, size.height) * (0.14 + (config.amplitude * 0.22));

    final Paint circlePaint = Paint()
      ..shader = RadialGradient(
        colors: <Color>[Colors.white.withValues(alpha: 0.9), Colors.white.withValues(alpha: 0.12)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, circlePaint);
    canvas.drawCircle(center, radius, outline);

    final Path triangle = Path()
      ..moveTo(size.width * 0.18, size.height * 0.72)
      ..lineTo(size.width * 0.44, size.height * 0.90)
      ..lineTo(size.width * 0.08, size.height * 0.90)
      ..close();
    canvas.drawPath(triangle, fill);
    canvas.drawPath(triangle, outline);

    final Rect bar = Rect.fromLTWH(size.width * 0.52, size.height * 0.68, size.width * 0.36, size.height * 0.18);
    final Paint barPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    canvas.drawRect(bar, barPaint);
    canvas.drawRect(bar, outline);
  }

  void _paintSignal(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = Colors.white.withValues(alpha: 0.70)
      ..strokeWidth = 1.3 * config.strokeScale;

    final double margin = 24;
    final Rect chart = Rect.fromLTWH(margin, margin, size.width - (margin * 2), size.height - (margin * 2));
    canvas.drawRect(chart, axis);

    final Path signalA = Path();
    final Path signalB = Path();
    final int points = 120;
    for (int i = 0; i <= points; i += 1) {
      final double t = i / points;
      final double x = chart.left + (chart.width * t);
      final double yA = chart.center.dy + math.sin((t * math.pi * 2 * config.frequency) + (config.progress * math.pi * 2)) * chart.height * 0.36 * config.amplitude;
      final double yB = chart.center.dy + math.cos((t * math.pi * 2 * (config.frequency + 0.35)) - (config.progress * math.pi * 2)) * chart.height * 0.24 * (0.4 + config.amplitude * 0.6);

      if (i == 0) {
        signalA.moveTo(x, yA);
        signalB.moveTo(x, yB);
      } else {
        signalA.lineTo(x, yA);
        signalB.lineTo(x, yB);
      }
    }

    final Paint lineA = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 * config.strokeScale;

    final Paint lineB = Paint()
      ..color = Colors.black.withValues(alpha: 0.36)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 * config.strokeScale;

    canvas.drawPath(signalA, lineA);
    canvas.drawPath(signalB, lineB);

    final Paint fill = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final Path area = Path.from(signalA)
      ..lineTo(chart.right, chart.bottom)
      ..lineTo(chart.left, chart.bottom)
      ..close();
    canvas.drawPath(area, fill);
  }

  void _paintPattern(Canvas canvas, Size size) {
    final Paint stripe = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..strokeWidth = 1.0 + (config.strokeScale * 0.7);

    final double spacing = 10 + ((1 - config.noise) * 24);
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), stripe);
    }

    final Paint dots = Paint()..color = Colors.white.withValues(alpha: 0.35);
    final int count = 260;
    for (int i = 0; i < count; i += 1) {
      final double t = i / count;
      final double x = (math.sin((t * 91) + (config.progress * math.pi * 2)) * 0.5 + 0.5) * size.width;
      final double y = (math.cos((t * 73) - (config.progress * math.pi * 2)) * 0.5 + 0.5) * size.height;
      final double r = 0.5 + ((i % 4) * 0.4) + config.noise;
      canvas.drawCircle(Offset(x, y), r, dots);
    }
  }

  void _paintRadial(Canvas canvas, Size size) {
    final Offset center = Offset(
      size.width * (0.5 + math.sin(config.progress * math.pi * 2) * 0.08),
      size.height * (0.5 + math.cos(config.progress * math.pi * 2) * 0.08),
    );

    final double maxRadius = math.min(size.width, size.height) * 0.52;
    for (int i = 0; i < 7; i += 1) {
      final double factor = (i + 1) / 7;
      final double radius = maxRadius * factor * (0.55 + (config.amplitude * 0.45));
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (1.0 + (i * 0.9)) * config.strokeScale
        ..color = Colors.white.withValues(alpha: (0.32 - (factor * 0.20)).clamp(0.08, 0.35));
      canvas.drawCircle(center, radius, ring);
    }

    final Paint glow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[Colors.white.withValues(alpha: 0.85), Colors.white.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));
    canvas.drawCircle(center, maxRadius, glow);
  }

  void _paintPathLab(Canvas canvas, Size size) {
    final double warp = config.pathWarp;
    final Path path = Path();
    path.moveTo(size.width * 0.10, size.height * 0.20);
    path.cubicTo(
      size.width * (0.28 + (warp * 0.2)),
      size.height * (0.02 + (warp * 0.18)),
      size.width * (0.44 - (warp * 0.2)),
      size.height * (0.50 + (warp * 0.18)),
      size.width * 0.62,
      size.height * 0.26,
    );
    path.cubicTo(
      size.width * (0.80 + (warp * 0.12)),
      size.height * (0.06 + (warp * 0.24)),
      size.width * (0.90 - (warp * 0.12)),
      size.height * (0.76 - (warp * 0.20)),
      size.width * 0.62,
      size.height * 0.76,
    );
    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * (0.92 - (warp * 0.20)),
      size.width * 0.20,
      size.height * 0.78,
    );
    path.close();

    final Paint fill = Paint()
      ..shader = LinearGradient(
        colors: <Color>[Colors.white.withValues(alpha: 0.50), Colors.white.withValues(alpha: 0.14)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    final Paint stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 * config.strokeScale;
    canvas.drawPath(path, stroke);

    final metric = path.computeMetrics().first;
    final int dashes = 34;
    final double segment = metric.length / dashes;
    final Paint dashPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.40)
      ..strokeWidth = 2 * config.strokeScale
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < dashes; i += 2) {
      final double start = i * segment;
      final Path dash = metric.extractPath(start, start + (segment * 0.8));
      canvas.drawPath(dash, dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundScenePainter oldDelegate) {
    return oldDelegate.config != config;
  }
}

class _ForegroundGuidePainter extends CustomPainter {
  _ForegroundGuidePainter({required this.config});

  final _SceneConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    if (config.showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white.withValues(alpha: (0.25 * config.guideOpacity).clamp(0.04, 0.25))
        ..strokeWidth = 1;
      const double step = 24;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    if (config.showAxes) {
      final Paint axis = Paint()
        ..color = Colors.white.withValues(alpha: (0.6 * config.guideOpacity).clamp(0.10, 0.60))
        ..strokeWidth = 1.3 * config.strokeScale;
      final Offset c = Offset(size.width / 2, size.height / 2);
      canvas.drawLine(Offset(0, c.dy), Offset(size.width, c.dy), axis);
      canvas.drawLine(Offset(c.dx, 0), Offset(c.dx, size.height), axis);
    }

    if (config.showProbe) {
      final Offset p = Offset(size.width * config.probe.dx, size.height * config.probe.dy);
      final Paint ring = Paint()
        ..color = Colors.white.withValues(alpha: 0.88)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.1 * config.strokeScale;
      final Paint fill = Paint()
        ..color = Colors.black.withValues(alpha: 0.32)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(p, 12, fill);
      canvas.drawCircle(p, 12, ring);
      canvas.drawLine(Offset(p.dx - 18, p.dy), Offset(p.dx + 18, p.dy), ring);
      canvas.drawLine(Offset(p.dx, p.dy - 18), Offset(p.dx, p.dy + 18), ring);
    }
  }

  @override
  bool shouldRepaint(covariant _ForegroundGuidePainter oldDelegate) {
    return oldDelegate.config != config;
  }
}
