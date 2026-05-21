// Pure model + step function for Conway's Game of Life.
//
// We use a sparse representation: live cells live in a `Set<Cell>`,
// which keeps the step function O(live * 8) regardless of board
// size. `Cell` provides content equality so two `Cell(x, y)` with
// the same coords hash and compare as one — that's what makes
// `Set<Cell>` work and is the exact contract the interpreter's
// equality / hashCode dispatch was wired to honour while shipping
// example #7.
//
// Constants up top so they're easy to spot:
//   * 60×40 board (per the spec).
//   * Default anchor for `LifePattern.stampAt` is the centre cell.
import 'package:flutter/foundation.dart';

/// Board width in cells.
const int kBoardW = 60;

/// Board height in cells.
const int kBoardH = 40;

@immutable
class Cell {
  final int x;
  final int y;

  const Cell(this.x, this.y);

  bool get inBounds =>
      x >= 0 && x < kBoardW && y >= 0 && y < kBoardH;

  @override
  bool operator ==(Object other) =>
      other is Cell && other.x == x && other.y == y;

  @override
  int get hashCode => x * 1000003 + y;

  @override
  String toString() => '($x,$y)';
}

/// Compute the next generation of [live].
///
/// Returns a brand-new set; the input is not mutated. We accumulate
/// neighbour counts in a `Map<Cell, int>` — that gives us a single
/// pass over each live cell's 8 neighbours, after which a live cell
/// survives iff its count is 2 or 3, and a dead cell becomes alive
/// iff its count is exactly 3. Both lookups go through the
/// content-based `==`/`hashCode` on `Cell`.
Set<Cell> stepLife(Set<Cell> live) {
  final neighbourCounts = <Cell, int>{};
  for (final cell in live) {
    for (var dy = -1; dy <= 1; dy++) {
      for (var dx = -1; dx <= 1; dx++) {
        if (dx == 0 && dy == 0) continue;
        final nx = cell.x + dx;
        final ny = cell.y + dy;
        if (nx < 0 || nx >= kBoardW) continue;
        if (ny < 0 || ny >= kBoardH) continue;
        final n = Cell(nx, ny);
        final prev = neighbourCounts[n] ?? 0;
        neighbourCounts[n] = prev + 1;
      }
    }
  }
  final next = <Cell>{};
  for (final cell in live) {
    final c = neighbourCounts[cell] ?? 0;
    if (c == 2 || c == 3) next.add(cell);
  }
  for (final entry in neighbourCounts.entries) {
    if (entry.value == 3 && !live.contains(entry.key)) {
      next.add(entry.key);
    }
  }
  return next;
}
