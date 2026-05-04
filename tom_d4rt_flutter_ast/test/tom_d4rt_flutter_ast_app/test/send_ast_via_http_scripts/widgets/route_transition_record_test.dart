// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Route Transition Record — Deep Demo (live concrete subclass edition)
//
// This harness file is a pedagogical exploration of Flutter's
// `RouteTransitionRecord`, the abstract hand-off object that Flutter's
// `Navigator` passes to a `TransitionDelegate` when `Navigator.pages`
// changes. A `RouteTransitionRecord` wraps a single `Route<dynamic>` and
// exposes the methods that a custom delegate uses to decide how that route
// should enter or leave the navigation stack: push with animation, silently
// add, complete, remove without animation, or pop with a result.
//
// Unlike the previous version of this demo, which sidestepped the
// abstractness of `RouteTransitionRecord` by mirroring its API on a
// dataclass, this revision declares a real concrete subclass
// `_DemoRouteTransitionRecord extends RouteTransitionRecord` that overrides
// every abstract member with shape-faithful stubs. Live instances of that
// subclass — typed as `RouteTransitionRecord` — are then exercised across
// many UI sections to demonstrate the decision lifecycle.
//
// Two subclasses participate:
//
//   _DemoRouteTransitionRecord
//       The primary concrete implementation. Stores a real `Route<dynamic>`
//       (a `PageRouteBuilder<void>`), tracks the latest decision, the result
//       value passed to `markForPop` / `markForComplete`, and any conflict
//       notes (calls made after a record was already decided).
//
//   _LoggingRouteTransitionRecord
//       A second concrete implementation showing polymorphism. It records a
//       call log of every method invocation. We treat both as
//       `RouteTransitionRecord` and store them together in
//       `List<RouteTransitionRecord>` to make the abstract type's
//       polymorphic identity visible in compiled code.
//
// Notes on the file shape:
//
//   - The harness top-level entrypoint is `dynamic build(BuildContext)`.
//   - All visuals are pure Material widgets — no platform channels or I/O.
//   - Platform-aware accents come from `Theme.of(context).platform`.
//   - Palette: indigo primary, sunset orange action, mint accent, soft tints.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kIndigo = Color(0xFF3F51B5);
const Color _kIndigoDark = Color(0xFF283593);
const Color _kIndigoSoft = Color(0xFFE8EAF6);
const Color _kSunset = Color(0xFFFF7043);
const Color _kSunsetDeep = Color(0xFFE64A19);
const Color _kSunsetSoft = Color(0xFFFFE0D4);
const Color _kMint = Color(0xFF26A69A);
const Color _kMintDeep = Color(0xFF00796B);
const Color _kMintSoft = Color(0xFFD5F2EE);
const Color _kInk = Color(0xFF1A1A2E);
const Color _kInkMuted = Color(0xFF4A4A6A);
const Color _kSurface = Color(0xFFFBFBFE);
const Color _kBorder = Color(0xFFDADAE8);
const Color _kCodeBg = Color(0xFF1B1B2E);
const Color _kCodeFg = Color(0xFFE0E0F0);
const Color _kWarn = Color(0xFFFBC02D);
const Color _kDanger = Color(0xFFC62828);
const Color _kPlum = Color(0xFF6A1B9A);
const Color _kPlumSoft = Color(0xFFEDE3F4);

// ---------------------------------------------------------------------------
// Live concrete subclass of RouteTransitionRecord
// ---------------------------------------------------------------------------

