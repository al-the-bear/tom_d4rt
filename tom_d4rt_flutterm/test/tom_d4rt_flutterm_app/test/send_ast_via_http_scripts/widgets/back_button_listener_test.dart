import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _BackButtonListenerDeepDemo();
}

class _BackButtonListenerDeepDemo extends StatefulWidget {
  const _BackButtonListenerDeepDemo();

  @override
  State<_BackButtonListenerDeepDemo> createState() => _BackButtonListenerDeepDemoState();
}

class _BackButtonListenerDeepDemoState extends State<_BackButtonListenerDeepDemo> {
  final _routerDelegate = _BackLabRouterDelegate();
  final _rootDispatcher = RootBackButtonDispatcher();

  @override
  Widget build(BuildContext context) {
    return Router<Object>(
      routerDelegate: _routerDelegate,
      backButtonDispatcher: _rootDispatcher,
    );
  }
}

class _BackLabRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  @override
  Future<void> setNewRoutePath(Object configuration) async {}

  @override
  Future<bool> popRoute() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF185B8D)),
        useMaterial3: true,
      ),
      home: const _BackButtonLabHome(),
    );
  }
}

enum _DemoStage {
  interception,
  nested,
  draftGuard,
  routeDeck,
  dispatcher,
  compendium,
}

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Harbor Blue',
    shell: Color(0xFF14242F),
    canvas: Color(0xFFF0F7FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF213644),
    muted: Color(0xFF6A8495),
    accentA: Color(0xFF1E88E5),
    accentB: Color(0xFF1B9B7B),
    accentC: Color(0xFFD98B1C),
  ),
  _Palette(
    name: 'Forest Graphite',
    shell: Color(0xFF1B241F),
    canvas: Color(0xFFF3FAF4),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF29362D),
    muted: Color(0xFF728676),
    accentA: Color(0xFF2E7D32),
    accentB: Color(0xFF00897B),
    accentC: Color(0xFFC4832B),
  ),
  _Palette(
    name: 'Copper Slate',
    shell: Color(0xFF2A1F1A),
    canvas: Color(0xFFFDF5EF),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF3A2E28),
    muted: Color(0xFF8C7B72),
    accentA: Color(0xFFB75F2F),
    accentB: Color(0xFF2F8CA5),
    accentC: Color(0xFF9B8A1D),
  ),
];

class _BackLogEvent {
  final DateTime at;
  final String lane;
  final String message;
  final Color tone;

