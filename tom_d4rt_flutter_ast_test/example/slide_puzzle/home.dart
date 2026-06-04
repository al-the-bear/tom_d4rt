// Slide-puzzle shell.
//
// Layout (top → bottom):
//   • AppBar with shuffle + solver IconButtons.
//   • A status row: move counter + elapsed-time text.
//   • A `Stack` of 15 `PuzzleTile`s using `AnimatedPositioned`.
//   • A `ConfettiBurst` overlay (only mounted while a burst is alive).
//
// State and effects:
//   • `_board`        — the immutable `PuzzleBoard`. Replaced on every
//                       tap / shuffle / solver step.
//   • `_moveCount`    — number of *accepted* taps since the last
//                       shuffle/reset.
//   • `_elapsed`      — seconds since the first move. Driven by a
//                       `Timer.periodic` started on the first tap and
//                       stopped on solve.
//   • `_celebrating`  — true while the confetti burst is on screen;
//                       cleared by the burst's onComplete callback.
//   • `_solving`      — true while the BFS solver is auto-playing. We
//                       chain its moves via `Future.delayed` so each
//                       step animates fully before the next.
//
// Trail (one line per significant event so tests can assert):
//
//   puzzle.boot tiles=16 gap=15
//   tile.tap cell=<c> value=<v>
//   tile.reject cell=<c>
//   move.count=<n>
//   puzzle.shuffle moves=<n> seed=<s>
//   timer.start
//   timer.stop elapsed=<n>
//   puzzle.solver moves=<n>
//   puzzle.solver.step cell=<c>
//   puzzle.solve moves=<n> elapsed=<n>
//   confetti.start particles=<n>
//   confetti.end
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'confetti.dart';
import 'puzzle.dart';
import 'solver.dart';
import 'tile.dart';

const int kShuffleMoves = 4;
const int kShuffleSeed = 42;

class SlidePuzzleApp extends StatelessWidget {
  const SlidePuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'slide_puzzle',
      theme: ThemeData(useMaterial3: true),
      home: const SlidePuzzleHome(),
    );
  }
}

class SlidePuzzleHome extends StatefulWidget {
  const SlidePuzzleHome({super.key});

  @override
  State<SlidePuzzleHome> createState() => _SlidePuzzleHomeState();
}

class _SlidePuzzleHomeState extends State<SlidePuzzleHome> {
  PuzzleBoard _board = PuzzleBoard.solved();
  int _moveCount = 0;
  int _elapsed = 0;
  Timer? _timer;
  bool _celebrating = false;
  bool _solving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      print('puzzle.boot tiles=$kBoardCells gap=${_board.gapCell}');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void _startTimerIfNeeded() {
    if (_timer != null) return;
    print('timer.start');
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      if (!mounted) return;
      setState(() {
        _elapsed = _elapsed + 1;
      });
    });
  }

  void _stopTimer() {
    if (_timer == null) return;
    print('timer.stop elapsed=$_elapsed');
    _timer?.cancel();
    _timer = null;
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsed = 0;
    });
  }

  /// Apply a tap originating from the user or the solver. Returns
  /// true if the move was accepted.
  bool _applyTap(int cell, {required bool fromUser}) {
    final int value = _board.tiles[cell];
    final PuzzleBoard? next = _board.tap(cell);
    if (next == null) {
      if (fromUser) {
        print('tile.reject cell=$cell');
      }
      return false;
    }
    if (fromUser) {
      _startTimerIfNeeded();
      print('tile.tap cell=$cell value=$value');
    }
    setState(() {
      _board = next;
      _moveCount = _moveCount + 1;
    });
    print('move.count=$_moveCount');
    if (_board.isSolved) {
      _onSolved();
    }
    return true;
  }

  void _onSolved() {
    _stopTimer();
    print('puzzle.solve moves=$_moveCount elapsed=$_elapsed');
    setState(() {
      _celebrating = true;
    });
  }

  void _onShuffle() {
    _resetTimer();
    final math.Random rng = math.Random(kShuffleSeed);
    final PuzzleBoard shuffled =
        PuzzleBoard.solved().shuffleByMoves(kShuffleMoves, rng);
    setState(() {
      _board = shuffled;
      _moveCount = 0;
      _celebrating = false;
    });
    print('puzzle.shuffle moves=$kShuffleMoves seed=$kShuffleSeed');
  }

  Future<void> _onSolverPressed() async {
    if (_solving) return;
    final List<int> plan = solvePuzzle(_board);
    print('puzzle.solver moves=${plan.length}');
    if (plan.isEmpty) return;
    setState(() {
      _solving = true;
    });
    for (int i = 0; i < plan.length; i = i + 1) {
      if (!mounted) break;
      final int cell = plan[i];
      print('puzzle.solver.step cell=$cell');
      _applyTap(cell, fromUser: false);
      await Future<void>.delayed(const Duration(milliseconds: 260));
    }
    if (!mounted) return;
    setState(() {
      _solving = false;
    });
  }

  Widget _buildBoard() {
    final double boardSide =
        kBoardSide * kTileSize + (kBoardSide - 1) * kTilePadding;
    final List<Widget> tiles = <Widget>[];
    for (int v = 1; v <= 15; v = v + 1) {
      final int cell = _board.cellOfValue(v);
      if (cell < 0) continue;
      tiles.add(PuzzleTile(
        key: ValueKey<int>(v),
        value: v,
        cell: cell,
        onTap: () => _applyTap(cell, fromUser: true),
      ));
    }
    if (_celebrating) {
      tiles.add(ConfettiBurst(
        width: boardSide,
        height: boardSide,
        onComplete: () {
          if (!mounted) return;
          setState(() {
            _celebrating = false;
          });
        },
      ));
    }
    return SizedBox(
      key: const Key('puzzle-board'),
      width: boardSide,
      height: boardSide,
      child: Stack(
        clipBehavior: Clip.none,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('puzzle-scaffold'),
      appBar: AppBar(
        title: const Text('slide_puzzle'),
        actions: <Widget>[
          IconButton(
            key: const Key('shuffle-button'),
            icon: const Icon(Icons.shuffle),
            tooltip: 'Shuffle',
            onPressed: _onShuffle,
          ),
          IconButton(
            key: const Key('solver-button'),
            icon: const Icon(Icons.auto_fix_high),
            tooltip: 'Solve',
            onPressed: _solving ? null : _onSolverPressed,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Moves: $_moveCount',
                      key: const Key('move-counter'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Time: ${_elapsed}s',
                      key: const Key('timer-text'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            _buildBoard(),
            const SizedBox(height: 16.0),
            if (_board.isSolved && !_celebrating)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Solved!',
                  key: Key('solved-label'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
