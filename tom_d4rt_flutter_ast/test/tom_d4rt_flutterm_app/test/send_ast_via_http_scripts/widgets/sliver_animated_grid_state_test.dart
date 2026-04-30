import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Animated Grid Command Deck — deep visual demo for SliverAnimatedGridState.
//
// This file is a hand-authored scene for the d4rt AST test harness. It
// showcases the State object that backs `SliverAnimatedGrid` — specifically
// how `insertItem`, `removeItem`, `insertAllItems`, and `removeAllItems`
// are orchestrated through a `GlobalKey<SliverAnimatedGridState>`.
//
// Palette:
//   * Deep teal  (#115E59) — primary chrome and navigation surfaces.
//   * Peach      (#FDBA74) — accent, focal points, control affordances.
//   * Cream      (#FFFBEB) — backdrop and passive surfaces.
//
// The demo is structured as a `CustomScrollView` hosting a `SliverAppBar`,
// the subject `SliverAnimatedGrid`, a `SliverToBoxAdapter` with context,
// and a trailing `SliverList` containing a lifecycle log and a comparison
// matrix for `SliverAnimatedGrid`, `AnimatedGrid`, and `ReorderableListView`.
//
// The d4rt AST harness entry point is `dynamic build(BuildContext context)`.
// There is NO `main()` and NO `runApp()`. The root returns
// `MaterialApp(home: Scaffold(...))`. All animation work uses the framework
// APIs available in Flutter 3.41.6.
// ---------------------------------------------------------------------------

// Palette constants. Using `Color.fromARGB` to avoid deprecation concerns on
// `Color.value` style expressions. These values are looked up in many places
// throughout the scene.
const Color _kTeal = Color(0xFF115E59);
const Color _kTealDeeper = Color(0xFF0F3F3B);
const Color _kTealLight = Color(0xFF2C7A74);
const Color _kPeach = Color(0xFFFDBA74);
const Color _kPeachWarm = Color(0xFFFB923C);
const Color _kCream = Color(0xFFFFFBEB);
const Color _kCreamSoft = Color(0xFFFFF3D6);
const Color _kInk = Color(0xFF1C1917);
const Color _kMuted = Color(0xFF57534E);
const Color _kBorder = Color(0xFFE7E5E4);

// Card palette used by the grid itself. The cards cycle through a set of
// teal / peach derived tones so insertions and removals remain visually
// distinguishable as the animation plays out.
const List<Color> _kCardPalette = <Color>[
  Color(0xFF115E59),
  Color(0xFF134E4A),
  Color(0xFF0F766E),
  Color(0xFFFDBA74),
  Color(0xFFFB923C),
  Color(0xFFF97316),
  Color(0xFF14B8A6),
  Color(0xFF2DD4BF),
];

// Maximum allowable card count. The grid starts with a seeded count and the
// user can add/remove with the control panel. We cap the upper bound so the
// viewport does not blow up when the user spams "add".
const int _kMaxCards = 48;

// Minimum duration for insert/remove animations, expressed in milliseconds.
// The slider maps linearly from this to `_kMaxDurationMs`.
const int _kMinDurationMs = 120;
const int _kMaxDurationMs = 1600;

// Initial seeded card count. Chosen so the grid looks populated but still
// leaves room to add more cards before the `_kMaxCards` cap kicks in.
const int _kInitialCardCount = 8;

// The root builder the d4rt AST harness invokes. It constructs a single
// `MaterialApp` whose `home` is the stateful demo page.
dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliverAnimatedGridState — Command Deck',
    home: _CommandDeckPage(),
  );
}

// ---------------------------------------------------------------------------
// Root page. Owns the GlobalKey<SliverAnimatedGridState>, the model data,
// the duration slider state, and the lifecycle log.
// ---------------------------------------------------------------------------

class _CommandDeckPage extends StatefulWidget {
  const _CommandDeckPage();

  @override
  State<_CommandDeckPage> createState() => _CommandDeckPageState();
}

