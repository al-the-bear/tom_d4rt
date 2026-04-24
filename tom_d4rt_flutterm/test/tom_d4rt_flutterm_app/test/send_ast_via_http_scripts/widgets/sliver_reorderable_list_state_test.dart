import 'dart:math' as math;

import 'package:flutter/material.dart';

// =====================================================================
// SliverReorderableListState — Drag-and-Drop Dojo
// ---------------------------------------------------------------------
// This demo celebrates `SliverReorderableListState`, the State object
// that backs `SliverReorderableList`. It is most often accessed through
// a `GlobalKey<SliverReorderableListState>` so callers can imperatively
// abort a drag session via `cancelReorder()`.
//
// Theme: a traditional dojo — ranked belts ascend from white to black,
// drag handles are belt-coloured rope pulls, and cherry blossoms drift
// past bamboo walls.  The palette is deliberately muted so the drag
// handles and rank icons stay legible.
//
// Palette:
//   • cherry  — Color(0xFFB7263D)  — accents, alerts, sensei stripes
//   • bamboo  — Color(0xFF3F8F5E)  — frames, passive chrome
//   • cream   — Color(0xFFF5EED8)  — background tatami
//
// API coverage (hand-authored, no generated boilerplate):
//   • SliverReorderableList with GlobalKey<SliverReorderableListState>
//   • cancelReorder() invoked from an imperative control bar
//   • ReorderableDragStartListener and ReorderableDelayedDragStartListener
//   • onReorder contract + the `if (newIndex > oldIndex) newIndex -= 1`
//     caveat (illustrated both in code and in the Rules-of-the-Dojo card)
//   • State diagram painted via a CustomPainter showing the drag lifecycle
//   • Gesture chart in DataTable form
//   • Pitfall card highlighting cancelReorder() as a no-op when idle
//   • A second list without GlobalKey so cancelReorder is unreachable
// =====================================================================

/// Cherry red — headline colour of the dojo banners.
const Color _kCherry = Color(0xFFB7263D);

/// Bamboo green — subdued frame colour used for non-hero chrome.
const Color _kBamboo = Color(0xFF3F8F5E);

/// Cream — tatami-mat background tone.
const Color _kCream = Color(0xFFF5EED8);

/// Deep charcoal — used for primary body text against cream.
const Color _kInkstone = Color(0xFF2B2A26);

/// Soft parchment — slightly warmer than cream, used for cards.
const Color _kParchment = Color(0xFFFBF5E3);

/// Aged-gold accent — used sparingly for rank pips and medal trims.
const Color _kAgedGold = Color(0xFFC9A24B);

/// A belt rank used throughout the demo list.  Colour maps roughly to
/// the traditional Japanese karate ranking progression; it is used both
/// for the list rows and for the stripe animation in the hero header.
class _SrlsBeltRank {
  const _SrlsBeltRank({
    required this.id,
    required this.name,
    required this.kanji,
    required this.color,
    required this.tenet,
    required this.icon,
  });

  final int id;
  final String name;
  final String kanji;
  final Color color;
  final String tenet;
  final IconData icon;
}

/// The ten ranks used by the primary dojo list.  Ordered from most
/// junior (white belt) to most senior (black belt) — because onReorder
/// operates on ordered lists and we need a deterministic start state.
const List<_SrlsBeltRank> _kDojoRanks = <_SrlsBeltRank>[
  _SrlsBeltRank(
    id: 0,
    name: 'White Belt',
    kanji: '白帯',
    color: Color(0xFFF2ECD6),
    tenet: 'Arrive. Observe. Breathe.',
    icon: Icons.air_outlined,
  ),
  _SrlsBeltRank(
    id: 1,
    name: 'Yellow Belt',
    kanji: '黄帯',
    color: Color(0xFFE6C94A),
    tenet: 'The dawn settles into the bones.',
    icon: Icons.wb_sunny_outlined,
  ),
  _SrlsBeltRank(
    id: 2,
    name: 'Orange Belt',
    kanji: '橙帯',
    color: Color(0xFFE08742),
    tenet: 'Strength finds its footing.',
    icon: Icons.local_fire_department_outlined,
  ),
  _SrlsBeltRank(
    id: 3,
    name: 'Green Belt',
    kanji: '緑帯',
    color: Color(0xFF3F8F5E),
    tenet: 'Stance takes root like bamboo.',
    icon: Icons.park_outlined,
  ),
  _SrlsBeltRank(
    id: 4,
    name: 'Blue Belt',
    kanji: '青帯',
    color: Color(0xFF3A6EA5),
    tenet: 'The sky opens to a calmer mind.',
    icon: Icons.waves_outlined,
  ),
  _SrlsBeltRank(
    id: 5,
    name: 'Purple Belt',
    kanji: '紫帯',
    color: Color(0xFF7E3F8F),
    tenet: 'Technique braids with patience.',
    icon: Icons.auto_awesome_outlined,
  ),
  _SrlsBeltRank(
    id: 6,
    name: 'Brown Belt',
    kanji: '茶帯',
    color: Color(0xFF8A5A3B),
    tenet: 'Earth informs every fall.',
    icon: Icons.landscape_outlined,
  ),
  _SrlsBeltRank(
    id: 7,
    name: 'Red Belt',
    kanji: '赤帯',
    color: Color(0xFFB7263D),
    tenet: 'The flame disciplines itself.',
    icon: Icons.whatshot_outlined,
  ),
  _SrlsBeltRank(
    id: 8,
    name: 'Silver Belt',
    kanji: '銀帯',
    color: Color(0xFFB7BAC1),
    tenet: 'Silence reflects the whole room.',
    icon: Icons.nightlight_outlined,
  ),
  _SrlsBeltRank(
    id: 9,
    name: 'Black Belt',
    kanji: '黒帯',
    color: Color(0xFF1E1E1E),
    tenet: 'Every breath returns to the first.',
    icon: Icons.military_tech_outlined,
  ),
];

/// A single gesture entry shown in the gesture chart DataTable.
class _SrlsGestureEntry {
  const _SrlsGestureEntry({
    required this.gesture,
    required this.listener,
    required this.transition,
    required this.outcome,
  });

  final String gesture;
  final String listener;
  final String transition;
  final String outcome;
}

