import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ThemeModel> _themeModels = <_ThemeModel>[
  _ThemeModel(
    id: 'aqua',
    name: 'Aqua Console',
    subtitle: 'Cool routing map for interaction shields and pass-through zones.',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
  ),
  _ThemeModel(
    id: 'copper',
    name: 'Copper Board',
    subtitle: 'Warm style for blocker overlays and modal route demos.',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
  ),
  _ThemeModel(
    id: 'slate',
    name: 'Slate Night',
    subtitle: 'High-contrast profile for deep routing diagnostics.',
    seed: Color(0xFF334155),
    brightness: Brightness.dark,
  ),
];

const List<_ScenarioModel> _scenarioModels = <_ScenarioModel>[
  _ScenarioModel(
    mode: _ScenarioMode.shieldGrid,
    title: 'Shield Grid',
    subtitle: 'Several controls routed through toggleable AbsorbPointer shields.',
  ),
  _ScenarioModel(
    mode: _ScenarioMode.nestedStacks,
    title: 'Nested Stacks',
    subtitle: 'Parent-child absorption hierarchy with local unblock regions.',
  ),
  _ScenarioModel(
    mode: _ScenarioMode.modalGate,
    title: 'Modal Gate',
    subtitle: 'Modal-like blocker that absorbs interactions behind the gate.',
  ),
  _ScenarioModel(
    mode: _ScenarioMode.dragDeck,
    title: 'Drag Deck',
    subtitle: 'Pointer drag controls that can be frozen with input absorption.',
  ),
  _ScenarioModel(
    mode: _ScenarioMode.formFlow,
    title: 'Form Flow',
    subtitle: 'Form controls with staged enable/absorb transitions.',
  ),
  _ScenarioModel(
    mode: _ScenarioMode.analytics,
    title: 'Analytics',
    subtitle: 'Comprehensive route summaries and blocked/pass-through metrics.',
  ),
];

const List<String> _guideLines = <String>[
  'AbsorbPointer prevents its subtree from receiving pointer events.',
  'RenderAbsorbPointer is the render-layer primitive behind AbsorbPointer widget behavior.',
  'Absorption differs from IgnorePointer: AbsorbPointer stops events in subtree and still participates in hit testing.',
  'Use absorption for temporary lock states, modal transitions, and controlled freeze interactions.',
  'Visual indicators are important so users understand why controls are temporarily non-interactive.',
  'Layered demos help verify which controls still react when shield states change.',
  'Combine absorb states with timers, progress, or form validation transitions for safe UX flows.',
  'Track blocked and allowed interactions to verify interpreter-side event routing behavior.',
  'Nested absorbers should be tested carefully to avoid accidental dead zones.',
  'Prefer explicit state labels and diagnostics in complex routing scenarios.',
];

const List<_FaqModel> _faqModels = <_FaqModel>[
  _FaqModel(
    question: 'When should I use AbsorbPointer?',
    answer: 'Use it when you need to temporarily block interactions for a subtree while preserving layout and visuals.',
  ),
  _FaqModel(
    question: 'How is it different from IgnorePointer?',
    answer: 'IgnorePointer removes subtree from hit testing; AbsorbPointer absorbs events and can stop routing behind it.',
  ),
  _FaqModel(
    question: 'Can I partially unblock controls?',
    answer: 'Yes, by splitting UI into multiple absorbers and toggling each zone independently.',
  ),
  _FaqModel(
    question: 'Why keep diagnostics in demos?',
    answer: 'They prove which interactions were blocked versus passed through in real runtime behavior.',
  ),
  _FaqModel(
    question: 'Should I animate shield transitions?',
    answer: 'Yes, gentle animation and labels reduce confusion when controls become disabled temporarily.',
  ),
];

enum _ScenarioMode {
  shieldGrid,
  nestedStacks,
  modalGate,
  dragDeck,
  formFlow,
  analytics,
}

class _ThemeModel {
  const _ThemeModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String subtitle;
  final Color seed;
  final Brightness brightness;
}

class _ScenarioModel {
  const _ScenarioModel({required this.mode, required this.title, required this.subtitle});

  final _ScenarioMode mode;
  final String title;
  final String subtitle;
}

class _FaqModel {
  const _FaqModel({required this.question, required this.answer});

  final String question;
  final String answer;
}

class _RouteEvent {
  const _RouteEvent({
    required this.time,
    required this.zone,
    required this.action,
    required this.blocked,
    required this.note,
  });

  final DateTime time;
  final String zone;
  final String action;
  final bool blocked;
  final String note;
}

class _MetricModel {
  const _MetricModel({required this.title, required this.value, required this.note, required this.icon});

  final String title;
  final String value;
  final String note;
  final IconData icon;
}

class _SnapshotModel {
  const _SnapshotModel({
    required this.scenario,
    required this.stage,
    required this.globalAbsorb,
    required this.blocked,
    required this.allowed,
  });

  final String scenario;
  final String stage;
  final bool globalAbsorb;
  final int blocked;
  final int allowed;
}

dynamic build(BuildContext context) {
  return const _RenderAbsorbPointerStudio();
}

