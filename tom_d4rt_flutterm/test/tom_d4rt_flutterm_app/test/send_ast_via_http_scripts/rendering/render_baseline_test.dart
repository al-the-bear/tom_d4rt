import 'package:flutter/material.dart';

const List<_ThemePreset> _themePresets = <_ThemePreset>[
  _ThemePreset(
    id: 'ink',
    name: 'Ink Studio',
    description: 'High-legibility profile for studying baseline offsets and cap-height contrast.',
    seed: Color(0xFF1D4ED8),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'amber',
    name: 'Amber Desk',
    description: 'Warm profile for educational baseline walkthroughs.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemePreset(
    id: 'night',
    name: 'Night Proof',
    description: 'Dark profile emphasizing baseline guide lines and glyph silhouettes.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
  _ThemePreset(
    id: 'mint',
    name: 'Mint Panel',
    description: 'Balanced profile for long diagnostic sessions and board comparisons.',
    seed: Color(0xFF047857),
    brightness: Brightness.light,
  ),
];

const List<_ScenarioPreset> _scenarioPresets = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'gallery',
    title: 'Baseline Gallery',
    subtitle: 'Compare font families and sizes with shared baseline anchors.',
  ),
  _ScenarioPreset(
    id: 'inspector',
    title: 'Grid Inspector',
    subtitle: 'Interactive baseline guide rails with adjustable offsets.',
  ),
  _ScenarioPreset(
    id: 'pairing',
    title: 'Icon/Text Pairing',
    subtitle: 'Align icons and labels using baseline-aware wrappers.',
  ),
  _ScenarioPreset(
    id: 'scripts',
    title: 'Script Mix',
    subtitle: 'Observe baseline behavior across multiple writing systems.',
  ),
  _ScenarioPreset(
    id: 'ops',
    title: 'Ops Console',
    subtitle: 'Metrics, timeline, and practical guidance for baseline usage.',
  ),
];

const List<_BaselinePreset> _baselinePresets = <_BaselinePreset>[
  _BaselinePreset(label: 'Compact', value: 20, note: 'Useful for compact labels and chips.'),
  _BaselinePreset(label: 'Body', value: 28, note: 'Typical baseline for body text rows.'),
  _BaselinePreset(label: 'Display', value: 42, note: 'Display typography with larger baseline depth.'),
  _BaselinePreset(label: 'Large Display', value: 58, note: 'Hero text and large card heading alignment.'),
];

const List<String> _guideBullets = <String>[
  'RenderBaseline positions its child so a chosen baseline aligns at a target distance from the top.',
  'The Baseline widget is the primary high-level API that configures RenderBaseline in Flutter trees.',
  'Use baseline alignment when mixed typography or icons must sit on one visual writing line.',
  'CrossAxisAlignment.baseline in Row/Column requires textBaseline and is useful for multi-widget text rows.',
  'If content has no baseline, fallback layout behavior can differ from pure text widgets, so verify visually.',
  'Baseline tuning is especially important for forms, dashboard labels, and mixed headline/subtitle cards.',
  'Use guide rails in demos to verify baseline movement while changing font sizes and script variants.',
  'Keep performance simple: baseline layout is not typically expensive, but repeated re-layout still has cost.',
  'Document baseline assumptions in shared components to prevent subtle alignment regressions later.',
  'Test with international scripts because baseline perception can vary across writing systems.',
];

const List<_FaqEntry> _faq = <_FaqEntry>[
  _FaqEntry(
    question: 'When should I use Baseline widget directly?',
    answer: 'Use it when you need precise control of one child alignment relative to an explicit baseline offset.',
  ),
  _FaqEntry(
    question: 'Why does CrossAxisAlignment.baseline need textBaseline?',
    answer: 'Flutter needs to know whether alphabetic or ideographic baseline should be used for row alignment.',
  ),
  _FaqEntry(
    question: 'Can icons align with text baselines?',
    answer: 'Yes, wrap icons in Baseline with tuned offset so visual bottoms align with neighboring text.',
  ),
  _FaqEntry(
    question: 'Does baseline differ across scripts?',
    answer: 'Yes, script metrics differ. Always test multilingual samples where typography consistency matters.',
  ),
];

