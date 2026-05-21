// SnakeGameHome — the state-bearing host that owns the snake body,
// the food pellet, the heading, the score, and the auto-play
// timer.
//
// State machine:
//   • `_body`       — snake cells, head first
//   • `_food`       — current food pellet (or null when the board
//                     is full, which means the player has won)
//   • `_direction`  — the heading the snake actually steps in on
//                     the next tick
//   • `_queuedDir`  — the most recent input, applied on the next
//                     tick. Buffering input one tick deep makes
//                     180° rejection robust against fast double
//                     taps and lets the player queue a turn mid-
//                     animation.
//   • `_score`      — pellets eaten so far. The auto-play tick
//                     interval ramps down with score.
//   • `_over`       — true once the head leaves the board or
//                     bites the body. Stops the timer and shows
//                     the game-over modal banner.
//   • `_paused`     — true at boot and after game-over. Toggled by
//                     the Play/Pause button or space bar.
//   • `_ticker`     — Timer.periodic that drives auto-play. Null
//                     while paused.
//
// Tests can drive the game deterministically because:
//   • the game starts paused, so no Timer fires until requested,
//   • the `step` button advances exactly one tick,
//   • the RNG is seeded (`kFoodSeed`), so food placement is
//     reproducible across boots.
//
// Every state-affecting branch emits a one-line `print()` so
// tests can observe the run via the host's `_printLog` zone
// capture.
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'board.dart';
import 'board_painter.dart';
import 'keymap.dart';
import 'snake.dart';

class SnakeGameHome extends StatefulWidget {
  const SnakeGameHome({super.key});

  @override
  State<SnakeGameHome> createState() => _SnakeGameHomeState();
}

