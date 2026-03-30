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
    name: 'Signal Harbor',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF1D4ED8),
    background: Color(0xFFF1FBFA),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF13312E),
    muted: Color(0xFF5E746F),
  ),
  _Palette(
    name: 'Graphite Mint',
    primary: Color(0xFF111827),
    secondary: Color(0xFF0891B2),
    accent: Color(0xFF65A30D),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
  _Palette(
    name: 'Cinder Coral',
    primary: Color(0xFF9A3412),
    secondary: Color(0xFF7C3AED),
    accent: Color(0xFF0E7490),
    background: Color(0xFFFFF8F5),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF3C2A27),
    muted: Color(0xFF7D635E),
  ),
];

enum _DemoStage {
  commandDeck,
  traceBoard,
  nestedLab,
  shortcutsArena,
  theater,
  compendium,
}

enum _Density {
  relaxed,
  balanced,
  dense,
}

class _SignalLog {
  final DateTime time;
  final String source;
  final String message;
  final Color color;

  const _SignalLog({
    required this.time,
    required this.source,
    required this.message,
    required this.color,
  });
}

class _CreateTicketIntent extends Intent {
  const _CreateTicketIntent();
}

class _ArchiveTicketIntent extends Intent {
  const _ArchiveTicketIntent();
}

class _PulseIntent extends Intent {
  const _PulseIntent();
}

class _ToggleSafetyIntent extends Intent {
  const _ToggleSafetyIntent();
}

class _ResetBoardIntent extends Intent {
  const _ResetBoardIntent();
}

class _RotatePaletteIntent extends Intent {
  const _RotatePaletteIntent();
}

class _StudioAction extends Action<Intent> {
  _StudioAction({
    required this.label,
    required this.tint,
    required this.onInvoke,
    bool enabled = true,
  }) : _enabled = enabled;

  final String label;
  final Color tint;
  final void Function(Intent intent) onInvoke;

  bool _enabled;
  int _signalVersion = 0;
  String _lastReason = 'initialized';

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

  void setEnabledState(bool enabled, {String reason = 'state changed'}) {
    if (_enabled == enabled) {
      return;
    }
    _enabled = enabled;
    _lastReason = reason;
    _signalVersion += 1;
    notifyActionListeners();
  }

  void announce(String reason) {
    _lastReason = reason;
    _signalVersion += 1;
    notifyActionListeners();
  }

  int get signalVersion => _signalVersion;
  String get lastReason => _lastReason;
}

class _TracingDispatcher extends ActionDispatcher {
  _TracingDispatcher({required this.onTrace});

  final void Function(String trace) onTrace;

  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    onTrace(
      'invokeAction: ${action.runtimeType} <- ${intent.runtimeType} '
      '(context: ${context != null})',
    );
    return super.invokeAction(action, intent, context);
  }
}

dynamic build(BuildContext context) {
  return const _ActionListenerDeepDemo();
}

class _ActionListenerDeepDemo extends StatefulWidget {
  const _ActionListenerDeepDemo();

  @override
  State<_ActionListenerDeepDemo> createState() => _ActionListenerDeepDemoState();
}

class _ActionListenerDeepDemoState extends State<_ActionListenerDeepDemo> {
  _DemoStage _stage = _DemoStage.commandDeck;
  _Density _density = _Density.balanced;
  int _paletteIndex = 0;
  bool _verbose = false;
  bool _showHints = true;
  bool _showGrid = true;
  bool _showMetrics = true;

  int _created = 0;
  int _archived = 0;
  int _pulseCount = 0;
  bool _safetyMode = true;
  int _queueDepth = 12;
  int _maxTimelineRows = 20;

  double _boardWidth = 820;
  double _boardHeight = 460;
  double _traceHeight = 360;
  double _theaterWidth = 760;
  double _theaterHeight = 480;

  final FocusNode _shortcutFocus = FocusNode(debugLabel: 'action-listener-demo');

  late final _TracingDispatcher _dispatcher;
  late final _StudioAction _createAction;
  late final _StudioAction _archiveAction;
  late final _StudioAction _pulseAction;
  late final _StudioAction _safetyAction;
  late final _StudioAction _resetAction;
  late final _StudioAction _rotatePaletteAction;

