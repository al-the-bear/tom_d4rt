import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_Profile> _profiles = [
  _Profile(
    id: 'beacon',
    name: 'Beacon Control',
    description: 'Balanced profile for studying pointer absorption pathways in layered hosts.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'midnight',
    name: 'Midnight Relay',
    description: 'High-contrast diagnostics profile for event-routing analysis.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _Profile(
    id: 'amber',
    name: 'Amber Workshop',
    description: 'Warm profile for teaching absorption semantics with clear visual contrast.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'jade',
    name: 'Jade Review',
    description: 'Readable profile for walkthrough sessions and onboarding demos.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    id: 'gallery',
    title: 'Gate Gallery',
    subtitle: 'Visual summary of what RenderAbsorbPointer does in common integration contexts.',
  ),
  _Scenario(
    id: 'matrix',
    title: 'Absorption Matrix',
    subtitle: 'Side-by-side comparison of absorbing ON/OFF and mixed configurations.',
  ),
  _Scenario(
    id: 'lab',
    title: 'Interaction Lab',
    subtitle: 'Live pointer experiments with toggles, overlays, and event counters.',
  ),
  _Scenario(
    id: 'integrated',
    title: 'Integrated Cockpit',
    subtitle: 'Comprehensive dashboard combining controls, hosts, metrics, and diagnostics.',
  ),
  _Scenario(
    id: 'guide',
    title: 'Guide + Timeline',
    subtitle: 'Instructional notes, FAQ, and chronological event stream.',
  ),
];

const List<_Blueprint> _blueprints = [
  _Blueprint(
    title: 'Modal Safety Shield',
    role: 'blocking',
    note: 'Absorb pointer input behind a transient modal to prevent accidental interactions.',
    absorbing: true,
    emphasis: 0.84,
  ),
  _Blueprint(
    title: 'Passive Overlay',
    role: 'decorative',
    note: 'Display visuals above content while still allowing pointer input to underlying targets.',
    absorbing: false,
    emphasis: 0.22,
  ),
  _Blueprint(
    title: 'Workflow Pause Layer',
    role: 'safety',
    note: 'Temporarily block child pointer events during sensitive state transitions.',
    absorbing: true,
    emphasis: 0.56,
  ),
  _Blueprint(
    title: 'Training Sandbox',
    role: 'teaching',
    note: 'Toggle absorbing repeatedly to teach event flow to new engineers.',
    absorbing: false,
    emphasis: 0.39,
  ),
  _Blueprint(
    title: 'Signal Guard Rail',
    role: 'validation',
    note: 'Prevent undesired interactions while asynchronous operations settle.',
    absorbing: true,
    emphasis: 0.71,
  ),
];

const List<String> _intro = [
  'RenderAbsorbPointer is a render-layer gate that can absorb pointer events for its child subtree.',
  'When absorbing is true, descendants do not receive pointer events from hit testing.',
  'This is useful when a workflow needs temporary interaction lockout without removing visuals.',
  'The class is ideal for render-level control in custom widgets and advanced integration surfaces.',
  'This demo focuses on visual, interactive behavior in the interpreter rather than assertion-heavy API checks.',
  'Multiple boards show matrix comparisons, live toggles, and integrated dashboards for practical understanding.',
  'Counters track child and shell taps to make pointer flow outcomes obvious.',
  'Diagnostics snapshots help confirm render object state while interacting with controls.',
];

const List<String> _bestPractices = [
  'Use RenderAbsorbPointer when you need to freeze child interactions while keeping child visuals visible.',
  'Expose clear UI cues when absorption is active so users understand why taps are ignored.',
  'Pair absorption controls with metrics to verify event-routing behavior under different overlays.',
  'Avoid overusing absorption as a global state; scope it to specific regions and transition windows.',
  'Test absorbing true/false side-by-side to prevent unexpected regressions in gesture behavior.',
  'Keep host diagnostics nearby when teaching or debugging pointer-routing issues.',
  'Document expected behavior in onboarding demos, especially with layered stacks and overlays.',
  'Use integrated dashboards to observe interaction counts over time instead of relying on print-only output.',
  'When available, use timelines to correlate toggles with user-reported interaction lockouts.',
  'Treat visual demonstration as the source of truth for interpreter bridge confidence.',
];

