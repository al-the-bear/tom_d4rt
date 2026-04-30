// Route Transition Record — Deep Demo
//
// This harness file is a pedagogical exploration of Flutter's
// `RouteTransitionRecord`, the abstract hand-off object that Flutter's
// `Navigator` passes to a `TransitionDelegate` when `Navigator.pages` changes.
// A `RouteTransitionRecord` wraps a single `Route<dynamic>` and exposes the
// methods that a custom delegate uses to decide how that route should enter
// or leave the navigation stack (push with animation, silently add, complete,
// remove without animation, or pop with a result).
//
// Because instantiating the real `RouteTransitionRecord` in a d4rt harness
// would require also constructing a real `Route` (and plumbing it through a
// real `Navigator`), this demo mirrors the real public API on a plain Dart
// class `_FakeRouteTransitionRecord`. The method names are intentionally
// identical to the framework class so readers can map 1-to-1:
//
//   real                                           fake (this file)
//   ----                                           ----------------
//   RouteTransitionRecord.route                 -> _FakeRouteTransitionRecord.name
//   isWaitingForEnteringDecision                -> isWaitingForEnteringDecision
//   isWaitingForExitingDecision                 -> isWaitingForExitingDecision
//   markForPush()                               -> markForPush()
//   markForAdd()                                -> markForAdd()
//   markForPop([result])                        -> markForPop([result])
//   markForRemove()                             -> markForRemove()
//   markForComplete([result])                   -> markForComplete([result])
//
// Palette: indigo + sunset orange + mint accent.

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
// Fake record — mirrors the real RouteTransitionRecord public API
// ---------------------------------------------------------------------------

/// Pedagogical stand-in for Flutter's `RouteTransitionRecord`.
///
/// This is deliberately NOT a subclass of the framework's
/// `RouteTransitionRecord`. The real class is abstract and tightly coupled to
/// `Route<dynamic>` which would need a real `Navigator` to construct. For the
/// demo we only need to illustrate the decision surface, so we copy the
/// method names and the two "waiting" booleans into a plain class.
///
/// A reader can map this 1-to-1 onto the framework class.
class _FakeRouteTransitionRecord {
  _FakeRouteTransitionRecord({
    required this.name,
    required this.isWaitingForEnteringDecision,
    required this.isWaitingForExitingDecision,
  });

  /// Stands in for `RouteTransitionRecord.route.settings.name`.
  final String name;

  /// Mirrors `RouteTransitionRecord.isWaitingForEnteringDecision`.
  bool isWaitingForEnteringDecision;

  /// Mirrors `RouteTransitionRecord.isWaitingForExitingDecision`.
  bool isWaitingForExitingDecision;

  /// The decision slug: one of push/add/pop/remove/complete, or null
  /// while the record is still waiting for the delegate to call a
  /// `markForXxx()` method.
  String? _decision;

  /// The optional result value passed to `markForPop` or `markForComplete`.
  Object? _result;

  /// A short free-form note used in the UI to explain a conflicting call.
  String? _conflictNote;

  String? get decision => _decision;
  Object? get result => _result;
  String? get conflictNote => _conflictNote;

  bool get isDecided => _decision != null;
  bool get isPending => _decision == null;

  /// Mirrors `RouteTransitionRecord.markForPush()`.
  void markForPush() {
    if (_decision != null) {
      _conflictNote = 'markForPush() called after $_decision';
      return;
    }
    _decision = 'push';
    isWaitingForEnteringDecision = false;
  }

  /// Mirrors `RouteTransitionRecord.markForAdd()`.
  void markForAdd() {
    if (_decision != null) {
      _conflictNote = 'markForAdd() called after $_decision';
      return;
    }
    _decision = 'add';
    isWaitingForEnteringDecision = false;
  }

  /// Mirrors `RouteTransitionRecord.markForPop([result])`.
  void markForPop([Object? result]) {
    if (_decision != null) {
      _conflictNote = 'markForPop() called after $_decision';
      return;
    }
    _decision = 'pop';
    _result = result;
    isWaitingForExitingDecision = false;
  }

  /// Mirrors `RouteTransitionRecord.markForRemove()`.
  void markForRemove() {
    if (_decision != null) {
      _conflictNote = 'markForRemove() called after $_decision';
      return;
    }
    _decision = 'remove';
    isWaitingForExitingDecision = false;
  }

  /// Mirrors `RouteTransitionRecord.markForComplete([result])`.
  void markForComplete([Object? result]) {
    if (_decision != null) {
      _conflictNote = 'markForComplete() called after $_decision';
      return;
    }
    _decision = 'complete';
    _result = result;
    isWaitingForExitingDecision = false;
  }

  void reset({
    required bool entering,
    required bool exiting,
  }) {
    _decision = null;
    _result = null;
    _conflictNote = null;
    isWaitingForEnteringDecision = entering;
    isWaitingForExitingDecision = exiting;
  }

