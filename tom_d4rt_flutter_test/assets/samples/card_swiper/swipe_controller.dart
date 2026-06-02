// Controller for the card_swiper sample (example #17).
//
// Owns the deck state:
//   * `cards` — initial catalogue of placeholder profiles
//   * `currentIndex` — top of the stack; advances on each fly-away
//   * `liked` / `passed` — running totals shown in the AppBar
//   * `dragOffset` — live offset of the top card while the user is
//      dragging; the deck widget consumes this to apply
//      `Transform.translate` + `Transform.rotate`
//   * `flying` — true between `startFly` and `finishFly` so the deck
//      can render a fly-away animation while ignoring further input
//
// The controller is a `ChangeNotifier`; the deck listens via
// `AnimatedBuilder` and rebuilds on every change. Mutations emit
// trail lines (`swipe.*`) so the in-process tester can assert the
// controller saw the expected sequence:
//
//   swipe.init n=N
//   swipe.drag dx=DX      (only on the first drag of a gesture and
//                          when |dx| crosses the threshold boundary)
//   swipe.release dir=DIR
//   swipe.button dir=DIR
//   swipe.fly id=N dir=DIR
//   swipe.done id=N dir=DIR liked=L passed=P
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Threshold in logical pixels: dragging the card past this distance
/// (positive = right, negative = left) commits the swipe on release.
const double kSwipeThreshold = 80.0;

/// Maximum rotation (radians) the card reaches when dragged a full
/// `kSwipeThreshold * 2` to either side. Chosen empirically — small
/// enough to keep the card readable, large enough to feel responsive.
const double kMaxCardRotation = 0.25;

class SwipeCard {
  final int id;
  final String name;
  final String fact;
  final Color color;

  const SwipeCard({
    required this.id,
    required this.name,
    required this.fact,
    required this.color,
  });
}

/// Stable, deterministic catalogue used by the home page. Six cards
/// is enough to exercise multiple swipes without running the deck
/// dry in the regression suite.
const List<SwipeCard> kDeck = <SwipeCard>[
  SwipeCard(
    id: 0,
    name: 'Alex',
    fact: 'Likes long walks on the heap.',
    color: Color(0xFFFB923C),
  ),
  SwipeCard(
    id: 1,
    name: 'Bree',
    fact: 'Knits her own type inference.',
    color: Color(0xFF0EA5E9),
  ),
  SwipeCard(
    id: 2,
    name: 'Cleo',
    fact: 'Speaks fluent zero-arg constructor.',
    color: Color(0xFF15803D),
  ),
  SwipeCard(
    id: 3,
    name: 'Dana',
    fact: 'Refactors before breakfast.',
    color: Color(0xFFEC4899),
  ),
  SwipeCard(
    id: 4,
    name: 'Eli',
    fact: 'Has strong opinions on null safety.',
    color: Color(0xFF7C3AED),
  ),
  SwipeCard(
    id: 5,
    name: 'Fern',
    fact: 'Believes in unit tests.',
    color: Color(0xFFDC2626),
  ),
];

class SwipeController extends ChangeNotifier {
  final List<SwipeCard> cards;
  int _currentIndex = 0;
  int _liked = 0;
  int _passed = 0;
  Offset _dragOffset = Offset.zero;
  bool _flying = false;

  SwipeController({List<SwipeCard>? deck})
      : cards = List<SwipeCard>.unmodifiable(deck ?? kDeck) {
    print('swipe.init n=${cards.length}');
  }

  int get currentIndex => _currentIndex;
  int get liked => _liked;
  int get passed => _passed;
  Offset get dragOffset => _dragOffset;
  bool get flying => _flying;
  bool get isEmpty => _currentIndex >= cards.length;

  /// Visible top card, or `null` if the deck has been exhausted.
  SwipeCard? get topCard =>
      isEmpty ? null : cards[_currentIndex];

  /// Live progress in `[-1.0, 1.0]` for the gesture overlay (used
  /// to drive opacity hints on the LIKE / PASS labels).
  double get dragProgress {
    if (_dragOffset.dx == 0) return 0.0;
    final p = _dragOffset.dx / kSwipeThreshold;
    if (p > 1.0) return 1.0;
    if (p < -1.0) return -1.0;
    return p;
  }

  bool _lastDragLogged = false;
  void updateDrag(Offset delta) {
    if (_flying || isEmpty) return;
    _dragOffset = _dragOffset + delta;
    // Log sparingly: just the first drag of a gesture, so the trail
    // doesn't blow up on every pan tick.
    if (!_lastDragLogged) {
      _lastDragLogged = true;
      print('swipe.drag dx=${_dragOffset.dx.toStringAsFixed(1)}');
    }
    notifyListeners();
  }

  /// Called when the user lifts the finger. Returns the committed
  /// direction (`-1` for left, `+1` for right, `0` if cancelled).
  int endDrag() {
    if (_flying || isEmpty) return 0;
    _lastDragLogged = false;
    final dx = _dragOffset.dx;
    if (dx > kSwipeThreshold) {
      print('swipe.release dir=right');
      return 1;
    }
    if (dx < -kSwipeThreshold) {
      print('swipe.release dir=left');
      return -1;
    }
    // Snap back to centre.
    print('swipe.release dir=none');
    _dragOffset = Offset.zero;
    notifyListeners();
    return 0;
  }

  /// Programmatic swipe from the bottom buttons. Returns the
  /// direction the deck will animate (`-1` or `+1`); `0` if the deck
  /// is empty or a fly animation is already running.
  int swipeButton({required bool right}) {
    if (_flying || isEmpty) return 0;
    final dir = right ? 1 : -1;
    print('swipe.button dir=${right ? "right" : "left"}');
    return dir;
  }

  /// Called by the deck just before starting the fly animation so
  /// further pointer input is ignored mid-flight.
  void startFly(int direction) {
    if (isEmpty) return;
    _flying = true;
    final id = cards[_currentIndex].id;
    print(
        'swipe.fly id=$id dir=${direction > 0 ? "right" : "left"}');
    notifyListeners();
  }

  /// Called when the fly animation completes. Records the result,
  /// advances the deck, resets the drag offset.
  void finishFly(int direction) {
    if (isEmpty) {
      _flying = false;
      return;
    }
    final id = cards[_currentIndex].id;
    if (direction > 0) {
      _liked += 1;
    } else if (direction < 0) {
      _passed += 1;
    }
    _currentIndex += 1;
    _dragOffset = Offset.zero;
    _flying = false;
    print(
        'swipe.done id=$id dir=${direction > 0 ? "right" : "left"} '
        'liked=$_liked passed=$_passed');
    notifyListeners();
  }
}
