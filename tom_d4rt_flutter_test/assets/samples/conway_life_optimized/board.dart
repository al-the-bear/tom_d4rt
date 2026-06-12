// Pure model + step function for Conway's Game of Life (optimized variant).
//
// THE MODEL OPTIMIZATION (particle-field freeze §"conway_life — rewrite the
// rendering AND the model"): the original sample uses a sparse `Set<Cell>` +
// `Map<Cell,int>` neighbour count. Under the d4rt interpreter every `Set` /
// `Map` operation on a `Cell` key dispatches the interpreted `==` / `hashCode`
// and mints fresh `Environment`s + closures — the ~26k `Environment`/gen that
// dominate the per-tick churn.
//
// On a bounded 60×40 board a **dense integer grid** is both simpler and far
// cheaper in the interpreter: the board is a flat `List<int>` of length
// `kBoardW * kBoardH` (1 = alive, 0 = dead), indexed by `y * kBoardW + x`.
// Neighbour counting becomes pure integer index arithmetic — **no `Cell`
// allocation and no interpreted `hashCode` / `==` dispatch per cell**.

/// Board width in cells.
const int kBoardW = 60;

/// Board height in cells.
const int kBoardH = 40;

/// Total cell count of the dense grid.
const int kCellCount = kBoardW * kBoardH;

/// Flat-array index for board coordinate (x, y). No bounds checking — callers
/// guard the edges where it matters.
int cellIndex(int x, int y) => y * kBoardW + x;

/// A fresh all-dead board.
List<int> emptyBoard() => List<int>.filled(kCellCount, 0);

/// Count of alive cells in [cells].
int countAlive(List<int> cells) {
  var n = 0;
  for (final v in cells) {
    if (v == 1) n += 1;
  }
  return n;
}

/// Compute the next generation of [cells].
///
/// Returns a brand-new dense board; the input is not mutated. We scan the
/// whole 60×40 grid once (O(W*H*8) = 19 200 integer reads / gen, independent
/// of population) accumulating each cell's live-neighbour count via index
/// arithmetic. A live cell survives iff its count is 2 or 3; a dead cell
/// becomes alive iff its count is exactly 3. There is no `Cell` object, no
/// `Set`/`Map`, and therefore no interpreted equality dispatch anywhere on
/// the hot path.
List<int> stepLife(List<int> cells) {
  final next = List<int>.filled(kCellCount, 0);
  for (var y = 0; y < kBoardH; y++) {
    for (var x = 0; x < kBoardW; x++) {
      var count = 0;
      for (var dy = -1; dy <= 1; dy++) {
        for (var dx = -1; dx <= 1; dx++) {
          if (dx == 0 && dy == 0) continue;
          final nx = x + dx;
          final ny = y + dy;
          if (nx < 0 || nx >= kBoardW) continue;
          if (ny < 0 || ny >= kBoardH) continue;
          count += cells[ny * kBoardW + nx];
        }
      }
      final idx = y * kBoardW + x;
      final alive = cells[idx] == 1;
      if (alive) {
        if (count == 2 || count == 3) next[idx] = 1;
      } else {
        if (count == 3) next[idx] = 1;
      }
    }
  }
  return next;
}
