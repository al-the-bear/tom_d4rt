// Pure game logic: deal the initial snake and food, step the
// snake one cell forward, and detect game-end conditions.
//
// The host holds the mutable game state (`body`, `food`,
// `direction`, `score`, `over`) — these helpers either return new
// values or mutate the list in place via the host's `setState`.
// Keeping the rules functional and side-effect-free makes them
// easy to reason about and trivially testable.
//
// Food spawning is seeded (`kFoodSeed`) so test scripts can
// pre-compute where each pellet will land. The host owns the
// `Random` instance and threads it through these helpers.
import 'dart:math' as math;

import 'board.dart';

/// Initial snake body, head first. Three cells in a row pointing
/// right, sitting near the centre of the board.
List<Cell> initialSnakeBody() {
  // Place the head one cell right of centre so the snake has
  // room to walk a few steps before hitting the right edge in a
  // test.
  final cx = kBoardSize ~/ 2;
  final cy = kBoardSize ~/ 2;
  final body = <Cell>[];
  for (var i = 0; i < kInitialSnakeLength; i++) {
    body.add(Cell(cx - i, cy));
  }
  return body;
}

/// Pick a random unoccupied cell for the next food pellet. Returns
/// `null` if the board is full (which would mean the player has
/// just won — every cell is snake).
Cell? spawnFood(math.Random rng, List<Cell> occupied) {
  final occupiedSet = <Cell>{};
  for (final c in occupied) {
    occupiedSet.add(c);
  }
  final total = kBoardSize * kBoardSize;
  if (occupiedSet.length >= total) return null;
  // Reservoir-pick over the free cells. Cheap on a 20×20 board.
  final free = <Cell>[];
  for (var y = 0; y < kBoardSize; y++) {
    for (var x = 0; x < kBoardSize; x++) {
      final c = Cell(x, y);
      if (!occupiedSet.contains(c)) {
        free.add(c);
      }
    }
  }
  if (free.isEmpty) return null;
  final idx = rng.nextInt(free.length);
  return free[idx];
}

/// Outcome of a single tick.
///
/// `body` is the new body (head first). `ateFood` indicates that
/// the head just landed on the pellet (caller must spawn a new
/// pellet and bump the score). `over` is `true` when the head
/// moved out of bounds or into its own body — the caller must
/// stop the timer and mark game-over.
class StepResult {
  final List<Cell> body;
  final bool ateFood;
  final bool over;
  final String reason;

  const StepResult({
    required this.body,
    required this.ateFood,
    required this.over,
    required this.reason,
  });
}

/// Step the snake one cell forward in [dir]. The previous head is
/// at `body.first`. If the new head lands on [food], the tail is
/// kept (snake grows by one); otherwise the tail is dropped.
StepResult step({
  required List<Cell> body,
  required Direction dir,
  required Cell food,
}) {
  if (body.isEmpty) {
    return const StepResult(
      body: <Cell>[],
      ateFood: false,
      over: true,
      reason: 'empty-body',
    );
  }
  final head = body.first;
  final newHead = head.shift(dxOf(dir), dyOf(dir));
  if (!newHead.inBounds) {
    return StepResult(
      body: body,
      ateFood: false,
      over: true,
      reason: 'wall',
    );
  }
  final ate = newHead == food;
  // Collision check: the new head can land on the current tail
  // cell only if we're *also* shrinking (i.e. not eating) — when
  // the tail moves out of the way the spot is free.
  final compareLimit = ate ? body.length : body.length - 1;
  for (var i = 0; i < compareLimit; i++) {
    if (body[i] == newHead) {
      return StepResult(
        body: body,
        ateFood: false,
        over: true,
        reason: 'self',
      );
    }
  }
  final next = <Cell>[newHead];
  // Grow if we ate, otherwise drop the tail.
  final keepUpTo = ate ? body.length : body.length - 1;
  for (var i = 0; i < keepUpTo; i++) {
    next.add(body[i]);
  }
  return StepResult(
    body: next,
    ateFood: ate,
    over: false,
    reason: ate ? 'eat' : 'move',
  );
}
