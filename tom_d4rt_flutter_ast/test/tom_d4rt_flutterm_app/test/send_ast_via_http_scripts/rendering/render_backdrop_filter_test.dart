import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'glacier',
    name: 'Glacier Studio',
    description: 'Bright high-contrast profile for blur comparison and edge readability.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'sunset',
    name: 'Sunset Lab',
    description: 'Warm palette for blend-mode emphasis and layered gradients.',
    seed: Color(0xFFEA580C),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Deck',
    description: 'Dark profile that makes frosted overlay effects very obvious.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'forest',
    name: 'Forest Console',
    description: 'Balanced profile suitable for long tuning sessions.',
    seed: Color(0xFF15803D),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioPreset> _scenarios = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'gallery',
    title: 'Frosted Gallery',
    subtitle: 'Multiple cards compare blur strengths and tint overlays over one backdrop.',
  ),
  _ScenarioPreset(
    id: 'blend',
    title: 'Blend Observatory',
    subtitle: 'Interactive blend mode changes on active blur windows.',
  ),
  _ScenarioPreset(
    id: 'motion',
    title: 'Motion Corridor',
    subtitle: 'Animated backdrop demonstrates temporal blur perception.',
  ),
  _ScenarioPreset(
    id: 'bounds',
    title: 'Bounds Lab',
    subtitle: 'Clip and size controls show filtering region effects and costs.',
  ),
  _ScenarioPreset(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Metrics, diagnostics and timeline for reproducible tuning.',
  ),
];

const List<_BlurPreset> _blurPresets = <_BlurPreset>[
  _BlurPreset(label: 'Light', sigmaX: 3, sigmaY: 3, note: 'Subtle frosted effect.'),
  _BlurPreset(label: 'Balanced', sigmaX: 8, sigmaY: 8, note: 'General-purpose glass effect.'),
  _BlurPreset(label: 'Heavy', sigmaX: 14, sigmaY: 14, note: 'Strong blur for modal emphasis.'),
  _BlurPreset(label: 'Wide X', sigmaX: 16, sigmaY: 5, note: 'Directional blur emphasizing horizontal smear.'),
  _BlurPreset(label: 'Wide Y', sigmaX: 5, sigmaY: 16, note: 'Directional blur emphasizing vertical smear.'),
];

const List<_BlendPreset> _blendPresets = <_BlendPreset>[
  _BlendPreset(label: 'SrcOver', mode: BlendMode.srcOver, note: 'Default compositing behavior.'),
  _BlendPreset(label: 'Screen', mode: BlendMode.screen, note: 'Brightens overlays while preserving highlights.'),
  _BlendPreset(label: 'Multiply', mode: BlendMode.multiply, note: 'Darkens and enriches dense backgrounds.'),
  _BlendPreset(label: 'Overlay', mode: BlendMode.overlay, note: 'Boosts contrast with mixed bright/dark regions.'),
  _BlendPreset(label: 'Plus', mode: BlendMode.plus, note: 'Additive blend useful for glow-like panels.'),
];

const List<_ClipPreset> _clipPresets = <_ClipPreset>[
  _ClipPreset(label: 'None', value: Clip.none, note: 'No clipping around filter region.'),
  _ClipPreset(label: 'HardEdge', value: Clip.hardEdge, note: 'Fast rectangular clipping.'),
  _ClipPreset(label: 'AntiAlias', value: Clip.antiAlias, note: 'Smoothed clip boundary.'),
  _ClipPreset(label: 'SaveLayer', value: Clip.antiAliasWithSaveLayer, note: 'Highest fidelity with extra compositing cost.'),
];

const List<String> _guideBullets = <String>[
  'BackdropFilter applies an ImageFilter to already-painted content behind its child.',
  'RenderBackdropFilter is the render layer behind this behavior and can be expensive for large regions.',
  'Use ClipRect or constrained bounds to keep filtered areas tight and predictable.',
  'Tune sigma values for readability; very high blur can flatten visual hierarchy.',
  'Evaluate blendMode against your palette because each mode changes contrast differently.',
  'Prefer isolated blur panes instead of full-screen blur unless absolutely necessary.',
  'Combine subtle tint with blur to build legible frosted surfaces over vivid backdrops.',
  'Test animation scenarios because moving backgrounds can amplify perceived blur cost.',
  'Keep diagnostics counters while tuning to track state and interaction changes.',
  'When demos must run cross-platform, provide fallback visuals that still teach behavior.',
];

