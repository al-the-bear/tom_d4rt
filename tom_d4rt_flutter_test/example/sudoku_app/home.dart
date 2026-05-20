// Sudoku game-state holder + Scaffold layout.
//
// Why `StatefulBuilder` instead of a user-defined `State.setState`?
// tom_d4rt (the analyzer-based interpreter this app runs on) makes
// `setState` on a script-declared `State<T>` subclass a no-op for
// Flutter rebuild scheduling — by design, to avoid the "Bug-45"
// cascading-rebuild loop. The user-State's setState callback DOES
// execute (so fields would mutate) but no frame is scheduled, so the
// UI never reflects the change.
//
// `StatefulBuilder` is a bridged native Flutter widget whose setState
// goes through Flutter's regular machinery, so it works end-to-end.
// State here lives on a plain `_GameState` Dart object held by the
// outer `SudokuHome` StatelessWidget — the builder closure captures
// that reference and reads/writes through it.
//
// See `tom_d4rt_flutter_ast/doc/interpreter_issues.md` for the
// "[Open] user-defined State.setState is a no-op for Flutter
// rebuild" entry tracking the underlying interpreter fix.
import 'package:flutter/material.dart';

import 'board.dart';
import 'keypad.dart';
import 'puzzles.dart';

class _GameState {
  int puzzleIndex = 0;
  int buildCount = 0;
  int tapCount = 0;
  List<List<int>> values = const [];
  List<List<bool>> given = const [];
  int? selRow;
  int? selCol;

  _GameState() {
    loadPuzzle(0);
  }

  void loadPuzzle(int index) {
    final puzzle = puzzles[index];
    puzzleIndex = index;
    values = [
      for (final row in puzzle) [...row]
    ];
    given = [
      for (final row in puzzle) [for (final v in row) v != 0]
    ];
    selRow = null;
    selCol = null;
  }
}

class SudokuHome extends StatelessWidget {
  final _GameState _state = _GameState();

  SudokuHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        _state.buildCount = _state.buildCount + 1;
        final solved = isSolved(_state.values);
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Sudoku — puzzle ${_state.puzzleIndex + 1}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset puzzle',
                onPressed: () {
                  setState(() {
                    _state.tapCount = _state.tapCount + 1;
                    _state.loadPuzzle(_state.puzzleIndex);
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                tooltip: 'Next puzzle',
                onPressed: () {
                  setState(() {
                    _state.tapCount = _state.tapCount + 1;
                    _state.loadPuzzle(
                      (_state.puzzleIndex + 1) % puzzles.length,
                    );
                  });
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Debug HUD — TEMP. Confirms the bridged
                      // StatefulBuilder.setState is driving rebuilds.
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.amber.shade100,
                        child: Text(
                          '[DEBUG] puzzle=${_state.puzzleIndex} '
                          'sel=(${_state.selRow},${_state.selCol}) '
                          'taps=${_state.tapCount} '
                          'build#${_state.buildCount}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SudokuBoard(
                        values: _state.values,
                        given: _state.given,
                        selRow: _state.selRow,
                        selCol: _state.selCol,
                        onSelect: (r, c) {
                          setState(() {
                            _state.tapCount = _state.tapCount + 1;
                            _state.selRow = r;
                            _state.selCol = c;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      if (solved)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            '★ Solved ★',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      SudokuKeypad(
                        onNumber: (value) {
                          final r = _state.selRow;
                          final c = _state.selCol;
                          if (r == null || c == null) return;
                          if (_state.given[r][c]) return;
                          setState(() {
                            _state.tapCount = _state.tapCount + 1;
                            _state.values[r][c] = value;
                          });
                        },
                        onErase: () {
                          final r = _state.selRow;
                          final c = _state.selCol;
                          if (r == null || c == null) return;
                          if (_state.given[r][c]) return;
                          setState(() {
                            _state.tapCount = _state.tapCount + 1;
                            _state.values[r][c] = 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