  const _BackLogEvent({
    required this.at,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

class _BackButtonLabHome extends StatefulWidget {
  const _BackButtonLabHome();

  @override
  State<_BackButtonLabHome> createState() => _BackButtonLabHomeState();
}

class _BackButtonLabHomeState extends State<_BackButtonLabHome> {
  _DemoStage _stage = _DemoStage.interception;
  int _paletteIndex = 0;

  bool _showTimeline = true;
  bool _showCheatSheet = true;
  bool _verboseLogs = false;
  bool _showCounters = true;

  int _manualBackRequests = 0;
  int _handledEvents = 0;
  int _propagatedEvents = 0;

  final List<_BackLogEvent> _events = <_BackLogEvent>[];

  _Palette get _p => _palettes[_paletteIndex];

  static const _stageLabels = <String>[
    '1 Interception Studio',
    '2 Nested Priority Arena',
    '3 Unsaved Draft Guard',
    '4 Route Deck Theater',
    '5 Dispatcher Dashboard',
    '6 Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _log('system', 'BackButtonListener deep demo initialized.', _p.accentA);
  }

  void _log(String lane, String message, Color tone) {
    final event = _BackLogEvent(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 120) {
        _events.removeRange(120, _events.length);
      }
    });
    if (_verboseLogs) {
      debugPrint('[BackButtonListener][$lane] $message');
    }
  }

  void _recordOutcome(String lane, bool handled, String detail) {
    if (handled) {
      setState(() => _handledEvents += 1);
      _log(lane, 'handled: $detail', _p.accentA);
    } else {
      setState(() => _propagatedEvents += 1);
      _log(lane, 'propagated: $detail', _p.accentC);
    }
  }

  Future<void> _simulateSystemBack(String source) async {
    setState(() => _manualBackRequests += 1);
    _log(source, 'manual back request sent through WidgetsBinding.handlePopRoute()', _p.accentB);
    final handled = await WidgetsBinding.instance.handlePopRoute();
    _recordOutcome(source, handled, 'handlePopRoute returned $handled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _stageBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 360,
                      child: _timelinePanel(),
                    ),
                ],
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
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.arrow_back_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'BackButtonListener Deep Demo',
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
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Router-Aware Back Interception',
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
            'BackButtonListener intercepts system back intents under a Router ancestor. '
            'This deep demo shows event handling, propagation strategy, nested priorities, '
            'unsaved-draft guards, and route-stack style behavior for interpreter validation.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 12.2,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accentA.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageLabels.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('cheat sheet', _showCheatSheet, (v) => _showCheatSheet = v),
          _toggleChip('counters', _showCounters, (v) => _showCounters = v),
          _toggleChip('verbose log', _verboseLogs, (v) => _verboseLogs = v),
          const SizedBox(width: 10),
          FilledButton.icon(
            onPressed: () => _simulateSystemBack('global-toolbar'),
            icon: const Icon(Icons.replay, size: 16),
            label: const Text('Simulate System Back'),
          ),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    final active = _stage.index == index;
    return ChoiceChip(
      selected: active,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: active ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) {
        setState(() => _stage = _DemoStage.values[index]);
        _log('stage', 'switched to ${_stageLabels[index]}', _p.accentB);
      },
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _paletteIndex = index);
        _log('palette', 'palette changed to ${_palettes[index].name}', _palettes[index].accentA);
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.19),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _DemoStage.interception:
        return _InterceptionStudio(
          palette: _p,
          onLog: _log,
          onOutcome: _recordOutcome,
          onSimulateBack: _simulateSystemBack,
          showCheatSheet: _showCheatSheet,
          showCounters: _showCounters,
        );
      case _DemoStage.nested:
        return _NestedPriorityArena(
          palette: _p,
          onLog: _log,
          onOutcome: _recordOutcome,
          onSimulateBack: _simulateSystemBack,
          showCheatSheet: _showCheatSheet,
          showCounters: _showCounters,
        );
      case _DemoStage.draftGuard:
        return _DraftGuardStudio(
          palette: _p,
          onLog: _log,
          onOutcome: _recordOutcome,
          onSimulateBack: _simulateSystemBack,
          showCheatSheet: _showCheatSheet,
          showCounters: _showCounters,
        );
      case _DemoStage.routeDeck:
        return _RouteDeckTheater(
          palette: _p,
          onLog: _log,
          onOutcome: _recordOutcome,
          onSimulateBack: _simulateSystemBack,
          showCheatSheet: _showCheatSheet,
          showCounters: _showCounters,
        );
      case _DemoStage.dispatcher:
        return _DispatcherDashboard(
          palette: _p,
          onLog: _log,
          onOutcome: _recordOutcome,
          onSimulateBack: _simulateSystemBack,
          showCheatSheet: _showCheatSheet,
          showCounters: _showCounters,
        );
      case _DemoStage.compendium:
        return _CompendiumStage(palette: _p);
    }
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(
        color: _p.card,
        border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.26))),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _p.accentA.withValues(alpha: 0.08),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Back Event Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Event flow from BackButtonListener callbacks and manual back dispatch requests.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _metric('manual requests', '$_manualBackRequests', _p.accentB),
                    _metric('handled', '$_handledEvents', _p.accentA),
                    _metric('propagated', '$_propagatedEvents', _p.accentC),
                    _metric('events', '${_events.length}', _p.accentA),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: event.tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: event.tone.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.lane,
                              style: TextStyle(
                                color: _p.ink,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                fontSize: 10.5,
                              ),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(
                              color: _p.muted,
                              fontFamily: 'monospace',
                              fontSize: 10.1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.message, style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.32)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: _p.ink, fontSize: 10.1, fontWeight: FontWeight.w700),
      ),
    );
  }

  String _clock(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _p.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_stageLabels[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }
}

class _InterceptionStudio extends StatefulWidget {
  const _InterceptionStudio({
    required this.palette,
    required this.onLog,
    required this.onOutcome,
    required this.onSimulateBack,
    required this.showCheatSheet,
    required this.showCounters,
  });