/// A concrete subclass of the abstract `RouteTransitionRecord`.
///
/// Constructing one is cheap because `PageRouteBuilder` is a fully fledged
/// concrete `Route<T>` that does not require a live `Navigator` to *exist* —
/// only to *attach*. This makes it perfectly fine for a demo that never
/// pushes the route, only references the wrapped `Route<dynamic>`.
class _DemoRouteTransitionRecord extends RouteTransitionRecord {
  _DemoRouteTransitionRecord({
    required this.label,
    required bool waitingEntering,
    required bool waitingExiting,
  })  : _waitingEntering = waitingEntering,
        _waitingExiting = waitingExiting,
        _route = PageRouteBuilder<void>(
          settings: RouteSettings(name: label),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return const SizedBox.shrink();
          },
        );

  /// A short, human-readable name. Mirrors `route.settings.name`.
  final String label;

  /// The wrapped `Route<dynamic>`. Real, instantiated, valid.
  final PageRouteBuilder<void> _route;

  bool _waitingEntering;
  bool _waitingExiting;

  String? _decision;
  Object? _result;
  String? _conflictNote;
  final List<String> _callLog = <String>[];

  @override
  Route<dynamic> get route => _route;

  @override
  bool get isWaitingForEnteringDecision => _waitingEntering;

  @override
  bool get isWaitingForExitingDecision => _waitingExiting;

  String? get decision => _decision;
  Object? get result => _result;
  String? get conflictNote => _conflictNote;
  List<String> get callLog => List<String>.unmodifiable(_callLog);

  bool get isDecided => _decision != null;
  bool get isPending => _decision == null;

  @override
  void markForPush() {
    _callLog.add('markForPush()');
    if (_decision != null) {
      _conflictNote = 'markForPush() called after $_decision';
      return;
    }
    _decision = 'push';
    _waitingEntering = false;
  }

  @override
  void markForAdd() {
    _callLog.add('markForAdd()');
    if (_decision != null) {
      _conflictNote = 'markForAdd() called after $_decision';
      return;
    }
    _decision = 'add';
    _waitingEntering = false;
  }

  @override
  void markForPop([dynamic result]) {
    _callLog.add('markForPop($result)');
    if (_decision != null) {
      _conflictNote = 'markForPop() called after $_decision';
      return;
    }
    _decision = 'pop';
    _result = result;
    _waitingExiting = false;
  }

  @override
  void markForComplete([dynamic result]) {
    _callLog.add('markForComplete($result)');
    if (_decision != null) {
      _conflictNote = 'markForComplete() called after $_decision';
      return;
    }
    _decision = 'complete';
    _result = result;
    _waitingExiting = false;
  }

  @override
  void markForRemove() {
    _callLog.add('markForRemove()');
    if (_decision != null) {
      _conflictNote = 'markForRemove() called after $_decision';
      return;
    }
    _decision = 'remove';
    _waitingExiting = false;
  }

  void resetTo({required bool entering, required bool exiting}) {
    _decision = null;
    _result = null;
    _conflictNote = null;
    _callLog.clear();
    _waitingEntering = entering;
    _waitingExiting = exiting;
  }

  /// Six-stage lifecycle slug used by the timeline hero.
  String get stage {
    if (_decision == null) {
      if (_waitingEntering) {
        return 'waitingEnterDecision';
      }
      if (_waitingExiting) {
        return 'waitingExitDecision';
      }
      return 'installed';
    }
    switch (_decision) {
      case 'push':
      case 'add':
        return 'transitioning';
      case 'pop':
        return 'waitingExitDecision';
      case 'complete':
        return 'complete';
      case 'remove':
        return 'disposed';
    }
    return 'installed';
  }
}

/// A second concrete subclass that just logs every call. Used to demonstrate
/// polymorphism — a `List<RouteTransitionRecord>` can hold both subclasses.
class _LoggingRouteTransitionRecord extends RouteTransitionRecord {
  _LoggingRouteTransitionRecord(this._name)
      : _route = PageRouteBuilder<void>(
          settings: RouteSettings(name: _name),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return const SizedBox.shrink();
          },
        );

  final String _name;
  final PageRouteBuilder<void> _route;
  final List<String> log = <String>[];

  String get name => _name;

  @override
  Route<dynamic> get route => _route;

  @override
  bool get isWaitingForEnteringDecision => log.isEmpty;

  @override
  bool get isWaitingForExitingDecision => log.isEmpty;

  @override
  void markForPush() => log.add('push');
  @override
  void markForAdd() => log.add('add');
  @override
  void markForPop([dynamic result]) => log.add('pop($result)');
  @override
  void markForComplete([dynamic result]) => log.add('complete($result)');
  @override
  void markForRemove() => log.add('remove');
}

// ---------------------------------------------------------------------------
// Harness entry
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RouteTransitionRecord — Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kIndigo,
        primary: _kIndigo,
        secondary: _kSunset,
        tertiary: _kMint,
        surface: _kSurface,
      ),
      scaffoldBackgroundColor: _kSurface,
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      useMaterial3: true,
    ),
    home: const RouteTransitionStagingDemo(),
  );
}

// ---------------------------------------------------------------------------
// Timeline stage descriptor
// ---------------------------------------------------------------------------

class _TimelineStage {
  const _TimelineStage({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.glow,
  });

  final String id;
  final String label;
  final String description;
  final IconData icon;
  final Color glow;
}

const List<_TimelineStage> _kTimelineStages = <_TimelineStage>[
  _TimelineStage(
    id: 'installed',
    label: 'installed',
    description: 'record created, no decision',
    icon: Icons.inventory_2_outlined,
    glow: _kIndigo,
  ),
  _TimelineStage(
    id: 'waitingEnterDecision',
    label: 'waitingEnter',
    description: 'new route, awaiting delegate',
    icon: Icons.login_rounded,
    glow: _kSunset,
  ),
  _TimelineStage(
    id: 'transitioning',
    label: 'transitioning',
    description: 'push/add animation running',
    icon: Icons.animation,
    glow: _kIndigoDark,
  ),
  _TimelineStage(
    id: 'complete',
    label: 'complete',
    description: 'route finished normally',
    icon: Icons.check_circle_outline,
    glow: _kMint,
  ),
  _TimelineStage(
    id: 'waitingExitDecision',
    label: 'waitingExit',
    description: 'exiting route, awaiting delegate',
    icon: Icons.logout_rounded,
    glow: _kSunsetDeep,
  ),
  _TimelineStage(
    id: 'disposed',
    label: 'disposed',
    description: 'removed, route torn down',
    icon: Icons.delete_sweep_outlined,
    glow: _kInkMuted,
  ),
];

