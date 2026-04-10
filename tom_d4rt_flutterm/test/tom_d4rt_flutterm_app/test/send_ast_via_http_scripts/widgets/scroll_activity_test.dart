// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollActivity from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFFBF360C); // DeepOrange 900
const _kAccent = Color(0xFFCCFF90); // LightGreen A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kIdle = Color(0xFF78909C); // BlueGrey 400
const _kHold = Color(0xFFFFD54F); // Amber 300
const _kDrag = Color(0xFF4DD0E1); // Cyan 300
const _kBallistic = Color(0xFF81C784); // Green 300
const _kDriven = Color(0xFFBA68C8); // Purple 300

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
    home: const _ScrollActivityDemo(),
  );
}

class _ScrollActivityDemo extends StatefulWidget {
  const _ScrollActivityDemo();

  @override
  State<_ScrollActivityDemo> createState() => _ScrollActivityDemoState();
}

class _ScrollActivityDemoState extends State<_ScrollActivityDemo>
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
        title: const Text('ScrollActivity',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book), text: 'Overview'),
            Tab(icon: Icon(Icons.view_module), text: 'Subclasses'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _OverviewTab(),
          _SubclassesTab(),
          _LifecycleTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Overview
// ═══════════════════════════════════════════════════════════════════════════
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

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
              colors: [Color(0xFFBF360C), Color(0xFF4E342E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.motion_photos_auto, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollActivity',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 24,
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
                  'abstract class ScrollActivity',
                  style: TextStyle(
                      color: _kAccent.withAlpha(200),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'The base class for all scroll behaviors. Every ongoing '
                'scroll interaction (drag, fling, programmatic animation) '
                'is represented by a ScrollActivity subclass that drives '
                'the ScrollPosition through its delegate.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Constructor
        _hdr('Constructor'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'ScrollActivity(\n'
            '  ScrollActivityDelegate _delegate,\n'
            ')\n'
            '\n'
            '// Stores a reference to the delegate\n'
            '// (typically ScrollPositionWithSingleContext)\n'
            '// All subclasses call super(delegate)',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 20),

        // Abstract properties
        _hdr('Abstract Properties'),
        const SizedBox(height: 10),
        _propcard(
          'shouldIgnorePointer',
          'bool',
          'When true, the scroll view ignores pointer events on its '
              'contents. Set during ballistic and driven activities so '
              'the user cannot interact with list items while they fly by.',
          Icons.do_not_touch,
          _kBallistic,
        ),
        const SizedBox(height: 10),
        _propcard(
          'isScrolling',
          'bool',
          'Whether this activity represents active scrolling. '
              'IdleScrollActivity returns false, all others return true. '
              'Used by ScrollNotification and accessibility.',
          Icons.swap_vert,
          _kDrag,
        ),
        const SizedBox(height: 10),
        _propcard(
          'velocity',
          'double',
          'Current scroll velocity in logical pixels per second. '
              'Returns 0.0 for idle, the drag delta for drag, '
              'and the simulation velocity for ballistic/driven.',
          Icons.speed,
          _kPrimary,
        ),
        const SizedBox(height: 20),

        // Concrete properties/methods
        _hdr('Concrete Members'),
        const SizedBox(height: 10),
        _propcard(
          'delegate',
          'ScrollActivityDelegate',
          'Getter that returns the internal delegate reference. '
              'The activity uses this to call setPixels(), goIdle(), '
              'goBallistic(), and applyUserOffset().',
          Icons.link,
          _kAccent,
        ),
        const SizedBox(height: 10),
        _propcard(
          'updateDelegate(value)',
          'void',
          'Swaps the delegate reference. Called when a ScrollPosition '
              'absorbs another and needs to reassign activities.',
          Icons.sync_alt,
          _kHold,
        ),
        const SizedBox(height: 20),

        // Notification methods
        _hdr('ScrollNotification Dispatchers'),
        const SizedBox(height: 10),
        _buildNotificationTable(),
      ],
    );
  }

  Widget _buildNotificationTable() {
    const notifs = [
      ('dispatchScrollStart\nNotification', 'ScrollStart\nNotification',
          'Sent when scrolling begins', _kHold),
      ('dispatchScrollUpdate\nNotification', 'ScrollUpdate\nNotification',
          'Sent on each position change', _kDrag),
      ('dispatchOverscroll\nNotification', 'Overscroll\nNotification',
          'Sent when scrolling past bounds', _kPrimary),
      ('dispatchScrollEnd\nNotification', 'ScrollEnd\nNotification',
          'Sent when scrolling stops', _kIdle),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _kPrimary.withAlpha(20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(13)),
            ),
            child: const Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Method',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
                Expanded(
                    flex: 2,
                    child: Text('Notification',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
                Expanded(
                    flex: 3,
                    child: Text('When',
                        style: TextStyle(
                            color: _kAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
              ],
            ),
          ),
          ...notifs.map((n) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: _kPrimary.withAlpha(20))),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(n.$1,
                            style: TextStyle(
                                color: n.$4,
                                fontSize: 10,
                                fontFamily: 'monospace',
                                height: 1.3))),
                    Expanded(
                        flex: 2,
                        child: Text(n.$2,
                            style: TextStyle(
                                color: n.$4,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: 1.3))),
                    Expanded(
                        flex: 3,
                        child: Text(n.$3,
                            style: const TextStyle(
                                color: _kDim,
                                fontSize: 10,
                                height: 1.3))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Subclasses (Live comparisons)
// ═══════════════════════════════════════════════════════════════════════════
class _SubclassesTab extends StatefulWidget {
  const _SubclassesTab();

  @override
  State<_SubclassesTab> createState() => _SubclassesTabState();
}

class _SubclassesTabState extends State<_SubclassesTab> {
  int _selected = 0;

  static const _subclasses = [
    _SubclassInfo(
      name: 'IdleScrollActivity',
      color: _kIdle,
      icon: Icons.pause_circle,
      isScrolling: false,
      shouldIgnorePointer: false,
      velocity: '0.0',
      description:
          'The resting state. The scroll view is not moving and the user '
          'is not touching it. Created by goIdle(). Most of the time, a '
          'scroll position holds an IdleScrollActivity.',
      details: [
        'Created when: goIdle() called, after momentum decays, or after animation completes',
        'Pointer events: Allowed (shouldIgnorePointer = false)',
        'User can tap items, start a new drag, or trigger programmatic scroll',
        'This is the default initial activity for ScrollPositionWithSingleContext',
      ],
    ),
    _SubclassInfo(
      name: 'HoldScrollActivity',
      color: _kHold,
      icon: Icons.touch_app,
      isScrolling: false,
      shouldIgnorePointer: false,
      velocity: '0.0',
      description:
          'Created when the user puts a finger down on a scrollable that '
          'is currently idle or coasting. This is a brief transitional '
          'state: either the finger starts moving (→ Drag) or lifts (→ Idle).',
      details: [
        'Created when: User touches a scrollable (pointer down)',
        'Cancels any existing ballistic activity',
        'Holds a VoidCallback for onHoldCanceled',
        'Does NOT constitute scrolling (isScrolling = false)',
        'Transitions to DragScrollActivity or back to Idle',
      ],
    ),
    _SubclassInfo(
      name: 'DragScrollActivity',
      color: _kDrag,
      icon: Icons.swipe,
      isScrolling: true,
      shouldIgnorePointer: true,
      velocity: 'Δpixels/Δtime',
      description:
          'Active while the user is physically dragging the scroll view. '
          'Each pointer-move event triggers delegate.applyUserOffset(delta). '
          'When the finger lifts, goBallistic(velocity) is called.',
      details: [
        'Created when: Pointer moves after hold state',
        'Dispatches ScrollStartNotification, then ScrollUpdateNotification per frame',
        'shouldIgnorePointer = true (list items non-interactive during drag)',
        'Velocity is tracked via VelocityTracker',
        'On end: goBallistic(velocity) or goIdle() if v ≈ 0',
      ],
    ),
    _SubclassInfo(
      name: 'BallisticScrollActivity',
      color: _kBallistic,
      icon: Icons.trending_flat,
      isScrolling: true,
      shouldIgnorePointer: true,
      velocity: 'simulation.dx(t)',
      description:
          'Momentum scrolling after the user releases a drag. A Simulation '
          '(either ClampingScrollSimulation or BouncingScrollSimulation) '
          'drives position updates on each frame tick.',
      details: [
        'Created by: goBallistic(velocity) when v ≠ 0',
        'Uses Ticker to call delegate.setPixels(sim.x(t)) each frame',
        'Velocity decays over time based on ScrollPhysics',
        'Dispatches ScrollUpdateNotification per frame',
        'When simulation is done: goIdle()',
        'Can be interrupted by touch (→ Hold)',
      ],
    ),
    _SubclassInfo(
      name: 'DrivenScrollActivity',
      color: _kDriven,
      icon: Icons.animation,
      isScrolling: true,
      shouldIgnorePointer: true,
      velocity: 'controller.velocity',
      description:
          'Programmatic smooth scrolling via ScrollPosition.animateTo(). '
          'Uses an AnimationController internally, calling setPixels() each '
          'frame until the target offset is reached.',
      details: [
        'Created by: animateTo() or ensureVisible()',
        'Uses AnimationController (not a Simulation)',
        'You can specify duration and curve',
        'Returns a Future<void> that completes when done',
        'When done: goIdle()',
        'Can be interrupted by touch (→ Hold)',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final info = _subclasses[_selected];
    return Column(
      children: [
        // Selector bar
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: _kCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_subclasses.length, (i) {
              final s = _subclasses[i];
              final active = i == _selected;
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: active ? s.color.withAlpha(25) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: active ? s.color : Colors.transparent),
                  ),
                  child: Column(
                    children: [
                      Icon(s.icon,
                          size: 22,
                          color: active ? s.color : _kDim.withAlpha(60)),
                      const SizedBox(height: 2),
                      Text(s.name.replaceAll('ScrollActivity', ''),
                          style: TextStyle(
                              color: active ? s.color : _kDim.withAlpha(60),
                              fontSize: 8,
                              fontWeight: active
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),

        // Detail area
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              // Name + class badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: info.color.withAlpha(10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: info.color.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Icon(info.icon, color: info.color, size: 36),
                    const SizedBox(height: 8),
                    Text(info.name,
                        style: TextStyle(
                            color: info.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace')),
                    const SizedBox(height: 10),
                    Text(info.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: _kDim, fontSize: 12, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Property badges
              Row(
                children: [
                  _badge('isScrolling',
                      info.isScrolling ? 'true' : 'false',
                      info.isScrolling ? _kDrag : _kIdle),
                  const SizedBox(width: 8),
                  _badge('ignorePointer',
                      info.shouldIgnorePointer ? 'true' : 'false',
                      info.shouldIgnorePointer ? _kPrimary : _kBallistic),
                  const SizedBox(width: 8),
                  _badge('velocity', info.velocity, _kAccent),
                ],
              ),
              const SizedBox(height: 14),

              // Details list
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: info.color.withAlpha(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Key Facts',
                        style: TextStyle(
                            color: info.color,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...info.details.map((d) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.arrow_right,
                                  size: 14, color: info.color),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(d,
                                    style: const TextStyle(
                                        color: _kDim,
                                        fontSize: 11,
                                        height: 1.4)),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Live scroll demo for this subclass type
              _hdr('Live Scroll Demo'),
              const SizedBox(height: 10),
              _buildLiveDemo(info),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badge(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(40)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(color: _kDim, fontSize: 9)),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveDemo(_SubclassInfo info) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: info.color.withAlpha(50)),
      ),
      clipBehavior: Clip.antiAlias,
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) => false,
        child: ListView.builder(
          itemCount: 30,
          physics: info.name.contains('Bouncing')
              ? const BouncingScrollPhysics()
              : const ClampingScrollPhysics(),
          itemBuilder: (ctx, i) {
            final hue = (i * 12.0 + info.color.value) % 360;
            return Container(
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: HSLColor.fromAHSL(1, hue, 0.3, 0.18).toColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color:
                        HSLColor.fromAHSL(1, hue, 0.4, 0.3).toColor()),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('${info.name} item $i',
                  style: TextStyle(
                      color: HSLColor.fromAHSL(1, hue, 0.5, 0.65)
                          .toColor(),
                      fontSize: 12)),
            );
          },
        ),
      ),
    );
  }
}

class _SubclassInfo {
  final String name;
  final Color color;
  final IconData icon;
  final bool isScrolling;
  final bool shouldIgnorePointer;
  final String velocity;
  final String description;
  final List<String> details;

  const _SubclassInfo({
    required this.name,
    required this.color,
    required this.icon,
    required this.isScrolling,
    required this.shouldIgnorePointer,
    required this.velocity,
    required this.description,
    required this.details,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Lifecycle
// ═══════════════════════════════════════════════════════════════════════════
class _LifecycleTab extends StatefulWidget {
  const _LifecycleTab();

  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab> {
  int _step = 0;

  static const _steps = [
    _LifecycleStep(
      title: 'Activity Created',
      sub: 'new XxxScrollActivity(delegate)',
      icon: Icons.add_circle,
      color: _kBallistic,
      explanation:
          'A new ScrollActivity is instantiated with a delegate reference. '
          'The delegate is typically the ScrollPosition itself (which '
          'implements ScrollActivityDelegate).',
      notifications: [],
    ),
    _LifecycleStep(
      title: 'beginActivity(activity)',
      sub: 'ScrollPosition sets the new activity',
      icon: Icons.play_circle,
      color: _kDrag,
      explanation:
          'ScrollPosition.beginActivity() stores the new activity, disposes '
          'the old one, and resets scroll direction tracking. If the old '
          'activity was scrolling, a ScrollEndNotification is dispatched.',
      notifications: ['ScrollEndNotification (from old activity)'],
    ),
    _LifecycleStep(
      title: 'Activity Dispatches Start',
      sub: 'dispatchScrollStartNotification()',
      icon: Icons.notifications_active,
      color: _kHold,
      explanation:
          'The new activity dispatches a ScrollStartNotification up the widget '
          'tree. NotificationListener<ScrollNotification> ancestors can '
          'react (e.g. show scroll indicators, hide floating buttons).',
      notifications: ['ScrollStartNotification'],
    ),
    _LifecycleStep(
      title: 'Activity Performs Work',
      sub: 'setPixels(), applyUserOffset(), etc.',
      icon: Icons.engineering,
      color: _kPrimary,
      explanation:
          'For drag: applyUserOffset(delta) each pointer move.\n'
          'For ballistic: tick → simulation.x(t) → setPixels().\n'
          'For driven: animation tick → setPixels().\n'
          'Each setPixels() dispatches ScrollUpdateNotification.',
      notifications: ['ScrollUpdateNotification (per frame)'],
    ),
    _LifecycleStep(
      title: 'applyNewDimensions()',
      sub: 'Called if scroll view metrics change mid-activity',
      icon: Icons.fit_screen,
      color: _kDriven,
      explanation:
          'If the scroll view is resized during the activity (e.g. keyboard '
          'appears), applyNewDimensions() is called. The activity can adjust '
          'its behavior. BallisticScrollActivity restarts its simulation.',
      notifications: [],
    ),
    _LifecycleStep(
      title: 'Activity Ends',
      sub: 'goIdle() or goBallistic(velocity)',
      icon: Icons.stop_circle,
      color: _kIdle,
      explanation:
          'The activity signals the delegate to transition to the next state. '
          'goIdle() → idle, goBallistic(v) → momentum. The delegate calls '
          'beginActivity() with the new activity, and this activity is disposed.',
      notifications: ['ScrollEndNotification'],
    ),
    _LifecycleStep(
      title: 'dispose()',
      sub: 'Clean up resources',
      icon: Icons.delete_outline,
      color: _kDim,
      explanation:
          'Tickers are disposed, animation controllers stopped. The delegate '
          'reference is nulled. The activity should not be used after dispose().',
      notifications: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_step];
    return Column(
      children: [
        // Step counter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          color: _kCard,
          child: Row(
            children: [
              Text('Step ${_step + 1} of ${_steps.length}',
                  style: const TextStyle(
                      color: _kDim, fontSize: 12, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                onPressed: _step > 0
                    ? () => setState(() => _step--)
                    : null,
                icon: Icon(Icons.chevron_left,
                    color: _step > 0 ? _kAccent : _kDim.withAlpha(40)),
                iconSize: 28,
              ),
              IconButton(
                onPressed: _step < _steps.length - 1
                    ? () => setState(() => _step++)
                    : null,
                icon: Icon(Icons.chevron_right,
                    color: _step < _steps.length - 1
                        ? _kAccent
                        : _kDim.withAlpha(40)),
                iconSize: 28,
              ),
            ],
          ),
        ),

        // Step indicator dots
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_steps.length, (i) {
              final s = _steps[i];
              final active = i == _step;
              return Container(
                width: active ? 24 : 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: active ? s.color : s.color.withAlpha(30),
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),
        ),

        // Step detail
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: step.color.withAlpha(10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: step.color.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    Icon(step.icon, color: step.color, size: 40),
                    const SizedBox(height: 12),
                    Text(step.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: step.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(step.sub,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: step.color.withAlpha(180),
                            fontSize: 11,
                            fontFamily: 'monospace')),
                    const SizedBox(height: 16),
                    Text(step.explanation,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: _kDim, fontSize: 12, height: 1.5)),
                  ],
                ),
              ),
              if (step.notifications.isNotEmpty) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kAccent.withAlpha(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.notifications,
                              color: _kAccent, size: 16),
                          SizedBox(width: 6),
                          Text('Notifications Dispatched',
                              style: TextStyle(
                                  color: _kAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...step.notifications.map((n) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right,
                                    size: 14, color: step.color),
                                const SizedBox(width: 4),
                                Text(n,
                                    style: TextStyle(
                                        color: step.color,
                                        fontSize: 11,
                                        fontFamily: 'monospace')),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),

              // Position in visual pipeline
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kPrimary.withAlpha(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Activity Pipeline',
                        style: TextStyle(
                            color: _kBright,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ..._buildPipelineSteps(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPipelineSteps() {
    const labels = [
      'Create',
      'beginActivity',
      'Start notif',
      'Work loop',
      'Dimensions',
      'End signal',
      'Dispose',
    ];
    return List.generate(labels.length, (i) {
      final active = i == _step;
      final done = i < _step;
      final color = active
          ? _steps[i].color
          : done
              ? _kAccent.withAlpha(80)
              : _kDim.withAlpha(30);
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: active ? color.withAlpha(30) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: active ? 2 : 1),
              ),
              child: done
                  ? Icon(Icons.check, size: 12, color: color)
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: active ? 3 : 1,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(labels[i],
                style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      );
    });
  }
}

class _LifecycleStep {
  final String title;
  final String sub;
  final IconData icon;
  final Color color;
  final String explanation;
  final List<String> notifications;

  const _LifecycleStep({
    required this.title,
    required this.sub,
    required this.icon,
    required this.color,
    required this.explanation,
    required this.notifications,
  });
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

Widget _propcard(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
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
                  Text(name,
                      style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(type,
                        style: TextStyle(
                            color: color,
                            fontSize: 10,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
              const SizedBox(height: 4),
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
