import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemeProfile> _themeProfiles = <_ThemeProfile>[
  _ThemeProfile(
    id: 'marine',
    name: 'Marine Studio',
    subtitle: 'Balanced cool palette to inspect shadow and clipping edges.',
    seed: Color(0xFF0E7490),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'ember',
    name: 'Ember Workshop',
    subtitle: 'Warm palette highlighting depth layering and highlights.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'charcoal',
    name: 'Charcoal Night',
    subtitle: 'Dark profile for high-contrast render edge validation.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ShapeScenario> _shapeScenarios = <_ShapeScenario>[
  _ShapeScenario(
    id: _ShapeScenarioMode.bevelDeck,
    title: 'Bevel Deck',
    description: 'Layered beveled cards with different elevations and blends.',
  ),
  _ShapeScenario(
    id: _ShapeScenarioMode.wavePanel,
    title: 'Wave Panel',
    description: 'Wave-shaped clipping surfaces to validate fluid contours.',
  ),
  _ShapeScenario(
    id: _ShapeScenarioMode.ticketBoard,
    title: 'Ticket Board',
    description: 'Notched ticket-style shapes with explicit clipping boundaries.',
  ),
  _ShapeScenario(
    id: _ShapeScenarioMode.orbitBlob,
    title: 'Orbit Blob',
    description: 'Organic blob shapes orbiting to stress animated clipping.',
  ),
  _ShapeScenario(
    id: _ShapeScenarioMode.morphLab,
    title: 'Morph Lab',
    description: 'Morphing shape paths with timeline-driven elevation shifts.',
  ),
  _ShapeScenario(
    id: _ShapeScenarioMode.compare,
    title: 'Compare',
    description: 'RenderPhysicalShape compared with ClipPath and PhysicalModel.',
  ),
];

const List<String> _guideLines = <String>[
  'PhysicalShape combines clipping and elevation shadow for arbitrary paths.',
  'RenderPhysicalShape is useful when your surface is not rectangle/circle only.',
  'Use a CustomClipper<Path> to define exact contours and reclip behavior.',
  'Clip behavior controls edge anti-aliasing and overflow semantics.',
  'Elevation should map to interaction hierarchy, not decorative noise.',
  'Shadow color can be tuned for visual language and theme contrast.',
  'Animated shape paths should preserve usability and predictable depth.',
  'Use diagnostic overlays to verify contour continuity and hit regions.',
  'Prefer meaningful shape families that encode intent in product UI.',
  'Compare PhysicalShape with PhysicalModel when deciding primitive choice.',
];

const List<_FaqCard> _faqCards = <_FaqCard>[
  _FaqCard(
    question: 'When should I choose PhysicalShape?',
    answer: 'When you need non-rectangular clipping plus elevation shadows from a single render primitive.',
  ),
  _FaqCard(
    question: 'What if my shape is just rounded rectangle?',
    answer: 'PhysicalModel is usually enough for standard geometric cases with border radius.',
  ),
  _FaqCard(
    question: 'Can I animate custom shape paths?',
    answer: 'Yes, but keep transitions smooth and preserve interaction targets during animation.',
  ),
  _FaqCard(
    question: 'How does clipBehavior impact visuals?',
    answer: 'It changes edge anti-aliasing and whether child paint can escape the shape boundary.',
  ),
  _FaqCard(
    question: 'How do I debug contour bugs?',
    answer: 'Add path overlays and snapshots to compare expected and painted geometry frame-by-frame.',
  ),
];

enum _ShapeScenarioMode {
  bevelDeck,
  wavePanel,
  ticketBoard,
  orbitBlob,
  morphLab,
  compare,
}

enum _ShapeFamily {
  bevel,
  wave,
  ticket,
  blob,
  star,
}

class _ThemeProfile {
  const _ThemeProfile({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String subtitle;
  final Color seed;
  final Brightness brightness;
}

class _ShapeScenario {
  const _ShapeScenario({required this.id, required this.title, required this.description});

  final _ShapeScenarioMode id;
  final String title;
  final String description;
}

class _FaqCard {
  const _FaqCard({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _MetricCard {
  const _MetricCard({required this.title, required this.value, required this.note, required this.icon});

  final String title;
  final String value;
  final String note;
  final IconData icon;
}

class _EventLine {
  const _EventLine({required this.time, required this.title, required this.note});

  final DateTime time;
  final String title;
  final String note;
}

class _SnapshotState {
  const _SnapshotState({
    required this.scenario,
    required this.family,
    required this.elevation,
    required this.clip,
  });

  final String scenario;
  final String family;
  final double elevation;
  final String clip;
}

dynamic build(BuildContext context) {
  return const _RenderPhysicalShapeStudio();
}

class _RenderPhysicalShapeStudio extends StatefulWidget {
  const _RenderPhysicalShapeStudio();

  @override
  State<_RenderPhysicalShapeStudio> createState() => _RenderPhysicalShapeStudioState();
}

class _RenderPhysicalShapeStudioState extends State<_RenderPhysicalShapeStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9800),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  _ShapeFamily _family = _ShapeFamily.wave;
  Clip _clipBehavior = Clip.antiAlias;

  double _stageHeight = 580;
  double _baseElevation = 9;
  double _elevationSpread = 16;
  double _corner = 24;
  double _notch = 26;
  double _waveAmplitude = 18;
  double _blobNoise = 0.42;
  double _starSharpness = 0.48;
  double _shadowAlpha = 0.46;
  double _surfaceAlpha = 0.92;
  double _shapeScale = 1.0;
  double _drift = 0.34;

  bool _animate = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showContours = true;
  bool _showOverflowProbe = true;
  bool _showLabels = true;

  int _themeChanges = 0;
  int _scenarioChanges = 0;
  int _familyChanges = 0;
  int _clipChanges = 0;
  int _controlEdits = 0;
  int _stageTaps = 0;

  String _phase = 'idle';

  _SnapshotState _snapshot = const _SnapshotState(
    scenario: 'bevelDeck',
    family: 'wave',
    elevation: 9,
    clip: 'antiAlias',
  );

  List<_EventLine> _timeline = const <_EventLine>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushEvent('Init', 'RenderPhysicalShape studio initialized.');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pushEvent(String title, String note) {
    setState(() {
      _timeline = <_EventLine>[
        _EventLine(time: DateTime.now(), title: title, note: note),
        ..._timeline,
      ].take(120).toList(growable: false);
    });
  }

  void _bump(String title, String note) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _pushEvent(title, note);
  }

  void _toggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'animate':
          _animate = next;
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
        case 'grid':
          _showGrid = next;
          break;
        case 'contours':
          _showContours = next;
          break;
        case 'overflow':
          _showOverflowProbe = next;
          break;
        case 'labels':
          _showLabels = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animate) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
    _pushEvent('Toggle', '$key set to $next.');
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _family = _ShapeFamily.wave;
      _clipBehavior = Clip.antiAlias;
      _stageHeight = 580;
      _baseElevation = 9;
      _elevationSpread = 16;
      _corner = 24;
      _notch = 26;
      _waveAmplitude = 18;
      _blobNoise = 0.42;
      _starSharpness = 0.48;
      _shadowAlpha = 0.46;
      _surfaceAlpha = 0.92;
      _shapeScale = 1.0;
      _drift = 0.34;
      _animate = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showContours = true;
      _showOverflowProbe = true;
      _showLabels = true;
      _phase = 'reset';
      _timeline = const <_EventLine>[];
      _snapshot = const _SnapshotState(scenario: 'bevelDeck', family: 'wave', elevation: 9, clip: 'antiAlias');
    });
    _controller.repeat();
    _pushEvent('Reset', 'Studio reset to defaults.');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeProfile profile = _themeProfiles[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: profile.seed, brightness: profile.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: profile.brightness),
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
                      _buildThemeAndScenarioBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildStageBoard(scheme),
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
                Icon(Icons.polyline_outlined, color: scheme.primary, size: 27),
                Text(
                  'RenderPhysicalShape Contour and Elevation Studio',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(
                    _shapeScenarios[_scenarioIndex].title,
                    style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual deep demo of PhysicalShape surfaces with custom clipping paths, elevation dynamics, and render diagnostics.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAndScenarioBoard(ColorScheme scheme) {
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
              children: List<Widget>.generate(_themeProfiles.length, (int i) {
                final _ThemeProfile p = _themeProfiles[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeChanges += 1;
                      _phase = 'theme';
                    });
                    _pushEvent('Theme', 'Theme switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themeProfiles[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_shapeScenarios.length, (int i) {
                final _ShapeScenario s = _shapeScenarios[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _scenarioChanges += 1;
                      _phase = 'scenario';
                    });
                    _pushEvent('Scenario', s.description);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_shapeScenarios[_scenarioIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Shape Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune clip paths, elevation, contour parameters, and visual diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 420,
              max: 960,
              divisions: 270,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _bump('Stage', 'Set stage height to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Base Elevation',
              value: _baseElevation,
              min: 0,
              max: 30,
              divisions: 150,
              onChanged: (double v) => setState(() => _baseElevation = v),
              onChangeEnd: (double v) => _bump('Elevation', 'Set base elevation to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Elevation Spread',
              value: _elevationSpread,
              min: 0,
              max: 40,
              divisions: 200,
              onChanged: (double v) => setState(() => _elevationSpread = v),
              onChangeEnd: (double v) => _bump('Spread', 'Set elevation spread to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Corner Radius',
              value: _corner,
              min: 0,
              max: 72,
              divisions: 144,
              onChanged: (double v) => setState(() => _corner = v),
              onChangeEnd: (double v) => _bump('Corner', 'Set corner radius to ${v.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Ticket Notch',
              value: _notch,
              min: 0,
              max: 64,
              divisions: 128,
              onChanged: (double v) => setState(() => _notch = v),
              onChangeEnd: (double v) => _bump('Notch', 'Set notch size to ${v.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Wave Amplitude',
              value: _waveAmplitude,
              min: 0,
              max: 40,
              divisions: 160,
              onChanged: (double v) => setState(() => _waveAmplitude = v),
              onChangeEnd: (double v) => _bump('Wave', 'Set wave amplitude to ${v.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Blob Noise',
              value: _blobNoise,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _blobNoise = v),
              onChangeEnd: (double v) => _bump('Blob', 'Set blob noise to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Star Sharpness',
              value: _starSharpness,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _starSharpness = v),
              onChangeEnd: (double v) => _bump('Star', 'Set star sharpness to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Shadow Alpha',
              value: _shadowAlpha,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _shadowAlpha = v),
              onChangeEnd: (double v) => _bump('Shadow', 'Set shadow alpha to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Surface Alpha',
              value: _surfaceAlpha,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double v) => setState(() => _surfaceAlpha = v),
              onChangeEnd: (double v) => _bump('Surface', 'Set surface alpha to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Shape Scale',
              value: _shapeScale,
              min: 0.6,
              max: 1.4,
              divisions: 80,
              onChanged: (double v) => setState(() => _shapeScale = v),
              onChangeEnd: (double v) => _bump('Scale', 'Set shape scale to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Drift',
              value: _drift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _drift = v),
              onChangeEnd: (double v) => _bump('Drift', 'Set drift to ${v.toStringAsFixed(2)}.'),
            ),
            const SizedBox(height: 8),
            Text('Shape Family', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _ShapeFamily.values.map(( _ShapeFamily family) {
                return ChoiceChip(
                  selected: _family == family,
                  label: Text(family.name),
                  onSelected: (_) {
                    setState(() {
                      _family = family;
                      _familyChanges += 1;
                      _phase = 'family';
                    });
                    _pushEvent('Family', 'Shape family switched to ${family.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text('Clip Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Clip.values.map((Clip c) {
                return ChoiceChip(
                  selected: _clipBehavior == c,
                  label: Text(c.name),
                  onSelected: (_) {
                    setState(() {
                      _clipBehavior = c;
                      _clipChanges += 1;
                      _phase = 'clip';
                    });
                    _pushEvent('Clip', 'Clip behavior switched to ${c.name}.');
                  },
                );
              }).toList(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate shapes')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Show stage grid')),
                CheckboxMenuButton(value: _showContours, onChanged: (bool? v) => _toggle('contours', v), child: const Text('Show contour overlay')),
                CheckboxMenuButton(value: _showOverflowProbe, onChanged: (bool? v) => _toggle('overflow', v), child: const Text('Show overflow probe')),
                CheckboxMenuButton(value: _showLabels, onChanged: (bool? v) => _toggle('labels', v), child: const Text('Show labels')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Show guide')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Show timeline')),
              ],
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

  Widget _buildStageBoard(ColorScheme scheme) {
    final double t = _animate ? _controller.value : 0;
    _snapshot = _SnapshotState(
      scenario: _shapeScenarios[_scenarioIndex].id.name,
      family: _family.name,
      elevation: _baseElevation,
      clip: _clipBehavior.name,
    );

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Physical Shape Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Each lane uses PhysicalShape with custom clippers and elevation dynamics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _stageTaps += 1;
                  _phase = 'stage-tap';
                });
                _pushEvent('Stage Tap', 'Stage tapped for interaction checkpoint.');
              },
              child: SizedBox(
                height: _stageHeight,
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
                            painter: _ShapeGridPainter(progress: t, drift: _drift),
                          ),
                        _buildScenarioLane(scheme, t),
                      ],
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

  Widget _buildScenarioLane(ColorScheme scheme, double t) {
    switch (_shapeScenarios[_scenarioIndex].id) {
      case _ShapeScenarioMode.bevelDeck:
        return _bevelDeckLane(scheme, t);
      case _ShapeScenarioMode.wavePanel:
        return _wavePanelLane(scheme, t);
      case _ShapeScenarioMode.ticketBoard:
        return _ticketBoardLane(scheme, t);
      case _ShapeScenarioMode.orbitBlob:
        return _orbitBlobLane(scheme, t);
      case _ShapeScenarioMode.morphLab:
        return _morphLabLane(scheme, t);
      case _ShapeScenarioMode.compare:
        return _compareLane(scheme, t);
    }
  }

  Widget _bevelDeckLane(ColorScheme scheme, double t) {
    final List<Widget> surfaces = <Widget>[];
    for (int i = 0; i < 6; i += 1) {
      final double x = 80 + i * 72;
      final double y = 70 + i * 46;
      final double e = _baseElevation + (_elevationSpread * (i / 5));
      surfaces.add(
        Positioned(
          left: x,
          top: y,
          child: _physicalSurface(
            scheme: scheme,
            width: 360 * _shapeScale,
            height: 150 * _shapeScale,
            elevation: e,
            colorA: Color.lerp(scheme.primary, scheme.secondary, i / 5)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, i / 5)!,
            clipper: _bevelClipper(_corner),
            label: 'Bevel ${i + 1}',
            subtitle: 'elevation ${e.toStringAsFixed(1)}',
          ),
        ),
      );
    }
    return Stack(children: surfaces);
  }

  Widget _wavePanelLane(ColorScheme scheme, double t) {
    final double drift = math.sin(t * math.pi * 2) * 0.5 + 0.5;
    return Center(
      child: SizedBox(
        width: 860,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _physicalSurface(
              scheme: scheme,
              width: 820,
              height: 220,
              elevation: _baseElevation + _elevationSpread * 0.7,
              colorA: scheme.primary,
              colorB: scheme.secondary,
              clipper: _WaveClipper(amplitude: _waveAmplitude * (0.6 + drift * 0.7), phase: t * math.pi * 2),
              label: 'Wave Header',
              subtitle: 'animated wave clipper',
            ),
            const SizedBox(height: 18),
            _physicalSurface(
              scheme: scheme,
              width: 820,
              height: 220,
              elevation: _baseElevation + _elevationSpread * 0.2,
              colorA: scheme.tertiary,
              colorB: scheme.primary,
              clipper: _WaveClipper(amplitude: _waveAmplitude * 0.7, phase: (1 - t) * math.pi * 2),
              label: 'Wave Detail',
              subtitle: 'phase-inverted contour',
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketBoardLane(ColorScheme scheme, double t) {
    final List<Widget> tickets = <Widget>[];
    for (int i = 0; i < 9; i += 1) {
      final double e = _baseElevation + (_elevationSpread * ((i % 3) / 2));
      final double x = 36 + (i % 3) * 300;
      final double y = 40 + (i ~/ 3) * 150;
      tickets.add(
        Positioned(
          left: x,
          top: y,
          child: _physicalSurface(
            scheme: scheme,
            width: 260,
            height: 118,
            elevation: e,
            colorA: Color.lerp(scheme.primary, scheme.secondary, (i % 4) / 4)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, ((i + 1) % 5) / 5)!,
            clipper: _TicketClipper(notch: _notch * (0.8 + ((i % 2) * 0.35))),
            label: 'Ticket ${i + 1}',
            subtitle: 'notch ${_notch.toStringAsFixed(1)}',
          ),
        ),
      );
    }
    return Stack(children: tickets);
  }

  Widget _orbitBlobLane(ColorScheme scheme, double t) {
    final List<Widget> blobs = <Widget>[];
    for (int i = 0; i < 7; i += 1) {
      final double angle = (t * math.pi * 2) + (i * 0.88);
      final double radius = 150 + (i * 36);
      final double x = 470 + math.cos(angle) * radius;
      final double y = 270 + math.sin(angle) * (radius * 0.58);
      final double e = _baseElevation + _elevationSpread * (0.2 + ((i % 5) / 5));
      blobs.add(
        Positioned(
          left: x,
          top: y,
          child: _physicalSurface(
            scheme: scheme,
            width: (110 + (i * 12)) * _shapeScale,
            height: (92 + (i * 10)) * _shapeScale,
            elevation: e,
            colorA: Color.lerp(scheme.primary, scheme.secondary, i / 7)!,
            colorB: Color.lerp(scheme.tertiary, scheme.primary, i / 7)!,
            clipper: _BlobClipper(noise: _blobNoise * (0.7 + i / 12), phase: angle),
            label: 'Blob ${i + 1}',
            subtitle: 'e ${e.toStringAsFixed(1)}',
          ),
        ),
      );
    }
    return Stack(children: blobs);
  }

  Widget _morphLabLane(ColorScheme scheme, double t) {
    final double p = _animate ? (0.5 + math.sin(t * math.pi * 2) * 0.5) : 0.5;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: List<Widget>.generate(6, (int index) {
          final double local = (index / 5 + p) % 1;
          final double e = _baseElevation + _elevationSpread * local;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _physicalSurface(
              scheme: scheme,
              width: double.infinity,
              height: 84,
              elevation: e,
              colorA: Color.lerp(scheme.primary, scheme.secondary, local)!,
              colorB: Color.lerp(scheme.tertiary, scheme.primary, local)!,
              clipper: _MorphClipper(
                family: _family,
                corner: _corner,
                notch: _notch,
                waveAmplitude: _waveAmplitude,
                blobNoise: _blobNoise,
                starSharpness: _starSharpness,
                morph: local,
              ),
              label: 'Morph ${(index + 1)}',
              subtitle: 'morph ${local.toStringAsFixed(2)} elevation ${e.toStringAsFixed(2)}',
            ),
          );
        }),
      ),
    );
  }

  Widget _compareLane(ColorScheme scheme, double t) {
    final CustomClipper<Path> clipper = _MorphClipper(
      family: _family,
      corner: _corner,
      notch: _notch,
      waveAmplitude: _waveAmplitude,
      blobNoise: _blobNoise,
      starSharpness: _starSharpness,
      morph: t,
    );
    final double elevation = _baseElevation + _elevationSpread * 0.6;
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Render Primitive Comparison', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 22)),
          const SizedBox(height: 8),
          Text(
            'Three equivalent-looking surfaces rendered through different primitives to explain trade-offs.',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _physicalSurface(
                  scheme: scheme,
                  width: double.infinity,
                  height: 210,
                  elevation: elevation,
                  colorA: scheme.primary,
                  colorB: scheme.secondary,
                  clipper: clipper,
                  label: 'PhysicalShape',
                  subtitle: 'clip + elevation in one primitive',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Material(
                  elevation: elevation,
                  shadowColor: scheme.shadow.withValues(alpha: _shadowAlpha),
                  clipBehavior: _clipBehavior,
                  child: ClipPath(
                    clipper: clipper,
                    child: Container(
                      height: 210,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[scheme.secondary, scheme.tertiary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: const Center(
                        child: Text('Material + ClipPath', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipPath(
                  clipper: clipper,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[scheme.tertiary, scheme.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: scheme.shadow.withValues(alpha: _shadowAlpha),
                          blurRadius: elevation * 2,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('ClipPath + DecoratedBox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('family ${_family.name}', scheme.primary),
              _chip('clip ${_clipBehavior.name}', scheme.secondary),
              _chip('elevation ${elevation.toStringAsFixed(2)}', scheme.tertiary),
              _chip('surface alpha ${_surfaceAlpha.toStringAsFixed(2)}', scheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _physicalSurface({
    required ColorScheme scheme,
    required double width,
    required double height,
    required double elevation,
    required Color colorA,
    required Color colorB,
    required CustomClipper<Path> clipper,
    required String label,
    required String subtitle,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          PhysicalShape(
            clipper: clipper,
            elevation: elevation,
            color: colorA.withValues(alpha: _surfaceAlpha),
            shadowColor: scheme.shadow.withValues(alpha: _shadowAlpha),
            clipBehavior: _clipBehavior,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[colorA.withValues(alpha: _surfaceAlpha), colorB.withValues(alpha: _surfaceAlpha)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SizedBox.expand(
                child: _showLabels
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                            const Spacer(),
                            Text(subtitle, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 12)),
                          ],
                        ),
                      )
                    : const SizedBox.expand(),
              ),
            ),
          ),
          if (_showOverflowProbe)
            Positioned(
              right: -10,
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(999)),
                child: const Text('probe', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          if (_showContours)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _ContourPainter(
                    clipper: clipper,
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  CustomClipper<Path> _bevelClipper(double corner) {
    return _BevelClipper(corner: corner);
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
            Text('Usage Guidance Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('How RenderPhysicalShape compares with nearby options in design and behavior.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget a = _compareCard(
                  scheme: scheme,
                  title: 'RenderPhysicalShape',
                  note: 'Best for arbitrary path clipping with elevation and shadow.',
                  icon: Icons.polyline,
                  color: const Color(0xFF0F766E),
                );
                final Widget b = _compareCard(
                  scheme: scheme,
                  title: 'RenderPhysicalModel',
                  note: 'Best for standard box/circle surfaces with elevation.',
                  icon: Icons.layers,
                  color: const Color(0xFF1D4ED8),
                );
                final Widget c = _compareCard(
                  scheme: scheme,
                  title: 'ClipPath + Decorated',
                  note: 'Manual route when you need custom paint pipeline control.',
                  icon: Icons.edit_road,
                  color: const Color(0xFFB45309),
                );
                if (narrow) {
                  return Column(children: <Widget>[a, const SizedBox(height: 10), b, const SizedBox(height: 10), c]);
                }
                return Row(children: <Widget>[Expanded(child: a), const SizedBox(width: 10), Expanded(child: b), const SizedBox(width: 10), Expanded(child: c)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareCard({required ColorScheme scheme, required String title, required String note, required IconData icon, required Color color}) {
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
            const SizedBox(height: 6),
            Text(note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 96,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.62)),
              ),
              child: Center(child: Icon(icon, color: color, size: 34)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricCard> cards = _metrics();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Diagnostics and Metrics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
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
                  itemCount: cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.7 : 2.05,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricCard m = cards[index];
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
                                Expanded(child: Text(m.title, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
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
            if (_showDiagnostics) _buildSnapshotBoard(scheme),
          ],
        ),
      ),
    );
  }

  List<_MetricCard> _metrics() {
    return <_MetricCard>[
      _MetricCard(title: 'Scenario', value: _shapeScenarios[_scenarioIndex].title, note: 'Active demo lane.', icon: Icons.route_outlined),
      _MetricCard(title: 'Theme', value: _themeProfiles[_themeIndex].name, note: 'Current color profile.', icon: Icons.palette_outlined),
      _MetricCard(title: 'Family', value: _family.name, note: 'Primary contour family.', icon: Icons.category_outlined),
      _MetricCard(title: 'Clip', value: _clipBehavior.name, note: 'Current clipping behavior.', icon: Icons.content_cut_outlined),
      _MetricCard(title: 'Stage Height', value: _stageHeight.toStringAsFixed(0), note: 'Canvas height for the stage.', icon: Icons.height_outlined),
      _MetricCard(title: 'Elevation', value: '${_baseElevation.toStringAsFixed(1)} + ${_elevationSpread.toStringAsFixed(1)}', note: 'Base and spread across surfaces.', icon: Icons.vertical_align_top_outlined),
      _MetricCard(title: 'Corner', value: _corner.toStringAsFixed(1), note: 'Corner parameter for bevel/morph shapes.', icon: Icons.rounded_corner_outlined),
      _MetricCard(title: 'Notch', value: _notch.toStringAsFixed(1), note: 'Ticket notch size.', icon: Icons.cut_outlined),
      _MetricCard(title: 'Wave Amplitude', value: _waveAmplitude.toStringAsFixed(1), note: 'Wave contour height.', icon: Icons.waves_outlined),
      _MetricCard(title: 'Blob Noise', value: _blobNoise.toStringAsFixed(2), note: 'Organic contour variation.', icon: Icons.bubble_chart_outlined),
      _MetricCard(title: 'Star Sharpness', value: _starSharpness.toStringAsFixed(2), note: 'Inner radius ratio for star.', icon: Icons.star_outline),
      _MetricCard(title: 'Shadow Alpha', value: _shadowAlpha.toStringAsFixed(2), note: 'Shadow intensity.', icon: Icons.dark_mode_outlined),
      _MetricCard(title: 'Surface Alpha', value: _surfaceAlpha.toStringAsFixed(2), note: 'Surface opacity.', icon: Icons.opacity_outlined),
      _MetricCard(title: 'Shape Scale', value: _shapeScale.toStringAsFixed(2), note: 'Global lane scaling.', icon: Icons.aspect_ratio_outlined),
      _MetricCard(title: 'Drift', value: _drift.toStringAsFixed(2), note: 'Grid/pattern drift factor.', icon: Icons.air_outlined),
      _MetricCard(title: 'Changes', value: 'theme=$_themeChanges scenario=$_scenarioChanges family=$_familyChanges clip=$_clipChanges', note: 'Mode switch counters.', icon: Icons.swap_horiz_outlined),
      _MetricCard(title: 'Control Edits', value: '$_controlEdits', note: 'Slider and toggle edit count.', icon: Icons.tune_outlined),
      _MetricCard(title: 'Stage Taps', value: '$_stageTaps', note: 'Interactions on the stage area.', icon: Icons.touch_app_outlined),
      _MetricCard(title: 'Snapshot', value: '${_snapshot.scenario} ${_snapshot.family} e=${_snapshot.elevation.toStringAsFixed(1)} ${_snapshot.clip}', note: 'Current snapshot line.', icon: Icons.camera_outlined),
      _MetricCard(title: 'Phase', value: _phase, note: 'Latest interaction phase.', icon: Icons.flag_outlined),
    ];
  }

  Widget _buildSnapshotBoard(ColorScheme scheme) {
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
                Text('Console Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('theme=${_themeProfiles[_themeIndex].id} scenario=${_shapeScenarios[_scenarioIndex].id.name} family=${_family.name} clip=${_clipBehavior.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stage=${_stageHeight.toStringAsFixed(0)} baseElevation=${_baseElevation.toStringAsFixed(1)} spread=${_elevationSpread.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('corner=${_corner.toStringAsFixed(1)} notch=${_notch.toStringAsFixed(1)} wave=${_waveAmplitude.toStringAsFixed(1)} blob=${_blobNoise.toStringAsFixed(2)} star=${_starSharpness.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('shadow=${_shadowAlpha.toStringAsFixed(2)} surface=${_surfaceAlpha.toStringAsFixed(2)} scale=${_shapeScale.toStringAsFixed(2)} drift=${_drift.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('flags animate=$_animate grid=$_showGrid contours=$_showContours overflow=$_showOverflowProbe labels=$_showLabels', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('changes theme=$_themeChanges scenario=$_scenarioChanges family=$_familyChanges clip=$_clipChanges controls=$_controlEdits taps=$_stageTaps', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            ..._guideLines.map((String line) {
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
            ..._faqCards.map(( _FaqCard faq) {
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
                      Text(faq.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(faq.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                TextButton.icon(onPressed: () => setState(() => _timeline = const <_EventLine>[]), icon: const Icon(Icons.clear_all), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological log of contour, clip, and depth interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with controls to create events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _EventLine event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer))),
                      title: Text(event.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${event.note}', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _ShapeGridPainter extends CustomPainter {
  const _ShapeGridPainter({required this.progress, required this.drift});

  final double progress;
  final double drift;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF14B8A6), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF3B82F6), const Color(0xFF8B5CF6), drift)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withValues(alpha: 0.2));

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.13)
      ..strokeWidth = 1;
    const double step = 28;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _ShapeGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}

class _ContourPainter extends CustomPainter {
  const _ContourPainter({required this.clipper, required this.color});

  final CustomClipper<Path> clipper;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = clipper.getClip(size);
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _ContourPainter oldDelegate) {
    return oldDelegate.clipper != clipper || oldDelegate.color != color;
  }
}

class _BevelClipper extends CustomClipper<Path> {
  const _BevelClipper({required this.corner});

  final double corner;

  @override
  Path getClip(Size size) {
    final double c = corner.clamp(0, math.min(size.width, size.height) / 2);
    return Path()
      ..moveTo(c, 0)
      ..lineTo(size.width - c, 0)
      ..lineTo(size.width, c)
      ..lineTo(size.width, size.height - c)
      ..lineTo(size.width - c, size.height)
      ..lineTo(c, size.height)
      ..lineTo(0, size.height - c)
      ..lineTo(0, c)
      ..close();
  }

  @override
  bool shouldReclip(covariant _BevelClipper oldClipper) => oldClipper.corner != corner;
}

class _WaveClipper extends CustomClipper<Path> {
  const _WaveClipper({required this.amplitude, required this.phase});

  final double amplitude;
  final double phase;

  @override
  Path getClip(Size size) {
    final Path path = Path()..moveTo(0, 0);
    for (double x = 0; x <= size.width; x += 8) {
      final double y = amplitude * math.sin((x / size.width) * math.pi * 2 + phase) + amplitude;
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant _WaveClipper oldClipper) {
    return oldClipper.amplitude != amplitude || oldClipper.phase != phase;
  }
}

class _TicketClipper extends CustomClipper<Path> {
  const _TicketClipper({required this.notch});

  final double notch;

  @override
  Path getClip(Size size) {
    final double n = notch.clamp(0, size.height / 2 - 2);
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height / 2 - n)
      ..arcToPoint(Offset(size.width, size.height / 2 + n), radius: Radius.circular(n), clockwise: false)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height / 2 + n)
      ..arcToPoint(Offset(0, size.height / 2 - n), radius: Radius.circular(n), clockwise: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant _TicketClipper oldClipper) => oldClipper.notch != notch;
}

class _BlobClipper extends CustomClipper<Path> {
  const _BlobClipper({required this.noise, required this.phase});

  final double noise;
  final double phase;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double rx = size.width / 2;
    final double ry = size.height / 2;

    for (int i = 0; i <= 60; i += 1) {
      final double a = (i / 60) * math.pi * 2;
      final double nx = 1 + noise * 0.4 * math.sin((a * 3) + phase);
      final double ny = 1 + noise * 0.35 * math.cos((a * 4) - phase);
      final Offset p = Offset(center.dx + math.cos(a) * rx * nx, center.dy + math.sin(a) * ry * ny);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _BlobClipper oldClipper) {
    return oldClipper.noise != noise || oldClipper.phase != phase;
  }
}

class _MorphClipper extends CustomClipper<Path> {
  const _MorphClipper({
    required this.family,
    required this.corner,
    required this.notch,
    required this.waveAmplitude,
    required this.blobNoise,
    required this.starSharpness,
    required this.morph,
  });

  final _ShapeFamily family;
  final double corner;
  final double notch;
  final double waveAmplitude;
  final double blobNoise;
  final double starSharpness;
  final double morph;

  @override
  Path getClip(Size size) {
    switch (family) {
      case _ShapeFamily.bevel:
        return _BevelClipper(corner: corner * (0.7 + morph * 0.5)).getClip(size);
      case _ShapeFamily.wave:
        return _WaveClipper(amplitude: waveAmplitude * (0.6 + morph * 0.7), phase: morph * math.pi * 2).getClip(size);
      case _ShapeFamily.ticket:
        return _TicketClipper(notch: notch * (0.5 + morph * 0.7)).getClip(size);
      case _ShapeFamily.blob:
        return _BlobClipper(noise: blobNoise * (0.7 + morph * 0.6), phase: morph * math.pi * 2).getClip(size);
      case _ShapeFamily.star:
        return _starPath(size, starSharpness * (0.7 + morph * 0.5));
    }
  }

  Path _starPath(Size size, double sharpness) {
    final Path path = Path();
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double outer = math.min(size.width, size.height) / 2;
    final double inner = outer * (0.2 + sharpness * 0.6);
    for (int i = 0; i < 10; i += 1) {
      final bool isOuter = i.isEven;
      final double radius = isOuter ? outer : inner;
      final double angle = -math.pi / 2 + (i * math.pi / 5);
      final Offset p = Offset(center.dx + math.cos(angle) * radius, center.dy + math.sin(angle) * radius);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _MorphClipper oldClipper) {
    return oldClipper.family != family ||
        oldClipper.corner != corner ||
        oldClipper.notch != notch ||
        oldClipper.waveAmplitude != waveAmplitude ||
        oldClipper.blobNoise != blobNoise ||
        oldClipper.starSharpness != starSharpness ||
        oldClipper.morph != morph;
  }
}
