import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const List<String> _introNotes = [
  'PlatformViewRenderBox is the render-layer primitive behind platform view embedding in Flutter rendering.',
  'It is useful when you need low-level control around layout, hit-testing, and composition behavior of native surfaces.',
  'This studio demonstrates constructor variations, behavioral changes, and render diagnostics with visual panels.',
  'Focus is on interpreter interaction and visual understanding, not asserting Flutter internals.',
  'Each board in this demo highlights a different practical concern: sizing, gestures, clipping, and integrated use.',
  'Use this class carefully in advanced rendering integrations where widget-level wrappers are not sufficient.',
];

const List<String> _bestPracticeTips = [
  'Keep controller ownership explicit; avoid mixing unrelated view identifiers in one host subtree.',
  'Choose PlatformViewHitTestBehavior based on overlay semantics and expected pointer transparency.',
  'Model gesture recognizer sets per scenario instead of using one global set for all native surfaces.',
  'Treat layout constraints as first-class concerns: native surfaces should be clipped and sized intentionally.',
  'Use diagnostics snapshots to teach integration teams what changed after each interaction.',
  'Prefer visual guides and telemetry over large assertion blocks in interpreter bridge demos.',
  'When debugging interaction conflicts, compare overlay taps versus platform-surface taps side-by-side.',
  'Document the reason for each hit-test behavior choice in production code reviews.',
];

const List<_FaqItem> _faqItems = [
  _FaqItem(
    question: 'Why use PlatformViewRenderBox directly?',
    answer:
        'Direct usage enables advanced render-layer composition and custom host widgets when default platform-view widgets are too high level.',
  ),
  _FaqItem(
    question: 'What is the controller responsible for?',
    answer:
        'PlatformViewController provides the connection to platform-view lifecycle methods and pointer dispatch behavior.',
  ),
  _FaqItem(
    question: 'How does hit-test behavior affect UX?',
    answer:
        'It determines whether pointers are absorbed, shared, or passed through relative to Flutter overlays.',
  ),
  _FaqItem(
    question: 'What should this demo verify?',
    answer:
        'That PlatformViewRenderBox instances can be created, updated, and reasoned about visually in interpreter workflows.',
  ),
];

const List<_PresetProfile> _profiles = [
  _PresetProfile(
    id: 'control-room',
    name: 'Control Room',
    description: 'Balanced profile for mixed diagnostics and visual clarity.',
    seed: Color(0xFF0B84F3),
    brightness: Brightness.light,
  ),
  _PresetProfile(
    id: 'night-ops',
    name: 'Night Ops',
    description: 'High-contrast profile for lifecycle tracing in dark conditions.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _PresetProfile(
    id: 'orchid-lab',
    name: 'Orchid Lab',
    description: 'Exploration profile to compare behaviors and gesture recognizers.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _PresetProfile(
    id: 'mint-review',
    name: 'Mint Review',
    description: 'Readable profile for walkthroughs and training sessions.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario(
    id: 'gallery',
    name: 'Constructor Gallery',
    subtitle: 'Create multiple PlatformViewRenderBox hosts with varying behavior/gesture sets.',
  ),
  _Scenario(
    id: 'layout',
    name: 'Layout Lab',
    subtitle: 'Stress width, height, and clipping envelopes with responsive host panels.',
  ),
  _Scenario(
    id: 'hit-test',
    name: 'Hit-Test Matrix',
    subtitle: 'Compare opaque, translucent, and transparent modes against Flutter overlays.',
  ),
  _Scenario(
    id: 'integrated',
    name: 'Integrated Cockpit',
    subtitle: 'Combine controls, visual surfaces, telemetry, and instructive notes in one board.',
  ),
  _Scenario(
    id: 'guide',
    name: 'Guide & Timeline',
    subtitle: 'Practical guidance, FAQ, and action timeline for real integration teams.',
  ),
];

