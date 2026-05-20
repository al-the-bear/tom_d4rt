// Tic-Tac-Toe — entry #1 from doc/example_app_plan.md.
//
// Two local players take turns marking cells in a 3×3 grid. Each placed
// mark fades + scales in via `AnimatedSwitcher`; on a win, the line
// through the three cells draws across the board via an
// `AnimationController` + `CustomPainter`. Scoreboard at the top tracks
// X / O wins and draws across rounds.
import 'package:flutter/material.dart';

import 'app.dart';

Widget build(BuildContext context) {
  return const TicTacToeApp();
}