class _SnakeGameHomeState extends State<SnakeGameHome> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'snake-board');
  // Mirrors the focus-tracking that tron uses: lets us tell from the
  // log whether the KeyboardListener actually has focus during
  // gameplay (lines like `snake.focus -> true/false`).
  bool _hasFocus = false;
  late math.Random _rng;
  List<Cell> _body = <Cell>[];
  Cell? _food;
  Direction _direction = Direction.right;
  Direction _queuedDir = Direction.right;
  int _score = 0;
  int _bestScore = 0;
  bool _over = false;
  bool _paused = true;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _resetGame(announce: 'init');
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    final has = _focusNode.hasFocus;
    if (has != _hasFocus) {
      _hasFocus = has;
      print('snake.focus -> $has');
    }
  }

  // ── Game lifecycle ──────────────────────────────────────────────

  void _resetGame({String announce = 'reset'}) {
    _ticker?.cancel();
    _ticker = null;
    _rng = math.Random(kFoodSeed);
    _body = initialSnakeBody();
    _food = spawnFood(_rng, _body);
    _direction = Direction.right;
    _queuedDir = Direction.right;
    _score = 0;
    _over = false;
    _paused = true;
    print('snake.$announce body=${_body.length} food=$_food '
        'dir=${directionLabel(_direction)}');
  }

  void _setDirection(Direction next) {
    if (_over) return;
    if (next == oppositeOf(_direction) && _body.length > 1) {
      // Reject reversing into our own neck — Dart's snake fans
      // are unanimous on this.
      print('snake.dir ignored=${directionLabel(next)} reason=reverse');
      return;
    }
    setState(() {
      _queuedDir = next;
    });
    print('snake.dir queued=${directionLabel(next)}');
  }

  void _tick() {
    if (_over) return;
    final dir = _queuedDir;
    final result = step(body: _body, dir: dir, food: _food ?? const Cell(-1, -1));
    if (result.over) {
      setState(() {
        _direction = dir;
        _over = true;
        _paused = true;
      });
      _ticker?.cancel();
      _ticker = null;
      if (_score > _bestScore) {
        _bestScore = _score;
        print('snake.newBest score=$_score');
      }
      print('snake.over reason=${result.reason} score=$_score '
          'body=${_body.length}');
      return;
    }
    final ate = result.ateFood;
    setState(() {
      _direction = dir;
      _body = result.body;
      if (ate) {
        _score++;
        _food = spawnFood(_rng, _body);
      }
    });
    if (ate) {
      print('snake.eat score=$_score body=${_body.length} food=$_food');
      // Speed up: restart the timer with the new interval.
      _restartTickerIfRunning();
    } else {
      print('snake.tick dir=${directionLabel(dir)} head=${_body.first} '
          'body=${_body.length}');
    }
  }

  void _togglePause() {
    if (_over) {
      // Pause toggle is also "restart" once the snake has died —
      // mirrors the keyboard contract where space restarts at
      // game-over.
      setState(() {
        _resetGame(announce: 'reset');
      });
      return;
    }
    setState(() {
      _paused = !_paused;
    });
    if (_paused) {
      _ticker?.cancel();
      _ticker = null;
      print('snake.pause');
    } else {
      _restartTickerIfRunning();
      print('snake.play interval=${tickIntervalForScore(_score).inMilliseconds}');
    }
  }

  void _restartTickerIfRunning() {
    if (_paused || _over) return;
    _ticker?.cancel();
    _ticker = Timer.periodic(tickIntervalForScore(_score), (_) {
      if (!mounted) return;
      _tick();
    });
  }

  // ── Keyboard handling ───────────────────────────────────────────

  void _onKeyEvent(KeyEvent event) {
    // Log EVERY event that reaches the handler — type, key, focus —
    // before the down/up filter. If the user's interactive trail
    // shows no `snake.key.in` lines during gameplay, the events
    // aren't reaching the handler (focus stolen or interpreter
    // backlog). If they're there but `snake.dir queued` lines are
    // missing, the down/up type filter is dropping them.
    print('snake.key.in type=${event.runtimeType} '
        'key=${event.logicalKey.debugName} focus=$_hasFocus');
    // We only react to *down* events. Holding a key doesn't
    // repeat-fire — the player gets one direction change per
    // press, which matches every other snake.
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;
    final dir = directionFromKey(key);
    if (dir != null) {
      _setDirection(dir);
      return;
    }
    if (isResetKey(key)) {
      setState(() {
        _resetGame(announce: 'reset');
      });
      return;
    }
    if (isPauseKey(key)) {
      _togglePause();
      return;
    }
  }

  // ── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text('Snake'),
        backgroundColor: scheme.surface,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                'Best: $_bestScore',
                key: const ValueKey<String>('best-readout'),
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _onKeyEvent,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                child: Row(
                  key: const ValueKey<String>('score-row'),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Score: $_score',
                      key: const ValueKey<String>('score-readout'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _over ? scheme.error : scheme.primary,
                      ),
                    ),
                    if (_over)
                      const Text(
                        'GAME OVER',
                        key: ValueKey<String>('game-over-banner'),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    Text(
                      _paused ? 'PAUSED' : 'PLAYING',
                      key: const ValueKey<String>('state-readout'),
                      style: TextStyle(
                        color: scheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: scheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CustomPaint(
                            key: const ValueKey<String>('snake-canvas'),
                            size: Size.infinite,
                            painter: BoardPainter(
                              body: _body,
                              food: _food,
                              over: _over,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _ControlBar(
                paused: _paused,
                over: _over,
                onDirection: _setDirection,
                onStep: _tick,
                onTogglePause: _togglePause,
                onReset: () {
                  setState(() {
                    _resetGame(announce: 'reset');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlBar extends StatelessWidget {
  final bool paused;
  final bool over;
  final void Function(Direction d) onDirection;
  final VoidCallback onStep;
  final VoidCallback onTogglePause;
  final VoidCallback onReset;

  const _ControlBar({
    required this.paused,
    required this.over,
    required this.onDirection,
    required this.onStep,
    required this.onTogglePause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      child: Column(
        children: [
          // D-pad row 1: up
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DirButton(
                keyId: 'btn-up',
                icon: Icons.arrow_upward,
                onPressed: over ? null : () => onDirection(Direction.up),
              ),
            ],
          ),
          // D-pad row 2: left, step, right
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DirButton(
                keyId: 'btn-left',
                icon: Icons.arrow_back,
                onPressed: over ? null : () => onDirection(Direction.left),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 56,
                height: 48,
                child: OutlinedButton(
                  key: const ValueKey<String>('btn-step'),
                  onPressed: over ? null : onStep,
                  child: const Text('Step'),
                ),
              ),
              const SizedBox(width: 8),
              _DirButton(
                keyId: 'btn-right',
                icon: Icons.arrow_forward,
                onPressed: over ? null : () => onDirection(Direction.right),
              ),
            ],
          ),
          // D-pad row 3: down
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DirButton(
                keyId: 'btn-down',
                icon: Icons.arrow_downward,
                onPressed: over ? null : () => onDirection(Direction.down),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Play/Pause + Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: FilledButton.tonalIcon(
                  key: const ValueKey<String>('btn-play-pause'),
                  onPressed: onTogglePause,
                  icon: Icon(
                    over
                        ? Icons.refresh
                        : (paused ? Icons.play_arrow : Icons.pause),
                  ),
                  label: Text(
                    over ? 'Restart' : (paused ? 'Play' : 'Pause'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 120,
                child: OutlinedButton.icon(
                  key: const ValueKey<String>('btn-reset'),
                  onPressed: onReset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DirButton extends StatelessWidget {
  final String keyId;
  final IconData icon;
  final VoidCallback? onPressed;

  const _DirButton({
    required this.keyId,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: 56,
        height: 48,
        child: OutlinedButton(
          key: ValueKey<String>(keyId),
          onPressed: onPressed,
          child: Icon(icon),
        ),
      ),
    );
  }
}