const List<_HostBlueprint> _hostBlueprints = [
  _HostBlueprint(
    name: 'Hero Surface',
    viewId: 301,
    behavior: PlatformViewHitTestBehavior.opaque,
    icon: Icons.slideshow,
    role: 'media',
    note: 'Large top-level native viewport for rich content playback.',
  ),
  _HostBlueprint(
    name: 'Mini Map',
    viewId: 302,
    behavior: PlatformViewHitTestBehavior.translucent,
    icon: Icons.map,
    role: 'navigation',
    note: 'Compact map that can share gestures with Flutter overlay controls.',
  ),
  _HostBlueprint(
    name: 'Capture View',
    viewId: 303,
    behavior: PlatformViewHitTestBehavior.opaque,
    icon: Icons.videocam,
    role: 'camera',
    note: 'Native camera preview with strict pointer ownership.',
  ),
  _HostBlueprint(
    name: 'Info Web Panel',
    viewId: 304,
    behavior: PlatformViewHitTestBehavior.transparent,
    icon: Icons.public,
    role: 'web',
    note: 'Passive information pane where Flutter overlays should keep priority.',
  ),
  _HostBlueprint(
    name: 'Telemetry Tile',
    viewId: 305,
    behavior: PlatformViewHitTestBehavior.translucent,
    icon: Icons.graphic_eq,
    role: 'telemetry',
    note: 'Compact tile for native-driven status widgets in a shared pointer surface.',
  ),
];

