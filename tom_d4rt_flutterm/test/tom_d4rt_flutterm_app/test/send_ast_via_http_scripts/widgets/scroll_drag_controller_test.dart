// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollDragController from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF795548); // Brown 600
const _kAccent = Color(0xFF80D8FF); // LightBlue A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kParam = Color(0xFF4DD0E1); // Cyan A200
const _kConst = Color(0xFFFF8A65); // DeepOrange 300
const _kMethod = Color(0xFFA5D6A7); // Green 300

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
    home: const _ScrollDragControllerDemo(),
  );
}

class _ScrollDragControllerDemo extends StatefulWidget {
  const _ScrollDragControllerDemo();

  @override
  State<_ScrollDragControllerDemo> createState() =>
      _ScrollDragControllerDemoState();
}

class _ScrollDragControllerDemoState extends State<_ScrollDragControllerDemo>
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
        title: const Text('ScrollDragController',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.swipe), text: 'Drag Session'),
            Tab(icon: Icon(Icons.speed), text: 'Momentum'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConstructorTab(),
          _DragSessionTab(),
          _MomentumTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Constructor
// ═══════════════════════════════════════════════════════════════════════════
class _ConstructorTab extends StatelessWidget {
  const _ConstructorTab();

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
              colors: [Color(0xFF3E2723), Color(0xFF5D4037)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.swipe_vertical, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollDragController',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('class', _kPrimary),
                  const SizedBox(width: 6),
                  _badge('implements Drag', _kMethod),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Manages user drag scrolling. Created when a drag gesture '
                'begins and drives scroll position updates until the drag '
                'ends or is canceled. At end, hands off velocity for '
                'ballistic scrolling.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Constructor signature
        _hdr('Constructor Signature'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'ScrollDragController({\n'
            '  required delegate,\n'
            '  required details,\n'
            '  onDragCanceled,\n'
            '  carriedVelocity,\n'
            '  motionStartDistanceThreshold,\n'
            '})',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Parameters
        _hdr('Parameters'),
        const SizedBox(height: 10),

        _paramCard(
          'delegate',
          'ScrollActivityDelegate',
          true,
          'The object that actualizes scrolling. Receives '
              'applyUserOffset calls during dragging and goBallistic '
              'when the drag ends. Changed via updateDelegate if the '
              'scroll position is re-parented.',
          Icons.hub,
        ),
        const SizedBox(height: 10),

        _paramCard(
          'details',
          'DragStartDetails',
          true,
          'Details of the drag start event including the global '
              'position and optional source timestamp. Used to '
              'initialize the velocity tracker and record the start '
              'position for motion threshold calculations.',
          Icons.pinch,
        ),
        const SizedBox(height: 10),

        _paramCard(
          'onDragCanceled',
          'VoidCallback?',
          false,
          'Notification callback invoked when the drag is canceled '
              'or disposed without a proper end. Allows the scroll '
              'configuration to react to interrupted drags.',
          Icons.cancel_outlined,
        ),
        const SizedBox(height: 10),

        _paramCard(
          'carriedVelocity',
          'double?',
          false,
          'Velocity from a preceding ballistic activity. When the '
              'user catches a scroll mid-fling, this velocity is carried '
              'into the new drag. If the drag lasts too long or slows too '
              'much, the carried velocity is discarded.',
          Icons.trending_flat,
        ),
        const SizedBox(height: 10),

        _paramCard(
          'motionStartDistanceThreshold',
          'double?',
          false,
          'Distance the finger must move before the controller starts '
              'issuing scroll updates. Prevents micro-movements from '
              'triggering scrolling. Null means any movement scrolls '
              'immediately. Also used to prevent carried momentum if the '
              'finger barely moves.',
          Icons.straighten,
        ),
        const SizedBox(height: 20),

        // Drag interface
        _hdr('Drag Interface'),
        const SizedBox(height: 10),
        _methodCard(
          'update(DragUpdateDetails details)',
          'void',
          'Called on each pointer movement during drag. Calculates '
              'the offset delta and calls delegate.applyUserOffset(). '
              'Also updates the velocity tracker. If motionStart '
              'DistanceThreshold is set and not yet met, the update '
              'is absorbed silently.',
        ),
        const SizedBox(height: 8),
        _methodCard(
          'end(DragEndDetails details)',
          'void',
          'Called when the drag gesture is recognized as ending. '
              'Computes the final velocity from the tracker (adds '
              'carried velocity if applicable), then calls '
              'delegate.goBallistic(velocity). The controller is then '
              'done — no further updates.',
        ),
        const SizedBox(height: 8),
        _methodCard(
          'cancel()',
          'void',
          'Called when the drag gesture is canceled (e.g., another '
              'gesture wins the arena). Calls delegate.goBallistic(0.0) '
              'since there is no reliable velocity. Triggers '
              'onDragCanceled callback.',
        ),
        const SizedBox(height: 8),
        _methodCard(
          'dispose()',
          'void',
          'Cleans up resources. If the drag was not properly ended, '
              'invokes onDragCanceled. Marks the controller as disposed.',
        ),
      ],
    );
  }

  static Widget _paramCard(
    String name,
    String type,
    bool required_,
    String description,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kParam.withAlpha(40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kParam.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kParam, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: const TextStyle(
                            color: _kParam,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                    const SizedBox(width: 6),
                    if (required_)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935).withAlpha(20),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color:
                                  const Color(0xFFE53935).withAlpha(50)),
                        ),
                        child: const Text('required',
                            style: TextStyle(
                                color: Color(0xFFEF5350),
                                fontSize: 9,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                Text(type,
                    style: const TextStyle(
                        color: _kDim,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                const SizedBox(height: 6),
                Text(description,
                    style: const TextStyle(
                        color: _kDim, fontSize: 11, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _methodCard(
      String signature, String returnType, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kMethod.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_arrow, color: _kMethod, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(signature,
                    style: const TextStyle(
                        color: _kMethod,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: _kMethod.withAlpha(15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(returnType,
                    style: TextStyle(
                        color: _kMethod.withAlpha(180),
                        fontSize: 9,
                        fontFamily: 'monospace')),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description,
              style:
                  const TextStyle(color: _kDim, fontSize: 11, height: 1.4)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Drag Session (interactive lifecycle)
// ═══════════════════════════════════════════════════════════════════════════
class _DragSessionTab extends StatefulWidget {
  const _DragSessionTab();

  @override
  State<_DragSessionTab> createState() => _DragSessionTabState();
}

enum _DragPhase { idle, dragging, ended, canceled }

class _DragSessionTabState extends State<_DragSessionTab> {
  _DragPhase _phase = _DragPhase.idle;
  double _totalDelta = 0;
  double _velocity = 0;
  int _updateCount = 0;
  final List<String> _log = [];

  void _startDrag() {
    if (_phase != _DragPhase.idle) return;
    setState(() {
      _phase = _DragPhase.dragging;
      _totalDelta = 0;
      _velocity = 0;
      _updateCount = 0;
      _log.add('> Drag started');
    });
  }

  void _updateDrag(double delta) {
    if (_phase != _DragPhase.dragging) return;
    setState(() {
      _totalDelta += delta;
      _updateCount++;
      _velocity = delta * 16.67; // simulate ~60fps velocity
      _log.add('  update #$_updateCount: delta=${delta.toStringAsFixed(1)}, '
          'total=${_totalDelta.toStringAsFixed(1)}');
    });
  }

  void _endDrag() {
    if (_phase != _DragPhase.dragging) return;
    setState(() {
      _phase = _DragPhase.ended;
      _log.add('> Drag ended (velocity: ${_velocity.toStringAsFixed(1)})');
      _log.add('  → goBallistic(${_velocity.toStringAsFixed(1)})');
    });
  }

  void _cancelDrag() {
    if (_phase != _DragPhase.dragging) return;
    setState(() {
      _phase = _DragPhase.canceled;
      _velocity = 0;
      _log.add('> Drag canceled');
      _log.add('  → goBallistic(0.0)');
      _log.add('  → onDragCanceled()');
    });
  }

  void _reset() {
    setState(() {
      _phase = _DragPhase.idle;
      _totalDelta = 0;
      _velocity = 0;
      _updateCount = 0;
      _log.clear();
    });
  }

  Color _phaseColor() {
    switch (_phase) {
      case _DragPhase.idle:
        return _kDim;
      case _DragPhase.dragging:
        return _kAccent;
      case _DragPhase.ended:
        return _kMethod;
      case _DragPhase.canceled:
        return _kConst;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phase indicator
        Container(
          padding: const EdgeInsets.all(12),
          color: _phaseColor().withAlpha(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _phaseColor(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _phase.name.toUpperCase(),
                style: TextStyle(
                    color: _phaseColor(),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ],
          ),
        ),

        // Stats bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          color: _kCard,
          child: Row(
            children: [
              _statChip('Updates', '$_updateCount', _kParam),
              const SizedBox(width: 10),
              _statChip('Delta', _totalDelta.toStringAsFixed(1), _kAccent),
              const SizedBox(width: 10),
              _statChip(
                  'Velocity', _velocity.toStringAsFixed(1), _kConst),
            ],
          ),
        ),

        // Pipeline
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              _pipelineStep('Start', 0, _kParam),
              _pipelineArrow(),
              _pipelineStep('Update ×N', 1, _kAccent),
              _pipelineArrow(),
              _pipelineStep('End / Cancel', 2, _kMethod),
              _pipelineArrow(),
              _pipelineStep('Ballistic', 3, _kConst),
            ],
          ),
        ),

        // Drag area
        Expanded(
          flex: 2,
          child: GestureDetector(
            onVerticalDragStart: (_) => _startDrag(),
            onVerticalDragUpdate: (d) => _updateDrag(d.delta.dy),
            onVerticalDragEnd: (_) => _endDrag(),
            onVerticalDragCancel: () => _cancelDrag(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _phaseColor().withAlpha(40)),
              ),
              child: Stack(
                children: [
                  // Background label
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _phase == _DragPhase.dragging
                              ? Icons.swipe_vertical
                              : Icons.touch_app,
                          color: _phaseColor().withAlpha(60),
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _phase == _DragPhase.idle
                              ? 'Drag vertically here'
                              : _phase == _DragPhase.dragging
                                  ? 'Keep dragging…'
                                  : 'Tap Reset to try again',
                          style: TextStyle(
                              color: _phaseColor().withAlpha(100),
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  // Position indicator
                  if (_phase == _DragPhase.dragging)
                    Positioned(
                      top: (_totalDelta.clamp(-150, 150) + 150) / 300 * 200,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _kAccent,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // Action buttons
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _phase == _DragPhase.dragging ? _cancelDrag : null,
                  icon: const Icon(Icons.cancel, size: 16),
                  label: const Text('Force Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kConst.withAlpha(30),
                    foregroundColor: _kConst,
                    disabledBackgroundColor: _kCard,
                    disabledForegroundColor: _kDim.withAlpha(40),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _phase != _DragPhase.idle ? _reset : null,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary.withAlpha(30),
                    foregroundColor: _kBright,
                    disabledBackgroundColor: _kCard,
                    disabledForegroundColor: _kDim.withAlpha(40),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Log
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _log.isEmpty
                ? const Center(
                    child: Text('Event log will appear here',
                        style: TextStyle(color: _kDim, fontSize: 11)),
                  )
                : ListView.builder(
                    itemCount: _log.length,
                    itemBuilder: (ctx, i) => Text(
                      _log[i],
                      style: TextStyle(
                          color: _log[i].startsWith('>')
                              ? _kAccent
                              : _kDim,
                          fontFamily: 'monospace',
                          fontSize: 10,
                          height: 1.4),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _statChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(25)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(color: _kDim, fontSize: 9)),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _pipelineStep(String label, int step, Color color) {
    final active = _phase.index >= step;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: active ? color.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: active ? color.withAlpha(60) : _kDim.withAlpha(25)),
      ),
      child: Text(label,
          style: TextStyle(
              color: active ? color : _kDim.withAlpha(60),
              fontSize: 9,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _pipelineArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(Icons.chevron_right, size: 14, color: _kDim.withAlpha(40)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Momentum (static constants & thresholds)
// ═══════════════════════════════════════════════════════════════════════════
class _MomentumTab extends StatelessWidget {
  const _MomentumTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('Momentum Retention'),
        const SizedBox(height: 10),
        const Text(
          'When a user catches a scrolling list mid-fling to start a '
          'new drag, ScrollDragController can add the previous fling\'s '
          'velocity to the new drag. Three static constants govern this:',
          style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 20),

        // Constant 1
        _constantCard(
          'momentumRetainStationaryDurationThreshold',
          'Duration(milliseconds: 20)',
          '20 ms',
          'Maximum time the pointer can be stationary before carried '
              'velocity is discarded. If the finger pauses for more than '
              '20ms before starting the drag, the old scroll momentum is '
              'lost. This ensures that only genuine "catch and rethrow" '
              'gestures carry momentum.',
          _buildTimelineBar(20, 100, _kConst, 'Retain', 'Forget'),
        ),
        const SizedBox(height: 14),

        // Constant 2
        _constantCard(
          'momentumRetainVelocityThresholdFactor',
          '0.5',
          '50%',
          'The new drag velocity must be at least 50% of the carried '
              'velocity. If the user starts dragging slowly after catching '
              'a fast fling, the carried velocity is ignored. This prevents '
              'awkward velocity jumps when the drag intent differs from '
              'the original fling direction.',
          _buildVelocityComparison(),
        ),
        const SizedBox(height: 14),

        // Constant 3
        _constantCard(
          'motionStoppedDurationThreshold',
          'Duration(milliseconds: 50)',
          '50 ms',
          'If motionStartDistanceThreshold is set and the pointer was '
              'stationary for more than 50ms, the threshold must be '
              'exceeded again before scrolling starts. This prevents '
              'accidental scrolling from micro-movements after a pause.',
          _buildTimelineBar(50, 100, _kParam, 'Free scroll', 'Need threshold'),
        ),
        const SizedBox(height: 20),

        // Flow diagram
        _hdr('Momentum Decision Flow'),
        const SizedBox(height: 10),
        _buildMomentumFlow(),
        const SizedBox(height: 20),

        // End velocity composition
        _hdr('End Velocity Composition'),
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
              _velocityRow('Tracker velocity', 'From pointer events',
                  _kMethod),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('+',
                      style: TextStyle(
                          color: _kAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _velocityRow('Carried velocity',
                        'From previous ballistic', _kConst),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: _kDim, height: 1),
              ),
              _velocityRow('Final velocity', 'Passed to goBallistic()',
                  _kAccent),
              const SizedBox(height: 10),
              const Text(
                'If carriedVelocity is null or conditions are not met, '
                'only the tracker velocity is used.',
                style: TextStyle(
                    color: _kDim, fontSize: 10, height: 1.3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // updateDelegate
        _hdr('delegate Hot-Swap'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kParam.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.swap_horiz, color: _kParam, size: 18),
                  const SizedBox(width: 8),
                  const Text('updateDelegate(newDelegate)',
                      style: TextStyle(
                          color: _kParam,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'If the underlying ScrollPosition is re-parented '
                'during a drag (e.g., a NestedScrollView switching '
                'between inner and outer positions), the delegate '
                'can be swapped mid-drag without interrupting the '
                'user experience.',
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _phaseChip('Old delegate', const Color(0xFF78909C)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: _kAccent),
                  ),
                  _phaseChip('updateDelegate()', _kParam),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward,
                        size: 14, color: _kAccent),
                  ),
                  _phaseChip('New delegate', _kMethod),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineBar(
      int threshold, int total, Color color, String before, String after) {
    final fraction = threshold / total;
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: (fraction * 100).toInt(),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(4)),
                  border: Border.all(color: color.withAlpha(60)),
                ),
                alignment: Alignment.center,
                child: Text(before,
                    style: TextStyle(
                        color: color, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: 2,
              height: 24,
              color: _kAccent,
            ),
            Expanded(
              flex: 100 - (fraction * 100).toInt(),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: _kDim.withAlpha(15),
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(4)),
                  border: Border.all(color: _kDim.withAlpha(25)),
                ),
                alignment: Alignment.center,
                child: Text(after,
                    style: TextStyle(
                        color: _kDim.withAlpha(120),
                        fontSize: 8,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('${threshold}ms threshold',
              style: TextStyle(
                  color: _kAccent, fontSize: 9, fontFamily: 'monospace')),
        ),
      ],
    );
  }

  Widget _buildVelocityComparison() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          _velBar('Carried', 1.0, _kConst),
          const SizedBox(height: 4),
          _velBar('Threshold (50%)', 0.5, _kAccent),
          const SizedBox(height: 4),
          _velBar('Drag slow', 0.3, _kDim),
          const SizedBox(height: 4),
          _velBar('Drag fast', 0.7, _kMethod),
          const SizedBox(height: 4),
          Row(
            children: [
              const Spacer(),
              Text('Below 50% → momentum lost',
                  style: TextStyle(
                      color: _kDim.withAlpha(150),
                      fontSize: 9,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _velBar(String label, double fraction, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: (fraction * 100).toInt(),
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: color.withAlpha(80)),
                  ),
                ),
              ),
              Expanded(
                  flex: 100 - (fraction * 100).toInt(),
                  child: const SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMomentumFlow() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          _flowStep('User catches mid-fling', _kAccent, true),
          _flowArrow(),
          _flowStep('carriedVelocity != null?', _kParam, true),
          _flowArrow(),
          _flowStep('Stationary < 20ms?', _kConst, true),
          _flowArrow(),
          _flowStep('Drag velocity >= 50% carried?', _kMethod, true),
          _flowArrow(),
          _flowStep('Add carried velocity to final', _kAccent, false),
        ],
      ),
    );
  }

  Widget _flowStep(String text, Color color, bool hasCheck) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(
              hasCheck ? Icons.help_outline : Icons.check_circle_outline,
              color: color,
              size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w500)),
          ),
          if (hasCheck)
            Text('Yes →',
                style: TextStyle(
                    color: color.withAlpha(120),
                    fontSize: 9,
                    fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.keyboard_arrow_down,
          size: 16, color: _kDim.withAlpha(40)),
    );
  }

  Widget _velocityRow(String label, String desc, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
              Text(desc,
                  style:
                      const TextStyle(color: _kDim, fontSize: 9)),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _phaseChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color,
              fontSize: 9,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold)),
    );
  }

  static Widget _constantCard(
    String name,
    String dartValue,
    String humanValue,
    String description,
    Widget visual,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kConst.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _kConst.withAlpha(15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.timer, color: _kConst, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        color: _kConst,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace')),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _kAccent.withAlpha(30)),
                ),
                child: Text(humanValue,
                    style: const TextStyle(
                        color: _kAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(dartValue,
                style: TextStyle(
                    color: _kBright.withAlpha(180),
                    fontSize: 10,
                    fontFamily: 'monospace')),
          ),
          const SizedBox(height: 8),
          Text(description,
              style:
                  const TextStyle(color: _kDim, fontSize: 11, height: 1.4)),
          visual,
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
