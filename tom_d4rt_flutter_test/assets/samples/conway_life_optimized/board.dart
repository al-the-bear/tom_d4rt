// Pure model + step function for Conway's Game of Life (optimized variant).
//
// THE MODEL — sparse, with **integer-encoded** cell keys. The first
// "optimized" cut used a dense `List<int>` of length `kBoardW*kBoardH`, which
// is the right shape for a *compiler* but a disaster under the d4rt
// interpreter: `stepLife` scanned the whole 60×40 board every generation —
// a fixed ~19 200 inner iterations, **independent of population**. In the
// interpreter cost scales with interpreted *loop-iteration count*, not native
// op count, so that fixed scan cost ~43 500 `Environment`/gen and ran 27×
// slower than the original sparse sample (see
// `particle_field_freeze_analysis.md` §"Profiler verdict").
//
// This model keeps the **sparse** representation (work ∝ live-cell count) but
// drops the original sample's `Cell` value object. A live cell is a single
// `int` index `y * kBoardW + x`; the live board is a `Set<int>` and neighbour
// counting accumulates into a `Map<int, int>`. Because the keys are plain
// `int`s, `Set`/`Map` membership uses the interpreter's **native** primitive
// hashing — there is no interpreted `hashCode` / `==` dispatch per cell, which
// was the ~26k-`Environment`/gen tax the original `Set<Cell>` model paid at
// high population. Net: sparse iteration *and* native keys — cheaper than both
// the dense grid and the original object-keyed sparse model.

/// Board width in cells.
const int kBoardW = 60;

/// Board height in cells.
const int kBoardH = 40;

/// Total addressable cells (bounds product). Not an array length — the live
/// board is sparse — but handy for documenting the coordinate space.
const int kCellCount = kBoardW * kBoardH;

/// Flat-array index for board coordinate (x, y). No bounds checking — callers
/// guard the edges where it matters.
int cellIndex(int x, int y) => y * kBoardW + x;

/// Column of a flat cell index.
int cellX(int index) => index % kBoardW;

/// Row of a flat cell index.
int cellY(int index) => index ~/ kBoardW;

/// A fresh empty (all-dead) board.
Set<int> emptyBoard() => <int>{};

/// Count of alive cells in [cells] — just its cardinality.
int countAlive(Set<int> cells) => cells.length;

/// Compute the next generation of [cells].
///
/// Returns a brand-new live set; the input is not mutated. The work is
/// proportional to the live-cell count, not the board area: we visit each live
/// cell once and bump the live-neighbour tally of its in-bounds neighbours in a
/// `Map<int, int>`. A cell is alive next generation iff it has exactly 3 live
/// neighbours (birth or survival) or exactly 2 live neighbours and is currently
/// alive (survival). Every key is a plain `int`, so there is no interpreted
/// equality dispatch anywhere on the hot path.
Set<int> stepLife(Set<int> cells) {
  if (cells.isEmpty) return <int>{};

  // Tally live-neighbour counts for every cell adjacent to a live one.
  final counts = <int, int>{};
  for (final idx in cells) {
    final x = idx % kBoardW;
    final y = idx ~/ kBoardW;
    for (var dy = -1; dy <= 1; dy++) {
      final ny = y + dy;
      if (ny < 0 || ny >= kBoardH) continue;
      final rowBase = ny * kBoardW;
      for (var dx = -1; dx <= 1; dx++) {
        if (dx == 0 && dy == 0) continue;
        final nx = x + dx;
        if (nx < 0 || nx >= kBoardW) continue;
        final nIdx = rowBase + nx;
        counts[nIdx] = (counts[nIdx] ?? 0) + 1;
      }
    }
  }

  // Apply the birth/survival rule. Only cells with ≥1 live neighbour appear in
  // `counts`; a live cell with 0–1 neighbours is simply never added and dies.
  final next = <int>{};
  for (final idx in counts.keys) {
    final count = counts[idx];
    if (count == 3 || (count == 2 && cells.contains(idx))) {
      next.add(idx);
    }
  }
  return next;
}