enum _FontLane {
  inter,
  serif,
  mono,
  playful,
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

class _BaselinePreset {
  const _BaselinePreset({required this.label, required this.value, required this.note});

  final String label;
  final double value;
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

class _BaselineSample {
  const _BaselineSample({
    required this.title,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.note,
  });

  final String title;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String note;
}

dynamic build(BuildContext context) {
  return const _RenderBaselineLab();
}

class _RenderBaselineLab extends StatefulWidget {
  const _RenderBaselineLab();

  @override
  State<_RenderBaselineLab> createState() => _RenderBaselineLabState();
}

class _RenderBaselineLabState extends State<_RenderBaselineLab> {
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _baselinePresetIndex = 1;

  _FontLane _fontLane = _FontLane.inter;

  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showScriptNotes = true;

  double _baselineOffset = 28;
  double _fontScale = 1;
  double _iconBaseline = 26;
  double _cardPadding = 12;
  double _inspectorHeight = 200;
  double _laneSpacing = 14;

  int _baselineSwitchCount = 0;
  int _fontSwitchCount = 0;
  int _iconTuneCount = 0;
  int _scriptSwitchCount = 0;
  int _tapCount = 0;
  int _presetApplyCount = 0;

  String _phase = 'steady';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  int _scriptVariant = 0;

  final List<List<String>> _scriptRows = <List<String>>[
    <String>['Baseline', 'कक्षा', 'مرحبا', '漢字', '123'],
    <String>['Typography', 'विद्यालय', 'لغة', '仮名', '456'],
    <String>['Render', 'पंक्ति', 'سطح', '文字', '789'],
  ];

  @override
  void initState() {
    super.initState();
    _applyBaselinePreset(_baselinePresets[_baselinePresetIndex], silent: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderBaseline Typographic Alignment Lab initialized.');
    });
  }

  @override
  void dispose() {
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

  void _applyBaselinePreset(_BaselinePreset preset, {bool silent = false}) {
    setState(() {
      _baselineOffset = preset.value;
      _phase = 'preset';
    });
    if (!silent) {
      _presetApplyCount += 1;
      _pushTimeline('Baseline Preset', '${preset.label} (${preset.value.toStringAsFixed(1)}) applied.');
    }
  }

  String? _fontFamilyForLane(_FontLane lane) {
    return switch (lane) {
      _FontLane.inter => null,
      _FontLane.serif => 'serif',
      _FontLane.mono => 'monospace',
      _FontLane.playful => null,
    };
  }

  FontStyle _fontStyleForLane(_FontLane lane) {
    return lane == _FontLane.playful ? FontStyle.italic : FontStyle.normal;
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Scenario', value: _scenarioPresets[_scenarioIndex].title, note: 'Current exploration lane.', icon: Icons.dashboard_customize_outlined),
      _MetricEntry(label: 'Theme', value: _themePresets[_themeIndex].name, note: 'Active visual profile.', icon: Icons.palette_outlined),
      _MetricEntry(label: 'Baseline', value: _baselineOffset.toStringAsFixed(1), note: 'Target baseline offset from top.', icon: Icons.height_outlined),
      _MetricEntry(label: 'Font Scale', value: _fontScale.toStringAsFixed(2), note: 'Global typographic scaling factor.', icon: Icons.text_fields_outlined),
      _MetricEntry(label: 'Icon Baseline', value: _iconBaseline.toStringAsFixed(1), note: 'Icon alignment baseline offset.', icon: Icons.image_outlined),
      _MetricEntry(label: 'Inspector Height', value: _inspectorHeight.toStringAsFixed(0), note: 'Grid inspector panel height.', icon: Icons.table_rows_outlined),
      _MetricEntry(label: 'Card Padding', value: _cardPadding.toStringAsFixed(0), note: 'Padding around baseline cards.', icon: Icons.space_dashboard_outlined),
      _MetricEntry(label: 'Lane Spacing', value: _laneSpacing.toStringAsFixed(0), note: 'Vertical spacing between demonstration lanes.', icon: Icons.format_line_spacing_outlined),
      _MetricEntry(label: 'Phase', value: _phase, note: 'Current interaction phase.', icon: Icons.flag_outlined),
      _MetricEntry(label: 'Baseline Switches', value: '$_baselineSwitchCount', note: 'Manual baseline adjustments count.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Font Switches', value: '$_fontSwitchCount', note: 'Font lane profile changes.', icon: Icons.font_download_outlined),
      _MetricEntry(label: 'Icon Tunes', value: '$_iconTuneCount', note: 'Icon baseline adjustments.', icon: Icons.align_horizontal_center_outlined),
      _MetricEntry(label: 'Script Variant', value: '$_scriptVariant', note: 'Current multilingual row variant.', icon: Icons.language_outlined),
      _MetricEntry(label: 'Script Switches', value: '$_scriptSwitchCount', note: 'Script lane toggles.', icon: Icons.translate_outlined),
      _MetricEntry(label: 'Preset Uses', value: '$_presetApplyCount', note: 'Baseline preset usage.', icon: Icons.bookmark_added_outlined),
      _MetricEntry(label: 'Taps', value: '$_tapCount', note: 'Interactive baseline lane taps.', icon: Icons.touch_app_outlined),
    ];
  }