class _RenderAbsorbPointerStudio extends StatefulWidget {
  const _RenderAbsorbPointerStudio();

  @override
  State<_RenderAbsorbPointerStudio> createState() => _RenderAbsorbPointerStudioState();
}

class _RenderAbsorbPointerStudioState extends State<_RenderAbsorbPointerStudio> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 9400),
  )..repeat();

  int _themeIndex = 0;
  int _scenarioIndex = 0;

  bool _globalAbsorb = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _showHeat = true;
  bool _animate = true;

  bool _zoneAAbsorb = false;
  bool _zoneBAbsorb = true;
  bool _zoneCAbsorb = false;
  bool _zoneDAbsorb = true;
  bool _modalAbsorb = true;
  bool _dragAbsorb = false;
  bool _formAbsorb = false;
  bool _nestedOuterAbsorb = true;
  bool _nestedInnerAbsorb = false;

  double _stageHeight = 570;
  double _cardRoundness = 18;
  double _zoneOpacity = 0.92;
  double _overlayAlpha = 0.34;
  double _heatIntensity = 0.56;
  double _drift = 0.32;
  double _panelScale = 1.0;
  double _lockPulse = 0.55;
  double _dragX = 0.45;
  double _dragY = 0.48;

  int _themeSwitches = 0;
  int _scenarioSwitches = 0;
  int _controlEdits = 0;
  int _blockedCount = 0;
  int _allowedCount = 0;
  int _tapCount = 0;
  int _dragCount = 0;
  int _formEdits = 0;
  int _buttonHits = 0;

  String _phase = 'idle';
  String _statusText = 'Ready';

  final TextEditingController _nameController = TextEditingController(text: 'Alex');
  final TextEditingController _noteController = TextEditingController(text: 'AbsorbPointer deep demo');

  _SnapshotModel _snapshot = const _SnapshotModel(
    scenario: 'shieldGrid',
    stage: 'ready',
    globalAbsorb: false,
    blocked: 0,
    allowed: 0,
  );

  List<_RouteEvent> _events = const <_RouteEvent>[];
  List<Offset> _heatPoints = const <Offset>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recordEvent(zone: 'system', action: 'init', blocked: false, note: 'RenderAbsorbPointer studio initialized.');
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool get _effectiveAbsorb => _globalAbsorb;

  void _recordEvent({required String zone, required String action, required bool blocked, required String note}) {
    setState(() {
      if (blocked) {
        _blockedCount += 1;
      } else {
        _allowedCount += 1;
      }
      _events = <_RouteEvent>[
        _RouteEvent(time: DateTime.now(), zone: zone, action: action, blocked: blocked, note: note),
        ..._events,
      ].take(180).toList(growable: false);
    });
  }

  void _addHeat(Offset local) {
    setState(() {
      _heatPoints = <Offset>[local, ..._heatPoints].take(120).toList(growable: false);
    });
  }

  void _onZoneAction({required String zone, required String action, required bool absorbed, String note = ''}) {
    setState(() {
      _phase = absorbed ? 'blocked' : 'allowed';
      _statusText = absorbed ? 'Blocked at $zone' : 'Allowed at $zone';
      if (!absorbed) {
        _buttonHits += 1;
      }
    });
    _recordEvent(
      zone: zone,
      action: action,
      blocked: absorbed,
      note: note.isEmpty ? (absorbed ? 'Absorbed by shield' : 'Action executed') : note,
    );
  }

  void _toggle(String key, bool? value) {
    final bool next = value ?? true;
    setState(() {
      switch (key) {
        case 'globalAbsorb':
          _globalAbsorb = next;
          break;
        case 'guide':
          _showGuide = next;
          break;
        case 'timeline':
          _showTimeline = next;
          break;
        case 'diagnostics':
          _showDiagnostics = next;
          break;
        case 'grid':
          _showGrid = next;
          break;
        case 'labels':
          _showLabels = next;
          break;
        case 'heat':
          _showHeat = next;
          break;
        case 'animate':
          _animate = next;
          break;
      }
      _controlEdits += 1;
      _phase = 'toggle';
    });
    if (_animate) {
      _pulse.repeat();
    } else {
      _pulse.stop();
    }
    _recordEvent(zone: 'control', action: 'toggle:$key', blocked: false, note: 'Set to $next');
  }

  void _reset() {
    setState(() {
      _themeIndex = 0;
      _scenarioIndex = 0;
      _globalAbsorb = false;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _showGrid = true;
      _showLabels = true;
      _showHeat = true;
      _animate = true;
      _zoneAAbsorb = false;
      _zoneBAbsorb = true;
      _zoneCAbsorb = false;
      _zoneDAbsorb = true;
      _modalAbsorb = true;
      _dragAbsorb = false;
      _formAbsorb = false;
      _nestedOuterAbsorb = true;
      _nestedInnerAbsorb = false;
      _stageHeight = 570;
      _cardRoundness = 18;
      _zoneOpacity = 0.92;
      _overlayAlpha = 0.34;
      _heatIntensity = 0.56;
      _drift = 0.32;
      _panelScale = 1.0;
      _lockPulse = 0.55;
      _dragX = 0.45;
      _dragY = 0.48;
      _controlEdits += 1;
      _phase = 'reset';
      _statusText = 'Reset to defaults';
      _blockedCount = 0;
      _allowedCount = 0;
      _tapCount = 0;
      _dragCount = 0;
      _formEdits = 0;
      _buttonHits = 0;
      _events = const <_RouteEvent>[];
      _heatPoints = const <Offset>[];
      _nameController.text = 'Alex';
      _noteController.text = 'AbsorbPointer deep demo';
      _snapshot = const _SnapshotModel(scenario: 'shieldGrid', stage: 'ready', globalAbsorb: false, blocked: 0, allowed: 0);
    });
    _pulse.repeat();
    _recordEvent(zone: 'system', action: 'reset', blocked: false, note: 'Studio reset to defaults');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemeModel theme = _themeModels[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: theme.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[scheme.surface, scheme.surfaceContainerLow, scheme.surfaceContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1540),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(scheme),
                      const SizedBox(height: 14),
                      _buildThemeScenarioBoard(scheme),
                      const SizedBox(height: 14),
                      _buildControlBoard(scheme),
                      const SizedBox(height: 14),
                      _buildStageBoard(scheme),
                      const SizedBox(height: 14),
                      _buildComparisonBoard(scheme),
                      const SizedBox(height: 14),
                      _buildMetricsBoard(scheme),
                      if (_showGuide) const SizedBox(height: 14),
                      if (_showGuide) _buildGuideBoard(scheme),
                      if (_showTimeline) const SizedBox(height: 14),
                      if (_showTimeline) _buildTimelineBoard(scheme),
                    ],
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
                Icon(Icons.block_outlined, color: scheme.primary, size: 26),
                Text('RenderAbsorbPointer Input Routing Lab', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 25)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarioModels[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Visual deep demo to understand blocked versus pass-through interactions with AbsorbPointer and RenderAbsorbPointer behavior.',
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
              children: List<Widget>.generate(_themeModels.length, (int index) {
                final _ThemeModel profile = _themeModels[index];
                return ChoiceChip(
                  selected: _themeIndex == index,
                  label: Text(profile.name),
                  onSelected: (_) {
                    setState(() {
                      _themeIndex = index;
                      _themeSwitches += 1;
                      _phase = 'theme';
                    });
                    _recordEvent(zone: 'control', action: 'theme', blocked: false, note: profile.id);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themeModels[_themeIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenarios', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarioModels.length, (int index) {
                final _ScenarioModel scenario = _scenarioModels[index];
                return FilterChip(
                  selected: _scenarioIndex == index,
                  label: Text(scenario.title),
                  onSelected: (_) {
                    setState(() {
                      _scenarioIndex = index;
                      _scenarioSwitches += 1;
                      _phase = 'scenario';
                    });
                    _recordEvent(zone: 'control', action: 'scenario', blocked: false, note: scenario.mode.name);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarioModels[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Absorption Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _reset, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tune global and local absorbers, visuals, and interaction routing diagnostics.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 420,
              max: 920,
              divisions: 250,
              onChanged: (double value) => setState(() => _stageHeight = value),
              onEnded: (double value) => _onSlider('stageHeight', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Card Roundness',
              value: _cardRoundness,
              min: 0,
              max: 36,
              divisions: 72,
              onChanged: (double value) => setState(() => _cardRoundness = value),
              onEnded: (double value) => _onSlider('cardRoundness', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Zone Opacity',
              value: _zoneOpacity,
              min: 0.2,
              max: 1,
              divisions: 80,
              onChanged: (double value) => setState(() => _zoneOpacity = value),
              onEnded: (double value) => _onSlider('zoneOpacity', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Overlay Alpha',
              value: _overlayAlpha,
              min: 0,
              max: 0.9,
              divisions: 90,
              onChanged: (double value) => setState(() => _overlayAlpha = value),
              onEnded: (double value) => _onSlider('overlayAlpha', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Heat Intensity',
              value: _heatIntensity,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _heatIntensity = value),
              onEnded: (double value) => _onSlider('heatIntensity', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Background Drift',
              value: _drift,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _drift = value),
              onEnded: (double value) => _onSlider('drift', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Panel Scale',
              value: _panelScale,
              min: 0.7,
              max: 1.4,
              divisions: 70,
              onChanged: (double value) => setState(() => _panelScale = value),
              onEnded: (double value) => _onSlider('panelScale', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Lock Pulse',
              value: _lockPulse,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (double value) => setState(() => _lockPulse = value),
              onEnded: (double value) => _onSlider('lockPulse', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Drag X',
              value: _dragX,
              min: 0.05,
              max: 0.95,
              divisions: 90,
              onChanged: (double value) => setState(() => _dragX = value),
              onEnded: (double value) => _onSlider('dragX', value),
            ),
            _slider(
              scheme: scheme,
              label: 'Drag Y',
              value: _dragY,
              min: 0.05,
              max: 0.95,
              divisions: 90,
              onChanged: (double value) => setState(() => _dragY = value),
              onEnded: (double value) => _onSlider('dragY', value),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(value: _globalAbsorb, onChanged: (bool? v) => _toggle('globalAbsorb', v), child: const Text('Global absorb')),
                CheckboxMenuButton(value: _showGrid, onChanged: (bool? v) => _toggle('grid', v), child: const Text('Show grid')),
                CheckboxMenuButton(value: _showLabels, onChanged: (bool? v) => _toggle('labels', v), child: const Text('Show labels')),
                CheckboxMenuButton(value: _showHeat, onChanged: (bool? v) => _toggle('heat', v), child: const Text('Show heat')),
                CheckboxMenuButton(value: _showDiagnostics, onChanged: (bool? v) => _toggle('diagnostics', v), child: const Text('Show diagnostics')),
                CheckboxMenuButton(value: _showGuide, onChanged: (bool? v) => _toggle('guide', v), child: const Text('Show guide')),
                CheckboxMenuButton(value: _showTimeline, onChanged: (bool? v) => _toggle('timeline', v), child: const Text('Show timeline')),
                CheckboxMenuButton(value: _animate, onChanged: (bool? v) => _toggle('animate', v), child: const Text('Animate background')),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilterChip(
                  selected: _zoneAAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _zoneAAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'zoneAAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Zone A absorb'),
                ),
                FilterChip(
                  selected: _zoneBAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _zoneBAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'zoneBAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Zone B absorb'),
                ),
                FilterChip(
                  selected: _zoneCAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _zoneCAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'zoneCAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Zone C absorb'),
                ),
                FilterChip(
                  selected: _zoneDAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _zoneDAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'zoneDAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Zone D absorb'),
                ),
                FilterChip(
                  selected: _modalAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _modalAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'modalAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Modal absorb'),
                ),
                FilterChip(
                  selected: _dragAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _dragAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'dragAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Drag absorb'),
                ),
                FilterChip(
                  selected: _formAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _formAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'formAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Form absorb'),
                ),
                FilterChip(
                  selected: _nestedOuterAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _nestedOuterAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'nestedOuterAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Nested outer absorb'),
                ),
                FilterChip(
                  selected: _nestedInnerAbsorb,
                  onSelected: (bool value) {
                    setState(() {
                      _nestedInnerAbsorb = value;
                      _controlEdits += 1;
                    });
                    _recordEvent(zone: 'control', action: 'nestedInnerAbsorb', blocked: false, note: '$value');
                  },
                  label: const Text('Nested inner absorb'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSlider(String name, double value) {
    setState(() {
      _controlEdits += 1;
      _phase = 'control';
    });
    _recordEvent(zone: 'control', action: 'slider:$name', blocked: false, note: value.toStringAsFixed(2));
  }

  Widget _slider({
    required ColorScheme scheme,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onEnded,
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
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, onChangeEnd: onEnded),
      ],
    );
  }

  Widget _buildStageBoard(ColorScheme scheme) {
    final double pulse = _animate ? _pulse.value : 0;
    _snapshot = _SnapshotModel(
      scenario: _scenarioModels[_scenarioIndex].mode.name,
      stage: _phase,
      globalAbsorb: _globalAbsorb,
      blocked: _blockedCount,
      allowed: _allowedCount,
    );

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Interaction Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Visual stage showing blocked and allowed routes under AbsorbPointer configurations.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            SizedBox(
              height: _stageHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (_showGrid) CustomPaint(painter: _RoutingGridPainter(progress: pulse, drift: _drift)),
                      Listener(
                        onPointerDown: (PointerDownEvent e) {
                          _addHeat(e.localPosition);
                          setState(() => _tapCount += 1);
                        },
                        onPointerMove: (PointerMoveEvent e) {
                          _addHeat(e.localPosition);
                        },
                        child: _buildScenarioLayer(scheme, pulse),
                      ),
                      if (_showHeat)
                        IgnorePointer(
                          child: CustomPaint(
                            painter: _HeatPainter(points: _heatPoints, intensity: _heatIntensity),
                          ),
                        ),
                      if (_effectiveAbsorb)
                        IgnorePointer(
                          child: Container(
                            color: Colors.black.withValues(alpha: _overlayAlpha + (_lockPulse * 0.2 * (0.5 + 0.5 * math.sin(pulse * math.pi * 2)))),
                            child: const Center(
                              child: Text(
                                'GLOBAL ABSORB ACTIVE',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 1.2),
                              ),
                            ),
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

  Widget _buildScenarioLayer(ColorScheme scheme, double pulse) {
    switch (_scenarioModels[_scenarioIndex].mode) {
      case _ScenarioMode.shieldGrid:
        return _shieldGridScene(scheme);
      case _ScenarioMode.nestedStacks:
        return _nestedStacksScene(scheme, pulse);
      case _ScenarioMode.modalGate:
        return _modalGateScene(scheme, pulse);
      case _ScenarioMode.dragDeck:
        return _dragDeckScene(scheme, pulse);
      case _ScenarioMode.formFlow:
        return _formFlowScene(scheme, pulse);
      case _ScenarioMode.analytics:
        return _analyticsScene(scheme, pulse);
    }
  }

  Widget _shieldGridScene(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _shieldZoneCard(scheme: scheme, zone: 'A', absorb: _zoneAAbsorb, colorA: scheme.primary, colorB: scheme.secondary)),
                const SizedBox(width: 12),
                Expanded(child: _shieldZoneCard(scheme: scheme, zone: 'B', absorb: _zoneBAbsorb, colorA: scheme.tertiary, colorB: scheme.primary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _shieldZoneCard(scheme: scheme, zone: 'C', absorb: _zoneCAbsorb, colorA: scheme.secondary, colorB: scheme.tertiary)),
                const SizedBox(width: 12),
                Expanded(child: _shieldZoneCard(scheme: scheme, zone: 'D', absorb: _zoneDAbsorb, colorA: scheme.primary, colorB: scheme.tertiary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shieldZoneCard({
    required ColorScheme scheme,
    required String zone,
    required bool absorb,
    required Color colorA,
    required Color colorB,
  }) {
    final bool blocked = _effectiveAbsorb || absorb;
    return AbsorbPointer(
      absorbing: blocked,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[colorA.withValues(alpha: _zoneOpacity), colorB.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(_cardRoundness),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_showLabels) Text('Zone $zone', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
              if (_showLabels) const SizedBox(height: 4),
              if (_showLabels) Text(blocked ? 'Absorbing input' : 'Passing input', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 12)),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _onZoneAction(zone: 'zone-$zone', action: 'primaryButton', absorbed: blocked),
                    child: const Text('Primary'),
                  ),
                  OutlinedButton(
                    onPressed: () => _onZoneAction(zone: 'zone-$zone', action: 'secondaryButton', absorbed: blocked),
                    child: const Text('Secondary'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => _onZoneAction(zone: 'zone-$zone', action: 'tonalButton', absorbed: blocked),
                    child: const Text('Tonal'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: _lockPulse,
                onChanged: blocked
                    ? null
                    : (double value) {
                        setState(() {
                          _lockPulse = value;
                          _controlEdits += 1;
                        });
                        _onZoneAction(zone: 'zone-$zone', action: 'slider', absorbed: blocked, note: value.toStringAsFixed(2));
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nestedStacksScene(ColorScheme scheme, double pulse) {
    final bool outerBlocked = _effectiveAbsorb || _nestedOuterAbsorb;
    final bool innerBlocked = outerBlocked || _nestedInnerAbsorb;
    return Center(
      child: SizedBox(
        width: 860,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AbsorbPointer(
              absorbing: outerBlocked,
              child: Container(
                height: 430,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _zoneOpacity), scheme.secondary.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(_cardRoundness + 4),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Text(outerBlocked ? 'Outer absorbs' : 'Outer allows', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                    Center(
                      child: AbsorbPointer(
                        absorbing: innerBlocked,
                        child: Container(
                          width: 420,
                          height: 250,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[scheme.tertiary.withValues(alpha: 0.88), scheme.primary.withValues(alpha: 0.88)]),
                            borderRadius: BorderRadius.circular(_cardRoundness),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(innerBlocked ? 'Inner absorbs' : 'Inner allows', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                                const Spacer(),
                                Row(
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () => _onZoneAction(zone: 'nested-inner', action: 'button', absorbed: innerBlocked),
                                      child: const Text('Inner Action'),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      onPressed: () => _onZoneAction(zone: 'nested-inner', action: 'outlined', absorbed: innerBlocked),
                                      child: const Text('Inner Outline'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (outerBlocked)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.25 + 0.12 * (0.5 + 0.5 * math.sin(pulse * math.pi * 2))),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: _modeBadge('outer=${_nestedOuterAbsorb ? 'absorb' : 'allow'} inner=${_nestedInnerAbsorb ? 'absorb' : 'allow'}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalGateScene(ColorScheme scheme, double pulse) {
    final bool blocked = _effectiveAbsorb || _modalAbsorb;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(child: _actionPanel(scheme, 'Back Panel A', 'modal-back-a', blocked, scheme.primary, scheme.secondary)),
                    const SizedBox(width: 12),
                    Expanded(child: _actionPanel(scheme, 'Back Panel B', 'modal-back-b', blocked, scheme.tertiary, scheme.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(child: _actionPanel(scheme, 'Back Panel C', 'modal-back-c', blocked, scheme.secondary, scheme.tertiary)),
                    const SizedBox(width: 12),
                    Expanded(child: _actionPanel(scheme, 'Back Panel D', 'modal-back-d', blocked, scheme.primary, scheme.tertiary)),
                  ],
                ),
              ),
            ],
          ),
          if (blocked)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.32 + 0.18 * (0.5 + 0.5 * math.sin(pulse * math.pi * 2))),
                  child: Center(
                    child: Container(
                      width: 430,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.5))),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Modal Gate Absorbing Input', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
                          SizedBox(height: 8),
                          Text('Background panels are visible but non-interactive while absorb is active.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _actionPanel(ColorScheme scheme, String title, String zone, bool blocked, Color c1, Color c2) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[c1.withValues(alpha: _zoneOpacity), c2.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(_cardRoundness),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
            const Spacer(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                ElevatedButton(onPressed: () => _onZoneAction(zone: zone, action: 'primary', absorbed: blocked), child: const Text('Action')),
                OutlinedButton(onPressed: () => _onZoneAction(zone: zone, action: 'secondary', absorbed: blocked), child: const Text('Route')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dragDeckScene(ColorScheme scheme, double pulse) {
    final bool blocked = _effectiveAbsorb || _dragAbsorb;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        final Offset marker = Offset(width * _dragX, height * _dragY);
        return AbsorbPointer(
          absorbing: blocked,
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              if (blocked) {
                _onZoneAction(zone: 'drag-deck', action: 'drag', absorbed: true);
                return;
              }
              setState(() {
                _dragX = (_dragX + (details.delta.dx / width)).clamp(0.05, 0.95);
                _dragY = (_dragY + (details.delta.dy / height)).clamp(0.05, 0.95);
                _dragCount += 1;
                _phase = 'drag';
              });
              _recordEvent(zone: 'drag-deck', action: 'drag', blocked: false, note: '(${_dragX.toStringAsFixed(2)}, ${_dragY.toStringAsFixed(2)})');
            },
            onTapDown: (TapDownDetails details) {
              _addHeat(details.localPosition);
              _onZoneAction(zone: 'drag-deck', action: 'tap', absorbed: blocked);
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _zoneOpacity), scheme.tertiary.withValues(alpha: _zoneOpacity)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(_cardRoundness),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.6),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: marker.dx - 42,
                    top: marker.dy - 42,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22 + 0.25 * (0.5 + 0.5 * math.sin(pulse * math.pi * 2))),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.75), width: 2),
                      ),
                      child: const Icon(Icons.open_with, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(blocked ? 'Drag deck absorbed' : 'Drag deck active', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                  if (blocked)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.25),
                        child: const Center(child: Text('Drag blocked by AbsorbPointer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _formFlowScene(ColorScheme scheme, double pulse) {
    final bool blocked = _effectiveAbsorb || _formAbsorb;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: AbsorbPointer(
              absorbing: blocked,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[scheme.primary.withValues(alpha: _zoneOpacity), scheme.secondary.withValues(alpha: _zoneOpacity)]),
                  borderRadius: BorderRadius.circular(_cardRoundness),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Form Flow Surface', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      onChanged: (String value) {
                        if (!blocked) {
                          setState(() {
                            _formEdits += 1;
                            _phase = 'form';
                          });
                          _recordEvent(zone: 'form', action: 'nameChanged', blocked: false, note: value);
                        }
                      },
                      decoration: const InputDecoration(filled: true, labelText: 'Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      maxLines: 3,
                      onChanged: (String value) {
                        if (!blocked) {
                          setState(() {
                            _formEdits += 1;
                            _phase = 'form';
                          });
                          _recordEvent(zone: 'form', action: 'noteChanged', blocked: false, note: value.length.toString());
                        }
                      },
                      decoration: const InputDecoration(filled: true, labelText: 'Note'),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => _onZoneAction(zone: 'form', action: 'save', absorbed: blocked, note: _nameController.text),
                          child: const Text('Save'),
                        ),
                        OutlinedButton(
                          onPressed: () => _onZoneAction(zone: 'form', action: 'preview', absorbed: blocked, note: _noteController.text.length.toString()),
                          child: const Text('Preview'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            if (blocked) {
                              _onZoneAction(zone: 'form', action: 'clear', absorbed: true);
                              return;
                            }
                            setState(() {
                              _nameController.clear();
                              _noteController.clear();
                              _phase = 'form';
                            });
                            _recordEvent(zone: 'form', action: 'clear', blocked: false, note: 'cleared');
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(_cardRoundness), border: Border.all(color: Colors.white.withValues(alpha: 0.35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('State Summary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('formAbsorb=$_formAbsorb', style: const TextStyle(color: Colors.white70)),
                  Text('globalAbsorb=$_globalAbsorb', style: const TextStyle(color: Colors.white70)),
                  Text('name=${_nameController.text}', style: const TextStyle(color: Colors.white70)),
                  Text('noteLength=${_noteController.text.length}', style: const TextStyle(color: Colors.white70)),
                  Text('formEdits=$_formEdits', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Text(
                    blocked ? 'Form interactions are currently absorbed.' : 'Form is interactive and events flow to fields and buttons.',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  LinearProgressIndicator(value: 0.4 + 0.3 * (0.5 + 0.5 * math.sin(pulse * math.pi * 2))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _analyticsScene(ColorScheme scheme, double pulse) {
    final bool blocked = _effectiveAbsorb;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _actionPanel(scheme, 'Tap Metric Panel', 'analytics-a', blocked, scheme.primary, scheme.secondary)),
              const SizedBox(width: 12),
              Expanded(child: _actionPanel(scheme, 'Route Metric Panel', 'analytics-b', blocked, scheme.tertiary, scheme.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[scheme.secondary.withValues(alpha: _zoneOpacity), scheme.tertiary.withValues(alpha: _zoneOpacity)]),
                borderRadius: BorderRadius.circular(_cardRoundness),
                border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Interpreter Interaction Verification', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17)),
                  const SizedBox(height: 8),
                  const Text('1. Toggle absorber states and observe blocked/allowed counters.', style: TextStyle(color: Colors.white70)),
                  const Text('2. Validate nested and modal route changes in timeline entries.', style: TextStyle(color: Colors.white70)),
                  const Text('3. Confirm drag and form paths freeze immediately when absorbed.', style: TextStyle(color: Colors.white70)),
                  const Text('4. Ensure visual labels always explain current interaction lock state.', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _modeBadge('blocked=$_blockedCount'),
                      _modeBadge('allowed=$_allowedCount'),
                      _modeBadge('status=$_statusText'),
                      _modeBadge('phase=$_phase'),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (_allowedCount + _blockedCount) == 0 ? 0 : _allowedCount / (_allowedCount + _blockedCount),
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (_allowedCount + _blockedCount) == 0 ? 0 : _blockedCount / (_allowedCount + _blockedCount),
                          minHeight: 10,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withValues(alpha: 0.4))),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }

  Widget _buildComparisonBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('AbsorbPointer vs IgnorePointer', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Comparison cards explain routing implications for common locking strategies.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget absorb = _compareCard(
                  scheme: scheme,
                  title: 'AbsorbPointer',
                  note: 'Absorbs hits for subtree and can stop event reach behind depending on composition.',
                  color: const Color(0xFF0F766E),
                  icon: Icons.block,
                );
                final Widget ignore = _compareCard(
                  scheme: scheme,
                  title: 'IgnorePointer',
                  note: 'Subtree does not receive hit testing; events can pass to widgets behind.',
                  color: const Color(0xFF1D4ED8),
                  icon: Icons.visibility_off_outlined,
                );
                final Widget render = _compareCard(
                  scheme: scheme,
                  title: 'RenderAbsorbPointer',
                  note: 'Render layer primitive used by AbsorbPointer for event routing.',
                  color: const Color(0xFFB45309),
                  icon: Icons.account_tree_outlined,
                );
                if (narrow) {
                  return Column(children: <Widget>[absorb, const SizedBox(height: 10), ignore, const SizedBox(height: 10), render]);
                }
                return Row(children: <Widget>[Expanded(child: absorb), const SizedBox(width: 10), Expanded(child: ignore), const SizedBox(width: 10), Expanded(child: render)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareCard({required ColorScheme scheme, required String title, required String note, required Color color, required IconData icon}) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 95,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.65))),
              child: Center(child: Icon(icon, color: color, size: 34)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricModel> metrics = _metrics();
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
                    childAspectRatio: columns == 1 ? 2.72 : 2.08,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricModel m = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(m.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(m.title, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
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
            if (_showDiagnostics) _buildSnapshotPanel(scheme),
          ],
        ),
      ),
    );
  }

  List<_MetricModel> _metrics() {
    return <_MetricModel>[
      _MetricModel(title: 'Scenario', value: _scenarioModels[_scenarioIndex].title, note: 'Active absorption scenario.', icon: Icons.route_outlined),
      _MetricModel(title: 'Theme', value: _themeModels[_themeIndex].name, note: 'Current visual profile.', icon: Icons.palette_outlined),
      _MetricModel(title: 'Global Absorb', value: '$_globalAbsorb', note: 'Global routing lock state.', icon: Icons.block_outlined),
      _MetricModel(title: 'Status', value: _statusText, note: 'Latest routing status message.', icon: Icons.info_outline),
      _MetricModel(title: 'Blocked', value: '$_blockedCount', note: 'Blocked interactions recorded.', icon: Icons.do_not_touch_outlined),
      _MetricModel(title: 'Allowed', value: '$_allowedCount', note: 'Allowed interactions recorded.', icon: Icons.check_circle_outline),
      _MetricModel(title: 'Tap Count', value: '$_tapCount', note: 'Pointer taps observed on stage.', icon: Icons.touch_app_outlined),
      _MetricModel(title: 'Drag Count', value: '$_dragCount', note: 'Drag updates accepted.', icon: Icons.open_with_outlined),
      _MetricModel(title: 'Form Edits', value: '$_formEdits', note: 'Form updates accepted.', icon: Icons.edit_outlined),
      _MetricModel(title: 'Button Hits', value: '$_buttonHits', note: 'Successful action triggers.', icon: Icons.smart_button_outlined),
      _MetricModel(title: 'Zone Absorb', value: 'A=$_zoneAAbsorb B=$_zoneBAbsorb C=$_zoneCAbsorb D=$_zoneDAbsorb', note: 'Shield grid states.', icon: Icons.grid_view_outlined),
      _MetricModel(title: 'Nested', value: 'outer=$_nestedOuterAbsorb inner=$_nestedInnerAbsorb', note: 'Nested absorber states.', icon: Icons.account_tree_outlined),
      _MetricModel(title: 'Modal/Form/Drag', value: 'modal=$_modalAbsorb form=$_formAbsorb drag=$_dragAbsorb', note: 'Scenario lock toggles.', icon: Icons.dashboard_customize_outlined),
      _MetricModel(title: 'Panel Visuals', value: 'round=${_cardRoundness.toStringAsFixed(1)} opacity=${_zoneOpacity.toStringAsFixed(2)}', note: 'Card and panel style settings.', icon: Icons.style_outlined),
      _MetricModel(title: 'Overlay', value: 'alpha=${_overlayAlpha.toStringAsFixed(2)} lockPulse=${_lockPulse.toStringAsFixed(2)}', note: 'Global blocker overlay settings.', icon: Icons.layers_outlined),
      _MetricModel(title: 'Heat', value: 'points=${_heatPoints.length} intensity=${_heatIntensity.toStringAsFixed(2)}', note: 'Tap heat-map summary.', icon: Icons.blur_on_outlined),
      _MetricModel(title: 'Switches', value: 'theme=$_themeSwitches scenario=$_scenarioSwitches controls=$_controlEdits', note: 'Configuration change counters.', icon: Icons.swap_horiz_outlined),
      _MetricModel(title: 'Snapshot', value: '${_snapshot.scenario} ${_snapshot.stage} g=${_snapshot.globalAbsorb}', note: 'Current run snapshot.', icon: Icons.camera_outlined),
      _MetricModel(title: 'Timeline Size', value: '${_events.length}', note: 'Bounded event timeline size.', icon: Icons.timeline_outlined),
      _MetricModel(title: 'Phase', value: _phase, note: 'Most recent interaction phase.', icon: Icons.flag_outlined),
    ];
  }

  Widget _buildSnapshotPanel(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Routing Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('theme=${_themeModels[_themeIndex].id} scenario=${_scenarioModels[_scenarioIndex].mode.name} globalAbsorb=$_globalAbsorb', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('stageHeight=${_stageHeight.toStringAsFixed(0)} panelScale=${_panelScale.toStringAsFixed(2)} roundness=${_cardRoundness.toStringAsFixed(1)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('zoneOpacity=${_zoneOpacity.toStringAsFixed(2)} overlayAlpha=${_overlayAlpha.toStringAsFixed(2)} heatIntensity=${_heatIntensity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('drag=(${_dragX.toStringAsFixed(2)}, ${_dragY.toStringAsFixed(2)}) lockPulse=${_lockPulse.toStringAsFixed(2)} drift=${_drift.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('zones A=$_zoneAAbsorb B=$_zoneBAbsorb C=$_zoneCAbsorb D=$_zoneDAbsorb nestedOuter=$_nestedOuterAbsorb nestedInner=$_nestedInnerAbsorb', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('modal=$_modalAbsorb form=$_formAbsorb drag=$_dragAbsorb blocked=$_blockedCount allowed=$_allowedCount events=${_events.length}', style: TextStyle(color: scheme.onSurfaceVariant)),
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
            ..._guideLines.map((String line) {
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
            ..._faqModels.map(( _FaqModel faq) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(faq.question, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(faq.answer, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                Text('Interaction Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _events = const <_RouteEvent>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological record of blocked and allowed interactions across zones.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_events.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                child: Text('Timeline is empty. Interact with controls and stage to create events.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _events.take(42).map(( _RouteEvent event) {
                  final String stamp = '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}:${event.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: event.blocked ? Colors.red.withValues(alpha: 0.25) : Colors.green.withValues(alpha: 0.25),
                        child: Icon(event.blocked ? Icons.block : Icons.check, size: 18, color: event.blocked ? Colors.red : Colors.green),
                      ),
                      title: Text('${event.zone}  |  ${event.action}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 13)),
                      subtitle: Text('$stamp  |  ${event.blocked ? 'blocked' : 'allowed'}  |  ${event.note}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
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

class _RoutingGridPainter extends CustomPainter {
  const _RoutingGridPainter({required this.progress, required this.drift});

  final double progress;
  final double drift;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Color.lerp(const Color(0xFF22D3EE), const Color(0xFF34D399), (math.sin(progress * math.pi * 2) + 1) / 2)!,
          Color.lerp(const Color(0xFF3B82F6), const Color(0xFF8B5CF6), drift)!,
          Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEF4444), (math.cos(progress * math.pi * 2) + 1) / 2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black.withValues(alpha: 0.2));

    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    const double step = 28;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _RoutingGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.drift != drift;
  }
}

class _HeatPainter extends CustomPainter {
  const _HeatPainter({required this.points, required this.intensity});

  final List<Offset> points;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i += 1) {
      final Offset p = points[i];
      final double alpha = (1 - (i / math.max(1, points.length))) * intensity;
      final Rect rect = Rect.fromCircle(center: p, radius: 34);
      final Paint glow = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            const Color(0xFFFDE047).withValues(alpha: alpha),
            const Color(0xFFF97316).withValues(alpha: alpha * 0.32),
            const Color(0xFFF97316).withValues(alpha: 0),
          ],
        ).createShader(rect);
      canvas.drawCircle(p, 34, glow);
    }
  }

  @override
  bool shouldRepaint(covariant _HeatPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.intensity != intensity;
  }
}