class _PresetProfile {
  const _PresetProfile({
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
  const _Scenario({required this.id, required this.name, required this.subtitle});

  final String id;
  final String name;
  final String subtitle;
}

class _HostBlueprint {
  const _HostBlueprint({
    required this.name,
    required this.viewId,
    required this.behavior,
    required this.icon,
    required this.role,
    required this.note,
  });

  final String name;
  final int viewId;
  final PlatformViewHitTestBehavior behavior;
  final IconData icon;
  final String role;
  final String note;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

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
  return const _PlatformViewRenderBoxStudio();
}

class _PlatformViewRenderBoxStudio extends StatefulWidget {
  const _PlatformViewRenderBoxStudio();

  @override
  State<_PlatformViewRenderBoxStudio> createState() => _PlatformViewRenderBoxStudioState();
}

class _PlatformViewRenderBoxStudioState extends State<_PlatformViewRenderBoxStudio> {
  int _profileIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  double _surfaceWidth = 320;
  double _surfaceHeight = 190;
  double _overlayOpacity = 0.35;
  double _noise = 0.4;
  double _cornerRadius = 16;

  bool _showDiagnostics = true;
  bool _compactMetrics = false;
  bool _showGuides = true;
  bool _showTimeline = true;
  bool _showClipMask = true;
  bool _autoLog = true;
  bool _showGrid = true;

  PlatformViewHitTestBehavior _activeBehavior = PlatformViewHitTestBehavior.opaque;

  List<bool> _boardModes = <bool>[true, false, false, false];
  List<bool> _gestureModes = <bool>[true, false, true, false];

  int _tick = 0;
  int _constructCount = 0;
  int _updateBehaviorCount = 0;
  int _updateRecognizerCount = 0;
  int _overlayTapCount = 0;
  int _surfaceTapCount = 0;
  int _controllerCreateCount = 0;
  int _controllerDisposeCount = 0;
  int _controllerClearFocusCount = 0;
  int _controllerDispatchCount = 0;

  late _DemoPlatformViewController _controller;
  late Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers;

  final GlobalKey _mainHostKey = GlobalKey();
  final GlobalKey _secondaryHostKey = GlobalKey();
  final GlobalKey _matrixHostKey = GlobalKey();

  final List<String> _timeline = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = _DemoPlatformViewController(viewId: 900);
    _gestureRecognizers = _buildGestureSet(0);
    _controller.onCreate = _onControllerCreate;
    _controller.onDispose = _onControllerDispose;
    _controller.onClearFocus = _onControllerClearFocus;
    _controller.onDispatch = _onControllerDispatch;
    _constructCount += 1;
    _event('Initialized controller viewId=${_controller.viewId} with initial recognizers.');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _event(String message) {
    if (!_autoLog) {
      return;
    }
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $message');
    if (_timeline.length > 40) {
      _timeline.removeRange(40, _timeline.length);
    }
  }

  void _onControllerCreate(Size? size, Offset? position) {
    setState(() {
      _controllerCreateCount += 1;
      _tick += 1;
      _event('controller.create called size=${size ?? '-'} position=${position ?? '-'}');
    });
  }

  void _onControllerDispose() {
    setState(() {
      _controllerDisposeCount += 1;
      _tick += 1;
      _event('controller.dispose called.');
    });
  }

  void _onControllerClearFocus() {
    setState(() {
      _controllerClearFocusCount += 1;
      _tick += 1;
      _event('controller.clearFocus called.');
    });
  }

  void _onControllerDispatch(PointerEvent event) {
    setState(() {
      _controllerDispatchCount += 1;
      _tick += 1;
      _event('controller.dispatchPointerEvent ${event.runtimeType}');
    });
  }

  void _switchController(int viewId) {
    setState(() {
      _controller = _DemoPlatformViewController(viewId: viewId);
      _controller.onCreate = _onControllerCreate;
      _controller.onDispose = _onControllerDispose;
      _controller.onClearFocus = _onControllerClearFocus;
      _controller.onDispatch = _onControllerDispatch;
      _constructCount += 1;
      _tick += 1;
      _event('Switched controller to viewId=$viewId.');
    });
  }

  Set<Factory<OneSequenceGestureRecognizer>> _buildGestureSet(int modeIndex) {
    if (modeIndex == 0) {
      return <Factory<OneSequenceGestureRecognizer>>{
        Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
      };
    }
    if (modeIndex == 1) {
      return <Factory<OneSequenceGestureRecognizer>>{
        Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
        Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()),
      };
    }
    if (modeIndex == 2) {
      return <Factory<OneSequenceGestureRecognizer>>{
        Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
      };
    }
    return <Factory<OneSequenceGestureRecognizer>>{};
  }

  void _setBehavior(PlatformViewHitTestBehavior behavior) {
    setState(() {
      _activeBehavior = behavior;
      _updateBehaviorCount += 1;
      _tick += 1;
      _event('Updated hitTestBehavior to ${behavior.name}.');
    });
  }

  void _setGestureMode(int index) {
    setState(() {
      _gestureModes = _singleSelect(_gestureModes, index);
      _gestureRecognizers = _buildGestureSet(index);
      _updateRecognizerCount += 1;
      _tick += 1;
      _event('Gesture recognizer mode switched to index=$index.');
    });
  }

  void _simulateControllerCalls() {
    _controller.create(
      size: Size(_surfaceWidth, _surfaceHeight),
      position: Offset(_cornerRadius, _cornerRadius),
    );
    _controller.clearFocus();
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profiles[_profileIndex];
    final scenario = _scenarios[_scenarioIndex];
    final scheme = ColorScheme.fromSeed(seedColor: profile.seed, brightness: profile.brightness);
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: _compactMetrics ? VisualDensity.compact : VisualDensity.standard,
    );

    final metrics = _metrics();

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
                      child: _board(theme, scenario, metrics),
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

  Widget _header(ThemeData theme, _PresetProfile profile, _Scenario scenario) {
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.surface,
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
            ),
            child: CustomPaint(
              painter: _RenderGlyphPainter(
                a: profile.seed,
                b: theme.colorScheme.tertiary,
                tick: _tick,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PlatformViewRenderBox Render Lab', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'profile: ${profile.name}  scenario: ${scenario.name}  behavior: ${_activeBehavior.name}',
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
            Text('Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Tune constructor inputs, hit-testing behavior, gesture sets, and visual diagnostics.'),
            const SizedBox(height: 10),
            _dropdownCard(
              label: 'Profile',
              value: _profileIndex,
              items: _profiles.map((e) => e.name).toList(),
              onChanged: (value) {
                setState(() {
                  _profileIndex = value;
                  _tick += 1;
                  _event('Profile switched to ${_profiles[value].name}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Scenario',
              value: _scenarioIndex,
              items: _scenarios.map((e) => e.name).toList(),
              onChanged: (value) {
                setState(() {
                  _scenarioIndex = value;
                  _boardIndex = value;
                  _tick += 1;
                  _event('Scenario switched to ${_scenarios[value].name}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Board',
              value: _boardIndex,
              items: List.generate(5, _boardLabel),
              onChanged: (value) {
                setState(() {
                  _boardIndex = value;
                  _tick += 1;
                  _event('Board switched to ${_boardLabel(value)}.');
                });
              },
            ),
            _card(
              theme,
              'Presentation Mode',
              'Switch between compact, walkthrough, diagnostics, and teaching density.',
              ToggleButtons(
                isSelected: _boardModes,
                onPressed: (index) {
                  setState(() {
                    _boardModes = _singleSelect(_boardModes, index);
                    _tick += 1;
                    _event('Presentation mode switched to index=$index.');
                  });
                },
                children: const [
                  _MiniTag(icon: Icons.fit_screen, text: 'Compact'),
                  _MiniTag(icon: Icons.menu_book, text: 'Walkthrough'),
                  _MiniTag(icon: Icons.query_stats, text: 'Diagnostics'),
                  _MiniTag(icon: Icons.school, text: 'Teaching'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _card(
              theme,
              'Hit-Test Behavior',
              'Control PlatformViewRenderBox.hitTestBehavior and compare overlay interactions.',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('opaque'),
                    selected: _activeBehavior == PlatformViewHitTestBehavior.opaque,
                    onSelected: (_) => _setBehavior(PlatformViewHitTestBehavior.opaque),
                  ),
                  ChoiceChip(
                    label: const Text('translucent'),
                    selected: _activeBehavior == PlatformViewHitTestBehavior.translucent,
                    onSelected: (_) => _setBehavior(PlatformViewHitTestBehavior.translucent),
                  ),
                  ChoiceChip(
                    label: const Text('transparent'),
                    selected: _activeBehavior == PlatformViewHitTestBehavior.transparent,
                    onSelected: (_) => _setBehavior(PlatformViewHitTestBehavior.transparent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _card(
              theme,
              'Gesture Recognizers',
              'Update recognizer set passed to PlatformViewRenderBox and monitor update counts.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButtons(
                    isSelected: _gestureModes,
                    onPressed: _setGestureMode,
                    children: const [
                      _MiniTag(icon: Icons.touch_app, text: 'Tap'),
                      _MiniTag(icon: Icons.timer, text: 'Tap+Long'),
                      _MiniTag(icon: Icons.pan_tool, text: 'Pan'),
                      _MiniTag(icon: Icons.block, text: 'None'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Active recognizers: ${_gestureSummary()}'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _sliderCard(
              label: 'Surface width',
              value: _surfaceWidth,
              min: 180,
              max: 520,
              onChanged: (value) => setState(() => _surfaceWidth = value),
            ),
            _sliderCard(
              label: 'Surface height',
              value: _surfaceHeight,
              min: 120,
              max: 320,
              onChanged: (value) => setState(() => _surfaceHeight = value),
            ),
            _sliderCard(
              label: 'Overlay opacity',
              value: _overlayOpacity,
              min: 0.05,
              max: 0.95,
              onChanged: (value) => setState(() => _overlayOpacity = value),
            ),
            _sliderCard(
              label: 'Noise',
              value: _noise,
              min: 0.0,
              max: 1.0,
              onChanged: (value) => setState(() => _noise = value),
            ),
            _sliderCard(
              label: 'Corner radius',
              value: _cornerRadius,
              min: 0,
              max: 40,
              onChanged: (value) => setState(() => _cornerRadius = value),
            ),
            _switchTile(
              title: 'Show diagnostics',
              subtitle: 'Render object snapshots and counters',
              value: _showDiagnostics,
              onChanged: (v) => setState(() => _showDiagnostics = v),
            ),
            _switchTile(
              title: 'Compact metrics',
              subtitle: 'Use denser metric cards',
              value: _compactMetrics,
              onChanged: (v) => setState(() => _compactMetrics = v),
            ),
            _switchTile(
              title: 'Show guides',
              subtitle: 'Display usage guidance and FAQ',
              value: _showGuides,
              onChanged: (v) => setState(() => _showGuides = v),
            ),
            _switchTile(
              title: 'Show timeline',
              subtitle: 'Display event timeline',
              value: _showTimeline,
              onChanged: (v) => setState(() => _showTimeline = v),
            ),
            _switchTile(
              title: 'Show clip mask',
              subtitle: 'Enable clipping overlay in scene boards',
              value: _showClipMask,
              onChanged: (v) => setState(() => _showClipMask = v),
            ),
            _switchTile(
              title: 'Show grid',
              subtitle: 'Overlay diagnostics grid on visual canvases',
              value: _showGrid,
              onChanged: (v) => setState(() => _showGrid = v),
            ),
            _switchTile(
              title: 'Auto log',
              subtitle: 'Log state actions automatically',
              value: _autoLog,
              onChanged: (v) => setState(() => _autoLog = v),
            ),
            const SizedBox(height: 8),
            _card(
              theme,
              'Controller Lifecycle',
              'Manually invoke PlatformViewController lifecycle hooks in this demo.',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: _simulateControllerCalls,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('create + clearFocus'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _controller.dispose(),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('dispose'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _switchController(900 + (_tick % 99)),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('new controller'),
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
    required List<String> items,
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
              for (var i = 0; i < items.length; i++) DropdownMenuItem<int>(value: i, child: Text(items[i])),
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

  Widget _switchTile({
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
          Text(subtitle, style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(170))),
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
          Text('$label: ${value.toStringAsFixed(1)}', style: const TextStyle(fontWeight: FontWeight.w700)),
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
        return _hitTestBoard(theme, scenario);
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
          _sectionHeader(theme, scenario.name, scenario.subtitle, 'gallery'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Constructor Blueprint Cards',
            'Each tile illustrates a concrete PlatformViewRenderBox setup with role-specific behavior.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final bp in _hostBlueprints)
                  SizedBox(
                    width: _compactMetrics ? 220 : 250,
                    child: _blueprintCard(theme, bp),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Live Host Surface',
            'Primary PlatformViewRenderBox host rendered via custom RenderObjectWidget.',
            _surfacePanel(
              key: _mainHostKey,
              title: 'Main Host',
              behavior: _activeBehavior,
              width: _surfaceWidth,
              height: _surfaceHeight,
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _renderSnapshot(theme, _mainHostKey, 'Main host render object snapshot'),
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
          _sectionHeader(theme, scenario.name, scenario.subtitle, 'layout'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Sizing Playground',
            'Resize two independent hosts and compare clipping envelopes visually.',
            Column(
              children: [
                _surfacePanel(
                  key: _mainHostKey,
                  title: 'Resizable Host A',
                  behavior: _activeBehavior,
                  width: _surfaceWidth,
                  height: _surfaceHeight,
                ),
                const SizedBox(height: 10),
                _surfacePanel(
                  key: _secondaryHostKey,
                  title: 'Resizable Host B',
                  behavior: PlatformViewHitTestBehavior.translucent,
                  width: math.max(140, _surfaceWidth * 0.72),
                  height: math.max(100, _surfaceHeight * 0.8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Layout Advice',
            'Guidance for choosing constraints and clipping around native surfaces.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(theme, 'Start with explicit min/max constraints; avoid unconstrained surprises in nested rows and stacks.'),
                _bullet(theme, 'Use ClipRRect or ClipRect around platform surfaces when rounded corners or masks are mandatory.'),
                _bullet(theme, 'Do not assume one-size-fits-all: media hosts and telemetry tiles often require different aspect strategies.'),
                _bullet(theme, 'Track size changes in logs to identify costly resize loops during integration.'),
                _bullet(theme, 'Align host dimensions with expected native texture or view resolution for visual sharpness.'),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _renderSnapshot(theme, _secondaryHostKey, 'Secondary host render object snapshot'),
          ],
        ],
      ),
    );
  }

  Widget _hitTestBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(theme, scenario.name, scenario.subtitle, 'hit-test'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Interaction Matrix',
            'Tap overlay chips and host zones to compare event ownership and layering behavior.',
            _interactionMatrix(theme),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Behavior Summary',
            'Quick interpretation of each PlatformViewHitTestBehavior option.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _BehaviorLine(
                  label: 'opaque',
                  detail: 'Platform view wins pointer interactions inside bounds; overlay widgets may not receive taps behind it.',
                ),
                _BehaviorLine(
                  label: 'translucent',
                  detail: 'Pointer interactions can be shared depending on stack arrangement and recognizer participation.',
                ),
                _BehaviorLine(
                  label: 'transparent',
                  detail: 'Flutter overlays can pass through while platform surface remains visually present for composition.',
                ),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _renderSnapshot(theme, _matrixHostKey, 'Matrix host render object snapshot'),
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
          _sectionHeader(theme, scenario.name, scenario.subtitle, 'integrated'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Integrated Native Surface Cockpit',
            'A composite dashboard using PlatformViewRenderBox with overlays, telemetry, and interaction controls.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _surfacePanel(
                  key: _mainHostKey,
                  title: 'Cockpit Main Surface',
                  behavior: _activeBehavior,
                  width: math.max(220, _surfaceWidth + 40),
                  height: math.max(140, _surfaceHeight + 20),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        _simulateControllerCalls();
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Run lifecycle pulse'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _setBehavior(PlatformViewHitTestBehavior.opaque);
                        });
                      },
                      icon: const Icon(Icons.shield),
                      label: const Text('Set opaque'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _setBehavior(PlatformViewHitTestBehavior.translucent);
                        });
                      },
                      icon: const Icon(Icons.layers),
                      label: const Text('Set translucent'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _setBehavior(PlatformViewHitTestBehavior.transparent);
                        });
                      },
                      icon: const Icon(Icons.flip_to_back),
                      label: const Text('Set transparent'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Telemetry Metrics',
            'Operational counters gathered during runtime interactions.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final m in metrics)
                  SizedBox(
                    width: _compactMetrics ? 220 : 248,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(_compactMetrics ? 10 : 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(m.icon),
                                const SizedBox(width: 8),
                                Expanded(child: Text(m.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(m.value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text(m.note),
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
          _sectionHeader(theme, scenario.name, scenario.subtitle, 'guide'),
          const SizedBox(height: 10),
          if (_showGuides)
            _card(
              theme,
              'What This Class Is For',
              'Practical interpretation of PlatformViewRenderBox in real projects.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final note in _introNotes) _bullet(theme, note),
                ],
              ),
            ),
          if (_showGuides) const SizedBox(height: 10),
          if (_showGuides)
            _card(
              theme,
              'Best Practices',
              'Recommendations gathered from rendering-focused integration work.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final tip in _bestPracticeTips) _bullet(theme, tip),
                ],
              ),
            ),
          if (_showGuides) const SizedBox(height: 10),
          if (_showGuides)
            _card(
              theme,
              'FAQ',
              'Common questions when teams start using render-level platform view hosts.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final faq in _faqItems)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(faq.question, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(faq.answer),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          if (_showTimeline) const SizedBox(height: 10),
          if (_showTimeline)
            _card(
              theme,
              'Action Timeline',
              'Chronological log of constructor updates, controller lifecycle calls, and interaction events.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('entries: ${_timeline.length}  •  tick: $_tick', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Use controls and interaction matrix to generate timeline entries.')
                  else
                    for (final line in _timeline)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                      ),
                ],
              ),
            ),
          if (_showDiagnostics) const SizedBox(height: 10),
          if (_showDiagnostics)
            _card(
              theme,
              'Metric Digest',
              'Compact summary of counters at current state.',
              Column(
                children: [
                  for (final m in metrics)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(m.icon, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(m.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                          Text(m.value),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _blueprintCard(ThemeData theme, _HostBlueprint blueprint) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(blueprint.icon, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(blueprint.name, style: const TextStyle(fontWeight: FontWeight.w700))),
              ],
            ),
            const SizedBox(height: 6),
            Text('viewId: ${blueprint.viewId}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('behavior: ${blueprint.behavior.name}'),
            const SizedBox(height: 4),
            Text('role: ${blueprint.role}'),
            const SizedBox(height: 8),
            Text(blueprint.note, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(176))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _pill('controller:${blueprint.viewId}', Colors.indigo),
                _pill('behavior:${blueprint.behavior.name}', Colors.teal),
                _pill('gesture:${_gestureSummaryShort()}', Colors.deepPurple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _surfacePanel({
    required Key key,
    required String title,
    required PlatformViewHitTestBehavior behavior,
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
              Text('behavior=${behavior.name}', style: const TextStyle(fontSize: 12.5)),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_showClipMask ? _cornerRadius : 0),
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    color: Colors.black.withAlpha(100),
                  ),
                  Positioned.fill(
                    child: _PlatformViewRenderBoxHost(
                      key: key,
                      controller: _controller,
                      hitTestBehavior: behavior,
                      gestureRecognizers: _gestureRecognizers,
                    ),
                  ),
                  if (_showGrid)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _GridPainter(color: Colors.white.withAlpha(65), step: 20),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _overlayTapCount += 1;
                          _tick += 1;
                          _event('Overlay tapped for "$title".');
                        });
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        color: Colors.blue.withAlpha((_overlayOpacity * 255).toInt()),
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Flutter overlay area',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  if (_noise > 0)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _NoisePainter(
                            color: Colors.amber.withAlpha(110),
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
                          _surfaceTapCount += 1;
                          _tick += 1;
                          _event('Surface action chip tapped for "$title".');
                        });
                      },
                      icon: const Icon(Icons.touch_app),
                      label: const Text('Surface action'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _interactionMatrix(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final behavior in PlatformViewHitTestBehavior.values)
              SizedBox(
                width: 280,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
                    border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(_iconForBehavior(behavior), size: 18),
                          const SizedBox(width: 8),
                          Text(behavior.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _surfacePanel(
                        key: behavior == PlatformViewHitTestBehavior.opaque
                            ? _mainHostKey
                            : behavior == PlatformViewHitTestBehavior.translucent
                                ? _secondaryHostKey
                                : _matrixHostKey,
                        title: 'Matrix ${behavior.name}',
                        behavior: behavior,
                        width: 255,
                        height: 140,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'overlay taps: $_overlayTapCount • surface action taps: $_surfaceTapCount',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _sectionHeader(ThemeData theme, String title, String subtitle, String chip) {
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
            color: theme.colorScheme.primaryContainer.withAlpha(170),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(chip, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
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

  Widget _renderSnapshot(ThemeData theme, GlobalKey key, String title) {
    final ro = key.currentContext?.findRenderObject();
    final info = <String>[
      'renderObject: ${ro?.runtimeType ?? 'null'}',
      if (ro is RenderBox) 'size: ${ro.hasSize ? ro.size : 'no-size'}',
      if (ro is RenderObject) 'attached: ${ro.attached}',
      if (ro is RenderObject) 'depth: ${ro.depth}',
      if (ro is RenderObject) 'needsLayout: ${ro.debugNeedsLayout}',
      if (ro is RenderObject) 'needsPaint: ${ro.debugNeedsPaint}',
      if (ro is PlatformViewRenderBox) 'hitTestBehavior(state): ${_activeBehavior.name}',
      if (ro is PlatformViewRenderBox) 'controller.viewId: ${ro.controller.viewId}',
      if (ro is PlatformViewRenderBox) 'alwaysNeedsCompositing: ${ro.alwaysNeedsCompositing}',
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
          for (final line in info)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
            ),
        ],
      ),
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

  Widget _pill(String text, Color color) {
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

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Constructors', value: '$_constructCount', note: 'controller/host constructions', icon: Icons.add_box),
      _Metric(label: 'Behavior updates', value: '$_updateBehaviorCount', note: 'hitTestBehavior changes', icon: Icons.swap_horiz),
      _Metric(label: 'Recognizer updates', value: '$_updateRecognizerCount', note: 'gesture set updates', icon: Icons.gesture),
      _Metric(label: 'Overlay taps', value: '$_overlayTapCount', note: 'flutter overlay interactions', icon: Icons.filter_center_focus),
      _Metric(label: 'Surface taps', value: '$_surfaceTapCount', note: 'surface action chip taps', icon: Icons.touch_app),
      _Metric(label: 'create calls', value: '$_controllerCreateCount', note: 'controller.create invocations', icon: Icons.play_arrow),
      _Metric(label: 'clearFocus calls', value: '$_controllerClearFocusCount', note: 'controller.clearFocus invocations', icon: Icons.center_focus_weak),
      _Metric(label: 'dispose calls', value: '$_controllerDisposeCount', note: 'controller.dispose invocations', icon: Icons.delete_outline),
      _Metric(label: 'dispatch calls', value: '$_controllerDispatchCount', note: 'dispatchPointerEvent count', icon: Icons.input),
      _Metric(label: 'Tick', value: '$_tick', note: 'state progression marker', icon: Icons.timeline),
    ];
  }

  String _gestureSummary() {
    if (_gestureModes[0]) {
      return 'TapGestureRecognizer';
    }
    if (_gestureModes[1]) {
      return 'Tap + LongPress';
    }
    if (_gestureModes[2]) {
      return 'PanGestureRecognizer';
    }
    return 'none';
  }

  String _gestureSummaryShort() {
    if (_gestureModes[0]) {
      return 'tap';
    }
    if (_gestureModes[1]) {
      return 'tap+long';
    }
    if (_gestureModes[2]) {
      return 'pan';
    }
    return 'none';
  }

  String _boardLabel(int index) {
    const labels = [
      'Constructor Gallery',
      'Layout Lab',
      'Hit-Test Matrix',
      'Integrated Cockpit',
      'Guide + Timeline',
    ];
    return labels[index.clamp(0, labels.length - 1)];
  }

  List<bool> _singleSelect(List<bool> values, int active) {
    final next = List<bool>.filled(values.length, false);
    next[active] = true;
    return next;
  }

  IconData _iconForBehavior(PlatformViewHitTestBehavior behavior) {
    switch (behavior) {
      case PlatformViewHitTestBehavior.opaque:
        return Icons.shield;
      case PlatformViewHitTestBehavior.translucent:
        return Icons.layers;
      case PlatformViewHitTestBehavior.transparent:
        return Icons.flip_to_back;
    }
  }
}

class _PlatformViewRenderBoxHost extends LeafRenderObjectWidget {
  const _PlatformViewRenderBoxHost({
    super.key,
    required this.controller,
    required this.hitTestBehavior,
    required this.gestureRecognizers,
  });

  final PlatformViewController controller;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  @override
  PlatformViewRenderBox createRenderObject(BuildContext context) {
    return PlatformViewRenderBox(
      controller: controller,
      hitTestBehavior: hitTestBehavior,
      gestureRecognizers: gestureRecognizers,
    );
  }

  @override
  void updateRenderObject(BuildContext context, PlatformViewRenderBox renderObject) {
    renderObject
      ..controller = controller
      ..hitTestBehavior = hitTestBehavior
      ..updateGestureRecognizers(gestureRecognizers);
  }
}

class _DemoPlatformViewController extends PlatformViewController {
  _DemoPlatformViewController({required this.viewId});

  @override
  final int viewId;

  @override
  bool awaitingCreation = false;

  void Function(Size? size, Offset? position)? onCreate;
  VoidCallback? onDispose;
  VoidCallback? onClearFocus;
  void Function(PointerEvent event)? onDispatch;

  @override
  Future<void> create({Size? size, Offset? position}) async {
    awaitingCreation = false;
    onCreate?.call(size, position);
  }

  @override
  Future<void> dispose() async {
    onDispose?.call();
  }

  @override
  Future<void> clearFocus() async {
    onClearFocus?.call();
  }

  @override
  Future<void> dispatchPointerEvent(PointerEvent event) async {
    onDispatch?.call(event);
  }
}

class _MiniTag extends StatelessWidget {
  const _MiniTag({required this.icon, required this.text});

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

class _BehaviorLine extends StatelessWidget {
  const _BehaviorLine({required this.label, required this.detail});

  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(child: Text(detail)),
        ],
      ),
    );
  }
}

class _RenderGlyphPainter extends CustomPainter {
  _RenderGlyphPainter({required this.a, required this.b, required this.tick});

  final Color a;
  final Color b;
  final int tick;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(77 + tick);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      paint.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      final y = 8 + i * 8.0;
      final width = size.width * (0.36 + random.nextDouble() * 0.52);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, width, 5.4), const Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RenderGlyphPainter oldDelegate) {
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
    final random = math.Random(999 + tick);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final lines = (8 + amplitude * 26).toInt();
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