/// Rows of the gesture chart.  Each row describes how a user gesture
/// maps to a reorder state transition when interacting with the
/// list.
const List<_SrlsGestureEntry> _kGestureRows = <_SrlsGestureEntry>[
  _SrlsGestureEntry(
    gesture: 'Tap',
    listener: 'none (inert)',
    transition: 'idle → idle',
    outcome: 'No drag; a tap is absorbed by the tile.',
  ),
  _SrlsGestureEntry(
    gesture: 'Long Press',
    listener: 'ReorderableDelayedDragStartListener',
    transition: 'idle → pickup',
    outcome: 'After the press delay, the tile detaches.',
  ),
  _SrlsGestureEntry(
    gesture: 'Handle Press',
    listener: 'ReorderableDragStartListener',
    transition: 'idle → pickup',
    outcome: 'Drag starts immediately on the handle.',
  ),
  _SrlsGestureEntry(
    gesture: 'Drag',
    listener: 'internal PointerMove',
    transition: 'pickup → dragging',
    outcome: 'Proxy follows pointer; edges may auto-scroll.',
  ),
  _SrlsGestureEntry(
    gesture: 'Release',
    listener: 'internal PointerUp',
    transition: 'dragging → drop',
    outcome: 'onReorder fires with oldIndex/newIndex.',
  ),
  _SrlsGestureEntry(
    gesture: 'cancelReorder()',
    listener: 'imperative (GlobalKey)',
    transition: 'dragging → settled',
    outcome: 'Drag aborts; the list restores its prior order.',
  ),
  _SrlsGestureEntry(
    gesture: 'Esc / Back',
    listener: 'system route pop',
    transition: 'dragging → settled',
    outcome: 'Platform cancels; State cleans up the overlay.',
  ),
];

/// A single row of the "Rules of the Dojo" reference card.
class _SrlsRule {
  const _SrlsRule({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;
}

/// The rules.  Ordering is intentional — each successive rule builds on
/// the previous one.
const List<_SrlsRule> _kDojoRules = <_SrlsRule>[
  _SrlsRule(
    title: 'ReorderableDragStartListener',
    body:
        'Wrap the drag handle (e.g. a rope icon) with this listener so a '
        'single press on the handle starts the drag immediately.  The '
        'listener requires the enclosing sliver\'s child `index` to be '
        'passed explicitly — do not rely on closure capture of a build-time '
        'index, use the itemBuilder parameter directly.',
    icon: Icons.drag_indicator_outlined,
  ),
  _SrlsRule(
    title: 'ReorderableDelayedDragStartListener',
    body:
        'Prefer this when the whole row should be draggable, but you want '
        'to preserve room for taps.  Flutter uses a long-press gesture to '
        'arm the drag; on touch devices this feels the most natural.',
    icon: Icons.hourglass_bottom_outlined,
  ),
  _SrlsRule(
    title: 'onReorder(oldIndex, newIndex)',
    body:
        'Called once per completed drag.  You must mutate the underlying '
        'list synchronously inside setState.  The framework delivers '
        '`newIndex` as if the dragged item still occupied its old slot, so '
        'you almost always need the shift adjustment described below.',
    icon: Icons.swap_vert_outlined,
  ),
  _SrlsRule(
    title: 'The newIndex shift caveat',
    body:
        'If `newIndex > oldIndex` subtract one before removing the item: '
        '`if (newIndex > oldIndex) newIndex -= 1;`  Forgetting this causes '
        'the item to "slip" past its intended slot by one position whenever '
        'you drag downward — a classic dojo stumble.',
    icon: Icons.rule_outlined,
  ),
  _SrlsRule(
    title: 'cancelReorder()',
    body:
        'Accessed through `GlobalKey<SliverReorderableListState>`.  Calling '
        'it while a drag is in progress aborts the session and snaps the '
        'proxy back.  Calling it when idle is a harmless no-op.',
    icon: Icons.cancel_outlined,
  ),
  _SrlsRule(
    title: 'Proxy + auto-scroll',
    body:
        'During a drag the State paints an overlay proxy and spins up an '
        '`EdgeDraggingAutoScroller`.  If you nest the sliver in a custom '
        'ScrollView you must forward the scroll controller properly; '
        'otherwise the proxy will not follow edge scrolls.',
    icon: Icons.autorenew_outlined,
  ),
];

/// A node in the state-diagram painted by [_SrlsStateDiagramPainter].
class _SrlsStateNode {
  const _SrlsStateNode({
    required this.id,
    required this.label,
    required this.center,
    required this.color,
    required this.detail,
  });

  final String id;
  final String label;
  final Offset center;
  final Color color;
  final String detail;
}

/// A directed edge between two state nodes.
class _SrlsStateEdge {
  const _SrlsStateEdge({
    required this.from,
    required this.to,
    required this.label,
    this.curve = 0.0,
    this.emphasized = false,
  });

  final String from;
  final String to;
  final String label;
  final double curve;
  final bool emphasized;
}

/// The canonical nodes of the reorder lifecycle.
const List<_SrlsStateNode> _kStateNodes = <_SrlsStateNode>[
  _SrlsStateNode(
    id: 'idle',
    label: 'idle',
    center: Offset(120, 120),
    color: _kBamboo,
    detail: 'The list is at rest. No overlay proxy exists.',
  ),
  _SrlsStateNode(
    id: 'pickup',
    label: 'pickup',
    center: Offset(360, 120),
    color: _kAgedGold,
    detail: 'A listener has armed the drag; proxy is fading in.',
  ),
  _SrlsStateNode(
    id: 'dragging',
    label: 'dragging',
    center: Offset(600, 120),
    color: _kCherry,
    detail: 'Pointer moves; auto-scroll engages near the edges.',
  ),
  _SrlsStateNode(
    id: 'drop',
    label: 'drop',
    center: Offset(600, 320),
    color: Color(0xFF7E3F8F),
    detail: 'Pointer released; onReorder fires with the shifted index.',
  ),
  _SrlsStateNode(
    id: 'settled',
    label: 'settled',
    center: Offset(240, 320),
    color: _kBamboo,
    detail: 'Proxy dismissed; state returns to idle on the next frame.',
  ),
];

/// Edges wiring the state diagram.  Two special edges are highlighted:
/// the cancel path and the newIndex-shift drop.
const List<_SrlsStateEdge> _kStateEdges = <_SrlsStateEdge>[
  _SrlsStateEdge(from: 'idle', to: 'pickup', label: 'drag-start-listener'),
  _SrlsStateEdge(from: 'pickup', to: 'dragging', label: 'pointer moves'),
  _SrlsStateEdge(
    from: 'dragging',
    to: 'drop',
    label: 'pointer up',
    emphasized: true,
  ),
  _SrlsStateEdge(from: 'drop', to: 'settled', label: 'onReorder()'),
  _SrlsStateEdge(from: 'settled', to: 'idle', label: 'next frame', curve: 0.3),
  _SrlsStateEdge(
    from: 'dragging',
    to: 'settled',
    label: 'cancelReorder()',
    curve: -0.4,
    emphasized: true,
  ),
];

/// Entry point — the d4rt AST harness expects a top-level `build` that
/// returns a full `MaterialApp` anchored by a `Scaffold`.  We must not
/// introduce a `main()` or `runApp()`.
dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliverReorderableListState — Drag-and-Drop Dojo',
    home: _SrlsDojoHome(),
  );
}

