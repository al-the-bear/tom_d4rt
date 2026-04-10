// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Deep visual test for ScrollPositionWithSingleContext.
///
/// ScrollPositionWithSingleContext is the most commonly used concrete
/// implementation of ScrollPosition. It manages scroll behavior using
/// ScrollActivity objects and implements ScrollActivityDelegate.
///
/// Demonstrates:
/// - Tab 1 (Position & Physics): Constructor parameters, ScrollPhysics
///   interaction, pixel position management, keepScrollOffset/PageStorage
///   persistence, and initialPixels configuration
/// - Tab 2 (Activity Lifecycle): ScrollActivityDelegate methods (setPixels,
///   goIdle, goBallistic), drag/hold interactions, activity state transitions,
///   and _heldPreviousVelocity transfer
/// - Tab 3 (State Absorption): absorb() method behavior, transferring state
///   from oldPosition, userScrollDirection tracking, axisDirection, and
///   position restoration flow

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF283593); // Indigo 900
const Color _kAccent = Color(0xFFF4FF81); // Lime A200
const Color _kSurface = Color(0xFF1A1A20);
const Color _kCard = Color(0xFF28282E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF38383E);
const Color _kError = Color(0xFFEF5350);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFFCA28);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _PositionDemo(),
  );
}

class _PositionDemo extends StatefulWidget {
  const _PositionDemo();
  @override
  State<_PositionDemo> createState() => _PositionDemoState();
}

