// Host-owned controller for the optimized Conway's Life board.
//
// THE RENDERING OPTIMIZATION (particle-field freeze §"conway_life"): the
// original sample drives the board with a per-tick `setState`, which under the
// d4rt interpreter re-interprets the entire `build()` every generation. Here
// the mutable state lives in `ValueNotifier`s owned by this controller:
//
//   * `cells` — the sparse live board (`Set<int>` of cell indices). Drives the
//               painter directly via `CustomPainter(repaint: cells)`, so a tick
//               repaints the board with **zero widget rebuild** (only the
//               interpreted `paint()` re-runs).
//   * `stats` — `LifeStats(gen, alive)`, drives the `gen=… alive=…` chip via a
//               tiny `ValueListenableBuilder` rather than rebuilding the bar.
//   * `paused` / `tickMs` — drive the play/pause icon and the speed slider.
//
// Together with the integer-keyed sparse model in `board.dart`, this removes
// both allocation sources the doc identifies: the per-tick widget rebuild and
// the per-generation interpreter churn inside `stepLife` (work now scales with
// live-cell count, with native int keys instead of interpreted `Cell` hashing).
//
// ignore_for_file: avoid_print — the print() lines are the run/test trail.
import 'dart:async';
import 'dart:ui' show Offset, Size;

import 'package:flutter/foundation.dart';

import 'board.dart';
import 'patterns.dart';

/// Immutable snapshot of the two scalar readouts the control bar shows.
/// `==` is defined so the chip's `ValueListenableBuilder` only rebuilds when
/// a value actually changes.
@immutable
class LifeStats {
  final int gen;
  final int alive;

  const LifeStats(this.gen, this.alive);

  @override
  bool operator ==(Object other) =>
      other is LifeStats && other.gen == gen && other.alive == alive;

  @override
  int get hashCode => gen * 100003 + alive;
}

class LifeController {
  final ValueNotifier<Set<int>> cells =
      ValueNotifier<Set<int>>(emptyBoard());
  final ValueNotifier<LifeStats> stats =
      ValueNotifier<LifeStats>(const LifeStats(0, 0));
  final ValueNotifier<bool> paused = ValueNotifier<bool>(true);
  final ValueNotifier<double> tickMs = ValueNotifier<double>(200.0);
  Timer? _ticker;
  int _gen = 0;

  LifeController() {
    print('life.init w=$kBoardW h=$kBoardH gen=0 alive=0');
  }

  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    cells.dispose();
    stats.dispose();
    paused.dispose();
    tickMs.dispose();
  }

  void _publish(int alive) {
    stats.value = LifeStats(_gen, alive);
  }

  void stepOnce() {
    final next = stepLife(cells.value);
    cells.value = next;
    _gen += 1;
    final alive = countAlive(next);
    _publish(alive);
    print('life.step gen=$_gen alive=$alive');
  }

  void clear() {
    cells.value = emptyBoard();
    _gen = 0;
    _publish(0);
    print('life.clear gen=0 alive=0');
  }

  void togglePause() {
    final next = !paused.value;
    paused.value = next;
    if (next) {
      _ticker?.cancel();
      _ticker = null;
      print('life.pause');
    } else {
      _restartTicker();
      print('life.play interval=${tickMs.value.round()}ms');
    }
  }

  void _restartTicker() {
    _ticker?.cancel();
    final ms = tickMs.value.round();
    _ticker = Timer.periodic(Duration(milliseconds: ms), (_) {
      stepOnce();
    });
  }

  void onSpeedChanged(double v) {
    tickMs.value = v;
    print('life.slider ms=${v.round()}');
    if (!paused.value) {
      _restartTicker();
    }
  }

  void applyPreset(LifePattern p) {
    final board = p.stampAt();
    cells.value = board;
    _gen = 0;
    final alive = countAlive(board);
    _publish(alive);
    print('life.preset name=${p.name} alive=$alive');
  }

  int? _hitIndex(Offset local, Size size) {
    if (size.width <= 0 || size.height <= 0) return null;
    final cellW = size.width / kBoardW;
    final cellH = size.height / kBoardH;
    final x = (local.dx / cellW).floor();
    final y = (local.dy / cellH).floor();
    if (x < 0 || x >= kBoardW) return null;
    if (y < 0 || y >= kBoardH) return null;
    return y * kBoardW + x;
  }

  /// Tap: toggle the cell under the pointer.
  void toggleCellAt(Offset local, Size size) {
    final idx = _hitIndex(local, size);
    if (idx == null) return;
    final next = Set<int>.of(cells.value);
    if (next.contains(idx)) {
      next.remove(idx);
    } else {
      next.add(idx);
    }
    cells.value = next;
    final alive = next.length;
    _publish(alive);
    final x = idx % kBoardW;
    final y = idx ~/ kBoardW;
    print('life.toggle x=$x y=$y alive=$alive');
  }

  /// Pan: paint the cell under the pointer ON (skips cells already alive, so a
  /// drag draws rather than flickers — matching the original sample).
  void paintCellAt(Offset local, Size size) {
    final idx = _hitIndex(local, size);
    if (idx == null) return;
    if (cells.value.contains(idx)) return;
    final next = Set<int>.of(cells.value);
    next.add(idx);
    cells.value = next;
    final alive = next.length;
    _publish(alive);
    final x = idx % kBoardW;
    final y = idx ~/ kBoardW;
    print('life.toggle x=$x y=$y alive=$alive');
  }
}
