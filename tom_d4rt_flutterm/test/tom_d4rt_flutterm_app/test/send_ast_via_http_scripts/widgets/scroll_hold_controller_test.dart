// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollHoldController from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFFC62828); // Red 800
const _kAccent = Color(0xFF84FFFF); // Cyan A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kHold = Color(0xFFFFB74D); // Orange 300
const _kIdle = Color(0xFF78909C); // BlueGrey 400
const _kDrag = Color(0xFF4DB6AC); // Teal 300

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _ScrollHoldControllerDemo(),
  );
}

class _ScrollHoldControllerDemo extends StatefulWidget {
  const _ScrollHoldControllerDemo();

  @override
  State<_ScrollHoldControllerDemo> createState() =>
      _ScrollHoldControllerDemoState();
}

class _ScrollHoldControllerDemoState extends State<_ScrollHoldControllerDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('ScrollHoldController',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.description), text: 'Contract'),
            Tab(icon: Icon(Icons.back_hand), text: 'Hold States'),
            Tab(icon: Icon(Icons.touch_app), text: 'Tap to Stop'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ContractTab(),
          _HoldStatesTab(),
          _TapToStopTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Contract
// ═══════════════════════════════════════════════════════════════════════════
class _ContractTab extends StatelessWidget {
  const _ContractTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A0000), Color(0xFF7F0000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.back_hand, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollHoldController',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('abstract class', _kPrimary),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'An interface for holding a Scrollable stationary. '
                'When the user touches a scrollable but has not yet started '
                'dragging, a hold activity is created. cancel() releases '
                'the hold.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // The abstract method
        _hdr('Abstract Method'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _kPrimary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.cancel,
                        color: _kPrimary, size: 22),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('cancel()',
                          style: TextStyle(
                              color: _kAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                      Text('→ void',
                          style: TextStyle(
                              color: _kDim,
                              fontSize: 10,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Release the Scrollable. Called when the user lifts their '
                'finger without dragging, or when a drag gesture is '
                'recognized and the hold transitions to a drag activity.',
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withAlpha(20)),
                ),
                child: const Text(
                  '// HoldScrollActivity implementation:\n'
                  '@override\n'
                  'void cancel() {\n'
                  '  delegate.goBallistic(0.0);\n'
                  '}',
                  style: TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Concrete implementation
        _hdr('Concrete: HoldScrollActivity'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kHold.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _kHold.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        const Icon(Icons.pause, color: _kHold, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('HoldScrollActivity',
                          style: TextStyle(
                              color: _kHold,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          _badge('extends ScrollActivity', _kDim),
                          const SizedBox(width: 4),
                          _badge('implements ScrollHoldController', _kAccent),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'The default concrete implementation that holds a scrollable '
                'stationary. Does nothing while active — simply prevents '
                'other scroll activities from occurring.',
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
              ),
              const SizedBox(height: 12),
              _propRow('shouldIgnorePointer', 'false',
                  'Content remains interactive', _kHold),
              const SizedBox(height: 4),
              _propRow('isScrolling', 'false',
                  'Not considered scrolling', _kHold),
              const SizedBox(height: 4),
              _propRow('velocity', '0.0',
                  'No movement', _kHold),
              const SizedBox(height: 4),
              _propRow('onHoldCanceled', 'VoidCallback?',
                  'Invoked on dispose', _kHold),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Creation flow
        _hdr('Creation Flow'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              _flowStep('User touches scrollable widget', _kBright, 1),
              _flowArrow(),
              _flowStep('GestureRecognizer fires onDown', _kDim, 2),
              _flowArrow(),
              _flowStep('ScrollPosition.hold() called', _kAccent, 3),
              _flowArrow(),
              _flowStep('HoldScrollActivity created', _kHold, 4),
              _flowArrow(),
              _flowStep('Returns ScrollHoldController', _kPrimary, 5),
              _flowArrow(),
              _flowStep('Scrollable references controller', _kDrag, 6),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // API signature
        _hdr('ScrollPosition.hold()'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'ScrollHoldController hold(\n'
            '  VoidCallback holdCancelCallback,\n'
            ')',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Called by Scrollable when a pointer touches but has not started '
          'a drag. Returns the controller that can be used to cancel the '
          'hold later.',
          style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
        ),
      ],
    );
  }

  static Widget _propRow(String name, String value, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(name,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(value,
                style: const TextStyle(
                    color: _kBright,
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ),
          Expanded(
            flex: 4,
            child: Text(desc,
                style: const TextStyle(color: _kDim, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _flowStep(String text, Color color, int num) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(20),
            border: Border.all(color: color.withAlpha(50)),
          ),
          child: Center(
            child: Text('$num',
                style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(color: color, fontSize: 11, height: 1.3)),
        ),
      ],
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
      child: Icon(Icons.keyboard_arrow_down,
          size: 14, color: _kDim.withAlpha(40)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Hold States (interactive state machine)
// ═══════════════════════════════════════════════════════════════════════════
class _HoldStatesTab extends StatefulWidget {
  const _HoldStatesTab();

  @override
  State<_HoldStatesTab> createState() => _HoldStatesTabState();
}

enum _ScrollPhase { idle, holding, dragging, ballistic }

class _HoldStatesTabState extends State<_HoldStatesTab> {
  _ScrollPhase _phase = _ScrollPhase.idle;
  final List<String> _log = [];

  void _transition(_ScrollPhase to, String msg) {
    setState(() {
      _phase = to;
      _log.insert(0, '${_phase.name.toUpperCase()}: $msg');
      if (_log.length > 30) _log.removeLast();
    });
  }

  Color _phaseColor() {
    switch (_phase) {
      case _ScrollPhase.idle:
        return _kIdle;
      case _ScrollPhase.holding:
        return _kHold;
      case _ScrollPhase.dragging:
        return _kDrag;
      case _ScrollPhase.ballistic:
        return _kPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current phase
        Container(
          padding: const EdgeInsets.all(12),
          color: _phaseColor().withAlpha(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: _phaseColor()),
              ),
              const SizedBox(width: 8),
              Text(
                _phase.name.toUpperCase(),
                style: TextStyle(
                    color: _phaseColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2),
              ),
            ],
          ),
        ),

        // Phase properties
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: _kCard,
          child: Row(
            children: [
              _propBadge('isScrolling',
                  _phase == _ScrollPhase.dragging ||
                      _phase == _ScrollPhase.ballistic),
              const SizedBox(width: 6),
              _propBadge('ignorePointer',
                  _phase == _ScrollPhase.ballistic),
              const SizedBox(width: 6),
              _velBadge(_phase == _ScrollPhase.ballistic
                  ? '~500'
                  : _phase == _ScrollPhase.dragging
                      ? '~100'
                      : '0'),
            ],
          ),
        ),

        // State machine diagram
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _stateCircle('Idle', _kIdle,
                  _phase == _ScrollPhase.idle),
              _arrow(),
              _stateCircle('Hold', _kHold,
                  _phase == _ScrollPhase.holding),
              _arrow(),
              _stateCircle('Drag', _kDrag,
                  _phase == _ScrollPhase.dragging),
              _arrow(),
              _stateCircle('Ballistic', _kPrimary,
                  _phase == _ScrollPhase.ballistic),
            ],
          ),
        ),

        // Transition buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _transBtn(
                      'Touch Down',
                      Icons.touch_app,
                      _kHold,
                      _phase == _ScrollPhase.idle ||
                          _phase == _ScrollPhase.ballistic,
                      () => _transition(_ScrollPhase.holding,
                          'pointer down → hold()'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _transBtn(
                      'Start Drag',
                      Icons.swipe,
                      _kDrag,
                      _phase == _ScrollPhase.holding,
                      () => _transition(_ScrollPhase.dragging,
                          'cancel() → drag activity'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _transBtn(
                      'Lift (Fling)',
                      Icons.swipe_up,
                      _kPrimary,
                      _phase == _ScrollPhase.dragging,
                      () => _transition(_ScrollPhase.ballistic,
                          'goBallistic(velocity)'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _transBtn(
                      'Lift (Still)',
                      Icons.pan_tool,
                      _kIdle,
                      _phase == _ScrollPhase.holding ||
                          _phase == _ScrollPhase.dragging,
                      () => _transition(_ScrollPhase.idle,
                          'cancel() → goBallistic(0) → idle'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _transBtn(
                      'Scroll Ends',
                      Icons.stop,
                      _kIdle,
                      _phase == _ScrollPhase.ballistic,
                      () => _transition(_ScrollPhase.idle,
                          'velocity → 0 → idle'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _transBtn(
                      'Reset',
                      Icons.refresh,
                      _kDim,
                      true,
                      () {
                        setState(() {
                          _phase = _ScrollPhase.idle;
                          _log.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Hold explanation
        if (_phase == _ScrollPhase.holding)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kHold.withAlpha(10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kHold.withAlpha(30)),
            ),
            child: const Text(
              'HOLD: ScrollHoldController is active. The scrollable is '
              'stationary. User can interact with content (shouldIgnorePointer '
              '= false). Waiting for either drag gesture or pointer up.',
              style: TextStyle(color: _kHold, fontSize: 10, height: 1.4),
            ),
          ),

        // Log
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _log.isEmpty
                ? const Center(
                    child: Text('Tap buttons to simulate scroll phases',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    itemCount: _log.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        _log[i],
                        style: const TextStyle(
                            color: _kDim,
                            fontFamily: 'monospace',
                            fontSize: 10,
                            height: 1.3),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _propBadge(String label, bool value) {
    final color = value ? _kAccent : _kDim;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withAlpha(25)),
        ),
        child: Center(
          child: Text('$label: $value',
              style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _velBadge(String vel) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _kPrimary.withAlpha(10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kPrimary.withAlpha(25)),
        ),
        child: Center(
          child: Text('vel: $vel',
              style: const TextStyle(
                  color: _kPrimary,
                  fontSize: 9,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _stateCircle(String label, Color color, bool active) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? color.withAlpha(30) : Colors.transparent,
              border: Border.all(
                color: active ? color : _kDim.withAlpha(25),
                width: active ? 2 : 1,
              ),
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? color : _kDim.withAlpha(30)),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  color: active ? color : _kDim.withAlpha(60),
                  fontSize: 9,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _arrow() {
    return Icon(Icons.arrow_forward,
        size: 12, color: _kDim.withAlpha(30));
  }

  Widget _transBtn(
    String label,
    IconData icon,
    Color color,
    bool enabled,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: enabled ? color.withAlpha(15) : _kCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: enabled ? color.withAlpha(40) : _kDim.withAlpha(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 14,
                color: enabled ? color : _kDim.withAlpha(30)),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: enabled ? color : _kDim.withAlpha(30),
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Tap to Stop (real hold in action)
// ═══════════════════════════════════════════════════════════════════════════
class _TapToStopTab extends StatefulWidget {
  const _TapToStopTab();

  @override
  State<_TapToStopTab> createState() => _TapToStopTabState();
}

class _TapToStopTabState extends State<_TapToStopTab> {
  final ScrollController _ctrl = ScrollController();
  bool _isAnimating = false;
  double _offset = 0;
  final List<String> _events = [];

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      if (_ctrl.hasClients) {
        setState(() => _offset = _ctrl.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    if (!_ctrl.hasClients) return;
    final max = _ctrl.position.maxScrollExtent;
    setState(() {
      _isAnimating = true;
      _events.insert(0, 'Auto-scroll started');
    });
    _ctrl
        .animateTo(
      _ctrl.offset < max * 0.5 ? max : 0,
      duration: const Duration(seconds: 6),
      curve: Curves.easeInOut,
    )
        .then((_) {
      if (mounted) {
        setState(() {
          _isAnimating = false;
          _events.insert(0, 'Auto-scroll completed');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Instruction
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              const Text(
                'Tap "Start Auto-Scroll", then touch the list to stop it. '
                'Touching triggers hold() which interrupts the animated scroll.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.3),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _isAnimating
                          ? _kAccent.withAlpha(15)
                          : _kDim.withAlpha(10),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: _isAnimating
                              ? _kAccent.withAlpha(40)
                              : _kDim.withAlpha(20)),
                    ),
                    child: Text(
                      _isAnimating ? 'SCROLLING' : 'STOPPED',
                      style: TextStyle(
                          color: _isAnimating ? _kAccent : _kDim,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${_offset.toStringAsFixed(0)} px',
                      style: const TextStyle(
                          color: _kBright,
                          fontFamily: 'monospace',
                          fontSize: 11)),
                ],
              ),
            ],
          ),
        ),

        // Button
        Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton.icon(
            onPressed: _isAnimating ? null : _startAutoScroll,
            icon: const Icon(Icons.play_arrow, size: 16),
            label: const Text('Start Auto-Scroll'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kAccent.withAlpha(25),
              foregroundColor: _kAccent,
              disabledBackgroundColor: _kCard,
              disabledForegroundColor: _kDim.withAlpha(40),
            ),
          ),
        ),

        // Scrollable
        Expanded(
          flex: 3,
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n is ScrollStartNotification) {
                setState(() => _events.insert(0, 'ScrollStart'));
              } else if (n is ScrollEndNotification) {
                setState(() {
                  _isAnimating = false;
                  _events.insert(
                      0,
                      'ScrollEnd (dragDetails: '
                      '${n.dragDetails != null ? "present" : "null"})');
                });
              }
              if (_events.length > 25) _events.removeLast();
              return false;
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: _isAnimating
                        ? _kAccent.withAlpha(40)
                        : _kPrimary.withAlpha(30)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  controller: _ctrl,
                  itemCount: 100,
                  itemBuilder: (ctx, i) {
                    final red = (i / 100 * 60 + 30).toInt();
                    return Container(
                      height: 42,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, red, 15, 15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text('Item $i',
                          style: TextStyle(
                              color: Color.fromARGB(
                                  255, red + 80, 80, 80),
                              fontSize: 11)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Events
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _events.isEmpty
                ? const Center(
                    child: Text('Events appear here',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        _events[i],
                        style: TextStyle(
                            color: _events[i].contains('End')
                                ? _kPrimary
                                : _events[i].contains('Start')
                                    ? _kAccent
                                    : _kDim,
                            fontFamily: 'monospace',
                            fontSize: 10,
                            height: 1.3),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _hdr(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                color: _kBright,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _badge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color.withAlpha(200),
            fontSize: 10,
            fontFamily: 'monospace')),
  );
}