// ---------------------------------------------------------------------------
// Scenario descriptor
// ---------------------------------------------------------------------------

class _Scenario {
  const _Scenario({
    required this.title,
    required this.subtitle,
    required this.method,
    required this.icon,
    required this.accent,
    required this.snippet,
  });

  final String title;
  final String subtitle;
  final String method;
  final IconData icon;
  final Color accent;
  final String snippet;
}

const List<_Scenario> _kScenarios = <_Scenario>[
  _Scenario(
    title: 'Standard push',
    subtitle: 'Run the normal enter transition.\nUsed for brand-new pages.',
    method: 'markForPush()',
    icon: Icons.arrow_upward_rounded,
    accent: _kIndigo,
    snippet: 'entering.markForPush();',
  ),
  _Scenario(
    title: 'Silent add',
    subtitle: 'Insert without animation.\nUseful during restoration.',
    method: 'markForAdd()',
    icon: Icons.add_box_outlined,
    accent: _kInkMuted,
    snippet: 'entering.markForAdd();',
  ),
  _Scenario(
    title: 'Pop with result',
    subtitle: 'Exit animation then deliver\na result to the popped future.',
    method: 'markForPop(result)',
    icon: Icons.arrow_downward_rounded,
    accent: _kSunset,
    snippet: "exiting.markForPop('saved');",
  ),
  _Scenario(
    title: 'Remove silently',
    subtitle: 'Pull the route out of the stack\nwith no exit animation.',
    method: 'markForRemove()',
    icon: Icons.close_rounded,
    accent: _kDanger,
    snippet: 'exiting.markForRemove();',
  ),
  _Scenario(
    title: 'Complete with value',
    subtitle: 'The route finishes normally\nand signals its Future.',
    method: 'markForComplete(v)',
    icon: Icons.check_rounded,
    accent: _kMint,
    snippet: 'exiting.markForComplete(42);',
  ),
  _Scenario(
    title: 'Conflicting decision',
    subtitle: 'Calling two markFor* on one\nrecord is a programmer error.',
    method: 'DO NOT',
    icon: Icons.warning_amber_rounded,
    accent: _kWarn,
    snippet: 'r.markForPush();\nr.markForAdd(); // throws',
  ),
];

// ---------------------------------------------------------------------------
// Main demo widget
// ---------------------------------------------------------------------------

class RouteTransitionStagingDemo extends StatefulWidget {
  const RouteTransitionStagingDemo({super.key});

  @override
  State<RouteTransitionStagingDemo> createState() =>
      _RouteTransitionStagingDemoState();
}