  final _Palette palette;
  final void Function(String lane, String message, Color tone) onLog;
  final void Function(String lane, bool handled, String detail) onOutcome;
  final Future<void> Function(String source) onSimulateBack;
  final bool showCheatSheet;
  final bool showCounters;

  @override
  State<_InterceptionStudio> createState() => _InterceptionStudioState();
}

class _InterceptionStudioState extends State<_InterceptionStudio> {
  bool _consumeBack = true;
  bool _listenerEnabled = true;
  int _localHandled = 0;
  int _localPropagated = 0;

  Future<bool> _onBackPressed() async {
    if (!_listenerEnabled) {
      widget.onOutcome('interception', false, 'listener disabled -> pass through');
      setState(() => _localPropagated += 1);
      return false;
    }
    if (_consumeBack) {
      widget.onOutcome('interception', true, 'consumeBack=true intercepted in studio');
      setState(() => _localHandled += 1);
      return true;
    }
    widget.onOutcome('interception', false, 'consumeBack=false propagate to router');
    setState(() => _localPropagated += 1);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Interception Studio'),
          const SizedBox(height: 8),
          Text(
            'Core behavior: BackButtonListener callback returns true to intercept, false to propagate.',
            style: TextStyle(color: widget.palette.ink, fontSize: 12.3),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Runtime Controls',
            subtitle: 'Toggle listener participation and interception policy.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilterChip(
                  selected: _listenerEnabled,
                  label: const Text('listener enabled'),
                  onSelected: (v) {
                    setState(() => _listenerEnabled = v);
                    widget.onLog('interception', 'listenerEnabled -> $v', widget.palette.accentB);
                  },
                ),
                FilterChip(
                  selected: _consumeBack,
                  label: const Text('consume back'),
                  onSelected: (v) {
                    setState(() => _consumeBack = v);
                    widget.onLog('interception', 'consumeBack -> $v', widget.palette.accentA);
                  },
                ),
                FilledButton.icon(
                  onPressed: () => widget.onSimulateBack('interception-stage'),
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Dispatch Back'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          BackButtonListener(
            onBackButtonPressed: _onBackPressed,
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _panel(
                      title: 'Visual Gate',
                      subtitle: 'This entire panel is wrapped by BackButtonListener.',
                      tint: widget.palette.accentA.withValues(alpha: 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _signalCard(
                            title: 'Current Policy',
                            detail: _listenerEnabled
                                ? (_consumeBack ? 'Intercept (returns true)' : 'Propagate (returns false)')
                                : 'Listener disabled (always propagate)',
                            tone: _consumeBack ? widget.palette.accentA : widget.palette.accentC,
                          ),
                          const SizedBox(height: 10),
                          if (widget.showCounters)
                            Row(
                              children: <Widget>[
                                _metric('local handled', '$_localHandled', widget.palette.accentA),
                                const SizedBox(width: 8),
                                _metric('local propagated', '$_localPropagated', widget.palette.accentC),
                              ],
                            ),
                          const SizedBox(height: 10),
                          Text(
                            'How to read this panel:\n'
                            '1. press Dispatch Back\n'
                            '2. observe timeline and local counters\n'
                            '3. switch between consume and propagate to compare outcomes',
                            style: TextStyle(color: widget.palette.ink, fontSize: 11.2, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.showCheatSheet) ...<Widget>[
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 320,
                      child: _panel(
                        title: 'Cheat Sheet',
                        subtitle: 'BackButtonListener essentials.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _bullet('Must be in a Router subtree.'),
                            _bullet('Returning true means "I consumed back".'),
                            _bullet('Returning false lets event continue upward.'),
                            _bullet('Useful for custom back policies and temporary guards.'),
                            _bullet('Keep callback focused and deterministic for predictability.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 22, color: widget.palette.accentA),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.8)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _signalCard({required String title, required String detail, required Color tone}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.33)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(detail, style: TextStyle(color: widget.palette.ink, fontSize: 11.2)),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value', style: TextStyle(color: widget.palette.ink, fontSize: 10.5, fontWeight: FontWeight.w700)),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: widget.palette.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 11.2))),
        ],
      ),
    );
  }
}

class _NestedPriorityArena extends StatefulWidget {
  const _NestedPriorityArena({
    required this.palette,
    required this.onLog,
    required this.onOutcome,
    required this.onSimulateBack,
    required this.showCheatSheet,
    required this.showCounters,
  });

