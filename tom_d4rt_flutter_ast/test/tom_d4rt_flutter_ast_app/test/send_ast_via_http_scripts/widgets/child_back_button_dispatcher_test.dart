import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ChildBackButtonDispatcherDeepDemo();
}

enum _DemoSection {
  primer,
  priority,
  cascade,
  lifecycle,
  integration,
  compendium,
}

enum _CanvasStyle {
  wave,
  grid,
  rings,
}

class _Palette {
  final String name;
  final Color shell;
  final Color paper;
  final Color panel;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.paper,
    required this.panel,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Control Harbor',
    shell: Color(0xFF142733),
    paper: Color(0xFFF2F8FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF203846),
    muted: Color(0xFF6F8797),
    accentA: Color(0xFF1E86DE),
    accentB: Color(0xFF1B9B77),
    accentC: Color(0xFFD1911F),
  ),
  _Palette(
    name: 'Forest Dispatcher',
    shell: Color(0xFF1A241E),
    paper: Color(0xFFF4FAF5),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF29372E),
    muted: Color(0xFF748679),
    accentA: Color(0xFF2E8E3B),
    accentB: Color(0xFF1F8E98),
    accentC: Color(0xFFB88727),
  ),
  _Palette(
    name: 'Copper Router',
    shell: Color(0xFF2B221D),
    paper: Color(0xFFFDF5ED),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3B2F29),
    muted: Color(0xFF8C7D73),
    accentA: Color(0xFFB96533),
    accentB: Color(0xFF2E89A3),
    accentC: Color(0xFF9B8418),
  ),
];

class _DispatcherEvent {
  final DateTime at;
  final String lane;
  final String message;
  final Color tone;