const List<_FaqEntry> _faq = <_FaqEntry>[
  _FaqEntry(
    question: 'What does BackdropFilter blur exactly?',
    answer: 'It blurs content already painted behind the filter region, not the child itself.',
  ),
  _FaqEntry(
    question: 'Why clip blur regions?',
    answer: 'Without clipping, the filtered layer can cover larger areas than intended and cost more.',
  ),
  _FaqEntry(
    question: 'Should I animate sigma values?',
    answer: 'You can, but test carefully because frequent large-kernel blur updates can be costly.',
  ),
  _FaqEntry(
    question: 'How is this different from ImageFiltered?',
    answer: 'ImageFiltered filters its child, while BackdropFilter filters content behind the child.',
  ),
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

class _ScenarioPreset {
  const _ScenarioPreset({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _BlurPreset {
  const _BlurPreset({required this.label, required this.sigmaX, required this.sigmaY, required this.note});

  final String label;
  final double sigmaX;
  final double sigmaY;
  final String note;
}

class _BlendPreset {
  const _BlendPreset({required this.label, required this.mode, required this.note});

  final String label;
  final BlendMode mode;
  final String note;
}

class _ClipPreset {
  const _ClipPreset({required this.label, required this.value, required this.note});

  final String label;
  final Clip value;
  final String note;
}

class _FaqEntry {
  const _FaqEntry({required this.question, required this.answer});

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

class _GallerySpec {
  const _GallerySpec({
    required this.title,
    required this.blur,
    required this.blend,
    required this.tint,
    required this.note,
  });

  final String title;
  final _BlurPreset blur;
  final _BlendPreset blend;
  final Color tint;
  final String note;
}

dynamic build(BuildContext context) {
  return const _RenderBackdropFilterStudio();
}

class _RenderBackdropFilterStudio extends StatefulWidget {
  const _RenderBackdropFilterStudio();

  @override
  State<_RenderBackdropFilterStudio> createState() => _RenderBackdropFilterStudioState();
}

class _RenderBackdropFilterStudioState extends State<_RenderBackdropFilterStudio> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _motionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 7600),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _activeBlurIndex = 1;
  int _activeBlendIndex = 0;
  int _clipIndex = 1;

  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showColorBand = true;
  bool _enableMotion = true;
  bool _enableTint = true;

  double _sigmaX = 8;
  double _sigmaY = 8;
  double _panelWidth = 430;
  double _panelHeight = 240;
  double _cornerRadius = 20;
  double _tintOpacity = 0.22;
  double _overlayOpacity = 0.20;

  int _blurSwitchCount = 0;
  int _blendSwitchCount = 0;
  int _clipSwitchCount = 0;
  int _presetApplyCount = 0;
  int _hostTapCount = 0;
  int _galleryTapCount = 0;
  int _motionToggleCount = 0;

  String _phaseLabel = 'steady';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  @override
  void initState() {
    super.initState();
    _applyBlurPreset(_blurPresets[_activeBlurIndex], silent: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderBackdropFilter Glass Optics Studio initialized.');
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

  void _applyBlurPreset(_BlurPreset preset, {bool silent = false}) {
    setState(() {
      _sigmaX = preset.sigmaX;
      _sigmaY = preset.sigmaY;
      _phaseLabel = 'preset';
    });
    if (!silent) {
      _presetApplyCount += 1;
      _pushTimeline('Blur Preset', '${preset.label} (${preset.sigmaX.toStringAsFixed(1)}, ${preset.sigmaY.toStringAsFixed(1)}) applied.');
    }
  }

  void _resetConsole() {
    setState(() {
      _scenarioIndex = 0;
      _activeBlurIndex = 1;
      _activeBlendIndex = 0;
      _clipIndex = 1;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showColorBand = true;
      _enableMotion = true;
      _enableTint = true;
      _panelWidth = 430;
      _panelHeight = 240;
      _cornerRadius = 20;
      _tintOpacity = 0.22;
      _overlayOpacity = 0.20;
      _blurSwitchCount = 0;
      _blendSwitchCount = 0;
      _clipSwitchCount = 0;
      _presetApplyCount = 0;
      _hostTapCount = 0;
      _galleryTapCount = 0;
      _motionToggleCount = 0;
      _phaseLabel = 'steady';
      _timeline = const <_TimelineEvent>[];
    });
    _applyBlurPreset(_blurPresets[_activeBlurIndex], silent: true);
    _pushTimeline('Reset', 'BackdropFilter controls reset to baseline.');
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Current exploration lane.', icon: Icons.dashboard_customize_outlined),
      _MetricEntry(label: 'Theme', value: _themes[_themeIndex].name, note: 'Active color profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'SigmaX', value: _sigmaX.toStringAsFixed(1), note: 'Horizontal blur kernel.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'SigmaY', value: _sigmaY.toStringAsFixed(1), note: 'Vertical blur kernel.', icon: Icons.swap_vert_outlined),
      _MetricEntry(label: 'Blend', value: _blendPresets[_activeBlendIndex].label, note: _blendPresets[_activeBlendIndex].note, icon: Icons.layers_outlined),
      _MetricEntry(label: 'Clip', value: _clipPresets[_clipIndex].label, note: _clipPresets[_clipIndex].note, icon: Icons.crop_outlined),
      _MetricEntry(label: 'Panel', value: '${_panelWidth.toStringAsFixed(0)} x ${_panelHeight.toStringAsFixed(0)}', note: 'Primary glass panel dimensions.', icon: Icons.aspect_ratio_outlined),
      _MetricEntry(label: 'Radius', value: _cornerRadius.toStringAsFixed(0), note: 'Rounded clip curvature.', icon: Icons.rounded_corner),
      _MetricEntry(label: 'Tint', value: _tintOpacity.toStringAsFixed(2), note: 'Foreground glass tint opacity.', icon: Icons.opacity_outlined),
      _MetricEntry(label: 'Overlay', value: _overlayOpacity.toStringAsFixed(2), note: 'Animated background overlay intensity.', icon: Icons.gradient_outlined),
      _MetricEntry(label: 'Phase', value: _phaseLabel, note: 'Current interaction phase marker.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Blur Switches', value: '$_blurSwitchCount', note: 'Blur profile changes.', icon: Icons.blur_on_outlined),
      _MetricEntry(label: 'Blend Switches', value: '$_blendSwitchCount', note: 'Blend mode changes.', icon: Icons.compare_arrows_outlined),
      _MetricEntry(label: 'Clip Switches', value: '$_clipSwitchCount', note: 'Clip behavior changes.', icon: Icons.content_cut_outlined),
      _MetricEntry(label: 'Preset Uses', value: '$_presetApplyCount', note: 'Preset apply count.', icon: Icons.bookmark_added_outlined),
      _MetricEntry(label: 'Host Taps', value: '$_hostTapCount', note: 'Main panel interaction count.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Gallery Taps', value: '$_galleryTapCount', note: 'Gallery card tap count.', icon: Icons.grid_view_outlined),
      _MetricEntry(label: 'Motion Toggles', value: '$_motionToggleCount', note: 'Animated backdrop mode switches.', icon: Icons.motion_photos_on_outlined),
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
                        _buildPrimaryDeck(scheme),
                        const SizedBox(height: 16),
                        _buildGalleryBoard(scheme),
                        const SizedBox(height: 16),
                        _buildBlendObservatory(scheme),
                        const SizedBox(height: 16),
                        _buildBoundsLab(scheme),
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
                Icon(Icons.blur_on_outlined, color: scheme.primary, size: 26),
                Text(
                  'RenderBackdropFilter Glass Optics Studio',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual deep demo visualizing BackdropFilter behavior through blur presets, blend modes, animated backdrops, bounds tuning, and operational diagnostics.',
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
                final _ThemePreset p = _themes[i];
                return ChoiceChip(
                  selected: _themeIndex == i,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() => _themeIndex = i);
                    _pushTimeline('Theme', 'Switched to ${p.name}.');
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
                final _ScenarioPreset s = _scenarios[i];
                return FilterChip(
                  selected: _scenarioIndex == i,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() => _scenarioIndex = i);
                    _pushTimeline('Scenario', s.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarios[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _showGrid,
                  onChanged: (bool? v) => setState(() => _showGrid = v ?? true),
                  child: const Text('Show background grid'),
                ),
                CheckboxMenuButton(
                  value: _showColorBand,
                  onChanged: (bool? v) => setState(() => _showColorBand = v ?? true),
                  child: const Text('Show color bands'),
                ),
                CheckboxMenuButton(
                  value: _enableMotion,
                  onChanged: (bool? v) {
                    setState(() => _enableMotion = v ?? true);
                    _motionToggleCount += 1;
                    if (_enableMotion) {
                      _motionController.repeat();
                    } else {
                      _motionController.stop();
                    }
                    _pushTimeline('Motion', _enableMotion ? 'Animated backdrop enabled.' : 'Animated backdrop paused.');
                  },
                  child: const Text('Enable motion'),
                ),
                CheckboxMenuButton(
                  value: _showDiagnostics,
                  onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true),
                  child: const Text('Show diagnostics'),
                ),
                CheckboxMenuButton(
                  value: _showGuide,
                  onChanged: (bool? v) => setState(() => _showGuide = v ?? true),
                  child: const Text('Show guide'),
                ),
                CheckboxMenuButton(
                  value: _showTimeline,
                  onChanged: (bool? v) => setState(() => _showTimeline = v ?? true),
                  child: const Text('Show timeline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryDeck(ColorScheme scheme) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 1040;
        final Widget stage = _buildMainStage(scheme);
        final Widget controls = _buildControlConsole(scheme);
        if (narrow) {
          return Column(
            children: <Widget>[stage, const SizedBox(height: 12), controls],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: stage),
            const SizedBox(width: 12),
            Expanded(flex: 5, child: controls),
          ],
        );
      },
    );
  }

  Widget _buildMainStage(ColorScheme scheme) {
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY);
    final BlendMode mode = _blendPresets[_activeBlendIndex].mode;

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
                Text('Main Blur Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetConsole, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Interactive glass panel over a layered animated backdrop. Tap inside panel to record interaction events.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_cornerRadius),
                clipBehavior: _clipPresets[_clipIndex].value,
                child: Container(
                  width: _panelWidth,
                  height: _panelHeight,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(_cornerRadius),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: _AnimatedBackdropCanvas(controller: _motionController, showGrid: _showGrid, showBands: _showColorBand, overlayOpacity: _overlayOpacity)),
                      Positioned.fill(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _hostTapCount += 1;
                                _phaseLabel = 'tap';
                              });
                              _pushTimeline('Panel Tap', 'Main blur panel tapped at sigma ${_sigmaX.toStringAsFixed(1)} / ${_sigmaY.toStringAsFixed(1)}.');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(_cornerRadius * 0.8),
                              clipBehavior: _clipPresets[_clipIndex].value,
                              child: BackdropFilter(
                                filter: filter,
                                blendMode: mode,
                                child: Container(
                                  width: _panelWidth * 0.74,
                                  height: _panelHeight * 0.66,
                                  decoration: BoxDecoration(
                                    color: _enableTint ? Colors.white.withValues(alpha: _tintOpacity) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(_cornerRadius * 0.8),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('BackdropFilter Panel', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                                        const SizedBox(height: 6),
                                        Text('sigmaX ${_sigmaX.toStringAsFixed(1)}  sigmaY ${_sigmaY.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                                        Text('blend ${_blendPresets[_activeBlendIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                                        const Spacer(),
                                        Text('tap count $_hostTapCount', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(top: 10, left: 10, child: _chip(scheme, 'phase $_phaseLabel', Icons.flag_circle_outlined)),
                      Positioned(top: 10, right: 10, child: _chip(scheme, _blendPresets[_activeBlendIndex].label, Icons.layers_outlined)),
                      Positioned(bottom: 10, right: 10, child: _chip(scheme, _clipPresets[_clipIndex].label, Icons.crop_outlined)),
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

  Widget _chip(ColorScheme scheme, String label, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

  Widget _buildControlConsole(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Control Console', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Tune blur kernels, blending, geometry, and clipping to inspect RenderBackdropFilter behavior.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            _slider(
              scheme: scheme,
              label: 'Sigma X',
              value: _sigmaX,
              min: 0,
              max: 24,
              divisions: 96,
              onChanged: (double value) {
                setState(() {
                  _sigmaX = value;
                  _phaseLabel = 'tuning';
                });
              },
              onChangeEnd: (double value) => _pushTimeline('Sigma', 'SigmaX tuned to ${value.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Sigma Y',
              value: _sigmaY,
              min: 0,
              max: 24,
              divisions: 96,
              onChanged: (double value) {
                setState(() {
                  _sigmaY = value;
                  _phaseLabel = 'tuning';
                });
              },
              onChangeEnd: (double value) => _pushTimeline('Sigma', 'SigmaY tuned to ${value.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Panel Width',
              value: _panelWidth,
              min: 280,
              max: 700,
              divisions: 84,
              onChanged: (double value) => setState(() => _panelWidth = value),
              onChangeEnd: (double value) => _pushTimeline('Geometry', 'Panel width set to ${value.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Panel Height',
              value: _panelHeight,
              min: 170,
              max: 420,
              divisions: 50,
              onChanged: (double value) => setState(() => _panelHeight = value),
              onChangeEnd: (double value) => _pushTimeline('Geometry', 'Panel height set to ${value.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Corner Radius',
              value: _cornerRadius,
              min: 0,
              max: 44,
              divisions: 44,
              onChanged: (double value) => setState(() => _cornerRadius = value),
              onChangeEnd: (double value) => _pushTimeline('Clip', 'Corner radius set to ${value.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Tint Opacity',
              value: _tintOpacity,
              min: 0,
              max: 0.55,
              divisions: 55,
              onChanged: (double value) => setState(() => _tintOpacity = value),
              onChangeEnd: (double value) => _pushTimeline('Tint', 'Tint opacity set to ${value.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Overlay Opacity',
              value: _overlayOpacity,
              min: 0,
              max: 0.45,
              divisions: 45,
              onChanged: (double value) => setState(() => _overlayOpacity = value),
              onChangeEnd: (double value) => _pushTimeline('Backdrop', 'Overlay opacity set to ${value.toStringAsFixed(2)}.'),
            ),
            const Divider(height: 22),
            Text('Blur Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_blurPresets.length, (int i) {
                final _BlurPreset p = _blurPresets[i];
                return ChoiceChip(
                  selected: _activeBlurIndex == i,
                  label: Text(p.label),
                  onSelected: (_) {
                    setState(() {
                      _activeBlurIndex = i;
                      _blurSwitchCount += 1;
                    });
                    _applyBlurPreset(p);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_blurPresets[_activeBlurIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Blend Modes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_blendPresets.length, (int i) {
                final _BlendPreset b = _blendPresets[i];
                return ChoiceChip(
                  selected: _activeBlendIndex == i,
                  label: Text(b.label),
                  onSelected: (_) {
                    setState(() {
                      _activeBlendIndex = i;
                      _blendSwitchCount += 1;
                      _phaseLabel = 'blend';
                    });
                    _pushTimeline('Blend', 'Blend mode switched to ${b.label}.');
                  },
                );
              }),
            ),
            const Divider(height: 22),
            Text('Clip Behavior', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_clipPresets.length, (int i) {
                final _ClipPreset c = _clipPresets[i];
                return ChoiceChip(
                  selected: _clipIndex == i,
                  label: Text(c.label),
                  onSelected: (_) {
                    setState(() {
                      _clipIndex = i;
                      _clipSwitchCount += 1;
                    });
                    _pushTimeline('Clip', 'Clip behavior switched to ${c.label}.');
                  },
                );
              }),
            ),
            const Divider(height: 22),
            SwitchListTile(
              value: _enableTint,
              title: const Text('Enable tint inside glass'),
              onChanged: (bool value) => setState(() => _enableTint = value),
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

  Widget _buildGalleryBoard(ColorScheme scheme) {
    final List<_GallerySpec> specs = <_GallerySpec>[
      _GallerySpec(
        title: 'Subtle Card',
        blur: _blurPresets[0],
        blend: _blendPresets[0],
        tint: scheme.primaryContainer.withValues(alpha: 0.30),
        note: 'Light blur for readable content panes.',
      ),
      _GallerySpec(
        title: 'Modal Card',
        blur: _blurPresets[2],
        blend: _blendPresets[1],
        tint: scheme.secondaryContainer.withValues(alpha: 0.30),
        note: 'Heavier blur suitable for modal foregrounds.',
      ),
      _GallerySpec(
        title: 'Directional X',
        blur: _blurPresets[3],
        blend: _blendPresets[3],
        tint: scheme.tertiaryContainer.withValues(alpha: 0.35),
        note: 'Directional blur can support stylized motion surfaces.',
      ),
      _GallerySpec(
        title: 'Directional Y',
        blur: _blurPresets[4],
        blend: _blendPresets[2],
        tint: scheme.primaryContainer.withValues(alpha: 0.35),
        note: 'Vertical spread useful for columnar visual effects.',
      ),
    ];

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Frosted Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Reusable card examples showing different blur + blend + tint profiles over one shared backdrop.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: specs.map(( _GallerySpec spec) {
                return SizedBox(
                  width: 318,
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
                          Row(
                            children: <Widget>[
                              Text(spec.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _sigmaX = spec.blur.sigmaX;
                                    _sigmaY = spec.blur.sigmaY;
                                    _activeBlendIndex = _blendPresets.indexOf(spec.blend);
                                    _phaseLabel = 'gallery';
                                    _galleryTapCount += 1;
                                  });
                                  _pushTimeline('Gallery Apply', '${spec.title} profile applied to main panel.');
                                },
                                child: const Text('Apply'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: _clipPresets[_clipIndex].value,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: _AnimatedBackdropCanvas(
                                      controller: _motionController,
                                      showGrid: _showGrid,
                                      showBands: true,
                                      overlayOpacity: _overlayOpacity,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ui.ImageFilter.blur(sigmaX: spec.blur.sigmaX, sigmaY: spec.blur.sigmaY),
                                          blendMode: spec.blend.mode,
                                          child: Container(
                                            width: 186,
                                            height: 106,
                                            decoration: BoxDecoration(
                                              color: spec.tint,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.white.withValues(alpha: 0.58)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(spec.blur.label, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                                                  const Spacer(),
                                                  Text(spec.blend.label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(spec.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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

  Widget _buildBlendObservatory(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Blend Observatory', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Directly compare blend modes with identical blur kernels to observe contrast and color interaction shifts.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            SizedBox(
              height: 215,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _blendPresets.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  final _BlendPreset preset = _blendPresets[index];
                  final bool selected = _activeBlendIndex == index;
                  return SizedBox(
                    width: 250,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: selected ? scheme.secondaryContainer.withValues(alpha: 0.35) : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant, width: selected ? 2 : 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: Text(preset.label, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700))),
                                IconButton(
                                  icon: const Icon(Icons.playlist_add_check),
                                  onPressed: () {
                                    setState(() {
                                      _activeBlendIndex = index;
                                      _blendSwitchCount += 1;
                                      _phaseLabel = 'blend';
                                    });
                                    _pushTimeline('Blend Apply', '${preset.label} set as active blend mode.');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                clipBehavior: _clipPresets[_clipIndex].value,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: _AnimatedBackdropCanvas(
                                        controller: _motionController,
                                        showGrid: _showGrid,
                                        showBands: true,
                                        overlayOpacity: _overlayOpacity,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ui.ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                                            blendMode: preset.mode,
                                            child: Container(
                                              width: 142,
                                              height: 88,
                                              decoration: BoxDecoration(
                                                color: _enableTint ? Colors.white.withValues(alpha: _tintOpacity) : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.white.withValues(alpha: 0.58)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(preset.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
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
  }

  Widget _buildBoundsLab(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Bounds and Clip Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Three lanes show how filter region size influences visual result and expected cost.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1080;
                final List<Widget> lanes = <Widget>[
                  _boundsLane(
                    scheme: scheme,
                    title: 'Compact Pane',
                    width: 150,
                    height: 96,
                    note: 'Small blur region generally cheaper and highly focused.',
                  ),
                  _boundsLane(
                    scheme: scheme,
                    title: 'Balanced Pane',
                    width: 220,
                    height: 128,
                    note: 'Typical card size for frosted overlays in dashboard layouts.',
                  ),
                  _boundsLane(
                    scheme: scheme,
                    title: 'Large Pane',
                    width: 290,
                    height: 170,
                    note: 'Large region increases effect but can raise compositing cost.',
                  ),
                ];
                if (narrow) {
                  return Column(
                    children: <Widget>[
                      lanes[0],
                      const SizedBox(height: 10),
                      lanes[1],
                      const SizedBox(height: 10),
                      lanes[2],
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: lanes[0]),
                    const SizedBox(width: 10),
                    Expanded(child: lanes[1]),
                    const SizedBox(width: 10),
                    Expanded(child: lanes[2]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _boundsLane({required ColorScheme scheme, required String title, required double width, required double height, required String note}) {
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
            const SizedBox(height: 8),
            SizedBox(
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: _clipPresets[_clipIndex].value,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: _AnimatedBackdropCanvas(
                        controller: _motionController,
                        showGrid: _showGrid,
                        showBands: _showColorBand,
                        overlayOpacity: _overlayOpacity,
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: _clipPresets[_clipIndex].value,
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                            blendMode: _blendPresets[_activeBlendIndex].mode,
                            child: Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                color: _enableTint ? Colors.white.withValues(alpha: _tintOpacity) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                              ),
                              alignment: Alignment.center,
                              child: Text('${width.toStringAsFixed(0)} x ${height.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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
            Text('theme=${_themes[_themeIndex].id} scenario=${_scenarios[_scenarioIndex].id} phase=$_phaseLabel', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('sigma=(${_sigmaX.toStringAsFixed(1)}, ${_sigmaY.toStringAsFixed(1)}) blend=${_blendPresets[_activeBlendIndex].label} clip=${_clipPresets[_clipIndex].label}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('panel=${_panelWidth.toStringAsFixed(0)}x${_panelHeight.toStringAsFixed(0)} radius=${_cornerRadius.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('tint=$_enableTint tintOpacity=${_tintOpacity.toStringAsFixed(2)} overlay=${_overlayOpacity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('grid=$_showGrid bands=$_showColorBand motion=$_enableMotion', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('hostTaps=$_hostTapCount galleryTaps=$_galleryTapCount presetUses=$_presetApplyCount', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological event stream for filter tuning and interaction changes.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                child: Text('Timeline is empty. Interact with controls to populate logs.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
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

class _AnimatedBackdropCanvas extends StatelessWidget {
  const _AnimatedBackdropCanvas({
    required this.controller,
    required this.showGrid,
    required this.showBands,
    required this.overlayOpacity,
  });

  final Animation<double> controller;
  final bool showGrid;
  final bool showBands;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final double t = controller.value;
        final List<Color> palette = <Color>[
          Color.lerp(const Color(0xFF0EA5E9), const Color(0xFF6366F1), (math.sin(t * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFF97316), const Color(0xFF10B981), (math.cos(t * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFFE11D48), const Color(0xFF14B8A6), (math.sin(t * math.pi * 4) + 1) / 2)!,
        ];
        return CustomPaint(
          painter: _BackdropPainter(
            progress: t,
            palette: palette,
            showGrid: showGrid,
            showBands: showBands,
            overlayOpacity: overlayOpacity,
          ),
        );
      },
    );
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({
    required this.progress,
    required this.palette,
    required this.showGrid,
    required this.showBands,
    required this.overlayOpacity,
  });

  final double progress;
  final List<Color> palette;
  final bool showGrid;
  final bool showBands;
  final double overlayOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..shader = LinearGradient(
        colors: palette,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final Paint circle = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 14; i += 1) {
      final double wave = progress * math.pi * 2 + (i * 0.45);
      final double x = (size.width * 0.5) + math.cos(wave) * (size.width * 0.38);
      final double y = (size.height * 0.5) + math.sin(wave * 1.3) * (size.height * 0.34);
      final double radius = 14 + ((i % 5) * 7);
      circle.color = palette[i % palette.length].withValues(alpha: 0.23 + ((i % 3) * 0.09));
      canvas.drawCircle(Offset(x, y), radius, circle);
    }

    if (showBands) {
      final Paint band = Paint();
      for (int i = 0; i < 5; i += 1) {
        final double top = (size.height / 5) * i;
        band.color = palette[i % palette.length].withValues(alpha: 0.12);
        canvas.drawRect(Rect.fromLTWH(0, top, size.width, size.height / 7), band);
      }
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
    return oldDelegate.progress != progress ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showBands != showBands ||
        oldDelegate.overlayOpacity != overlayOpacity ||
        oldDelegate.palette != palette;
  }
}
