// Sudoku game-state holder. Owns the 9x9 board mutation, the active
// selection cursor, and the puzzle-rotation controls. Hands plain data
// down to the board and keypad widgets via constructor arguments.
import 'package:flutter/material.dart';

import 'board.dart';
import 'keypad.dart';
import 'puzzles.dart';

class SudokuHome extends StatefulWidget {
  const SudokuHome({super.key});

  @override
  State<SudokuHome> createState() => _SudokuHomeState();
}

class _SudokuHomeState extends State<SudokuHome> {
  int _puzzleIndex = 0;
  int _buildCount = 0;
  int _tapCount = 0;
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
    _tapCount++;
    setState(() {
      _selRow = row;
      _selCol = col;
    });
  }

  void _enter(int value) {
    _tapCount++;
    final r = _selRow;
    final c = _selCol;
    if (r == null || c == null) return;
    if (_given[r][c]) return;
    setState(() => _values[r][c] = value);
  }

  void _erase() {
    _tapCount++;
    final r = _selRow;
    final c = _selCol;
    if (r == null || c == null) return;
    if (_given[r][c]) return;
    setState(() => _values[r][c] = 0);
  }

  void _nextPuzzle() {
    _tapCount++;
    setState(() => _loadPuzzle((_puzzleIndex + 1) % puzzles.length));
  }

  void _resetPuzzle() {
    _tapCount++;
    setState(() => _loadPuzzle(_puzzleIndex));
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Debug HUD — TEMP. If `taps` increments on every cell/key
                  // press but `build#` does not, the d4rt bridge for State
                  // is not marking the interpreted element dirty. If both
                  // increment but the board doesn't change visually, the
                  // mutation is going to a different state instance than
                  // the one read during build().
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    color: Colors.amber.shade100,
                    child: Text(
                      '[DEBUG] puzzle=$_puzzleIndex '
                      'sel=($_selRow,$_selCol) '
                      'taps=$_tapCount '
                      'build#$_buildCount',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}