  final _Palette palette;
  final void Function(String lane, String message, Color tone) onLog;
  final void Function(String lane, bool handled, String detail) onOutcome;
  final Future<void> Function(String source) onSimulateBack;
  final bool showCheatSheet;
  final bool showCounters;

  @override
  State<_NestedPriorityArena> createState() => _NestedPriorityArenaState();
}

class _NestedPriorityArenaState extends State<_NestedPriorityArena> {
  bool _parentEnabled = true;
  bool _parentConsumes = false;
  bool _childEnabled = true;
  bool _childConsumes = true;
  int _parentHits = 0;
  int _childHits = 0;

  Future<bool> _onParentBack() async {
    if (!_parentEnabled) {
      widget.onOutcome('nested-parent', false, 'parent disabled');
      return false;
    }
    setState(() => _parentHits += 1);
    if (_parentConsumes) {
      widget.onOutcome('nested-parent', true, 'parent consumed');
      return true;
    }
    widget.onOutcome('nested-parent', false, 'parent propagated');
    return false;
  }

  Future<bool> _onChildBack() async {
    if (!_childEnabled) {
      widget.onOutcome('nested-child', false, 'child disabled');
      return false;
    }
    setState(() => _childHits += 1);
    if (_childConsumes) {
      widget.onOutcome('nested-child', true, 'child consumed before parent');
      return true;
    }
    widget.onOutcome('nested-child', false, 'child propagated to parent');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Nested Priority Arena'),
          const SizedBox(height: 8),
          Text(
            'Nested BackButtonListener zones illustrate callback ordering: inner zone receives back first.',
            style: TextStyle(color: widget.palette.ink, fontSize: 12.3),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Zone Policies',
            subtitle: 'Configure parent and child interception behavior.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilterChip(
                  selected: _parentEnabled,
                  label: const Text('parent enabled'),
                  onSelected: (v) => setState(() => _parentEnabled = v),
                ),
                FilterChip(
                  selected: _parentConsumes,
                  label: const Text('parent consumes'),
                  onSelected: (v) => setState(() => _parentConsumes = v),
                ),
                FilterChip(
                  selected: _childEnabled,
                  label: const Text('child enabled'),
                  onSelected: (v) => setState(() => _childEnabled = v),
                ),
                FilterChip(
                  selected: _childConsumes,
                  label: const Text('child consumes'),
                  onSelected: (v) => setState(() => _childConsumes = v),
                ),
                FilledButton.icon(
                  onPressed: () => widget.onSimulateBack('nested-stage'),
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Dispatch Back'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: BackButtonListener(
                    onBackButtonPressed: _onParentBack,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.palette.accentA.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: widget.palette.accentA.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Parent Zone', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(
                            'Parent receives event only when child propagates.',
                            style: TextStyle(color: widget.palette.muted, fontSize: 11.1),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: BackButtonListener(
                              onBackButtonPressed: _onChildBack,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.palette.accentB.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: widget.palette.accentB.withValues(alpha: 0.3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Child Zone', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12.8)),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Child callback executes first and can stop propagation.',
                                      style: TextStyle(color: widget.palette.muted, fontSize: 10.8),
                                    ),
                                    const Spacer(),
                                    if (widget.showCounters)
                                      Row(
                                        children: <Widget>[
                                          _chip('parent hits', '$_parentHits', widget.palette.accentA),
                                          const SizedBox(width: 8),
                                          _chip('child hits', '$_childHits', widget.palette.accentB),
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
                  ),
                ),
                if (widget.showCheatSheet) ...<Widget>[
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 320,
                    child: _panel(
                      title: 'Ordering Notes',
                      subtitle: 'Nested callback flow.',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _row('Step 1', 'Child listener callback runs first.'),
                          _row('Step 2', 'If child returns true, parent is not called.'),
                          _row('Step 3', 'If child returns false, parent decides next.'),
                          _row('Step 4', 'If parent also returns false, router receives event.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 22, color: widget.palette.accentA),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.7)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: widget.palette.ink, fontSize: 10.4, fontWeight: FontWeight.w700)),
    );
  }

  Widget _row(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 58,
            child: Text(
              label,
              style: TextStyle(
                color: widget.palette.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.5,
              ),
            ),
          ),
          Expanded(child: Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 11.2))),
        ],
      ),
    );
  }
}

