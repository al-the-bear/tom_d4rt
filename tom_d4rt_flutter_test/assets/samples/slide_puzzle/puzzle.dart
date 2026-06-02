// Pure model for the 4×4 sliding-tile puzzle.
//
// State is a 16-cell array of tile values: `tiles[cell] = value` where
// value 0 = the gap, and 1..15 = the numbered tiles.
//
// "Solved" means every tile sits in its natural slot:
//   cells 0..14 hold values 1..15 and cell 15 is the gap.
//
// The board is intentionally immutable from the outside: `tap()` and
// `shuffleByMoves()` return a *new* board instead of mutating in
// place, which keeps the BFS solver clean and lets `setState`
// trivially diff the old/new boards.
import 'dart:math' as math;

const int kBoardSide = 4;
const int kBoardCells = 16;

class PuzzleBoard {
  final List<int> tiles;

  PuzzleBoard._(this.tiles);

  /// Solved board: tile v sits at cell v-1; the gap sits at cell 15.
  factory PuzzleBoard.solved() {
    final List<int> list = <int>[];
    for (int i = 1; i <= 15; i = i + 1) {
      list.add(i);
    }
    list.add(0);
    return PuzzleBoard._(list);
  }

  /// Construct from an explicit list (length 16). Used by tests + solver.
  factory PuzzleBoard.fromList(List<int> source) {
    final List<int> copy = <int>[];
    for (int i = 0; i < source.length; i = i + 1) {
      copy.add(source[i]);
    }
    return PuzzleBoard._(copy);
  }

  int get gapCell {
    for (int i = 0; i < kBoardCells; i = i + 1) {
      if (tiles[i] == 0) return i;
    }
    return -1;
  }

  bool get isSolved {
    for (int i = 0; i < 15; i = i + 1) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles[15] == 0;
  }

  /// Cell index where tile value `v` currently lives. Returns -1 if
  /// `v` is not on the board (should not happen for a well-formed board).
  int cellOfValue(int v) {
    for (int i = 0; i < kBoardCells; i = i + 1) {
      if (tiles[i] == v) return i;
    }
    return -1;
  }

  /// True if the tile at `cell` is adjacent to the current gap
  /// (Manhattan distance == 1 on the 4×4 grid).
  bool canTap(int cell) {
    if (cell < 0 || cell >= kBoardCells) return false;
    if (tiles[cell] == 0) return false; // tapping the gap itself
    final int g = gapCell;
    final int r1 = cell ~/ kBoardSide;
    final int c1 = cell % kBoardSide;
    final int r2 = g ~/ kBoardSide;
    final int c2 = g % kBoardSide;
    final int dr = (r1 - r2).abs();
    final int dc = (c1 - c2).abs();
    return (dr + dc) == 1;
  }

  /// Tap a cell. If the tile is adjacent to the gap, returns the new
  /// board with the swap applied; otherwise returns null.
  PuzzleBoard? tap(int cell) {
    if (!canTap(cell)) return null;
    final List<int> next = <int>[];
    for (int i = 0; i < kBoardCells; i = i + 1) {
      next.add(tiles[i]);
    }
    final int g = gapCell;
    next[g] = tiles[cell];
    next[cell] = 0;
    return PuzzleBoard._(next);
  }

  /// Neighbours of the gap — the cells whose tile can legally move next.
  List<int> tappableCells() {
    final int g = gapCell;
    final int r = g ~/ kBoardSide;
    final int c = g % kBoardSide;
    final List<int> out = <int>[];
    if (r > 0) out.add((r - 1) * kBoardSide + c);
    if (r < kBoardSide - 1) out.add((r + 1) * kBoardSide + c);
    if (c > 0) out.add(r * kBoardSide + (c - 1));
    if (c < kBoardSide - 1) out.add(r * kBoardSide + (c + 1));
    return out;
  }

  /// Stable string key for the BFS visited set.
  String key() {
    final List<String> parts = <String>[];
    for (int i = 0; i < kBoardCells; i = i + 1) {
      parts.add(tiles[i].toString());
    }
    return parts.join(',');
  }

  /// Apply `n` random valid moves starting from the current board,
  /// avoiding the trivial undo of the previous step. Returns a new
  /// board that is provably solvable in ≤ n moves.
  PuzzleBoard shuffleByMoves(int n, math.Random rng) {
    PuzzleBoard board = this;
    int previousGap = -1;
    for (int step = 0; step < n; step = step + 1) {
      final List<int> options = <int>[];
      final List<int> raw = board.tappableCells();
      final int gap = board.gapCell;
      for (int i = 0; i < raw.length; i = i + 1) {
        // Don't undo the move we just did: skip cells equal to the
        // previous gap location.
        if (raw[i] == previousGap) continue;
        options.add(raw[i]);
      }
      if (options.isEmpty) {
        // Edge case (first iteration): allow any neighbour.
        options.addAll(raw);
      }
      final int pick = options[rng.nextInt(options.length)];
      final PuzzleBoard? moved = board.tap(pick);
      if (moved == null) break;
      previousGap = gap;
      board = moved;
    }
    return board;
  }
}
