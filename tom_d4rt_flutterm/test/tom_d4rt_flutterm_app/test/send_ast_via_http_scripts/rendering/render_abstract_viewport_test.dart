import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const List<_Profile> _profiles = [
  _Profile(
    id: 'harbor',
    name: 'Harbor Desk',
    description: 'Balanced profile for understanding reveal-offset mechanics in viewports.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'nightwatch',
    name: 'Nightwatch',
    description: 'Dark profile for diagnostics-first navigation and viewport geometry tracing.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _Profile(
    id: 'copperfield',
    name: 'Copperfield',
    description: 'Warm profile for tutorial walkthroughs and team onboarding sessions.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _Profile(
    id: 'mintline',
    name: 'Mintline',
    description: 'Readable profile tuned for mixed vertical and horizontal viewport experiments.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    id: 'gallery',
    title: 'Viewport Gallery',
    subtitle: 'Conceptual orientation around RenderAbstractViewport and reveal offset workflows.',
  ),
  _Scenario(
    id: 'vertical',
    title: 'Vertical Reveal Lab',
    subtitle: 'Compute and animate offsets for vertical targets with alignment controls.',
  ),
  _Scenario(
    id: 'horizontal',
    title: 'Horizontal Reveal Rail',
    subtitle: 'Inspect getOffsetToReveal against horizontal surfaces and index jumps.',
  ),
  _Scenario(
    id: 'integrated',
    title: 'Integrated Navigator',
    subtitle: 'Combine dual-axis controls, telemetry, and diagnostics in one workspace.',
  ),
  _Scenario(
    id: 'guide',
    title: 'Guide + Timeline',
    subtitle: 'Instructive notes, FAQs, and chronological event traces.',
  ),
];

const List<_Blueprint> _blueprints = [
  _Blueprint(
    title: 'Targeted Scroll-to-Item',
    role: 'navigation',
    note: 'Use viewport reveal offsets to move a specific render object into view with chosen alignment.',
    emphasis: 0.61,
  ),
  _Blueprint(
    title: 'Context Preservation',
    role: 'ux',
    note: 'Pick alignment values that preserve surrounding context while revealing important nodes.',
    emphasis: 0.42,
  ),
  _Blueprint(
    title: 'Cross-Axis Reveal',
    role: 'layout',
    note: 'Work with both vertical and horizontal viewports using the same reveal abstraction.',
    emphasis: 0.72,
  ),
  _Blueprint(
    title: 'Diagnostics Snapshot',
    role: 'debug',
    note: 'Inspect viewport type and computed offsets before animating to reduce guesswork.',
    emphasis: 0.33,
  ),
  _Blueprint(
    title: 'Scripted Teaching Flows',
    role: 'education',
    note: 'Sequence alignment presets to teach how reveal offsets alter user perception.',
    emphasis: 0.52,
  ),
];

const List<String> _intro = [
  'RenderAbstractViewport is the abstraction that exposes viewport-level reveal calculations for render objects.',
  'A common usage pattern is RenderAbstractViewport.of(targetRenderObject) followed by getOffsetToReveal(...).',
  'This allows deterministic scroll offset computation independent of high-level widget wrappers.',
  'In interpreter bridge tests, the goal is to verify interaction and visual behavior of this mechanism.',
  'This demo presents vertical and horizontal reveal labs with manual controls and metric instrumentation.',
  'The boards emphasize practical usage, not assertion-heavy verification of Flutter internals.',
  'Timeline entries help correlate requested reveal actions with resulting offset changes.',
  'Diagnostics sections capture viewport class and offset values to aid debugging and onboarding.',
];