class _DraftGuardStudio extends StatefulWidget {
  const _DraftGuardStudio({
    required this.palette,
    required this.onLog,
    required this.onOutcome,
    required this.onSimulateBack,
    required this.showCheatSheet,
    required this.showCounters,
  });

  final _Palette palette;
  final void Function(String lane, String message, Color tone) onLog;
  final void Function(String lane, bool handled, String detail) onOutcome;
  final Future<void> Function(String source) onSimulateBack;
  final bool showCheatSheet;
  final bool showCounters;

  @override
  State<_DraftGuardStudio> createState() => _DraftGuardStudioState();
}

class _DraftGuardStudioState extends State<_DraftGuardStudio> {
  final _title = TextEditingController();
  final _details = TextEditingController();
  bool _dirty = false;
  int _saveCount = 0;
  int _cancelGuardCount = 0;

  @override
  void initState() {
    super.initState();
    _title.addListener(_markDirty);
    _details.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_dirty) {
      setState(() => _dirty = true);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _details.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    if (!_dirty) {
      widget.onOutcome('draft', false, 'clean state -> propagate');
      return false;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unsaved draft'),
          content: const Text('Discard draft changes and propagate back?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Stay')),
            FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Discard')),
          ],
        );
      },
    );
    if (discard == true) {
      setState(() {
        _dirty = false;
        _title.clear();
        _details.clear();
      });
      widget.onOutcome('draft', false, 'discard confirmed -> propagate');
      return false;
    }
    setState(() => _cancelGuardCount += 1);
    widget.onOutcome('draft', true, 'guard kept user on page');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Unsaved Draft Guard'),
          const SizedBox(height: 8),
          Text(
            'Asynchronous callback flow: open confirmation dialog and decide whether to intercept back.',
            style: TextStyle(color: widget.palette.ink, fontSize: 12.3),
          ),
          const SizedBox(height: 12),
          BackButtonListener(
            onBackButtonPressed: _onBackPressed,
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _panel(
                      title: 'Editor Surface',
                      subtitle: 'Modify fields then dispatch back to test guard behavior.',
                      tint: widget.palette.accentB.withValues(alpha: 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: _title,
                            decoration: const InputDecoration(
                              labelText: 'Draft title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: TextField(
                              controller: _details,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                labelText: 'Draft details',
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              FilledButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _dirty = false;
                                    _saveCount += 1;
                                  });
                                  widget.onLog('draft', 'manual save performed', widget.palette.accentA);
                                },
                                icon: const Icon(Icons.save_outlined, size: 16),
                                label: const Text('Save Draft'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => widget.onSimulateBack('draft-stage'),
                                icon: const Icon(Icons.replay, size: 16),
                                label: const Text('Dispatch Back'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (widget.showCounters)
                            Row(
                              children: <Widget>[
                                _chip('dirty', '$_dirty', widget.palette.accentC),
                                const SizedBox(width: 8),
                                _chip('saves', '$_saveCount', widget.palette.accentA),
                                const SizedBox(width: 8),
                                _chip('guard stays', '$_cancelGuardCount', widget.palette.accentB),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.showCheatSheet) ...<Widget>[
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 330,
                      child: _panel(
                        title: 'Draft Guard Notes',
                        subtitle: 'Practical back-policy guidance.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _bullet('Use async callback for confirmation dialogs.'),
                            _bullet('Return true when user stays on current view.'),
                            _bullet('Return false when user confirms discard or leave.'),
                            _bullet('Keep dirty-state updates centralized to avoid false prompts.'),
                            _bullet('Pair with timeline logs for interpreter behavior verification.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 22, color: widget.palette.accentA),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.7)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: widget.palette.ink, fontSize: 10.4, fontWeight: FontWeight.w700)),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: widget.palette.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 11.1))),
        ],
      ),
    );
  }
}

class _DeckEntry {
  final int id;
  final String title;
  final Color tone;
  final int absorbBeforeRelease;

  const _DeckEntry({
    required this.id,
    required this.title,
    required this.tone,
    required this.absorbBeforeRelease,
  });
}

const _routeDeckEntries = <_DeckEntry>[
  _DeckEntry(id: 1, title: 'Profile Overlay', tone: Color(0xFF1E88E5), absorbBeforeRelease: 1),
  _DeckEntry(id: 2, title: 'Payment Overlay', tone: Color(0xFF00897B), absorbBeforeRelease: 2),
  _DeckEntry(id: 3, title: 'Shipping Overlay', tone: Color(0xFFD98B1C), absorbBeforeRelease: 0),
  _DeckEntry(id: 4, title: 'Review Overlay', tone: Color(0xFF6C5CE7), absorbBeforeRelease: 1),
];

class _RouteDeckTheater extends StatefulWidget {
  const _RouteDeckTheater({
    required this.palette,
    required this.onLog,
    required this.onOutcome,
    required this.onSimulateBack,
    required this.showCheatSheet,
    required this.showCounters,
  });

  final _Palette palette;
  final void Function(String lane, String message, Color tone) onLog;
  final void Function(String lane, bool handled, String detail) onOutcome;
  final Future<void> Function(String source) onSimulateBack;
  final bool showCheatSheet;
  final bool showCounters;

  @override
  State<_RouteDeckTheater> createState() => _RouteDeckTheaterState();
}

class _RouteDeckTheaterState extends State<_RouteDeckTheater> {
  final List<_DeckEntry> _stack = <_DeckEntry>[];
  int _innerAbsorbed = 0;

  void _push(_DeckEntry entry) {
    setState(() => _stack.add(entry));
    widget.onLog('route-deck', 'pushed ${entry.title}', entry.tone);
  }

  void _popTop(String reason) {
    if (_stack.isEmpty) {
      return;
    }
    final top = _stack.removeLast();
    setState(() {});
    widget.onLog('route-deck', 'popped ${top.title} ($reason)', top.tone);
  }

  Future<bool> _onOuterBack() async {
    if (_stack.isEmpty) {
      widget.onOutcome('route-deck-outer', false, 'empty stack -> propagate');
      return false;
    }
    _popTop('outer listener consumed back');
    widget.onOutcome('route-deck-outer', true, 'popped top deck entry');
    return true;
  }

  Future<bool> _onInnerBack(_DeckEntry top) async {
    if (_innerAbsorbed < top.absorbBeforeRelease) {
      setState(() => _innerAbsorbed += 1);
      widget.onOutcome(
        'route-deck-inner',
        true,
        '${top.title} inner guard absorbed $_innerAbsorbed/${top.absorbBeforeRelease}',
      );
      return true;
    }
    widget.onOutcome('route-deck-inner', false, '${top.title} inner guard released event');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final top = _stack.isEmpty ? null : _stack.last;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Route Deck Theater'),
          const SizedBox(height: 8),
          Text(
            'Simulated route stack with nested listeners: inner detail policy first, outer stack pop fallback second.',
            style: TextStyle(color: widget.palette.ink, fontSize: 12.3),
          ),
          const SizedBox(height: 12),
          BackButtonListener(
            onBackButtonPressed: _onOuterBack,
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _panel(
                      title: 'Deck Builder',
                      subtitle: 'Open overlays and dispatch back repeatedly.',
                      tint: widget.palette.accentC.withValues(alpha: 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              for (final entry in _routeDeckEntries)
                                OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() => _innerAbsorbed = 0);
                                    _push(entry);
                                  },
                                  icon: const Icon(Icons.add, size: 15),
                                  label: Text('Open ${entry.title}'),
                                ),
                              FilledButton.icon(
                                onPressed: () => widget.onSimulateBack('route-deck-stage'),
                                icon: const Icon(Icons.play_arrow, size: 16),
                                label: const Text('Dispatch Back'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: widget.palette.muted.withValues(alpha: 0.25)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Active Deck Stack', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12.1)),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: _stack.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No overlays open.\nOpen an entry then dispatch back.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: widget.palette.muted, fontSize: 11.3),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: _stack.length,
                                            itemBuilder: (context, index) {
                                              final item = _stack[index];
                                              final isTop = index == _stack.length - 1;
                                              return Container(
                                                margin: const EdgeInsets.only(bottom: 7),
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: item.tone.withValues(alpha: isTop ? 0.16 : 0.08),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: item.tone.withValues(alpha: 0.32)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        '${item.title} (absorb before release: ${item.absorbBeforeRelease})',
                                                        style: TextStyle(color: widget.palette.ink, fontSize: 11.1),
                                                      ),
                                                    ),
                                                    if (isTop)
                                                      const Icon(Icons.expand_less, size: 16),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 360,
                    child: _panel(
                      title: 'Top Overlay Policy',
                      subtitle: 'Inner BackButtonListener for active entry.',
                      child: top == null
                          ? Center(child: Text('No active overlay', style: TextStyle(color: widget.palette.muted, fontSize: 11.3)))
                          : BackButtonListener(
                              onBackButtonPressed: () => _onInnerBack(top),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: top.tone.withValues(alpha: 0.11),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: top.tone.withValues(alpha: 0.32)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(top.title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12.2)),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Inner absorbs first ${top.absorbBeforeRelease} back event(s), then propagates to outer listener.',
                                          style: TextStyle(color: widget.palette.ink, fontSize: 10.9, height: 1.32),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (widget.showCounters)
                                    _chip(
                                      'inner absorbed',
                                      '$_innerAbsorbed/${top.absorbBeforeRelease}',
                                      widget.palette.accentB,
                                    ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Tip: this model helps validate layered policies where details intercept first and parent controllers pop stack later.',
                                    style: TextStyle(color: widget.palette.muted, fontSize: 10.9, height: 1.35),
                                  ),
                                ],
                              ),
                            ),
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

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 22, color: widget.palette.accentA),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.7)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: widget.palette.ink, fontSize: 10.4, fontWeight: FontWeight.w700)),
    );
  }
}

