// MemoryMatchHome — the state-bearing host that owns the deck, the
// in-flight selection, the move/match counters, and the per-
// difficulty best-score map. Plays the canonical d4rt-friendly
// pattern: script-defined `StatefulWidget` + `State<T>` + `setState`.
//
// State machine:
//   • At most two cards are revealed at any time (the "selection
//     window"). The first tap reveals a card; the second tap reveals
//     a second card, increments `_moves`, then schedules a
//     `Future.delayed` to either lock the pair in (`matched = true`)
//     or hide both again.
//   • While the resolve future is pending, further taps are ignored
//     — `_resolving` gates the handler so quick double-taps don't
//     escape the two-card window.
//   • Changing difficulty or hitting Reset deals a fresh deck via
//     `dealCards`. The bestmoves entry for the *previous* difficulty
//     survives so the player keeps their highscore across resets.
//
// Every state-affecting branch emits a one-line `print()` so tests
// can observe the run via the host's `_printLog` zone capture.
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:async';

import 'package:flutter/material.dart';

import 'card_widget.dart';
import 'difficulty.dart';
import 'game.dart';
import 'score_panel.dart';

/// Fixed RNG seed so every fresh boot of the sample produces the
/// same layout — tests rely on this to address specific matching
/// pairs by slot index.
const int _kShuffleSeed = 4242;

/// How long the second card stays face-up before the engine resolves
/// a miss (hide) or a match (lock). 600 ms feels natural without
/// blocking the test runner.
const Duration _kResolveDelay = Duration(milliseconds: 600);

class MemoryMatchHome extends StatefulWidget {
  const MemoryMatchHome({super.key});

  @override
  State<MemoryMatchHome> createState() => _MemoryMatchHomeState();
}

class _MemoryMatchHomeState extends State<MemoryMatchHome> {
  Difficulty _difficulty = Difficulty.easy;
  List<MemoryCard> _deck = <MemoryCard>[];
  int? _firstFlippedSlot;
  int _moves = 0;
  int _matches = 0;
  bool _resolving = false;
  Timer? _pendingResolve;

  /// Per-difficulty best (lowest) move count. Survives Reset and
  /// difficulty swaps inside one sample boot.
  final Map<Difficulty, int> _bestMoves = <Difficulty, int>{};

  @override
  void initState() {
    super.initState();
    _dealFresh();
  }

  @override
  void dispose() {
    _pendingResolve?.cancel();
    super.dispose();
  }

  // ── Game lifecycle ──────────────────────────────────────────────

  void _dealFresh() {
    _pendingResolve?.cancel();
    _pendingResolve = null;
    final deck = dealCards(
      cardCount: cardCountOf(_difficulty),
      seed: _kShuffleSeed,
    );
    _deck = deck;
    _firstFlippedSlot = null;
    _moves = 0;
    _matches = 0;
    _resolving = false;
    // Print the dealt face-ids so tests can build a pair index
    // without knowing the seed's exact output.
    final faces = <String>[];
    for (final card in deck) {
      faces.add('${card.faceId}');
    }
    print('memmatch.deal difficulty=${_difficulty.name} '
        'cards=${deck.length} faces=[${faces.join(",")}]');
  }

  void _resetBoard() {
    setState(_dealFresh);
    print('memmatch.reset difficulty=${_difficulty.name}');
  }

  void _changeDifficulty(Difficulty next) {
    if (next == _difficulty) return;
    setState(() {
      _difficulty = next;
      _dealFresh();
    });
    print('memmatch.difficulty=${_difficulty.name}');
  }

  // ── Tap handling ────────────────────────────────────────────────