/// Top-level Scaffold.  Hosts the hero, the main CustomScrollView and
/// the ancillary reference cards.  This widget is stateful so it can
/// own the list model, the `GlobalKey<SliverReorderableListState>` and
/// the hero stripe animation.
class _SrlsDojoHome extends StatefulWidget {
  const _SrlsDojoHome();

  @override
  State<_SrlsDojoHome> createState() => _SrlsDojoHomeState();
}

class _SrlsDojoHomeState extends State<_SrlsDojoHome>
    with TickerProviderStateMixin {
  /// Live ranks for the primary list.  Starts from `_kDojoRanks` but
  /// mutates as the user drags rows around.
  late List<_SrlsBeltRank> _primaryOrder;

  /// The alternate list used to demonstrate the absence of the key —
  /// it exists but has no imperative handle.
  late List<_SrlsBeltRank> _alternateOrder;

  /// The GlobalKey that grants access to `SliverReorderableListState`.
  /// This is the whole point of the demo.
  final GlobalKey<SliverReorderableListState> _primaryListKey =
      GlobalKey<SliverReorderableListState>(debugLabel: 'dojo-primary-list');

  /// The shared scroll controller; both lists live under the same
  /// CustomScrollView, but the secondary list is in its own column.
  final ScrollController _primaryScrollController = ScrollController();
  final ScrollController _secondaryScrollController = ScrollController();

  /// Controller for the belt-stripe animation that sweeps across the
  /// hero header.  The stripes repeat continuously to evoke a constant
  /// training rhythm.
  late final AnimationController _stripeController;

  /// A slower pulsing animation used by the hero mon (crest) to evoke
  /// a breathing motion.  Independent from the stripes for visual
  /// variety.
  late final AnimationController _breathController;

  /// A log of imperative operations, shown as a running scroll so the
  /// reader can inspect the exact order of calls.  Capped at a modest
  /// length to avoid unbounded growth.
  final List<_SrlsLogEntry> _log = <_SrlsLogEntry>[];

  /// Cached gesture drag count for the "pitfall" card — incremented
  /// every time the user cancels a drag, whether it was valid or a
  /// no-op.
  int _cancelAttempts = 0;
  int _cancelNoOps = 0;

  /// Tracks whether a drag is believed to be active.  This is a local
  /// heuristic; the authoritative truth lives in
  /// `SliverReorderableListState`, but tracking it here lets the UI
  /// display a sensible hint.
  bool _dragActive = false;

  @override
  void initState() {
    super.initState();
    _primaryOrder = List<_SrlsBeltRank>.of(_kDojoRanks);
    _alternateOrder = List<_SrlsBeltRank>.of(_kDojoRanks.reversed);

    _stripeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Dojo opened',
        detail: 'Primary list is bound to GlobalKey<SliverReorderableListState>.',
        tone: _SrlsLogTone.info,
      ),
    );
  }

  @override
  void dispose() {
    _stripeController.dispose();
    _breathController.dispose();
    _primaryScrollController.dispose();
    _secondaryScrollController.dispose();
    super.dispose();
  }

  /// Appends a log entry and trims the log so it does not grow
  /// unboundedly during an extended demo session.
  void _appendLog(_SrlsLogEntry entry) {
    setState(() {
      _log.insert(0, entry);
      if (_log.length > 24) {
        _log.removeRange(24, _log.length);
      }
    });
  }

  /// Correctly handle the reorder contract, including the
  /// `if (newIndex > oldIndex) newIndex -= 1;` shift described in the
  /// dojo rules.
  void _onPrimaryReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _SrlsBeltRank moved = _primaryOrder.removeAt(oldIndex);
      _primaryOrder.insert(newIndex, moved);
      _dragActive = false;
    });
    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Reordered primary list',
        detail: '${_primaryOrder[newIndex].name} now at slot '
            '${newIndex + 1}/${_primaryOrder.length}.',
        tone: _SrlsLogTone.success,
      ),
    );
    debugPrint(
      'SrlsDojo: primary reorder ($oldIndex → $newIndex) '
      'head=${_primaryOrder.first.name}',
    );
  }

  /// Alternate list reorder.  Same contract, but this list has no
  /// GlobalKey so there is no imperative cancel path.
  void _onAlternateReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _SrlsBeltRank moved = _alternateOrder.removeAt(oldIndex);
      _alternateOrder.insert(newIndex, moved);
    });
    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Reordered alternate list',
        detail: 'No GlobalKey attached — cancelReorder() is unavailable.',
        tone: _SrlsLogTone.warning,
      ),
    );
    debugPrint(
      'SrlsDojo: alternate reorder ($oldIndex → $newIndex) '
      '(no imperative handle)',
    );
  }

  /// Cancels a drag via the GlobalKey's currentState.  Records whether
  /// the invocation was a no-op for the pitfall card.
  void _cancelPrimaryDrag() {
    _cancelAttempts += 1;
    final SliverReorderableListState? state = _primaryListKey.currentState;
    if (state == null) {
      _appendLog(
        _SrlsLogEntry(
          timestamp: DateTime.now(),
          title: 'cancelReorder() — unreachable',
          detail: 'GlobalKey.currentState is null; list is not mounted.',
          tone: _SrlsLogTone.error,
        ),
      );
      return;
    }
    final bool wasActive = _dragActive;
    state.cancelReorder();
    if (!wasActive) {
      _cancelNoOps += 1;
      _appendLog(
        _SrlsLogEntry(
          timestamp: DateTime.now(),
          title: 'cancelReorder() — no-op',
          detail: 'No drag was in progress; call returned harmlessly.',
          tone: _SrlsLogTone.warning,
        ),
      );
    } else {
      _appendLog(
        _SrlsLogEntry(
          timestamp: DateTime.now(),
          title: 'cancelReorder() — aborted drag',
          detail: 'An active drag was terminated via the imperative API.',
          tone: _SrlsLogTone.success,
        ),
      );
    }
    setState(() {
      _dragActive = false;
    });
  }

  /// Resets the primary list to its canonical white-to-black order.
  void _resetPrimaryOrder() {
    setState(() {
      _primaryOrder = List<_SrlsBeltRank>.of(_kDojoRanks);
    });
    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Primary list reset',
        detail: 'White-belt to black-belt canonical order restored.',
        tone: _SrlsLogTone.info,
      ),
    );
  }

  /// Reverses the primary list.  Handy demonstration that the sliver
  /// rebuilds correctly when we mutate the underlying model without
  /// involving drag.
  void _reversePrimaryOrder() {
    setState(() {
      _primaryOrder = List<_SrlsBeltRank>.of(_primaryOrder.reversed);
    });
    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Primary list reversed',
        detail: 'Order flipped via setState — no drag required.',
        tone: _SrlsLogTone.info,
      ),
    );
  }

  /// Shuffles the primary list deterministically.  We seed the RNG so
  /// the animation is reproducible across hot reloads.
  void _shufflePrimaryOrder() {
    final math.Random rng = math.Random(20260424);
    setState(() {
      _primaryOrder = List<_SrlsBeltRank>.of(_primaryOrder)..shuffle(rng);
    });
    _appendLog(
      _SrlsLogEntry(
        timestamp: DateTime.now(),
        title: 'Primary list shuffled',
        detail: 'Deterministic shuffle seeded with 20260424.',
        tone: _SrlsLogTone.info,
      ),
    );
  }

  /// The slivers that make up the primary CustomScrollView.
  List<Widget> _buildPrimarySlivers() {
    return <Widget>[
      SliverToBoxAdapter(child: _SrlsHeroHeader(
        stripe: _stripeController,
        breath: _breathController,
      )),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      SliverToBoxAdapter(
        child: _SrlsControlBar(
          onCancel: _cancelPrimaryDrag,
          onReset: _resetPrimaryOrder,
          onReverse: _reversePrimaryOrder,
          onShuffle: _shufflePrimaryOrder,
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 8)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'primary roster',
          title: 'Ten ranks, one GlobalKey',
          subtitle:
              'Drag the rope handle to reorder.  The control bar above '
              'calls `cancelReorder()` through the GlobalKey.',
          icon: Icons.view_list_outlined,
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverReorderableList(
          key: _primaryListKey,
          itemCount: _primaryOrder.length,
          onReorder: _onPrimaryReorder,
          onReorderStart: (int index) {
            _dragActive = true;
            _appendLog(
              _SrlsLogEntry(
                timestamp: DateTime.now(),
                title: 'Drag started',
                detail: '${_primaryOrder[index].name} picked up.',
                tone: _SrlsLogTone.info,
              ),
            );
          },
          onReorderEnd: (int index) {
            _dragActive = false;
            _appendLog(
              _SrlsLogEntry(
                timestamp: DateTime.now(),
                title: 'Drag ended',
                detail: 'Drop at slot $index.',
                tone: _SrlsLogTone.info,
              ),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final _SrlsBeltRank rank = _primaryOrder[index];
            return _SrlsRankTile(
              key: ValueKey<int>(rank.id),
              rank: rank,
              index: index,
              total: _primaryOrder.length,
              draggableByHandle: true,
              draggableByRow: true,
            );
          },
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'state model',
          title: 'Lifecycle of a drag',
          subtitle:
              'Idle → pickup → dragging → drop → settled.  The painter '
              'below is hand-authored; no flow charting package involved.',
          icon: Icons.account_tree_outlined,
        ),
      ),
      const SliverToBoxAdapter(child: _SrlsStateDiagramCard()),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'gesture chart',
          title: 'What each gesture does',
          subtitle:
              'How taps, long presses and imperative calls translate '
              'into concrete state transitions on the sliver.',
          icon: Icons.pan_tool_alt_outlined,
        ),
      ),
      const SliverToBoxAdapter(child: _SrlsGestureChartCard()),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'rules of the dojo',
          title: 'Six tenets for imperative reorder',
          subtitle:
              'Listeners, the onReorder contract, cancelReorder, and the '
              '`newIndex > oldIndex` caveat.',
          icon: Icons.menu_book_outlined,
        ),
      ),
      const SliverToBoxAdapter(child: _SrlsRulesCard()),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'pitfall',
          title: 'cancelReorder is a quiet no-op',
          subtitle:
              'Calling it while nothing is being dragged is safe, but the '
              'caller must not assume that "nothing happened" means the '
              'API failed.',
          icon: Icons.warning_amber_outlined,
        ),
      ),
      SliverToBoxAdapter(
        child: _SrlsPitfallCard(
          attempts: _cancelAttempts,
          noOps: _cancelNoOps,
          active: _dragActive,
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'without the key',
          title: 'The other sliver',
          subtitle:
              'A second SliverReorderableList without a GlobalKey — '
              'drags still work, but cancelReorder is unreachable.',
          icon: Icons.key_off_outlined,
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverReorderableList(
          itemCount: _alternateOrder.length,
          onReorder: _onAlternateReorder,
          itemBuilder: (BuildContext context, int index) {
            final _SrlsBeltRank rank = _alternateOrder[index];
            return _SrlsRankTile(
              key: ValueKey<int>(-1 - rank.id),
              rank: rank,
              index: index,
              total: _alternateOrder.length,
              draggableByHandle: true,
              draggableByRow: false,
              muted: true,
            );
          },
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
      SliverToBoxAdapter(
        child: _SrlsSectionHeading(
          overline: 'imperative log',
          title: 'What the dojo remembers',
          subtitle:
              'Every reorder, every cancelReorder call, every reset — '
              'stamped with a local wall-clock time.',
          icon: Icons.receipt_long_outlined,
        ),
      ),
      SliverToBoxAdapter(child: _SrlsLogCard(entries: _log)),
      const SliverToBoxAdapter(child: SizedBox(height: 48)),
      const SliverToBoxAdapter(child: _SrlsFooter()),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      body: CustomScrollView(
        controller: _primaryScrollController,
        physics: const BouncingScrollPhysics(),
        slivers: _buildPrimarySlivers(),
      ),
    );
  }
}

