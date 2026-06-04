// Difficulty levels for the memory-match game.
//
// Modelled as a plain `enum` (see `pomodoro_timer/session.dart` for
// the canonical reference) plus top-level helpers — extensions on
// enums are avoided here because top-level functions exercise more
// of the d4rt dispatch surface we already trust.
//
// Easy = 4×4 = 16 cards = 8 pairs.
// Hard = 6×6 = 36 cards = 18 pairs.
enum Difficulty {
  easy,
  hard,
}

/// Side length of the square grid for [d].
int gridSizeOf(Difficulty d) => d == Difficulty.easy ? 4 : 6;

/// Display label for the selector.
String labelOf(Difficulty d) =>
    d == Difficulty.easy ? 'Easy (4×4)' : 'Hard (6×6)';

/// Total card count.
int cardCountOf(Difficulty d) => gridSizeOf(d) * gridSizeOf(d);

/// Number of matching pairs.
int pairCountOf(Difficulty d) => cardCountOf(d) ~/ 2;