class _RouteTransitionStagingDemoState
    extends State<RouteTransitionStagingDemo> {
  // Live records, typed as the abstract base class to drive the point home.
  late final List<RouteTransitionRecord> _records;

  // The same list, but as the concrete subclass so we can read internal
  // state (decision, result, conflict notes) for the UI. This is a deliberate
  // pedagogical pattern — in real code the framework holds the abstract list
  // and the delegate just calls markFor*.
  late final List<_DemoRouteTransitionRecord> _concreteRecords;

  // A second polymorphic flavour, used in the polymorphism panel to prove
  // that the abstract base type really is abstract.
  late final List<RouteTransitionRecord> _loggingRecords;

  int _focusedIndex = 0;
  int _turns = 0;

  @override
  void initState() {
    super.initState();
    _concreteRecords = <_DemoRouteTransitionRecord>[
      _DemoRouteTransitionRecord(
        label: '/articles',
        waitingEntering: true,
        waitingExiting: false,
      ),
      _DemoRouteTransitionRecord(
        label: '/settings',
        waitingEntering: false,
        waitingExiting: true,
      ),
      _DemoRouteTransitionRecord(
        label: '/help',
        waitingEntering: true,
        waitingExiting: false,
      ),
      _DemoRouteTransitionRecord(
        label: '/about',
        waitingEntering: false,
        waitingExiting: true,
      ),
    ];
    _records = List<RouteTransitionRecord>.from(_concreteRecords);
    _loggingRecords = <RouteTransitionRecord>[
      _LoggingRouteTransitionRecord('/diagnostics'),
      _LoggingRouteTransitionRecord('/inbox'),
      _LoggingRouteTransitionRecord('/profile'),
    ];
  }

  void _apply(int index, String action) {
    final RouteTransitionRecord record = _records[index];
    setState(() {
      switch (action) {
        case 'push':
          record.markForPush();
          break;
        case 'add':
          record.markForAdd();
          break;
        case 'complete':
          record.markForComplete('ok@$_turns');
          break;
        case 'remove':
          record.markForRemove();
          break;
        case 'pop':
          record.markForPop('result@$_turns');
          break;
      }
      _focusedIndex = index;
      _turns += 1;
    });
    final concrete = _concreteRecords[index];
    debugPrint(
      '[RouteTransitionStagingDemo] ${concrete.label} -> $action '
      '(decision=${concrete.decision})',
    );
  }

  void _resetAll() {
    setState(() {
      for (var i = 0; i < _concreteRecords.length; i++) {
        final isEntering = i.isEven;
        _concreteRecords[i].resetTo(
          entering: isEntering,
          exiting: !isEntering,
        );
      }
      _focusedIndex = 0;
      _turns = 0;
    });
    debugPrint('[RouteTransitionStagingDemo] reset all');
  }

  void _runDelegateOverEverything() {
    setState(() {
      // Simulate a TransitionDelegate.resolve pass over every undecided record.
      for (final _DemoRouteTransitionRecord r in _concreteRecords) {
        if (r.isWaitingForEnteringDecision && r.isPending) {
          r.markForPush();
        } else if (r.isWaitingForExitingDecision && r.isPending) {
          r.markForComplete('auto');
        }
      }
      _turns += 1;
    });
    debugPrint('[RouteTransitionStagingDemo] auto-resolve pass complete');
  }

  Color _platformAccent(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS ||
        platform == TargetPlatform.macOS) {
      return _kPlum;
    }
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia) {
      return _kMintDeep;
    }
    return _kIndigoDark;
  }

  String _platformLabel(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) return 'iOS';
    if (platform == TargetPlatform.macOS) return 'macOS';
    if (platform == TargetPlatform.android) return 'Android';
    if (platform == TargetPlatform.fuchsia) return 'Fuchsia';
    if (platform == TargetPlatform.linux) return 'Linux';
    return 'Windows';
  }

  @override
  Widget build(BuildContext context) {
    final _DemoRouteTransitionRecord focused = _concreteRecords[_focusedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kIndigo,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RouteTransitionRecord — Deep Demo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Auto resolve',
            onPressed: _runDelegateOverEverything,
            icon: const Icon(Icons.auto_fix_high_rounded),
          ),
          IconButton(
            tooltip: 'Reset records',
            onPressed: _resetAll,
            icon: const Icon(Icons.restart_alt_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeadline(context),
                    const SizedBox(height: 20),
                    _buildLiveSurfacePanel(context),
                    const SizedBox(height: 24),
                    _buildTimelineHero(focused),
                    const SizedBox(height: 24),
                    _buildDecisionPlayground(),
                    const SizedBox(height: 24),
                    _buildSequenceDiagram(),
                    const SizedBox(height: 24),
                    _buildScenarioWrap(),
                    const SizedBox(height: 24),
                    _buildPolymorphismPanel(),
                    const SizedBox(height: 24),
                    _buildCallLogPanel(focused),
                    const SizedBox(height: 24),
                    _buildTeachingPanel(),
                    const SizedBox(height: 24),
                    _buildFooter(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Headline
  // -------------------------------------------------------------------------

  Widget _buildHeadline(BuildContext context) {
    final Color accent = _platformAccent(context);
    final String platform = _platformLabel(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kIndigo, _kIndigoDark],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIndigo.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.alt_route_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'RouteTransitionRecord',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'The hand-off object between Navigator.pages and a '
                  'TransitionDelegate. A record carries one pending '
                  'decision per route.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _kSunset.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'turns: $_turns',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'platform: $platform',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Live API Surface — uses concrete subclass live & shows runtimeType
  // -------------------------------------------------------------------------

  Widget _buildLiveSurfacePanel(BuildContext context) {
    // Locally instantiate fresh records typed as the abstract base.
    final RouteTransitionRecord exampleEnter = _DemoRouteTransitionRecord(
      label: '/example/enter',
      waitingEntering: true,
      waitingExiting: false,
    );
    final RouteTransitionRecord exampleExit = _DemoRouteTransitionRecord(
      label: '/example/exit',
      waitingEntering: false,
      waitingExiting: true,
    );

    // Exercise them right here in compiled code.
    exampleEnter.markForPush();
    exampleExit.markForPop('demo-result');

    final List<RouteTransitionRecord> bothTypes = <RouteTransitionRecord>[
      exampleEnter,
      exampleExit,
      _LoggingRouteTransitionRecord('/example/log'),
    ];

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.api_rounded, color: _kPlum, size: 22),
                SizedBox(width: 8),
                Text(
                  'Live API surface',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'These rows show real concrete subclasses of the abstract '
              'RouteTransitionRecord, instantiated live during build() and '
              'exercised via their markFor* methods.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: _kPlumSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPlum.withValues(alpha: 0.3)),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < bothTypes.length; i++)
                    _buildSurfaceRow(bothTypes[i], i == bothTypes.length - 1),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildRuntimeFacts(bothTypes),
          ],
        ),
      ),
    );
  }

  Widget _buildSurfaceRow(RouteTransitionRecord record, bool isLast) {
    final String routeName = record.route.settings.name ?? '<unnamed>';
    final bool waitingEnter = record.isWaitingForEnteringDecision;
    final bool waitingExit = record.isWaitingForExitingDecision;
    // D4rt workaround: runtimeType.toString() on user-defined interpreted
    // classes triggers "no static method 'toString'". Use a manual label.
    final String runtime = record is _DemoRouteTransitionRecord
        ? '_DemoRouteTransitionRecord'
        : 'RouteTransitionRecord';
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPlum.withValues(alpha: 0.4)),
            ),
            child: const Icon(Icons.route_rounded,
                color: _kPlum, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  routeName,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'runtimeType: $runtime',
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'isWaitingForEnteringDecision: $waitingEnter   '
                  'isWaitingForExitingDecision: $waitingExit',
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 10,
                    height: 1.4,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuntimeFacts(List<RouteTransitionRecord> all) {
    // Verify polymorphic behaviour right here.
    final int demoCount =
        all.whereType<_DemoRouteTransitionRecord>().length;
    final int loggingCount =
        all.whereType<_LoggingRouteTransitionRecord>().length;
    final int total = all.length;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kIndigoSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kIndigo.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.fact_check_outlined,
              color: _kIndigoDark, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'List<RouteTransitionRecord> length=$total   '
              '_DemoRouteTransitionRecord=$demoCount   '
              '_LoggingRouteTransitionRecord=$loggingCount',
              style: const TextStyle(
                color: _kInk,
                fontSize: 11,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Timeline hero
  // -------------------------------------------------------------------------

  Widget _buildTimelineHero(_DemoRouteTransitionRecord focused) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.timeline_rounded,
                  size: 22,
                  color: _kIndigoDark,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Lifecycle timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const Spacer(),
                _buildFocusChip(focused),
              ],
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                final List<_TimelineStage> stages = _kTimelineStages;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: c.maxWidth),
                    child: Row(
                      children: <Widget>[
                        for (int i = 0; i < stages.length; i++) ...<Widget>[
                          _buildTimelineStage(
                            stages[i],
                            active: stages[i].id == focused.stage,
                          ),
                          if (i != stages.length - 1)
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 36,
                                left: 4,
                                right: 4,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: _kBorder,
                                size: 22,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            _buildStageExplainer(focused),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusChip(_DemoRouteTransitionRecord focused) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kMintSoft,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kMint.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.center_focus_strong_rounded,
              size: 14, color: _kMintDeep),
          const SizedBox(width: 6),
          Text(
            'focus: ${focused.label}',
            style: const TextStyle(
              color: _kMintDeep,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStage(_TimelineStage stage, {required bool active}) {
    final Color fill = active ? stage.glow : Colors.white;
    final Color border = active ? stage.glow : _kBorder;
    final Color icon = active ? Colors.white : stage.glow;
    final Color text = active ? Colors.white : _kInk;
    final Color subtitle =
        active ? Colors.white.withValues(alpha: 0.85) : _kInkMuted;
    return Container(
      width: 132,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: active ? 2 : 1),
        boxShadow: active
            ? <BoxShadow>[
                BoxShadow(
                  color: stage.glow.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: active
                  ? Colors.white.withValues(alpha: 0.2)
                  : stage.glow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stage.icon, size: 20, color: icon),
          ),
          const SizedBox(height: 8),
          Text(
            stage.label,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            stage.description,
            style: TextStyle(
              color: subtitle,
              fontSize: 10,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStageExplainer(_DemoRouteTransitionRecord focused) {
    final String label;
    final String explain;
    switch (focused.stage) {
      case 'installed':
        label = 'installed';
        explain =
            'Record exists. No enter/exit flag set — Navigator is idle for this route.';
        break;
      case 'waitingEnterDecision':
        label = 'waiting for enter decision';
        explain =
            'isWaitingForEnteringDecision is true. Delegate must call markForPush() or markForAdd().';
        break;
      case 'transitioning':
        label = 'transitioning';
        explain =
            'Decision made (${focused.decision}). Animation or silent insert is in progress.';
        break;
      case 'complete':
        label = 'complete';
        explain =
            "markForComplete() fired. Route's future resolves with ${focused.result ?? 'no result'}.";
        break;
      case 'waitingExitDecision':
        label = 'waiting for exit decision';
        explain = focused.decision == 'pop'
            ? 'markForPop() fired — exit animation will run and future resolves with ${focused.result ?? 'no result'}.'
            : 'isWaitingForExitingDecision is true. Delegate must call markForComplete / markForRemove / markForPop.';
        break;
      case 'disposed':
      default:
        label = 'disposed';
        explain =
            'Record is gone. markForRemove() took it out without animation.';
        break;
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kIndigoSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kIndigo.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.info_outline_rounded,
              size: 18, color: _kIndigoDark),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  height: 1.4,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _kIndigoDark,
                    ),
                  ),
                  TextSpan(text: explain),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Decision playground
  // -------------------------------------------------------------------------

  Widget _buildDecisionPlayground() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.tune_rounded, color: _kSunsetDeep, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Decision playground',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _resetAll,
                  icon: const Icon(Icons.refresh_rounded, size: 16),
                  label: const Text('reset records'),
                  style: TextButton.styleFrom(
                    foregroundColor: _kIndigoDark,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Each row holds a real RouteTransitionRecord (a concrete '
              '_DemoRouteTransitionRecord). Tap a decision button to call '
              'the corresponding markFor* method on that live instance.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                final bool twoCol = c.maxWidth > 720;
                final List<Widget> cards = <Widget>[
                  for (int i = 0; i < _concreteRecords.length; i++)
                    _buildDecisionCard(i, _concreteRecords[i]),
                ];
                if (!twoCol) {
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < cards.length; i++) ...<Widget>[
                        cards[i],
                        if (i != cards.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  );
                }
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    for (final Widget card in cards)
                      SizedBox(
                        width: (c.maxWidth - 12) / 2,
                        child: card,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecisionCard(int index, _DemoRouteTransitionRecord record) {
    final bool focused = index == _focusedIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: focused ? _kIndigoSoft : _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: focused ? _kIndigo : _kBorder,
          width: focused ? 1.6 : 1,
        ),
        boxShadow: focused
            ? <BoxShadow>[
                BoxShadow(
                  color: _kIndigo.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBorder),
                ),
                child: const Icon(Icons.route_rounded,
                    color: _kIndigoDark, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      record.label,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'stage: ${record.stage}',
                      style: const TextStyle(
                        color: _kInkMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: record.isDecided
                    ? const Icon(
                        Icons.check_circle_rounded,
                        key: ValueKey<String>('tick'),
                        color: _kMintDeep,
                        size: 22,
                      )
                    : const SizedBox(
                        key: ValueKey<String>('empty'),
                        width: 22,
                        height: 22,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              _badge(
                active: record.isWaitingForEnteringDecision,
                label: 'is-entering',
                color: _kSunset,
              ),
              _badge(
                active: record.isWaitingForExitingDecision,
                label: 'is-exiting',
                color: _kSunsetDeep,
              ),
              _badge(
                active: record.isDecided,
                label: record.isDecided
                    ? 'decided: ${record.decision}'
                    : 'pending ...',
                color: record.isDecided ? _kMintDeep : _kInkMuted,
              ),
              if (record.result != null)
                _badge(
                  active: true,
                  label: 'result: ${record.result}',
                  color: _kIndigoDark,
                ),
              if (record.conflictNote != null)
                _badge(
                  active: true,
                  label: record.conflictNote!,
                  color: _kDanger,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              _buildDecisionButton(
                label: 'Push',
                icon: Icons.arrow_upward_rounded,
                color: _kIndigo,
                enabled: record.isPending,
                onTap: () => _apply(index, 'push'),
              ),
              _buildDecisionButton(
                label: 'Add',
                icon: Icons.add_rounded,
                color: _kInkMuted,
                enabled: record.isPending,
                onTap: () => _apply(index, 'add'),
              ),
              _buildDecisionButton(
                label: 'Complete',
                icon: Icons.check_rounded,
                color: _kMintDeep,
                enabled: record.isPending,
                onTap: () => _apply(index, 'complete'),
              ),
              _buildDecisionButton(
                label: 'Remove',
                icon: Icons.close_rounded,
                color: _kDanger,
                enabled: record.isPending,
                onTap: () => _apply(index, 'remove'),
              ),
              _buildDecisionButton(
                label: 'Pop',
                icon: Icons.arrow_downward_rounded,
                color: _kSunsetDeep,
                enabled: record.isPending,
                onTap: () => _apply(index, 'pop'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    final Color fg = enabled ? color : _kInkMuted;
    final Color bg = enabled
        ? color.withValues(alpha: 0.12)
        : _kBorder.withValues(alpha: 0.4);
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge({
    required bool active,
    required String label,
    required Color color,
  }) {
    final Color fg = active ? Colors.white : color;
    final Color bg = active ? color : color.withValues(alpha: 0.12);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: active ? color : color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Sequence diagram
  // -------------------------------------------------------------------------

  Widget _buildSequenceDiagram() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.account_tree_rounded,
                    color: _kMintDeep, size: 22),
                SizedBox(width: 8),
                Text(
                  'TransitionDelegate sequence',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'How the Navigator talks to your custom TransitionDelegate when '
              'Navigator.pages changes.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _diagramBox(
                    title: 'Navigator.pages',
                    subtitle: 'list changed',
                    icon: Icons.list_alt_rounded,
                    color: _kIndigo,
                  ),
                  _diagramArrow(),
                  _diagramBox(
                    title: 'build records',
                    subtitle: 'wraps each Route',
                    icon: Icons.build_circle_outlined,
                    color: _kIndigoDark,
                  ),
                  _diagramArrow(),
                  _diagramBox(
                    title: 'delegate.resolve',
                    subtitle: 'receives records',
                    icon: Icons.engineering_rounded,
                    color: _kSunsetDeep,
                  ),
                  _diagramArrow(),
                  _diagramBox(
                    title: 'markFor* per record',
                    subtitle: 'push / add / pop / ...',
                    icon: Icons.touch_app_rounded,
                    color: _kSunset,
                  ),
                  _diagramArrow(),
                  _diagramBox(
                    title: 'ordered result',
                    subtitle: 'returned to Navigator',
                    icon: Icons.sort_rounded,
                    color: _kMintDeep,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kSunsetSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kSunset.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.lightbulb_outline_rounded,
                      color: _kSunsetDeep, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Side note — ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _kSunsetDeep,
                            ),
                          ),
                          TextSpan(
                            text:
                                'custom delegates can override this ordering '
                                'to stagger animations or group them; the '
                                'default delegate simply pushes entries one '
                                'after another.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _diagramBox({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: _kInkMuted,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _diagramArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Icon(
        Icons.arrow_forward_rounded,
        color: _kInkMuted,
        size: 22,
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Scenario wrap
  // -------------------------------------------------------------------------

  Widget _buildScenarioWrap() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.view_week_rounded, color: _kIndigo, size: 22),
                SizedBox(width: 8),
                Text(
                  'Six transition scenarios',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Each card maps to one markFor* method, with a tiny snippet '
              'showing the call site.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                final double targetWidth;
                if (c.maxWidth > 980) {
                  targetWidth = (c.maxWidth - 24) / 3;
                } else if (c.maxWidth > 620) {
                  targetWidth = (c.maxWidth - 12) / 2;
                } else {
                  targetWidth = c.maxWidth;
                }
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    for (final _Scenario s in _kScenarios)
                      SizedBox(
                        width: targetWidth,
                        child: _buildScenarioCard(s),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(_Scenario scenario) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scenario.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: scenario.accent.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(scenario.icon, color: scenario.accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      scenario.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      scenario.method,
                      style: TextStyle(
                        fontSize: 11,
                        color: scenario.accent,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            scenario.subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: _kInkMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              scenario.snippet,
              style: const TextStyle(
                color: _kCodeFg,
                fontSize: 11,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Polymorphism panel — exercises the abstract base type with two
  // concrete subclasses, side by side.
  // -------------------------------------------------------------------------

  Widget _buildPolymorphismPanel() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.merge_type_rounded, color: _kPlum, size: 22),
                SizedBox(width: 8),
                Text(
                  'Polymorphism panel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'A List<RouteTransitionRecord> can hold any concrete subclass. '
              'Below, both _DemoRouteTransitionRecord and '
              '_LoggingRouteTransitionRecord are accessed through the abstract '
              'base type.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),
            for (int i = 0; i < _loggingRecords.length; i++)
              _polymorphismRow(_loggingRecords[i], i),
          ],
        ),
      ),
    );
  }

  Widget _polymorphismRow(RouteTransitionRecord record, int index) {
    // Drive the abstract API on whatever concrete class this happens to be.
    final String routeName = record.route.settings.name ?? '<unnamed>';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kPlumSoft,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kPlum.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kPlum.withValues(alpha: 0.4)),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: _kPlum,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    routeName,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'runtimeType: ${record.runtimeType}',
                    style: const TextStyle(
                      color: _kInkMuted,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  record.markForPush();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _kPlum,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('markForPush'),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Call log panel — shows the live call log of the focused record.
  // -------------------------------------------------------------------------

  Widget _buildCallLogPanel(_DemoRouteTransitionRecord focused) {
    final List<String> log = focused.callLog;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.history_rounded,
                    color: _kSunsetDeep, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Call log (focused)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const Spacer(),
                Text(
                  '${log.length} call${log.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCodeBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: log.isEmpty
                  ? const Text(
                      '<no calls yet>',
                      style: TextStyle(
                        color: _kCodeFg,
                        fontSize: 12,
                        fontFamily: 'monospace',
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (int i = 0; i < log.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              '[${i.toString().padLeft(2, '0')}] '
                              '${focused.label}.${log[i]}',
                              style: const TextStyle(
                                color: _kCodeFg,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                height: 1.45,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Teaching panel
  // -------------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.menu_book_rounded, color: _kIndigoDark, size: 22),
                SizedBox(width: 8),
                Text(
                  'What RouteTransitionRecord really is',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                final bool twoCol = c.maxWidth > 640;
                if (!twoCol) {
                  return Column(
                    children: <Widget>[
                      _teachingColumn(
                        title: 'IS',
                        icon: Icons.category_rounded,
                        accent: _kIndigo,
                        bullets: const <String>[
                          'Abstract class in flutter/widgets.dart',
                          'Framework-managed — you never new it up',
                          'One-to-one with a Route in Navigator.pages',
                          'Short-lived: lives only for one build pass',
                        ],
                      ),
                      const SizedBox(height: 12),
                      _teachingColumn(
                        title: 'DOES',
                        icon: Icons.flash_on_rounded,
                        accent: _kSunset,
                        bullets: const <String>[
                          'Carries one pending transition decision',
                          'Exposes is-entering / is-exiting flags',
                          'Consumed by TransitionDelegate.resolve()',
                          'Drives the enter or exit animation',
                        ],
                      ),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _teachingColumn(
                        title: 'IS',
                        icon: Icons.category_rounded,
                        accent: _kIndigo,
                        bullets: const <String>[
                          'Abstract class in flutter/widgets.dart',
                          'Framework-managed — you never new it up',
                          'One-to-one with a Route in Navigator.pages',
                          'Short-lived: lives only for one build pass',
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _teachingColumn(
                        title: 'DOES',
                        icon: Icons.flash_on_rounded,
                        accent: _kSunset,
                        bullets: const <String>[
                          'Carries one pending transition decision',
                          'Exposes is-entering / is-exiting flags',
                          'Consumed by TransitionDelegate.resolve()',
                          'Drives the enter or exit animation',
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            _buildMethodTable(),
            const SizedBox(height: 18),
            _buildCustomDelegateSnippet(),
          ],
        ),
      ),
    );
  }

  Widget _teachingColumn({
    required String title,
    required IconData icon,
    required Color accent,
    required List<String> bullets,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: accent),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMethodTable() {
    const List<List<String>> rows = <List<String>>[
      <String>[
        'markForPush()',
        'Animate entry',
        'isWaitingForEnteringDecision',
        'full enter animation',
      ],
      <String>[
        'markForAdd()',
        'Silent entry',
        'isWaitingForEnteringDecision',
        'none — inserted instantly',
      ],
      <String>[
        'markForComplete([v])',
        'Natural finish',
        'isWaitingForExitingDecision',
        'matches default completion',
      ],
      <String>[
        'markForRemove()',
        'Silent removal',
        'isWaitingForExitingDecision',
        'none — torn down instantly',
      ],
      <String>[
        'markForPop([v])',
        'Animate exit with result',
        'isWaitingForExitingDecision',
        'full pop animation',
      ],
      <String>[
        '(conflict)',
        'Calling two markFor* on one record',
        'record already decided',
        'framework throws / asserts',
      ],
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: <Widget>[
          _tableHeader(const <String>[
            'method',
            'purpose',
            'precondition',
            'animation',
          ]),
          for (int i = 0; i < rows.length; i++)
            _tableRow(rows[i], alt: i.isOdd),
        ],
      ),
    );
  }

  Widget _tableHeader(List<String> cells) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: _kIndigo,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : 3,
              child: Text(
                cells[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tableRow(List<String> cells, {required bool alt}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: alt ? _kIndigoSoft.withValues(alpha: 0.35) : Colors.white,
        border: const Border(
          bottom: BorderSide(color: _kBorder),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              cells[0],
              style: const TextStyle(
                color: _kIndigoDark,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cells[1],
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cells[2],
              style: const TextStyle(
                color: _kInkMuted,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cells[3],
              style: const TextStyle(
                color: _kInk,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDelegateSnippet() {
    const String snippet = '''
class MyDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];
    for (final RouteTransitionRecord entering in newPageRouteHistory) {
      if (entering.isWaitingForEnteringDecision) {
        entering.markForPush();
      }
      results.add(entering);
    }
    for (final RouteTransitionRecord exiting
        in locationToExitingPageRoute.values) {
      if (exiting.isWaitingForExitingDecision) {
        exiting.markForComplete();
      }
      results.add(exiting);
    }
    return results;
  }
}
''';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCodeBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _kSunset,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _kWarn.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _kMint,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'custom_delegate.dart',
                style: TextStyle(
                  color: _kCodeFg,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SelectableText(
            snippet,
            style: TextStyle(
              color: _kCodeFg,
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer
  // -------------------------------------------------------------------------

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kMintSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kMint.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: const <Widget>[
          Icon(Icons.verified_outlined, color: _kMintDeep, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Rule of thumb: every entering record needs exactly one of '
              'markForPush / markForAdd, and every exiting record needs '
              'exactly one of markForComplete / markForRemove / markForPop '
              'before TransitionDelegate.resolve returns.',
              style: TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