// =====================================================================
// Hero header — a banner with repeating belt stripes sweeping to the
// right, the dojo mon (crest) breathing in the centre, and a concise
// subtitle explaining the demo.
// =====================================================================
class _SrlsHeroHeader extends StatelessWidget {
  const _SrlsHeroHeader({required this.stripe, required this.breath});

  final Animation<double> stripe;
  final Animation<double> breath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: <Color>[_kInkstone, Color(0xFF3C342E), _kCherry],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kCherry.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedBuilder(
            animation: stripe,
            builder: (BuildContext context, Widget? _) {
              return CustomPaint(
                painter: _SrlsBeltStripePainter(progress: stripe.value),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: _SrlsHeroMon(breath: breath),
          ),
          Positioned(
            left: 24,
            top: 22,
            right: 24,
            child: Row(
              children: <Widget>[
                _SrlsHeroBadge(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'SliverReorderableListState',
                    style: TextStyle(
                      color: _kCream,
                      fontSize: 18,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                _SrlsHeroChip(
                  label: 'GlobalKey',
                  color: _kBamboo,
                  icon: Icons.vpn_key_outlined,
                ),
                const SizedBox(width: 6),
                _SrlsHeroChip(
                  label: 'cancelReorder',
                  color: _kCherry,
                  icon: Icons.cancel_schedule_send_outlined,
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Drag-and-Drop Dojo',
                  style: TextStyle(
                    color: _kCream,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.65),
                        blurRadius: 10,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ten dojo ranks, one imperative handle, and the '
                  'lifecycle of a reorder — rendered hand-painted.',
                  style: TextStyle(
                    color: _kCream.withValues(alpha: 0.86),
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A small badge painted next to the hero title.
class _SrlsHeroBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _kCream.withValues(alpha: 0.12),
        border: Border.all(color: _kCream.withValues(alpha: 0.35)),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.shield_moon_outlined, color: _kCream, size: 18),
    );
  }
}

/// A small hero chip — used to indicate key features at the top of the
/// hero header.
class _SrlsHeroChip extends StatelessWidget {
  const _SrlsHeroChip({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.65)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: _kCream, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _kCream,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// A breathing mon (crest) placed in the centre of the hero.  The crest
/// is painted by hand with a simple compass-rose shape; it expands and
/// contracts subtly according to [breath].
class _SrlsHeroMon extends StatelessWidget {
  const _SrlsHeroMon({required this.breath});

  final Animation<double> breath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: breath,
        builder: (BuildContext context, Widget? _) {
          final double scale = 1.0 + (breath.value * 0.08);
          return Opacity(
            opacity: 0.22 + (breath.value * 0.14),
            child: Transform.scale(
              scale: scale,
              child: CustomPaint(
                size: const Size(150, 150),
                painter: _SrlsMonPainter(),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Paints a hand-authored mon (crest).  Four cardinal petals, an inner
/// circle, and a ring — deliberately simple so it reads at a glance.
class _SrlsMonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.shortestSide / 2;
    final Paint ringPaint = Paint()
      ..color = _kCream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius * 0.98, ringPaint);

    final Paint petalPaint = Paint()
      ..color = _kCream
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 4; i++) {
      final double angle = (i * math.pi / 2) - (math.pi / 4);
      final Offset petalCenter = center + Offset(
        math.cos(angle) * radius * 0.55,
        math.sin(angle) * radius * 0.55,
      );
      final Path path = Path();
      path.moveTo(petalCenter.dx, petalCenter.dy - radius * 0.3);
      path.quadraticBezierTo(
        petalCenter.dx + radius * 0.22,
        petalCenter.dy,
        petalCenter.dx,
        petalCenter.dy + radius * 0.3,
      );
      path.quadraticBezierTo(
        petalCenter.dx - radius * 0.22,
        petalCenter.dy,
        petalCenter.dx,
        petalCenter.dy - radius * 0.3,
      );
      canvas.drawPath(path, petalPaint);
    }

    final Paint hubPaint = Paint()
      ..color = _kCream
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.18, hubPaint);

    final Paint hubInnerPaint = Paint()
      ..color = _kCherry
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.08, hubInnerPaint);
  }

  @override
  bool shouldRepaint(covariant _SrlsMonPainter oldDelegate) => false;
}

/// Paints diagonal belt stripes across the hero header that continuously
/// slide to the right.  Each stripe is tinted with a belt colour to
/// hint at the ranked nature of the subject matter.
class _SrlsBeltStripePainter extends CustomPainter {
  const _SrlsBeltStripePainter({required this.progress});

  final double progress;

  static const List<Color> _stripeColors = <Color>[
    Color(0xFFF2ECD6),
    Color(0xFFE6C94A),
    Color(0xFFE08742),
    Color(0xFF3F8F5E),
    Color(0xFF3A6EA5),
    Color(0xFF7E3F8F),
    Color(0xFF8A5A3B),
    Color(0xFFB7263D),
    Color(0xFFB7BAC1),
    Color(0xFF1E1E1E),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double stripeWidth = 40;
    final double diag = size.width + size.height;
    final double offset = progress * (stripeWidth * 2);
    for (int i = -3; i < (diag / stripeWidth).ceil() + 3; i++) {
      final Color color = _stripeColors[i.abs() % _stripeColors.length];
      final double x = (i * stripeWidth) + offset;
      final Path path = Path();
      path.moveTo(x, 0);
      path.lineTo(x + stripeWidth * 0.45, 0);
      path.lineTo(x - size.height + stripeWidth * 0.45, size.height);
      path.lineTo(x - size.height, size.height);
      path.close();
      final Paint paint = Paint()
        ..color = color.withValues(alpha: 0.14)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    }

    // A subtle inner vignette so the title remains legible against the
    // stripes.
    final Paint vignette = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          Colors.transparent,
          Colors.black.withValues(alpha: 0.35),
        ],
        stops: const <double>[0.6, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, vignette);
  }

  @override
  bool shouldRepaint(covariant _SrlsBeltStripePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// =====================================================================
// Control bar — imperative invocations of `.currentState!.cancelReorder()`,
// plus helper buttons to reset, reverse and shuffle the list order.
// =====================================================================
class _SrlsControlBar extends StatelessWidget {
  const _SrlsControlBar({
    required this.onCancel,
    required this.onReset,
    required this.onReverse,
    required this.onShuffle,
  });

  final VoidCallback onCancel;
  final VoidCallback onReset;
  final VoidCallback onReverse;
  final VoidCallback onShuffle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInkstone.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.handyman_outlined,
                color: _kCherry,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Imperative control bar',
                style: TextStyle(
                  color: _kInkstone,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Text(
                '.currentState!.cancelReorder()',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kInkstone.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _SrlsControlButton(
                label: 'cancelReorder',
                tone: _kCherry,
                icon: Icons.stop_circle_outlined,
                onPressed: onCancel,
              ),
              _SrlsControlButton(
                label: 'Reset (white→black)',
                tone: _kBamboo,
                icon: Icons.restart_alt_outlined,
                onPressed: onReset,
              ),
              _SrlsControlButton(
                label: 'Reverse',
                tone: _kInkstone,
                icon: Icons.swap_vert_circle_outlined,
                onPressed: onReverse,
              ),
              _SrlsControlButton(
                label: 'Shuffle (seeded)',
                tone: _kAgedGold,
                icon: Icons.shuffle_outlined,
                onPressed: onShuffle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SrlsControlButton extends StatelessWidget {
  const _SrlsControlButton({
    required this.label,
    required this.tone,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Color tone;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tone.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 16, color: tone),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: tone,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Section heading — shared across all demo sections to keep the visual
// rhythm predictable.
// =====================================================================
class _SrlsSectionHeading extends StatelessWidget {
  const _SrlsSectionHeading({
    required this.overline,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String overline;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kBamboo.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kBamboo.withValues(alpha: 0.4)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: _kBamboo, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  overline.toUpperCase(),
                  style: TextStyle(
                    color: _kCherry,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInkstone,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _kInkstone.withValues(alpha: 0.72),
                    fontSize: 13,
                    height: 1.38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Rank tile — one row in the reorderable list.  Each tile shows:
//   • a belt-coloured drag handle (ReorderableDragStartListener)
//   • a rank label with kanji
//   • a rank icon
//   • a row-level ReorderableDelayedDragStartListener (optional)
// =====================================================================
class _SrlsRankTile extends StatelessWidget {
  const _SrlsRankTile({
    required super.key,
    required this.rank,
    required this.index,
    required this.total,
    required this.draggableByHandle,
    required this.draggableByRow,
    this.muted = false,
  });

  final _SrlsBeltRank rank;
  final int index;
  final int total;
  final bool draggableByHandle;
  final bool draggableByRow;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final Color chromeColor = muted
        ? rank.color.withValues(alpha: 0.45)
        : rank.color;
    final Widget card = Card(
      elevation: muted ? 1 : 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: chromeColor.withValues(alpha: 0.75)),
      ),
      color: _kParchment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            _SrlsHandle(
              color: chromeColor,
              draggable: draggableByHandle,
              index: index,
            ),
            const SizedBox(width: 12),
            _SrlsRankIcon(rank: rank, muted: muted),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        rank.name,
                        style: TextStyle(
                          color: _kInkstone,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: muted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor:
                              _kInkstone.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        rank.kanji,
                        style: TextStyle(
                          color: _kCherry.withValues(alpha: 0.8),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _SrlsPositionPill(index: index, total: total),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    rank.tenet,
                    style: TextStyle(
                      color: _kInkstone.withValues(alpha: 0.7),
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            _SrlsBeltSwatch(color: chromeColor),
          ],
        ),
      ),
    );

    if (draggableByRow) {
      return ReorderableDelayedDragStartListener(
        index: index,
        child: card,
      );
    }
    return card;
  }
}

/// The rope-style drag handle — wrapped in a ReorderableDragStartListener
/// so a single press starts the drag without a long-press delay.
class _SrlsHandle extends StatelessWidget {
  const _SrlsHandle({
    required this.color,
    required this.draggable,
    required this.index,
  });

  final Color color;
  final bool draggable;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Widget visual = Container(
      width: 32,
      height: 52,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.8), width: 1.4),
      ),
      alignment: Alignment.center,
      child: CustomPaint(
        size: const Size(24, 40),
        painter: _SrlsHandleKnotPainter(color: color),
      ),
    );
    if (!draggable) {
      return Opacity(opacity: 0.5, child: visual);
    }
    return ReorderableDragStartListener(
      index: index,
      child: Semantics(
        label: 'Reorder handle for slot ${index + 1}',
        child: visual,
      ),
    );
  }
}

/// Paints a small rope knot on the drag handle.  Just three horizontal
/// bands, angled slightly to suggest a braid.
class _SrlsHandleKnotPainter extends CustomPainter {
  const _SrlsHandleKnotPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 3; i++) {
      final double y = (size.height / 4) * (i + 1);
      final double skew = (i - 1) * 2.0;
      canvas.drawLine(
        Offset(2 + skew, y),
        Offset(size.width - 2 - skew, y),
        paint,
      );
    }
    final Paint dotPaint = Paint()..color = color.withValues(alpha: 0.6);
    canvas.drawCircle(size.center(Offset.zero), 2.4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _SrlsHandleKnotPainter old) =>
      old.color != color;
}

/// A belt swatch painted at the end of each tile.  The swatch is a
/// horizontal rectangle with a single sensei stripe if the rank is
/// advanced (brown/red/silver/black).
class _SrlsBeltSwatch extends StatelessWidget {
  const _SrlsBeltSwatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.9), width: 1.2),
      ),
      child: CustomPaint(
        painter: _SrlsBeltSwatchPainter(color: color),
      ),
    );
  }
}

class _SrlsBeltSwatchPainter extends CustomPainter {
  const _SrlsBeltSwatchPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a single cream stripe to represent a sensei stripe on
    // advanced belts.
    final double brightness =
        (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
    final bool advanced = brightness < 0.6;
    if (advanced) {
      final Paint paint = Paint()
        ..color = _kCream.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      final Rect stripeRect = Rect.fromLTWH(
        size.width * 0.75,
        1.5,
        size.width * 0.2,
        size.height - 3,
      );
      canvas.drawRect(stripeRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SrlsBeltSwatchPainter old) =>
      old.color != color;
}

/// A circular icon showing the rank's emblematic glyph.
class _SrlsRankIcon extends StatelessWidget {
  const _SrlsRankIcon({required this.rank, required this.muted});

  final _SrlsBeltRank rank;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: rank.color.withValues(alpha: muted ? 0.15 : 0.22),
        border: Border.all(
          color: rank.color.withValues(alpha: muted ? 0.5 : 0.85),
          width: 1.4,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(rank.icon, color: _kInkstone, size: 18),
    );
  }
}

/// A small "slot N/M" pill shown next to the rank name.
class _SrlsPositionPill extends StatelessWidget {
  const _SrlsPositionPill({required this.index, required this.total});

  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _kBamboo.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.4)),
      ),
      child: Text(
        '${index + 1}/$total',
        style: const TextStyle(
          color: _kBamboo,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =====================================================================
// State diagram — a custom-painted flow showing the reorder lifecycle.
// =====================================================================
class _SrlsStateDiagramCard extends StatelessWidget {
  const _SrlsStateDiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.polyline_outlined, color: _kCherry, size: 18),
              SizedBox(width: 8),
              Text(
                'Lifecycle of a SliverReorderableList drag',
                style: TextStyle(
                  color: _kInkstone,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 16 / 7,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return CustomPaint(
                  painter: _SrlsStateDiagramPainter(
                    nodes: _kStateNodes,
                    edges: _kStateEdges,
                    canvasSize: Size(constraints.maxWidth, constraints.maxHeight),
                  ),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: _kStateNodes
                .map((_SrlsStateNode node) => _SrlsStateNodeChip(node: node))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SrlsStateNodeChip extends StatelessWidget {
  const _SrlsStateNodeChip({required this.node});

  final _SrlsStateNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: node.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: node.color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: node.color),
          ),
          const SizedBox(width: 6),
          Text(
            node.label,
            style: TextStyle(
              color: _kInkstone,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              node.detail,
              style: TextStyle(
                color: _kInkstone.withValues(alpha: 0.7),
                fontSize: 11,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for the state diagram.  Scales the canonical `_kStateNodes`
/// offsets (expressed in a 720×440 reference space) to fit whatever
/// canvas the card assigns.
class _SrlsStateDiagramPainter extends CustomPainter {
  const _SrlsStateDiagramPainter({
    required this.nodes,
    required this.edges,
    required this.canvasSize,
  });

  final List<_SrlsStateNode> nodes;
  final List<_SrlsStateEdge> edges;
  final Size canvasSize;

  static const Size _referenceSize = Size(720, 440);

  Offset _scale(Offset raw) {
    return Offset(
      raw.dx * (canvasSize.width / _referenceSize.width),
      raw.dy * (canvasSize.height / _referenceSize.height),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Background grid — very subtle, hints at a dojo tatami mat.
    final Paint gridPaint = Paint()
      ..color = _kBamboo.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    const double gridStep = 28;
    for (double x = 0; x < size.width; x += gridStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Edges first so node circles sit on top.
    for (final _SrlsStateEdge edge in edges) {
      final _SrlsStateNode fromNode = nodes.firstWhere(
        (_SrlsStateNode n) => n.id == edge.from,
      );
      final _SrlsStateNode toNode = nodes.firstWhere(
        (_SrlsStateNode n) => n.id == edge.to,
      );
      _paintEdge(canvas, _scale(fromNode.center), _scale(toNode.center), edge);
    }

    // Nodes.
    for (final _SrlsStateNode node in nodes) {
      _paintNode(canvas, _scale(node.center), node);
    }
  }

  void _paintNode(Canvas canvas, Offset center, _SrlsStateNode node) {
    final double radius = 30;
    final Paint fill = Paint()
      ..color = node.color.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    final Paint ring = Paint()
      ..color = node.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    canvas.drawCircle(center, radius, fill);
    canvas.drawCircle(center, radius, ring);

    final TextPainter label = TextPainter(
      text: TextSpan(
        text: node.label,
        style: const TextStyle(
          color: _kInkstone,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(
      canvas,
      Offset(center.dx - label.width / 2, center.dy - label.height / 2),
    );
  }

  void _paintEdge(
    Canvas canvas,
    Offset from,
    Offset to,
    _SrlsStateEdge edge,
  ) {
    final double radius = 30;
    final Offset delta = to - from;
    final double length = delta.distance;
    if (length < 1e-6) {
      return;
    }
    final Offset unit = delta / length;
    final Offset start = from + unit * radius;
    final Offset end = to - unit * radius;
    final Paint stroke = Paint()
      ..color = edge.emphasized
          ? _kCherry
          : _kInkstone.withValues(alpha: 0.6)
      ..strokeWidth = edge.emphasized ? 2.4 : 1.6
      ..style = PaintingStyle.stroke;

    final Offset midpoint = Offset(
      (start.dx + end.dx) / 2 + (unit.dy * edge.curve * length),
      (start.dy + end.dy) / 2 - (unit.dx * edge.curve * length),
    );

    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(midpoint.dx, midpoint.dy, end.dx, end.dy);
    canvas.drawPath(path, stroke);

    // Arrow head.
    final Offset tangent = end - midpoint;
    final double tangentLen = tangent.distance == 0 ? 1 : tangent.distance;
    final Offset tangentUnit = tangent / tangentLen;
    final Offset left = Offset(
      end.dx - tangentUnit.dx * 12 + tangentUnit.dy * 6,
      end.dy - tangentUnit.dy * 12 - tangentUnit.dx * 6,
    );
    final Offset right = Offset(
      end.dx - tangentUnit.dx * 12 - tangentUnit.dy * 6,
      end.dy - tangentUnit.dy * 12 + tangentUnit.dx * 6,
    );
    final Path arrow = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final Paint arrowFill = Paint()
      ..color = edge.emphasized
          ? _kCherry
          : _kInkstone.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    canvas.drawPath(arrow, arrowFill);

    // Label above the curve midpoint.
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: edge.label,
        style: TextStyle(
          color: edge.emphasized
              ? _kCherry
              : _kInkstone.withValues(alpha: 0.8),
          fontSize: 11,
          fontWeight: edge.emphasized ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160);
    final Offset labelAnchor = Offset(
      midpoint.dx - painter.width / 2,
      midpoint.dy - painter.height - 2,
    );
    final Rect labelBg = Rect.fromLTWH(
      labelAnchor.dx - 4,
      labelAnchor.dy - 2,
      painter.width + 8,
      painter.height + 4,
    );
    final Paint labelBgPaint = Paint()
      ..color = _kParchment.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(labelBg, const Radius.circular(4)),
      labelBgPaint,
    );
    painter.paint(canvas, labelAnchor);
  }

  @override
  bool shouldRepaint(covariant _SrlsStateDiagramPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.edges != edges ||
        oldDelegate.canvasSize != canvasSize;
  }
}

// =====================================================================
// Gesture chart — a DataTable mapping gestures to state transitions.
// =====================================================================
class _SrlsGestureChartCard extends StatelessWidget {
  const _SrlsGestureChartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.28)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor: WidgetStatePropertyAll<Color>(
            _kBamboo.withValues(alpha: 0.12),
          ),
          dividerThickness: 0.6,
          headingTextStyle: const TextStyle(
            color: _kInkstone,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 0.4,
          ),
          dataTextStyle: const TextStyle(
            color: _kInkstone,
            fontSize: 12.5,
            height: 1.35,
          ),
          columns: const <DataColumn>[
            DataColumn(label: Text('Gesture')),
            DataColumn(label: Text('Listener')),
            DataColumn(label: Text('Transition')),
            DataColumn(label: Text('Outcome')),
          ],
          rows: _kGestureRows.map((_SrlsGestureEntry row) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _kCherry,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      row.gesture,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                )),
                DataCell(Text(
                  row.listener,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                )),
                DataCell(Text(
                  row.transition,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: _kBamboo,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                DataCell(ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Text(row.outcome),
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// =====================================================================
// Rules card — the six tenets of imperative reorder, rendered as a
// vertically-stacked list of rule tiles.
// =====================================================================
class _SrlsRulesCard extends StatelessWidget {
  const _SrlsRulesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.book_outlined, color: _kCherry, size: 18),
              SizedBox(width: 8),
              Text(
                'Rules of the Dojo',
                style: TextStyle(
                  color: _kInkstone,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _kDojoRules.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == _kDojoRules.length - 1 ? 10 : 12,
              ),
              child: _SrlsRuleRow(rule: _kDojoRules[i], index: i + 1),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCherry.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kCherry.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.tips_and_updates_outlined,
                    color: _kCherry, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Mantra: "If newIndex > oldIndex, subtract one — then '
                    'remove, then insert."  Recite before every refactor.',
                    style: TextStyle(
                      color: _kInkstone.withValues(alpha: 0.85),
                      fontSize: 12.5,
                      height: 1.35,
                      fontStyle: FontStyle.italic,
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
}

class _SrlsRuleRow extends StatelessWidget {
  const _SrlsRuleRow({required this.rule, required this.index});

  final _SrlsRule rule;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _kBamboo.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBamboo.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Icon(rule.icon, color: _kBamboo, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _kCherry.withValues(alpha: 0.18),
                      border: Border.all(
                        color: _kCherry.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: _kCherry,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      rule.title,
                      style: const TextStyle(
                        color: _kInkstone,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                rule.body,
                style: TextStyle(
                  color: _kInkstone.withValues(alpha: 0.78),
                  fontSize: 12.5,
                  height: 1.38,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// Pitfall card — cancelReorder is a no-op if nothing is being dragged.
// =====================================================================
class _SrlsPitfallCard extends StatelessWidget {
  const _SrlsPitfallCard({
    required this.attempts,
    required this.noOps,
    required this.active,
  });

  final int attempts;
  final int noOps;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final Color tone = active ? _kCherry : _kAgedGold;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tone.withValues(alpha: 0.55)),
        gradient: LinearGradient(
          colors: <Color>[
            tone.withValues(alpha: 0.06),
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_outlined, color: tone, size: 20),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'cancelReorder() is safe to call, but it is NOT a state '
                  'resetter — it only aborts an in-flight drag.',
                  style: TextStyle(
                    color: _kInkstone,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Invoking it while idle will look like "nothing happened" from '
            'the UI\'s perspective — because nothing did.  If you are '
            'trying to undo a completed reorder, you need to mutate your '
            'own model yourself: cancelReorder cannot rewind a drop that '
            'has already fired onReorder.',
            style: TextStyle(
              color: _kInkstone.withValues(alpha: 0.8),
              fontSize: 12.8,
              height: 1.38,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _SrlsStat(
                label: 'cancelReorder() attempts',
                value: '$attempts',
                color: _kCherry,
              ),
              const SizedBox(width: 10),
              _SrlsStat(
                label: 'of which were no-ops',
                value: '$noOps',
                color: _kAgedGold,
              ),
              const SizedBox(width: 10),
              _SrlsStat(
                label: 'drag active now',
                value: active ? 'yes' : 'no',
                color: active ? _kBamboo : _kInkstone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SrlsStat extends StatelessWidget {
  const _SrlsStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _kInkstone.withValues(alpha: 0.75),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Log card — imperative operations timeline.
// =====================================================================
class _SrlsLogCard extends StatelessWidget {
  const _SrlsLogCard({required this.entries});

  final List<_SrlsLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _kInkstone,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.5)),
      ),
      constraints: const BoxConstraints(maxHeight: 260),
      child: ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          return _SrlsLogRow(entry: entries[index]);
        },
      ),
    );
  }
}

class _SrlsLogRow extends StatelessWidget {
  const _SrlsLogRow({required this.entry});

  final _SrlsLogEntry entry;

  Color _toneColor() {
    switch (entry.tone) {
      case _SrlsLogTone.info:
        return _kCream;
      case _SrlsLogTone.success:
        return _kBamboo;
      case _SrlsLogTone.warning:
        return _kAgedGold;
      case _SrlsLogTone.error:
        return _kCherry;
    }
  }

  String _timestampLabel() {
    final DateTime dt = entry.timestamp;
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final Color tone = _toneColor();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(shape: BoxShape.circle, color: tone),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      entry.title,
                      style: const TextStyle(
                        color: _kCream,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    _timestampLabel(),
                    style: TextStyle(
                      color: _kCream.withValues(alpha: 0.55),
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                entry.detail,
                style: TextStyle(
                  color: _kCream.withValues(alpha: 0.76),
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _SrlsLogTone { info, success, warning, error }

class _SrlsLogEntry {
  const _SrlsLogEntry({
    required this.timestamp,
    required this.title,
    required this.detail,
    required this.tone,
  });

  final DateTime timestamp;
  final String title;
  final String detail;
  final _SrlsLogTone tone;
}

// =====================================================================
// Footer — final note and mini "signature" of the demo.
// =====================================================================
class _SrlsFooter extends StatelessWidget {
  const _SrlsFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBamboo.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _kCherry.withValues(alpha: 0.15),
              border: Border.all(color: _kCherry.withValues(alpha: 0.6)),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.emoji_events_outlined,
              color: _kCherry,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'End of the dojo.',
                  style: TextStyle(
                    color: _kInkstone,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'You have drilled SliverReorderableListState from rope '
                  'handles to state diagrams, from gesture chart to '
                  'pitfall card.  Remember the newIndex shift; rest well.',
                  style: TextStyle(
                    color: _kInkstone,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