  void _resetConsole() {
    setState(() {
      _scenarioIndex = 0;
      _baselinePresetIndex = 1;
      _fontLane = _FontLane.inter;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showScriptNotes = true;
      _baselineOffset = 28;
      _fontScale = 1;
      _iconBaseline = 26;
      _cardPadding = 12;
      _inspectorHeight = 200;
      _laneSpacing = 14;
      _baselineSwitchCount = 0;
      _fontSwitchCount = 0;
      _iconTuneCount = 0;
      _scriptSwitchCount = 0;
      _tapCount = 0;
      _presetApplyCount = 0;
      _phase = 'steady';
      _timeline = const <_TimelineEvent>[];
      _scriptVariant = 0;
    });
    _applyBaselinePreset(_baselinePresets[_baselinePresetIndex], silent: true);
    _pushTimeline('Reset', 'Baseline lab controls reset to defaults.');
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
                        _buildPrimaryDeck(scheme),
                        const SizedBox(height: 16),
                        _buildInspectorBoard(scheme),
                        const SizedBox(height: 16),
                        _buildIconPairingBoard(scheme),
                        const SizedBox(height: 16),
                        _buildScriptMixBoard(scheme),
                        const SizedBox(height: 16),
                        _buildChallengeBoard(scheme),
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
                Icon(Icons.align_vertical_bottom_outlined, color: scheme.primary, size: 26),
                Text('RenderBaseline Typographic Alignment Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioPresets[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual deep visual demo for baseline alignment across mixed typography, icons, scripts, and interactive layout lanes.',
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
                final _ThemePreset p = _themePresets[i];
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
            Text(_themePresets[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioPresets.length, (int i) {
                final _ScenarioPreset s = _scenarioPresets[i];
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
            Text(_scenarioPresets[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => setState(() => _showGrid = v ?? true), child: const Text('Show grid guides')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showScriptNotes, onChanged: (bool? v) => setState(() => _showScriptNotes = v ?? true), child: const Text('Show script notes')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => setState(() => _showGuide = v ?? true), child: const Text('Show guide board')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => setState(() => _showTimeline = v ?? true), child: const Text('Show timeline board')),
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
        final Widget gallery = _buildBaselineGallery(scheme);
        final Widget controls = _buildControlConsole(scheme);
        if (narrow) {
          return Column(children: <Widget>[gallery, const SizedBox(height: 12), controls]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 7, child: gallery),
            const SizedBox(width: 12),
            Expanded(flex: 5, child: controls),
          ],
        );
      },
    );
  }

  List<_BaselineSample> _samples(ColorScheme scheme) {
    return <_BaselineSample>[
      _BaselineSample(
        title: 'Label',
        text: 'Baseline',
        fontSize: 16 * _fontScale,
        fontWeight: FontWeight.w600,
        color: scheme.primary,
        note: 'Small text baseline anchor.',
      ),
      _BaselineSample(
        title: 'Body',
        text: 'Alignment matters',
        fontSize: 22 * _fontScale,
        fontWeight: FontWeight.w700,
        color: scheme.secondary,
        note: 'Medium copy baseline comparison.',
      ),
      _BaselineSample(
        title: 'Display',
        text: 'RenderBaseline',
        fontSize: 34 * _fontScale,
        fontWeight: FontWeight.w800,
        color: scheme.tertiary,
        note: 'Large heading baseline anchor.',
      ),
    ];
  }

  Widget _buildBaselineGallery(ColorScheme scheme) {
    final List<_BaselineSample> samples = _samples(scheme);
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
                Text('Baseline Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetConsole, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Mixed typographic samples aligned on a shared baseline using Baseline widget wrappers.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: EdgeInsets.all(_cardPadding),
                child: SizedBox(
                  height: 212,
                  child: Stack(
                    children: <Widget>[
                      if (_showGrid)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _BaselineGridPainter(
                              color: scheme.outlineVariant.withValues(alpha: 0.24),
                              baseline: _baselineOffset,
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tapCount += 1;
                                  _phase = 'tap';
                                });
                                _pushTimeline('Gallery Tap', 'Baseline gallery lane tapped.');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: samples.map(( _BaselineSample sample) {
                                  return Baseline(
                                    baseline: _baselineOffset,
                                    baselineType: TextBaseline.alphabetic,
                                    child: _sampleCard(scheme, sample),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
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

  Widget _sampleCard(ColorScheme scheme, _BaselineSample sample) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: sample.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sample.color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sample.title, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            sample.text,
            style: TextStyle(
              color: sample.color,
              fontSize: sample.fontSize,
              fontWeight: sample.fontWeight,
              fontFamily: _fontFamilyForLane(_fontLane),
              fontStyle: _fontStyleForLane(_fontLane),
            ),
          ),
          const SizedBox(height: 4),
          Text(sample.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
        ],
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
            Text('Tune baseline offsets, font scaling, card geometry, and script variants.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            _slider(
              scheme: scheme,
              label: 'Baseline Offset',
              value: _baselineOffset,
              min: 10,
              max: 80,
              divisions: 70,
              onChanged: (double v) {
                setState(() {
                  _baselineOffset = v;
                  _baselineSwitchCount += 1;
                  _phase = 'tuning';
                });
              },
              onChangeEnd: (double v) => _pushTimeline('Baseline', 'Baseline offset tuned to ${v.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Font Scale',
              value: _fontScale,
              min: 0.65,
              max: 1.8,
              divisions: 115,
              onChanged: (double v) => setState(() => _fontScale = v),
              onChangeEnd: (double v) => _pushTimeline('Typography', 'Font scale set to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Icon Baseline',
              value: _iconBaseline,
              min: 10,
              max: 60,
              divisions: 50,
              onChanged: (double v) {
                setState(() {
                  _iconBaseline = v;
                  _iconTuneCount += 1;
                });
              },
              onChangeEnd: (double v) => _pushTimeline('Icon Baseline', 'Icon baseline tuned to ${v.toStringAsFixed(1)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Inspector Height',
              value: _inspectorHeight,
              min: 140,
              max: 320,
              divisions: 90,
              onChanged: (double v) => setState(() => _inspectorHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Inspector', 'Inspector height set to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Card Padding',
              value: _cardPadding,
              min: 6,
              max: 28,
              divisions: 22,
              onChanged: (double v) => setState(() => _cardPadding = v),
              onChangeEnd: (double v) => _pushTimeline('Layout', 'Card padding set to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Lane Spacing',
              value: _laneSpacing,
              min: 8,
              max: 34,
              divisions: 26,
              onChanged: (double v) => setState(() => _laneSpacing = v),
              onChangeEnd: (double v) => _pushTimeline('Layout', 'Lane spacing set to ${v.toStringAsFixed(0)}.'),
            ),
            const Divider(height: 22),
            Text('Baseline Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_baselinePresets.length, (int i) {
                final _BaselinePreset p = _baselinePresets[i];
                return ChoiceChip(
                  selected: _baselinePresetIndex == i,
                  label: Text(p.label),
                  onSelected: (_) {
                    setState(() => _baselinePresetIndex = i);
                    _applyBaselinePreset(p);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_baselinePresets[_baselinePresetIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Font Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _FontLane.values.map(( _FontLane lane) {
                return ChoiceChip(
                  selected: _fontLane == lane,
                  label: Text(lane.name),
                  onSelected: (_) {
                    setState(() {
                      _fontLane = lane;
                      _fontSwitchCount += 1;
                    });
                    _pushTimeline('Font Lane', 'Switched font lane to ${lane.name}.');
                  },
                );
              }).toList(),
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

  Widget _buildInspectorBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Baseline Grid Inspector', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Guide rails and mixed-size samples reveal how baseline adjustments move all children together.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: SizedBox(
                height: _inspectorHeight,
                child: Stack(
                  children: <Widget>[
                    if (_showGrid)
                      Positioned.fill(child: CustomPaint(painter: _BaselineGridPainter(color: scheme.outlineVariant.withValues(alpha: 0.25), baseline: _baselineOffset))),
                    Positioned.fill(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Baseline(
                              baseline: _baselineOffset,
                              baselineType: TextBaseline.alphabetic,
                              child: Text('Aa', style: TextStyle(fontSize: 22 * _fontScale, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                            ),
                            Baseline(
                              baseline: _baselineOffset,
                              baselineType: TextBaseline.alphabetic,
                              child: Text('gQp', style: TextStyle(fontSize: 34 * _fontScale, fontWeight: FontWeight.w700, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                            ),
                            Baseline(
                              baseline: _baselineOffset,
                              baselineType: TextBaseline.alphabetic,
                              child: Text('2026', style: TextStyle(fontSize: 26 * _fontScale, fontWeight: FontWeight.w700, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                            ),
                            Baseline(
                              baseline: _baselineOffset,
                              baselineType: TextBaseline.alphabetic,
                              child: Text('Typo', style: TextStyle(fontSize: 46 * _fontScale, fontWeight: FontWeight.w800, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildIconPairingBoard(ColorScheme scheme) {
    final List<IconData> icons = <IconData>[Icons.home_outlined, Icons.analytics_outlined, Icons.mail_outline, Icons.schedule_outlined];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Icon + Text Pairing', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Rows demonstrate icon/text alignment using Baseline wrappers for icon glyph containers.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            ...List<Widget>.generate(icons.length, (int i) {
              return Container(
                margin: EdgeInsets.only(bottom: i == icons.length - 1 ? 0 : _laneSpacing),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Baseline(
                      baseline: _iconBaseline,
                      baselineType: TextBaseline.alphabetic,
                      child: Icon(icons[i], size: 30 + (i * 3), color: scheme.primary),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Baseline(
                        baseline: _baselineOffset,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          'Row ${i + 1}: baseline-aligned label for icon pairing',
                          style: TextStyle(fontSize: (17 + i).toDouble() * _fontScale, fontWeight: FontWeight.w600, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildScriptMixBoard(ColorScheme scheme) {
    final List<String> row = _scriptRows[_scriptVariant % _scriptRows.length];
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
                Text('Script Mix Lane', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _scriptVariant = (_scriptVariant + 1) % _scriptRows.length;
                      _scriptSwitchCount += 1;
                      _phase = 'scripts';
                    });
                    _pushTimeline('Scripts', 'Script mix switched to variant $_scriptVariant.');
                  },
                  icon: const Icon(Icons.cached),
                  label: const Text('Cycle'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Baseline behavior across multiple writing systems and numeric strings.', style: TextStyle(color: scheme.onSurfaceVariant)),
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
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List<Widget>.generate(row.length, (int i) {
                        final double size = (16 + (i * 7)).toDouble() * _fontScale;
                        return Baseline(
                          baseline: _baselineOffset,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            row[i],
                            style: TextStyle(fontSize: size, fontWeight: i.isEven ? FontWeight.w700 : FontWeight.w500, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane)),
                          ),
                        );
                      }),
                    ),
                    if (_showScriptNotes) const SizedBox(height: 10),
                    if (_showScriptNotes)
                      Text(
                        'Observe baseline consistency despite different glyph shapes and script metrics. Fine-tune offsets where multilingual labels share one row.',
                        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
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

  Widget _buildChallengeBoard(ColorScheme scheme) {
    final List<double> offsets = <double>[_baselineOffset - 8, _baselineOffset, _baselineOffset + 10];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Baseline Shift Challenges', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Three challenge cards demonstrate near, exact, and exaggerated baseline offsets.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1000;
                final List<Widget> cards = List<Widget>.generate(offsets.length, (int i) {
                  final double target = offsets[i].clamp(8, 90);
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i == offsets.length - 1 || narrow ? 0 : 10, bottom: narrow && i < offsets.length - 1 ? 10 : 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Target ${target.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 104,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(painter: _BaselineGridPainter(color: scheme.outlineVariant.withValues(alpha: 0.22), baseline: target)),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: <Widget>[
                                      Baseline(
                                        baseline: target,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Text('A', style: TextStyle(fontSize: 26 * _fontScale, fontWeight: FontWeight.w700, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                                      ),
                                      Baseline(
                                        baseline: target,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Text('Baseline', style: TextStyle(fontSize: 18 * _fontScale, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                                      ),
                                      Baseline(
                                        baseline: target,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Text('123', style: TextStyle(fontSize: 22 * _fontScale, fontWeight: FontWeight.w700, fontFamily: _fontFamilyForLane(_fontLane), fontStyle: _fontStyleForLane(_fontLane))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });

                if (narrow) {
                  return Column(children: cards);
                }
                return Row(children: cards);
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
            Text('theme=${_themePresets[_themeIndex].id} scenario=${_scenarioPresets[_scenarioIndex].id} phase=$_phase', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('baseline=${_baselineOffset.toStringAsFixed(1)} fontScale=${_fontScale.toStringAsFixed(2)} iconBaseline=${_iconBaseline.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('inspectorHeight=${_inspectorHeight.toStringAsFixed(0)} cardPadding=${_cardPadding.toStringAsFixed(0)} laneSpacing=${_laneSpacing.toStringAsFixed(0)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('fontLane=${_fontLane.name} scriptVariant=$_scriptVariant showGrid=$_showGrid', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('switches baseline=$_baselineSwitchCount font=$_fontSwitchCount script=$_scriptSwitchCount icon=$_iconTuneCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('taps=$_tapCount presetUses=$_presetApplyCount', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            Text('Chronological log of baseline operations and control updates.', style: TextStyle(color: scheme.onSurfaceVariant)),
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

class _BaselineGridPainter extends CustomPainter {
  _BaselineGridPainter({required this.color, required this.baseline});

  final Color color;
  final double baseline;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Paint baselinePaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.8)
      ..strokeWidth = 2;
    final double y = baseline.clamp(0, size.height);
    canvas.drawLine(Offset(0, y), Offset(size.width, y), baselinePaint);

    final Paint centerPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.4;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), centerPaint);
  }

  @override
  bool shouldRepaint(covariant _BaselineGridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.baseline != baseline;
  }
}
