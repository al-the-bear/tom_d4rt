import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _ManifoldZone {
  const _ManifoldZone({
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

class _FrameScenario {
  const _FrameScenario({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;
}

class _QueueItem {
  const _QueueItem({
    required this.id,
    required this.label,
    required this.detail,
    required this.phase,
    required this.weight,
  });

  final String id;
  final String label;
  final String detail;
  final String phase;
  final double weight;
}

class _Faq {
  const _Faq(this.q, this.a);

  final String q;
  final String a;
}

class _Metric {
  const _Metric({
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

const List<_ManifoldZone> _zones = [
  _ManifoldZone(
    id: 'prod',
    name: 'Production Pipeline',
    description: 'Balanced profile for runtime frame orchestration and stable throughput.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _ManifoldZone(
    id: 'ops',
    name: 'Ops Command Surface',
    description: 'High-contrast style for debugging visual update traffic and ownership changes.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _ManifoldZone(
    id: 'lab',
    name: 'Research Lab',
    description: 'Exploration mode for testing manifold listeners and semantics toggles.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _ManifoldZone(
    id: 'review',
    name: 'Review Room',
    description: 'Readable review-focused mode for pipeline education and onboarding.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_FrameScenario> _scenarios = [
  _FrameScenario(
    id: 'scheduler',
    title: 'Scheduler View',
    description: 'Focus on how pipeline phases are scheduled and routed through manifold update requests.',
  ),
  _FrameScenario(
    id: 'routing',
    title: 'Dirty Routing View',
    description: 'Inspect simulated dirty nodes moving across layout/paint/compositing/semantics queues.',
  ),
  _FrameScenario(
    id: 'ownership',
    title: 'Ownership View',
    description: 'Visualize owner/manifold relationships and listener-driven visual update requests.',
  ),
  _FrameScenario(
    id: 'integrated',
    title: 'Integrated Frame Run',
    description: 'Run a complete simulated frame where manifold interactions drive visible UI updates.',
  ),
];

const List<String> _guideLines = [
  'PipelineManifold is the interface used by rendering owners to request and observe visual updates.',
  'In practical Flutter pipelines, the manifold cooperates with PipelineOwner to coordinate frame work.',
  'requestVisualUpdate() should be triggered when rendering state changes need a new visual frame.',
  'addListener/removeListener allow runtime observation of manifold-driven update flows.',
  'semanticsEnabled indicates whether semantics-related passes should be considered in orchestration logic.',
  'Use visualization boards to test manifold responsibilities instead of relying only on print-based scripts.',
  'Modeling phase queues helps detect where rendering pressure accumulates before it becomes a frame drop.',
  'Ownership boundaries matter: local owners can isolate subtree behavior while still participating in manifold updates.',
  'A good manifold demo should cover phase routing, listener reactions, semantics state, and integrated frame behavior.',
  'Keep diagnostics visible while interacting so observers can connect controls to manifold outcomes.',
];

const List<_Faq> _faq = [
  _Faq(
    'What does PipelineManifold do conceptually?',
    'It represents an update manifold that can request visual updates, expose semantics state, and notify listeners.',
  ),
  _Faq(
    'Why include listener controls in a manifold demo?',
    'Listeners make update propagation visible so you can reason about frame triggers in a reproducible way.',
  ),
  _Faq(
    'How should I validate semantics behavior?',
    'Observe semanticsEnabled and ensure your frame orchestration keeps semantics phase expectations explicit.',
  ),
  _Faq(
    'How is this useful in interpreter testing?',
    'It verifies interaction and state propagation patterns rather than asserting framework internals.',
  ),
];

const List<_QueueItem> _layoutItems = [
  _QueueItem(id: 'L1', label: 'HeaderRenderBox', detail: 'dirty due to width constraint update', phase: 'layout', weight: 0.74),
  _QueueItem(id: 'L2', label: 'PanelGrid', detail: 'child count changed from filter update', phase: 'layout', weight: 0.52),
  _QueueItem(id: 'L3', label: 'SidebarRail', detail: 'cross axis alignment changed', phase: 'layout', weight: 0.61),
  _QueueItem(id: 'L4', label: 'FooterSummary', detail: 'text metrics updated', phase: 'layout', weight: 0.38),
];

const List<_QueueItem> _paintItems = [
  _QueueItem(id: 'P1', label: 'HeatmapCanvas', detail: 'color map invalidated', phase: 'paint', weight: 0.81),
  _QueueItem(id: 'P2', label: 'LegendPainter', detail: 'tick labels changed', phase: 'paint', weight: 0.46),
  _QueueItem(id: 'P3', label: 'StatusGlow', detail: 'accent pulse updated', phase: 'paint', weight: 0.58),
  _QueueItem(id: 'P4', label: 'OverlayHints', detail: 'tooltip marker moved', phase: 'paint', weight: 0.41),
];

const List<_QueueItem> _compositingItems = [
  _QueueItem(id: 'C1', label: 'SceneLayerRoot', detail: 'layer subtree reorder required', phase: 'compositing', weight: 0.77),
  _QueueItem(id: 'C2', label: 'ShadowLayer', detail: 'elevation profile changed', phase: 'compositing', weight: 0.49),
  _QueueItem(id: 'C3', label: 'ClipLayer', detail: 'rounded clip radii changed', phase: 'compositing', weight: 0.53),
  _QueueItem(id: 'C4', label: 'TransformLayer', detail: 'camera shift applied', phase: 'compositing', weight: 0.66),
];

const List<_QueueItem> _semanticsItems = [
  _QueueItem(id: 'S1', label: 'ActionChipGroup', detail: 'semantic labels refreshed', phase: 'semantics', weight: 0.44),
  _QueueItem(id: 'S2', label: 'MetricsTable', detail: 'row focus order changed', phase: 'semantics', weight: 0.57),
  _QueueItem(id: 'S3', label: 'StatusBanner', detail: 'live region content updated', phase: 'semantics', weight: 0.39),
  _QueueItem(id: 'S4', label: 'ControlRail', detail: 'hint text changed', phase: 'semantics', weight: 0.47),
];

class _DemoPipelineManifold implements PipelineManifold {
  _DemoPipelineManifold({required this.semanticsEnabled});

  @override
  bool semanticsEnabled;

  final List<VoidCallback> _listeners = <VoidCallback>[];

  @override
  void requestVisualUpdate() {
    final snapshot = List<VoidCallback>.from(_listeners);
    for (final listener in snapshot) {
      listener();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }
}

dynamic build(BuildContext context) {
  return const _PipelineManifoldStudio();
}

class _PipelineManifoldStudio extends StatefulWidget {
  const _PipelineManifoldStudio();

  @override
  State<_PipelineManifoldStudio> createState() => _PipelineManifoldStudioState();
}

class _PipelineManifoldStudioState extends State<_PipelineManifoldStudio> {
  late final PipelineManifold _manifold;

  int _zoneIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _showDiagnostics = true;
  bool _dense = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showSemanticsLane = true;
  bool _autoPulse = false;
  bool _highlightHotNodes = true;
  bool _compactCards = false;

  double _phaseIntensity = 0.58;
  double _trafficScale = 1.0;
  double _frameSpeed = 1.0;

  int _tick = 0;
  int _visualRequests = 0;
  int _listenerHits = 0;
  int _manualFrameRuns = 0;

  List<bool> _toolbarSelection = <bool>[true, false, false, false];
  List<bool> _routeSelection = <bool>[true, true, false, false, true, false];
  List<bool> _ownerSelection = <bool>[true, false, true, false];
  List<bool> _timelineSelection = <bool>[true, false, false];

  final List<String> _timeline = <String>[];

  bool _listenerAttached = false;

  void _noopListener() {}

  @override
  void initState() {
    super.initState();
    _manifold = _DemoPipelineManifold(semanticsEnabled: true);
    _attachListener();
    _addEvent('PipelineManifold studio initialized with demo manifold implementation.');
  }

  @override
  void dispose() {
    if (_listenerAttached) {
      _manifold.removeListener(_noopListener);
      _listenerAttached = false;
    }
    super.dispose();
  }

  void _attachListener() {
    if (_listenerAttached) {
      return;
    }
    _manifold.addListener(_noopListener);
    _listenerAttached = true;
    _addEvent('Manifold listener attached.');
  }

  void _detachListener() {
    if (!_listenerAttached) {
      return;
    }
    _manifold.removeListener(_noopListener);
    _listenerAttached = false;
    _addEvent('Manifold listener detached.');
  }

  void _requestVisualUpdate(String reason) {
    _manifold.requestVisualUpdate();
    setState(() {
      _visualRequests += 1;
      _tick += 1;
      if (_listenerAttached) {
        _listenerHits += 1;
      }
      _addEvent('requestVisualUpdate() invoked: $reason.');
    });
  }

  void _addEvent(String text) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 32) {
      _timeline.removeRange(32, _timeline.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final zone = _zones[_zoneIndex];
    final scenario = _scenarios[_scenarioIndex];

    final scheme = ColorScheme.fromSeed(seedColor: zone.seed, brightness: zone.brightness);
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: _dense ? VisualDensity.compact : VisualDensity.standard,
    );

    final metrics = _buildMetrics();

    return Theme(
      data: theme,
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            _topBanner(theme, zone, scenario),
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
                      child: _board(theme, zone, scenario, metrics),
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

  List<_Metric> _buildMetrics() {
    return [
      _Metric(label: 'Visual Requests', value: '$_visualRequests', note: 'requestVisualUpdate calls', icon: Icons.visibility),
      _Metric(label: 'Listener Hits', value: '$_listenerHits', note: 'simulated listener reactions', icon: Icons.hearing),
      _Metric(label: 'Manual Runs', value: '$_manualFrameRuns', note: 'integrated frame run count', icon: Icons.play_circle),
      _Metric(label: 'Tick', value: '$_tick', note: 'state progression counter', icon: Icons.timeline),
    ];
  }

  Widget _topBanner(ThemeData theme, _ManifoldZone zone, _FrameScenario scenario) {
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
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(135)),
            ),
            child: CustomPaint(
              painter: _FlowGlyphPainter(
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
                Text('PipelineManifold Rendering Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'zone: ${zone.name}  scenario: ${scenario.title}  semanticsEnabled: ${_manifold.semanticsEnabled}',
                  style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(zone.description, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(172))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlRail(ThemeData theme) {
    return Container(
      width: 388,
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
            Text('Manifold Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Tune phase traffic, listener lifecycle, and integrated frame behavior.'),
            const SizedBox(height: 10),
            _dropdownCard(
              label: 'Zone',
              value: _zoneIndex,
              options: _zones.map((e) => e.name).toList(),
              onChanged: (v) {
                setState(() {
                  _zoneIndex = v;
                  _tick += 1;
                  _addEvent('Zone switched to ${_zones[v].name}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Scenario',
              value: _scenarioIndex,
              options: _scenarios.map((e) => e.title).toList(),
              onChanged: (v) {
                setState(() {
                  _scenarioIndex = v;
                  _tick += 1;
                  _addEvent('Scenario switched to ${_scenarios[v].title}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Board',
              value: _boardIndex,
              options: List.generate(5, _boardTitle),
              onChanged: (v) {
                setState(() {
                  _boardIndex = v;
                  _tick += 1;
                  _addEvent('Board switched to ${_boardTitle(v)}.');
                });
              },
            ),
            _switchCard(
              title: 'Diagnostics',
              subtitle: 'Show manifold counters, queue stats, and phase details',
              value: _showDiagnostics,
              onChanged: (v) {
                setState(() {
                  _showDiagnostics = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Dense mode',
              subtitle: 'Compact layout density for crowded debug surfaces',
              value: _dense,
              onChanged: (v) {
                setState(() {
                  _dense = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Show guide',
              subtitle: 'Display usage guidance and FAQ board content',
              value: _showGuide,
              onChanged: (v) {
                setState(() {
                  _showGuide = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Show timeline',
              subtitle: 'Display event log for manifold interactions',
              value: _showTimeline,
              onChanged: (v) {
                setState(() {
                  _showTimeline = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Semantics lane',
              subtitle: 'Include semantics lane and routing in queue boards',
              value: _showSemanticsLane,
              onChanged: (v) {
                setState(() {
                  _showSemanticsLane = v;
                  _tick += 1;
                  _addEvent('Semantics lane ${v ? 'enabled' : 'disabled'}.');
                });
              },
            ),
            _switchCard(
              title: 'Auto pulse',
              subtitle: 'Request visual update on specific interactions',
              value: _autoPulse,
              onChanged: (v) {
                setState(() {
                  _autoPulse = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Highlight hot nodes',
              subtitle: 'Emphasize heavy queue items in routing displays',
              value: _highlightHotNodes,
              onChanged: (v) {
                setState(() {
                  _highlightHotNodes = v;
                  _tick += 1;
                });
              },
            ),
            _switchCard(
              title: 'Compact cards',
              subtitle: 'Use tighter integrated scene cards',
              value: _compactCards,
              onChanged: (v) {
                setState(() {
                  _compactCards = v;
                  _tick += 1;
                });
              },
            ),
            _sliderCard(
              label: 'Phase intensity',
              value: _phaseIntensity,
              min: 0.1,
              max: 1.0,
              onChanged: (v) {
                setState(() {
                  _phaseIntensity = v;
                  _tick += 1;
                });
              },
            ),
            _sliderCard(
              label: 'Traffic scale',
              value: _trafficScale,
              min: 0.6,
              max: 1.8,
              onChanged: (v) {
                setState(() {
                  _trafficScale = v;
                  _tick += 1;
                });
              },
            ),
            _sliderCard(
              label: 'Frame speed',
              value: _frameSpeed,
              min: 0.5,
              max: 1.9,
              onChanged: (v) {
                setState(() {
                  _frameSpeed = v;
                  _tick += 1;
                });
              },
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

  Widget _board(ThemeData theme, _ManifoldZone zone, _FrameScenario scenario, List<_Metric> metrics) {
    switch (_boardIndex) {
      case 0:
        return _phaseBoard(theme, scenario);
      case 1:
        return _queueBoard(theme);
      case 2:
        return _ownershipBoard(theme, zone);
      case 3:
        return _integratedSceneBoard(theme, scenario, metrics);
      default:
        return _guideBoard(theme, metrics);
    }
  }

  Widget _phaseBoard(ThemeData theme, _FrameScenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Phase Orchestrator', scenario.description, 'phase'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Frame Lanes',
            'Simulate layout, paint, compositing, and semantics orchestration from manifold requests.',
            Column(
              children: [
                _phaseLane(theme, 'layout', Icons.straighten, _phaseIntensity * 0.82, Colors.teal),
                _phaseLane(theme, 'paint', Icons.brush, (_phaseIntensity + 0.12).clamp(0, 1), Colors.orange),
                _phaseLane(theme, 'compositing', Icons.layers, (_phaseIntensity + 0.05).clamp(0, 1), Colors.blue),
                if (_showSemanticsLane)
                  _phaseLane(theme, 'semantics', Icons.accessibility_new, (_phaseIntensity - 0.08).clamp(0, 1), Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Phase Controls',
            'Trigger visual update requests while selecting active orchestration mode.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _toolbarSelection,
                  onPressed: (i) {
                    setState(() {
                      _toolbarSelection = _singleSelect(_toolbarSelection, i);
                      _tick += 1;
                      _addEvent('Phase mode selected: index $i.');
                    });
                    if (_autoPulse) {
                      _requestVisualUpdate('phase mode change');
                    }
                  },
                  children: const [
                    _LabelIcon(icon: Icons.play_arrow, text: 'Idle'),
                    _LabelIcon(icon: Icons.bolt, text: 'Burst'),
                    _LabelIcon(icon: Icons.schedule, text: 'Steady'),
                    _LabelIcon(icon: Icons.pause, text: 'Hold'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _requestVisualUpdate('manual phase pulse'),
                      icon: const Icon(Icons.visibility),
                      label: const Text('requestVisualUpdate'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _phaseIntensity = (_phaseIntensity + 0.08).clamp(0.1, 1.0);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.add_chart),
                      label: const Text('Increase load'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _phaseIntensity = (_phaseIntensity - 0.08).clamp(0.1, 1.0);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.stacked_line_chart),
                      label: const Text('Reduce load'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Phase Diagnostics', [
              'phaseIntensity: ${_phaseIntensity.toStringAsFixed(2)}',
              'trafficScale: ${_trafficScale.toStringAsFixed(2)}',
              'frameSpeed: ${_frameSpeed.toStringAsFixed(2)}',
              'semanticsEnabled: ${_manifold.semanticsEnabled}',
              'visualRequests: $_visualRequests',
              'listenerAttached: $_listenerAttached',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _phaseLane(ThemeData theme, String name, IconData icon, double load, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(130),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
              Text('${(load * 100).round()}%'),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 9,
              value: load,
              backgroundColor: color.withAlpha(48),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _queueBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Dirty Queue Routing', 'Observe simulated dirty nodes routed by phase and manifold triggers.', 'routing'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Queue Filters',
            'Toggle visibility of routing channels and request updates after filter adjustments.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _routeSelection,
                  onPressed: (i) {
                    setState(() {
                      _routeSelection = _toggle(_routeSelection, i);
                      _tick += 1;
                      _addEvent('Queue filter toggled: index $i.');
                    });
                    if (_autoPulse) {
                      _requestVisualUpdate('queue filter change');
                    }
                  },
                  children: const [
                    _LabelIcon(icon: Icons.straighten, text: 'Layout'),
                    _LabelIcon(icon: Icons.brush, text: 'Paint'),
                    _LabelIcon(icon: Icons.layers, text: 'Compose'),
                    _LabelIcon(icon: Icons.accessibility_new, text: 'Semantics'),
                    _LabelIcon(icon: Icons.priority_high, text: 'Hot'),
                    _LabelIcon(icon: Icons.filter_alt_off, text: 'Muted'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _requestVisualUpdate('queue flush simulation'),
                      icon: const Icon(Icons.sync),
                      label: const Text('Flush queues'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _trafficScale = (_trafficScale + 0.08).clamp(0.6, 1.8);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.trending_up),
                      label: const Text('Increase traffic'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _trafficScale = (_trafficScale - 0.08).clamp(0.6, 1.8);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.trending_down),
                      label: const Text('Reduce traffic'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _queueLane(theme, 'layout queue', _layoutItems, Colors.teal),
          _queueLane(theme, 'paint queue', _paintItems, Colors.orange),
          _queueLane(theme, 'compositing queue', _compositingItems, Colors.blue),
          if (_showSemanticsLane) _queueLane(theme, 'semantics queue', _semanticsItems, Colors.purple),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Routing Diagnostics', [
              'layout count: ${_layoutItems.length}',
              'paint count: ${_paintItems.length}',
              'compositing count: ${_compositingItems.length}',
              'semantics count: ${_showSemanticsLane ? _semanticsItems.length : 0}',
              'hot node highlight: $_highlightHotNodes',
              'trafficScale: ${_trafficScale.toStringAsFixed(2)}',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _queueLane(ThemeData theme, String title, List<_QueueItem> items, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface.withAlpha(195),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final item in items)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _highlightHotNodes && item.weight * _trafficScale > 0.66
                    ? accent.withAlpha(40)
                    : theme.colorScheme.surfaceContainerHighest.withAlpha(120),
                border: Border.all(color: accent.withAlpha(120)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent.withAlpha(48),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(item.id, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.label, style: const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(item.detail, style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(170))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 86,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${(item.weight * _trafficScale * 100).round()}%'),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: (item.weight * _trafficScale).clamp(0, 1),
                            minHeight: 6,
                            backgroundColor: accent.withAlpha(45),
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
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

  Widget _ownershipBoard(ThemeData theme, _ManifoldZone zone) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Owner Attachment Board', 'Inspect listener lifecycle and owner/manifold interaction controls.', 'owner'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Listener Lifecycle',
            'Attach or detach manifold listeners and request updates to observe counter effects.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _ownerSelection,
                  onPressed: (i) {
                    setState(() {
                      _ownerSelection = _toggle(_ownerSelection, i);
                      _tick += 1;
                      _addEvent('Ownership toggle changed: index $i.');
                    });
                  },
                  children: const [
                    _LabelIcon(icon: Icons.cable, text: 'Attach'),
                    _LabelIcon(icon: Icons.link_off, text: 'Detach'),
                    _LabelIcon(icon: Icons.visibility, text: 'Visual'),
                    _LabelIcon(icon: Icons.accessibility_new, text: 'Semantic'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          _attachListener();
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.cable),
                      label: const Text('Attach listener'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _detachListener();
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.link_off),
                      label: const Text('Detach listener'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _requestVisualUpdate('ownership board manual request'),
                      icon: const Icon(Icons.visibility),
                      label: const Text('requestVisualUpdate'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Ownership Graph',
            'Visual abstraction of PipelineOwner-backed manifold and attached observers.',
            Column(
              children: [
                _graphRow(theme, 'PipelineOwner', 'implements', 'PipelineManifold', zone.seed),
                _graphRow(theme, 'PipelineManifold', 'notifies', _listenerAttached ? 'Listener: attached' : 'Listener: detached', theme.colorScheme.tertiary),
                _graphRow(theme, 'PipelineManifold', 'reads', 'semanticsEnabled: ${_manifold.semanticsEnabled}', theme.colorScheme.primary),
                _graphRow(theme, 'UI Controls', 'invoke', 'requestVisualUpdate()', theme.colorScheme.secondary),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Ownership Diagnostics', [
              'listenerAttached: $_listenerAttached',
              'visualRequests: $_visualRequests',
              'listenerHits: $_listenerHits',
              'semanticsEnabled: ${_manifold.semanticsEnabled}',
              'manualFrameRuns: $_manualFrameRuns',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _graphRow(ThemeData theme, String left, String verb, String right, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(118),
        border: Border.all(color: color.withAlpha(130)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(left, style: const TextStyle(fontWeight: FontWeight.w700))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: color.withAlpha(45),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(verb, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(right, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _integratedSceneBoard(ThemeData theme, _FrameScenario scenario, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Integrated Frame Run', scenario.description, 'scene'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Run Controls',
            'Execute a full simulated frame where manifold request/observer counters update together.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _timelineSelection,
                  onPressed: (i) {
                    setState(() {
                      _timelineSelection = _singleSelect(_timelineSelection, i);
                      _tick += 1;
                      _addEvent('Frame run mode switched: index $i.');
                    });
                  },
                  children: const [
                    _LabelIcon(icon: Icons.bolt, text: 'Burst'),
                    _LabelIcon(icon: Icons.timer, text: 'Steady'),
                    _LabelIcon(icon: Icons.pause_circle, text: 'Observe'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        _requestVisualUpdate('integrated run');
                        setState(() {
                          _manualFrameRuns += 1;
                          _tick += 1;
                          _addEvent('Integrated frame run executed.');
                        });
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Run frame'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _frameSpeed = (_frameSpeed + 0.12).clamp(0.5, 1.9);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.fast_forward),
                      label: const Text('Faster'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _frameSpeed = (_frameSpeed - 0.12).clamp(0.5, 1.9);
                          _tick += 1;
                        });
                      },
                      icon: const Icon(Icons.slow_motion_video),
                      label: const Text('Slower'),
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
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () => _requestVisualUpdate('metric inspect: ${m.label}'),
                            child: const Text('Inspect'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Frame Storyboard',
            'Visual progression bars for a complete frame pass through manifold-coordinated phases.',
            Column(
              children: [
                _storyBar(theme, 'layout', (_phaseIntensity * _frameSpeed).clamp(0.1, 1.0), Colors.teal),
                _storyBar(theme, 'paint', ((_phaseIntensity + 0.07) * _frameSpeed).clamp(0.1, 1.0), Colors.orange),
                _storyBar(theme, 'compositing', ((_phaseIntensity + 0.03) * _frameSpeed).clamp(0.1, 1.0), Colors.blue),
                if (_showSemanticsLane)
                  _storyBar(theme, 'semantics', ((_phaseIntensity - 0.09) * _frameSpeed).clamp(0.1, 1.0), Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storyBar(ThemeData theme, String label, double value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 106, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: value,
                backgroundColor: color.withAlpha(46),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 38, child: Text('${(value * 100).round()}%', textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _guideBoard(ThemeData theme, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Guide + Timeline', 'PipelineManifold usage guidance and event chronology.', 'guide'),
          if (_showGuide) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.tertiaryContainer.withAlpha(110),
                border: Border.all(color: theme.colorScheme.tertiary.withAlpha(120)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PipelineManifold Guide', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  for (final line in _guideLines) _bullet(theme, line),
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
                  Text('events: ${_timeline.length}  |  tick: $_tick  |  requests: $_visualRequests'),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Interact with controls to populate timeline.')
                  else
                    for (final event in _timeline)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(event, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
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
              'Compact summary of active manifold counters and integrated scene stats.',
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

  List<bool> _singleSelect(List<bool> values, int index) {
    final next = List<bool>.filled(values.length, false);
    next[index] = true;
    return next;
  }

  List<bool> _toggle(List<bool> values, int index) {
    final next = List<bool>.from(values);
    next[index] = !next[index];
    return next;
  }

  String _boardTitle(int index) {
    const titles = [
      'Phase Orchestrator',
      'Dirty Queue Routing',
      'Owner Attachment',
      'Integrated Frame Run',
      'Guide + Timeline',
    ];
    return titles[index.clamp(0, titles.length - 1)];
  }
}

class _LabelIcon extends StatelessWidget {
  const _LabelIcon({required this.icon, required this.text});

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

class _FlowGlyphPainter extends CustomPainter {
  _FlowGlyphPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed.toInt() + 44);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final width = size.width * (0.33 + random.nextDouble() * 0.58);
      final y = 8 + i * 8.0;
      paint.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, width, 5.2), const Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FlowGlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}