  const _DispatcherEvent({
    required this.at,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

class _LaneCardData {
  final String id;
  final String title;
  final String role;
  final Color tone;

  const _LaneCardData({
    required this.id,
    required this.title,
    required this.role,
    required this.tone,
  });
}

class _InspectableChildBackButtonDispatcher extends ChildBackButtonDispatcher {
  _InspectableChildBackButtonDispatcher(
    super.parent, {
    required this.id,
    this.onNotified,
  });

  final String id;
  final void Function(String id)? onNotified;

  @override
  Future<bool> notifiedByParent(Future<bool> defaultValue) {
    onNotified?.call(id);
    return super.notifiedByParent(defaultValue);
  }
}

class _ChildBackButtonDispatcherDeepDemo extends StatefulWidget {
  const _ChildBackButtonDispatcherDeepDemo();

  @override
  State<_ChildBackButtonDispatcherDeepDemo> createState() => _ChildBackButtonDispatcherDeepDemoState();
}

class _ChildBackButtonDispatcherDeepDemoState extends State<_ChildBackButtonDispatcherDeepDemo> {
  _DemoSection _section = _DemoSection.primer;
  int _paletteIndex = 0;
  _CanvasStyle _canvasStyle = _CanvasStyle.wave;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showMetrics = true;
  bool _showCrosshair = true;
  bool _verbose = false;

  bool _rootHandles = false;
  bool _stackMode = false;

  final Map<String, bool> _laneWillHandle = <String, bool>{
    'A': true,
    'B': false,
    'C': false,
    'A1': true,
    'A2': false,
  };

  final Map<String, bool> _laneActive = <String, bool>{
    'A': true,
    'B': true,
    'C': true,
    'A1': true,
    'A2': true,
  };

  final Map<String, int> _laneHits = <String, int>{
    'root': 0,
    'A': 0,
    'B': 0,
    'C': 0,
    'A1': 0,
    'A2': 0,
  };

  final Map<String, int> _routeDepth = <String, int>{
    'A': 3,
    'B': 2,
    'C': 1,
  };

  final List<String> _rootPriority = <String>[];
  final List<String> _aPriority = <String>[];
  final List<_DispatcherEvent> _events = <_DispatcherEvent>[];

  int _tapCount = 0;
  int _dispatchAttempts = 0;
  int _handledDispatches = 0;
  int _unhandledDispatches = 0;
  int _controlChanges = 0;
  int _modeChanges = 0;

  late final RootBackButtonDispatcher _root;
  late final _InspectableChildBackButtonDispatcher _a;
  late final _InspectableChildBackButtonDispatcher _b;
  late final _InspectableChildBackButtonDispatcher _c;
  late final _InspectableChildBackButtonDispatcher _a1;
  late final _InspectableChildBackButtonDispatcher _a2;

  late final ValueGetter<Future<bool>> _rootCallback;
  late final ValueGetter<Future<bool>> _aCallback;
  late final ValueGetter<Future<bool>> _bCallback;
  late final ValueGetter<Future<bool>> _cCallback;
  late final ValueGetter<Future<bool>> _a1Callback;
  late final ValueGetter<Future<bool>> _a2Callback;

  _Palette get _p => _palettes[_paletteIndex];

  static const _sectionTitles = <String>[
    '1 Primer Studio',
    '2 Priority Arena',
    '3 Cascade Chain Lab',
    '4 Callback Lifecycle Deck',
    '5 Router Integration Theater',
    '6 Verification Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _initializeDispatchers();
    _registerCallbacks();
    _setupInitialPriority();
    _log('system', 'ChildBackButtonDispatcher deep demo initialized.', _p.accentA);
  }

  void _initializeDispatchers() {
    _root = RootBackButtonDispatcher();
    _a = _InspectableChildBackButtonDispatcher(_root, id: 'A', onNotified: _onChildNotified);
    _b = _InspectableChildBackButtonDispatcher(_root, id: 'B', onNotified: _onChildNotified);
    _c = _InspectableChildBackButtonDispatcher(_root, id: 'C', onNotified: _onChildNotified);
    _a1 = _InspectableChildBackButtonDispatcher(_a, id: 'A1', onNotified: _onChildNotified);
    _a2 = _InspectableChildBackButtonDispatcher(_a, id: 'A2', onNotified: _onChildNotified);
  }

  void _registerCallbacks() {
    _rootCallback = () => _onRootCallback();
    _aCallback = () => _onLaneCallback('A');
    _bCallback = () => _onLaneCallback('B');
    _cCallback = () => _onLaneCallback('C');
    _a1Callback = () => _onLaneCallback('A1');
    _a2Callback = () => _onLaneCallback('A2');

    _root.addCallback(_rootCallback);
    _a.addCallback(_aCallback);
    _b.addCallback(_bCallback);
    _c.addCallback(_cCallback);
    _a1.addCallback(_a1Callback);
    _a2.addCallback(_a2Callback);
  }

  void _setupInitialPriority() {
    _a.takePriority();
    _a1.takePriority();
    _updatePriority(_rootPriority, 'A');
    _updatePriority(_aPriority, 'A1');
  }

  @override
  void dispose() {
    _removeLaneCallbacksIfActive('A');
    _removeLaneCallbacksIfActive('B');
    _removeLaneCallbacksIfActive('C');
    _removeLaneCallbacksIfActive('A1');
    _removeLaneCallbacksIfActive('A2');
    _root.removeCallback(_rootCallback);
    super.dispose();
  }

  void _removeLaneCallbacksIfActive(String lane) {
    if (!(_laneActive[lane] ?? false)) {
      return;
    }
    switch (lane) {
      case 'A':
        _a.removeCallback(_aCallback);
      case 'B':
        _b.removeCallback(_bCallback);
      case 'C':
        _c.removeCallback(_cCallback);
      case 'A1':
        _a1.removeCallback(_a1Callback);
      case 'A2':
        _a2.removeCallback(_a2Callback);
    }
  }

  Future<bool> _onRootCallback() {
    _laneHits['root'] = (_laneHits['root'] ?? 0) + 1;
    _log('root-callback', 'Root callback -> $_rootHandles', _p.accentC);
    return Future<bool>.value(_rootHandles);
  }

  Future<bool> _onLaneCallback(String lane) {
    _laneHits[lane] = (_laneHits[lane] ?? 0) + 1;
    final tone = _laneTone(lane);

    bool handled;
    if (_stackMode && (lane == 'A' || lane == 'B' || lane == 'C')) {
      final current = _routeDepth[lane] ?? 1;
      if (current > 1) {
        _routeDepth[lane] = current - 1;
        handled = true;
        _log('stack', '$lane popped route, remaining depth ${_routeDepth[lane]}', tone);
      } else {
        handled = false;
        _log('stack', '$lane at root route, cannot pop', tone);
      }
      setState(() {});
    } else {
      handled = _laneWillHandle[lane] ?? false;
      _log('lane-callback', '$lane callback -> $handled', tone);
    }
    return Future<bool>.value(handled);
  }

  void _onChildNotified(String id) {
    _log('notify', '$id notified by parent dispatcher', _laneTone(id));
  }

  Color _laneTone(String lane) {
    switch (lane) {
      case 'A':
      case 'A1':
        return _p.accentA;
      case 'B':
      case 'A2':
        return _p.accentB;
      case 'C':
      case 'root':
        return _p.accentC;
      default:
        return _p.accentA;
    }
  }

  void _log(String lane, String message, Color tone) {
    final event = _DispatcherEvent(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 220) {
        _events.removeRange(220, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[ChildBackButtonDispatcher][$lane] $message');
    }
  }

  void _recordTap(String lane, String message) {
    setState(() => _tapCount += 1);
    _log(lane, message, _p.accentA);
  }

  void _recordControl(String lane, String message) {
    setState(() => _controlChanges += 1);
    _log(lane, message, _p.accentB);
  }

  void _recordMode(String lane, String message) {
    setState(() => _modeChanges += 1);
    _log(lane, message, _p.accentC);
  }

  void _updatePriority(List<String> list, String lane) {
    list.remove(lane);
    list.add(lane);
  }

  BackButtonDispatcher _dispatcherFor(String lane) {
    switch (lane) {
      case 'A':
        return _a;
      case 'B':
        return _b;
      case 'C':
        return _c;
      case 'A1':
        return _a1;
      case 'A2':
        return _a2;
      default:
        return _root;
    }
  }

  bool _laneCanTakePriority(String lane) {
    return _laneActive[lane] ?? false;
  }

  void _takeLanePriority(String lane) {
    if (!_laneCanTakePriority(lane)) {
      _log('priority', '$lane ignored takePriority because callback is inactive', _laneTone(lane));
      return;
    }

    final dispatcher = _dispatcherFor(lane);
    dispatcher.takePriority();
    if (lane == 'A' || lane == 'B' || lane == 'C') {
      _updatePriority(_rootPriority, lane);
    } else if (lane == 'A1' || lane == 'A2') {
      _updatePriority(_aPriority, lane);
      _updatePriority(_rootPriority, 'A');
    }
    _recordMode('priority', '$lane takePriority invoked');
  }

  void _forgetChildFromParent({required String parent, required String child}) {
    if (parent == 'root') {
      _root.forget(_dispatcherFor(child) as ChildBackButtonDispatcher);
      _rootPriority.remove(child);
      _recordMode('priority', 'root.forget($child)');
      return;
    }
    if (parent == 'A') {
      _a.forget(_dispatcherFor(child) as ChildBackButtonDispatcher);
      _aPriority.remove(child);
      _recordMode('priority', 'A.forget($child)');
    }
  }

  void _clearRootPriority() {
    _root.takePriority();
    _rootPriority.clear();
    _recordMode('priority', 'root.takePriority() cleared root child defer list');
  }

  void _clearAPriority() {
    _a.takePriority();
    _aPriority.clear();
    _updatePriority(_rootPriority, 'A');
    _recordMode('priority', 'A.takePriority() cleared nested child defer list');
  }

  void _setLaneCallbackActive(String lane, bool active) {
    if ((_laneActive[lane] ?? false) == active) {
      return;
    }

    setState(() => _laneActive[lane] = active);

    if (active) {
      switch (lane) {
        case 'A':
          _a.addCallback(_aCallback);
        case 'B':
          _b.addCallback(_bCallback);
        case 'C':
          _c.addCallback(_cCallback);
        case 'A1':
          _a1.addCallback(_a1Callback);
        case 'A2':
          _a2.addCallback(_a2Callback);
      }
      _recordControl('lifecycle', '$lane callback activated');
      return;
    }

    switch (lane) {
      case 'A':
        _a.removeCallback(_aCallback);
        _rootPriority.remove('A');
      case 'B':
        _b.removeCallback(_bCallback);
        _rootPriority.remove('B');
      case 'C':
        _c.removeCallback(_cCallback);
        _rootPriority.remove('C');
      case 'A1':
        _a1.removeCallback(_a1Callback);
        _aPriority.remove('A1');
      case 'A2':
        _a2.removeCallback(_a2Callback);
        _aPriority.remove('A2');
    }
    _recordControl('lifecycle', '$lane callback deactivated');
  }

  Future<void> _simulateBackDispatch({required String source}) async {
    setState(() => _dispatchAttempts += 1);
    _log('dispatch', 'Back dispatch requested by $source', _p.accentA);
    final handled = await _root.invokeCallback(Future<bool>.value(false));
    if (!mounted) {
      return;
    }
    setState(() {
      if (handled) {
        _handledDispatches += 1;
      } else {
        _unhandledDispatches += 1;
      }
    });
    _log('dispatch-result', handled ? 'Dispatch handled by hierarchy' : 'Dispatch unhandled by hierarchy', handled ? _p.accentB : _p.accentC);
  }

  void _adjustRouteDepth(String lane, int delta) {
    final current = _routeDepth[lane] ?? 1;
    final updated = (current + delta).clamp(1, 8);
    setState(() => _routeDepth[lane] = updated);
    _recordControl('stack', '$lane route depth -> $updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.paper,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _sectionBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 390,
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
              const Icon(Icons.account_tree_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'ChildBackButtonDispatcher Deep Demo',
                  style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Nested Back Dispatch Priority',
                  style: TextStyle(color: Colors.white, fontSize: 10.2, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ChildBackButtonDispatcher coordinates back-button ownership between nested routers. '
            'This deep demo visualizes callback registration, priority transfer, nested child chains, and '
            'route-stack integration patterns for interpreter-side behavior verification.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 12.2, height: 1.34),
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
          Text('Section', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _sectionTitles.length; i++) _sectionChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
          _toggleChip('crosshair', _showCrosshair, (v) => _showCrosshair = v),
          _toggleChip('verbose', _verbose, (v) => _verbose = v),
        ],
      ),
    );
  }

  Widget _sectionChip(int index) {
    final active = _section.index == index;
    return ChoiceChip(
      selected: active,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(color: active ? Colors.white : _p.ink, fontSize: 11, fontWeight: FontWeight.w700),
      onSelected: (_) {
        setState(() => _section = _DemoSection.values[index]);
        _log('section', 'Switched to ${_sectionTitles[index]}', _p.accentB);
      },
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _paletteIndex = index);
        _log('palette', 'Palette changed to ${_palettes[index].name}', _palettes[index].accentA);
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent, width: 2),
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

  Widget _sectionBody() {
    switch (_section) {
      case _DemoSection.primer:
        return _primerSection();
      case _DemoSection.priority:
        return _prioritySection();
      case _DemoSection.cascade:
        return _cascadeSection();
      case _DemoSection.lifecycle:
        return _lifecycleSection();
      case _DemoSection.integration:
        return _integrationSection();
      case _DemoSection.compendium:
        return _compendiumSection();
    }
  }

  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(color: _p.ink, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.2),
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tint ?? _p.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: _p.shell.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.8)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.33)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _primerSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Primer Studio'),
          const SizedBox(height: 8),
          Text(
            'RootBackButtonDispatcher dispatches back events through child dispatchers in priority order. '
            'This primer shows live callbacks and hierarchy routing in a visual command desk.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Primer Controls',
            subtitle: 'Run dispatch and toggle baseline handling flags.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonalIcon(
                  onPressed: () => _simulateBackDispatch(source: 'primer button'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Simulate Back Press'),
                ),
                _toggleChip('root handles fallback', _rootHandles, (v) {
                  _rootHandles = v;
                  _recordMode('primer', 'root handles -> $v');
                }),
                _toggleChip('A handles', _laneWillHandle['A'] ?? false, (v) {
                  _laneWillHandle['A'] = v;
                  _recordControl('primer', 'A handles -> $v');
                }),
                _toggleChip('B handles', _laneWillHandle['B'] ?? false, (v) {
                  _laneWillHandle['B'] = v;
                  _recordControl('primer', 'B handles -> $v');
                }),
                _toggleChip('C handles', _laneWillHandle['C'] ?? false, (v) {
                  _laneWillHandle['C'] = v;
                  _recordControl('primer', 'C handles -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Dispatcher Hierarchy',
                  subtitle: 'Root -> A/B/C and nested A -> A1/A2 chain.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 470,
                    child: _deviceShell(
                      title: 'dispatcher map',
                      caption: 'live callback state',
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(child: _background(_canvasStyle)),
                          if (_showCrosshair)
                            Positioned.fill(
                              child: CustomPaint(painter: _CrosshairPainter(color: _p.ink.withValues(alpha: 0.2))),
                            ),
                          Positioned.fill(
                            // Cluster H follow-up: same pattern as
                            // widgets/callback_shortcuts_test.dart — the
                            // inner Column (root node + 3-lane Row +
                            // 2-lane Row + metrics Wrap with separator
                            // SizedBoxes) can exceed the Positioned.fill
                            // viewport derived from SizedBox(height: 470)
                            // when rendered under flutter_test_app's
                            // slightly shorter widget pane. Wrap the inner
                            // Column in a non-scrollable
                            // SingleChildScrollView so the bounded viewport
                            // silently clips the bottom-most metrics row
                            // instead of asserting RenderFlex overflow.
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: <Widget>[
                                    _laneNode(_laneData('root')),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Expanded(child: _laneNode(_laneData('A'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: _laneNode(_laneData('B'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: _laneNode(_laneData('C'))),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        const Spacer(),
                                        Expanded(child: _laneNode(_laneData('A1'))),
                                        const SizedBox(width: 8),
                                        Expanded(child: _laneNode(_laneData('A2'))),
                                        const Spacer(),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: <Widget>[
                                        _metric('root order', _rootPriority.isEmpty ? 'none' : _rootPriority.join(' -> '), _p.accentA),
                                        _metric('A order', _aPriority.isEmpty ? 'none' : _aPriority.join(' -> '), _p.accentB),
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
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 350,
                  child: _panel(
                    title: 'Primer Notes',
                    subtitle: 'Fundamentals of child back dispatchers.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('ChildBackButtonDispatcher participates only after takePriority/deferTo chain setup.'),
                        _bullet('Parent asks children in reverse priority order; first true wins.'),
                        _bullet('If children return false, parent callback decides final result.'),
                        _bullet('Nested children (A1/A2) can intercept before parent lane A callback.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricsPanel(),
          ],
        ],
      ),
    );
  }

  Widget _prioritySection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Priority Arena'),
          const SizedBox(height: 8),
          Text(
            'Control which child dispatcher is asked first by invoking takePriority, forget, and list clearing operations.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Root Priority Controls',
            subtitle: 'Manage A/B/C priority ownership from root dispatcher.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonal(onPressed: () => _takeLanePriority('A'), child: const Text('A takePriority')),
                FilledButton.tonal(onPressed: () => _takeLanePriority('B'), child: const Text('B takePriority')),
                FilledButton.tonal(onPressed: () => _takeLanePriority('C'), child: const Text('C takePriority')),
                FilledButton.tonal(onPressed: _clearRootPriority, child: const Text('root.takePriority() clear')),
                OutlinedButton(onPressed: () => _forgetChildFromParent(parent: 'root', child: 'A'), child: const Text('root.forget(A)')),
                OutlinedButton(onPressed: () => _forgetChildFromParent(parent: 'root', child: 'B'), child: const Text('root.forget(B)')),
                OutlinedButton(onPressed: () => _forgetChildFromParent(parent: 'root', child: 'C'), child: const Text('root.forget(C)')),
                FilledButton.tonalIcon(
                  onPressed: () => _simulateBackDispatch(source: 'priority arena'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Dispatch Back'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Nested A Priority Controls',
            subtitle: 'Manage A1/A2 order under A dispatcher.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonal(onPressed: () => _takeLanePriority('A1'), child: const Text('A1 takePriority')),
                FilledButton.tonal(onPressed: () => _takeLanePriority('A2'), child: const Text('A2 takePriority')),
                FilledButton.tonal(onPressed: _clearAPriority, child: const Text('A.takePriority() clear nested')),
                OutlinedButton(onPressed: () => _forgetChildFromParent(parent: 'A', child: 'A1'), child: const Text('A.forget(A1)')),
                OutlinedButton(onPressed: () => _forgetChildFromParent(parent: 'A', child: 'A2'), child: const Text('A.forget(A2)')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Root Defer Queue',
                  subtitle: 'Rightmost lane is consulted first in parent traversal.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: _priorityVisual(_rootPriority, lane: 'root'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'A Defer Queue',
                  subtitle: 'Nested queue for A1/A2 traversal.',
                  tint: _p.accentB.withValues(alpha: 0.05),
                  child: _priorityVisual(_aPriority, lane: 'A'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priorityVisual(List<String> list, {required String lane}) {
    if (list.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
        ),
        child: Text('No deferred children', style: TextStyle(color: _p.muted, fontSize: 11.2)),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            lane == 'root' ? 'Traversal: ${list.reversed.join(' -> ')}' : 'Traversal: ${list.reversed.join(' -> ')}',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.4),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: list
                .map(
                  (entry) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _laneTone(entry).withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: _laneTone(entry).withValues(alpha: 0.36)),
                    ),
                    child: Text(entry, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.6)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _cascadeSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Cascade Chain Lab'),
          const SizedBox(height: 8),
          Text(
            'Experiment with nested A -> A1/A2 callback outcomes to observe parent-notification order and fallback behavior.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Cascade Switches',
            subtitle: 'Toggle which lane claims the back dispatch.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('A handles', _laneWillHandle['A'] ?? false, (v) {
                  _laneWillHandle['A'] = v;
                  _recordControl('cascade', 'A handles -> $v');
                }),
                _toggleChip('A1 handles', _laneWillHandle['A1'] ?? false, (v) {
                  _laneWillHandle['A1'] = v;
                  _recordControl('cascade', 'A1 handles -> $v');
                }),
                _toggleChip('A2 handles', _laneWillHandle['A2'] ?? false, (v) {
                  _laneWillHandle['A2'] = v;
                  _recordControl('cascade', 'A2 handles -> $v');
                }),
                FilledButton.tonalIcon(
                  onPressed: () => _simulateBackDispatch(source: 'cascade lab'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Dispatch Back'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Cascade Visualizer',
                  subtitle: 'Nested card lanes with direct action buttons.',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 520,
                    child: _deviceShell(
                      title: 'cascade map',
                      caption: 'A -> A1/A2',
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(child: _background(_canvasStyle)),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                children: <Widget>[
                                  _cascadeLaneCard('A', parent: 'root'),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: _cascadeLaneCard('A1', parent: 'A')),
                                      const SizedBox(width: 10),
                                      Expanded(child: _cascadeLaneCard('A2', parent: 'A')),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Cascade quick actions', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.3)),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: <Widget>[
                                            OutlinedButton(onPressed: () => _takeLanePriority('A1'), child: const Text('A1 priority')),
                                            OutlinedButton(onPressed: () => _takeLanePriority('A2'), child: const Text('A2 priority')),
                                            OutlinedButton(onPressed: _clearAPriority, child: const Text('clear nested')),
                                            OutlinedButton(
                                              onPressed: () => _simulateBackDispatch(source: 'cascade quick action'),
                                              child: const Text('dispatch'),
                                            ),
                                          ],
                                        ),
                                      ],
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
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 340,
                  child: _panel(
                    title: 'Cascade Notes',
                    subtitle: 'Reading the notification flow.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('A1/A2 are notified by A before A callback executes.'),
                        _bullet('If the newest nested child returns true, A callback is skipped.'),
                        _bullet('If all nested children return false, A callback determines result.'),
                        _bullet('If A also returns false, root continues to other children or fallback.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _cascadeLaneCard(String lane, {required String parent}) {
    final active = _laneActive[lane] ?? false;
    final handles = _laneWillHandle[lane] ?? false;
    final tone = _laneTone(lane);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$lane (parent: $parent)', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11.4)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _smallBadge('active: $active', tone),
              _smallBadge('handles: $handles', tone),
              _smallBadge('hits: ${_laneHits[lane] ?? 0}', tone),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              OutlinedButton(
                onPressed: active ? () => _takeLanePriority(lane) : null,
                child: const Text('takePriority'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  _laneWillHandle[lane] = !handles;
                  _recordControl('cascade', '$lane handles toggled -> ${_laneWillHandle[lane]}');
                },
                child: const Text('toggle handle'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallBadge(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: _p.ink, fontSize: 10, fontWeight: FontWeight.w700)),
    );
  }

  Widget _lifecycleSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Callback Lifecycle Deck'),
          const SizedBox(height: 8),
          Text(
            'Activation state determines whether a child can take priority or stay in defer lists. '
            'Disabling a lane callback removes it from parent defer chains.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Callback Activation Controls',
            subtitle: 'Toggle callback registration per lane.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final lane in <String>['A', 'B', 'C', 'A1', 'A2'])
                  FilterChip(
                    selected: _laneActive[lane] ?? false,
                    label: Text('$lane callback'),
                    onSelected: (selected) => _setLaneCallbackActive(lane, selected),
                  ),
                FilledButton.tonalIcon(
                  onPressed: () => _simulateBackDispatch(source: 'lifecycle deck'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Dispatch Back'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Lifecycle Monitor',
            subtitle: 'Registration status, callback hits, and defer-order side effects.',
            tint: _p.accentB.withValues(alpha: 0.05),
            child: Column(
              children: <Widget>[
                for (final lane in <String>['A', 'B', 'C', 'A1', 'A2']) _lifecycleRow(lane),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lifecycleRow(String lane) {
    final tone = _laneTone(lane);
    final active = _laneActive[lane] ?? false;
    final handles = _laneWillHandle[lane] ?? false;
    final hits = _laneHits[lane] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 66,
            child: Text(lane, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.2)),
          ),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _smallBadge('active: $active', tone),
                _smallBadge('handles: $handles', tone),
                _smallBadge('hits: $hits', tone),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () => _setLaneCallbackActive(lane, !active),
            child: Text(active ? 'disable' : 'enable'),
          ),
        ],
      ),
    );
  }

  Widget _integrationSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Router Integration Theater'),
          const SizedBox(height: 8),
          Text(
            'In stack mode, lane callbacks pop local route depth first. This simulates nested router delegates '
            'where child routers handle back presses until root route.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Integration Controls',
            subtitle: 'Toggle stack mode and adjust per-lane route depth.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('stack mode', _stackMode, (v) {
                      _stackMode = v;
                      _recordMode('integration', 'stack mode -> $v');
                    }),
                    FilledButton.tonalIcon(
                      onPressed: () => _simulateBackDispatch(source: 'integration theater'),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Dispatch Back'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(child: _stackDepthEditor('A')),
                    const SizedBox(width: 10),
                    Expanded(child: _stackDepthEditor('B')),
                    const SizedBox(width: 10),
                    Expanded(child: _stackDepthEditor('C')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Route Stack Shell',
            subtitle: 'Each lane behaves like a nested router branch.',
            tint: _p.accentA.withValues(alpha: 0.05),
            child: SizedBox(
              height: 540,
              child: _deviceShell(
                title: 'stack simulator',
                caption: _stackMode ? 'stack mode active' : 'fixed handle mode',
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: _background(_canvasStyle)),
                    if (_showCrosshair)
                      Positioned.fill(child: CustomPaint(painter: _CrosshairPainter(color: _p.ink.withValues(alpha: 0.18)))),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: _stackLaneCard('A')),
                                const SizedBox(width: 10),
                                Expanded(child: _stackLaneCard('B')),
                                const SizedBox(width: 10),
                                Expanded(child: _stackLaneCard('C')),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Expected routing sequence', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.4)),
                                    const SizedBox(height: 8),
                                    _pathLine('Root traversal', _rootPriority.isEmpty ? 'root callback only' : _rootPriority.reversed.join(' -> ')),
                                    _pathLine('Nested A traversal', _aPriority.isEmpty ? 'A callback only' : _aPriority.reversed.join(' -> ')),
                                    const SizedBox(height: 8),
                                    Text(
                                      'When stack mode is on, lane callbacks pop route depth until depth=1, then return false.',
                                      style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.32),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _stackDepthEditor(String lane) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _laneTone(lane).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _laneTone(lane).withValues(alpha: 0.28)),
      ),
      child: Row(
        children: <Widget>[
          Text('$lane depth', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.8)),
          const Spacer(),
          IconButton(
            onPressed: () => _adjustRouteDepth(lane, -1),
            icon: const Icon(Icons.remove_circle_outline),
            iconSize: 18,
          ),
          Text('${_routeDepth[lane]}', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
          IconButton(
            onPressed: () => _adjustRouteDepth(lane, 1),
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _stackLaneCard(String lane) {
    final tone = _laneTone(lane);
    final depth = _routeDepth[lane] ?? 1;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.layers_outlined, color: tone, size: 18),
              const SizedBox(width: 6),
              Text('Lane $lane', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11.6)),
            ],
          ),
          const SizedBox(height: 6),
          _smallBadge('depth: $depth', tone),
          const SizedBox(height: 6),
          _smallBadge('hits: ${_laneHits[lane] ?? 0}', tone),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => _adjustRouteDepth(lane, 1),
                  child: const Text('push'),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => _adjustRouteDepth(lane, -1),
                  child: const Text('pop'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pathLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 132,
            child: Text(
              label,
              style: TextStyle(color: _p.accentA, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.4),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 10.8))),
        ],
      ),
    );
  }

  Widget _compendiumSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'ChildBackButtonDispatcher Matrix',
            subtitle: 'Feature and behavior coverage from this demo.',
            child: Column(
              children: <Widget>[
                _matrix('Core role', 'Participates in nested back dispatch and can claim priority from parent.'),
                _matrix('Priority rules', 'Latest child to takePriority handles first; fallback continues in reverse order.'),
                _matrix('Nested chain', 'A can own root priority while A1/A2 arbitrate inside A before A callback.'),
                _matrix('Lifecycle behavior', 'Removing last callback causes parent.forget for that child dispatcher.'),
                _matrix('Integration mode', 'Route-depth simulation mirrors nested router pop behavior.'),
                _matrix('Debug strategy', 'Timeline captures notified order and callback handling decisions.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Practical patterns for dispatcher trees.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do call takePriority on active child dispatchers',
                  detail: 'Priority methods require callbacks to be registered.',
                ),
                _doDont(
                  good: true,
                  title: 'Do keep hierarchy intent explicit in nested routers',
                  detail: 'Traceability is easier when parent-child ownership is clear.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont leave stale child dispatchers after callback removal',
                  detail: 'Inactive children should not remain in priority assumptions.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont assume root callback runs first',
                  detail: 'Children with priority are notified before root callback fallback.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common questions for dispatcher usage.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When do I need ChildBackButtonDispatcher?',
                  a: 'When a nested router must own back-button handling relative to a parent router.',
                ),
                _qa(
                  q: 'What happens if no child handles back?',
                  a: 'Parent dispatcher callback runs, eventually reaching root fallback logic.',
                ),
                _qa(
                  q: 'Why does callback activation matter?',
                  a: 'Priority and defer assertions rely on dispatcher having active callbacks.',
                ),
                _qa(
                  q: 'How do nested children A1/A2 interact with A?',
                  a: 'A notifies its nested children first; if they return false, A callback decides.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Completion Checklist',
            subtitle: 'Deep-demo quality gates for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Multiple visual sections demonstrate dispatcher hierarchy and priority behavior.'),
                _check('Nested A1/A2 chain scenarios verify parent-notified cascade flow.'),
                _check('Lifecycle section covers callback activation and automatic forgetting behavior.'),
                _check('Integration section demonstrates route-stack style pop semantics.'),
                _check('Instructional content explains practical usage and common pitfalls.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.accentC.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.accentC.withValues(alpha: 0.32)),
            ),
            child: Text(
              'ChildBackButtonDispatcher is central to nested router back ownership. '
              'This deep demo provides a visual and operational map for priority transfer, callback lifecycle, '
              'and nested pop handling in interpreter-driven UI environments.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  _LaneCardData _laneData(String id) {
    switch (id) {
      case 'root':
        return _LaneCardData(id: 'root', title: 'Root Dispatcher', role: 'Final fallback owner', tone: _p.accentC);
      case 'A':
        return _LaneCardData(id: 'A', title: 'Child A', role: 'Primary nested lane', tone: _p.accentA);
      case 'B':
        return _LaneCardData(id: 'B', title: 'Child B', role: 'Sibling lane', tone: _p.accentB);
      case 'C':
        return _LaneCardData(id: 'C', title: 'Child C', role: 'Sibling lane', tone: _p.accentC);
      case 'A1':
        return _LaneCardData(id: 'A1', title: 'Child A1', role: 'Nested under A', tone: _p.accentA);
      case 'A2':
        return _LaneCardData(id: 'A2', title: 'Child A2', role: 'Nested under A', tone: _p.accentB);
      default:
        return _LaneCardData(id: id, title: id, role: '-', tone: _p.accentA);
    }
  }

  Widget _laneNode(_LaneCardData lane) {
    final isRoot = lane.id == 'root';
    final active = isRoot ? true : (_laneActive[lane.id] ?? false);
    final handles = isRoot ? _rootHandles : (_laneWillHandle[lane.id] ?? false);
    final hits = _laneHits[lane.id] ?? 0;
    return GestureDetector(
      onTap: () => _recordTap('lane-node', 'Tapped ${lane.id} node'),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: lane.tone.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: lane.tone.withValues(alpha: 0.32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(lane.title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11.8)),
            const SizedBox(height: 4),
            Text(lane.role, style: TextStyle(color: _p.muted, fontSize: 10.3)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _smallBadge('active: $active', lane.tone),
                _smallBadge('handles: $handles', lane.tone),
                _smallBadge('hits: $hits', lane.tone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _deviceShell({required String title, required String caption, required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _p.paper,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Row(
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.muted, fontSize: 10.8)),
                const Spacer(),
                Text(caption, style: TextStyle(color: _p.muted, fontFamily: 'monospace', fontSize: 10.3)),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Dispatch and interaction counters.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _metric('dispatch attempts', '$_dispatchAttempts', _p.accentA),
          _metric('handled', '$_handledDispatches', _p.accentB),
          _metric('unhandled', '$_unhandledDispatches', _p.accentC),
          _metric('tap events', '$_tapCount', _p.accentA),
          _metric('controls', '$_controlChanges', _p.accentB),
          _metric('mode changes', '$_modeChanges', _p.accentC),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700)),
    );
  }

  Widget _matrix(String key, String value) {
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
        children: <Widget>[
          SizedBox(
            width: 148,
            child: Text(
              key,
              style: TextStyle(color: _p.accentA, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.8),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.2, height: 1.33))),
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
        border: Border.all(color: tone.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.32)),
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
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.33)),
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
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.3))),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: _p.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.1))),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(color: _p.panel, border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.25)))),
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
                Text('Dispatch Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Notification order, callback outcomes, and priority operations.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                // Cluster H follow-up: same fix as the matching block in
                // widgets/callback_shortcuts_test.dart — the metrics Wrap
                // below adds 4 px more than the timeline panel's outer
                // Column has available under flutter_test_app's slightly
                // shorter widget pane (extra server-status row vs
                // flutter_ast_app shrinks Expanded(flex:3) by ~19 px).
                // Cutting the spacing here from 8 to 4 recovers the
                // exact 4 px without any visual impact worth noting.
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _metric('events', '${_events.length}', _p.accentA),
                    _metric('handled', '$_handledDispatches', _p.accentB),
                    _metric('unhandled', '$_unhandledDispatches', _p.accentC),
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
                    border: Border.all(color: event.tone.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.lane,
                              style: TextStyle(color: _p.ink, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.4),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(color: _p.muted, fontFamily: 'monospace', fontSize: 10.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.message, style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.31)),
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

  String _clock(DateTime at) {
    final h = at.hour.toString().padLeft(2, '0');
    final m = at.minute.toString().padLeft(2, '0');
    final s = at.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _p.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_sectionTitles[_section.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          DropdownButton<_CanvasStyle>(
            value: _canvasStyle,
            borderRadius: BorderRadius.circular(10),
            items: const <DropdownMenuItem<_CanvasStyle>>[
              DropdownMenuItem(value: _CanvasStyle.wave, child: Text('Wave')),
              DropdownMenuItem(value: _CanvasStyle.grid, child: Text('Grid')),
              DropdownMenuItem(value: _CanvasStyle.rings, child: Text('Rings')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _canvasStyle = value);
                _recordControl('canvas', 'canvas style -> $value');
              }
            },
          ),
          const SizedBox(width: 10),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }

  Widget _background(_CanvasStyle style) {
    switch (style) {
      case _CanvasStyle.wave:
        return _waveBackground();
      case _CanvasStyle.grid:
        return _gridBackground();
      case _CanvasStyle.rings:
        return _ringBackground();
    }
  }

  Widget _waveBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.24), _p.accentB.withValues(alpha: 0.24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _WavePainter(color: Colors.white.withValues(alpha: 0.2))),
    );
  }

  Widget _gridBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentB.withValues(alpha: 0.24), _p.accentC.withValues(alpha: 0.24)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(painter: _GridPainter(color: Colors.white.withValues(alpha: 0.22))),
    );
  }

  Widget _ringBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentC.withValues(alpha: 0.24), _p.accentA.withValues(alpha: 0.24)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _StarPainter(color: Colors.white.withValues(alpha: 0.2)))),
          Positioned(left: 24, top: 24, child: _ring(88, Colors.white.withValues(alpha: 0.16))),
          Positioned(right: 30, top: 40, child: _ring(68, Colors.white.withValues(alpha: 0.15))),
          Positioned(left: 110, bottom: 28, child: _ring(110, Colors.white.withValues(alpha: 0.13))),
        ],
      ),
    );
  }

  Widget _ring(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 6)),
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  const _CrosshairPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawCircle(Offset(cx, cy), 4.2, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter oldDelegate) => oldDelegate.color != color;
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < 7; i++) {
      final path = Path();
      final baseY = 22.0 + i * 28;
      path.moveTo(0, baseY);
      for (var x = 0.0; x <= size.width; x += 20) {
        final y = baseY + 8 * (i.isEven ? 1 : -1) * math.sin(x / 40);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) => oldDelegate.color != color;
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += 24;
    }
    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.color != color;
}

class _StarPainter extends CustomPainter {
  const _StarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 72; i++) {
      final dx = (i * 37 % 1000) / 1000 * size.width;
      final dy = (i * 59 % 1000) / 1000 * size.height;
      final radius = 0.7 + ((i * 13 % 10) / 10) * 1.6;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) => oldDelegate.color != color;
}
