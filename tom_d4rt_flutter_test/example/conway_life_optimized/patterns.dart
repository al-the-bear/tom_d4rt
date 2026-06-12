// Preset patterns for Conway's Game of Life (optimized variant).
//
// Each pattern is a list of `(dx, dy)` offsets relative to an anchor cell.
// `stampAt(anchorX, anchorY)` returns a fresh **sparse board** (`Set<int>` of
// live cell indices) with the pattern's cells set alive — matching the
// integer-keyed sparse model in `board.dart`.
//
// Offsets are written in "human" coordinates with the anchor at the visual
// centre of the pattern, so callers can just say "drop blinker at (30, 20)".
import 'board.dart';

class LifePattern {
  final String name;
  final List<List<int>> offsets;

  const LifePattern(this.name, this.offsets);

  /// Default anchor is the centre cell of the board. Returns a sparse board
  /// (set of live cell indices).
  Set<int> stampAt([int? anchorX, int? anchorY]) {
    final ax = anchorX ?? (kBoardW ~/ 2);
    final ay = anchorY ?? (kBoardH ~/ 2);
    final board = <int>{};
    for (final off in offsets) {
      final x = ax + off[0];
      final y = ay + off[1];
      if (x < 0 || x >= kBoardW) continue;
      if (y < 0 || y >= kBoardH) continue;
      board.add(y * kBoardW + x);
    }
    return board;
  }
}

/// Three cells in a horizontal row — oscillates between horizontal
/// and vertical at the same centre. Period 2.
const LifePattern kBlinker = LifePattern('Blinker', [
  [-1, 0],
  [0, 0],
  [1, 0],
]);

/// 2x2 square — completely static.
const LifePattern kBlock = LifePattern('Block', [
  [0, 0],
  [1, 0],
  [0, 1],
  [1, 1],
]);

/// Classic glider — moves diagonally by (+1, +1) every 4 generations.
const LifePattern kGlider = LifePattern('Glider', [
  [0, -1],
  [1, 0],
  [-1, 1],
  [0, 1],
  [1, 1],
]);

/// Lightweight spaceship — moves horizontally.
const LifePattern kLwss = LifePattern('LWSS', [
  [-2, -1], [1, -1],
  [-3, 0],
  [-3, 1], [1, 1],
  [-3, 2], [-2, 2], [-1, 2], [0, 2],
]);

/// R-pentomino — small but chaotic; expands for ~1100 generations.
const LifePattern kRPentomino = LifePattern('R-pentomino', [
  [0, -1], [1, -1],
  [-1, 0], [0, 0],
  [0, 1],
]);

/// Ordered list of presets surfaced in the UI.
const List<LifePattern> kPatterns = <LifePattern>[
  kBlinker,
  kBlock,
  kGlider,
  kLwss,
  kRPentomino,
];