class _DispatcherDashboard extends StatefulWidget {
  const _DispatcherDashboard({
    required this.palette,
    required this.onLog,
    required this.onOutcome,
    required this.onSimulateBack,
    required this.showCheatSheet,
    required this.showCounters,
  });

  final _Palette palette;
  final void Function(String lane, String message, Color tone) onLog;
  final void Function(String lane, bool handled, String detail) onOutcome;
  final Future<void> Function(String source) onSimulateBack;
  final bool showCheatSheet;
  final bool showCounters;

  @override
  State<_DispatcherDashboard> createState() => _DispatcherDashboardState();
}

class _DispatcherDashboardState extends State<_DispatcherDashboard> {
  late RootBackButtonDispatcher _root;
  late ChildBackButtonDispatcher _childA;
  late ChildBackButtonDispatcher _childB;
  int _priorityChanges = 0;

  @override
  void initState() {
    super.initState();
    _root = RootBackButtonDispatcher();
    _childA = ChildBackButtonDispatcher(_root);
    _childB = ChildBackButtonDispatcher(_root);
  }

  void _takePriorityA() {
    _childA.takePriority();
    setState(() => _priorityChanges += 1);
    widget.onLog('dispatcher', 'child A called takePriority()', widget.palette.accentA);
  }

  void _takePriorityB() {
    _childB.takePriority();
    setState(() => _priorityChanges += 1);
    widget.onLog('dispatcher', 'child B called takePriority()', widget.palette.accentB);
  }

