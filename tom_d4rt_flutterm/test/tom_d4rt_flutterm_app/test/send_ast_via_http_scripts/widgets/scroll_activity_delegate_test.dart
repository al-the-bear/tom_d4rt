// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollActivityDelegate from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF00838F); // Cyan 800
const _kAccent = Color(0xFFFFD740); // Amber A200
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kIdle = Color(0xFF78909C); // BlueGrey 400
const _kHold = Color(0xFFFFB74D); // Orange 300
const _kDrag = Color(0xFF4FC3F7); // LightBlue 300
const _kBallistic = Color(0xFFAED581); // LightGreen 300
const _kDriven = Color(0xFFCE93D8); // Purple 200

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
    home: const _ScrollActivityDelegateDemo(),
  );
}

class _ScrollActivityDelegateDemo extends StatefulWidget {
  const _ScrollActivityDelegateDemo();

  @override
  State<_ScrollActivityDelegateDemo> createState() =>
      _ScrollActivityDelegateDemoState();
}

class _ScrollActivityDelegateDemoState
    extends State<_ScrollActivityDelegateDemo>
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
        title: const Text('ScrollActivityDelegate',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.api), text: 'Interface'),
            Tab(icon: Icon(Icons.account_tree), text: 'Activity Flow'),
            Tab(icon: Icon(Icons.code), text: 'Implementation'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _InterfaceTab(),
          _ActivityFlowTab(),
          _ImplementationTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Interface
// ═══════════════════════════════════════════════════════════════════════════
class _InterfaceTab extends StatelessWidget {
  const _InterfaceTab();

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
              colors: [Color(0xFF006064), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.api, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollActivityDelegate',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: Text(
                  'abstract class (mixin interface)',
                  style: TextStyle(
                      color: _kAccent.withAlpha(200),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'The contract between ScrollActivity subclasses and '
                'the ScrollPosition that hosts them. Activities call '
                'delegate methods to set pixels, apply user offsets, '
                'or transition to idle/ballistic states.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Property
        _hdr('Property'),
        const SizedBox(height: 10),
        _methodCard(
          'axisDirection',
          'AxisDirection',
          'Returns the direction along which the scroll view scrolls '
              '(up, down, left, right). Activities use this to determine '
              'which axis to operate on.',
          Icons.compass_calibration,
          _kPrimary,
          isProperty: true,
        ),
        const SizedBox(height: 20),

        // Methods
        _hdr('Abstract Methods'),
        const SizedBox(height: 10),
        _methodCard(
          'setPixels(double pixels)',
          'double',
          'Moves the scroll position to the specified pixel offset. '
              'Returns the overscroll amount (how many pixels could not '
              'be consumed). A non-zero return means the position hit a '
              'boundary.',
          Icons.straighten,
          _kDrag,
        ),
        const SizedBox(height: 10),
        _methodCard(
          'applyUserOffset(double delta)',
          'void',
          'When the user physically drags, the delta goes through '
              'ScrollPhysics.applyPhysicsToUserOffset() before reaching '
              'the position. This filters momentum, applies clamping, '
              'and converts raw gestures into smooth scroll behavior.',
          Icons.touch_app,
          _kHold,
        ),
        const SizedBox(height: 10),
        _methodCard(
          'goIdle()',
          'void',
          'Terminates the current activity and switches to '
              'IdleScrollActivity. Called when drag ends without momentum, '
              'when a driven animation completes, or when the activity '
              'should simply stop.',
          Icons.pause_circle_outline,
          _kIdle,
        ),
        const SizedBox(height: 10),
        _methodCard(
          'goBallistic(double velocity)',
          'void',
          'Terminates the current activity and starts a '
              'BallisticScrollActivity with the given velocity. Called '
              'when a drag ends with momentum or when physics dictates '
              "a spring-back to valid bounds. If velocity is 0, it's "
              'equivalent to going idle.',
          Icons.speed,
          _kBallistic,
        ),
        const SizedBox(height: 20),

        // Relationship diagram
        _hdr('Relationship Diagram'),
        const SizedBox(height: 10),
        _buildRelationshipDiagram(),
      ],
    );
  }

  Widget _buildRelationshipDiagram() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          // Top: Scrollable
          _diagramBox('Scrollable', 'Creates ScrollPosition', _kPrimary),
          _diagramArrow('owns'),
          _diagramBox(
              'ScrollPosition', 'implements ScrollActivityDelegate', _kAccent),
          _diagramArrow('hosts'),
          _diagramBox(
              'ScrollActivity', 'holds reference to delegate', _kDrag),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withAlpha(10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withAlpha(30)),
            ),
            child: const Text(
              'Activity calls delegate.setPixels() / delegate.goIdle() / '
              'delegate.goBallistic() to control the scroll position.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _diagramBox(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace')),
          const SizedBox(height: 2),
          Text(subtitle,
              style: const TextStyle(color: _kDim, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _diagramArrow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 16, width: 2, color: _kDim.withAlpha(40)),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  color: _kDim, fontSize: 10, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  static Widget _methodCard(
    String signature,
    String returnType,
    String description,
    IconData icon,
    Color color, {
    bool isProperty = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(signature,
                          style: TextStyle(
                              color: color,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withAlpha(40)),
                      ),
                      child: Text(
                        isProperty ? 'get' : '→ $returnType',
                        style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description,
                    style: const TextStyle(
                        color: _kDim, fontSize: 12, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Activity Flow (Interactive State Machine)
// ═══════════════════════════════════════════════════════════════════════════
class _ActivityFlowTab extends StatefulWidget {
  const _ActivityFlowTab();

  @override
  State<_ActivityFlowTab> createState() => _ActivityFlowTabState();
}

enum _ActivityState { idle, hold, drag, ballistic, driven }

class _ActivityFlowTabState extends State<_ActivityFlowTab> {
  _ActivityState _current = _ActivityState.idle;
  final List<String> _transitions = [];

  void _transition(_ActivityState to, String method) {
    setState(() {
      _transitions.insert(
          0, '${_current.name} → ${to.name}  via $method');
      if (_transitions.length > 10) _transitions.removeLast();
      _current = to;
    });
  }

  Color _colorFor(_ActivityState s) {
    switch (s) {
      case _ActivityState.idle:
        return _kIdle;
      case _ActivityState.hold:
        return _kHold;
      case _ActivityState.drag:
        return _kDrag;
      case _ActivityState.ballistic:
        return _kBallistic;
      case _ActivityState.driven:
        return _kDriven;
    }
  }

  IconData _iconFor(_ActivityState s) {
    switch (s) {
      case _ActivityState.idle:
        return Icons.pause_circle;
      case _ActivityState.hold:
        return Icons.touch_app;
      case _ActivityState.drag:
        return Icons.swipe;
      case _ActivityState.ballistic:
        return Icons.speed;
      case _ActivityState.driven:
        return Icons.animation;
    }
  }

  String _descFor(_ActivityState s) {
    switch (s) {
      case _ActivityState.idle:
        return 'No scrolling. Waiting for user input or programmatic scroll.';
      case _ActivityState.hold:
        return 'User finger down but not yet dragging. Pointer events paused.';
      case _ActivityState.drag:
        return 'User actively dragging. delegate.applyUserOffset() called.';
      case _ActivityState.ballistic:
        return 'Momentum scrolling via physics simulation. delegate.setPixels() called each frame.';
      case _ActivityState.driven:
        return 'Programmatic animation (animateTo). delegate.setPixels() called each frame.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _colorFor(_current);
    return Column(
      children: [
        // Current state card
        Container(
          padding: const EdgeInsets.all(16),
          color: _kCard,
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: c.withAlpha(25),
                  shape: BoxShape.circle,
                  border: Border.all(color: c, width: 2),
                ),
                child: Icon(_iconFor(_current), color: c, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_current.name.toUpperCase(),
                        style: TextStyle(
                            color: c,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5)),
                    const SizedBox(height: 4),
                    Text(_descFor(_current),
                        style: const TextStyle(
                            color: _kDim, fontSize: 11, height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Transition buttons
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Trigger Transitions:',
                  style: TextStyle(
                      color: _kDim, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _availableTransitions(),
              ),
            ],
          ),
        ),

        // State overview — all five bubbles
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: _ActivityState.values.map((s) {
              final active = s == _current;
              final sc = _colorFor(s);
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? sc.withAlpha(30) : _kCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: active ? sc : _kDim.withAlpha(25),
                        width: active ? 2 : 1),
                  ),
                  child: Column(
                    children: [
                      Icon(_iconFor(s),
                          size: 18, color: active ? sc : _kDim.withAlpha(60)),
                      const SizedBox(height: 4),
                      Text(s.name,
                          style: TextStyle(
                              color: active ? sc : _kDim.withAlpha(60),
                              fontSize: 9,
                              fontWeight:
                                  active ? FontWeight.bold : FontWeight.normal)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Transition log
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Transition Log',
                    style: TextStyle(
                        color: _kAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const Divider(color: _kDim, height: 12),
                Expanded(
                  child: _transitions.isEmpty
                      ? const Center(
                          child: Text('Tap a transition button above',
                              style: TextStyle(color: _kDim, fontSize: 11)))
                      : ListView(
                          children: _transitions.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(e,
                                  style: const TextStyle(
                                      color: _kBright,
                                      fontFamily: 'monospace',
                                      fontSize: 10,
                                      height: 1.4)),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _availableTransitions() {
    final result = <Widget>[];

    void add(String label, _ActivityState to, String method, Color c) {
      result.add(
        GestureDetector(
          onTap: () => _transition(to, method),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: c.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: c.withAlpha(60)),
            ),
            child: Text(label,
                style: TextStyle(
                    color: c, fontSize: 11, fontWeight: FontWeight.w500)),
          ),
        ),
      );
    }

    switch (_current) {
      case _ActivityState.idle:
        add('Touch down → Hold', _ActivityState.hold, 'hold()', _kHold);
        add('animateTo → Driven', _ActivityState.driven, 'animateTo()', _kDriven);
        break;
      case _ActivityState.hold:
        add('Start drag → Drag', _ActivityState.drag, 'drag()', _kDrag);
        add('Lift finger → Idle', _ActivityState.idle, 'goIdle()', _kIdle);
        break;
      case _ActivityState.drag:
        add('Release w/ velocity → Ballistic', _ActivityState.ballistic,
            'goBallistic(v)', _kBallistic);
        add('Release no velocity → Idle', _ActivityState.idle,
            'goIdle()', _kIdle);
        break;
      case _ActivityState.ballistic:
        add('Simulation done → Idle', _ActivityState.idle,
            'goIdle()', _kIdle);
        add('Touch interrupts → Hold', _ActivityState.hold,
            'hold()', _kHold);
        break;
      case _ActivityState.driven:
        add('Animation done → Idle', _ActivityState.idle,
            'goIdle()', _kIdle);
        add('Touch interrupts → Hold', _ActivityState.hold,
            'hold()', _kHold);
        break;
    }

    return result;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Implementation (ScrollPositionWithSingleContext)
// ═══════════════════════════════════════════════════════════════════════════
class _ImplementationTab extends StatelessWidget {
  const _ImplementationTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('ScrollPositionWithSingleContext'),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAccent.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withAlpha(40)),
          ),
          child: const Text(
            'The concrete class that implements ScrollActivityDelegate. '
            'Every standard ListView, GridView, CustomScrollView uses this.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
          ),
        ),
        const SizedBox(height: 20),

        // setPixels
        _implCard(
          'setPixels(double pixels)',
          'double overscroll',
          _kDrag,
          'Clamp the requested pixels to [minScrollExtent, maxScrollExtent]. '
              'If the value exceeds bounds, return the excess as overscroll. '
              'Then dispatch a ScrollUpdateNotification.',
          'double setPixels(double newPixels) {\n'
              '  // 1. clamp to bounds\n'
              '  // 2. compute overscroll\n'
              '  // 3. update internal _pixels\n'
              '  // 4. notify listeners\n'
              '  // 5. return overscroll\n'
              '}',
          [
            'Input: 1200.0 px, maxExtent: 1000.0',
            'Sets pixels to 1000.0, returns 200.0 overscroll',
            'Triggers ScrollUpdateNotification',
          ],
        ),
        const SizedBox(height: 14),

        // applyUserOffset
        _implCard(
          'applyUserOffset(double delta)',
          'void',
          _kHold,
          'Takes the raw drag delta, feeds it through '
              'physics.applyPhysicsToUserOffset(), then calls setPixels(). '
              'Physics can dampen the offset near boundaries to create the '
              'overscroll-glow or bounce effect.',
          'void applyUserOffset(double delta) {\n'
              '  updateUserScrollDirection(...);\n'
              '  final adjusted = physics\n'
              '    .applyPhysicsToUserOffset(this, delta);\n'
              '  setPixels(pixels - adjusted);\n'
              '}',
          [
            'Raw delta: -40.0 (drag up)',
            'Physics may soften to -38.5 near edge',
            'setPixels(currentPixels + 38.5)',
          ],
        ),
        const SizedBox(height: 14),

        // goIdle
        _implCard(
          'goIdle()',
          'void',
          _kIdle,
          'Creates a new IdleScrollActivity and sets it as the current. '
              'The previous activity is disposed. Usually called when a drag '
              'ends with zero velocity or when an animation completes.',
          'void goIdle() {\n'
              '  beginActivity(\n'
              '    IdleScrollActivity(this),\n'
              '  );\n'
              '}',
          [
            'Previous activity: DragScrollActivity',
            'Creates IdleScrollActivity(delegate: this)',
            'Disposes DragScrollActivity',
          ],
        ),
        const SizedBox(height: 14),

        // goBallistic
        _implCard(
          'goBallistic(double velocity)',
          'void',
          _kBallistic,
          'Creates a ClampingScrollSimulation (or BouncingScrollSimulation) '
              'from the current position and velocity, wraps it in a '
              'BallisticScrollActivity. The simulation runs on every tick, '
              'calling setPixels() until the velocity decays to zero.',
          'void goBallistic(double velocity) {\n'
              '  final simulation = physics\n'
              '    .createBallisticSimulation(this, v);\n'
              '  if (simulation != null)\n'
              '    beginActivity(BallisticScroll\n'
              '      Activity(this, simulation, ...));\n'
              '  else\n'
              '    goIdle();\n'
              '}',
          [
            'velocity: 1500.0 px/s after drag release',
            'Physics builds ClampingScrollSimulation',
            'Each frame: setPixels() with simulated position',
            'After ~800ms: velocity ≈ 0, goIdle()',
          ],
        ),
        const SizedBox(height: 20),

        // axisDirection
        _hdr('axisDirection Property'),
        const SizedBox(height: 10),
        _buildAxisDirectionGrid(),
        const SizedBox(height: 20),

        // Full lifecycle
        _hdr('Delegate Method Call Sequence'),
        const SizedBox(height: 10),
        _buildLifecycleSequence(),
      ],
    );
  }

  Widget _buildAxisDirectionGrid() {
    const dirs = [
      ('up', Icons.arrow_upward, 'Content scrolls towards top',
          _kIdle),
      ('down', Icons.arrow_downward, 'Content scrolls towards bottom (default)',
          _kDrag),
      ('left', Icons.arrow_back, 'Content scrolls towards left',
          _kHold),
      ('right', Icons.arrow_forward, 'Content scrolls towards right',
          _kBallistic),
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (final d in dirs)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: d.$4.withAlpha(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: d.$4.withAlpha(60)),
                    ),
                    child: Icon(d.$2, size: 16, color: d.$4),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AxisDirection.${d.$1}',
                            style: TextStyle(
                                color: d.$4,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace')),
                        Text(d.$3,
                            style: const TextStyle(
                                color: _kDim, fontSize: 10)),
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

  Widget _buildLifecycleSequence() {
    const steps = [
      ('1. User touches', 'hold() → HoldScrollActivity', _kHold),
      ('2. Finger moves', 'drag() → DragScrollActivity', _kDrag),
      ('3. During drag', 'delegate.applyUserOffset(delta)', _kHold),
      ('4. Finger lifts', 'delegate.goBallistic(velocity)', _kBallistic),
      ('5. Each sim frame', 'delegate.setPixels(simPosition)', _kDrag),
      ('6. Momentum stops', 'delegate.goIdle()', _kIdle),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: steps[i].$3.withAlpha(25),
                    shape: BoxShape.circle,
                    border: Border.all(color: steps[i].$3.withAlpha(80)),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: TextStyle(
                            color: steps[i].$3,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i].$1,
                          style: TextStyle(
                              color: steps[i].$3,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      Text(steps[i].$2,
                          style: const TextStyle(
                              color: _kDim,
                              fontSize: 10,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
              ],
            ),
            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 14),
                height: 10,
                width: 2,
                color: steps[i].$3.withAlpha(30),
              ),
          ],
        ],
      ),
    );
  }

  static Widget _implCard(
    String signature,
    String returnType,
    Color color,
    String description,
    String code,
    List<String> examples,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(signature,
                    style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('→ $returnType',
                    style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                  color: _kDim, fontSize: 12, height: 1.4)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withAlpha(25)),
            ),
            child: Text(code,
                style: const TextStyle(
                    color: _kBright,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.4)),
          ),
          const SizedBox(height: 8),
          ...examples.map((ex) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right, size: 14, color: color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(ex,
                          style: const TextStyle(
                              color: _kDim,
                              fontSize: 11,
                              height: 1.3)),
                    ),
                  ],
                ),
              )),
        ],
      ),
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