const List<_Faq> _faq = [
  _Faq(
    question: 'What is the main effect of absorbing=true?',
    answer: 'Child render objects stop receiving pointer events from hit testing while visuals remain rendered.',
  ),
  _Faq(
    question: 'Does this replace gesture detectors?',
    answer: 'No. It complements gesture logic by controlling whether the subtree receives pointer input at all.',
  ),
  _Faq(
    question: 'When should I toggle absorption dynamically?',
    answer: 'During transitions, async operations, or temporary lock states where accidental input must be blocked.',
  ),
  _Faq(
    question: 'Why use a render-level demo here?',
    answer: 'This repository validates interpreter interactions at low-level Flutter rendering primitives.',
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

class _Blueprint {
  const _Blueprint({
    required this.title,
    required this.role,
    required this.note,
    required this.absorbing,
    required this.emphasis,
  });

  final String title;
  final String role;
  final String note;
  final bool absorbing;
  final double emphasis;
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
  return const _RenderAbsorbPointerStudio();
}

class _RenderAbsorbPointerStudio extends StatefulWidget {
  const _RenderAbsorbPointerStudio();

  @override
  State<_RenderAbsorbPointerStudio> createState() => _RenderAbsorbPointerStudioState();
}

class _RenderAbsorbPointerStudioState extends State<_RenderAbsorbPointerStudio> {
  int _profileIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _absorbingPrimary = true;
  bool _absorbingSecondary = false;
  bool _absorbingTertiary = true;

  bool _showDiagnostics = true;
  bool _showTimeline = true;
  bool _showGuide = true;
  bool _showGrid = true;
  bool _showNoise = true;
  bool _compactCards = false;
  bool _autoLog = true;

  double _hostWidth = 320;
  double _hostHeight = 180;
  double _cornerRadius = 16;
  double _overlayOpacity = 0.26;
  double _noise = 0.34;
  double _density = 0.56;
  double _accent = 0.47;

  List<bool> _modeSelection = <bool>[true, false, false, false];
  List<bool> _burstSelection = <bool>[true, false, true, false];

  int _tick = 0;
  int _toggleCount = 0;
  int _childTapCount = 0;
  int _shellTapCount = 0;
  int _overlayTapCount = 0;
  int _pointerCount = 0;
  int _layoutCount = 0;
  int _paintCount = 0;

  final List<String> _timeline = <String>[];

  final GlobalKey _primaryKey = GlobalKey();
  final GlobalKey _secondaryKey = GlobalKey();
  final GlobalKey _tertiaryKey = GlobalKey();

  void _log(String text) {
    if (!_autoLog) {
      return;
    }
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 42) {
      _timeline.removeRange(42, _timeline.length);
    }
  }

  void _markPointer(String from) {
    setState(() {
      _pointerCount += 1;
      _tick += 1;
      _log('Pointer observed by $from child render tile.');
    });
  }

  void _markLayout() {
    setState(() {
      _layoutCount += 1;
      _tick += 1;
    });
  }

  void _markPaint() {
    setState(() {
      _paintCount += 1;
    });
  }

  void _togglePrimary() {
    setState(() {
      _absorbingPrimary = !_absorbingPrimary;
      _toggleCount += 1;
      _tick += 1;
      _log('Primary absorbing set to $_absorbingPrimary.');
    });
  }

  void _toggleSecondary() {
    setState(() {
      _absorbingSecondary = !_absorbingSecondary;
      _toggleCount += 1;
      _tick += 1;
      _log('Secondary absorbing set to $_absorbingSecondary.');
    });
  }

  void _toggleTertiary() {
    setState(() {
      _absorbingTertiary = !_absorbingTertiary;
      _toggleCount += 1;
      _tick += 1;
      _log('Tertiary absorbing set to $_absorbingTertiary.');
    });
  }

  void _burstToggles() {
    final loops = _burstSelection[0]
        ? 1
        : _burstSelection[1]
            ? 2
            : _burstSelection[2]
                ? 3
                : 5;

    for (var i = 0; i < loops; i++) {
      _absorbingPrimary = !_absorbingPrimary;
      _absorbingSecondary = !_absorbingSecondary;
      _absorbingTertiary = !_absorbingTertiary;
      _toggleCount += 3;
    }

    setState(() {
      _tick += 1;
      _log('Burst toggles complete: loops=$loops, states=[$_absorbingPrimary,$_absorbingSecondary,$_absorbingTertiary].');
    });
  }

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Toggles', value: '$_toggleCount', note: 'absorbing state changes', icon: Icons.toggle_on),
      _Metric(label: 'Child taps', value: '$_childTapCount', note: 'tap callbacks from child controls', icon: Icons.touch_app),
      _Metric(label: 'Shell taps', value: '$_shellTapCount', note: 'shell container tap count', icon: Icons.crop_square),
      _Metric(label: 'Overlay taps', value: '$_overlayTapCount', note: 'overlay capture interactions', icon: Icons.layers),
      _Metric(label: 'Pointers', value: '$_pointerCount', note: 'pointer events in render tile', icon: Icons.ads_click),
      _Metric(label: 'Layouts', value: '$_layoutCount', note: 'child performLayout invocations', icon: Icons.grid_view),
      _Metric(label: 'Paints', value: '$_paintCount', note: 'child paint invocations', icon: Icons.brush),
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
            theme.colorScheme.secondaryContainer.withAlpha(160),
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
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(132)),
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
                Text('RenderAbsorbPointer Pointer Gate Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'profile: ${profile.name}  scenario: ${scenario.title}  states: [$_absorbingPrimary, $_absorbingSecondary, $_absorbingTertiary]',
                  style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(176), fontWeight: FontWeight.w700),
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
      width: 404,
      margin: const EdgeInsets.fromLTRB(12, 10, 0, 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.surfaceContainerHighest.withAlpha(126),
            theme.colorScheme.surfaceContainer.withAlpha(96),
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
            Text('Gate Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Tune absorbing states, host geometry, overlays, and diagnostics presentation.'),
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
              options: List.generate(5, _boardLabel),
              onChanged: (v) => setState(() {
                _boardIndex = v;
                _tick += 1;
                _log('Board switched to ${_boardLabel(v)}.');
              }),
            ),
            _card(
              theme,
              'Presentation Mode',
              'Switch compact, walkthrough, diagnostics, or teaching emphasis.',
              ToggleButtons(
                isSelected: _modeSelection,
                onPressed: (i) {
                  setState(() {
                    _modeSelection = _single(_modeSelection, i);
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
              'Burst Pattern',
              'Select toggle burst intensity for stress testing event routes.',
              ToggleButtons(
                isSelected: _burstSelection,
                onPressed: (i) {
                  setState(() {
                    _burstSelection = _single(_burstSelection, i);
                    _tick += 1;
                    _log('Burst mode switched to index=$i.');
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
            _switchCard(
              title: 'Primary absorbing',
              subtitle: 'Main host absorb-pointer state',
              value: _absorbingPrimary,
              onChanged: (_) => _togglePrimary(),
            ),
            _switchCard(
              title: 'Secondary absorbing',
              subtitle: 'Second host absorb-pointer state',
              value: _absorbingSecondary,
              onChanged: (_) => _toggleSecondary(),
            ),
            _switchCard(
              title: 'Tertiary absorbing',
              subtitle: 'Third host absorb-pointer state',
              value: _absorbingTertiary,
              onChanged: (_) => _toggleTertiary(),
            ),
            _sliderCard(label: 'Host width', value: _hostWidth, min: 180, max: 560, onChanged: (v) => setState(() => _hostWidth = v)),
            _sliderCard(label: 'Host height', value: _hostHeight, min: 120, max: 320, onChanged: (v) => setState(() => _hostHeight = v)),
            _sliderCard(label: 'Density', value: _density, min: 0.1, max: 1.0, onChanged: (v) => setState(() => _density = v)),
            _sliderCard(label: 'Accent', value: _accent, min: 0.1, max: 1.0, onChanged: (v) => setState(() => _accent = v)),
            _sliderCard(label: 'Overlay opacity', value: _overlayOpacity, min: 0.05, max: 0.9, onChanged: (v) => setState(() => _overlayOpacity = v)),
            _sliderCard(label: 'Noise', value: _noise, min: 0, max: 1.0, onChanged: (v) => setState(() => _noise = v)),
            _sliderCard(label: 'Corner radius', value: _cornerRadius, min: 0, max: 40, onChanged: (v) => setState(() => _cornerRadius = v)),
            _switchCard(title: 'Show diagnostics', subtitle: 'Show render snapshots and counters', value: _showDiagnostics, onChanged: (v) => setState(() => _showDiagnostics = v)),
            _switchCard(title: 'Show timeline', subtitle: 'Show chronological events', value: _showTimeline, onChanged: (v) => setState(() => _showTimeline = v)),
            _switchCard(title: 'Show guide', subtitle: 'Show guide and FAQ', value: _showGuide, onChanged: (v) => setState(() => _showGuide = v)),
            _switchCard(title: 'Show grid', subtitle: 'Show grid overlay on hosts', value: _showGrid, onChanged: (v) => setState(() => _showGrid = v)),
            _switchCard(title: 'Show noise', subtitle: 'Show dynamic noise overlay', value: _showNoise, onChanged: (v) => setState(() => _showNoise = v)),
            _switchCard(title: 'Compact cards', subtitle: 'Use tighter metric cards', value: _compactCards, onChanged: (v) => setState(() => _compactCards = v)),
            _switchCard(title: 'Auto log', subtitle: 'Automatically write timeline entries', value: _autoLog, onChanged: (v) => setState(() => _autoLog = v)),
            const SizedBox(height: 8),
            _card(
              theme,
              'Quick Actions',
              'Trigger common interaction patterns used during absorb-pointer debugging.',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(onPressed: _togglePrimary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle primary')),
                  OutlinedButton.icon(onPressed: _toggleSecondary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle secondary')),
                  OutlinedButton.icon(onPressed: _toggleTertiary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle tertiary')),
                  OutlinedButton.icon(onPressed: _burstToggles, icon: const Icon(Icons.waves), label: const Text('Burst toggles')),
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
            items: [for (var i = 0; i < options.length; i++) DropdownMenuItem<int>(value: i, child: Text(options[i]))],
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
          Text(subtitle, style: TextStyle(color: Colors.black.withAlpha(170), fontSize: 12.5)),
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
        return _matrixBoard(theme, scenario);
      case 2:
        return _labBoard(theme, scenario);
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
            'Pointer Gate Blueprints',
            'Representative usage ideas showing where absorption is enabled or disabled.',
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
                            Text('absorbing: ${bp.absorbing} • emphasis: ${bp.emphasis.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            Text(bp.note),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _chip('render-gate', Colors.indigo),
                                _chip(bp.absorbing ? 'blocked' : 'pass-through', bp.absorbing ? Colors.orange : Colors.green),
                                _chip('pointer-flow', Colors.teal),
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
            'Primary Gate Host',
            'Single host showcasing direct RenderAbsorbPointer behavior with live state.',
            _hostPanel(
              key: _primaryKey,
              title: 'Primary Host',
              absorbing: _absorbingPrimary,
              hueShift: 0.12,
              width: _hostWidth,
              height: _hostHeight,
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _primaryKey, 'Primary host snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _matrixBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'matrix'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Triple Host Matrix',
            'Compare three gates simultaneously with independent absorbing states.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _primaryKey,
                    title: 'Matrix A',
                    absorbing: _absorbingPrimary,
                    hueShift: 0.08,
                    width: 262,
                    height: 138,
                  ),
                ),
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _secondaryKey,
                    title: 'Matrix B',
                    absorbing: _absorbingSecondary,
                    hueShift: 0.42,
                    width: 262,
                    height: 138,
                  ),
                ),
                SizedBox(
                  width: 286,
                  child: _hostPanel(
                    key: _tertiaryKey,
                    title: 'Matrix C',
                    absorbing: _absorbingTertiary,
                    hueShift: 0.74,
                    width: 262,
                    height: 138,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Matrix Actions',
            'Trigger state changes quickly to inspect count differences.',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(onPressed: _togglePrimary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle A')),
                OutlinedButton.icon(onPressed: _toggleSecondary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle B')),
                OutlinedButton.icon(onPressed: _toggleTertiary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle C')),
                OutlinedButton.icon(onPressed: _burstToggles, icon: const Icon(Icons.waves), label: const Text('Burst all')),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _secondaryKey, 'Secondary host snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _labBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'lab'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Live Interaction Lab',
            'Tap overlay, shell, and child controls while toggling absorption to see route changes.',
            Column(
              children: [
                _hostPanel(
                  key: _primaryKey,
                  title: 'Lab Host Primary',
                  absorbing: _absorbingPrimary,
                  hueShift: 0.16,
                  width: _hostWidth,
                  height: _hostHeight,
                ),
                const SizedBox(height: 10),
                _hostPanel(
                  key: _secondaryKey,
                  title: 'Lab Host Secondary',
                  absorbing: _absorbingSecondary,
                  hueShift: 0.58,
                  width: math.max(160, _hostWidth * 0.72),
                  height: math.max(110, _hostHeight * 0.8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Interaction Notes',
            'Observed patterns while testing absorption toggles in layered hosts.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(theme, 'When absorbing=true, child tap activity usually drops because pointer events are intercepted earlier.'),
                _bullet(theme, 'Shell and overlay counters can still move, revealing where taps are rerouted.'),
                _bullet(theme, 'Use matrix comparisons to validate temporary lock states during async workflows.'),
                _bullet(theme, 'Visual overlays help explain pointer ownership to teammates without reading code first.'),
                _bullet(theme, 'Toggle bursts reveal race-like sequences in event streams and counters.'),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _tertiaryKey, 'Tertiary host snapshot'),
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
            'Integrated Pointer Gate Cockpit',
            'Combined controls and host visuals for end-to-end event-flow inspection.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hostPanel(
                  key: _primaryKey,
                  title: 'Integrated Main Host',
                  absorbing: _absorbingPrimary,
                  hueShift: 0.24,
                  width: math.max(220, _hostWidth + 36),
                  height: math.max(140, _hostHeight + 16),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(onPressed: _togglePrimary, icon: const Icon(Icons.toggle_on), label: const Text('Toggle main')),
                    OutlinedButton.icon(onPressed: _burstToggles, icon: const Icon(Icons.waves), label: const Text('Burst sequence')),
                    OutlinedButton.icon(onPressed: _toggleSecondary, icon: const Icon(Icons.layers), label: const Text('Toggle side host')),
                    OutlinedButton.icon(onPressed: _toggleTertiary, icon: const Icon(Icons.view_stream), label: const Text('Toggle matrix host')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Metrics',
            'Live counters for pointer flow, layout, paint, and state transitions.',
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
          if (_showGuide) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Introduction',
              'What RenderAbsorbPointer is for and how it behaves in render-level integration.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [for (final line in _intro) _bullet(theme, line)],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'Best Practices',
              'Recommendations for robust absorption behavior in production-like integrations.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [for (final line in _bestPractices) _bullet(theme, line)],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'FAQ',
              'Common engineering questions about pointer absorption usage patterns.',
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
              'Chronological log of profile changes, toggles, and interaction outcomes.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('entries: ${_timeline.length} • tick: $_tick • toggles: $_toggleCount', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Use controls and host interactions to populate timeline.')
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
              'Compact digest of current runtime counters.',
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
    required bool absorbing,
    required double hueShift,
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
              Text('absorbing=$absorbing'),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                _shellTapCount += 1;
                _tick += 1;
                _log('Shell tapped on "$title".');
              });
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_cornerRadius),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _AbsorbGateHost(
                          key: key,
                          absorbing: absorbing,
                          child: _InteractiveTile(
                            hueShift: hueShift,
                            density: _density,
                            accent: _accent,
                            onPointer: () => _markPointer(title),
                            onLayout: _markLayout,
                            onPaint: _markPaint,
                          ),
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
                            color: Colors.blue.withAlpha((_overlayOpacity * 255).toInt()),
                            child: const Text('Overlay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      if (_showGrid)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(painter: _GridPainter(color: Colors.white.withAlpha(68), step: 20)),
                          ),
                        ),
                      if (_showNoise)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(painter: _NoisePainter(color: Colors.orange.withAlpha(90), amplitude: _noise, tick: _tick)),
                          ),
                        ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: FilledButton.tonalIcon(
                          onPressed: () {
                            setState(() {
                              _childTapCount += 1;
                              _tick += 1;
                              _log('Child action chip tapped on "$title".');
                            });
                          },
                          icon: const Icon(Icons.touch_app),
                          label: const Text('Child action'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _snapshot(ThemeData theme, GlobalKey key, String title) {
    final ctx = key.currentContext;
    final ro = (ctx != null && ctx.mounted) ? ctx.findRenderObject() : null;
    final lines = <String>[
      'renderObject: ${ro?.runtimeType ?? 'null'}',
      if (ro is RenderBox) 'size: ${ro.hasSize ? ro.size : 'no-size'}',
      if (ro is RenderObject) 'attached: ${ro.attached}',
      if (ro is RenderObject) 'depth: ${ro.depth}',
      if (ro is RenderObject) 'needsLayout: ${ro.debugNeedsLayout}',
      if (ro is RenderObject) 'needsPaint: ${ro.debugNeedsPaint}',
      if (ro is RenderAbsorbPointer) 'absorbing: ${ro.absorbing}',
      if (ro is RenderAbsorbPointer) 'hasChild: ${ro.child != null}',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.primaryContainer.withAlpha(100),
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
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11.7)),
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

  List<bool> _single(List<bool> values, int index) {
    final next = List<bool>.filled(values.length, false);
    next[index] = true;
    return next;
  }

  String _boardLabel(int index) {
    const labels = [
      'Gate Gallery',
      'Absorption Matrix',
      'Interaction Lab',
      'Integrated Cockpit',
      'Guide + Timeline',
    ];
    return labels[index.clamp(0, labels.length - 1)];
  }
}

class _AbsorbGateHost extends SingleChildRenderObjectWidget {
  const _AbsorbGateHost({
    super.key,
    required this.absorbing,
    super.child,
  });

  final bool absorbing;

  @override
  RenderAbsorbPointer createRenderObject(BuildContext context) {
    return RenderAbsorbPointer(absorbing: absorbing);
  }

  @override
  void updateRenderObject(BuildContext context, RenderAbsorbPointer renderObject) {
    renderObject.absorbing = absorbing;
  }
}

class _InteractiveTile extends LeafRenderObjectWidget {
  const _InteractiveTile({
    required this.hueShift,
    required this.density,
    required this.accent,
    required this.onPointer,
    required this.onLayout,
    required this.onPaint,
  });

  final double hueShift;
  final double density;
  final double accent;
  final VoidCallback onPointer;
  final VoidCallback onLayout;
  final VoidCallback onPaint;

  @override
  _InteractiveTileRenderBox createRenderObject(BuildContext context) {
    return _InteractiveTileRenderBox(
      hueShift: hueShift,
      density: density,
      accent: accent,
      onPointer: onPointer,
      onLayout: onLayout,
      onPaint: onPaint,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _InteractiveTileRenderBox renderObject) {
    renderObject
      ..hueShift = hueShift
      ..density = density
      ..accent = accent
      ..onPointer = onPointer
      ..onLayout = onLayout
      ..onPaint = onPaint;
  }
}

class _InteractiveTileRenderBox extends RenderBox {
  _InteractiveTileRenderBox({
    required double hueShift,
    required double density,
    required double accent,
    required this.onPointer,
    required this.onLayout,
    required this.onPaint,
  })  : _hueShift = hueShift,
        _density = density,
        _accent = accent;

  VoidCallback onPointer;
  VoidCallback onLayout;
  VoidCallback onPaint;

  double _hueShift;
  double _density;
  double _accent;

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

  double get accent => _accent;

  set accent(double value) {
    if (_accent == value) {
      return;
    }
    _accent = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final width = constraints.constrainWidth(170 + 250 * density);
    final height = constraints.constrainHeight(110 + 120 * (0.2 + accent));
    size = Size(width, height);
    onLayout();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    if (event is PointerDownEvent) {
      onPointer();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    onPaint();

    final canvas = context.canvas;
    final rect = offset & size;

    final base = HSVColor.fromAHSV(1, 360 * hueShift, 0.5, 0.85).toColor();
    final accentColor = HSVColor.fromAHSV(1, (360 * hueShift + 62) % 360, 0.62, 0.92).toColor();

    final bg = Paint()
      ..shader = LinearGradient(
        colors: [
          base.withAlpha(208),
          accentColor.withAlpha(180),
          base.withAlpha(162),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.white.withAlpha(150);

    final rrect = RRect.fromRectAndRadius(rect.deflate(1), const Radius.circular(12));
    canvas.drawRRect(rrect, bg);
    canvas.drawRRect(rrect, border);

    final bars = (4 + density * 8).toInt();
    final barPaint = Paint()..color = Colors.white.withAlpha((80 + accent * 80).toInt());

    for (var i = 0; i < bars; i++) {
      final y = offset.dy + 12 + i * (size.height - 24) / bars;
      final w = (size.width - 24) * (0.3 + ((i % 5) * 0.12));
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(offset.dx + 12, y, w.clamp(26, size.width - 24), 5), const Radius.circular(4)),
        barPaint,
      );
    }

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.black.withAlpha(84);

    final rings = (2 + accent * 4).toInt();
    for (var i = 0; i < rings; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect.deflate(8 + i * 6), const Radius.circular(10)),
        ringPaint,
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
    final rnd = math.Random(51 + tick);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final y = 8 + i * 8.0;
      final w = size.width * (0.34 + rnd.nextDouble() * 0.56);
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
    final random = math.Random(901 + tick);
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
