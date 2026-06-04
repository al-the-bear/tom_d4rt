// Sudoku game-state holder + Scaffold layout.
//
// Idiomatic Flutter pattern: a script-defined `StatefulWidget` /
// `State<T>` pair drives the UI through plain `setState` calls. The
// d4rt interpreter routes setState through the `_InterpretedState`
// proxy (GEN-112) so it actually schedules a Flutter rebuild — the
// scheduler-phase guard in `StateUserBridge.overrideMethodSetState`
// keeps the mid-frame `setState` hazard (original Bug-45) safe by
// deferring via `addPostFrameCallback`.
import 'package:flutter/material.dart';

import 'board.dart';
import 'keypad.dart';
import 'puzzles.dart';
import 'rules.dart';

class SudokuHome extends StatefulWidget {
  const SudokuHome({super.key});

  @override
  State<SudokuHome> createState() => _SudokuHomeState();
}

class _SudokuHomeState extends State<SudokuHome> {
  int _puzzleIndex = 0;
  late List<List<int>> _values;
  late List<List<bool>> _given;
  int? _selRow;
  int? _selCol;

  @override
  void initState() {
    super.initState();
    _loadPuzzle(0);
  }

  void _loadPuzzle(int index) {
    final puzzle = puzzles[index];
    _puzzleIndex = index;
    _values = [
      for (final row in puzzle) [...row]
    ];
    _given = [
      for (final row in puzzle) [for (final v in row) v != 0]
    ];
    _selRow = null;
    _selCol = null;
  }

  void _select(int row, int col) {
    setState(() {
      _selRow = row;
      _selCol = col;
    });
  }

  void _enter(int value) {
    final r = _selRow;
    final c = _selCol;
    if (r == null || c == null) return;
    if (_given[r][c]) return;
    setState(() => _values[r][c] = value);
  }

  void _erase() {
    final r = _selRow;
    final c = _selCol;
    if (r == null || c == null) return;
    if (_given[r][c]) return;
    setState(() => _values[r][c] = 0);
  }

  void _nextPuzzle() {
    setState(() => _loadPuzzle((_puzzleIndex + 1) % puzzles.length));
  }

  void _resetPuzzle() {
    setState(() => _loadPuzzle(_puzzleIndex));
  }

  @override
  Widget build(BuildContext context) {
    final solved = isSolved(_values);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku — puzzle ${_puzzleIndex + 1}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset puzzle',
            onPressed: _resetPuzzle,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            tooltip: 'Next puzzle',
            onPressed: _nextPuzzle,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final playArea = ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SudokuBoard(
                    values: _values,
                    given: _given,
                    selRow: _selRow,
                    selCol: _selCol,
                    onSelect: _select,
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
                  SudokuKeypad(onNumber: _enter, onErase: _erase),
                ],
              ),
            );
            const rules = SudokuRulesPanel();

            // Wide screens (≥ 880 px): board on the left, rules panel
            // on the right. Below that, stack them vertically so the
            // app remains usable in narrow windows.
            if (constraints.maxWidth >= 880) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: playArea),
                    const SizedBox(width: 24),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: rules,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    playArea,
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: rules,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
