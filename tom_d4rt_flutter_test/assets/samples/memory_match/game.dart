// Pure model layer for the memory-match game.
//
// `MemoryCard` is a tiny mutable struct (revealed / matched flags
// flip during play). `dealCards` produces a deterministic deck for a
// given seed — important because the tester suite needs the same
// layout on every fresh sample boot so we can address specific
// matching pairs by index.
//
// The shuffle is a textbook Fisher–Yates against a `Random(seed)`
// so the order is reproducible without us reaching into d4rt for
// extra plumbing. The list of face emojis is sized to the largest
// supported grid (18 pairs for 6×6); easy mode just uses the first
// 8.
import 'dart:math' as math;

/// One face-down card in the grid.
///
/// Mutable on purpose — the host's `setState` flips `revealed` and
/// `matched` and we want the change to be visible to the painter
/// without rebuilding the whole list.
class MemoryCard {
  /// Unique slot id in the dealt deck (0..cardCount-1).
  final int id;

  /// Index into the face-emoji rack; two cards share the same
  /// `faceId` exactly when they're a matching pair.
  final int faceId;

  /// Currently face-up?
  bool revealed;

  /// Already matched (stays face-up once solved)?
  bool matched;

  MemoryCard({
    required this.id,
    required this.faceId,
    this.revealed = false,
    this.matched = false,
  });
}

/// Face emojis used to mark pairs. The list is intentionally larger
/// than the hardest difficulty (18 pairs) so we never run out.
const List<String> kFaceRack = <String>[
  '🐶', '🐱', '🦊', '🐻', '🐼', '🐨', '🐯', '🦁', '🐮',
  '🐷', '🐸', '🐵', '🦄', '🐔', '🦉', '🦋', '🐢', '🐙',
];

/// Deal a face-down deck for [cardCount] cards using [seed] for the
/// shuffle. Returns the dealt deck — callers usually copy it into
/// their own list to mutate during play.
///
/// The deck is built by emitting every face twice (so faceIds 0..N-1
/// each appear exactly twice for `N = cardCount ~/ 2`), then
/// Fisher–Yates'd against `Random(seed)`. Slot ids run 0..cardCount-1
/// in shuffled order — they let UI tests address a specific card
/// regardless of layout.
List<MemoryCard> dealCards({required int cardCount, required int seed}) {
  final pairCount = cardCount ~/ 2;
  // Build the face list — each face appears twice.
  final faces = <int>[];
  for (var i = 0; i < pairCount; i++) {
    faces.add(i);
    faces.add(i);
  }
  // Fisher–Yates shuffle with a seeded RNG so tests are reproducible.
  final rng = math.Random(seed);
  for (var i = faces.length - 1; i > 0; i--) {
    final j = rng.nextInt(i + 1);
    final tmp = faces[i];
    faces[i] = faces[j];
    faces[j] = tmp;
  }
  // Wrap in MemoryCard with slot id == position in the shuffled list.
  final deck = <MemoryCard>[];
  for (var i = 0; i < cardCount; i++) {
    deck.add(MemoryCard(id: i, faceId: faces[i]));
  }
  return deck;
}

/// Whether [deck] is fully solved — every card matched.
bool isSolved(List<MemoryCard> deck) {
  for (final card in deck) {
    if (!card.matched) return false;
  }
  return true;
}
