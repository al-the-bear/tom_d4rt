// Keyboard-to-direction mapping for the snake game.
//
// `directionFromKey` recognises both arrow keys and WASD. The
// returned `Direction` may still be ignored by the host if it
// would force a 180° reverse — but that's a *game-rule* concern,
// not a key-mapping one, so it stays in `home.dart`.
//
// `isResetKey` covers Enter and R, matching the on-screen reset
// button. Used to restart from the game-over modal.
//
// `isPauseKey` is the space bar — pauses or resumes auto-play.
import 'package:flutter/services.dart';

import 'board.dart';

/// Map a logical key to a snake direction, or `null` if the key
/// isn't a direction input.
Direction? directionFromKey(LogicalKeyboardKey key) {
  if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
    return Direction.up;
  }
  if (key == LogicalKeyboardKey.arrowDown ||
      key == LogicalKeyboardKey.keyS) {
    return Direction.down;
  }
  if (key == LogicalKeyboardKey.arrowLeft ||
      key == LogicalKeyboardKey.keyA) {
    return Direction.left;
  }
  if (key == LogicalKeyboardKey.arrowRight ||
      key == LogicalKeyboardKey.keyD) {
    return Direction.right;
  }
  return null;
}

bool isResetKey(LogicalKeyboardKey key) {
  return key == LogicalKeyboardKey.enter ||
      key == LogicalKeyboardKey.keyR;
}

bool isPauseKey(LogicalKeyboardKey key) {
  return key == LogicalKeyboardKey.space;
}
