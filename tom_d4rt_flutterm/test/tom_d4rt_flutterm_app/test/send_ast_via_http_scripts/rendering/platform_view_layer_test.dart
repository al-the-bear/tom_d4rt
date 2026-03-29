import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _LayerZone {
  const _LayerZone({
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

class _LayerScenario {
  const _LayerScenario(this.id, this.title, this.description);

  final String id;
  final String title;
  final String description;
}

class _LayerTemplate {
  const _LayerTemplate({
    required this.name,
    required this.rect,
    required this.viewId,
    required this.role,
    required this.note,
  });

  final String name;
  final Rect rect;
  final int viewId;
  final String role;
  final String note;
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

const List<_LayerZone> _zones = [
  _LayerZone(
    id: 'shell',
    name: 'App Shell',
    description: 'Balanced profile for mixed Flutter + platform surface composition.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _LayerZone(
    id: 'ops',
    name: 'Ops Console',
    description: 'High-contrast diagnostics for layer lifecycle and scene routing.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _LayerZone(
    id: 'lab',
    name: 'Integration Lab',
    description: 'Exploration profile for viewId choreography and layer state transitions.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _LayerZone(
    id: 'review',
    name: 'Review Deck',
    description: 'Readable mode for instructional walkthrough of PlatformViewLayer usage.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_LayerScenario> _scenarios = [
  _LayerScenario('gallery', 'Constructor Gallery', 'Inspect PlatformViewLayer creation with varying rect/viewId templates.'),
  _LayerScenario('lifecycle', 'Lifecycle Board', 'Exercise mark/clean/update lifecycle calls with visual diagnostics.'),
  _LayerScenario('scene', 'Scene Composition', 'Use pseudo scene stacks to explain where PlatformViewLayer participates.'),
  _LayerScenario('integrated', 'Integrated Surface', 'Combine controls, metrics, and layered visuals in one realistic dashboard.'),
];

const List<_LayerTemplate> _templates = [
  _LayerTemplate(
    name: 'Hero Video Slot',
    rect: Rect.fromLTWH(16, 16, 320, 180),
    viewId: 41,
    role: 'media',
    note: 'Primary media viewport embedded in top section.',
  ),
  _LayerTemplate(
    name: 'Mini Map Window',
    rect: Rect.fromLTWH(18, 210, 180, 120),
    viewId: 42,
    role: 'map',
    note: 'Context map with compact viewport and quick interactions.',
  ),
  _LayerTemplate(
    name: 'Camera Preview',
    rect: Rect.fromLTWH(210, 210, 126, 120),
    viewId: 43,
    role: 'camera',
    note: 'Secondary camera feed aligned with controls panel.',
  ),
  _LayerTemplate(
    name: 'Document Host',
    rect: Rect.fromLTWH(16, 340, 320, 150),
    viewId: 44,
    role: 'document',
    note: 'Native document rendering region in lower section.',
  ),
  _LayerTemplate(
    name: 'Inline Chart',
    rect: Rect.fromLTWH(16, 500, 155, 110),
    viewId: 45,
    role: 'chart',
    note: 'Compact chart host for analytics summary area.',
  ),
  _LayerTemplate(
    name: 'Web Snippet',
    rect: Rect.fromLTWH(181, 500, 155, 110),
    viewId: 46,
    role: 'web',
    note: 'Embedded web segment for external status widget.',
  ),
];

const List<String> _guide = [
  'PlatformViewLayer represents a composited layer that embeds a platform view in the scene graph.',
  'Its constructor requires a Rect and a viewId to identify region and platform view connection.',
  'Use PlatformViewLayer when integrating native views directly into Flutter layer composition.',
  'markNeedsAddToScene and updateSubtreeNeedsAddToScene indicate scene rebuild intent.',
  'Lifecycle operations should be tested visually with counters and timeline logging.',
  'Choose rect sizing carefully to match clipping and overlay expectations in mixed layouts.',
  'Track viewId ownership to avoid ambiguity when multiple platform layers coexist.',
  'Deep demos should show constructor variation, lifecycle controls, and integrated app scenes.',
  'Use diagnostics to inspect attached state, depth, and toString summaries where possible.',
  'Keep user-facing explanation clear: PlatformViewLayer is about scene composition, not gesture policy enums.',
];

const List<_Faq> _faq = [
  _Faq('When should I create a PlatformViewLayer directly?', 'Use it when you need low-level control of scene layering around embedded platform views.'),
  _Faq('What are rect and viewId used for?', 'rect defines scene placement; viewId references the underlying platform view instance.'),
  _Faq('How do I validate lifecycle behavior?', 'Invoke lifecycle methods, observe counters, and verify visual state transitions in dashboards.'),
  _Faq('Does PlatformViewLayer replace widget-level integrations?', 'No. It complements lower-level rendering scenarios and advanced integrations.'),
];

dynamic build(BuildContext context) {
  return const _PlatformViewLayerStudio();
}

class _PlatformViewLayerStudio extends StatefulWidget {
  const _PlatformViewLayerStudio();

  @override
  State<_PlatformViewLayerStudio> createState() => _PlatformViewLayerStudioState();
}

class _PlatformViewLayerStudioState extends State<_PlatformViewLayerStudio> {
  int _zoneIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _showDiagnostics = true;
  bool _dense = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _compactCards = false;
  bool _showRectOverlay = true;
  bool _showLifecycleLegend = true;
  bool _autoLog = true;

  double _rectScale = 1.0;
  double _sceneDensity = 0.55;
  double _noise = 0.38;

  int _tick = 0;
  int _created = 0;
  int _markCalls = 0;
  int _cleanCalls = 0;
  int _updateCalls = 0;
  int _callbackRegistrations = 0;

  List<bool> _modeSelection = <bool>[true, false, false, false];
  List<bool> _lifecycleSelection = <bool>[true, false, true, false, true];
  List<bool> _sceneSelection = <bool>[true, false, true, false];

  final List<String> _timeline = <String>[];

  List<PlatformViewLayer> _layers = <PlatformViewLayer>[];

  @override
  void initState() {
    super.initState();
    _rebuildLayers('initialization');
  }

  @override
  void dispose() {
    for (final layer in _layers) {
      try {
        layer.dispose();
      } catch (_) {
        // Ignore disposal issues in demo context.
      }
    }
    super.dispose();
  }

  void _event(String text) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 34) {
      _timeline.removeRange(34, _timeline.length);
    }
  }

  void _rebuildLayers(String reason) {
    for (final old in _layers) {
      try {
        old.dispose();
      } catch (_) {}
    }
    _layers = _templates
        .map(
          (t) => PlatformViewLayer(
            rect: Rect.fromLTWH(
              t.rect.left,
              t.rect.top,
              t.rect.width * _rectScale,
              t.rect.height * _rectScale,
            ),
            viewId: t.viewId,
          ),
        )
        .toList();

    _created += _layers.length;
    if (_autoLog) {
      _event('Rebuilt ${_layers.length} PlatformViewLayer instances: $reason.');
    }
  }

  void _markAllNeedsScene() {
    for (final layer in _layers) {
      layer.markNeedsAddToScene();
    }
    setState(() {
      _markCalls += _layers.length;
      _tick += 1;
      _event('markNeedsAddToScene called for all layers.');
    });
  }

  void _markAllClean() {
    for (final layer in _layers) {
      layer.debugMarkClean();
    }
    setState(() {
      _cleanCalls += _layers.length;
      _tick += 1;
      _event('debugMarkClean called for all layers.');
    });
  }

  void _updateAllSubtreeFlags() {
    for (final layer in _layers) {
      layer.updateSubtreeNeedsAddToScene();
    }
    setState(() {
      _updateCalls += _layers.length;
      _tick += 1;
      _event('updateSubtreeNeedsAddToScene called for all layers.');
    });
  }

  void _registerCompositionCallbacks() {
    for (final layer in _layers) {
      layer.addCompositionCallback((_) {});
    }
    setState(() {
      _callbackRegistrations += _layers.length;
      _tick += 1;
      _event('addCompositionCallback registered for all layers.');
    });
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

    final metrics = _metrics();

    return Theme(
      data: theme,
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            _header(theme, zone, scenario),
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

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Layers Created', value: '$_created', note: 'total constructor invocations', icon: Icons.add_box),
      _Metric(label: 'markNeeds', value: '$_markCalls', note: 'markNeedsAddToScene calls', icon: Icons.flag),
      _Metric(label: 'debugMarkClean', value: '$_cleanCalls', note: 'debugMarkClean calls', icon: Icons.cleaning_services),
      _Metric(label: 'updateSubtree', value: '$_updateCalls', note: 'updateSubtreeNeedsAddToScene calls', icon: Icons.update),
      _Metric(label: 'Callbacks', value: '$_callbackRegistrations', note: 'composition callback registrations', icon: Icons.notifications_active),
      _Metric(label: 'Tick', value: '$_tick', note: 'state progression', icon: Icons.timeline),
    ];
  }

  Widget _header(ThemeData theme, _LayerZone zone, _LayerScenario scenario) {
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
              painter: _LayerGlyphPainter(
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
                Text('PlatformViewLayer Composition Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'zone: ${zone.name}  scenario: ${scenario.title}  layers: ${_layers.length}',
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
      width: 392,
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
            Text('Layer Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Inspect constructor output, lifecycle actions, and integrated scene composition.'),
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
              'View Modes',
              'Switch surface mode emphasis for constructor, lifecycle, and integrated panels.',
              ToggleButtons(
                isSelected: _modeSelection,
                onPressed: (i) {
                  setState(() {
                    _modeSelection = _single(_modeSelection, i);
                    _tick += 1;
                    _event('Mode switched index $i.');
                  });
                },
                children: const [
                  _MiniLabel(icon: Icons.view_compact, text: 'Compact'),
                  _MiniLabel(icon: Icons.view_agenda, text: 'Verbose'),
                  _MiniLabel(icon: Icons.dashboard, text: 'Dashboard'),
                  _MiniLabel(icon: Icons.school, text: 'Teaching'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _switchCard(
              title: 'Diagnostics',
              subtitle: 'Show layer fields and lifecycle counters',
              value: _showDiagnostics,
              onChanged: (v) => setState(() => _showDiagnostics = v),
            ),
            _switchCard(
              title: 'Dense mode',
              subtitle: 'Compact spacing for high-density diagnostics',
              value: _dense,
              onChanged: (v) => setState(() => _dense = v),
            ),
            _switchCard(
              title: 'Show guide',
              subtitle: 'Display usage guide and FAQ board',
              value: _showGuide,
              onChanged: (v) => setState(() => _showGuide = v),
            ),
            _switchCard(
              title: 'Show timeline',
              subtitle: 'Display interaction/lifecycle timeline',
              value: _showTimeline,
              onChanged: (v) => setState(() => _showTimeline = v),
            ),
            _switchCard(
              title: 'Compact cards',
              subtitle: 'Use tighter metric cards and comparison tiles',
              value: _compactCards,
              onChanged: (v) => setState(() => _compactCards = v),
            ),
            _switchCard(
              title: 'Rect overlays',
              subtitle: 'Overlay rect bounds in scene previews',
              value: _showRectOverlay,
              onChanged: (v) => setState(() => _showRectOverlay = v),
            ),
            _switchCard(
              title: 'Lifecycle legend',
              subtitle: 'Show action guidance for lifecycle calls',
              value: _showLifecycleLegend,
              onChanged: (v) => setState(() => _showLifecycleLegend = v),
            ),
            _switchCard(
              title: 'Auto log',
              subtitle: 'Record timeline entry on key interactions',
              value: _autoLog,
              onChanged: (v) => setState(() => _autoLog = v),
            ),
            _sliderCard(
              label: 'Rect scale',
              value: _rectScale,
              min: 0.7,
              max: 1.45,
              onChanged: (v) => setState(() => _rectScale = v),
            ),
            _sliderCard(
              label: 'Scene density',
              value: _sceneDensity,
              min: 0.1,
              max: 1.0,
              onChanged: (v) => setState(() => _sceneDensity = v),
            ),
            _sliderCard(
              label: 'Noise',
              value: _noise,
              min: 0.0,
              max: 1.0,
              onChanged: (v) => setState(() => _noise = v),
            ),
            const SizedBox(height: 4),
            _card(
              theme,
              'Lifecycle Actions',
              'Invoke PlatformViewLayer lifecycle methods across all demo layers.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButtons(
                    isSelected: _lifecycleSelection,
                    onPressed: (i) {
                      setState(() {
                        _lifecycleSelection = _toggle(_lifecycleSelection, i);
                        _tick += 1;
                        _event('Lifecycle flag toggled index $i.');
                      });
                    },
                    children: const [
                      _MiniLabel(icon: Icons.flag, text: 'Mark'),
                      _MiniLabel(icon: Icons.cleaning_services, text: 'Clean'),
                      _MiniLabel(icon: Icons.update, text: 'Update'),
                      _MiniLabel(icon: Icons.notifications, text: 'Callback'),
                      _MiniLabel(icon: Icons.layers, text: 'Rebuild'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: _markAllNeedsScene,
                        icon: const Icon(Icons.flag),
                        label: const Text('markNeedsAddToScene'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _markAllClean,
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('debugMarkClean'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _updateAllSubtreeFlags,
                        icon: const Icon(Icons.update),
                        label: const Text('updateSubtreeNeedsAddToScene'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _registerCompositionCallbacks,
                        icon: const Icon(Icons.notifications_active),
                        label: const Text('addCompositionCallback'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _rebuildLayers('manual rebuild');
                            _tick += 1;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Rebuild layers'),
                      ),
                    ],
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

  Widget _board(ThemeData theme, _LayerScenario scenario, List<_Metric> metrics) {
    switch (_boardIndex) {
      case 0:
        return _constructorBoard(theme, scenario);
      case 1:
        return _lifecycleBoard(theme);
      case 2:
        return _sceneBoard(theme);
      case 3:
        return _integratedBoard(theme, scenario, metrics);
      default:
        return _guideBoard(theme, metrics);
    }
  }

  Widget _constructorBoard(ThemeData theme, _LayerScenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Constructor Gallery', scenario.description, 'ctor'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Layer Templates',
            'Each card corresponds to a PlatformViewLayer(rect:, viewId:) constructor instance.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < _layers.length; i++) _layerCard(theme, _templates[i], _layers[i]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Constructor Actions',
            'Resize or rebuild all layers to simulate dynamic layout updates.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _rectScale = (_rectScale + 0.05).clamp(0.7, 1.45);
                      _rebuildLayers('scale up');
                      _tick += 1;
                    });
                  },
                  icon: const Icon(Icons.zoom_in),
                  label: const Text('Scale up'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _rectScale = (_rectScale - 0.05).clamp(0.7, 1.45);
                      _rebuildLayers('scale down');
                      _tick += 1;
                    });
                  },
                  icon: const Icon(Icons.zoom_out),
                  label: const Text('Scale down'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _rebuildLayers('template refresh');
                      _tick += 1;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh constructors'),
                ),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Constructor Diagnostics', [
              'layers: ${_layers.length}',
              'rectScale: ${_rectScale.toStringAsFixed(2)}',
              'created total: $_created',
              'sceneDensity: ${_sceneDensity.toStringAsFixed(2)}',
              'noise: ${_noise.toStringAsFixed(2)}',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _layerCard(ThemeData theme, _LayerTemplate template, PlatformViewLayer layer) {
    return SizedBox(
      width: _compactCards ? 222 : 252,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(_compactCards ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(template.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text('role: ${template.role}', style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(template.note, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(170), fontSize: 12.5)),
              const SizedBox(height: 8),
              _chip('viewId ${layer.viewId}', Colors.indigo),
              const SizedBox(height: 6),
              _chip('rect ${_rectString(layer.rect)}', Colors.teal),
              const SizedBox(height: 6),
              _chip('attached ${layer.attached}', layer.attached ? Colors.green : Colors.orange),
              const SizedBox(height: 6),
              _chip('subtreeHasCompositionCallbacks ${layer.subtreeHasCompositionCallbacks}', Colors.deepPurple),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(150)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11.5)),
    );
  }

  String _rectString(Rect rect) {
    return '${rect.left.toStringAsFixed(0)},${rect.top.toStringAsFixed(0)} ${rect.width.toStringAsFixed(0)}x${rect.height.toStringAsFixed(0)}';
  }

  Widget _lifecycleBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Lifecycle Board', 'Run lifecycle operations and inspect cumulative counters.', 'life'),
          const SizedBox(height: 10),
          if (_showLifecycleLegend)
            _card(
              theme,
              'Lifecycle Legend',
              'Guidance for commonly used PlatformViewLayer lifecycle methods in this demo.',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _legendLine('markNeedsAddToScene', 'Marks layer as needing scene update in next composition pass.'),
                  _legendLine('debugMarkClean', 'Clears debug dirty marker after simulated scene processing.'),
                  _legendLine('updateSubtreeNeedsAddToScene', 'Propagates subtree scene update requirement flags.'),
                  _legendLine('addCompositionCallback', 'Registers callback to observe composition events.'),
                ],
              ),
            ),
          if (_showLifecycleLegend) const SizedBox(height: 10),
          _card(
            theme,
            'Lifecycle Counters',
            'Current operation totals across all active layer instances.',
            Column(
              children: [
                _counterRow(theme, 'markNeedsAddToScene', _markCalls, Colors.orange),
                _counterRow(theme, 'debugMarkClean', _cleanCalls, Colors.teal),
                _counterRow(theme, 'updateSubtreeNeedsAddToScene', _updateCalls, Colors.indigo),
                _counterRow(theme, 'addCompositionCallback', _callbackRegistrations, Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Layer Details',
            'Snapshot details from each layer instance after lifecycle operations.',
            Column(
              children: [
                for (var i = 0; i < _layers.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
                      border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('L$i', style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 11)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('viewId ${_layers[i].viewId} • depth ${_layers[i].depth}', style: const TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Text('attached ${_layers[i].attached} • subtreeHasCompositionCallbacks ${_layers[i].subtreeHasCompositionCallbacks}', style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(170))),
                              const SizedBox(height: 2),
                              Text('rect ${_rectString(_layers[i].rect)}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11.8)),
                            ],
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

  Widget _legendLine(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 194, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5))),
          Expanded(child: Text(detail, style: const TextStyle(fontSize: 12.5))),
        ],
      ),
    );
  }

  Widget _counterRow(ThemeData theme, String label, int value, Color color) {
    final ratio = ((value % 100) / 100).clamp(0.05, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 210, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: ratio,
                backgroundColor: color.withAlpha(46),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 52, child: Text('$value', textAlign: TextAlign.right, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }

  Widget _sceneBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Scene Composition Board', 'Visualize how PlatformViewLayer rects sit within mixed scene stacks.', 'scene'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Scene Flags',
            'Toggle visual scene flags and inspect layer overlays in the composition map.',
            ToggleButtons(
              isSelected: _sceneSelection,
              onPressed: (i) {
                setState(() {
                  _sceneSelection = _toggle(_sceneSelection, i);
                  _tick += 1;
                  _event('Scene flag toggled index $i.');
                });
              },
              children: const [
                _MiniLabel(icon: Icons.layers, text: 'Layers'),
                _MiniLabel(icon: Icons.crop_free, text: 'Rects'),
                _MiniLabel(icon: Icons.map, text: 'Map'),
                _MiniLabel(icon: Icons.noise_control_off, text: 'Noise'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Composition Map',
            'Rectangles represent PlatformViewLayer constructor rects over Flutter background surfaces.',
            _compositionMap(theme),
          ),
        ],
      ),
    );
  }

  Widget _compositionMap(ThemeData theme) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primaryContainer.withAlpha(150),
                      theme.colorScheme.secondaryContainer.withAlpha(125),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('Flutter Base Surface', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ),
          for (var i = 0; i < _layers.length; i++)
            Positioned(
              left: _layers[i].rect.left * 0.7,
              top: _layers[i].rect.top * 0.48,
              width: _layers[i].rect.width * 0.68,
              height: _layers[i].rect.height * 0.46,
              child: Opacity(
                opacity: 0.56 + (_sceneDensity * 0.34),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.withAlpha((88 + _sceneDensity * 120).toInt()),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withAlpha(150)),
                  ),
                  child: Center(
                    child: Text(
                      'view ${_layers[i].viewId}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          if (_showRectOverlay)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _RectOverlayPainter(
                    rects: _layers.map((l) => l.rect).toList(),
                    color: theme.colorScheme.tertiary,
                    density: _sceneDensity,
                  ),
                ),
              ),
            ),
          if (_noise > 0 && _sceneSelection[3])
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _NoisePainter(color: theme.colorScheme.secondary, amplitude: _noise, tick: _tick),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _integratedBoard(ThemeData theme, _LayerScenario scenario, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Integrated Dashboard', scenario.description, 'integrated'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Runtime Controls',
            'Combine constructor/lifecycle operations inside one dashboard with immediate diagnostics updates.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: _markAllNeedsScene,
                  icon: const Icon(Icons.flag),
                  label: const Text('Mark all'),
                ),
                OutlinedButton.icon(
                  onPressed: _markAllClean,
                  icon: const Icon(Icons.cleaning_services),
                  label: const Text('Clean all'),
                ),
                OutlinedButton.icon(
                  onPressed: _updateAllSubtreeFlags,
                  icon: const Icon(Icons.update),
                  label: const Text('Update subtree'),
                ),
                OutlinedButton.icon(
                  onPressed: _registerCompositionCallbacks,
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Register callbacks'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Integrated Surface',
            'Composite panel with pseudo platform windows plus metrics and controls.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _compositionMap(theme),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final m in metrics)
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
              ],
            ),
          ),
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
          _section(theme, 'Guide + Timeline', 'How to use PlatformViewLayer effectively in mixed composition stacks.', 'guide'),
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
                  Text('events: ${_timeline.length}  |  tick: $_tick  |  layers: ${_layers.length}'),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Use lifecycle and constructor actions to populate timeline.')
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
            _card(
              theme,
              'Metric Digest',
              'Quick summary of counters accumulated during this run.',
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
      'Constructor Gallery',
      'Lifecycle Board',
      'Scene Composition',
      'Integrated Surface',
      'Guide + Timeline',
    ];
    return titles[i.clamp(0, titles.length - 1)];
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

class _LayerGlyphPainter extends CustomPainter {
  _LayerGlyphPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed.toInt() + 63);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.32 + rnd.nextDouble() * 0.60);
      final y = 8 + i * 8.0;
      p.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.2), const Radius.circular(4)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LayerGlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}

class _RectOverlayPainter extends CustomPainter {
  _RectOverlayPainter({required this.rects, required this.color, required this.density});

  final List<Rect> rects;
  final Color color;
  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = color.withAlpha((130 + density * 90).toInt());

    for (final r in rects) {
      final scaled = Rect.fromLTWH(r.left * 0.7, r.top * 0.48, r.width * 0.68, r.height * 0.46);
      canvas.drawRRect(
        RRect.fromRectAndRadius(scaled, const Radius.circular(8)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RectOverlayPainter oldDelegate) {
    return oldDelegate.rects != rects || oldDelegate.color != color || oldDelegate.density != density;
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
      ..color = color.withAlpha((24 + amplitude * 70).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

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
