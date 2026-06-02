// Sudoku — multi-file D4rt sample app.
//
// Entry point: `build(BuildContext)` returns the top-level SudokuApp widget.
// The test runner discovers this file via the example/ folder dropdown,
// resolves all relative imports (board.dart, home.dart, …) into the
// interpreter's sources map, and invokes `build` with a real BuildContext.
import 'package:flutter/material.dart';

import 'app.dart';

Widget build(BuildContext context) {
  return const SudokuApp();
}
