// Pure model types for the snake game.
//
// `Cell` is a value-like (x, y) grid coordinate — we deliberately
// avoid using `Point<int>` from `dart:math` so the interpreter
// doesn't have to round-trip a generic class for plain int math.
// Equality is by content; `hashCode` is a hand-rolled mix so two
// `Cell`s with the same coords are interchangeable in `contains`
// checks (the collision test for self-bite).
//
// `Direction` is a four-value enum with an `opposite` lookup —
// the host uses it to ignore reverse-direction key presses (a
// 180° turn would instantly self-collide).
//
// Constants live at the top so they're easy to spot when reading
// the sample: 20×20 board, initial snake of length 3, headed
// right, fixed RNG seed so tests can address food positions
// deterministically.
import 'package:flutter/foundation.dart';

/// Board edge length in cells (square board).
const int kBoardSize = 20;

/// Snake length at the start of every game.
const int kInitialSnakeLength = 3;

/// Fixed RNG seed for food placement — keeps the test layout
/// reproducible across boots. Tests rely on this to know which
/// cell the next food will appear in.
const int kFoodSeed = 1337;

/// Initial tick interval. Real auto-play would shrink this as the
/// score climbs (see `tickIntervalForScore`).
const Duration kInitialTickInterval = Duration(milliseconds: 250);

/// Floor on the auto-play tick interval. With a 20×20 board the
/// snake can't move faster than ~12 cells/s before the game stops
/// being playable.
const Duration kMinTickInterval = Duration(milliseconds: 80);

/// How much the tick interval shrinks per pellet eaten, in ms.
const int kTickShrinkPerScore = 12;

@immutable
class Cell {
  final int x;
  final int y;

  const Cell(this.x, this.y);

  Cell shift(int dx, int dy) => Cell(x + dx, y + dy);

  bool get inBounds =>
      x >= 0 && x < kBoardSize && y >= 0 && y < kBoardSize;

  @override
  bool operator ==(Object other) =>
      other is Cell && other.x == x && other.y == y;

  @override
  int get hashCode => x * 1000003 + y;

  @override
  String toString() => '($x,$y)';
}

enum Direction { up, down, left, right }

/// Returns the opposite direction (used to reject 180° turns).
Direction oppositeOf(Direction d) {
  if (d == Direction.up) return Direction.down;
  if (d == Direction.down) return Direction.up;
  if (d == Direction.left) return Direction.right;
  return Direction.left;
}

/// dx for a single step in [d].
int dxOf(Direction d) {
  if (d == Direction.left) return -1;
  if (d == Direction.right) return 1;
  return 0;
}

/// dy for a single step in [d].
int dyOf(Direction d) {
  if (d == Direction.up) return -1;
  if (d == Direction.down) return 1;
  return 0;
}

/// Short, lowercase label for trail prints (`up` / `down` / ...).
String directionLabel(Direction d) {
  if (d == Direction.up) return 'up';
  if (d == Direction.down) return 'down';
  if (d == Direction.left) return 'left';
  return 'right';
}

/// Linear ramp from `kInitialTickInterval` toward `kMinTickInterval`
/// as the score climbs. Clamped so we never go below the floor.
Duration tickIntervalForScore(int score) {
  final shrunk =
      kInitialTickInterval.inMilliseconds - score * kTickShrinkPerScore;
  final clamped = shrunk < kMinTickInterval.inMilliseconds
      ? kMinTickInterval.inMilliseconds
      : shrunk;
  return Duration(milliseconds: clamped);
}