  /// The six-stage lifecycle slug used by the timeline hero.
  String get stage {
    if (_decision == null) {
      if (isWaitingForEnteringDecision) {
        return 'waitingEnterDecision';
      }
      if (isWaitingForExitingDecision) {
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
    snippet: "exiting.markForComplete(42);",
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
  late final List<_FakeRouteTransitionRecord> _records;
  int _focusedIndex = 0;
  int _turns = 0;

  @override
  void initState() {
    super.initState();
    _records = <_FakeRouteTransitionRecord>[
      _FakeRouteTransitionRecord(
        name: '/articles',
        isWaitingForEnteringDecision: true,
        isWaitingForExitingDecision: false,
      ),
      _FakeRouteTransitionRecord(
        name: '/settings',
        isWaitingForEnteringDecision: false,
        isWaitingForExitingDecision: true,
      ),
      _FakeRouteTransitionRecord(
        name: '/help',
        isWaitingForEnteringDecision: true,
        isWaitingForExitingDecision: false,
      ),
      _FakeRouteTransitionRecord(
        name: '/about',
        isWaitingForEnteringDecision: false,
        isWaitingForExitingDecision: true,
      ),
    ];
  }

  void _apply(int index, String action) {
    final record = _records[index];
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
    debugPrint('[RouteTransitionStagingDemo] ${record.name} -> $action');
  }

  void _resetAll() {
    setState(() {
      for (var i = 0; i < _records.length; i++) {
        final isEntering = i.isEven;
        _records[i].reset(
          entering: isEntering,
          exiting: !isEntering,
        );
      }
      _focusedIndex = 0;
      _turns = 0;
    });
    debugPrint('[RouteTransitionStagingDemo] reset all');
  }

  @override
  Widget build(BuildContext context) {
    final focused = _records[_focusedIndex];
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
            tooltip: 'Reset fakes',
            onPressed: _resetAll,
            icon: const Icon(Icons.restart_alt_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeadline(),
                    const SizedBox(height: 20),
                    _buildTimelineHero(focused),
                    const SizedBox(height: 24),
                    _buildDecisionPlayground(),
                    const SizedBox(height: 24),
                    _buildSequenceDiagram(),
                    const SizedBox(height: 24),
                    _buildScenarioWrap(),
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

  Widget _buildHeadline() {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Timeline hero
  // -------------------------------------------------------------------------

  Widget _buildTimelineHero(_FakeRouteTransitionRecord focused) {
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
              builder: (context, c) {
                final stages = _kTimelineStages;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: c.maxWidth),
                    child: Row(
                      children: <Widget>[
                        for (var i = 0; i < stages.length; i++) ...<Widget>[
                          _buildTimelineStage(
                            stages[i],
                            active: stages[i].id == focused.stage,
                          ),
                          if (i != stages.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(
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

  Widget _buildFocusChip(_FakeRouteTransitionRecord focused) {
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
            'focus: ${focused.name}',
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
    final Color subtitle = active
        ? Colors.white.withValues(alpha: 0.85)
        : _kInkMuted;
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

  Widget _buildStageExplainer(_FakeRouteTransitionRecord focused) {
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
            'markForComplete() fired. Route\'s future resolves with ${focused.result ?? "no result"}.';
        break;
      case 'waitingExitDecision':
        label = 'waiting for exit decision';
        explain = focused.decision == 'pop'
            ? 'markForPop() fired — exit animation will run and future resolves with ${focused.result ?? "no result"}.'
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
                  label: const Text('reset fakes'),
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
              'Each fake record mirrors the real RouteTransitionRecord API. '
              'Tap a decision button to call the corresponding markFor* method.',
              style: TextStyle(color: _kInkMuted, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, c) {
                final twoCol = c.maxWidth > 720;
                final cards = <Widget>[
                  for (var i = 0; i < _records.length; i++)
                    _buildDecisionCard(i, _records[i]),
                ];
                if (!twoCol) {
                  return Column(
                    children: <Widget>[
                      for (var i = 0; i < cards.length; i++) ...<Widget>[
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
                    for (final card in cards)
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

  Widget _buildDecisionCard(int index, _FakeRouteTransitionRecord record) {
    final focused = index == _focusedIndex;
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
                      record.name,
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
              builder: (context, c) {
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
                    for (final s in _kScenarios)
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
              builder: (context, c) {
                final twoCol = c.maxWidth > 640;
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
          for (final b in bullets)
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
    const rows = <List<String>>[
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
          _tableHeader(const <String>['method', 'purpose', 'precondition', 'animation']),
          for (var i = 0; i < rows.length; i++)
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
          for (var i = 0; i < cells.length; i++)
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
    const snippet = '''
class MyDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve(...) {
    for (final entering in newPageRouteHistory) {
      entering.markForPush();
    }
    for (final exiting in locationToExitingPageRoute.values) {
      exiting.markForComplete();
    }
    return [...];
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
