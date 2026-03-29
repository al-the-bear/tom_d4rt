import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_Profile> _profiles = [
  _Profile(
    id: 'atlas',
    name: 'Atlas Desk',
    description: 'Balanced profile for studying layout transitions after font-change signals.',
    seed: Color(0xFF0EA5E9),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'nocturne',
    name: 'Nocturne Ops',
    description: 'Dark diagnostics profile for detailed relayout tracking and timeline review.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _Profile(
    id: 'copper',
    name: 'Copper Lab',
    description: 'Warm profile focused on typography experiments and signal choreography.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'orchid',
    name: 'Orchid Systems',
    description: 'Training profile for instructional walkthroughs around mixin behavior.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    id: 'gallery',
    title: 'Mixin Gallery',
    subtitle: 'Understand where RelayoutWhenSystemFontsChangeMixin fits in render-layer architecture.',
  ),
  _Scenario(
    id: 'layout',
    title: 'Layout Lab',
    subtitle: 'Visualize host size and paint changes under typography pressure and constraints.',
  ),
  _Scenario(
    id: 'signal',
    title: 'Signal Simulator',
    subtitle: 'Send synthetic system-font change signals and observe relayout wave effects.',
  ),
  _Scenario(
    id: 'integrated',
    title: 'Integrated Cockpit',
    subtitle: 'Combine controls, hosts, metrics, and notes into a realistic observability dashboard.',
  ),
  _Scenario(
    id: 'guide',
    title: 'Guide + Timeline',
    subtitle: 'Instructive notes, FAQ, and chronological events for practical usage understanding.',
  ),
];

const List<_TileBlueprint> _blueprints = [
  _TileBlueprint(
    title: 'Primary Reader Surface',
    role: 'content',
    emphasis: 0.42,
    density: 0.52,
    note: 'Main text-like host with clear area to observe relayout after font-change events.',
  ),
  _TileBlueprint(
    title: 'Compact Metadata Strip',
    role: 'meta',
    emphasis: 0.22,
    density: 0.84,
    note: 'Dense auxiliary strip often sensitive to typography metrics and spacing adjustments.',
  ),
  _TileBlueprint(
    title: 'Prominent Banner',
    role: 'banner',
    emphasis: 0.88,
    density: 0.33,
    note: 'Large decorative host where font-size and baseline shifts become visually obvious.',
  ),
  _TileBlueprint(
    title: 'Telemetry Badge Group',
    role: 'badge',
    emphasis: 0.58,
    density: 0.66,
    note: 'Intermediate cluster that balances readability and compactness under relayout.',
  ),
  _TileBlueprint(
    title: 'Inline Label Rail',
    role: 'label',
    emphasis: 0.31,
    density: 0.72,
    note: 'Side rail style host useful for seeing horizontal contraction/expansion behavior.',
  ),
];

const List<String> _introduction = [
  'RelayoutWhenSystemFontsChangeMixin is a render-layer helper that requests layout updates when system fonts change.',
  'It is commonly relevant for render objects whose geometry depends on typography metrics, not only paint output.',
  'This demo uses a custom RenderBox with the mixin so behavior is visible and controllable in the interpreter environment.',
  'The objective is to observe interaction and relayout outcomes, not to assert Flutter engine correctness.',
  'Each board offers visual evidence through host surfaces, overlays, and metrics that update with actions.',
  'Synthetic signals are used to emulate font-change events and verify response flow across multiple hosts.',
  'Layout and paint counters help separate pure repaint effects from true relayout pathways.',
  'Guide sections explain practical decisions for teams building custom render objects with typography dependencies.',
];

const List<String> _bestPractices = [
  'Use the mixin when your render object size depends on font metrics or text layout assumptions.',
  'Keep signal handling lightweight; let layout/paint methods do heavy work with clear counters for diagnosis.',
  'Expose diagnostics in demos so engineers can observe relayout cadence while toggling typography settings.',
  'Design visual boards that compare before/after host geometry, not just a printed event log.',
  'Track layout count and paint count independently to catch unnecessary layout invalidations.',
  'When multiple hosts depend on fonts, trigger and compare them side-by-side for regression detection.',
  'Pair guidance text with interactive controls to make demos instructive for onboarding engineers.',
  'Avoid hidden state transitions; surface important toggles like density, emphasis, and signal burst size.',
  'Document expected interaction patterns when system-font changes occur repeatedly in short intervals.',
  'Use rounded clipping and overlays in demos to make geometric shifts easy to detect visually.',
];