  final List<_SignalLog> _timeline = <_SignalLog>[];
  final Map<String, int> _listenerHits = <String, int>{};
  final Map<String, String> _listenerReasons = <String, String>{};

  static const _stageTitles = <String>[
    '1 Command Deck Studio',
    '2 Dispatcher Trace Board',
    '3 Nested Listener Lab',
    '4 Shortcuts Arena',
    '5 Control Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  @override
  void initState() {
    super.initState();
    _dispatcher = _TracingDispatcher(onTrace: _logDispatcherTrace);

    _createAction = _StudioAction(
      label: 'Create Ticket Action',
      tint: const Color(0xFF1D4ED8),
      onInvoke: (intent) {
        setState(() {
          _created += 1;
          _queueDepth += 1;
        });
        _createAction.announce('ticket created');
        _log('create', 'Created one ticket', _createAction.tint);
      },
    );

    _archiveAction = _StudioAction(
      label: 'Archive Ticket Action',
      tint: const Color(0xFFEA580C),
      onInvoke: (intent) {
        setState(() {
          _archived += 1;
          if (_queueDepth > 0) {
            _queueDepth -= 1;
          }
        });
        _archiveAction.announce('ticket archived');
        _log('archive', 'Archived one ticket', _archiveAction.tint);
      },
    );

    _pulseAction = _StudioAction(
      label: 'Pulse Diagnostics Action',
      tint: const Color(0xFF7C3AED),
      onInvoke: (intent) {
        setState(() {
          _pulseCount += 1;
        });
        _pulseAction.announce('diagnostic pulse');
        _log('pulse', 'Diagnostics pulse emitted', _pulseAction.tint);
      },
    );

    _safetyAction = _StudioAction(
      label: 'Toggle Safety Action',
      tint: const Color(0xFF0F766E),
      onInvoke: (intent) {
        setState(() {
          _safetyMode = !_safetyMode;
          _archiveAction.setEnabledState(
            _safetyMode || _queueDepth > 0,
            reason: _safetyMode ? 'safe archive policy' : 'manual override policy',
          );
        });
        _safetyAction.announce('safety toggled');
        _log(
          'safety',
          _safetyMode ? 'Safety mode ON' : 'Safety mode OFF',
          _safetyAction.tint,
        );
      },
    );

    _resetAction = _StudioAction(
      label: 'Reset Board Action',
      tint: const Color(0xFF334155),
      onInvoke: (intent) {
        setState(() {
          _created = 0;
          _archived = 0;
          _pulseCount = 0;
          _queueDepth = 12;
        });
        _createAction.announce('board reset touched create');
        _archiveAction.announce('board reset touched archive');
        _pulseAction.announce('board reset touched pulse');
        _resetAction.announce('board reset');
        _log('reset', 'Board counters reset', _resetAction.tint);
      },
    );

    _rotatePaletteAction = _StudioAction(
      label: 'Rotate Palette Action',
      tint: const Color(0xFF0E7490),
      onInvoke: (intent) {
        setState(() {
          _paletteIndex = (_paletteIndex + 1) % _palettes.length;
        });
        _rotatePaletteAction.announce('palette rotated');
        _log('palette', 'Palette rotated to ${_p.name}', _rotatePaletteAction.tint);
      },
    );

    _archiveAction.setEnabledState(
      _safetyMode || _queueDepth > 0,
      reason: 'initial policy evaluation',
    );

    _log('boot', 'ActionListener studio booted', _p.primary);
  }

  @override
  void dispose() {
    _shortcutFocus.dispose();
    super.dispose();
  }

  void _logDispatcherTrace(String trace) {
    _log('dispatcher', trace, _p.accent);
  }

  void _log(String source, String message, Color color) {
    final entry = _SignalLog(
      time: DateTime.now(),
      source: source,
      message: message,
      color: color,
    );
    setState(() {
      _timeline.insert(0, entry);
      if (_timeline.length > _maxTimelineRows) {
        _timeline.removeRange(_maxTimelineRows, _timeline.length);
      }
    });
    if (_verbose) {
      debugPrint('[ActionListenerDemo][$source] $message');
    }
  }

  void _handleActionSignal(Action<Intent> action) {
    final label = action is _StudioAction ? action.label : action.runtimeType.toString();
    setState(() {
      _listenerHits[label] = (_listenerHits[label] ?? 0) + 1;
      if (action is _StudioAction) {
        _listenerReasons[label] = action.lastReason;
      }
    });
    if (action is _StudioAction) {
      _log(
        'listener',
        '${action.label} signal v${action.signalVersion}: ${action.lastReason}',
        action.tint,
      );
    } else {
      _log('listener', '$label signal captured', _p.primary);
    }
  }

  void _invoke(Action<Intent> action, Intent intent, BuildContext context) {
    _dispatcher.invokeAction(action, intent, context);
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
                  _CreateTicketIntent: _createAction,
                  _ArchiveTicketIntent: _archiveAction,
                  _PulseIntent: _pulseAction,
                  _ToggleSafetyIntent: _safetyAction,
                  _ResetBoardIntent: _resetAction,
                  _RotatePaletteIntent: _rotatePaletteAction,
                },
                child: _stageBody(),
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
              const Icon(Icons.hearing_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'ActionListener Deep Demo Studio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Action and Intent Signals',
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
            'ActionListener listens to Action state notifications. It does not '
            'replace invocation, it observes Action signal changes so UI and '
            'tooling layers can react to enablement and runtime updates.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.5,
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
          for (var i = 0; i < _stageTitles.length; i++)
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
              onSelected: (_) => setState(() => _stage = _DemoStage.values[i]),
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
          for (var i = 0; i < _palettes.length; i++)
            GestureDetector(
              onTap: () => setState(() => _paletteIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _palettes[i].primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _paletteIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
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

  Widget _stageBody() {
    switch (_stage) {
      case _DemoStage.commandDeck:
        return _commandDeckStage();
      case _DemoStage.traceBoard:
        return _traceBoardStage();
      case _DemoStage.nestedLab:
        return _nestedListenerStage();
      case _DemoStage.shortcutsArena:
        return _shortcutsStage();
      case _DemoStage.theater:
        return _theaterStage();
      case _DemoStage.compendium:
        return _compendiumStage();
    }
  }

  Widget _commandDeckStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Command Deck Studio'),
          const SizedBox(height: 8),
          Text(
            'This board demonstrates ActionListener attached to multiple '
            'Action objects. Trigger commands and watch listener panels update '
            'with signal counts and reasons.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Deck Controls',
            subtitle: 'Board dimensions and observation options.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'board width',
                  value: _boardWidth,
                  min: 360,
                  max: 1100,
                  divisions: 37,
                  display: _boardWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _boardWidth = v),
                ),
                _sliderRow(
                  label: 'board height',
                  value: _boardHeight,
                  min: 280,
                  max: 620,
                  divisions: 34,
                  display: _boardHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _boardHeight = v),
                ),
                _sliderRow(
                  label: 'timeline rows',
                  value: _maxTimelineRows.toDouble(),
                  min: 8,
                  max: 40,
                  divisions: 32,
                  display: '$_maxTimelineRows',
                  color: _p.accent,
                  onChanged: (v) => setState(() => _maxTimelineRows = v.round()),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showHints,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _showHints = v ?? true),
                    ),
                    Text('show hints', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showGrid,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _showGrid = v ?? true),
                    ),
                    Text('show overlay grid',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showMetrics,
                      activeColor: _p.accent,
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
            title: 'Interactive Deck',
            subtitle: 'Invoke actions and observe ActionListener reactions.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _boardWidth,
                height: _boardHeight,
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
                              Expanded(flex: 2, child: _commandButtonsPanel()),
                              const SizedBox(width: 10),
                              Expanded(flex: 3, child: _listenerPanelGrid()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_showGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GridPainter(
                              color: _p.primary.withValues(alpha: 0.11),
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
          if (_showHints) ...[
            const SizedBox(height: 12),
            _card(
              title: 'Interpretation Notes',
              subtitle: 'How to read this stage.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bullet('Action invocation and ActionListener notification are related but distinct.'),
                  _bullet('ActionListener callback fires when Action notifies listeners.'),
                  _bullet('Enablement changes are a practical trigger for listener updates.'),
                  _bullet('Use listener signals to drive diagnostics and status widgets.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _commandButtonsPanel() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Command Invoker',
              style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: 'Create Ticket',
              icon: Icons.add_circle_outline_rounded,
              color: _createAction.tint,
              onPressed: () => _invoke(_createAction, const _CreateTicketIntent(), context),
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: 'Archive Ticket',
              icon: Icons.archive_outlined,
              color: _archiveAction.tint,
              onPressed: _archiveAction.isEnabled(const _ArchiveTicketIntent())
                  ? () => _invoke(_archiveAction, const _ArchiveTicketIntent(), context)
                  : null,
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: 'Pulse Diagnostics',
              icon: Icons.graphic_eq_rounded,
              color: _pulseAction.tint,
              onPressed: () => _invoke(_pulseAction, const _PulseIntent(), context),
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: _safetyMode ? 'Disable Safety' : 'Enable Safety',
              icon: _safetyMode ? Icons.shield_outlined : Icons.gpp_bad_rounded,
              color: _safetyAction.tint,
              onPressed: () => _invoke(_safetyAction, const _ToggleSafetyIntent(), context),
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: 'Reset Board',
              icon: Icons.restart_alt_rounded,
              color: _resetAction.tint,
              onPressed: () => _invoke(_resetAction, const _ResetBoardIntent(), context),
            ),
            const SizedBox(height: 8),
            _actionButton(
              label: 'Rotate Palette',
              icon: Icons.palette_outlined,
              color: _rotatePaletteAction.tint,
              onPressed: () =>
                  _invoke(_rotatePaletteAction, const _RotatePaletteIntent(), context),
            ),
            const SizedBox(height: 10),
            _metricChips(),
          ],
        );
      },
    );
  }

