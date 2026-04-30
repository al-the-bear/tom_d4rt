import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _ArenaZone {
  const _ArenaZone({
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

class _ArenaScenario {
  const _ArenaScenario(this.id, this.title, this.description);

  final String id;
  final String title;
  final String description;
}

class _BehaviorNote {
  const _BehaviorNote(this.behavior, this.summary, this.whenToUse, this.risk);

  final PlatformViewHitTestBehavior behavior;
  final String summary;
  final String whenToUse;
  final String risk;
}

class _Faq {
  const _Faq(this.q, this.a);

  final String q;
  final String a;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

const List<_ArenaZone> _zones = [
  _ArenaZone(
    id: 'dashboard',
    name: 'Dashboard Surface',
    description: 'Balanced style for app-shell interaction layering tests.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _ArenaZone(
    id: 'ops',
    name: 'Ops Surface',
    description: 'High-contrast mode for intense pointer routing diagnostics.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _ArenaZone(
    id: 'lab',
    name: 'Lab Surface',
    description: 'Exploratory profile for behavior switching and edge-case routing.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _ArenaZone(
    id: 'review',
    name: 'Review Surface',
    description: 'Readable presentation mode for training and semantics walkthroughs.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_ArenaScenario> _scenarios = [
  _ArenaScenario('overlay', 'Overlay Stack', 'Platform view overlayed by Flutter widgets with mixed hit routing.'),
  _ArenaScenario('split', 'Split Panels', 'Side-by-side panels comparing behavior modes under identical pointer input.'),
  _ArenaScenario('forms', 'Form Surface', 'Text controls layered with pseudo platform containers and tap targets.'),
  _ArenaScenario('maps', 'Map-like Scene', 'Map/video style interaction where pass-through policy is critical.'),
];

const List<_BehaviorNote> _behaviorNotes = [
  _BehaviorNote(
    PlatformViewHitTestBehavior.opaque,
    'Consumes hit tests inside bounds and prevents targets behind from receiving them.',
    'Use when platform view should be primary interaction owner in its area.',
    'Can block expected Flutter gestures behind the view if overused.',
  ),
  _BehaviorNote(
    PlatformViewHitTestBehavior.translucent,
    'Participates in hit testing while allowing widgets behind to also receive events.',
    'Use when both platform and Flutter layers need coordinated pointer responses.',
    'May create duplicate gesture reactions if not intentionally handled.',
  ),
  _BehaviorNote(
    PlatformViewHitTestBehavior.transparent,
    'Skips hit testing so events pass through to widgets behind the platform view region.',
    'Use for decorative or non-interactive embedded platform layers.',
    'Platform view will not receive interaction even when visibly present.',
  ),
];

const List<String> _guide = [
  'PlatformViewHitTestBehavior controls how embedded platform views participate in hit testing.',
  'opaque captures events in its bounds and blocks behind layers from direct pointer access.',
  'translucent allows both current layer and behind layers to be considered for hit handling.',
  'transparent bypasses hit participation and forwards interaction to widgets behind.',
  'Choose behavior per scene intent, not globally: maps, video overlays, and HUDs often differ.',
  'Always test drag, tap, long-press, and hover patterns when layering platform and Flutter content.',
  'Compare side-by-side boards to spot accidental gesture duplication or blocked controls.',
  'Use clear diagnostics with interaction counters and timeline entries for reproducible verification.',
  'Document behavior rationale near integration points so future refactors preserve interaction policy.',
  'A deep demo should be visual and instructive, not only enum listing or print output.',
];

const List<_Faq> _faq = [
  _Faq('How do I choose between opaque and translucent?', 'Choose opaque for exclusive control, translucent when both layers intentionally react.'),
  _Faq('When is transparent useful?', 'Use transparent for visual-only platform surfaces where Flutter handles all interaction.'),
  _Faq('Can translucent cause duplicate taps?', 'Yes, if both layers process the same event without coordination safeguards.'),
  _Faq('How should I test mixed behavior pages?', 'Run comparative scenes with event counters and verify expected routing under multiple gestures.'),
];

dynamic build(BuildContext context) {
  return const _PlatformViewHitBehaviorStudio();
}

class _PlatformViewHitBehaviorStudio extends StatefulWidget {
  const _PlatformViewHitBehaviorStudio();

  @override
  State<_PlatformViewHitBehaviorStudio> createState() => _PlatformViewHitBehaviorStudioState();
}

class _PlatformViewHitBehaviorStudioState extends State<_PlatformViewHitBehaviorStudio> {
  int _zoneIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  PlatformViewHitTestBehavior _activeBehavior = PlatformViewHitTestBehavior.opaque;

  bool _showDiagnostics = true;
  bool _dense = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _compactCards = false;
  bool _showPointerNoise = true;
  bool _showPassThroughOverlay = true;
  bool _autoLog = true;
  bool _showBehaviorLegend = true;

  double _platformOpacity = 0.82;
  double _overlayDensity = 0.50;
  double _gestureAmplitude = 0.55;

  int _platformHits = 0;
  int _flutterHits = 0;
  int _bothHits = 0;
  int _passThroughHits = 0;
  int _tick = 0;

  List<bool> _behaviorToggle = <bool>[true, false, false];
  List<bool> _routeToggle = <bool>[true, true, false, false, true, false];
  List<bool> _sceneToggle = <bool>[true, false, false, true];

  final List<String> _timeline = <String>[];

  void _event(String text) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 34) {
      _timeline.removeRange(34, _timeline.length);
    }
  }

  void _registerHit({required bool platform, required bool flutter}) {
    setState(() {
      if (platform) {
        _platformHits += 1;
      }
      if (flutter) {
        _flutterHits += 1;
      }
      if (platform && flutter) {
        _bothHits += 1;
      }
      if (!platform && flutter) {
        _passThroughHits += 1;
      }
      _tick += 1;
      if (_autoLog) {
        _event('Hit registered -> platform: $platform flutter: $flutter behavior: ${_activeBehavior.name}.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final zone = _zones[_zoneIndex];
    final scenario = _scenarios[_scenarioIndex];
    final behavior = _activeBehavior;

    final scheme = ColorScheme.fromSeed(seedColor: zone.seed, brightness: zone.brightness);
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: _dense ? VisualDensity.compact : VisualDensity.standard,
    );

    return Theme(
      data: theme,
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            _header(theme, zone, scenario, behavior),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _controlRail(theme),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 12, 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.surface,
                            theme.colorScheme.surfaceContainerHighest.withAlpha(166),
                            theme.colorScheme.surface,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                      ),
                      child: _board(theme, zone, scenario, behavior),
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

  Widget _header(ThemeData theme, _ArenaZone zone, _ArenaScenario scenario, PlatformViewHitTestBehavior behavior) {
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
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(134)),
            ),
            child: CustomPaint(
              painter: _ArenaGlyphPainter(
                a: zone.seed,
                b: theme.colorScheme.tertiary,
                seed: _tick.toDouble(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PlatformViewHitTestBehavior Arena', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'zone: ${zone.name}  scenario: ${scenario.title}  behavior: ${behavior.name}',
                  style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(zone.description, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(174))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlRail(ThemeData theme) {
    return Container(
      width: 390,
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
            Text('Behavior Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Switch hit-test behavior and inspect event routing effects visually.'),
            const SizedBox(height: 10),
            _dropdownCard(
              label: 'Zone',
              value: _zoneIndex,
              options: _zones.map((e) => e.name).toList(),
              onChanged: (v) => setState(() {
                _zoneIndex = v;
                _tick += 1;
                _event('Zone switched to ${_zones[v].name}.');
              }),
            ),
            _dropdownCard(
              label: 'Scenario',
              value: _scenarioIndex,
              options: _scenarios.map((e) => e.title).toList(),
              onChanged: (v) => setState(() {
                _scenarioIndex = v;
                _tick += 1;
                _event('Scenario switched to ${_scenarios[v].title}.');
              }),
            ),
            _dropdownCard(
              label: 'Board',
              value: _boardIndex,
              options: List.generate(5, _boardTitle),
              onChanged: (v) => setState(() {
                _boardIndex = v;
                _tick += 1;
                _event('Board switched to ${_boardTitle(v)}.');
              }),
            ),
            _card(
              theme,
              'Hit-Test Behavior',
              'Choose the active PlatformViewHitTestBehavior for interactive boards.',
              ToggleButtons(
                isSelected: _behaviorToggle,
                onPressed: (i) {
                  setState(() {
                    _behaviorToggle = _single(_behaviorToggle, i);
                    _activeBehavior = PlatformViewHitTestBehavior.values[i];
                    _tick += 1;
                    _event('Active behavior changed to ${_activeBehavior.name}.');
                  });
                },
                children: const [
                  _TinyIconLabel(icon: Icons.block, text: 'opaque'),
                  _TinyIconLabel(icon: Icons.blur_on, text: 'translucent'),
                  _TinyIconLabel(icon: Icons.blur_off, text: 'transparent'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _switchCard(
              title: 'Diagnostics',
              subtitle: 'Show routing counters and behavior metadata',
              value: _showDiagnostics,
              onChanged: (v) => setState(() => _showDiagnostics = v),
            ),
            _switchCard(
              title: 'Dense mode',
              subtitle: 'Compact spacing for crowded interaction boards',
              value: _dense,
              onChanged: (v) => setState(() => _dense = v),
            ),
            _switchCard(
              title: 'Show guide',
              subtitle: 'Display usage guidance and FAQs',
              value: _showGuide,
              onChanged: (v) => setState(() => _showGuide = v),
            ),
            _switchCard(
              title: 'Show timeline',
              subtitle: 'Display event timeline for routing interactions',
              value: _showTimeline,
              onChanged: (v) => setState(() => _showTimeline = v),
            ),
            _switchCard(
              title: 'Compact cards',
              subtitle: 'Use tighter card layouts in integrated scene',
              value: _compactCards,
              onChanged: (v) => setState(() => _compactCards = v),
            ),
            _switchCard(
              title: 'Pointer noise',
              subtitle: 'Overlay simulated pointer traces for stress testing',
              value: _showPointerNoise,
              onChanged: (v) => setState(() => _showPointerNoise = v),
            ),
            _switchCard(
              title: 'Pass-through overlay',
              subtitle: 'Highlight areas where Flutter receives behind-layer taps',
              value: _showPassThroughOverlay,
              onChanged: (v) => setState(() => _showPassThroughOverlay = v),
            ),
            _switchCard(
              title: 'Auto log',
              subtitle: 'Record interaction timeline entries automatically',
              value: _autoLog,
              onChanged: (v) => setState(() => _autoLog = v),
            ),
            _switchCard(
              title: 'Behavior legend',
              subtitle: 'Show side-by-side behavior recommendations',
              value: _showBehaviorLegend,
              onChanged: (v) => setState(() => _showBehaviorLegend = v),
            ),
            _sliderCard(
              label: 'Platform opacity',
              value: _platformOpacity,
              min: 0.35,
              max: 1.0,
              onChanged: (v) => setState(() => _platformOpacity = v),
            ),
            _sliderCard(
              label: 'Overlay density',
              value: _overlayDensity,
              min: 0.1,
              max: 1.0,
              onChanged: (v) => setState(() => _overlayDensity = v),
            ),
            _sliderCard(
              label: 'Gesture amplitude',
              value: _gestureAmplitude,
              min: 0.1,
              max: 1.0,
              onChanged: (v) => setState(() => _gestureAmplitude = v),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(20)),
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
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(160))),
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
        border: Border.all(color: Colors.black.withAlpha(20)),
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

  Widget _board(ThemeData theme, _ArenaZone zone, _ArenaScenario scenario, PlatformViewHitTestBehavior behavior) {
    switch (_boardIndex) {
      case 0:
        return _arenaBoard(theme, scenario, behavior);
      case 1:
        return _routingBoard(theme, behavior);
      case 2:
        return _comparisonBoard(theme);
      case 3:
        return _integratedBoard(theme, zone, scenario, behavior);
      default:
        return _guideBoard(theme, behavior);
    }
  }

  Widget _arenaBoard(ThemeData theme, _ArenaScenario scenario, PlatformViewHitTestBehavior behavior) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Interaction Arena', scenario.description, 'arena'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Layered Hit-Test Stack',
            'Tap the stacked surface and observe how behavior mode routes events between platform and Flutter layers.',
            _layerStack(theme, behavior, height: 290),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Route Toggles',
            'Toggle channels and run event pulses to inspect behavior under noisy pointer conditions.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _routeToggle,
                  onPressed: (i) {
                    setState(() {
                      _routeToggle = _toggle(_routeToggle, i);
                      _tick += 1;
                      _event('Route flag toggled index $i.');
                    });
                  },
                  children: const [
                    _TinyIconLabel(icon: Icons.touch_app, text: 'Tap'),
                    _TinyIconLabel(icon: Icons.swipe, text: 'Drag'),
                    _TinyIconLabel(icon: Icons.pan_tool, text: 'Long'),
                    _TinyIconLabel(icon: Icons.mouse, text: 'Hover'),
                    _TinyIconLabel(icon: Icons.layers, text: 'Stack'),
                    _TinyIconLabel(icon: Icons.timeline, text: 'Trace'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _registerHit(
                        platform: behavior != PlatformViewHitTestBehavior.transparent,
                        flutter: behavior != PlatformViewHitTestBehavior.opaque,
                      ),
                      icon: const Icon(Icons.flash_on),
                      label: const Text('Pulse event'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => setState(() {
                        _platformHits = 0;
                        _flutterHits = 0;
                        _bothHits = 0;
                        _passThroughHits = 0;
                        _tick += 1;
                        _event('Hit counters reset.');
                      }),
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset counters'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Arena Diagnostics', [
              'activeBehavior: ${behavior.name}',
              'platformHits: $_platformHits',
              'flutterHits: $_flutterHits',
              'bothHits: $_bothHits',
              'passThroughHits: $_passThroughHits',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _layerStack(ThemeData theme, PlatformViewHitTestBehavior behavior, {required double height}) {
    return GestureDetector(
      onTap: () {
        final platform = behavior != PlatformViewHitTestBehavior.transparent;
        final flutter = behavior != PlatformViewHitTestBehavior.opaque;
        _registerHit(platform: platform, flutter: flutter);
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha(170),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Flutter Behind Layer\n(receives hits when behavior != opaque)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              right: 40,
              top: 42,
              bottom: 42,
              child: Opacity(
                opacity: _platformOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withAlpha((80 + _overlayDensity * 140).toInt()),
                        Colors.cyan.withAlpha((80 + _overlayDensity * 140).toInt()),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withAlpha(160)),
                  ),
                  child: Center(
                    child: Text(
                      'Pseudo Platform View\n(${behavior.name})',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ),
            if (_showPassThroughOverlay && behavior == PlatformViewHitTestBehavior.transparent)
              Positioned(
                left: 54,
                right: 54,
                top: 56,
                bottom: 56,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.greenAccent.withAlpha(210), width: 2),
                    ),
                    child: const Center(
                      child: Text('Pass-through enabled', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
            if (_showPointerNoise)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _PointerNoisePainter(
                      color: theme.colorScheme.secondary,
                      density: _overlayDensity,
                      amplitude: _gestureAmplitude,
                      tick: _tick,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _routingBoard(ThemeData theme, PlatformViewHitTestBehavior behavior) {
    final rows = _behaviorNotes.map((n) {
      final active = n.behavior == behavior;
      final platformGets = n.behavior != PlatformViewHitTestBehavior.transparent;
      final flutterGets = n.behavior != PlatformViewHitTestBehavior.opaque;
      return _routingRow(
        theme: theme,
        note: n,
        active: active,
        platformGets: platformGets,
        flutterGets: flutterGets,
      );
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Routing Matrix', 'Visual matrix for behavior-to-route mapping under mixed layers.', 'matrix'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Behavior Matrix',
            'Rows summarize event ownership and practical tradeoffs.',
            Column(children: rows),
          ),
          if (_showBehaviorLegend) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Quick Legend',
              'At-a-glance guide for selecting behavior per integration context.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _legendLine(theme, PlatformViewHitTestBehavior.opaque, 'Exclusive control, blocks behind layer.'),
                  _legendLine(theme, PlatformViewHitTestBehavior.translucent, 'Shared routing, both layers can react.'),
                  _legendLine(theme, PlatformViewHitTestBehavior.transparent, 'Pass-through routing to Flutter layer behind.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _routingRow({
    required ThemeData theme,
    required _BehaviorNote note,
    required bool active,
    required bool platformGets,
    required bool flutterGets,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: active ? theme.colorScheme.primaryContainer.withAlpha(120) : theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        border: Border.all(color: active ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: active ? theme.colorScheme.primary.withAlpha(40) : theme.colorScheme.secondary.withAlpha(36),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(note.behavior.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              Text(active ? 'active' : 'inactive', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withAlpha(180))),
            ],
          ),
          const SizedBox(height: 6),
          Text(note.summary),
          const SizedBox(height: 5),
          Text('when to use: ${note.whenToUse}', style: const TextStyle(fontSize: 12.5)),
          const SizedBox(height: 4),
          Text('risk: ${note.risk}', style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(170))),
          const SizedBox(height: 6),
          Row(
            children: [
              _routeBadge(platformGets ? 'platform gets event' : 'platform bypassed', platformGets ? Colors.blue : Colors.grey),
              const SizedBox(width: 8),
              _routeBadge(flutterGets ? 'flutter gets event' : 'flutter blocked', flutterGets ? Colors.green : Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(140)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11.5)),
    );
  }

  Widget _legendLine(ThemeData theme, PlatformViewHitTestBehavior behavior, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 84, child: Text(behavior.name, style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(child: Text(detail, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180)))),
        ],
      ),
    );
  }

  Widget _comparisonBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Side-by-Side Comparison', 'Compare all behaviors under identical layered tap surfaces.', 'compare'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final behavior in PlatformViewHitTestBehavior.values)
                SizedBox(
                  width: _compactCards ? 232 : 262,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(_compactCards ? 10 : 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(behavior.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          _miniArena(theme, behavior),
                          const SizedBox(height: 8),
                          Text(
                            _behaviorNotes.firstWhere((b) => b.behavior == behavior).summary,
                            style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontSize: 12.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniArena(ThemeData theme, PlatformViewHitTestBehavior behavior) {
    return GestureDetector(
      onTap: () {
        _registerHit(
          platform: behavior != PlatformViewHitTestBehavior.transparent,
          flutter: behavior != PlatformViewHitTestBehavior.opaque,
        );
      },
      child: Container(
        height: 122,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withAlpha(170),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Flutter base', style: TextStyle(fontWeight: FontWeight.w700))),
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              top: 18,
              bottom: 18,
              child: Opacity(
                opacity: _platformOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.withAlpha((120 + _overlayDensity * 110).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('platform (${behavior.name})', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _integratedBoard(ThemeData theme, _ArenaZone zone, _ArenaScenario scenario, PlatformViewHitTestBehavior behavior) {
    final metrics = _metrics();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Integrated Scene', scenario.description, 'scene'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Mixed UI Surface',
            'A practical app shell with top controls, pseudo platform content, and behind-layer buttons.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _sceneToggle,
                  onPressed: (i) {
                    setState(() {
                      _sceneToggle = _toggle(_sceneToggle, i);
                      _tick += 1;
                      _event('Scene flag toggled index $i.');
                    });
                  },
                  children: const [
                    _TinyIconLabel(icon: Icons.filter_alt, text: 'Filter'),
                    _TinyIconLabel(icon: Icons.sort, text: 'Sort'),
                    _TinyIconLabel(icon: Icons.pin, text: 'Pin'),
                    _TinyIconLabel(icon: Icons.map, text: 'Map'),
                  ],
                ),
                const SizedBox(height: 10),
                _layerStack(theme, behavior, height: 250),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _registerHit(
                        platform: behavior != PlatformViewHitTestBehavior.transparent,
                        flutter: behavior != PlatformViewHitTestBehavior.opaque,
                      ),
                      icon: const Icon(Icons.touch_app),
                      label: const Text('Simulate tap'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _overlayDensity = (_overlayDensity + 0.08).clamp(0.1, 1.0);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.opacity),
                      label: const Text('More overlay'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _overlayDensity = (_overlayDensity - 0.08).clamp(0.1, 1.0);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.invert_colors_off),
                      label: const Text('Less overlay'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final m in metrics)
                SizedBox(
                  width: _compactCards ? 228 : 252,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(_compactCards ? 10 : 12),
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
                          const SizedBox(height: 6),
                          Text(m.note),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Integrated Diagnostics', [
              'zone: ${zone.name}',
              'scenario: ${scenario.title}',
              'behavior: ${behavior.name}',
              'platformOpacity: ${_platformOpacity.toStringAsFixed(2)}',
              'overlayDensity: ${_overlayDensity.toStringAsFixed(2)}',
              'gestureAmplitude: ${_gestureAmplitude.toStringAsFixed(2)}',
            ]),
          ],
        ],
      ),
    );
  }

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Platform Hits', value: '$_platformHits', note: 'events seen by platform layer', icon: Icons.phone_iphone),
      _Metric(label: 'Flutter Hits', value: '$_flutterHits', note: 'events seen by Flutter layer', icon: Icons.flutter_dash),
      _Metric(label: 'Both Hits', value: '$_bothHits', note: 'shared translucent interactions', icon: Icons.call_merge),
      _Metric(label: 'Pass-through', value: '$_passThroughHits', note: 'flutter-only forwarded events', icon: Icons.compare_arrows),
    ];
  }

  Widget _guideBoard(ThemeData theme, PlatformViewHitTestBehavior behavior) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Guide + Timeline', 'Usage guidance for PlatformViewHitTestBehavior in mixed-layer apps.', 'guide'),
          if (_showGuide) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.tertiaryContainer.withAlpha(108),
                border: Border.all(color: theme.colorScheme.tertiary.withAlpha(120)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Usage Guide', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  for (final line in _guide) _bullet(theme, line),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surfaceContainerHighest.withAlpha(122),
                border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  for (final f in _faq)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.q, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(f.a),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (_showTimeline) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.primaryContainer.withAlpha(106),
                border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('events: ${_timeline.length}  |  active behavior: ${behavior.name}  |  tick: $_tick'),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No interaction events yet. Use arena controls to populate timeline.')
                  else
                    for (final e in _timeline)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(e, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                      ),
                ],
              ),
            ),
          ],
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Global Diagnostics', [
              'platformHits: $_platformHits',
              'flutterHits: $_flutterHits',
              'bothHits: $_bothHits',
              'passThroughHits: $_passThroughHits',
              'pointerNoise: $_showPointerNoise',
              'passThroughOverlay: $_showPassThroughOverlay',
            ]),
          ],
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

  Widget _diagnostics(ThemeData theme, String title, List<String> lines) {
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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

  List<bool> _toggle(List<bool> values, int index) {
    final next = List<bool>.from(values);
    next[index] = !next[index];
    return next;
  }

  String _boardTitle(int i) {
    const titles = [
      'Interaction Arena',
      'Routing Matrix',
      'Side-by-Side Comparison',
      'Integrated Scene',
      'Guide + Timeline',
    ];
    return titles[i.clamp(0, titles.length - 1)];
  }
}

class _TinyIconLabel extends StatelessWidget {
  const _TinyIconLabel({required this.icon, required this.text});

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

class _ArenaGlyphPainter extends CustomPainter {
  _ArenaGlyphPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed.toInt() + 81);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.33 + rnd.nextDouble() * 0.58);
      final y = 8 + i * 8.0;
      p.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.2), const Radius.circular(4)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaGlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}

class _PointerNoisePainter extends CustomPainter {
  _PointerNoisePainter({
    required this.color,
    required this.density,
    required this.amplitude,
    required this.tick,
  });

  final Color color;
  final double density;
  final double amplitude;
  final int tick;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(500 + tick);
    final paint = Paint()
      ..color = color.withAlpha((26 + density * 70).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    final lines = (10 + density * 28).toInt();
    for (var i = 0; i < lines; i++) {
      final path = Path();
      final startY = random.nextDouble() * size.height;
      path.moveTo(0, startY);
      final segments = 5;
      for (var s = 1; s <= segments; s++) {
        final x = size.width * s / segments;
        final y = startY + math.sin((s + i + tick) * 0.7) * amplitude * 16;
        path.lineTo(x, y.clamp(0, size.height));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PointerNoisePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.density != density ||
        oldDelegate.amplitude != amplitude ||
        oldDelegate.tick != tick;
  }
}