const List<_Faq> _faq = [
  _Faq(
    question: 'When should I add RelayoutWhenSystemFontsChangeMixin?',
    answer: 'Use it when your render object dimensions depend on typography metrics affected by system font changes.',
  ),
  _Faq(
    question: 'Is this only for text render objects?',
    answer: 'No. Any render object with font-influenced layout logic can benefit from this relayout trigger behavior.',
  ),
  _Faq(
    question: 'What does this demo verify most strongly?',
    answer: 'That font-change signals propagate into observable relayout activity in custom render hosts.',
  ),
  _Faq(
    question: 'Why focus on visuals over assertions?',
    answer: 'Interpreter bridge tests prioritize interaction confidence and runtime behavior understanding.',
  ),
];

class _Profile {
  const _Profile({
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

class _TileBlueprint {
  const _TileBlueprint({
    required this.title,
    required this.role,
    required this.emphasis,
    required this.density,
    required this.note,
  });

  final String title;
  final String role;
  final double emphasis;
  final double density;
  final String note;
}

class _Faq {
  const _Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

dynamic build(BuildContext context) {
  return const _RelayoutWhenSystemFontsChangeMixinStudio();
}

class _RelayoutWhenSystemFontsChangeMixinStudio extends StatefulWidget {
  const _RelayoutWhenSystemFontsChangeMixinStudio();

  @override
  State<_RelayoutWhenSystemFontsChangeMixinStudio> createState() => _RelayoutWhenSystemFontsChangeMixinStudioState();
}

class _RelayoutWhenSystemFontsChangeMixinStudioState extends State<_RelayoutWhenSystemFontsChangeMixinStudio> {
  int _profileIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _showDiagnostics = true;
  bool _showTimeline = true;
  bool _showGuides = true;
  bool _showGrid = true;
  bool _showNoise = true;
  bool _compactCards = false;
  bool _autoLog = true;

  double _hostWidth = 340;
  double _hostHeight = 190;
  double _cornerRadius = 16;
  double _overlayOpacity = 0.24;
  double _noise = 0.36;
  double _density = 0.56;
  double _emphasis = 0.47;

  List<bool> _modeToggle = <bool>[true, false, false, false];
  List<bool> _signalToggle = <bool>[true, false, true, false];

  int _tick = 0;
  int _signalCount = 0;
  int _layoutCount = 0;
  int _paintCount = 0;
  int _pointerCount = 0;
  int _overlayTapCount = 0;
  int _hostTapCount = 0;

  final List<String> _timeline = <String>[];

  final GlobalKey _primaryHostKey = GlobalKey();
  final GlobalKey _secondaryHostKey = GlobalKey();
  final GlobalKey _matrixHostKey = GlobalKey();

  void _log(String message) {
    if (!_autoLog) {
      return;
    }
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $message');
    if (_timeline.length > 44) {
      _timeline.removeRange(44, _timeline.length);
    }
  }

  void _onSignal() {
    setState(() {
      _signalCount += 1;
      _tick += 1;
      _log('systemFontsDidChange signal observed by render host.');
    });
  }

  void _onLayout() {
    setState(() {
      _layoutCount += 1;
      _tick += 1;
    });
  }

  void _onPaint() {
    setState(() {
      _paintCount += 1;
    });
  }

  void _onPointer() {
    setState(() {
      _pointerCount += 1;
      _tick += 1;
      _log('Pointer event forwarded to host render object.');
    });
  }

  void _triggerSystemFontSignal(GlobalKey key, String tag) {
    final ro = key.currentContext?.findRenderObject();
    if (ro is _FontRelayoutRenderBox) {
      ro.systemFontsDidChange();
      setState(() {
        _tick += 1;
        _log('Manual systemFontsDidChange invoked for $tag.');
      });
    } else {
      setState(() {
        _tick += 1;
        _log('Skipped signal for $tag (render object not ready).');
      });
    }
  }

  void _burstSignals() {
    final bursts = _signalToggle[0]
        ? 1
        : _signalToggle[1]
            ? 2
            : _signalToggle[2]
                ? 3
                : 5;
    for (var i = 0; i < bursts; i++) {
      _triggerSystemFontSignal(_primaryHostKey, 'primary');
      _triggerSystemFontSignal(_secondaryHostKey, 'secondary');
    }
    setState(() {
      _tick += 1;
      _log('Signal burst complete: bursts=$bursts across primary and secondary hosts.');
    });
  }

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Signals', value: '$_signalCount', note: 'systemFontsDidChange callbacks', icon: Icons.wifi_tethering),
      _Metric(label: 'Layouts', value: '$_layoutCount', note: 'performLayout invocations', icon: Icons.grid_view),
      _Metric(label: 'Paints', value: '$_paintCount', note: 'paint invocations', icon: Icons.brush),
      _Metric(label: 'Pointers', value: '$_pointerCount', note: 'host pointer events', icon: Icons.touch_app),
      _Metric(label: 'Overlay taps', value: '$_overlayTapCount', note: 'flutter overlay interactions', icon: Icons.layers),
      _Metric(label: 'Host taps', value: '$_hostTapCount', note: 'host action chip interactions', icon: Icons.ads_click),
      _Metric(label: 'Tick', value: '$_tick', note: 'state progression marker', icon: Icons.timeline),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profiles[_profileIndex];
    final scenario = _scenarios[_scenarioIndex];
    final scheme = ColorScheme.fromSeed(seedColor: profile.seed, brightness: profile.brightness);

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: _compactCards ? VisualDensity.compact : VisualDensity.standard,
    );

    return Theme(
      data: theme,
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            _header(theme, profile, scenario),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _controls(theme),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 12, 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.surface,
                            theme.colorScheme.surfaceContainerHighest.withAlpha(150),
                            theme.colorScheme.surface,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                      ),
                      child: _board(theme, scenario, _metrics()),
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

  Widget _header(ThemeData theme, _Profile profile, _Scenario scenario) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withAlpha(180),
            theme.colorScheme.secondaryContainer.withAlpha(150),
            theme.colorScheme.tertiaryContainer.withAlpha(130),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.surface,
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
            ),
            child: CustomPaint(
              painter: _GlyphPainter(a: profile.seed, b: theme.colorScheme.tertiary, tick: _tick),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RelayoutWhenSystemFontsChangeMixin Observatory', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'profile: ${profile.name}  scenario: ${scenario.title}  density: ${_density.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface.withAlpha(176)),
                ),
                const SizedBox(height: 4),
                Text(profile.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controls(ThemeData theme) {
    return Container(
      width: 408,
      margin: const EdgeInsets.fromLTRB(12, 10, 0, 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.surfaceContainerHighest.withAlpha(126),
            theme.colorScheme.surfaceContainer.withAlpha(98),
            theme.colorScheme.surfaceContainerLow.withAlpha(84),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Observatory Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Tune host geometry, typography pressure, signal bursts, and diagnostics visibility.'),
            const SizedBox(height: 10),
            _dropdownCard(
              label: 'Profile',
              value: _profileIndex,
              options: _profiles.map((e) => e.name).toList(),
              onChanged: (v) => setState(() {
                _profileIndex = v;
                _tick += 1;
                _log('Profile switched to ${_profiles[v].name}.');
              }),
            ),
            _dropdownCard(
              label: 'Scenario',
              value: _scenarioIndex,
              options: _scenarios.map((e) => e.title).toList(),
              onChanged: (v) => setState(() {
                _scenarioIndex = v;
                _boardIndex = v;
                _tick += 1;
                _log('Scenario switched to ${_scenarios[v].title}.');
              }),
            ),
            _dropdownCard(
              label: 'Board',
              value: _boardIndex,
              options: List.generate(5, _boardTitle),
              onChanged: (v) => setState(() {
                _boardIndex = v;
                _tick += 1;
                _log('Board switched to ${_boardTitle(v)}.');
              }),
            ),
            _card(
              theme,
              'Mode',
              'Switch presentation emphasis for compact, walkthrough, diagnostics, or teaching mode.',
              ToggleButtons(
                isSelected: _modeToggle,
                onPressed: (i) {
                  setState(() {
                    _modeToggle = _single(_modeToggle, i);
                    _tick += 1;
                    _log('Mode switched to index=$i.');
                  });
                },
                children: const [
                  _MiniLabel(icon: Icons.fit_screen, text: 'Compact'),
                  _MiniLabel(icon: Icons.menu_book, text: 'Walkthrough'),
                  _MiniLabel(icon: Icons.science, text: 'Diagnostics'),
                  _MiniLabel(icon: Icons.school, text: 'Teaching'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _card(
              theme,
              'Signal Burst Pattern',
              'Choose burst profile for synthetic systemFontsDidChange wave simulation.',
              ToggleButtons(
                isSelected: _signalToggle,
                onPressed: (i) {
                  setState(() {
                    _signalToggle = _single(_signalToggle, i);
                    _tick += 1;
                    _log('Signal burst mode switched to index=$i.');
                  });
                },
                children: const [
                  _MiniLabel(icon: Icons.looks_one, text: '1x'),
                  _MiniLabel(icon: Icons.looks_two, text: '2x'),
                  _MiniLabel(icon: Icons.looks_3, text: '3x'),
                  _MiniLabel(icon: Icons.all_inclusive, text: '5x'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _sliderCard(
              label: 'Host width',
              value: _hostWidth,
              min: 180,
              max: 560,
              onChanged: (v) => setState(() => _hostWidth = v),
            ),
            _sliderCard(
              label: 'Host height',
              value: _hostHeight,
              min: 120,
              max: 320,
              onChanged: (v) => setState(() => _hostHeight = v),
            ),
            _sliderCard(
              label: 'Density',
              value: _density,
              min: 0.1,
              max: 1.0,
              onChanged: (v) => setState(() => _density = v),
            ),
            _sliderCard(
              label: 'Emphasis',
              value: _emphasis,
              min: 0.1,
              max: 1.0,
              onChanged: (v) => setState(() => _emphasis = v),
            ),
            _sliderCard(
              label: 'Overlay opacity',
              value: _overlayOpacity,
              min: 0.05,
              max: 0.9,
              onChanged: (v) => setState(() => _overlayOpacity = v),
            ),
            _sliderCard(
              label: 'Noise',
              value: _noise,
              min: 0,
              max: 1.0,
              onChanged: (v) => setState(() => _noise = v),
            ),
            _sliderCard(
              label: 'Corner radius',
              value: _cornerRadius,
              min: 0,
              max: 40,
              onChanged: (v) => setState(() => _cornerRadius = v),
            ),
            _switchCard(
              title: 'Show diagnostics',
              subtitle: 'Render object snapshot panels and counters',
              value: _showDiagnostics,
              onChanged: (v) => setState(() => _showDiagnostics = v),
            ),
            _switchCard(
              title: 'Show timeline',
              subtitle: 'Chronological event log panel',
              value: _showTimeline,
              onChanged: (v) => setState(() => _showTimeline = v),
            ),
            _switchCard(
              title: 'Show guides',
              subtitle: 'Usage recommendations and FAQ blocks',
              value: _showGuides,
              onChanged: (v) => setState(() => _showGuides = v),
            ),
            _switchCard(
              title: 'Show grid',
              subtitle: 'Grid overlay on host surfaces',
              value: _showGrid,
              onChanged: (v) => setState(() => _showGrid = v),
            ),
            _switchCard(
              title: 'Show noise',
              subtitle: 'Animated noise strokes for visual depth',
              value: _showNoise,
              onChanged: (v) => setState(() => _showNoise = v),
            ),
            _switchCard(
              title: 'Compact cards',
              subtitle: 'Use tighter metrics and cards',
              value: _compactCards,
              onChanged: (v) => setState(() => _compactCards = v),
            ),
            _switchCard(
              title: 'Auto log',
              subtitle: 'Automatically log major actions',
              value: _autoLog,
              onChanged: (v) => setState(() => _autoLog = v),
            ),
            const SizedBox(height: 8),
            _card(
              theme,
              'Signal Actions',
              'Send one or multiple font-change signals to active hosts.',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: () => _triggerSystemFontSignal(_primaryHostKey, 'primary'),
                    icon: const Icon(Icons.send),
                    label: const Text('Signal primary'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _triggerSystemFontSignal(_secondaryHostKey, 'secondary'),
                    icon: const Icon(Icons.send_to_mobile),
                    label: const Text('Signal secondary'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _burstSignals,
                    icon: const Icon(Icons.waves),
                    label: const Text('Burst signals'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdownCard({
    required String label,
    required int value,
    required List<String> options,
    required ValueChanged<int> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          DropdownButtonFormField<int>(
            initialValue: value,
            decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
            items: [
              for (var i = 0; i < options.length; i++) DropdownMenuItem<int>(value: i, child: Text(options[i])),
            ],
            onChanged: (v) {
              if (v != null) {
                onChanged(v);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _switchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
              Switch(value: value, onChanged: onChanged),
            ],
          ),
          Text(subtitle, style: TextStyle(color: Colors.black.withAlpha(168), fontSize: 12.5)),
        ],
      ),
    );
  }

  Widget _sliderCard({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
          Slider(value: value, min: min, max: max, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _board(ThemeData theme, _Scenario scenario, List<_Metric> metrics) {
    switch (_boardIndex) {
      case 0:
        return _galleryBoard(theme, scenario);
      case 1:
        return _layoutBoard(theme, scenario);
      case 2:
        return _signalBoard(theme, scenario);
      case 3:
        return _integratedBoard(theme, scenario, metrics);
      default:
        return _guideBoard(theme, scenario, metrics);
    }
  }

  Widget _galleryBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'gallery'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Mixin Blueprint Cards',
            'Role-oriented host examples showing density/emphasis combinations suitable for relayout observation.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final bp in _blueprints)
                  SizedBox(
                    width: _compactCards ? 220 : 250,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bp.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('role: ${bp.role}'),
                            const SizedBox(height: 4),
                            Text('emphasis: ${bp.emphasis.toStringAsFixed(2)} • density: ${bp.density.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            Text(bp.note),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _chip('relayout-aware', Colors.indigo),
                                _chip('font-signal', Colors.teal),
                                _chip('render-host', Colors.deepPurple),
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
          const SizedBox(height: 10),
          _card(
            theme,
            'Primary Host',
            'Custom RenderBox host with RelayoutWhenSystemFontsChangeMixin responding to manual signals.',
            _hostPanel(
              key: _primaryHostKey,
              title: 'Primary Relayout Host',
              hueShift: 0.12,
              density: _density,
              emphasis: _emphasis,
              width: _hostWidth,
              height: _hostHeight,
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _primaryHostKey, 'Primary host render snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _layoutBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'layout'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Dual Host Layout Testbed',
            'Compare wide and compact hosts under same typography pressure controls.',
            Column(
              children: [
                _hostPanel(
                  key: _primaryHostKey,
                  title: 'Wide Host',
                  hueShift: 0.08,
                  density: _density,
                  emphasis: _emphasis,
                  width: _hostWidth,
                  height: _hostHeight,
                ),
                const SizedBox(height: 10),
                _hostPanel(
                  key: _secondaryHostKey,
                  title: 'Compact Host',
                  hueShift: 0.44,
                  density: (_density * 1.14).clamp(0.1, 1.0),
                  emphasis: (_emphasis * 0.78).clamp(0.1, 1.0),
                  width: math.max(160, _hostWidth * 0.68),
                  height: math.max(110, _hostHeight * 0.76),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Layout Guidance',
            'Design tips for render objects mixing typography-sensitive metrics and custom visuals.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(theme, 'Keep constraints explicit and audit host sizes after each synthetic font-change signal.'),
                _bullet(theme, 'Surface layout counters to verify signal bursts do not create accidental layout storms.'),
                _bullet(theme, 'Use clip and corner radius intentionally so geometric changes remain legible.'),
                _bullet(theme, 'Provide visual markers for baseline-like rows to detect subtle spacing shifts.'),
                _bullet(theme, 'Treat relayout as a first-class event in custom render object architecture docs.'),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _secondaryHostKey, 'Secondary host render snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _signalBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'signal'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Signal Matrix',
            'Three hosts with different density/emphasis pairs to compare relayout response curves.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _primaryHostKey,
                    title: 'Matrix A',
                    hueShift: 0.18,
                    density: _density,
                    emphasis: _emphasis,
                    width: 260,
                    height: 138,
                  ),
                ),
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _secondaryHostKey,
                    title: 'Matrix B',
                    hueShift: 0.53,
                    density: (_density * 1.08).clamp(0.1, 1.0),
                    emphasis: (_emphasis * 0.62).clamp(0.1, 1.0),
                    width: 260,
                    height: 138,
                  ),
                ),
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _matrixHostKey,
                    title: 'Matrix C',
                    hueShift: 0.83,
                    density: (_density * 0.76).clamp(0.1, 1.0),
                    emphasis: (_emphasis * 1.20).clamp(0.1, 1.0),
                    width: 260,
                    height: 138,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Signal Controls',
            'Trigger focused or burst signals and compare how quickly layout counters climb.',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _triggerSystemFontSignal(_primaryHostKey, 'matrix-a'),
                  icon: const Icon(Icons.radio_button_checked),
                  label: const Text('Signal A'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _triggerSystemFontSignal(_secondaryHostKey, 'matrix-b'),
                  icon: const Icon(Icons.radio_button_checked),
                  label: const Text('Signal B'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _triggerSystemFontSignal(_matrixHostKey, 'matrix-c'),
                  icon: const Icon(Icons.radio_button_checked),
                  label: const Text('Signal C'),
                ),
                OutlinedButton.icon(
                  onPressed: _burstSignals,
                  icon: const Icon(Icons.waves),
                  label: const Text('Burst all'),
                ),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _matrixHostKey, 'Matrix host render snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _integratedBoard(ThemeData theme, _Scenario scenario, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'integrated'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Typography Operations Cockpit',
            'Integrated visual workspace to trigger signals, observe hosts, and inspect metrics in one place.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hostPanel(
                  key: _primaryHostKey,
                  title: 'Integrated Main Host',
                  hueShift: 0.21,
                  density: _density,
                  emphasis: _emphasis,
                  width: math.max(220, _hostWidth + 36),
                  height: math.max(140, _hostHeight + 16),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: _burstSignals,
                      icon: const Icon(Icons.wifi_tethering),
                      label: const Text('Run burst'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _triggerSystemFontSignal(_primaryHostKey, 'integrated-primary'),
                      icon: const Icon(Icons.send),
                      label: const Text('Signal main'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _triggerSystemFontSignal(_secondaryHostKey, 'integrated-secondary'),
                      icon: const Icon(Icons.send_to_mobile),
                      label: const Text('Signal compact'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Metrics',
            'Runtime counters that reveal relayout and paint behavior under signal pressure.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final metric in metrics)
                  SizedBox(
                    width: _compactCards ? 220 : 248,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(_compactCards ? 10 : 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(metric.icon),
                                const SizedBox(width: 8),
                                Expanded(child: Text(metric.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(metric.value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text(metric.note),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _guideBoard(ThemeData theme, _Scenario scenario, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'guide'),
          if (_showGuides) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Introduction',
              'Core interpretation of RelayoutWhenSystemFontsChangeMixin in custom render workflows.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in _introduction) _bullet(theme, line),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'Best Practices',
              'Operational guidelines for implementing and debugging font-dependent relayout behavior.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in _bestPractices) _bullet(theme, line),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'FAQ',
              'Frequent questions from integration teams using render-layer typography hosts.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final item in _faq)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.question, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(item.answer),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (_showTimeline) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Timeline',
              'Event stream for profile changes, signal triggers, and host interactions.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('entries: ${_timeline.length} • tick: $_tick • signals: $_signalCount', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Trigger host signals or change controls to populate timeline.')
                  else
                    for (final line in _timeline)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                      ),
                ],
              ),
            ),
          ],
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Metric Digest',
              'Condensed snapshot of the current counters.',
              Column(
                children: [
                  for (final metric in metrics)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(metric.icon, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(metric.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                          Text(metric.value),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _hostPanel({
    required GlobalKey key,
    required String title,
    required double hueShift,
    required double density,
    required double emphasis,
    required double width,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withAlpha(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('d:${density.toStringAsFixed(2)} e:${emphasis.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_cornerRadius),
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _RelayoutHostWidget(
                        key: key,
                        hueShift: hueShift,
                        density: density,
                        emphasis: emphasis,
                        onSignal: _onSignal,
                        onLayout: _onLayout,
                        onPaint: _onPaint,
                        onPointer: _onPointer,
                      ),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _overlayTapCount += 1;
                            _tick += 1;
                            _log('Overlay tapped on "$title".');
                          });
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(8),
                          color: Colors.lightBlue.withAlpha((_overlayOpacity * 255).toInt()),
                          child: const Text('Flutter overlay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                    if (_showGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GridPainter(color: Colors.white.withAlpha(70), step: 20),
                          ),
                        ),
                      ),
                    if (_showNoise)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _NoisePainter(
                              color: Colors.orange.withAlpha(96),
                              amplitude: _noise,
                              tick: _tick,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            _hostTapCount += 1;
                            _tick += 1;
                            _log('Host action tapped on "$title".');
                          });
                        },
                        icon: const Icon(Icons.touch_app),
                        label: const Text('Host action'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _snapshot(ThemeData theme, GlobalKey key, String title) {
    final ro = key.currentContext?.findRenderObject();
    final lines = <String>[
      'renderObject: ${ro?.runtimeType ?? 'null'}',
      if (ro is RenderBox) 'size: ${ro.hasSize ? ro.size : 'no-size'}',
      if (ro is RenderObject) 'attached: ${ro.attached}',
      if (ro is RenderObject) 'depth: ${ro.depth}',
      if (ro is RenderObject) 'needsLayout: ${ro.debugNeedsLayout}',
      if (ro is RenderObject) 'needsPaint: ${ro.debugNeedsPaint}',
      if (ro is _FontRelayoutRenderBox) 'density: ${ro.density.toStringAsFixed(2)}',
      if (ro is _FontRelayoutRenderBox) 'emphasis: ${ro.emphasis.toStringAsFixed(2)}',
      if (ro is _FontRelayoutRenderBox) 'signalMark: ${ro.signalMark}',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.primaryContainer.withAlpha(98),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
            ),
        ],
      ),
    );
  }

  Widget _section(ThemeData theme, String title, String subtitle, String chip) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(176))),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withAlpha(168),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(chip, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _card(ThemeData theme, String title, String subtitle, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface.withAlpha(194),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180))),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(34),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(130)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 11.8, fontWeight: FontWeight.w700)),
    );
  }

  Widget _bullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  List<bool> _single(List<bool> current, int index) {
    final next = List<bool>.filled(current.length, false);
    next[index] = true;
    return next;
  }

  String _boardTitle(int i) {
    const titles = [
      'Mixin Gallery',
      'Layout Lab',
      'Signal Simulator',
      'Integrated Cockpit',
      'Guide + Timeline',
    ];
    return titles[i.clamp(0, titles.length - 1)];
  }
}

class _RelayoutHostWidget extends LeafRenderObjectWidget {
  const _RelayoutHostWidget({
    super.key,
    required this.hueShift,
    required this.density,
    required this.emphasis,
    required this.onSignal,
    required this.onLayout,
    required this.onPaint,
    required this.onPointer,
  });

  final double hueShift;
  final double density;
  final double emphasis;
  final VoidCallback onSignal;
  final VoidCallback onLayout;
  final VoidCallback onPaint;
  final VoidCallback onPointer;

  @override
  _FontRelayoutRenderBox createRenderObject(BuildContext context) {
    return _FontRelayoutRenderBox(
      hueShift: hueShift,
      density: density,
      emphasis: emphasis,
      onSignal: onSignal,
      onLayout: onLayout,
      onPaint: onPaint,
      onPointer: onPointer,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _FontRelayoutRenderBox renderObject) {
    renderObject
      ..hueShift = hueShift
      ..density = density
      ..emphasis = emphasis
      ..onSignal = onSignal
      ..onLayout = onLayout
      ..onPaint = onPaint
      ..onPointer = onPointer;
  }
}

class _FontRelayoutRenderBox extends RenderBox with RelayoutWhenSystemFontsChangeMixin {
  _FontRelayoutRenderBox({
    required double hueShift,
    required double density,
    required double emphasis,
    required this.onSignal,
    required this.onLayout,
    required this.onPaint,
    required this.onPointer,
  })  : _hueShift = hueShift,
        _density = density,
        _emphasis = emphasis;

  VoidCallback onSignal;
  VoidCallback onLayout;
  VoidCallback onPaint;
  VoidCallback onPointer;

  int signalMark = 0;

  double _hueShift;
  double _density;
  double _emphasis;

  double get hueShift => _hueShift;

  set hueShift(double value) {
    if (_hueShift == value) {
      return;
    }
    _hueShift = value;
    markNeedsPaint();
  }

  double get density => _density;

  set density(double value) {
    if (_density == value) {
      return;
    }
    _density = value;
    markNeedsLayout();
  }

  double get emphasis => _emphasis;

  set emphasis(double value) {
    if (_emphasis == value) {
      return;
    }
    _emphasis = value;
    markNeedsLayout();
  }

  @override
  void systemFontsDidChange() {
    signalMark += 1;
    onSignal();
    super.systemFontsDidChange();
  }

  @override
  void performLayout() {
    final width = constraints.constrainWidth(180 + 240 * density);
    final height = constraints.constrainHeight(110 + 150 * (0.25 + emphasis));
    size = Size(width, height);
    onLayout();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      onPointer();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    onPaint();

    final canvas = context.canvas;
    final rect = offset & size;

    final base = HSVColor.fromAHSV(1, 360 * hueShift, 0.55, 0.86).toColor();
    final accent = HSVColor.fromAHSV(1, (360 * hueShift + 58) % 360, 0.62, 0.92).toColor();

    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          base.withAlpha(205),
          accent.withAlpha(178),
          base.withAlpha(158),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.white.withAlpha(150);

    final rrect = RRect.fromRectAndRadius(rect.deflate(1), const Radius.circular(12));
    canvas.drawRRect(rrect, bgPaint);
    canvas.drawRRect(rrect, borderPaint);

    final stripePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withAlpha((70 + emphasis * 90).toInt());

    final rowCount = (4 + density * 8).toInt();
    for (var i = 0; i < rowCount; i++) {
      final y = offset.dy + 12 + i * (size.height - 24) / rowCount;
      final widthFactor = 0.35 + ((i + signalMark) % 7) * 0.08;
      final w = (size.width - 24) * widthFactor.clamp(0.18, 0.96);
      final bar = RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx + 12, y, w, 5),
        const Radius.circular(4),
      );
      canvas.drawRRect(bar, stripePaint);
    }

    final pulsePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.black.withAlpha(90);

    final pulseCount = math.max(1, (signalMark % 6) + 1);
    for (var i = 0; i < pulseCount; i++) {
      final inset = 8.0 + i * 5.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.deflate(inset), const Radius.circular(10)),
        pulsePaint,
      );
    }
  }
}

class _MiniLabel extends StatelessWidget {
  const _MiniLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}

class _GlyphPainter extends CustomPainter {
  _GlyphPainter({required this.a, required this.b, required this.tick});

  final Color a;
  final Color b;
  final int tick;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(41 + tick);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.3 + rnd.nextDouble() * 0.62);
      final y = 8 + i * 8.0;
      p.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.2), const Radius.circular(4)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.tick != tick;
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color, required this.step});

  final Color color;
  final double step;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.step != step;
  }
}

class _NoisePainter extends CustomPainter {
  _NoisePainter({required this.color, required this.amplitude, required this.tick});

  final Color color;
  final double amplitude;
  final int tick;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(700 + tick);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final lines = (8 + amplitude * 24).toInt();
    for (var i = 0; i < lines; i++) {
      final path = Path();
      final startY = random.nextDouble() * size.height;
      path.moveTo(0, startY);
      for (var s = 1; s <= 5; s++) {
        final x = size.width * s / 5;
        final y = startY + math.sin((s + i + tick) * 0.7) * amplitude * 18;
        path.lineTo(x, y.clamp(0, size.height));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NoisePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.amplitude != amplitude || oldDelegate.tick != tick;
  }
}