  Widget _metricChips() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _chip('created', '$_created', _createAction.tint),
        _chip('archived', '$_archived', _archiveAction.tint),
        _chip('queue', '$_queueDepth', _p.primary),
        _chip('pulse', '$_pulseCount', _pulseAction.tint),
        _chip('safety', _safetyMode ? 'on' : 'off', _safetyAction.tint),
      ],
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color.withValues(alpha: 0.35),
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

  Widget _listenerPanelGrid() {
    final compact = _density == _Density.dense;
    final rows = compact ? 2 : 3;
    final columns = compact ? 2 : 2;
    final panels = <Widget>[
      _actionListenerPanel('Create Probe', _createAction, Icons.add_task_rounded),
      _actionListenerPanel('Archive Probe', _archiveAction, Icons.archive_rounded),
      _actionListenerPanel('Pulse Probe', _pulseAction, Icons.sensors_rounded),
      _actionListenerPanel('Safety Probe', _safetyAction, Icons.verified_user_rounded),
      _actionListenerPanel('Reset Probe', _resetAction, Icons.restore_rounded),
      _actionListenerPanel(
        'Palette Probe',
        _rotatePaletteAction,
        Icons.color_lens_outlined,
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: rows == 2 ? 2.25 : 1.9,
      ),
      itemCount: panels.length,
      itemBuilder: (context, index) => panels[index],
    );
  }

  Widget _actionListenerPanel(String title, _StudioAction action, IconData icon) {
    final hits = _listenerHits[action.label] ?? 0;
    final reason = _listenerReasons[action.label] ?? 'none yet';

    return ActionListener(
      action: action,
      listener: _handleActionSignal,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: action.tint.withValues(alpha: 0.11),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: action.tint.withValues(alpha: 0.34)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: action.tint, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _p.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            _chip('signals', '$hits', action.tint),
            const SizedBox(height: 6),
            Text(
              'reason: $reason',
              style: TextStyle(
                color: _p.muted,
                fontSize: 10.6,
                height: 1.28,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              'enabled: ${action.isEnabled(const _PulseIntent())}',
              style: TextStyle(
                color: _p.ink,
                fontFamily: 'monospace',
                fontSize: 10.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _traceBoardStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Dispatcher Trace Board'),
          const SizedBox(height: 8),
          Text(
            'ActionListener focuses on action signals, while ActionDispatcher '
            'focuses on invocation routing. This stage presents both together.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Trace Controls',
            subtitle: 'Timeline and trace board controls.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'trace board height',
                  value: _traceHeight,
                  min: 220,
                  max: 580,
                  divisions: 36,
                  display: _traceHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _traceHeight = v),
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
                      onPressed: () => setState(() {
                        _createAction.announce('manual diagnostics announce');
                        _archiveAction.announce('manual diagnostics announce');
                        _pulseAction.announce('manual diagnostics announce');
                        _safetyAction.announce('manual diagnostics announce');
                      }),
                      icon: const Icon(Icons.campaign_outlined),
                      label: const Text('Broadcast announces'),
                    ),
                    const Spacer(),
                    _chip('rows', '${_timeline.length}', _p.accent),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Trace Timeline',
            subtitle: 'Invocation routes and listener signals.',
            tint: _p.secondary.withValues(alpha: 0.05),
            child: SizedBox(
              height: _traceHeight,
              child: _timeline.isEmpty
                  ? Center(
                      child: Text(
                        'No events yet. Trigger commands in stage 1 or here.',
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
                            border: Border.all(color: row.color.withValues(alpha: 0.32)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _chip('src', row.source, row.color),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  row.message,
                                  style: TextStyle(
                                    color: _p.ink,
                                    fontSize: 11.5,
                                    height: 1.32,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatTime(row.time),
                                style: TextStyle(
                                  color: _p.muted,
                                  fontFamily: 'monospace',
                                  fontSize: 10.4,
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
            title: 'Trace Reading Guide',
            subtitle: 'Distinguish invocation from signal events.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Entries tagged dispatcher represent invocation routing.'),
                _bullet('Entries tagged listener represent ActionListener callbacks.'),
                _bullet('Action announce and enablement updates are listener sources.'),
                _bullet('Use this split to debug command systems in complex trees.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _nestedListenerStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Listener Lab'),
          const SizedBox(height: 8),
          Text(
            'Nested ActionListener widgets can observe the same Action. '
            'This helps different UI layers respond independently to the same signal.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Relay Control',
            subtitle: 'Trigger pulse and watch all nested listeners react.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Builder(
              builder: (context) {
                return ActionListener(
                  action: _pulseAction,
                  listener: _handleActionSignal,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _pulseAction.tint.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _pulseAction.tint.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outer Listener Layer',
                          style: TextStyle(
                            color: _p.ink,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ActionListener(
                          action: _pulseAction,
                          listener: _handleActionSignal,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _p.secondary.withValues(alpha: 0.11),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _p.secondary.withValues(alpha: 0.28),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Middle Listener Layer',
                                  style: TextStyle(
                                    color: _p.ink,
                                    fontSize: 12.4,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ActionListener(
                                  action: _pulseAction,
                                  listener: _handleActionSignal,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: _p.accent.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: _p.accent.withValues(alpha: 0.28),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Inner Listener Layer',
                                          style: TextStyle(
                                            color: _p.ink,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.1,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            _actionButtonLite(
                                              label: 'Pulse Once',
                                              color: _pulseAction.tint,
                                              onTap: () => _invoke(
                                                _pulseAction,
                                                const _PulseIntent(),
                                                context,
                                              ),
                                            ),
                                            _actionButtonLite(
                                              label: 'Announce Only',
                                              color: _p.primary,
                                              onTap: () => _pulseAction
                                                  .announce('manual announce in nested lab'),
                                            ),
                                            _actionButtonLite(
                                              label: 'Pulse x3',
                                              color: _p.secondary,
                                              onTap: () {
                                                _invoke(
                                                  _pulseAction,
                                                  const _PulseIntent(),
                                                  context,
                                                );
                                                _invoke(
                                                  _pulseAction,
                                                  const _PulseIntent(),
                                                  context,
                                                );
                                                _invoke(
                                                  _pulseAction,
                                                  const _PulseIntent(),
                                                  context,
                                                );
                                              },
                                            ),
                                          ],
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
              },
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Lab Metrics',
            subtitle: 'How often each listener receives pulse signals.',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _metricPanel('Pulse action signals', '${_listenerHits[_pulseAction.label] ?? 0}',
                    _pulseAction.tint),
                _metricPanel('Pulse count', '$_pulseCount', _p.accent),
                _metricPanel('Timeline rows', '${_timeline.length}', _p.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtonLite({
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
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.34)),
        ),
        child: Text(
          label,
          style: TextStyle(color: _p.ink, fontSize: 11.5, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _metricPanel(String title, String value, Color color) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: _p.ink, fontSize: 11.6, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: _p.ink,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _shortcutsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Shortcuts Arena'),
          const SizedBox(height: 8),
          Text(
            'Shortcuts and Actions together create command surfaces. '
            'ActionListener then observes Action changes and drives UI diagnostics.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Keyboard Legend',
            subtitle: 'Focus panel and use keyboard shortcuts.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _chip('C', 'Create', _createAction.tint),
                _chip('A', 'Archive', _archiveAction.tint),
                _chip('P', 'Pulse', _pulseAction.tint),
                _chip('S', 'Toggle Safety', _safetyAction.tint),
                _chip('R', 'Reset', _resetAction.tint),
                _chip('T', 'Rotate Theme', _rotatePaletteAction.tint),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Shortcut Focus Arena',
            subtitle: 'ActionListener probes update when keyboard triggers actions.',
            tint: _p.secondary.withValues(alpha: 0.05),
            child: Shortcuts(
              shortcuts: <ShortcutActivator, Intent>{
                const SingleActivator(LogicalKeyboardKey.keyC): const _CreateTicketIntent(),
                const SingleActivator(LogicalKeyboardKey.keyA): const _ArchiveTicketIntent(),
                const SingleActivator(LogicalKeyboardKey.keyP): const _PulseIntent(),
                const SingleActivator(LogicalKeyboardKey.keyS): const _ToggleSafetyIntent(),
                const SingleActivator(LogicalKeyboardKey.keyR): const _ResetBoardIntent(),
                const SingleActivator(LogicalKeyboardKey.keyT): const _RotatePaletteIntent(),
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
                    border: Border.all(color: _p.muted.withValues(alpha: 0.23)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _shortcutFocus.hasFocus
                                ? 'Keyboard focus active'
                                : 'Click this panel to focus',
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
                      const SizedBox(height: 10),
                      _listenerPanelGrid(),
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
          _sectionTitle('Control Theater'),
          const SizedBox(height: 8),
          Text(
            'This stage applies ActionListener patterns across shell sizes to '
            'validate behavior in responsive command dashboards.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Theater Controls',
            subtitle: 'Custom shell dimensions.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'theater width',
                  value: _theaterWidth,
                  min: 340,
                  max: 1080,
                  divisions: 37,
                  display: _theaterWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _theaterWidth = v),
                ),
                _sliderRow(
                  label: 'theater height',
                  value: _theaterHeight,
                  min: 260,
                  max: 760,
                  divisions: 25,
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
              _shellBoard('Pocket Shell', 340, 430, 'single rail'),
              _shellBoard('Tablet Shell', 580, 440, 'split board'),
              _shellBoard(
                'Custom Shell',
                _theaterWidth,
                _theaterHeight,
                'user controlled shell',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shellBoard(String title, double width, double height, String note) {
    return SizedBox(
      width: width > 600 ? 520 : 380,
      child: _card(
        title: title,
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
                final lane = maxW < 420
                    ? 1
                    : maxW < 760
                        ? 2
                        : 3;

                Widget body;
                if (lane == 1) {
                  body = Column(
                    children: [
                      Expanded(child: _miniProbeCard('create', _createAction)),
                      Expanded(child: _miniProbeCard('archive', _archiveAction)),
                      Expanded(child: _miniProbeCard('pulse', _pulseAction)),
                    ],
                  );
                } else if (lane == 2) {
                  body = Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: _miniProbeCard('create', _createAction)),
                            Expanded(child: _miniProbeCard('archive', _archiveAction)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: _miniProbeCard('pulse', _pulseAction)),
                            Expanded(child: _miniProbeCard('safety', _safetyAction)),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  body = Row(
                    children: [
                      Expanded(child: _miniProbeCard('create', _createAction)),
                      Expanded(child: _miniProbeCard('archive', _archiveAction)),
                      Expanded(child: _miniProbeCard('pulse', _pulseAction)),
                    ],
                  );
                }

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: _p.secondary.withValues(alpha: 0.13),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
                      ),
                      child: Row(
                        children: [
                          _chip('lane', '$lane', _p.secondary),
                          const SizedBox(width: 6),
                          _chip('w', maxW.toStringAsFixed(0), _p.primary),
                          if (_showMetrics) ...[
                            const SizedBox(width: 6),
                            _chip('signals', '${_timeline.length}', _p.accent),
                          ],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: body,
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

  Widget _miniProbeCard(String title, _StudioAction action) {
    return ActionListener(
      action: action,
      listener: _handleActionSignal,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: action.tint.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: _p.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11.4,
              ),
            ),
            const Spacer(),
            Text(
              'signals ${_listenerHits[action.label] ?? 0}',
              style: TextStyle(
                color: _p.ink,
                fontFamily: 'monospace',
                fontSize: 10.2,
              ),
            ),
          ],
        ),
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
            title: 'ActionListener Reference Matrix',
            subtitle: 'What ActionListener is and how to use it.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Role',
                  value:
                      'Observe Action signal changes by listening to Action listener notifications.',
                ),
                _matrixRow(
                  keyText: 'Constructor',
                  value:
                      'ActionListener(action: someAction, listener: callback, child: widget)',
                ),
                _matrixRow(
                  keyText: 'When callback fires',
                  value:
                      'When the target Action emits listener notifications, such as enablement changes.',
                ),
                _matrixRow(
                  keyText: 'Typical pairing',
                  value:
                      'Actions widget for dispatching + ActionListener for observing action state.',
                ),
                _matrixRow(
                  keyText: 'What it is not',
                  value:
                      'Not a replacement for action invocation. It is an observation hook.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical guidance for real-world action systems.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Attach ActionListener where state reaction is needed',
                  detail:
                      'Use it for diagnostics, badges, and side-panel updates that follow action signals.',
                ),
                _doDont(
                  good: false,
                  title: 'Use ActionListener as the only command trigger path',
                  detail:
                      'Invocation should still flow through Actions, dispatchers, shortcuts, or explicit calls.',
                ),
                _doDont(
                  good: true,
                  title: 'Model explicit reasons for notifications',
                  detail:
                      'A reason string helps explain what changed when signals arrive in the callback.',
                ),
                _doDont(
                  good: false,
                  title: 'Scatter hidden notify calls without traceability',
                  detail:
                      'If signals are opaque, debugging action systems becomes difficult.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common questions for ActionListener usage.',
            child: Column(
              children: [
                _qa(
                  q: 'Does ActionListener execute the Action?',
                  a: 'No. It only listens to Action signal changes. Invocation is separate.',
                ),
                _qa(
                  q: 'Can multiple ActionListener widgets observe one Action?',
                  a: 'Yes. The nested listener lab in this demo shows stacked observers.',
                ),
                _qa(
                  q: 'Where should I put ActionListener in the tree?',
                  a: 'Place it close to UI that needs reaction to Action state signals.',
                ),
                _qa(
                  q: 'How can I test interpreter integration visually?',
                  a: 'Combine invocation controls, listener counters, and trace timelines.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo acceptance criteria for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Multiple visual displays for ActionListener use cases are present.'),
                _check('Action invocation and listener signaling are shown separately.'),
                _check('Nested ActionListener behavior is demonstrated with live counters.'),
                _check('Shortcuts and Actions integration is demonstrated visually.'),
                _check('Responsive shells show adaptation of listener-driven dashboards.'),
                _check('Compendium provides instructive guidance and usage patterns.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'ActionListener is an observation layer for Action state signals: '
            'invoke through command pathways, observe through listeners, and '
            'render transparent diagnostics for reliable runtime behavior.',
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
          width: 210,
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
          fontSize: 10.4,
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
              style: TextStyle(color: _p.ink, fontSize: 11.5, height: 1.33),
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
        border: Border.all(color: tone.withValues(alpha: 0.28)),
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
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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
            _stageTitles[_stage.index],
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

class _GridPainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _GridPainter({required this.color, required this.spacing});

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
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
