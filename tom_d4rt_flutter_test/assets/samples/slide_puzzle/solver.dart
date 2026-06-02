// Breadth-first solver for the 4×4 sliding-tile puzzle.
//
// The full puzzle has ~10^13 reachable states, well beyond BFS, so
// this solver only handles shallow scrambles: we cap the search at
// `maxDepth` (8 by default), which is enough for the in-tester
// shuffle (`PuzzleBoard.shuffleByMoves(N)` with small N). If no
// solution is found within the cap, an empty list is returned and
// the caller is expected to fall back to manual play.
//
// Returns the *sequence of cell taps* (not tile values) that the UI
// should play back to drive the board to its solved state.
import 'puzzle.dart';

List<int> solvePuzzle(PuzzleBoard start, {int maxDepth = 8}) {
  if (start.isSolved) return <int>[];

  // BFS queue holds (board, path-of-taps).
  final List<PuzzleBoard> queueBoards = <PuzzleBoard>[start];
  final List<List<int>> queuePaths = <List<int>>[<int>[]];
  final Set<String> visited = <String>{start.key()};

  while (queueBoards.isNotEmpty) {
    final PuzzleBoard board = queueBoards.removeAt(0);
    final List<int> path = queuePaths.removeAt(0);
    if (path.length >= maxDepth) continue;

    final List<int> nexts = board.tappableCells();
    for (int i = 0; i < nexts.length; i = i + 1) {
      final int cell = nexts[i];
      final PuzzleBoard? moved = board.tap(cell);
      if (moved == null) continue;
      final String k = moved.key();
      if (visited.contains(k)) continue;
      final List<int> newPath = <int>[];
      for (int j = 0; j < path.length; j = j + 1) {
        newPath.add(path[j]);
      }
      newPath.add(cell);
      if (moved.isSolved) return newPath;
      visited.add(k);
      queueBoards.add(moved);
      queuePaths.add(newPath);
    }
  }
  return <int>[];
}
