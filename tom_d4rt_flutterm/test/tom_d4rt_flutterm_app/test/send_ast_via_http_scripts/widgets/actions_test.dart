import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _Palette {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _Palette({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Harbor Blue',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF0F766E),
    background: Color(0xFFF2F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF17233A),
    muted: Color(0xFF5F6F8A),
  ),
  _Palette(
    name: 'Graph Mint',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFF7C3AED),
    accent: Color(0xFFB45309),
    background: Color(0xFFF2FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF14322F),
    muted: Color(0xFF5D726D),
  ),
  _Palette(
    name: 'Slate Citrus',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF667085),
  ),
];

enum _Stage {
  registry,
  matrix,
  cascade,
  shortcuts,
  theater,
  compendium,
}

enum _Density {
  relaxed,
  balanced,
  dense,
}

class _EventLog {
  final DateTime time;
  final String source;
  final String message;
  final Color color;

  const _EventLog({
    required this.time,
    required this.source,
    required this.message,
    required this.color,
  });
}

class _OpenOrderIntent extends Intent {
  const _OpenOrderIntent();
}

class _ShipOrderIntent extends Intent {
  const _ShipOrderIntent();
}

class _EscalateIntent extends Intent {
  const _EscalateIntent();
}

class _ToggleAutoIntent extends Intent {
  const _ToggleAutoIntent();
}

class _ResetFlowIntent extends Intent {
  const _ResetFlowIntent();
}

class _RotatePaletteIntent extends Intent {
  const _RotatePaletteIntent();
}

class _LocalOpenOrderIntent extends Intent {
  const _LocalOpenOrderIntent();
}

class _StudioAction extends Action<Intent> {
  _StudioAction({
    required this.label,
    required this.color,
    required this.onInvoke,
    bool enabled = true,
  }) : _enabled = enabled;

  final String label;
  final Color color;
  final void Function(Intent intent) onInvoke;
  bool _enabled;

  @override
  bool isEnabled(covariant Intent intent) {
    return _enabled;
  }

  @override
  Object? invoke(covariant Intent intent) {
    if (!_enabled) {
      return null;
    }
    onInvoke(intent);
    return null;
  }

  void setEnabledState(bool enabled) {
    if (_enabled == enabled) {
      return;
    }
    _enabled = enabled;
    notifyActionListeners();
  }
}

class _AuditDispatcher extends ActionDispatcher {
  _AuditDispatcher({required this.onTrace});

  final void Function(String trace) onTrace;

  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    onTrace(
      'invokeAction ${action.runtimeType} <- ${intent.runtimeType} '
      '(context: ${context != null})',
    );
    return super.invokeAction(action, intent, context);
  }

  @override
  (bool, Object?) invokeActionIfEnabled(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    onTrace('invokeActionIfEnabled ${action.runtimeType} <- ${intent.runtimeType}');
    return super.invokeActionIfEnabled(action, intent, context);
  }
}

dynamic build(BuildContext context) {
  return const _ActionsDeepDemo();
}

class _ActionsDeepDemo extends StatefulWidget {
  const _ActionsDeepDemo();

  @override
  State<_ActionsDeepDemo> createState() => _ActionsDeepDemoState();
}

class _ActionsDeepDemoState extends State<_ActionsDeepDemo> {
  _Stage _stage = _Stage.registry;
  _Density _density = _Density.balanced;
  int _paletteIndex = 0;

  bool _verbose = false;
  bool _showGuides = true;
  bool _showMetrics = true;
  bool _autoRouting = true;

  int _opened = 0;
  int _shipped = 0;
  int _escalated = 0;
  int _localOpened = 0;
  int _backlog = 14;

  double _registryWidth = 840;
  double _registryHeight = 470;
  double _timelineHeight = 340;
  double _theaterWidth = 780;
  double _theaterHeight = 520;

  final FocusNode _shortcutFocus = FocusNode(debugLabel: 'actions-shortcuts');

