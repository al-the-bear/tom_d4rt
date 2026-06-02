// 9x9 Sudoku board grid. Renders nine rows of nine cells; the inner
// 3x3 box borders are painted thicker so the structure is visible at a
// glance. Selection state is purely cosmetic — actual mutation lives in
// the parent SudokuHome state.
import 'package:flutter/material.dart';

import 'puzzles.dart';

class SudokuBoard extends StatelessWidget {
  final List<List<int>> values;
  final List<List<bool>> given;
  final int? selRow;
  final int? selCol;
  final void Function(int row, int col) onSelect;

  const SudokuBoard({
    super.key,
    required this.values,
    required this.given,
    required this.selRow,
    required this.selCol,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          color: Colors.white,
        ),
        // List.generate gives each callback its own row/col parameter scope,
        // so per-cell closures capture distinct r/c values. A plain
        // `for (var r = 0; ...)` inside a collection literal would share one
        // r across all closures under the d4rt interpreter, making every
        // cell tap fire with the post-loop value of r (9 — out of range).
        child: Column(
          children: List.generate(9, (r) {
            return Expanded(
              child: Row(
                children: List.generate(9, (c) {
                  return Expanded(
                    child: _Cell(
                      row: r,
                      col: c,
                      value: values[r][c],
                      given: given[r][c],
                      selected: selRow == r && selCol == c,
                      highlighted: _isHighlighted(r, c),
                      conflict: hasConflict(values, r, c),
                      onTap: () => onSelect(r, c),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  bool _isHighlighted(int r, int c) {
    final sr = selRow;
    final sc = selCol;
    if (sr == null || sc == null) return false;
    if (sr == r || sc == c) return true;
    return (r ~/ 3) == (sr ~/ 3) && (c ~/ 3) == (sc ~/ 3);
  }
}

class _Cell extends StatelessWidget {
  final int row;
  final int col;
  final int value;
  final bool given;
  final bool selected;
  final bool highlighted;
  final bool conflict;
  final VoidCallback onTap;

  const _Cell({
    required this.row,
    required this.col,
    required this.value,
    required this.given,
    required this.selected,
    required this.highlighted,
    required this.conflict,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = selected
        ? scheme.primaryContainer
        : highlighted
            ? scheme.surfaceContainerHigh
            : Colors.white;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          border: Border(
            top: BorderSide(
              width: row % 3 == 0 ? 2 : 0.5,
              color: Colors.black,
            ),
            left: BorderSide(
              width: col % 3 == 0 ? 2 : 0.5,
              color: Colors.black,
            ),
            right: BorderSide(
              width: col == 8 ? 0 : 0.5,
              color: Colors.black,
            ),
            bottom: BorderSide(
              width: row == 8 ? 0 : 0.5,
              color: Colors.black,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          value == 0 ? '' : '$value',
          style: TextStyle(
            fontSize: 22,
            fontWeight: given ? FontWeight.w800 : FontWeight.w400,
            color: conflict
                ? Colors.red
                : given
                    ? Colors.black
                    : scheme.primary,
          ),
        ),
      ),
    );
  }
}
