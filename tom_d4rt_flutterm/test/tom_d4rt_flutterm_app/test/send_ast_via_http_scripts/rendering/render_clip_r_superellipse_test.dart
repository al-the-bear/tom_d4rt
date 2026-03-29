import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemeProfile> _themeProfiles = <_ThemeProfile>[
  _ThemeProfile(
    id: 'signal',
    name: 'Signal Deck',
    description: 'Balanced profile for evaluating superellipse clipping transitions.',
    seed: Color(0xFF0F766E),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'amber',
    name: 'Amber Studio',
    description: 'Warm profile for edge quality and clip behavior inspection.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'cobalt',
    name: 'Cobalt Grid',
    description: 'Cool profile for geometry and corner-radius comparison.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemeProfile(
    id: 'night',
    name: 'Night Audit',
    description: 'Dark profile for contrast and clipping-boundary diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ScenarioLane> _scenarioLanes = <_ScenarioLane>[
  _ScenarioLane(
    id: 'hero',
    title: 'Hero Stage',
    subtitle: 'Interactive hero card to tune border radius and clip behavior in real time.',
  ),
  _ScenarioLane(
    id: 'behavior',
    title: 'Clip Behavior Matrix',
    subtitle: 'Visual side-by-side comparison of none, hardEdge, antiAlias, and saveLayer clipping.',
  ),
  _ScenarioLane(
    id: 'radius',
    title: 'Radius Study',
    subtitle: 'Small multiples showing curvature shifts across increasing superellipse radii.',
  ),
  _ScenarioLane(
    id: 'custom',
    title: 'Custom Clipper',
    subtitle: 'Asymmetric CustomClipper<RSuperellipse> use cases and practical composition patterns.',
  ),
  _ScenarioLane(
    id: 'nested',
    title: 'Nested and Animated',
    subtitle: 'Nested superellipse clips and animation behavior under changing geometry.',
  ),
];

const List<String> _guideBullets = <String>[
  'RenderClipRSuperellipse is the render object behind ClipRSuperellipse.',
  'Use ClipRSuperellipse when you need smooth squircle-like clipping rather than circular arcs.',
  'Prefer Clip.antiAlias for most UI cases where edge quality matters.',
  'Use Clip.hardEdge when performance is critical and antialiasing is not visually required.',
  'Use Clip.antiAliasWithSaveLayer only when blending and compositing artifacts demand it.',
  'A custom clipper lets you define asymmetric corner radii via RSuperellipse constructors.',
  'Pair clipping with gradients and texture overlays to verify edge behavior under complex paints.',
  'Nested clips are useful for card-within-card compositions and framing effects.',
  'Animate radius and clip settings to catch transitions where aliasing or boundary artifacts appear.',
  'Document chosen clip behavior in shared widgets to maintain consistent visual quality.',
];

const List<_FaqItem> _faqItems = <_FaqItem>[
  _FaqItem(
    question: 'What does RenderClipRSuperellipse do?',
    answer: 'It clips child painting to an RSuperellipse region and powers ClipRSuperellipse at the widget layer.',
  ),
  _FaqItem(
    question: 'When should I prefer superellipse clipping over rounded rectangles?',
    answer: 'When you want smoother corner transitions often associated with modern platform surfaces and icon-like shapes.',
  ),
  _FaqItem(
    question: 'How do clipBehavior modes differ?',
    answer: 'They trade edge quality and compositing cost; antiAlias is the default balance for most cases.',
  ),
  _FaqItem(
    question: 'Can I provide custom geometry?',
    answer: 'Yes, provide a CustomClipper<RSuperellipse> for dynamic or asymmetric clipping logic.',
  ),
  _FaqItem(
    question: 'Is this mainly visual or semantic?',
    answer: 'It is primarily visual clipping at paint time, though it influences hit regions where clipping intersects interaction.',
  ),
];

const List<_GalleryTile> _galleryTiles = <_GalleryTile>[
  _GalleryTile(label: 'Aurora', colorA: Color(0xFF0EA5E9), colorB: Color(0xFF14B8A6), note: 'Gradient blend with icon stack'),
  _GalleryTile(label: 'Canyon', colorA: Color(0xFFF59E0B), colorB: Color(0xFFEF4444), note: 'Warm tones with texture stripes'),
  _GalleryTile(label: 'Lime', colorA: Color(0xFF22C55E), colorB: Color(0xFF16A34A), note: 'Dense curve reads on green palette'),
  _GalleryTile(label: 'Iris', colorA: Color(0xFF8B5CF6), colorB: Color(0xFF6366F1), note: 'High-contrast corner transition demo'),
  _GalleryTile(label: 'Rose', colorA: Color(0xFFF43F5E), colorB: Color(0xFFFB7185), note: 'Smooth clipping over diagonal overlay'),
  _GalleryTile(label: 'Steel', colorA: Color(0xFF475569), colorB: Color(0xFF1E293B), note: 'Dark card for edge visibility checks'),
];

enum _ClipGeometryMode {
  uniform,
  asymmetric,
  custom,
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

class _ScenarioLane {
  const _ScenarioLane({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _GalleryTile {
  const _GalleryTile({required this.label, required this.colorA, required this.colorB, required this.note});

  final String label;
  final Color colorA;
  final Color colorB;
  final String note;
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
  return const _RenderClipRSuperellipseStudio();
}

class _RenderClipRSuperellipseStudio extends StatefulWidget {
  const _RenderClipRSuperellipseStudio();

  @override
  State<_RenderClipRSuperellipseStudio> createState() => _RenderClipRSuperellipseStudioState();
}

class _RenderClipRSuperellipseStudioState extends State<_RenderClipRSuperellipseStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7600),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  Clip _clipBehavior = Clip.antiAlias;
  _ClipGeometryMode _geometryMode = _ClipGeometryMode.uniform;

  bool _showGrid = true;
  bool _showOutline = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _animateBackdrop = true;
  bool _animateRadius = false;
  bool _nestedClip = true;

  double _radiusValue = 28;
  double _heroHeight = 240;
  double _heroWidthFactor = 0.86;
  double _asymmetry = 0.35;
  double _textureDensity = 0.50;
  double _panelPadding = 14;

  int _themeSwitchCount = 0;
  int _scenarioSwitchCount = 0;
  int _clipSwitchCount = 0;
  int _geometrySwitchCount = 0;
  int _heroTapCount = 0;
  int _galleryTapCount = 0;

  String _phase = 'idle';
  String _lastTileTap = 'none';
  String _lastClipChange = 'antiAlias';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTimeline('Init', 'RenderClipRSuperellipse visual studio initialized.');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(80).toList(growable: false);
    });
  }

  double _effectiveRadius() {
    if (_animateRadius) {
      final double wave = (math.sin(_animationController.value * math.pi * 2) + 1) / 2;
      return 8 + wave * 68;
    }
    return _radiusValue;
  }

  List<_MetricEntry> _metrics() {
    final double radius = _effectiveRadius();
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarioLanes[_scenarioIndex].title, note: 'Current lane for exploration.', icon: Icons.dashboard_customize_outlined),
      _MetricEntry(label: 'Theme', value: _themeProfiles[_themeIndex].name, note: 'Visual profile and contrast mood.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Clip Behavior', value: _clipBehavior.name, note: 'Current clip quality/compositing strategy.', icon: Icons.content_cut_outlined),
      _MetricEntry(label: 'Geometry Mode', value: _geometryMode.name, note: 'Uniform, asymmetric, or custom clipper.', icon: Icons.category_outlined),
      _MetricEntry(label: 'Radius', value: radius.toStringAsFixed(2), note: 'Current effective corner radius.', icon: Icons.rounded_corner_outlined),
      _MetricEntry(label: 'Asymmetry', value: _asymmetry.toStringAsFixed(2), note: 'Corner variation amount.', icon: Icons.compare_arrows_outlined),
      _MetricEntry(label: 'Texture', value: _textureDensity.toStringAsFixed(2), note: 'Texture stripe density overlay.', icon: Icons.texture_outlined),
      _MetricEntry(label: 'Hero Height', value: _heroHeight.toStringAsFixed(0), note: 'Primary demo card height.', icon: Icons.height_outlined),
      _MetricEntry(label: 'Hero Width Factor', value: _heroWidthFactor.toStringAsFixed(2), note: 'Primary demo card width ratio.', icon: Icons.width_normal_outlined),
      _MetricEntry(label: 'Theme Switches', value: '$_themeSwitchCount', note: 'Number of profile switches.', icon: Icons.color_lens_outlined),
      _MetricEntry(label: 'Scenario Switches', value: '$_scenarioSwitchCount', note: 'Number of lane changes.', icon: Icons.route_outlined),
      _MetricEntry(label: 'Clip Switches', value: '$_clipSwitchCount', note: 'Clip behavior changes.', icon: Icons.swap_horizontal_circle_outlined),
      _MetricEntry(label: 'Geometry Switches', value: '$_geometrySwitchCount', note: 'Geometry mode changes.', icon: Icons.change_circle_outlined),
      _MetricEntry(label: 'Hero Taps', value: '$_heroTapCount', note: 'Tap count on hero clipped card.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Gallery Taps', value: '$_galleryTapCount', note: 'Tap count on gallery tiles.', icon: Icons.grid_view_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Current interaction phase.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Last Clip Change', value: _lastClipChange, note: 'Last selected clip behavior.', icon: Icons.update_outlined),
      _MetricEntry(label: 'Last Tile Tap', value: _lastTileTap, note: 'Most recently tapped gallery tile.', icon: Icons.pin_drop_outlined),
    ];
  }

  void _resetStudio() {
    setState(() {
      _scenarioIndex = 0;
      _clipBehavior = Clip.antiAlias;
      _geometryMode = _ClipGeometryMode.uniform;
      _showGrid = true;
      _showOutline = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _animateBackdrop = true;
      _animateRadius = false;
      _nestedClip = true;
      _radiusValue = 28;
      _heroHeight = 240;
      _heroWidthFactor = 0.86;
      _asymmetry = 0.35;
      _textureDensity = 0.50;
      _panelPadding = 14;
      _themeSwitchCount = 0;
      _scenarioSwitchCount = 0;
      _clipSwitchCount = 0;
      _geometrySwitchCount = 0;
      _heroTapCount = 0;
      _galleryTapCount = 0;
      _phase = 'idle';
      _lastTileTap = 'none';
      _lastClipChange = 'antiAlias';
      _timeline = const <_TimelineEvent>[];
    });
    _animationController.repeat();
    _addTimeline('Reset', 'RenderClipRSuperellipse studio reset to defaults.');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeProfile profile = _themeProfiles[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: profile.seed,
      brightness: profile.brightness,
    );

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: profile.brightness),
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
                    constraints: const BoxConstraints(maxWidth: 1380),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildControlBoard(scheme),
                        const SizedBox(height: 16),
                        _buildHeroBoard(scheme),
                        const SizedBox(height: 16),
                        _buildClipBehaviorBoard(scheme),
                        const SizedBox(height: 16),
                        _buildRadiusGalleryBoard(scheme),
                        const SizedBox(height: 16),
                        _buildCustomClipperBoard(scheme),
                        const SizedBox(height: 16),
                        _buildNestedAnimationBoard(scheme),
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
                Icon(Icons.rounded_corner_outlined, color: scheme.primary, size: 26),
                Text(
                  'RenderClipRSuperellipse Visual Geometry Studio',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(
                    _scenarioLanes[_scenarioIndex].title,
                    style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Comprehensive visual demo for RenderClipRSuperellipse via ClipRSuperellipse: clip behaviors, radius studies, asymmetric clippers, nested composition, and animated transitions.',
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
              children: List<Widget>.generate(_themeProfiles.length, (int i) {
                final _ThemeProfile profile = _themeProfiles[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(profile.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = i;
                      _themeSwitchCount += 1;
                      _phase = 'theme';
                    });
                    _addTimeline('Theme', 'Theme switched to ${profile.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themeProfiles[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioLanes.length, (int i) {
                final _ScenarioLane lane = _scenarioLanes[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(lane.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = i;
                      _scenarioSwitchCount += 1;
                      _phase = 'scenario';
                    });
                    _addTimeline('Scenario', lane.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarioLanes[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Clip Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetStudio, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune ClipRSuperellipse behavior, geometry strategy, and shape dynamics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Clip.values.map((Clip value) {
                return ChoiceChip(
                  selected: _clipBehavior == value,
                  label: Text(value.name),
                  onSelected: (_) {
                    setState(() {
                      _clipBehavior = value;
                      _clipSwitchCount += 1;
                      _phase = 'clip';
                      _lastClipChange = value.name;
                    });
                    _addTimeline('Clip Behavior', 'Clip behavior changed to ${value.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _ClipGeometryMode.values.map(( _ClipGeometryMode mode) {
                return ChoiceChip(
                  selected: _geometryMode == mode,
                  label: Text(mode.name),
                  onSelected: (_) {
                    setState(() {
                      _geometryMode = mode;
                      _geometrySwitchCount += 1;
                      _phase = 'geometry';
                    });
                    _addTimeline('Geometry Mode', 'Geometry mode switched to ${mode.name}.');
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            _sliderRow(
              scheme: scheme,
              label: 'Base Radius',
              value: _radiusValue,
              min: 0,
              max: 80,
              divisions: 80,
              onChanged: (double v) => setState(() => _radiusValue = v),
              onChangeEnd: (double v) => _addTimeline('Radius', 'Base radius set to ${v.toStringAsFixed(1)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Hero Height',
              value: _heroHeight,
              min: 180,
              max: 360,
              divisions: 90,
              onChanged: (double v) => setState(() => _heroHeight = v),
              onChangeEnd: (double v) => _addTimeline('Hero Height', 'Hero height set to ${v.toStringAsFixed(0)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Hero Width Factor',
              value: _heroWidthFactor,
              min: 0.55,
              max: 1,
              divisions: 45,
              onChanged: (double v) => setState(() => _heroWidthFactor = v),
              onChangeEnd: (double v) => _addTimeline('Hero Width', 'Hero width factor set to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Asymmetry',
              value: _asymmetry,
              min: 0,
              max: 0.9,
              divisions: 90,
              onChanged: (double v) => setState(() => _asymmetry = v),
              onChangeEnd: (double v) => _addTimeline('Asymmetry', 'Asymmetry set to ${v.toStringAsFixed(2)}.'),
            ),
            _sliderRow(
              scheme: scheme,
              label: 'Texture Density',
              value: _textureDensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double v) => setState(() => _textureDensity = v),
              onChangeEnd: (double v) => _addTimeline('Texture', 'Texture density set to ${v.toStringAsFixed(2)}.'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => setState(() => _showGrid = v ?? true), child: const Text('Show backdrop grid')),
                CheckboxMenuButton(value: _showOutline, onChanged: (bool? v) => setState(() => _showOutline = v ?? true), child: const Text('Show clip outline')),
                CheckboxMenuButton(
                  value: _animateBackdrop,
                  onChanged: (bool? v) {
                    final bool next = v ?? true;
                    setState(() => _animateBackdrop = next);
                    if (next) {
                      _animationController.repeat();
                    } else {
                      _animationController.stop();
                    }
                    _addTimeline('Backdrop', next ? 'Backdrop animation enabled.' : 'Backdrop animation paused.');
                  },
                  child: const Text('Animate backdrop'),
                ),
                CheckboxMenuButton(value: _animateRadius, onChanged: (bool? v) => setState(() => _animateRadius = v ?? false), child: const Text('Animate radius')),
                CheckboxMenuButton(value: _nestedClip, onChanged: (bool? v) => setState(() => _nestedClip = v ?? true), child: const Text('Enable nested clip lane')),
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

  Widget _buildHeroBoard(ColorScheme scheme) {
    final double radius = _effectiveRadius();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hero Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Primary superellipse clip demo with optional custom geometry and live edge overlays.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double width = constraints.maxWidth * _heroWidthFactor;
                final Widget clipped = ClipRSuperellipse(
                  clipBehavior: _clipBehavior,
                  borderRadius: BorderRadius.circular(radius),
                  clipper: _geometryMode == _ClipGeometryMode.custom ? _AsymmetricSuperellipseClipper(baseRadius: radius, asymmetry: _asymmetry) : null,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _heroTapCount += 1;
                        _phase = 'hero-tap';
                      });
                      _addTimeline('Hero Tap', 'Hero card tapped with ${_clipBehavior.name} and ${_geometryMode.name}.');
                    },
                    child: SizedBox(
                      width: width,
                      height: _heroHeight,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[scheme.primary, scheme.tertiary, scheme.secondary],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          CustomPaint(painter: _TexturePainter(density: _textureDensity, seedColor: scheme.onPrimary.withValues(alpha: 0.16))),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.auto_awesome, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text('RenderClipRSuperellipse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.20), borderRadius: BorderRadius.circular(999)),
                                      child: Text(_clipBehavior.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text('Radius ${radius.toStringAsFixed(1)}  •  Geometry ${_geometryMode.name}', style: TextStyle(color: Colors.white.withValues(alpha: 0.92))),
                                const SizedBox(height: 8),
                                Text('Tap this card to log interactions and evaluate clipped boundary behavior.', style: TextStyle(color: Colors.white.withValues(alpha: 0.90))),
                                const Spacer(),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: <Widget>[
                                    _pill('clip: ${_clipBehavior.name}'),
                                    _pill('radius: ${radius.toStringAsFixed(1)}'),
                                    _pill('asymmetry: ${_asymmetry.toStringAsFixed(2)}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      clipped,
                      if (_showOutline)
                        IgnorePointer(
                          child: _OutlineOverlay(
                            width: width,
                            height: _heroHeight,
                            radius: radius,
                            asymmetry: _asymmetry,
                            geometryMode: _geometryMode,
                            color: scheme.onSurface.withValues(alpha: 0.42),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.24), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildClipBehaviorBoard(ColorScheme scheme) {
    final List<Clip> modes = <Clip>[Clip.none, Clip.hardEdge, Clip.antiAlias, Clip.antiAliasWithSaveLayer];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Clip Behavior Matrix', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Compare clipping strategies with identical content and shape parameters.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 860
                        ? 2
                        : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: modes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.4 : 1.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final Clip clip = modes[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(clip.name, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(_clipDescription(clip), style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ClipRSuperellipse(
                                clipBehavior: clip,
                                borderRadius: BorderRadius.circular(_effectiveRadius() * 0.75),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[scheme.primary, scheme.tertiary],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      CustomPaint(painter: _TexturePainter(density: _textureDensity * 0.86, seedColor: Colors.white.withValues(alpha: 0.24))),
                                      Center(
                                        child: Text('Clip.${clip.name}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _clipDescription(Clip clip) {
    switch (clip) {
      case Clip.none:
        return 'No clipping, shape metadata present but edges are not clipped.';
      case Clip.hardEdge:
        return 'Fast hard-edge clipping with no antialiasing smoothing.';
      case Clip.antiAlias:
        return 'Smoothed edge clipping. Typical default for UI quality.';
      case Clip.antiAliasWithSaveLayer:
        return 'Antialiased clipping plus saveLayer for complex blending.';
    }
  }

  Widget _buildRadiusGalleryBoard(ColorScheme scheme) {
    final List<double> radii = <double>[4, 10, 18, 28, 40, 56, 72];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Radius Study Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Small multiples illustrating curvature progression as radius increases.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 900
                        ? 3
                        : constraints.maxWidth > 580
                            ? 2
                            : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: radii.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.4 : 1.26,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final double radius = radii[index];
                    final _GalleryTile tile = _galleryTiles[index % _galleryTiles.length];
                    return _radiusTile(scheme, tile, radius);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _radiusTile(ColorScheme scheme, _GalleryTile tile, double radius) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('${tile.label}  r=${radius.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700))),
                Icon(Icons.rounded_corner_outlined, color: scheme.primary, size: 18),
              ],
            ),
            const SizedBox(height: 4),
            Text(tile.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _galleryTapCount += 1;
                    _lastTileTap = '${tile.label}-${radius.toStringAsFixed(0)}';
                    _phase = 'gallery-tap';
                  });
                  _addTimeline('Gallery Tap', 'Tapped ${tile.label} at radius ${radius.toStringAsFixed(0)}.');
                },
                child: ClipRSuperellipse(
                  clipBehavior: _clipBehavior,
                  borderRadius: BorderRadius.circular(radius),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[tile.colorA, tile.colorB],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CustomPaint(painter: _TexturePainter(density: _textureDensity * 0.72, seedColor: Colors.white.withValues(alpha: 0.21))),
                        Center(child: Text(tile.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
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

  Widget _buildCustomClipperBoard(ColorScheme scheme) {
    final double base = _effectiveRadius();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Custom Clipper Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Asymmetric corner definitions using CustomClipper<RSuperellipse>.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 940;
                final Widget left = _customClipCard(
                  scheme: scheme,
                  title: 'Asymmetric Corners',
                  subtitle: 'Top-left and bottom-right emphasized.',
                  clipper: _AsymmetricSuperellipseClipper(baseRadius: base, asymmetry: _asymmetry),
                  gradient: <Color>[const Color(0xFF22C55E), const Color(0xFF0EA5E9)],
                );
                final Widget right = _customClipCard(
                  scheme: scheme,
                  title: 'Inverted Asymmetry',
                  subtitle: 'Opposite corners emphasized for contrast.',
                  clipper: _InvertedAsymmetricSuperellipseClipper(baseRadius: base, asymmetry: _asymmetry),
                  gradient: <Color>[const Color(0xFFFB7185), const Color(0xFFF97316)],
                );
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

  Widget _customClipCard({
    required ColorScheme scheme,
    required String title,
    required String subtitle,
    required CustomClipper<RSuperellipse> clipper,
    required List<Color> gradient,
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
            SizedBox(
              height: 180,
              child: ClipRSuperellipse(
                clipBehavior: _clipBehavior,
                clipper: clipper,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CustomPaint(painter: _TexturePainter(density: _textureDensity * 0.8, seedColor: Colors.white.withValues(alpha: 0.24))),
                      Center(child: Text('CustomClipper<RSuperellipse>', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
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

  Widget _buildNestedAnimationBoard(ColorScheme scheme) {
    final double radius = _effectiveRadius();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nested and Animated Clips', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Nested clip stacks and animated radius transitions for compositional scenarios.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget nested = DecoratedBox(
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
                        Text('Nested Clips', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text('Inner card clipped independently inside an outer superellipse frame.', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 190,
                          child: Center(
                            child: ClipRSuperellipse(
                              clipBehavior: _clipBehavior,
                              borderRadius: BorderRadius.circular(radius),
                              child: Container(
                                width: 280,
                                height: 180,
                                color: scheme.primary.withValues(alpha: 0.90),
                                child: Center(
                                  child: _nestedClip
                                      ? ClipRSuperellipse(
                                          clipBehavior: _clipBehavior,
                                          borderRadius: BorderRadius.circular(radius * 0.56),
                                          child: Container(
                                            width: 180,
                                            height: 110,
                                            color: scheme.tertiary.withValues(alpha: 0.92),
                                            alignment: Alignment.center,
                                            child: const Text('Inner clip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                          ),
                                        )
                                      : Container(
                                          width: 180,
                                          height: 110,
                                          color: scheme.tertiary.withValues(alpha: 0.92),
                                          alignment: Alignment.center,
                                          child: const Text('Inner clip off', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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

                final Widget animated = DecoratedBox(
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
                        Text('Animated Radius', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text('Toggle radius animation to inspect edge behavior under continuous shape changes.', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 190,
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (BuildContext context, Widget? child) {
                              final double wave = (math.sin(_animationController.value * math.pi * 2) + 1) / 2;
                              final double animatedRadius = _animateRadius ? 8 + wave * 72 : _radiusValue;
                              return Center(
                                child: ClipRSuperellipse(
                                  clipBehavior: _clipBehavior,
                                  borderRadius: BorderRadius.circular(animatedRadius),
                                  child: Container(
                                    width: 280,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[scheme.secondary, scheme.primary],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'r=${animatedRadius.toStringAsFixed(1)}',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                if (narrow) {
                  return Column(children: <Widget>[nested, const SizedBox(height: 10), animated]);
                }
                return Row(children: <Widget>[Expanded(child: nested), const SizedBox(width: 10), Expanded(child: animated)]);
              },
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
                    childAspectRatio: columns == 1 ? 2.7 : 1.95,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricEntry metric = metrics[index];
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
                                Icon(metric.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(metric.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(metric.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontSize: 15, fontWeight: FontWeight.w800)),
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
            Text('theme=${_themeProfiles[_themeIndex].id} scenario=${_scenarioLanes[_scenarioIndex].id}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('clipBehavior=${_clipBehavior.name} geometryMode=${_geometryMode.name} radius=${_effectiveRadius().toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('heroHeight=${_heroHeight.toStringAsFixed(0)} heroWidthFactor=${_heroWidthFactor.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('asymmetry=${_asymmetry.toStringAsFixed(2)} texture=${_textureDensity.toStringAsFixed(2)} nestedClip=$_nestedClip', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('showGrid=$_showGrid showOutline=$_showOutline animateBackdrop=$_animateBackdrop animateRadius=$_animateRadius', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches theme=$_themeSwitchCount scenario=$_scenarioSwitchCount clip=$_clipSwitchCount geometry=$_geometrySwitchCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('heroTap=$_heroTapCount galleryTap=$_galleryTapCount phase=$_phase lastTile=$_lastTileTap', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological event log for clip changes, taps, and geometry updates.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                child: Text('Timeline is empty. Interact with controls to generate events.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _TexturePainter extends CustomPainter {
  _TexturePainter({required this.density, required this.seedColor});

  final double density;
  final Color seedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = seedColor
      ..strokeWidth = 1.1;
    final double step = (24 - (density * 16)).clamp(6, 24);
    for (double x = -size.height; x < size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TexturePainter oldDelegate) {
    return oldDelegate.density != density || oldDelegate.seedColor != seedColor;
  }
}

class _AsymmetricSuperellipseClipper extends CustomClipper<RSuperellipse> {
  _AsymmetricSuperellipseClipper({required this.baseRadius, required this.asymmetry});

  final double baseRadius;
  final double asymmetry;

  @override
  RSuperellipse getClip(Size size) {
    final Rect rect = Offset.zero & size;
    final double delta = baseRadius * asymmetry;
    return RSuperellipse.fromRectAndCorners(
      rect,
      topLeft: Radius.circular((baseRadius + delta).clamp(0, 120)),
      topRight: Radius.circular((baseRadius - delta * 0.5).clamp(0, 120)),
      bottomRight: Radius.circular((baseRadius + delta * 0.8).clamp(0, 120)),
      bottomLeft: Radius.circular((baseRadius - delta).clamp(0, 120)),
    );
  }

  @override
  bool shouldReclip(covariant _AsymmetricSuperellipseClipper oldClipper) {
    return oldClipper.baseRadius != baseRadius || oldClipper.asymmetry != asymmetry;
  }
}

class _InvertedAsymmetricSuperellipseClipper extends CustomClipper<RSuperellipse> {
  _InvertedAsymmetricSuperellipseClipper({required this.baseRadius, required this.asymmetry});

  final double baseRadius;
  final double asymmetry;

  @override
  RSuperellipse getClip(Size size) {
    final Rect rect = Offset.zero & size;
    final double delta = baseRadius * asymmetry;
    return RSuperellipse.fromRectAndCorners(
      rect,
      topLeft: Radius.circular((baseRadius - delta).clamp(0, 120)),
      topRight: Radius.circular((baseRadius + delta).clamp(0, 120)),
      bottomRight: Radius.circular((baseRadius - delta * 0.5).clamp(0, 120)),
      bottomLeft: Radius.circular((baseRadius + delta * 0.8).clamp(0, 120)),
    );
  }

  @override
  bool shouldReclip(covariant _InvertedAsymmetricSuperellipseClipper oldClipper) {
    return oldClipper.baseRadius != baseRadius || oldClipper.asymmetry != asymmetry;
  }
}

class _OutlineOverlay extends StatelessWidget {
  const _OutlineOverlay({
    required this.width,
    required this.height,
    required this.radius,
    required this.asymmetry,
    required this.geometryMode,
    required this.color,
  });

  final double width;
  final double height;
  final double radius;
  final double asymmetry;
  final _ClipGeometryMode geometryMode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final CustomClipper<RSuperellipse>? clipper = switch (geometryMode) {
      _ClipGeometryMode.uniform => null,
      _ClipGeometryMode.asymmetric => _AsymmetricSuperellipseClipper(baseRadius: radius, asymmetry: asymmetry),
      _ClipGeometryMode.custom => _InvertedAsymmetricSuperellipseClipper(baseRadius: radius, asymmetry: asymmetry),
    };

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _SuperellipseOutlinePainter(
          radius: radius,
          color: color,
          clipper: clipper,
        ),
      ),
    );
  }
}

class _SuperellipseOutlinePainter extends CustomPainter {
  _SuperellipseOutlinePainter({required this.radius, required this.color, required this.clipper});

  final double radius;
  final Color color;
  final CustomClipper<RSuperellipse>? clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outline = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final RSuperellipse shape = clipper?.getClip(size) ?? RSuperellipse.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));
    final Path path = Path()..addRSuperellipse(shape);
    canvas.drawPath(path, outline);
  }

  @override
  bool shouldRepaint(covariant _SuperellipseOutlinePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color || oldDelegate.clipper != clipper;
  }
}