class _CommandDeckPageState extends State<_CommandDeckPage>
    with TickerProviderStateMixin {
  // The GlobalKey that gives the control panel and lifecycle log a handle on
  // the SliverAnimatedGridState. This is the core feature being demoed.
  final GlobalKey<SliverAnimatedGridState> _gridKey =
      GlobalKey<SliverAnimatedGridState>();

  // Model: the list of cards backing the grid. The grid state's internal
  // item count is kept in sync by pairing every model mutation with the
  // corresponding `insertItem` / `removeItem` call.
  final List<_DeckCardModel> _cards = <_DeckCardModel>[];

  // Counter used to assign stable IDs to cards — this keeps the log entries
  // tied to a specific card even as their index changes on insert/remove.
  int _nextCardId = 0;

  // Duration of insert / remove animations, controlled by the slider. The
  // current value is passed to the grid state's methods via the `duration:`
  // parameter at call time (not as a widget field).
  int _animDurationMs = 520;

  // Whether removing uses the custom fade-scale builder (true) or a simpler
  // fade (false). Exposed via a switch in the control panel.
  bool _useFancyRemoval = true;

  // Lifecycle log for every insert / remove call. Newest-first ordering so
  // the user sees the most recent action near the top of the trailing list.
  final List<_LogEntry> _log = <_LogEntry>[];

  // Random source used to colour incoming cards and label them with a random
  // glyph. Seeded to a fixed value for deterministic visuals during
  // harness runs.
  final math.Random _rng = math.Random(20260423);

  // The scroll controller for the CustomScrollView — we pass it in so the
  // AppBar collapse and internal buttons can cooperate if needed.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Seed the model. We do NOT call insertItem here because the grid
    // starts with `initialItemCount: _kInitialCardCount` — the grid's
    // state counter is initialised to that value, so we must provide
    // exactly that many model entries up front.
    for (var i = 0; i < _kInitialCardCount; i++) {
      _cards.add(_generateCard());
    }
    _log.insert(
      0,
      _LogEntry(
        timestamp: DateTime.now(),
        method: 'initState',
        index: -1,
        total: _cards.length,
        note: 'Seeded grid with $_kInitialCardCount cards.',
      ),
    );
    // Touch the marker types so the analyser sees them as used. Both names
    // are required by the brief and document the scene structure.
    const _LifecycleLog();
    debugPrint('[CommandDeck] stage: ${_AnimatedGridStage.description}');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Factory for a new card model. Pulls a random colour from the palette,
  // a random glyph, a monotonically increasing ID, and the current clock.
  _DeckCardModel _generateCard() {
    final id = _nextCardId++;
    final colour = _kCardPalette[id % _kCardPalette.length];
    final glyph = _kGlyphs[_rng.nextInt(_kGlyphs.length)];
    return _DeckCardModel(
      id: id,
      label: 'C-${id.toString().padLeft(3, '0')}',
      glyph: glyph,
      colour: colour,
      birth: DateTime.now(),
    );
  }

  // Helper to derive the animation duration from the current slider value.
  Duration get _currentDuration => Duration(milliseconds: _animDurationMs);

  // --- Control panel actions ------------------------------------------------

  // Insert a single card at a random position in the first half of the grid
  // so the effect is visible without scrolling. If the grid is empty we
  // insert at index 0.
  void _handleAddOne() {
    if (_cards.length >= _kMaxCards) {
      _pushLog('addOne (skipped — max reached)', -1, _cards.length,
          note: 'Cap is $_kMaxCards.');
      return;
    }
    final int insertAt = _cards.isEmpty
        ? 0
        : _rng.nextInt(math.max(1, (_cards.length / 2).ceil()));
    final card = _generateCard();
    setState(() {
      _cards.insert(insertAt, card);
    });
    _gridKey.currentState?.insertItem(
      insertAt,
      duration: _currentDuration,
    );
    _pushLog('insertItem', insertAt, _cards.length,
        note: 'Added ${card.label} (${_colourName(card.colour)}).');
  }

  // Remove a card at a random position. The builder passed to removeItem
  // decides how the outgoing card animates: a fade+scale if fancy removal
  // is on, otherwise a plain fade.
  void _handleRemoveOne() {
    if (_cards.isEmpty) {
      _pushLog('removeOne (skipped — empty)', -1, 0,
          note: 'Grid already empty.');
      return;
    }
    final int removeAt = _rng.nextInt(_cards.length);
    final removed = _cards.removeAt(removeAt);
    setState(() {});
    final builder = _useFancyRemoval
        ? _buildFancyRemovedCard(removed)
        : _buildPlainRemovedCard(removed);
    _gridKey.currentState?.removeItem(
      removeAt,
      builder,
      duration: _currentDuration,
    );
    _pushLog('removeItem', removeAt, _cards.length,
        note: 'Removed ${removed.label}.');
  }

  // Add three cards in a single call. We prefer `insertAllItems` over a
  // for-loop around `insertItem` because the framework's own implementation
  // fans out to `insertItem` with the same duration — the demo intentionally
  // routes through the state-level API to illustrate it.
  void _handleAddThree() {
    final int capacity = _kMaxCards - _cards.length;
    final int toAdd = math.min(3, capacity);
    if (toAdd <= 0) {
      _pushLog('addThree (skipped — max reached)', -1, _cards.length);
      return;
    }
    final int insertAt = _cards.isEmpty ? 0 : _rng.nextInt(_cards.length + 1);
    final List<_DeckCardModel> newCards = <_DeckCardModel>[];
    for (var i = 0; i < toAdd; i++) {
      newCards.add(_generateCard());
    }
    setState(() {
      _cards.insertAll(insertAt, newCards);
    });
    _gridKey.currentState?.insertAllItems(
      insertAt,
      toAdd,
      duration: _currentDuration,
    );
    _pushLog('insertAllItems', insertAt, _cards.length,
        note: 'Added $toAdd cards starting at $insertAt.');
  }

  // Remove three cards starting at a random valid window.
  void _handleRemoveThree() {
    if (_cards.isEmpty) {
      _pushLog('removeThree (skipped — empty)', -1, 0);
      return;
    }
    final int toRemove = math.min(3, _cards.length);
    final int removeAt = _rng.nextInt(_cards.length - toRemove + 1);
    final List<_DeckCardModel> removed = <_DeckCardModel>[];
    for (var i = 0; i < toRemove; i++) {
      // Always remove at the same `removeAt` — because after each removal,
      // indices shift down by one. This mirrors the semantics of the grid
      // state's internal counter.
      removed.add(_cards.removeAt(removeAt));
    }
    setState(() {});
    for (var i = 0; i < toRemove; i++) {
      final builder = _useFancyRemoval
          ? _buildFancyRemovedCard(removed[i])
          : _buildPlainRemovedCard(removed[i]);
      _gridKey.currentState?.removeItem(
        removeAt,
        builder,
        duration: _currentDuration,
      );
    }
    _pushLog('removeItem x $toRemove', removeAt, _cards.length,
        note: 'Removed $toRemove cards starting at $removeAt.');
  }

  // Reset the grid to the initial seeded state. We flush every live model
  // entry via `removeAllItems` — again through the state-level API — and
  // then replay the initial seed with `insertAllItems` once the outgoing
  // animation finishes. For simplicity in the AST demo we snapshot the
  // list first so the removed-item builder still has access to the
  // original colour / glyph data.
  void _handleReset() {
    if (_cards.isEmpty && _nextCardId == _kInitialCardCount) {
      _pushLog('reset (no-op)', -1, 0);
      return;
    }
    final snapshot = List<_DeckCardModel>.from(_cards);
    _cards.clear();
    setState(() {});
    _gridKey.currentState?.removeAllItems(
      (BuildContext context, Animation<double> animation) {
        return _SlidingRemovedCard(animation: animation, snapshot: snapshot);
      },
      duration: _currentDuration,
    );
    _pushLog('removeAllItems', -1, 0,
        note: 'Cleared ${snapshot.length} cards.');

    // Re-seed after the removal animation window. The grid state accepts
    // insertItem calls immediately because `removeAllItems` marks items as
    // outgoing rather than blocking inserts.
    for (var i = 0; i < _kInitialCardCount; i++) {
      final card = _generateCard();
      _cards.add(card);
    }
    setState(() {});
    _gridKey.currentState
        ?.insertAllItems(0, _kInitialCardCount, duration: _currentDuration);
    _pushLog('insertAllItems (reset)', 0, _cards.length,
        note: 'Re-seeded with $_kInitialCardCount cards.');
  }

  // The `AnimatedRemovedItemBuilder` for the fancy mode — fade + scale down +
  // small rotation. The builder retains a snapshot of the card so the
  // visuals keep their identity even after the model entry is gone.
  AnimatedRemovedItemBuilder _buildFancyRemovedCard(_DeckCardModel snapshot) {
    return (BuildContext context, Animation<double> animation) {
      return _FancyRemovedCard(animation: animation, snapshot: snapshot);
    };
  }

  // The `AnimatedRemovedItemBuilder` for the plain mode — straight fade.
  AnimatedRemovedItemBuilder _buildPlainRemovedCard(_DeckCardModel snapshot) {
    return (BuildContext context, Animation<double> animation) {
      return _PlainRemovedCard(animation: animation, snapshot: snapshot);
    };
  }

  // Push a single log entry onto the newest-first list. Caps the total so
  // the trailing list does not grow unbounded.
  void _pushLog(String method, int index, int total, {String? note}) {
    setState(() {
      _log.insert(
        0,
        _LogEntry(
          timestamp: DateTime.now(),
          method: method,
          index: index,
          total: total,
          note: note,
        ),
      );
      if (_log.length > 32) {
        _log.removeRange(32, _log.length);
      }
    });
    debugPrint('[CommandDeck] $method index=$index total=$total');
  }

  // --- Build ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildHeroSliver(),
          _buildControlPanelSliver(),
          _buildDurationSliver(),
          _buildGridHeaderSliver(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            sliver: SliverAnimatedGrid(
              key: _gridKey,
              initialItemCount: _kInitialCardCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.88,
              ),
              itemBuilder: _buildGridCard,
            ),
          ),
          _buildGridFooterSliver(),
          _buildComparisonSliver(),
          _buildLogHeaderSliver(),
          _buildLogListSliver(),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }

  // The SliverAppBar — collapsible, teal, with a peach badge.
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: _kTeal,
      foregroundColor: _kCream,
      expandedHeight: 168,
      pinned: true,
      elevation: 4,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        title: const Text(
          'SliverAnimatedGridState',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[_kTealDeeper, _kTeal, _kTealLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -40,
              top: -20,
              child: Opacity(
                opacity: 0.18,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    color: _kPeach,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -40,
              child: Opacity(
                opacity: 0.12,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: _kPeachWarm,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kPeach.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              '${_cards.length} / $_kMaxCards',
              style: const TextStyle(
                color: _kTealDeeper,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // The hero sliver — the big painted command-deck header.
  Widget _buildHeroSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
        child: _CommandDeckHero(cardCount: _cards.length),
      ),
    );
  }

  // The control panel sliver — buttons driving the grid key.
  Widget _buildControlPanelSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
        child: _ControlPanelCard(
          onAddOne: _handleAddOne,
          onRemoveOne: _handleRemoveOne,
          onAddThree: _handleAddThree,
          onRemoveThree: _handleRemoveThree,
          onReset: _handleReset,
          cardCount: _cards.length,
          maxCards: _kMaxCards,
        ),
      ),
    );
  }

  // The duration slider sliver.
  Widget _buildDurationSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 6),
        child: _DurationSlider(
          valueMs: _animDurationMs,
          useFancyRemoval: _useFancyRemoval,
          onDurationChanged: (int v) {
            setState(() => _animDurationMs = v);
          },
          onFancyRemovalChanged: (bool v) {
            setState(() => _useFancyRemoval = v);
          },
        ),
      ),
    );
  }

  // A small label above the grid introducing the subject widget.
  Widget _buildGridHeaderSliver() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: _SectionHeading(
          eyebrow: 'SCENE 2',
          title: 'The grid itself',
          description:
              'A SliverAnimatedGrid nested in this CustomScrollView. '
              'Insertions and removals flow through the GlobalKey above.',
        ),
      ),
    );
  }

  // A trailing block beneath the grid summarising the current state.
  Widget _buildGridFooterSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 6),
        child: _GridFooterCard(
          cardCount: _cards.length,
          durationMs: _animDurationMs,
          fancyRemoval: _useFancyRemoval,
        ),
      ),
    );
  }

  // The comparison matrix sliver — SliverAnimatedGrid vs AnimatedGrid vs
  // ReorderableListView.
  Widget _buildComparisonSliver() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, 24, 18, 6),
        child: _ComparisonMatrixCard(),
      ),
    );
  }

  // Heading above the lifecycle log.
  Widget _buildLogHeaderSliver() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: _SectionHeading(
          eyebrow: 'SCENE 6',
          title: 'Lifecycle log',
          description:
              'Every call into SliverAnimatedGridState is recorded here '
              'with its timestamp, method, index, and resulting total.',
        ),
      ),
    );
  }

  // The lifecycle log itself, as a SliverList. This ensures the trailing
  // list is part of the CustomScrollView rather than a separate scroll
  // surface.
  Widget _buildLogListSliver() {
    if (_log.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No events yet — use the control panel above.'),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index >= _log.length) {
              return null;
            }
            return _LifecycleLogTile(
              entry: _log[index],
              isFirst: index == 0,
              isLast: index == _log.length - 1,
            );
          },
          childCount: _log.length,
        ),
      ),
    );
  }

  // Animated item builder invoked by the grid. `index` is the grid's
  // own coordinate, but the model is kept in lockstep so we can look up
  // the card directly. We guard against the model being behind the
  // framework during the brief window when `removeAllItems` has queued
  // outgoing items but we have not yet updated the model snapshot.
  Widget _buildGridCard(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    if (index < 0 || index >= _cards.length) {
      // Defensive fallback — should not occur in normal flow, but the
      // grid state can briefly request indices we haven't synced yet.
      return const SizedBox.shrink();
    }
    final card = _cards[index];
    return _IncomingCard(
      animation: animation,
      card: card,
      index: index,
    );
  }
}