  Future<bool> _onBackPressed() async {
    widget.onOutcome('dispatcher-listener', true, 'dashboard listener consumed for instrumentation');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Dispatcher Dashboard'),
          const SizedBox(height: 8),
          Text(
            'BackButtonDispatcher hierarchy context that commonly appears with nested routers.',
            style: TextStyle(color: widget.palette.ink, fontSize: 12.3),
          ),
          const SizedBox(height: 12),
          BackButtonListener(
            onBackButtonPressed: _onBackPressed,
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _panel(
                      title: 'Dispatcher Objects',
                      subtitle: 'Runtime snapshots and priority controls.',
                      tint: widget.palette.accentA.withValues(alpha: 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _line('root type', _root.runtimeType.toString()),
                          _line('child A type', _childA.runtimeType.toString()),
                          _line('child B type', _childB.runtimeType.toString()),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              OutlinedButton(onPressed: _takePriorityA, child: const Text('Child A takePriority')),
                              OutlinedButton(onPressed: _takePriorityB, child: const Text('Child B takePriority')),
                              FilledButton.icon(
                                onPressed: () => widget.onSimulateBack('dispatcher-stage'),
                                icon: const Icon(Icons.play_arrow, size: 16),
                                label: const Text('Dispatch Back'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (widget.showCounters)
                            _chip('priority changes', '$_priorityChanges', widget.palette.accentC),
                          const SizedBox(height: 10),
                          Text(
                            'This panel demonstrates dispatcher construction and priority APIs. '
                            'BackButtonListener still handles intercept logic declaratively in widget zones.',
                            style: TextStyle(color: widget.palette.muted, fontSize: 11, height: 1.34),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.showCheatSheet) ...<Widget>[
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 340,
                      child: _panel(
                        title: 'When to Use What',
                        subtitle: 'Dispatcher vs listener responsibilities.',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _row('BackButtonListener', 'Widget-level interception policy in local UI scope.'),
                            _row('RootBackButtonDispatcher', 'Top-level back dispatch manager for router tree.'),
                            _row('ChildBackButtonDispatcher', 'Nested router-specific back ownership and priority.'),
                            _row('Design tip', 'Use listeners for page logic and dispatchers for routing topology.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(width: 4, height: 22, color: widget.palette.accentA),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w800, fontSize: 13.7)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: widget.palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _line(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              key,
              style: TextStyle(
                color: widget.palette.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.5,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: widget.palette.ink, fontSize: 11.1))),
        ],
      ),
    );
  }

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: widget.palette.ink, fontSize: 10.4, fontWeight: FontWeight.w700)),
    );
  }

  Widget _row(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 128,
            child: Text(
              label,
              style: TextStyle(
                color: widget.palette.accentB,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.3,
              ),
            ),
          ),
          Expanded(child: Text(text, style: TextStyle(color: widget.palette.ink, fontSize: 11.1))),
        ],
      ),
    );
  }
}