class _PositionDemoState extends State<_PositionDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ScrollPositionWithSingleContext',
          style: TextStyle(
            color: _kAccent,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Position'),
            Tab(text: 'Activities'),
            Tab(text: 'Absorb'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _PositionPhysicsTab(),
          _ActivityLifecycleTab(),
          _StateAbsorptionTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Position & Physics
// ═══════════════════════════════════════════════════════════════════════════════

class _PositionPhysicsTab extends StatefulWidget {
  const _PositionPhysicsTab();
  @override
  State<_PositionPhysicsTab> createState() => _PositionPhysicsTabState();
}

class _PositionPhysicsTabState extends State<_PositionPhysicsTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollCtrl = ScrollController();
  double _currentPixels = 0.0;
  double _maxExtent = 0.0;
  double _viewportDim = 0.0;
  bool _keepScrollOffset = true;
  String _selectedPhysics = 'BouncingScrollPhysics';
  double _initialPixels = 0.0;
  String _debugLabel = 'listView';
  final List<String> _positionLog = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollCtrl.hasClients) return;
    final pos = _scrollCtrl.position;
    setState(() {
      _currentPixels = pos.pixels;
      _maxExtent = pos.maxScrollExtent;
      _viewportDim = pos.viewportDimension;
    });
  }

  void _logAction(String msg) {
    setState(() {
      _positionLog.insert(0, msg);
      if (_positionLog.length > 50) _positionLog.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Position metrics ──
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.straighten, size: 16, color: _kAccent),
                  const SizedBox(width: 8),
                  const Text(
                    'Scroll Position Metrics',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildMetricRow('pixels', _currentPixels.toStringAsFixed(1)),
              _buildMetricRow('maxScrollExtent', _maxExtent.toStringAsFixed(1)),
              _buildMetricRow(
                'viewportDimension',
                _viewportDim.toStringAsFixed(1),
              ),
              _buildMetricRow(
                'progress',
                _maxExtent > 0
                    ? '${(_currentPixels / _maxExtent * 100).toStringAsFixed(1)}%'
                    : '0%',
              ),
            ],
          ),
        ),

        // ── Progress bar ──
        Container(
          height: 6,
          color: _kSubtle,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _maxExtent > 0
                  ? (_currentPixels / _maxExtent).clamp(0.0, 1.0)
                  : 0.0,
              child: Container(color: _kPrimary),
            ),
          ),
        ),

        // ── Constructor params ──
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Constructor Parameters',
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildParamRow(
                  'physics',
                  _selectedPhysics,
                  onTap: () {
                    setState(() {
                      _selectedPhysics =
                          _selectedPhysics == 'BouncingScrollPhysics'
                              ? 'ClampingScrollPhysics'
                              : 'BouncingScrollPhysics';
                      _logAction('physics → $_selectedPhysics');
                    });
                  },
                ),
                _buildParamRow(
                  'initialPixels',
                  _initialPixels.toStringAsFixed(0),
                  onTap: () {
                    setState(() {
                      _initialPixels = _initialPixels == 0 ? 200.0 : 0.0;
                      _logAction('initialPixels → ${_initialPixels.toStringAsFixed(0)}');
                    });
                  },
                ),
                _buildParamRow(
                  'keepScrollOffset',
                  '$_keepScrollOffset',
                  onTap: () {
                    setState(() {
                      _keepScrollOffset = !_keepScrollOffset;
                      _logAction('keepScrollOffset → $_keepScrollOffset');
                    });
                  },
                ),
                _buildParamRow('debugLabel', '"$_debugLabel"', onTap: () {
                  setState(() {
                    _debugLabel =
                        _debugLabel == 'listView' ? 'gridView' : 'listView';
                    _logAction('debugLabel → "$_debugLabel"');
                  });
                }),
                _buildParamRow('context', 'ScrollableState', onTap: null),
              ],
            ),
          ),
        ),

        // ── Scrollable area ──
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n is ScrollStartNotification) {
                _logAction('ScrollStartNotification dispatched');
              } else if (n is ScrollEndNotification) {
                _logAction('ScrollEndNotification dispatched');
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 40,
              itemBuilder: (_, i) {
                return Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _kSubtle.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: _kPrimary.withValues(
                            alpha: (1 - i / 40.0).clamp(0.2, 1.0),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Item $i',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'offset: ${(i * 48.0).toStringAsFixed(0)}',
                        style: TextStyle(
                          color: _kDimText.withValues(alpha: 0.5),
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        _buildInfoBanner(
          'ScrollPositionWithSingleContext is created by ScrollController.createScrollPosition(). '
          'It uses ScrollPhysics to determine overscroll behavior and momentum curves.',
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParamRow(String name, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Text(
                name,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: onTap != null ? _kAccent : _kDimText,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            if (onTap != null)
              const Icon(Icons.touch_app, size: 12, color: _kDimText),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Activity Lifecycle
// ═══════════════════════════════════════════════════════════════════════════════

class _ActivityLifecycleTab extends StatefulWidget {
  const _ActivityLifecycleTab();
  @override
  State<_ActivityLifecycleTab> createState() => _ActivityLifecycleTabState();
}

class _ActivityLifecycleTabState extends State<_ActivityLifecycleTab>
    with AutomaticKeepAliveClientMixin {
  String _currentActivity = 'IdleScrollActivity';
  double _velocity = 0.0;
  double _heldPreviousVelocity = 0.0;
  String _userDirection = 'idle';
  final List<_ActivityTransition> _transitions = [];
  int _transitionId = 0;

  @override
  bool get wantKeepAlive => true;

  void _transition(String from, String to, String trigger) {
    _transitionId++;
    setState(() {
      _transitions.insert(
        0,
        _ActivityTransition(
          id: _transitionId,
          from: from,
          to: to,
          trigger: trigger,
        ),
      );
      _currentActivity = to;
    });
  }

  void _simulateGoIdle() {
    _transition(_currentActivity, 'IdleScrollActivity', 'goIdle()');
    setState(() {
      _velocity = 0.0;
      _userDirection = 'idle';
    });
  }

  void _simulateGoBallistic() {
    final vel = 800.0 + (math.Random().nextDouble() * 400);
    _transition(
      _currentActivity,
      'BallisticScrollActivity',
      'goBallistic(${vel.toStringAsFixed(0)})',
    );
    setState(() {
      _velocity = vel;
      _userDirection = 'forward';
    });
  }

  void _simulateHold() {
    setState(() {
      _heldPreviousVelocity = _velocity;
    });
    _transition(_currentActivity, 'HoldScrollActivity', 'hold()');
    setState(() {
      _velocity = 0.0;
    });
  }

  void _simulateDrag() {
    _transition(_currentActivity, 'DragScrollActivity', 'drag(startDetails, …)');
    setState(() {
      _velocity = 0.0;
      _userDirection = 'forward';
    });
  }

  void _simulateSetPixels() {
    _transition(
      _currentActivity,
      _currentActivity,
      'setPixels(${(math.Random().nextDouble() * 500).toStringAsFixed(0)})',
    );
  }

  Color _activityColor(String activity) {
    if (activity.contains('Idle')) return _kDimText;
    if (activity.contains('Ballistic')) return _kWarning;
    if (activity.contains('Hold')) return _kPrimary;
    if (activity.contains('Drag')) return _kAccent;
    if (activity.contains('Driven')) return _kSuccess;
    return _kDimText;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Current state ──
        Container(
          padding: const EdgeInsets.all(14),
          color: _kCard,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _activityColor(_currentActivity),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _currentActivity,
                      style: TextStyle(
                        color: _activityColor(_currentActivity),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildKV2('velocity', '${_velocity.toStringAsFixed(1)} px/s'),
              _buildKV2(
                '_heldPreviousVelocity',
                '${_heldPreviousVelocity.toStringAsFixed(1)} px/s',
              ),
              _buildKV2('userScrollDirection', _userDirection),
            ],
          ),
        ),

        // ── Delegate actions ──
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ScrollActivityDelegate Actions',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _activityBtn('goIdle()', _kDimText, _simulateGoIdle),
                  _activityBtn(
                    'goBallistic(v)',
                    _kWarning,
                    _simulateGoBallistic,
                  ),
                  _activityBtn('hold()', _kPrimary, _simulateHold),
                  _activityBtn('drag(…)', _kAccent, _simulateDrag),
                  _activityBtn('setPixels(n)', _kSuccess, _simulateSetPixels),
                ],
              ),
            ],
          ),
        ),

        // ── State machine diagram ──
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Activity State Machine',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              _stateRow('Idle', '→ hold()', 'Hold', _kDimText, _kPrimary),
              _stateRow('Hold', '→ drag()', 'Drag', _kPrimary, _kAccent),
              _stateRow(
                'Drag',
                '→ goBallistic()',
                'Ballistic',
                _kAccent,
                _kWarning,
              ),
              _stateRow(
                'Ballistic',
                '→ goIdle()',
                'Idle',
                _kWarning,
                _kDimText,
              ),
              _stateRow('Any', '→ goIdle()', 'Idle', Colors.white38, _kDimText),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ── Transitions log ──
        Expanded(
          child: _transitions.isEmpty
              ? const Center(
                  child: Text(
                    'Use delegate actions to trigger transitions',
                    style: TextStyle(color: _kDimText, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _transitions.length,
                  itemBuilder: (_, i) {
                    final t = _transitions[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Text(
                              '#${t.id}',
                              style: const TextStyle(
                                color: _kDimText,
                                fontSize: 9,
                              ),
                            ),
                          ),
                          Text(
                            t.trigger,
                            style: const TextStyle(
                              color: _kAccent,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${t.from} → ${t.to}',
                            style: const TextStyle(
                              color: _kDimText,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),

        _buildInfoBanner(
          'hold() saves current velocity in _heldPreviousVelocity. When drag() '
          'ends, goBallistic() receives the combined velocity for smooth momentum.',
        ),
      ],
    );
  }

  Widget _stateRow(
    String from,
    String trigger,
    String to,
    Color fromColor,
    Color toColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              from,
              style: TextStyle(
                color: fromColor,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              trigger,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            to,
            style: TextStyle(
              color: toColor,
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — State Absorption
// ═══════════════════════════════════════════════════════════════════════════════

class _StateAbsorptionTab extends StatefulWidget {
  const _StateAbsorptionTab();
  @override
  State<_StateAbsorptionTab> createState() => _StateAbsorptionTabState();
}

class _StateAbsorptionTabState extends State<_StateAbsorptionTab>
    with AutomaticKeepAliveClientMixin {
  _SimPosition _oldPosition = _SimPosition(
    type: 'ScrollPositionWithSingleContext',
    pixels: 350.0,
    activity: 'BallisticScrollActivity',
    velocity: 1200.0,
    direction: 'forward',
  );
  _SimPosition _newPosition = _SimPosition(
    type: 'ScrollPositionWithSingleContext',
    pixels: 0.0,
    activity: 'IdleScrollActivity',
    velocity: 0.0,
    direction: 'idle',
  );
  bool _oldIsSameType = true;
  bool _absorbed = false;
  final List<String> _absorbLog = [];
  bool _pageStorageSaved = false;

  @override
  bool get wantKeepAlive => true;

  void _toggleOldType() {
    setState(() {
      _oldIsSameType = !_oldIsSameType;
      _absorbed = false;
      _absorbLog.clear();
      if (_oldIsSameType) {
        _oldPosition = _SimPosition(
          type: 'ScrollPositionWithSingleContext',
          pixels: 350.0,
          activity: 'BallisticScrollActivity',
          velocity: 1200.0,
          direction: 'forward',
        );
      } else {
        _oldPosition = _SimPosition(
          type: 'CustomScrollPosition',
          pixels: 200.0,
          activity: 'DrivenScrollActivity',
          velocity: 0.0,
          direction: 'forward',
        );
      }
      _newPosition = _SimPosition(
        type: 'ScrollPositionWithSingleContext',
        pixels: 0.0,
        activity: 'IdleScrollActivity',
        velocity: 0.0,
        direction: 'idle',
      );
    });
  }

  void _runAbsorb() {
    setState(() {
      _absorbed = true;
      _absorbLog.clear();
      _absorbLog.add('absorb(oldPosition) called');
      _absorbLog.add('  oldPosition is ${_oldPosition.type}');

      if (_oldIsSameType) {
        _absorbLog.add(
          '  ✓ Same type → transfer activity & velocity',
        );
        _absorbLog.add(
          '  activity: ${_oldPosition.activity} → newPosition',
        );
        _absorbLog.add(
          '  _heldPreviousVelocity: ${_oldPosition.velocity.toStringAsFixed(0)}'
          ' → newPosition',
        );
        _newPosition = _SimPosition(
          type: 'ScrollPositionWithSingleContext',
          pixels: _oldPosition.pixels,
          activity: _oldPosition.activity,
          velocity: _oldPosition.velocity,
          direction: _oldPosition.direction,
        );
      } else {
        _absorbLog.add('  ✗ Different type → cannot transfer activity');
        _absorbLog.add('  Calling super.absorb(oldPosition)');
        _absorbLog.add('  Then goIdle() — cannot continue foreign activity');
        _newPosition = _SimPosition(
          type: 'ScrollPositionWithSingleContext',
          pixels: _oldPosition.pixels,
          activity: 'IdleScrollActivity',
          velocity: 0.0,
          direction: 'idle',
        );
      }
      _absorbLog.add(
        '  Result: pixels=${_newPosition.pixels.toStringAsFixed(0)}, '
        'activity=${_newPosition.activity}',
      );
    });
  }

  void _togglePageStorage() {
    setState(() {
      _pageStorageSaved = !_pageStorageSaved;
      _absorbLog.insert(
        0,
        _pageStorageSaved
            ? 'PageStorage.of(context).writeState(pixels: ${_newPosition.pixels.toStringAsFixed(0)})'
            : 'PageStorage cleared — offset will not be restored',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Old position card ──
          _buildSectionTitle('Old Position (to absorb from)'),
          const SizedBox(height: 8),
          _positionCard(_oldPosition, true),
          const SizedBox(height: 6),
          Center(
            child: GestureDetector(
              onTap: _toggleOldType,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _kSubtle,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _oldIsSameType
                      ? 'Switch to different type'
                      : 'Switch to same type',
                  style: const TextStyle(color: _kAccent, fontSize: 11),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Absorb button ──
          Center(
            child: Column(
              children: [
                const Icon(Icons.arrow_downward, color: _kDimText, size: 20),
                const SizedBox(height: 4),
                ElevatedButton.icon(
                  onPressed: _absorbed ? null : _runAbsorb,
                  icon: const Icon(Icons.merge_type, size: 16),
                  label: Text(_absorbed ? 'Absorbed' : 'absorb(oldPosition)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _kSubtle,
                    disabledForegroundColor: _kDimText,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(Icons.arrow_downward, color: _kDimText, size: 20),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── New position card ──
          _buildSectionTitle('New Position (absorbs state)'),
          const SizedBox(height: 8),
          _positionCard(_newPosition, false),

          const SizedBox(height: 16),

          // ── PageStorage ──
          _buildSectionTitle('Position Restoration'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      _pageStorageSaved ? Icons.save : Icons.save_outlined,
                      size: 18,
                      color: _pageStorageSaved ? _kSuccess : _kDimText,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _pageStorageSaved
                          ? 'PageStorage: SAVED'
                          : 'PageStorage: NOT SAVED',
                      style: TextStyle(
                        color: _pageStorageSaved ? _kSuccess : _kDimText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _togglePageStorage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _kPrimary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _kPrimary),
                        ),
                        child: Text(
                          _pageStorageSaved ? 'Clear' : 'Save',
                          style: const TextStyle(
                            color: _kAccent,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildKV3(
                  'keepScrollOffset',
                  'true → saves to PageStorage on detach',
                ),
                _buildKV3(
                  'restoreOffset',
                  'reads from PageStorage on attach',
                ),
                _buildKV3(
                  'saveScrollOffset',
                  'called by activity on every pixel change',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Absorb log ──
          if (_absorbLog.isNotEmpty) ...[
            _buildSectionTitle('Absorb Log'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _absorbLog.map((msg) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: msg.contains('✓')
                            ? _kSuccess
                            : msg.contains('✗')
                                ? _kError
                                : msg.contains('Result')
                                    ? _kAccent
                                    : _kDimText,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 12),

          _buildInfoBanner(
            'absorb() transfers state from the old position during ScrollController '
            'reassignment. Same-type positions transfer the full activity; '
            'different types fall back to goIdle().',
          ),
        ],
      ),
    );
  }

  Widget _positionCard(_SimPosition pos, bool isOld) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isOld
              ? _kWarning.withValues(alpha: 0.4)
              : _kPrimary.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isOld ? Icons.outbox : Icons.inbox,
                size: 16,
                color: isOld ? _kWarning : _kPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                pos.type,
                style: TextStyle(
                  color: isOld ? _kWarning : _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildKV3('pixels', pos.pixels.toStringAsFixed(1)),
          _buildKV3('activity', pos.activity),
          _buildKV3('velocity', '${pos.velocity.toStringAsFixed(1)} px/s'),
          _buildKV3('userScrollDirection', pos.direction),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers & data models
// ═══════════════════════════════════════════════════════════════════════════════

class _SimPosition {
  _SimPosition({
    required this.type,
    required this.pixels,
    required this.activity,
    required this.velocity,
    required this.direction,
  });
  final String type;
  final double pixels;
  final String activity;
  final double velocity;
  final String direction;
}

class _ActivityTransition {
  _ActivityTransition({
    required this.id,
    required this.from,
    required this.to,
    required this.trigger,
  });
  final int id;
  final String from;
  final String to;
  final String trigger;
}

Widget _buildKV2(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            key,
            style: const TextStyle(
              color: _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKV3(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            key,
            style: const TextStyle(
              color: _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _activityBtn(String label, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