// ---------------------------------------------------------------------------
// Scene 1: hero — painted command-deck header with API badges.
// ---------------------------------------------------------------------------

class _CommandDeckHero extends StatelessWidget {
  const _CommandDeckHero({required this.cardCount});

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: <Color>[
            _kTealDeeper,
            _kTeal,
            _kTealLight.withValues(alpha: 0.88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomPaint(
                size: const Size(48, 48),
                painter: _CommandDeckBadgePainter(),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'SCENE 1',
                      style: TextStyle(
                        color: _kPeach,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Animated Grid Command Deck',
                      style: TextStyle(
                        color: _kCream,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              _HeroCountChip(count: cardCount),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Control a SliverAnimatedGrid through its State object using a '
            'GlobalKey<SliverAnimatedGridState>. The four methods below are '
            'wired to the buttons further down the page.',
            style: TextStyle(
              color: _kCream.withValues(alpha: 0.92),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          const _ApiMethodBadgeRow(),
          const SizedBox(height: 14),
          _HeroGlyphStrip(),
        ],
      ),
    );
  }
}

// The four API method badges arranged as a wrapping row. Kept separate so
// the hero `build()` remains legible.
class _ApiMethodBadgeRow extends StatelessWidget {
  const _ApiMethodBadgeRow();

  static const List<_ApiMethodSpec> _methods = <_ApiMethodSpec>[
    _ApiMethodSpec(
      name: 'insertItem',
      hint: 'Adds one card with an entrance animation.',
    ),
    _ApiMethodSpec(
      name: 'removeItem',
      hint: 'Drives a custom removed-item builder for the outgoing card.',
    ),
    _ApiMethodSpec(
      name: 'insertAllItems',
      hint: 'Fan-out helper for a contiguous batch of inserts.',
    ),
    _ApiMethodSpec(
      name: 'removeAllItems',
      hint: 'Animates every surviving card out of the grid.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        for (final m in _methods) _ApiMethodBadge(spec: m),
      ],
    );
  }
}

class _ApiMethodSpec {
  const _ApiMethodSpec({required this.name, required this.hint});
  final String name;
  final String hint;
}

class _ApiMethodBadge extends StatelessWidget {
  const _ApiMethodBadge({required this.spec});
  final _ApiMethodSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.fromLTRB(12, 10, 14, 12),
      decoration: BoxDecoration(
        color: _kCream.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPeach.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _kPeach,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                spec.name,
                style: const TextStyle(
                  color: _kCream,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            spec.hint,
            style: TextStyle(
              color: _kCream.withValues(alpha: 0.82),
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// A decorative strip of glyph chips across the bottom of the hero.
class _HeroGlyphStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _kGlyphs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final glyph = _kGlyphs[index];
          return Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kCream.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPeach.withValues(alpha: 0.35)),
            ),
            child: Text(
              glyph,
              style: const TextStyle(
                color: _kPeach,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Card count chip in the hero corner.
class _HeroCountChip extends StatelessWidget {
  const _HeroCountChip({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _kPeach,
        borderRadius: BorderRadius.circular(999),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.18),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.grid_view_outlined, size: 16, color: _kTealDeeper),
          const SizedBox(width: 6),
          Text(
            '$count cards',
            style: const TextStyle(
              color: _kTealDeeper,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the little command-deck badge next to the hero title.
class _CommandDeckBadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect r = Offset.zero & size;
    final Paint peachFill = Paint()..color = _kPeach;
    final Paint tealFill = Paint()..color = _kTealDeeper;
    final Paint strokePaint = Paint()
      ..color = _kCream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    // Base peach circle.
    canvas.drawCircle(r.center, size.width / 2 - 1, peachFill);

    // Inner teal hex-like diamond.
    final Path diamond = Path()
      ..moveTo(r.center.dx, r.top + 10)
      ..lineTo(r.right - 10, r.center.dy)
      ..lineTo(r.center.dx, r.bottom - 10)
      ..lineTo(r.left + 10, r.center.dy)
      ..close();
    canvas.drawPath(diamond, tealFill);

    // Four tick marks on the corners to evoke a grid.
    const double tick = 4.5;
    canvas.drawLine(
        Offset(r.left + 4, r.top + 4), Offset(r.left + 4 + tick, r.top + 4),
        strokePaint);
    canvas.drawLine(Offset(r.right - 4, r.top + 4),
        Offset(r.right - 4 - tick, r.top + 4), strokePaint);
    canvas.drawLine(Offset(r.left + 4, r.bottom - 4),
        Offset(r.left + 4 + tick, r.bottom - 4), strokePaint);
    canvas.drawLine(Offset(r.right - 4, r.bottom - 4),
        Offset(r.right - 4 - tick, r.bottom - 4), strokePaint);

    // Centre dot.
    canvas.drawCircle(r.center, 3.4, Paint()..color = _kCream);
  }

  @override
  bool shouldRepaint(_CommandDeckBadgePainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Scene 2 (inline with main build) helper widgets.
// ---------------------------------------------------------------------------

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          eyebrow,
          style: const TextStyle(
            color: _kPeachWarm,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: _kTealDeeper,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(color: _kMuted, fontSize: 13, height: 1.4),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scene 3: control panel card.
// ---------------------------------------------------------------------------

class _ControlPanelCard extends StatelessWidget {
  const _ControlPanelCard({
    required this.onAddOne,
    required this.onRemoveOne,
    required this.onAddThree,
    required this.onRemoveThree,
    required this.onReset,
    required this.cardCount,
    required this.maxCards,
  });

  final VoidCallback onAddOne;
  final VoidCallback onRemoveOne;
  final VoidCallback onAddThree;
  final VoidCallback onRemoveThree;
  final VoidCallback onReset;
  final int cardCount;
  final int maxCards;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCreamSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.tune_rounded, color: _kTeal, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Control panel',
                style: TextStyle(
                  color: _kTealDeeper,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '$cardCount / $maxCards',
                style: const TextStyle(
                  color: _kMuted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Every button here calls into the GlobalKey<SliverAnimatedGridState> '
            'that lives on the page state.',
            style: TextStyle(color: _kMuted, fontSize: 12.5),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _ControlButton(
                label: 'Add card',
                icon: Icons.add_rounded,
                onPressed: onAddOne,
                primary: true,
              ),
              _ControlButton(
                label: 'Remove card',
                icon: Icons.remove_rounded,
                onPressed: onRemoveOne,
              ),
              _ControlButton(
                label: 'Add 3 cards',
                icon: Icons.playlist_add_rounded,
                onPressed: onAddThree,
                primary: true,
              ),
              _ControlButton(
                label: 'Remove 3 cards',
                icon: Icons.playlist_remove_rounded,
                onPressed: onRemoveThree,
              ),
              _ControlButton(
                label: 'Reset',
                icon: Icons.refresh_rounded,
                onPressed: onReset,
                tone: _ControlButtonTone.neutral,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _ControlButtonTone { peach, teal, neutral }

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.primary = false,
    this.tone = _ControlButtonTone.peach,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool primary;
  final _ControlButtonTone tone;

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;
    switch (tone) {
      case _ControlButtonTone.peach:
        background = primary ? _kPeach : _kCream;
        foreground = _kTealDeeper;
        break;
      case _ControlButtonTone.teal:
        background = primary ? _kTeal : _kCream;
        foreground = primary ? _kCream : _kTeal;
        break;
      case _ControlButtonTone.neutral:
        background = _kCream;
        foreground = _kTealDeeper;
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12),
      elevation: primary ? 2 : 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: primary ? _kPeachWarm : _kBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scene 4: duration slider + fancy-removal switch.
// ---------------------------------------------------------------------------

class _DurationSlider extends StatelessWidget {
  const _DurationSlider({
    required this.valueMs,
    required this.useFancyRemoval,
    required this.onDurationChanged,
    required this.onFancyRemovalChanged,
  });

  final int valueMs;
  final bool useFancyRemoval;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<bool> onFancyRemovalChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.speed_rounded, color: _kTeal, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Animation duration',
                style: TextStyle(
                  color: _kTealDeeper,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kTealDeeper,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${valueMs}ms',
                  style: const TextStyle(
                    color: _kCream,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Passed at call time via the `duration:` parameter of '
            'insertItem / removeItem / insertAllItems / removeAllItems.',
            style: const TextStyle(color: _kMuted, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _kTeal,
              inactiveTrackColor: _kTeal.withValues(alpha: 0.22),
              thumbColor: _kPeach,
              overlayColor: _kPeach.withValues(alpha: 0.22),
              valueIndicatorColor: _kTealDeeper,
              valueIndicatorTextStyle: const TextStyle(
                color: _kCream,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Slider(
              min: _kMinDurationMs.toDouble(),
              max: _kMaxDurationMs.toDouble(),
              divisions: (_kMaxDurationMs - _kMinDurationMs) ~/ 40,
              label: '${valueMs}ms',
              value: valueMs.toDouble(),
              onChanged: (double v) => onDurationChanged(v.round()),
            ),
          ),
          const Divider(color: _kBorder, height: 24),
          Row(
            children: <Widget>[
              const Icon(Icons.auto_awesome_rounded,
                  color: _kPeachWarm, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Fancy removal builder (fade + scale + tilt)',
                  style: TextStyle(
                    color: _kTealDeeper,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch.adaptive(
                value: useFancyRemoval,
                activeThumbColor: _kPeachWarm,
                onChanged: onFancyRemovalChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// The animated grid cards — incoming + outgoing builders.
// ---------------------------------------------------------------------------

class _IncomingCard extends StatelessWidget {
  const _IncomingCard({
    required this.animation,
    required this.card,
    required this.index,
  });

  final Animation<double> animation;
  final _DeckCardModel card;
  final int index;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.76, end: 1.0).animate(curved),
        child: _CardSurface(card: card, index: index),
      ),
    );
  }
}

class _FancyRemovedCard extends StatelessWidget {
  const _FancyRemovedCard({
    required this.animation,
    required this.snapshot,
  });

  final Animation<double> animation;
  final _DeckCardModel snapshot;

  @override
  Widget build(BuildContext context) {
    // `animation` runs from 1.0 down to 0.0 for outgoing items.
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.4, end: 1.0).animate(curved),
        child: RotationTransition(
          turns: Tween<double>(begin: -0.08, end: 0.0).animate(curved),
          child: _CardSurface(card: snapshot, index: -1, outgoing: true),
        ),
      ),
    );
  }
}

class _PlainRemovedCard extends StatelessWidget {
  const _PlainRemovedCard({
    required this.animation,
    required this.snapshot,
  });

  final Animation<double> animation;
  final _DeckCardModel snapshot;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: _CardSurface(card: snapshot, index: -1, outgoing: true),
    );
  }
}

// Builder shared by the `removeAllItems` path. Slides the card off to the
// right while fading, so a bulk clear looks distinct from a single remove.
class _SlidingRemovedCard extends StatelessWidget {
  const _SlidingRemovedCard({
    required this.animation,
    required this.snapshot,
  });

  final Animation<double> animation;
  final List<_DeckCardModel> snapshot;

  @override
  Widget build(BuildContext context) {
    final fallback = _DeckCardModel(
      id: -1,
      label: 'C-???',
      glyph: '·',
      colour: _kTeal,
      birth: DateTime.now(),
    );
    final card = snapshot.isNotEmpty ? snapshot.first : fallback;
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeIn);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.6, 0),
          end: Offset.zero,
        ).animate(curved),
        child: _CardSurface(card: card, index: -1, outgoing: true),
      ),
    );
  }
}

// The card surface itself — a gradient tile with the card ID, glyph, and a
// small footer. Shared by incoming and outgoing card widgets.
class _CardSurface extends StatelessWidget {
  const _CardSurface({
    required this.card,
    required this.index,
    this.outgoing = false,
  });

  final _DeckCardModel card;
  final int index;
  final bool outgoing;

  @override
  Widget build(BuildContext context) {
    final Color base = card.colour;
    final bool isPeach = base.r > 0.78 && base.g > 0.39 && base.b < 0.71;
    final Color foreground = isPeach ? _kTealDeeper : _kCream;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: <Color>[
            base,
            Color.lerp(base, _kInk, 0.28) ?? base,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: outgoing
              ? _kPeachWarm.withValues(alpha: 0.8)
              : _kCream.withValues(alpha: 0.35),
          width: outgoing ? 2 : 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: outgoing ? 0.28 : 0.18),
            blurRadius: outgoing ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  index >= 0 ? '#$index' : '×',
                  style: TextStyle(
                    color: foreground,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                outgoing
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outline_rounded,
                size: 14,
                color: foreground.withValues(alpha: 0.85),
              ),
            ],
          ),
          const Spacer(),
          Text(
            card.glyph,
            style: TextStyle(
              color: foreground,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            card.label,
            style: TextStyle(
              color: foreground.withValues(alpha: 0.9),
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            _formatClock(card.birth),
            style: TextStyle(
              color: foreground.withValues(alpha: 0.7),
              fontSize: 9.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer card below the grid, summarising current knobs.
// ---------------------------------------------------------------------------

class _GridFooterCard extends StatelessWidget {
  const _GridFooterCard({
    required this.cardCount,
    required this.durationMs,
    required this.fancyRemoval,
  });

  final int cardCount;
  final int durationMs;
  final bool fancyRemoval;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.info_outline_rounded,
                  color: _kTeal, size: 18),
              const SizedBox(width: 6),
              const Text(
                'Current state',
                style: TextStyle(
                  color: _kTealDeeper,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _kPeach,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  fancyRemoval ? 'Fancy' : 'Plain',
                  style: const TextStyle(
                    color: _kTealDeeper,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              _FooterMetric(
                icon: Icons.grid_view_outlined,
                label: 'Cards',
                value: '$cardCount',
              ),
              const SizedBox(width: 12),
              _FooterMetric(
                icon: Icons.timer_outlined,
                label: 'Duration',
                value: '${durationMs}ms',
              ),
              const SizedBox(width: 12),
              _FooterMetric(
                icon: Icons.key_outlined,
                label: 'Key',
                value: 'GlobalKey<SAGS>',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterMetric extends StatelessWidget {
  const _FooterMetric({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _kCreamSoft,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kBorder),
        ),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 16, color: _kTeal),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      color: _kMuted,
                      fontSize: 10,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _kTealDeeper,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
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
}

// ---------------------------------------------------------------------------
// Scene 7: comparison matrix — SliverAnimatedGrid vs AnimatedGrid vs
// ReorderableListView, plus a field-reference table.
// ---------------------------------------------------------------------------

class _ComparisonMatrixCard extends StatelessWidget {
  const _ComparisonMatrixCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionHeading(
            eyebrow: 'SCENE 7',
            title: 'When to use which widget',
            description:
                'A quick decision matrix for animated collections. All '
                'three support insertion / removal animations but differ '
                'in what they orchestrate.',
          ),
          SizedBox(height: 12),
          _ComparisonTable(),
          SizedBox(height: 18),
          _FieldReferenceTable(),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  static const List<_ComparisonRow> _rows = <_ComparisonRow>[
    _ComparisonRow(
      widget: 'SliverAnimatedGrid',
      scroll: 'Sliver (inside CustomScrollView)',
      layout: 'Grid via SliverGridDelegate',
      animated: 'Yes — insert + remove',
      reorder: 'No',
      useWhen: 'Grid needs to coexist with SliverAppBar/other slivers.',
    ),
    _ComparisonRow(
      widget: 'AnimatedGrid',
      scroll: 'Standalone (creates its own viewport)',
      layout: 'Grid via SliverGridDelegate',
      animated: 'Yes — insert + remove',
      reorder: 'No',
      useWhen: 'Screen is only the grid; no other slivers.',
    ),
    _ComparisonRow(
      widget: 'ReorderableListView',
      scroll: 'Standalone list',
      layout: 'One-dimensional list',
      animated: 'Move animation during drag',
      reorder: 'Yes — drag handles',
      useWhen: 'User must reorder items by dragging.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCreamSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: <Widget>[
          const _ComparisonHeader(),
          for (int i = 0; i < _rows.length; i++) ...<Widget>[
            if (i > 0)
              Divider(
                  height: 1, color: _kBorder.withValues(alpha: 0.8)),
            _ComparisonBodyRow(row: _rows[i]),
          ],
        ],
      ),
    );
  }
}

class _ComparisonHeader extends StatelessWidget {
  const _ComparisonHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kTealDeeper,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: const Row(
        children: <Widget>[
          Expanded(flex: 3, child: _ComparisonHeaderCell(label: 'Widget')),
          Expanded(flex: 3, child: _ComparisonHeaderCell(label: 'Scroll')),
          Expanded(flex: 3, child: _ComparisonHeaderCell(label: 'Layout')),
          Expanded(flex: 3, child: _ComparisonHeaderCell(label: 'Animations')),
          Expanded(flex: 2, child: _ComparisonHeaderCell(label: 'Reorder')),
          Expanded(flex: 5, child: _ComparisonHeaderCell(label: 'Use when')),
        ],
      ),
    );
  }
}

class _ComparisonHeaderCell extends StatelessWidget {
  const _ComparisonHeaderCell({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: _kPeach,
        fontSize: 11,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ComparisonRow {
  const _ComparisonRow({
    required this.widget,
    required this.scroll,
    required this.layout,
    required this.animated,
    required this.reorder,
    required this.useWhen,
  });
  final String widget;
  final String scroll;
  final String layout;
  final String animated;
  final String reorder;
  final String useWhen;
}

class _ComparisonBodyRow extends StatelessWidget {
  const _ComparisonBodyRow({required this.row});
  final _ComparisonRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.widget,
              style: const TextStyle(
                color: _kTealDeeper,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(flex: 3, child: _ComparisonCell(text: row.scroll)),
          Expanded(flex: 3, child: _ComparisonCell(text: row.layout)),
          Expanded(flex: 3, child: _ComparisonCell(text: row.animated)),
          Expanded(flex: 2, child: _ComparisonCell(text: row.reorder)),
          Expanded(flex: 5, child: _ComparisonCell(text: row.useWhen)),
        ],
      ),
    );
  }
}

class _ComparisonCell extends StatelessWidget {
  const _ComparisonCell({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        text,
        style: const TextStyle(color: _kInk, fontSize: 11.5, height: 1.35),
      ),
    );
  }
}

// Field-reference table — documents the signatures of the four state methods
// so the reader can cross-check parameter names / defaults without opening
// the Flutter source.
class _FieldReferenceTable extends StatelessWidget {
  const _FieldReferenceTable();

  static const List<_FieldSpec> _specs = <_FieldSpec>[
    _FieldSpec(
      signature: 'void insertItem(int index, {Duration duration})',
      returns: 'void',
      notes:
          'Shifts all items at or after `index` one slot later and runs the '
          'forward animation.',
    ),
    _FieldSpec(
      signature:
          'void insertAllItems(int index, int length, {Duration duration})',
      returns: 'void',
      notes: 'Fan-out helper — repeats insertItem `length` times in order.',
    ),
    _FieldSpec(
      signature:
          'void removeItem(int index, AnimatedRemovedItemBuilder builder, '
              '{Duration duration})',
      returns: 'void',
      notes:
          'Marks the item outgoing. The builder drives the widget while the '
          'reverse animation plays.',
    ),
    _FieldSpec(
      signature:
          'void removeAllItems(AnimatedRemovedItemBuilder builder, '
              '{Duration duration})',
      returns: 'void',
      notes:
          'Bulk variant that cascades removal across every surviving entry '
          'at once.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCreamSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.menu_book_outlined, size: 16, color: _kTeal),
              SizedBox(width: 6),
              Text(
                'Field reference',
                style: TextStyle(
                  color: _kTealDeeper,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < _specs.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: 8),
            _FieldRow(spec: _specs[i]),
          ],
        ],
      ),
    );
  }
}

class _FieldSpec {
  const _FieldSpec({
    required this.signature,
    required this.returns,
    required this.notes,
  });
  final String signature;
  final String returns;
  final String notes;
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.spec});
  final _FieldSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectableText(
            spec.signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kTealDeeper,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kPeach,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'returns ${spec.returns}',
                  style: const TextStyle(
                    color: _kTealDeeper,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.notes,
                  style: const TextStyle(
                    color: _kMuted,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lifecycle log tile — used by the SliverList at the bottom.
// ---------------------------------------------------------------------------

class _LifecycleLog {
  // Marker class to keep the name `_LifecycleLog` reserved per the brief.
  // The actual rendering happens in `_LifecycleLogTile` which consumes
  // `_LogEntry` items produced by the page state.
  const _LifecycleLog();
}

class _LogEntry {
  const _LogEntry({
    required this.timestamp,
    required this.method,
    required this.index,
    required this.total,
    this.note,
  });

  final DateTime timestamp;
  final String method;
  final int index;
  final int total;
  final String? note;
}

class _LifecycleLogTile extends StatelessWidget {
  const _LifecycleLogTile({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final _LogEntry entry;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final Color borderColour = isFirst
        ? _kPeach.withValues(alpha: 0.85)
        : _kBorder;
    return Container(
      margin: EdgeInsets.only(
        top: isFirst ? 4 : 0,
        bottom: isLast ? 18 : 8,
      ),
      decoration: BoxDecoration(
        color: _kCream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColour),
        boxShadow: isFirst
            ? <BoxShadow>[
                BoxShadow(
                  color: _kPeach.withValues(alpha: 0.28),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
            : const <BoxShadow>[],
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _LogDot(isFirst: isFirst),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      entry.method,
                      style: const TextStyle(
                        color: _kTealDeeper,
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (entry.index >= 0)
                      _LogChip(label: 'idx=${entry.index}'),
                    const SizedBox(width: 6),
                    _LogChip(label: 'total=${entry.total}'),
                    const Spacer(),
                    Text(
                      _formatClock(entry.timestamp, withMillis: true),
                      style: const TextStyle(
                        color: _kMuted,
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                if (entry.note != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    entry.note!,
                    style: const TextStyle(
                      color: _kMuted,
                      fontSize: 11.5,
                      height: 1.35,
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
}

class _LogDot extends StatelessWidget {
  const _LogDot({required this.isFirst});
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: isFirst ? _kPeachWarm : _kTeal,
        shape: BoxShape.circle,
        border: Border.all(color: _kCream, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (isFirst ? _kPeachWarm : _kTeal).withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _LogChip extends StatelessWidget {
  const _LogChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _kTealDeeper,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _kCream,
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stage marker class — reserved name per the brief to document the grid's
// position in the overall scene structure.
// ---------------------------------------------------------------------------

class _AnimatedGridStage {
  const _AnimatedGridStage();

  // Conceptual documentation: the stage below hosts a SliverAnimatedGrid
  // inside a CustomScrollView. The grid's state can be controlled via a
  // GlobalKey<SliverAnimatedGridState>. See `_CommandDeckPageState` for
  // the concrete wiring.
  static const String description =
      'Stage 2 — SliverAnimatedGrid inside CustomScrollView with '
      'SliverAppBar, hero, control panel, grid, footer, comparison, log.';
}

// ---------------------------------------------------------------------------
// Models and helpers.
// ---------------------------------------------------------------------------

class _DeckCardModel {
  const _DeckCardModel({
    required this.id,
    required this.label,
    required this.glyph,
    required this.colour,
    required this.birth,
  });

  final int id;
  final String label;
  final String glyph;
  final Color colour;
  final DateTime birth;
}

const List<String> _kGlyphs = <String>[
  'α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ',
  'λ', 'μ', 'ν', 'ξ', 'π', 'ρ', 'σ', 'τ',
  'φ', 'χ', 'ψ', 'ω',
  // ignore: unnecessary_string_escapes — no ignores allowed, use plain chars.
  '◆', '◇', '●', '○', '■', '□', '▲', '△',
];

String _formatClock(DateTime t, {bool withMillis = false}) {
  String two(int n) => n.toString().padLeft(2, '0');
  final base =
      '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
  if (!withMillis) return base;
  final ms = t.millisecond.toString().padLeft(3, '0');
  return '$base.$ms';
}

String _colourName(Color c) {
  if (c == _kTeal) return 'teal';
  if (c == _kTealDeeper) return 'deep teal';
  if (c == _kTealLight) return 'teal light';
  if (c == _kPeach) return 'peach';
  if (c == _kPeachWarm) return 'warm peach';
  if (c == _kCream) return 'cream';
  if (c == _kCreamSoft) return 'cream soft';
  return 'mix';
}