  late final _AuditDispatcher _dispatcher;
  late final _StudioAction _openAction;
  late final _StudioAction _shipAction;
  late final _StudioAction _escalateAction;
  late final _StudioAction _toggleAutoAction;
  late final _StudioAction _resetAction;
  late final _StudioAction _rotatePaletteAction;
  late final _StudioAction _localOpenAction;

  final List<_EventLog> _timeline = <_EventLog>[];
  final Map<String, int> _invokeHits = <String, int>{};

  static const _stageLabels = <String>[
    '1 Actions Registry Studio',
    '2 Invocation Matrix',
    '3 Scope Cascade Lab',
    '4 Shortcut Command Arena',
    '5 Responsive Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  @override
  void initState() {
    super.initState();
    _dispatcher = _AuditDispatcher(onTrace: _trace);

    _openAction = _StudioAction(
      label: 'Open Order',
      color: const Color(0xFF1D4ED8),
      onInvoke: (intent) {
        setState(() {
          _opened += 1;
          _backlog += 1;
        });
        _registerHit('Open Order');
        _log('action', 'Open Order invoked', _openAction.color);
      },
    );

    _shipAction = _StudioAction(
      label: 'Ship Order',
      color: const Color(0xFF0F766E),
      onInvoke: (intent) {
        setState(() {
          _shipped += 1;
          if (_backlog > 0) {
            _backlog -= 1;
          }
        });
        _registerHit('Ship Order');
        _log('action', 'Ship Order invoked', _shipAction.color);
      },
    );

    _escalateAction = _StudioAction(
      label: 'Escalate',
      color: const Color(0xFFEA580C),
      onInvoke: (intent) {
        setState(() {
          _escalated += 1;
        });
        _registerHit('Escalate');
        _log('action', 'Escalation triggered', _escalateAction.color);
      },
    );

    _toggleAutoAction = _StudioAction(
      label: 'Toggle Auto Routing',
      color: const Color(0xFF7C3AED),
      onInvoke: (intent) {
        setState(() {
          _autoRouting = !_autoRouting;
          _shipAction.setEnabledState(_autoRouting || _backlog > 0);
        });
        _registerHit('Toggle Auto Routing');
        _log(
          'action',
          _autoRouting ? 'Auto routing enabled' : 'Auto routing disabled',
          _toggleAutoAction.color,
        );
      },
    );

    _resetAction = _StudioAction(
      label: 'Reset Flow',
      color: const Color(0xFF334155),
      onInvoke: (intent) {
        setState(() {
          _opened = 0;
          _shipped = 0;
          _escalated = 0;
          _localOpened = 0;
          _backlog = 14;
        });
        _registerHit('Reset Flow');
        _log('action', 'Flow reset complete', _resetAction.color);
      },
    );

    _rotatePaletteAction = _StudioAction(
      label: 'Rotate Palette',
      color: const Color(0xFF0E7490),
      onInvoke: (intent) {
        setState(() {
          _paletteIndex = (_paletteIndex + 1) % _palettes.length;
        });
        _registerHit('Rotate Palette');
        _log('action', 'Palette rotated to ${_p.name}', _rotatePaletteAction.color);
      },
    );

    _localOpenAction = _StudioAction(
      label: 'Local Open (Inner Scope)',
      color: const Color(0xFFB45309),
      onInvoke: (intent) {
        setState(() {
          _localOpened += 1;
        });
        _registerHit('Local Open (Inner Scope)');
        _log('inner', 'Inner scope open action invoked', _localOpenAction.color);
      },
    );

    _shipAction.setEnabledState(_autoRouting || _backlog > 0);
    _log('boot', 'Actions demo initialized', _p.primary);
  }

  @override
  void dispose() {
    _shortcutFocus.dispose();
    super.dispose();
  }

  void _registerHit(String key) {
    setState(() {
      _invokeHits[key] = (_invokeHits[key] ?? 0) + 1;
    });
  }

  void _trace(String message) {
    _log('dispatcher', message, _p.accent);
  }

  void _log(String source, String message, Color color) {
    final row = _EventLog(
      time: DateTime.now(),
      source: source,
      message: message,
      color: color,
    );
    setState(() {
      _timeline.insert(0, row);
      if (_timeline.length > 36) {
        _timeline.removeRange(36, _timeline.length);
      }
    });
    if (_verbose) {
      debugPrint('[ActionsDemo][$source] $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _toolbar(),
            Expanded(
              child: Actions(
                dispatcher: _dispatcher,
                actions: <Type, Action<Intent>>{
                  _OpenOrderIntent: _openAction,
                  _ShipOrderIntent: _shipAction,
                  _EscalateIntent: _escalateAction,
                  _ToggleAutoIntent: _toggleAutoAction,
                  _ResetFlowIntent: _resetAction,
                  _RotatePaletteIntent: _rotatePaletteAction,
                },
                child: _body(),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_p.primary, _p.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Actions Deep Demo Studio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Intent to Action Routing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Actions provides an intent-to-command map in the widget tree. '
            'This demo shows how Actions scopes, dispatching, and shortcuts '
            'compose into reliable command systems in interpreter scenarios.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.4,
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          for (var i = 0; i < _stageLabels.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _p.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              onSelected: (_) => setState(() => _stage = _Stage.values[i]),
            ),
          const SizedBox(width: 10),
          Text(
            'Density',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          _densityChip('Relaxed', _Density.relaxed),
          _densityChip('Balanced', _Density.balanced),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text(
            'Palette',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => setState(() => _paletteIndex = index),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].primary,
          border: Border.all(
            color: _paletteIndex == index ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _densityChip(String label, _Density density) {
    return ChoiceChip(
      selected: _density == density,
      selectedColor: _p.secondary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == density ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) => setState(() => _density = density),
    );
  }

  Widget _body() {
    switch (_stage) {
      case _Stage.registry:
        return _registryStage();
      case _Stage.matrix:
        return _matrixStage();
      case _Stage.cascade:
        return _cascadeStage();
      case _Stage.shortcuts:
        return _shortcutsStage();
      case _Stage.theater:
        return _theaterStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _registryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Actions Registry Studio'),
          const SizedBox(height: 8),
          Text(
            'The Actions widget holds a map of intent types to action objects. '
            'Use Actions.invoke in subtree contexts to route commands through this map.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Registry Controls',
            subtitle: 'Board dimensions and telemetry controls.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'board width',
                  value: _registryWidth,
                  min: 360,
                  max: 1100,
                  divisions: 37,
                  display: _registryWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _registryWidth = v),
                ),
                _sliderRow(
                  label: 'board height',
                  value: _registryHeight,
                  min: 280,
                  max: 660,
                  divisions: 38,
                  display: _registryHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _registryHeight = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showGuides,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _showGuides = v ?? true),
                    ),
                    Text('show guides', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showMetrics,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _showMetrics = v ?? true),
                    ),
                    Text('show metrics', style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Registry Console',
            subtitle: 'Buttons trigger Actions.invoke on this Actions scope.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _registryWidth,
                height: _registryHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: _registryControlPanel()),
                              const SizedBox(width: 10),
                              Expanded(flex: 3, child: _registryInspectorPanel()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_showGuides)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GuidePainter(
                              color: _p.primary.withValues(alpha: 0.1),
                              spacing: 44,
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
    );
  }

  Widget _registryControlPanel() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoke Through Actions',
              style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: 'Open Order',
              icon: Icons.add_circle_outline_rounded,
              color: _openAction.color,
              onPressed: () {
                Actions.invoke(context, const _OpenOrderIntent());
              },
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: 'Ship Order',
              icon: Icons.local_shipping_outlined,
              color: _shipAction.color,
              onPressed: () {
                final result = Actions.maybeInvoke(context, const _ShipOrderIntent());
                _log('invoke', 'maybeInvoke ship => $result', _shipAction.color);
              },
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: 'Escalate',
              icon: Icons.priority_high_rounded,
              color: _escalateAction.color,
              onPressed: () {
                Actions.invoke(context, const _EscalateIntent());
              },
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: _autoRouting ? 'Disable Auto Routing' : 'Enable Auto Routing',
              icon: _autoRouting ? Icons.route_outlined : Icons.alt_route_rounded,
              color: _toggleAutoAction.color,
              onPressed: () {
                Actions.invoke(context, const _ToggleAutoIntent());
              },
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: 'Reset Flow',
              icon: Icons.restart_alt_rounded,
              color: _resetAction.color,
              onPressed: () {
                Actions.invoke(context, const _ResetFlowIntent());
              },
            ),
            const SizedBox(height: 8),
            _commandButton(
              label: 'Rotate Palette',
              icon: Icons.palette_outlined,
              color: _rotatePaletteAction.color,
              onPressed: () {
                Actions.invoke(context, const _RotatePaletteIntent());
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _chip('opened', '$_opened', _openAction.color),
                _chip('shipped', '$_shipped', _shipAction.color),
                _chip('escalated', '$_escalated', _escalateAction.color),
                _chip('backlog', '$_backlog', _p.primary),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _registryInspectorPanel() {
    final rows = <(String, String, Color)>[
      ('_OpenOrderIntent', _openAction.runtimeType.toString(), _openAction.color),
      ('_ShipOrderIntent', _shipAction.runtimeType.toString(), _shipAction.color),
      ('_EscalateIntent', _escalateAction.runtimeType.toString(), _escalateAction.color),
      ('_ToggleAutoIntent', _toggleAutoAction.runtimeType.toString(), _toggleAutoAction.color),
      ('_ResetFlowIntent', _resetAction.runtimeType.toString(), _resetAction.color),
      (
        '_RotatePaletteIntent',
        _rotatePaletteAction.runtimeType.toString(),
        _rotatePaletteAction.color,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Action Map Inspector',
          style: TextStyle(color: _p.ink, fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (context, index) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final row = rows[index];
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: row.$3.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: row.$3.withValues(alpha: 0.31)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        row.$1,
                        style: TextStyle(
                          color: _p.ink,
                          fontFamily: 'monospace',
                          fontSize: 10.8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      row.$2,
                      style: TextStyle(color: _p.muted, fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (_showMetrics) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _chip('Open hits', '${_invokeHits['Open Order'] ?? 0}', _openAction.color),
              _chip('Ship hits', '${_invokeHits['Ship Order'] ?? 0}', _shipAction.color),
              _chip('Escalate hits', '${_invokeHits['Escalate'] ?? 0}', _escalateAction.color),
            ],
          ),
        ],
      ],
    );
  }

  Widget _commandButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  Widget _matrixStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Invocation Matrix'),
          const SizedBox(height: 8),
          Text(
            'Compare invocation paths: direct Actions.invoke, Actions.maybeInvoke, '
            'and dispatcher-level invocation traces.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Matrix Controls',
            subtitle: 'Timeline window and trace events.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 220,
                  max: 620,
                  divisions: 40,
                  display: _timelineHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => setState(_timeline.clear),
                      icon: const Icon(Icons.delete_sweep_rounded),
                      label: const Text('Clear timeline'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        _dispatcher.invokeAction(_openAction, const _OpenOrderIntent());
                        _dispatcher.invokeActionIfEnabled(
                          _escalateAction,
                          const _EscalateIntent(),
                        );
                      },
                      icon: const Icon(Icons.play_circle_outline_rounded),
                      label: const Text('Dispatcher sample run'),
                    ),
                    const Spacer(),
                    _chip('events', '${_timeline.length}', _p.accent),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Trace Timeline',
            subtitle: 'Command routing events with source tags.',
            tint: _p.secondary.withValues(alpha: 0.05),
            child: SizedBox(
              height: _timelineHeight,
              child: _timeline.isEmpty
                  ? Center(
                      child: Text(
                        'No events yet. Trigger commands from stage 1 or use sample run.',
                        style: TextStyle(color: _p.muted, fontSize: 12),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _timeline.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final row = _timeline[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: row.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: row.color.withValues(alpha: 0.31)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _chip('src', row.source, row.color),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  row.message,
                                  style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatTime(row.time),
                                style: TextStyle(
                                  color: _p.muted,
                                  fontFamily: 'monospace',
                                  fontSize: 10.2,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Matrix Notes',
            subtitle: 'Interpreting command routing behavior.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Use Actions.invoke when an action is guaranteed in scope.'),
                _bullet('Use Actions.maybeInvoke when command availability is optional.'),
                _bullet('Custom ActionDispatcher helps inspect runtime routing and policy.'),
                _bullet('Keep intent types explicit for predictable action lookup.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime value) {
    final h = value.hour.toString().padLeft(2, '0');
    final m = value.minute.toString().padLeft(2, '0');
    final s = value.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _cascadeStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scope Cascade Lab'),
          const SizedBox(height: 8),
          Text(
            'Nested Actions widgets can override intent bindings in local subtrees '
            'without affecting parent scopes.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Cascade Visualizer',
            subtitle: 'Outer scope and inner override scope.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Builder(
              builder: (outerContext) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.primary.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _p.primary.withValues(alpha: 0.27)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Outer Actions Scope',
                        style: TextStyle(
                          color: _p.ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _liteButton(
                            label: 'Outer Open',
                            color: _openAction.color,
                            onTap: () {
                              Actions.invoke(outerContext, const _OpenOrderIntent());
                            },
                          ),
                          _liteButton(
                            label: 'Outer Escalate',
                            color: _escalateAction.color,
                            onTap: () {
                              Actions.invoke(outerContext, const _EscalateIntent());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Actions(
                        actions: <Type, Action<Intent>>{
                          _OpenOrderIntent: _localOpenAction,
                          _LocalOpenOrderIntent: _localOpenAction,
                        },
                        child: Builder(
                          builder: (innerContext) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _p.secondary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _p.secondary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Inner Actions Scope (Open overridden)',
                                    style: TextStyle(
                                      color: _p.ink,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.4,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _liteButton(
                                        label: 'Inner Open',
                                        color: _localOpenAction.color,
                                        onTap: () {
                                          Actions.invoke(innerContext, const _OpenOrderIntent());
                                        },
                                      ),
                                      _liteButton(
                                        label: 'Inner Escalate (fallback to outer)',
                                        color: _escalateAction.color,
                                        onTap: () {
                                          Actions.invoke(innerContext, const _EscalateIntent());
                                        },
                                      ),
                                      _liteButton(
                                        label: 'Local Intent',
                                        color: _localOpenAction.color,
                                        onTap: () {
                                          Actions.invoke(
                                            innerContext,
                                            const _LocalOpenOrderIntent(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chip('global open', '$_opened', _openAction.color),
                          _chip('inner open', '$_localOpened', _localOpenAction.color),
                          _chip('escalate', '$_escalated', _escalateAction.color),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Scope Rules',
            subtitle: 'How Actions lookup behaves in nested trees.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Lookup starts at the nearest Actions ancestor in context.'),
                _bullet('Inner scopes can override parent actions for selected intents.'),
                _bullet('Intents not overridden continue to resolve from parent scope.'),
                _bullet('This enables local command customization with shared defaults.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _liteButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.33)),
        ),
        child: Text(
          label,
          style: TextStyle(color: _p.ink, fontSize: 11.5, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _shortcutsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Shortcut Command Arena'),
          const SizedBox(height: 8),
          Text(
            'Shortcuts emits intents, and Actions resolves those intents into actions. '
            'This stage demonstrates keyboard-driven command flows.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Shortcut Legend',
            subtitle: 'Focus the panel and use these keys.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _chip('O', 'Open', _openAction.color),
                _chip('S', 'Ship', _shipAction.color),
                _chip('E', 'Escalate', _escalateAction.color),
                _chip('A', 'Toggle Auto', _toggleAutoAction.color),
                _chip('R', 'Reset', _resetAction.color),
                _chip('P', 'Palette', _rotatePaletteAction.color),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Focused Shortcut Surface',
            subtitle: 'Commands route through Actions map using keyboard intents.',
            tint: _p.secondary.withValues(alpha: 0.05),
            child: Shortcuts(
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.keyO): _OpenOrderIntent(),
                SingleActivator(LogicalKeyboardKey.keyS): _ShipOrderIntent(),
                SingleActivator(LogicalKeyboardKey.keyE): _EscalateIntent(),
                SingleActivator(LogicalKeyboardKey.keyA): _ToggleAutoIntent(),
                SingleActivator(LogicalKeyboardKey.keyR): _ResetFlowIntent(),
                SingleActivator(LogicalKeyboardKey.keyP): _RotatePaletteIntent(),
              },
              child: Focus(
                focusNode: _shortcutFocus,
                autofocus: true,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _shortcutFocus.hasFocus
                                ? 'Keyboard focus active'
                                : 'Click panel then press focus button',
                            style: TextStyle(
                              color: _p.ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () => _shortcutFocus.requestFocus(),
                            icon: const Icon(Icons.keyboard_rounded),
                            label: const Text('Focus panel'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chip('opened', '$_opened', _openAction.color),
                          _chip('shipped', '$_shipped', _shipAction.color),
                          _chip('escalated', '$_escalated', _escalateAction.color),
                          _chip('backlog', '$_backlog', _p.primary),
                        ],
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

  Widget _theaterStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Responsive Theater'),
          const SizedBox(height: 8),
          Text(
            'Actions-based command surfaces adapt to shell constraints while '
            'maintaining consistent intent routing behavior.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Theater Controls',
            subtitle: 'Custom shell width and height.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'shell width',
                  value: _theaterWidth,
                  min: 340,
                  max: 1120,
                  divisions: 39,
                  display: _theaterWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _theaterWidth = v),
                ),
                _sliderRow(
                  label: 'shell height',
                  value: _theaterHeight,
                  min: 280,
                  max: 760,
                  divisions: 24,
                  display: _theaterHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _theaterHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _shellCard('Pocket', 340, 460, 'single lane'),
              _shellCard('Tablet', 620, 480, 'dual lane'),
              _shellCard('Custom', _theaterWidth, _theaterHeight, 'user controlled lane'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shellCard(String label, double width, double height, String note) {
    return SizedBox(
      width: width > 640 ? 540 : 390,
      child: _card(
        title: '$label Shell',
        subtitle: 'w ${width.toStringAsFixed(0)} | h ${height.toStringAsFixed(0)} | $note',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                final lane = maxW < 430
                    ? 1
                    : maxW < 780
                        ? 2
                        : 3;

                Widget laneBody;
                if (lane == 1) {
                  laneBody = Column(
                    children: [
                      Expanded(child: _laneTile('Open', _openAction.color, _opened)),
                      Expanded(child: _laneTile('Ship', _shipAction.color, _shipped)),
                      Expanded(child: _laneTile('Escalate', _escalateAction.color, _escalated)),
                    ],
                  );
                } else if (lane == 2) {
                  laneBody = Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: _laneTile('Open', _openAction.color, _opened)),
                            Expanded(child: _laneTile('Local', _localOpenAction.color, _localOpened)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: _laneTile('Ship', _shipAction.color, _shipped)),
                            Expanded(
                              child: _laneTile('Escalate', _escalateAction.color, _escalated),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  laneBody = Row(
                    children: [
                      Expanded(child: _laneTile('Open', _openAction.color, _opened)),
                      Expanded(child: _laneTile('Ship', _shipAction.color, _shipped)),
                      Expanded(child: _laneTile('Escalate', _escalateAction.color, _escalated)),
                    ],
                  );
                }

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: _p.secondary.withValues(alpha: 0.12),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
                      ),
                      child: Row(
                        children: [
                          _chip('lane', '$lane', _p.secondary),
                          const SizedBox(width: 6),
                          _chip('w', maxW.toStringAsFixed(0), _p.primary),
                          if (_showMetrics) ...[
                            const SizedBox(width: 6),
                            _chip('events', '${_timeline.length}', _p.accent),
                          ],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: laneBody,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _laneTile(String title, Color color, int value) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: _p.ink, fontSize: 11.4, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Text(
            '$value',
            style: TextStyle(
              color: _p.ink,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _card(
            title: 'Actions Reference Matrix',
            subtitle: 'What Actions is for and how to apply it.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Role',
                  value: 'Resolve intents to action implementations within widget subtree scopes.',
                ),
                _matrixRow(
                  keyText: 'Constructor',
                  value: 'Actions(dispatcher: optional, actions: map, child: widget)',
                ),
                _matrixRow(
                  keyText: 'Invocation',
                  value: 'Actions.invoke(context, intent) and Actions.maybeInvoke(context, intent)',
                ),
                _matrixRow(
                  keyText: 'Scoping model',
                  value:
                      'Nearest Actions ancestor wins. Nested scopes can override selected intents.',
                ),
                _matrixRow(
                  keyText: 'Dispatcher use',
                  value:
                      'Custom ActionDispatcher can instrument routing and centralize invoke policy.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical command-system guidance.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Keep intent classes explicit and focused',
                  detail:
                      'Small intent types make routing behavior predictable and testable.',
                ),
                _doDont(
                  good: false,
                  title: 'Mix unrelated side effects in one action',
                  detail:
                      'Split actions by command responsibility to avoid brittle behavior.',
                ),
                _doDont(
                  good: true,
                  title: 'Use nested Actions for local override',
                  detail:
                      'Override only the intents a subtree needs to customize.',
                ),
                _doDont(
                  good: false,
                  title: 'Assume every command exists everywhere',
                  detail:
                      'Use maybeInvoke for optional command availability.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common Actions questions in interpreter demos.',
            child: Column(
              children: [
                _qa(
                  q: 'What is the difference between Actions and Action?',
                  a: 'Actions is the widget scope map; Action is the command object implementation.',
                ),
                _qa(
                  q: 'When should I use maybeInvoke?',
                  a: 'When command presence is optional or scope-dependent.',
                ),
                _qa(
                  q: 'Can I override one command in a subtree?',
                  a: 'Yes. Nest Actions and provide only the override entries.',
                ),
                _qa(
                  q: 'How do shortcuts connect to Actions?',
                  a: 'Shortcuts emits intents, and Actions resolves those intents to actions.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion criteria for Actions.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Multiple visual command surfaces are implemented.'),
                _check('Actions.invoke and Actions.maybeInvoke are demonstrated in-context.'),
                _check('Nested Actions scope override behavior is visually demonstrated.'),
                _check('Shortcuts + Actions integration is demonstrated with focus handling.'),
                _check('Custom dispatcher tracing and routing logs are shown.'),
                _check('Compendium includes matrix, do and dont, FAQ, and checklist guidance.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'Actions is the command routing backbone in Flutter intent systems: '
            'define clear intent classes, bind them in scopes, and invoke them '
            'through context to keep command flows explicit and adaptable.',
          ),
        ],
      ),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String display,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 220,
          child: Text(
            '$label: $display',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.3,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _matrixRow({required String keyText, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              keyText,
              style: TextStyle(
                color: _p.primary,
                fontFamily: 'monospace',
                fontSize: 11.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doDont({
    required bool good,
    required String title,
    required String detail,
  }) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.27)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _p.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _p.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _p.primary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _note(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.34)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _p.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.4)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageLabels[_stage.index],
            style: TextStyle(
              color: _p.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _GuidePainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += spacing;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _GuidePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
