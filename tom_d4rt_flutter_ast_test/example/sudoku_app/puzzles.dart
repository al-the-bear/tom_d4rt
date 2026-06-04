// Puzzle bank plus validation helpers. Zero represents an empty cell.
// Two distinct starting boards are bundled — `home.dart` rotates between
// them with the "Next puzzle" action.

const List<List<List<int>>> puzzles = [
  [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
  ],
  [
    [0, 0, 0, 2, 6, 0, 7, 0, 1],
    [6, 8, 0, 0, 7, 0, 0, 9, 0],
    [1, 9, 0, 0, 0, 4, 5, 0, 0],
    [8, 2, 0, 1, 0, 0, 0, 4, 0],
    [0, 0, 4, 6, 0, 2, 9, 0, 0],
    [0, 5, 0, 0, 0, 3, 0, 2, 8],
    [0, 0, 9, 3, 0, 0, 0, 7, 4],
    [0, 4, 0, 0, 5, 0, 0, 3, 6],
    [7, 0, 3, 0, 1, 8, 0, 0, 0],
  ],
];

/// True when [values] form a complete and valid solution: every row,
/// column, and 3x3 box contains the digits 1–9 exactly once.
bool isSolved(List<List<int>> values) {
  for (var i = 0; i < 9; i++) {
    final rowSeen = <int>{};
    final colSeen = <int>{};
    for (var j = 0; j < 9; j++) {
      final r = values[i][j];
      final c = values[j][i];
      if (r < 1 || r > 9 || !rowSeen.add(r)) return false;
      if (c < 1 || c > 9 || !colSeen.add(c)) return false;
    }
  }
  for (var br = 0; br < 9; br += 3) {
    for (var bc = 0; bc < 9; bc += 3) {
      final seen = <int>{};
      for (var r = br; r < br + 3; r++) {
        for (var c = bc; c < bc + 3; c++) {
          final v = values[r][c];
          if (v < 1 || v > 9 || !seen.add(v)) return false;
        }
      }
    }
  }
  return true;
}

/// True when the cell at [row]/[col] holds a value (1–9) that already
/// appears elsewhere in its row, column, or 3x3 box. Empty cells (0)
/// are never in conflict.
bool hasConflict(List<List<int>> values, int row, int col) {
  final v = values[row][col];
  if (v == 0) return false;
  for (var k = 0; k < 9; k++) {
    if (k != col && values[row][k] == v) return true;
    if (k != row && values[k][col] == v) return true;
  }
  final br = (row ~/ 3) * 3;
  final bc = (col ~/ 3) * 3;
  for (var r = br; r < br + 3; r++) {
    for (var c = bc; c < bc + 3; c++) {
      if ((r != row || c != col) && values[r][c] == v) return true;
    }
  }
  return false;
}