class _CompendiumStage extends StatelessWidget {
  const _CompendiumStage({required this.palette});

  final _Palette palette;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 4, height: 22, color: palette.accentA),
              const SizedBox(width: 8),
              Text('Verification Compendium', style: TextStyle(color: palette.ink, fontSize: 18, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'BackButtonListener Matrix',
            subtitle: 'Purpose and behavior summary.',
            child: Column(
              children: <Widget>[
                _matrix('Purpose', 'Intercept back intents in a widget subtree under Router.'),
                _matrix('Callback type', 'Future<bool> Function() via onBackButtonPressed.'),
                _matrix('true return', 'Event handled here; do not propagate upward.'),
                _matrix('false return', 'Event propagates to parent listener/dispatcher/router.'),
                _matrix('Common use', 'Unsaved form guard, nested route areas, temporary modal policies.'),
                _matrix('Dependency', 'Requires Router ancestor to connect into back dispatch system.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Implementation quality guidance.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do return true only when you intentionally consume back',
                  detail: 'Use explicit policy conditions rather than accidental always-true returns.',
                ),
                _doDont(
                  good: true,
                  title: 'Do structure nested listeners with clear ownership',
                  detail: 'Document which zone should intercept first to avoid unpredictable behavior.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont block all back events permanently',
                  detail: 'Users need an eventual path to exit or navigate back.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont use listener when no Router is present',
                  detail: 'Back dispatch hooks require router wiring to be meaningful.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep-demo scenarios covered in this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Interception Studio demonstrates true/false callback outcomes.'),
                _check('Nested Priority Arena demonstrates ordering and bubbling.'),
                _check('Unsaved Draft Guard demonstrates async dialog-based back decisions.'),
                _check('Route Deck Theater demonstrates layered listener policies with stack behavior.'),
                _check('Dispatcher Dashboard contextualizes listener role with dispatcher hierarchy.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: palette.accentC.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: palette.accentC.withValues(alpha: 0.32)),
            ),
            child: Text(
              'BackButtonListener is most effective when treated as an explicit back-policy gate, '
              'not just a generic callback wrapper. In interpreter tests, visual stages and logs '
              'make propagation paths observable and debuggable.',
              style: TextStyle(color: palette.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.muted.withValues(alpha: 0.23)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: palette.ink, fontWeight: FontWeight.w800, fontSize: 13.7)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: palette.muted, fontSize: 11)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.muted.withValues(alpha: 0.19)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              key,
              style: TextStyle(
                color: palette.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.7,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: palette.ink, fontSize: 11.2, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, size: 17, color: tone),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: palette.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: palette.muted, fontSize: 11.1, height: 1.32)),
              ],
            ),
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
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 17),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: palette.ink, fontSize: 11.4))),
        ],
      ),
    );
  }
}