const List<String> _bestPractices = [
  'Always resolve a target RenderObject before calling RenderAbstractViewport.of to avoid null viewport lookups.',
  'Treat alignment as UX policy: start with 0.0, 0.5, and 1.0 presets, then refine for context retention.',
  'Clamp or validate computed offsets against controller extents before animating in production code.',
  'Expose logs or telemetry in demos so engineers can compare expected and actual reveal trajectories.',
  'Support both axes in toolkits that rely on complex dashboard or carousel navigation patterns.',
  'Use diagnostics snapshots to confirm the viewport class backing your target before measuring offsets.',
  'When teaching this API, pair numeric outputs with visible movement to build intuition quickly.',
  'Prefer clear reveal controls over hidden automatic behavior while debugging scroll issues.',
  'Keep timeline records for repeated reveal actions to identify jitter or redundant motion requests.',
  'Design demos so users can intentionally trigger edge cases near start and end scroll extents.',
];

const List<_Faq> _faq = [
  _Faq(
    question: 'Why not just call ScrollController.animateTo with guessed values?',
    answer: 'RenderAbstractViewport computes reveal offsets relative to actual target geometry, reducing guesswork.',
  ),
  _Faq(
    question: 'Can I use this for horizontal viewports too?',
    answer: 'Yes. getOffsetToReveal accepts an axis parameter and works for both vertical and horizontal arrangements.',
  ),
  _Faq(
    question: 'What does alignment mean?',
    answer: 'Alignment indicates where the target should appear in the viewport: start (0), center (0.5), end (1).',
  ),
  _Faq(
    question: 'What should this demo prove?',
    answer: 'That reveal offsets are computable and visually actionable in interpreter-driven render workflows.',
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
  const _Blueprint({required this.title, required this.role, required this.note, required this.emphasis});

  final String title;
  final String role;
  final String note;
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
  return const _RenderAbstractViewportStudio();
}

class _RenderAbstractViewportStudio extends StatefulWidget {
  const _RenderAbstractViewportStudio();

  @override
  State<_RenderAbstractViewportStudio> createState() => _RenderAbstractViewportStudioState();
}

class _RenderAbstractViewportStudioState extends State<_RenderAbstractViewportStudio> {
  int _profileIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _showDiagnostics = true;
  bool _showTimeline = true;
  bool _showGuide = true;
  bool _showGrid = true;
  bool _showNoise = true;
  bool _compactCards = false;
  bool _autoLog = true;

  double _alignment = 0.5;
  double _overlayOpacity = 0.24;
  double _noise = 0.34;
  double _tileScale = 1.0;

  int _tick = 0;
  int _revealCalls = 0;
  int _verticalRevealCalls = 0;
  int _horizontalRevealCalls = 0;
  int _overlayTapCount = 0;
  int _targetTapCount = 0;
  int _snapshotCount = 0;

  double _lastVerticalOffset = 0;
  double _lastHorizontalOffset = 0;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  final GlobalKey _verticalViewportKey = GlobalKey();
  final GlobalKey _horizontalViewportKey = GlobalKey();

  final List<GlobalKey> _verticalItemKeys = List<GlobalKey>.generate(14, (_) => GlobalKey());
  final List<GlobalKey> _horizontalItemKeys = List<GlobalKey>.generate(14, (_) => GlobalKey());

  int _selectedVerticalIndex = 6;
  int _selectedHorizontalIndex = 6;

  final List<String> _timeline = <String>[];

  void _log(String text) {
    if (!_autoLog) {
      return;
    }
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 48) {
      _timeline.removeRange(48, _timeline.length);
    }
  }

  Future<void> _revealVertical({int? index, double? alignment}) async {
    final targetIndex = index ?? _selectedVerticalIndex;
    final targetAlignment = alignment ?? _alignment;
    final context = _verticalItemKeys[targetIndex].currentContext;
    if (context == null) {
      setState(() {
        _tick += 1;
        _log('Vertical reveal skipped: target context not ready (index=$targetIndex).');
      });
      return;
    }

    final target = context.findRenderObject();
    if (target == null) {
      setState(() {
        _tick += 1;
        _log('Vertical reveal skipped: render object missing (index=$targetIndex).');
      });
      return;
    }

    final viewport = RenderAbstractViewport.of(target);

    final revealed = viewport.getOffsetToReveal(target, targetAlignment, axis: Axis.vertical);
    final offset = revealed.offset.clamp(
      _verticalController.position.minScrollExtent,
      _verticalController.position.maxScrollExtent,
    );

    await _verticalController.animateTo(
      offset,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
    );

    setState(() {
      _selectedVerticalIndex = targetIndex;
      _revealCalls += 1;
      _verticalRevealCalls += 1;
      _lastVerticalOffset = offset;
      _tick += 1;
      _log('Vertical reveal index=$targetIndex alignment=${targetAlignment.toStringAsFixed(2)} offset=${offset.toStringAsFixed(1)}.');
    });
  }

  Future<void> _revealHorizontal({int? index, double? alignment}) async {
    final targetIndex = index ?? _selectedHorizontalIndex;
    final targetAlignment = alignment ?? _alignment;

    final context = _horizontalItemKeys[targetIndex].currentContext;
    if (context == null) {
      setState(() {
        _tick += 1;
        _log('Horizontal reveal skipped: target context not ready (index=$targetIndex).');
      });
      return;
    }

    final target = context.findRenderObject();
    if (target == null) {
      setState(() {
        _tick += 1;
        _log('Horizontal reveal skipped: render object missing (index=$targetIndex).');
      });
      return;
    }

    final viewport = RenderAbstractViewport.of(target);

    final revealed = viewport.getOffsetToReveal(target, targetAlignment, axis: Axis.horizontal);
    final offset = revealed.offset.clamp(
      _horizontalController.position.minScrollExtent,
      _horizontalController.position.maxScrollExtent,
    );

    await _horizontalController.animateTo(
      offset,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
    );

    setState(() {
      _selectedHorizontalIndex = targetIndex;
      _revealCalls += 1;
      _horizontalRevealCalls += 1;
      _lastHorizontalOffset = offset;
      _tick += 1;
      _log('Horizontal reveal index=$targetIndex alignment=${targetAlignment.toStringAsFixed(2)} offset=${offset.toStringAsFixed(1)}.');
    });
  }

  void _captureSnapshot(String source) {
    setState(() {
      _snapshotCount += 1;
      _tick += 1;
      _log('Diagnostics snapshot captured from $source.');
    });
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Reveal calls', value: '$_revealCalls', note: 'all reveal invocations', icon: Icons.navigation),
      _Metric(label: 'Vertical reveals', value: '$_verticalRevealCalls', note: 'vertical viewport reveals', icon: Icons.swap_vert),
      _Metric(label: 'Horizontal reveals', value: '$_horizontalRevealCalls', note: 'horizontal viewport reveals', icon: Icons.swap_horiz),
      _Metric(label: 'Last vertical', value: _lastVerticalOffset.toStringAsFixed(1), note: 'last vertical target offset', icon: Icons.straighten),
      _Metric(label: 'Last horizontal', value: _lastHorizontalOffset.toStringAsFixed(1), note: 'last horizontal target offset', icon: Icons.straighten),
      _Metric(label: 'Overlay taps', value: '$_overlayTapCount', note: 'overlay interactions', icon: Icons.layers),
      _Metric(label: 'Target taps', value: '$_targetTapCount', note: 'target tile interactions', icon: Icons.touch_app),
      _Metric(label: 'Snapshots', value: '$_snapshotCount', note: 'diagnostic snapshots captured', icon: Icons.photo_camera),
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
                Text('RenderAbstractViewport Reveal Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'profile: ${profile.name}  scenario: ${scenario.title}  alignment: ${_alignment.toStringAsFixed(2)}',
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
      width: 410,
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
            Text('Viewport Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Control target selection, reveal alignment, and diagnostics for RenderAbstractViewport workflows.'),
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
              'Mode',
              'Select compact, walkthrough, diagnostics, or teaching emphasis.',
              ToggleButtons(
                isSelected: _modeSelect,
                onPressed: (i) {
                  setState(() {
                    _modeSelect = _single(_modeSelect, i);
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
            _sliderCard(
              label: 'Alignment',
              value: _alignment,
              min: 0,
              max: 1,
              onChanged: (v) => setState(() => _alignment = v),
            ),
            _sliderCard(
              label: 'Tile scale',
              value: _tileScale,
              min: 0.7,
              max: 1.5,
              onChanged: (v) => setState(() => _tileScale = v),
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
              max: 1,
              onChanged: (v) => setState(() => _noise = v),
            ),
            _switchCard(title: 'Show diagnostics', subtitle: 'show viewport snapshots', value: _showDiagnostics, onChanged: (v) => setState(() => _showDiagnostics = v)),
            _switchCard(title: 'Show timeline', subtitle: 'show event stream', value: _showTimeline, onChanged: (v) => setState(() => _showTimeline = v)),
            _switchCard(title: 'Show guide', subtitle: 'show usage guide and faq', value: _showGuide, onChanged: (v) => setState(() => _showGuide = v)),
            _switchCard(title: 'Show grid', subtitle: 'show tile grid overlays', value: _showGrid, onChanged: (v) => setState(() => _showGrid = v)),
            _switchCard(title: 'Show noise', subtitle: 'show dynamic noise overlays', value: _showNoise, onChanged: (v) => setState(() => _showNoise = v)),
            _switchCard(title: 'Compact cards', subtitle: 'use dense metric cards', value: _compactCards, onChanged: (v) => setState(() => _compactCards = v)),
            _switchCard(title: 'Auto log', subtitle: 'record timeline entries automatically', value: _autoLog, onChanged: (v) => setState(() => _autoLog = v)),
            const SizedBox(height: 8),
            _card(
              theme,
              'Quick Reveal Actions',
              'Trigger start/center/end reveals on both axes for fast comparisons.',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: () async {
                      await _revealVertical(alignment: 0);
                      await _revealHorizontal(alignment: 0);
                    },
                    icon: const Icon(Icons.vertical_align_top),
                    label: const Text('Align start'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await _revealVertical(alignment: 0.5);
                      await _revealHorizontal(alignment: 0.5);
                    },
                    icon: const Icon(Icons.align_vertical_center),
                    label: const Text('Align center'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await _revealVertical(alignment: 1);
                      await _revealHorizontal(alignment: 1);
                    },
                    icon: const Icon(Icons.vertical_align_bottom),
                    label: const Text('Align end'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      _captureSnapshot('quick-actions');
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Snapshot'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> _modeSelect = <bool>[true, false, false, false];

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
          Text(subtitle, style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(168))),
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
        return _verticalBoard(theme, scenario);
      case 2:
        return _horizontalBoard(theme, scenario);
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
            'Reveal Blueprints',
            'Representative use cases for RenderAbstractViewport reveal mechanics.',
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
                            Text('role: ${bp.role} • emphasis: ${bp.emphasis.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            Text(bp.note),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _chip('viewport-query', Colors.indigo),
                                _chip('offset-reveal', Colors.teal),
                                _chip('alignment-aware', Colors.deepPurple),
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
            'Vertical Preview Surface',
            'Target index and alignment controls reveal chosen item using RenderAbstractViewport.',
            _verticalSurface(theme),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _verticalViewportKey, 'Vertical viewport snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _verticalBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'vertical'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Vertical Reveal Controls',
            'Select a target index and call RenderAbstractViewport.getOffsetToReveal with active alignment.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _selectedVerticalIndex.toDouble(),
                        min: 0,
                        max: 13,
                        divisions: 13,
                        label: '$_selectedVerticalIndex',
                        onChanged: (v) => setState(() => _selectedVerticalIndex = v.round()),
                      ),
                    ),
                    SizedBox(width: 54, child: Text('$_selectedVerticalIndex')),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _revealVertical(),
                      icon: const Icon(Icons.navigation),
                      label: const Text('Reveal selected'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _revealVertical(index: 0, alignment: 0),
                      icon: const Icon(Icons.vertical_align_top),
                      label: const Text('Reveal first'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _revealVertical(index: 13, alignment: 1),
                      icon: const Icon(Icons.vertical_align_bottom),
                      label: const Text('Reveal last'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _captureSnapshot('vertical-board'),
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Snapshot'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _verticalSurface(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, scenario.title, scenario.subtitle, 'horizontal'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Horizontal Reveal Controls',
            'Use axis=horizontal reveal calculations to navigate the rail accurately.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _selectedHorizontalIndex.toDouble(),
                        min: 0,
                        max: 13,
                        divisions: 13,
                        label: '$_selectedHorizontalIndex',
                        onChanged: (v) => setState(() => _selectedHorizontalIndex = v.round()),
                      ),
                    ),
                    SizedBox(width: 54, child: Text('$_selectedHorizontalIndex')),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _revealHorizontal(),
                      icon: const Icon(Icons.navigation),
                      label: const Text('Reveal selected'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _revealHorizontal(index: 0, alignment: 0),
                      icon: const Icon(Icons.first_page),
                      label: const Text('Reveal first'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _revealHorizontal(index: 13, alignment: 1),
                      icon: const Icon(Icons.last_page),
                      label: const Text('Reveal last'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _captureSnapshot('horizontal-board'),
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Snapshot'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _horizontalSurface(theme),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _snapshot(theme, _horizontalViewportKey, 'Horizontal viewport snapshot'),
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
            'Integrated Reveal Navigator',
            'Vertical and horizontal surfaces together with synchronized reveal controls.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () async {
                        await _revealVertical();
                        await _revealHorizontal();
                      },
                      icon: const Icon(Icons.sync),
                      label: const Text('Reveal both selected'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await _revealVertical(index: math.max(0, _selectedVerticalIndex - 1));
                        await _revealHorizontal(index: math.max(0, _selectedHorizontalIndex - 1));
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Step back'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await _revealVertical(index: math.min(13, _selectedVerticalIndex + 1));
                        await _revealHorizontal(index: math.min(13, _selectedHorizontalIndex + 1));
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Step forward'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _verticalSurface(theme),
                const SizedBox(height: 10),
                _horizontalSurface(theme),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Metrics',
            'Runtime counters for reveal activity and interaction traces.',
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
              'How RenderAbstractViewport participates in reveal-driven navigation.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [for (final line in _intro) _bullet(theme, line)],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'Best Practices',
              'Recommendations for stable reveal flows in production-style UIs.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [for (final line in _bestPractices) _bullet(theme, line)],
              ),
            ),
            const SizedBox(height: 10),
            _card(
              theme,
              'FAQ',
              'Common questions from teams using reveal offsets in custom navigation.',
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
              'Chronological stream of reveal calls and interaction events.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('entries: ${_timeline.length} • tick: $_tick • reveals: $_revealCalls', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Trigger reveal actions to populate timeline.')
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
              'Compact summary of reveal and interaction counters.',
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

  Widget _verticalSurface(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(124),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(128)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              key: _verticalViewportKey,
              controller: _verticalController,
              padding: const EdgeInsets.all(10),
              itemCount: _verticalItemKeys.length,
              itemBuilder: (context, index) {
                final selected = index == _selectedVerticalIndex;
                return Container(
                  key: _verticalItemKeys[index],
                  margin: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedVerticalIndex = index;
                        _targetTapCount += 1;
                        _tick += 1;
                        _log('Vertical tile tapped index=$index.');
                      });
                    },
                    child: Container(
                      height: (66 + (index % 4) * 12) * _tileScale,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: selected
                              ? [
                                  theme.colorScheme.primary.withAlpha(190),
                                  theme.colorScheme.secondary.withAlpha(170),
                                ]
                              : [
                                  theme.colorScheme.surface,
                                  theme.colorScheme.surfaceContainerHigh,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withAlpha(120),
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          CircleAvatar(radius: 14, child: Text('$index', style: const TextStyle(fontSize: 11))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Vertical Target $index',
                              style: TextStyle(fontWeight: FontWeight.w700, color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface),
                            ),
                          ),
                          Text('h ${(66 + (index % 4) * 12).toStringAsFixed(0)}'),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  _overlayTapCount += 1;
                  _tick += 1;
                  _log('Vertical overlay tapped.');
                });
              },
              child: Container(color: Colors.blue.withAlpha((_overlayOpacity * 255).toInt())),
            ),
          ),
          if (_showGrid)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _GridPainter(color: Colors.white.withAlpha(66), step: 22)),
              ),
            ),
          if (_showNoise)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _NoisePainter(color: Colors.orange.withAlpha(86), amplitude: _noise, tick: _tick)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _horizontalSurface(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(124),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(128)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              key: _horizontalViewportKey,
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              itemCount: _horizontalItemKeys.length,
              itemBuilder: (context, index) {
                final selected = index == _selectedHorizontalIndex;
                final width = (140 + (index % 4) * 26) * _tileScale;
                return Container(
                  key: _horizontalItemKeys[index],
                  width: width,
                  margin: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedHorizontalIndex = index;
                        _targetTapCount += 1;
                        _tick += 1;
                        _log('Horizontal tile tapped index=$index.');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: selected
                              ? [
                                  theme.colorScheme.tertiary.withAlpha(180),
                                  theme.colorScheme.primary.withAlpha(180),
                                ]
                              : [
                                  theme.colorScheme.surface,
                                  theme.colorScheme.surfaceContainerHigh,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: selected ? theme.colorScheme.tertiary : theme.colorScheme.outlineVariant.withAlpha(120),
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 16, child: Text('$index', style: const TextStyle(fontSize: 12))),
                          const SizedBox(height: 8),
                          Text('Rail Tile $index', style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('w ${width.toStringAsFixed(0)}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  _overlayTapCount += 1;
                  _tick += 1;
                  _log('Horizontal overlay tapped.');
                });
              },
              child: Container(color: Colors.indigo.withAlpha((_overlayOpacity * 255).toInt())),
            ),
          ),
          if (_showGrid)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _GridPainter(color: Colors.white.withAlpha(66), step: 24)),
              ),
            ),
          if (_showNoise)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _NoisePainter(color: Colors.orange.withAlpha(86), amplitude: _noise, tick: _tick + 3)),
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
      if (ro is RenderObject) 'attached: ${ro.attached}',
      if (ro is RenderObject) 'depth: ${ro.depth}',
      if (ro is RenderObject) 'needsLayout: ${ro.debugNeedsLayout}',
      if (ro is RenderObject) 'needsPaint: ${ro.debugNeedsPaint}',
      if (ro != null) 'viewportFromOf: ${RenderAbstractViewport.of(ro).runtimeType}',
      'selectedVertical: $_selectedVerticalIndex',
      'selectedHorizontal: $_selectedHorizontalIndex',
      'alignment: ${_alignment.toStringAsFixed(2)}',
      'lastVerticalOffset: ${_lastVerticalOffset.toStringAsFixed(1)}',
      'lastHorizontalOffset: ${_lastHorizontalOffset.toStringAsFixed(1)}',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.primaryContainer.withAlpha(102),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
              OutlinedButton(
                onPressed: () => _captureSnapshot(title),
                child: const Text('capture'),
              ),
            ],
          ),
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
      'Viewport Gallery',
      'Vertical Reveal Lab',
      'Horizontal Reveal Rail',
      'Integrated Navigator',
      'Guide + Timeline',
    ];
    return labels[index.clamp(0, labels.length - 1)];
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
    final rnd = math.Random(37 + tick);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final y = 8 + i * 8.0;
      final w = size.width * (0.32 + rnd.nextDouble() * 0.6);
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
    final random = math.Random(802 + tick);
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