  void _onCardTap(int slot) {
    // Reject taps that aren't legal in the current state:
    //   * resolving (waiting for the hide/match future)
    //   * already matched (the card is locked face-up)
    //   * already revealed *as the first* card (don't allow the
    //     player to "uncombine" their own first selection)
    if (_resolving) {
      print('memmatch.tap slot=$slot ignored=resolving');
      return;
    }
    final tapped = _deck[slot];
    if (tapped.matched) {
      print('memmatch.tap slot=$slot ignored=matched');
      return;
    }
    if (tapped.revealed) {
      print('memmatch.tap slot=$slot ignored=already-revealed');
      return;
    }

    if (_firstFlippedSlot == null) {
      // First card of a pair.
      setState(() {
        tapped.revealed = true;
        _firstFlippedSlot = slot;
      });
      print('memmatch.flipFirst slot=$slot face=${tapped.faceId}');
      return;
    }

    // Second card of a pair — reveal it, freeze input, schedule the
    // resolve.
    final firstSlot = _firstFlippedSlot!;
    setState(() {
      tapped.revealed = true;
      _moves++;
      _resolving = true;
    });
    final first = _deck[firstSlot];
    final isMatch = first.faceId == tapped.faceId;
    print('memmatch.flipSecond slot=$slot face=${tapped.faceId} '
        'firstSlot=$firstSlot match=$isMatch moves=$_moves');
    _pendingResolve = Timer(_kResolveDelay, () {
      if (!mounted) return;
      _resolvePair(firstSlot, slot, isMatch);
    });
  }

  void _resolvePair(int firstSlot, int secondSlot, bool isMatch) {
    setState(() {
      if (isMatch) {
        _deck[firstSlot].matched = true;
        _deck[secondSlot].matched = true;
        _matches++;
      } else {
        _deck[firstSlot].revealed = false;
        _deck[secondSlot].revealed = false;
      }
      _firstFlippedSlot = null;
      _resolving = false;
    });
    print('memmatch.resolve match=$isMatch matches=$_matches '
        'moves=$_moves');

    if (isSolved(_deck)) {
      final current = _bestMoves[_difficulty];
      if (current == null || _moves < current) {
        _bestMoves[_difficulty] = _moves;
        print('memmatch.newBest difficulty=${_difficulty.name} '
            'moves=$_moves');
      }
      print('memmatch.solved difficulty=${_difficulty.name} '
          'moves=$_moves best=${_bestMoves[_difficulty]}');
    }
  }

  // ── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final solved = isSolved(_deck);
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text('Memory Match'),
        backgroundColor: scheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            key: const ValueKey<String>('btn-reset'),
            tooltip: 'Reset',
            onPressed: _resetBoard,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _DifficultyBar(
              current: _difficulty,
              onSelected: _changeDifficulty,
            ),
            ScorePanel(
              moves: _moves,
              matches: _matches,
              totalPairs: pairCountOf(_difficulty),
              bestMoves: _bestMoves[_difficulty],
              solved: solved,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _Grid(
                  deck: _deck,
                  gridSize: gridSizeOf(_difficulty),
                  onCardTap: _onCardTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyBar extends StatelessWidget {
  final Difficulty current;
  final void Function(Difficulty d) onSelected;

  const _DifficultyBar({
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        key: const ValueKey<String>('difficulty-bar'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(Difficulty.values.length, (i) {
          final d = Difficulty.values[i];
          final selected = d == current;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton(
              key: ValueKey<String>('difficulty-${d.name}'),
              onPressed: selected ? null : () => onSelected(d),
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    selected ? scheme.primaryContainer : null,
                foregroundColor:
                    selected ? scheme.onPrimaryContainer : scheme.primary,
                side: BorderSide(
                  color: selected ? scheme.primary : scheme.outlineVariant,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Text(labelOf(d)),
            ),
          );
        }),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final List<MemoryCard> deck;
  final int gridSize;
  final void Function(int slot) onCardTap;

  const _Grid({
    required this.deck,
    required this.gridSize,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    // Easy and Hard are both square (4×4 and 6×6) so the natural grid
    // aspect is 1:1. Wrapping in Center > AspectRatio(1.0) makes the
    // grid the largest square that fits the available area — on wide
    // desktop windows the prior `Expanded > GridView.count` laid out
    // square cells at width/cols, which made total grid height equal
    // to grid width and forced the grid to scroll vertically.
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GridView.count(
          key: const ValueKey<String>('card-grid'),
          crossAxisCount: gridSize,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(deck.length, (i) {
            final card = deck[i];
            return MemoryCardTile(
              card: card,
              slot: i,
              onTap: () => onCardTap(i),
            );
          }),
        ),
      ),
    );
  }
}
