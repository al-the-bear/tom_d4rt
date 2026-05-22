import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'engine.dart';
import 'painter.dart';

class TronHome extends StatefulWidget {
  const TronHome({super.key});

  @override
  State<TronHome> createState() => _TronHomeState();
}

class _TronHomeState extends State<TronHome> {
  late TronEngine _engine;
  Timer? _ticker;

  /// Bumped on every tick. AnimatedBuilder watches this and
  /// rebuilds ONLY the CustomPaint subtree.
  final ValueNotifier<int> _tickNotifier = ValueNotifier<int>(0);

  // Keyboard focus node + visible status so the user can see whether
  // the arena is currently receiving key events.
  final FocusNode _focusNode = FocusNode(debugLabel: 'tron-keys');
  bool _hasFocus = false;

  int _playerWins = 0;
  int _aiWins = 0;
  int _draws = 0;
  bool _paused = false;

  /// The first round starts paused — we wait until the user presses a
  /// key (any key) before the ticker takes its first step. Without this
  /// the AI would win in ~3 seconds before the user realises they're
  /// expected to steer. After a round ends, restart also leaves the
  /// game in this "armed but not ticking" state.
  bool _started = false;

  /// Snapshot of the keys held at the previous tick poll. Used for
  /// edge detection — a key in [_pollKeyboardForTurn]'s current
  /// snapshot but NOT in this set is a fresh press and triggers
  /// exactly one turn. Holding a key down doesn't compound into a
  /// spiral the way it would with snake-style "is currently held"
  /// polling (snake uses absolute directions; tron uses 90° relative
  /// turns, so each press must be one-shot).
  Set<LogicalKeyboardKey> _previouslyHeld =
      const <LogicalKeyboardKey>{};

  // Aligned with snake_game (250 ms). Snake plays fine at this rate
  // after the Timer-bridge multi-yield (commit 13528d0a). Tron at
  // 180 ms had visible problems: input felt sluggish (events queued
  // behind heavier per-tick AI flood-fill), and post-game-over
  // keypress flushes carried into the new round with the wrong
  // direction queued. Slower tick + edge-detected polling fixes
  // both.
  static const Duration _tickRate = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _engine = TronEngine();
    _focusNode.addListener(_onFocusChange);
    _start();
    print('[tron] init');
  }

  void _onFocusChange() {
    final has = _focusNode.hasFocus;
    if (has != _hasFocus) {
      setState(() => _hasFocus = has);
      print('[tron] focus changed -> $has');
    }
  }

  void _start() {
    _ticker?.cancel();
    _ticker = Timer.periodic(_tickRate, _onTick);
  }

  void _onTick(Timer _) {
    // Poll keyboard FIRST — this both detects the first key press
    // (arming the game) and responds to in-game turns. It runs
    // unconditionally so even the "not started" state still picks
    // up the very-first key.
    _pollKeyboardForTurn();
    if (!_started) return;
    if (_paused) return;
    if (_engine.status != GameStatus.playing) return;
    final prev = _engine.status;
    final next = _engine.step();
    _tickNotifier.value = _engine.tick;
    if (next != prev && next != GameStatus.playing) {
      if (next == GameStatus.playerWin) _playerWins++;
      if (next == GameStatus.aiWin) _aiWins++;
      if (next == GameStatus.draw) _draws++;
      print('[tron] round ended: $next  '
          'score player=$_playerWins ai=$_aiWins draw=$_draws');
      if (mounted) setState(() {});
    }
  }

  /// Tick-aligned keyboard polling. Looks at the CURRENT set of held
  /// logical keys (via `HardwareKeyboard.instance.logicalKeysPressed`),
  /// finds keys that are pressed now but weren't on the previous
  /// poll (edge detection — a "fresh press"), and acts on the first
  /// fresh control key.
  ///
  /// Why edge detection instead of snake-style "is held":
  /// - Snake controls are absolute (Arrow Down = "face down"), so
  ///   continuously asserting the held direction is idempotent.
  /// - Tron controls are relative — `_turnLeft()` adds 90° CCW to
  ///   the current heading. Continuously applying it while the user
  ///   holds Arrow Left would spiral the bike. Only the transition
  ///   from "not held" → "held" should turn.
  ///
  /// Also handles the game-over → any-key-restarts contract via the
  /// same polling path, so post-game-over key bursts can't leak into
  /// the next round with the wrong direction queued.
  void _pollKeyboardForTurn() {
    final held = HardwareKeyboard.instance.logicalKeysPressed;
    final fresh = held.difference(_previouslyHeld);
    _previouslyHeld = held.toSet();

    if (fresh.isEmpty) return;

    // Game over: any fresh press restarts. We do NOT queue a turn
    // here — the next tick's poll will see the held key (after the
    // restart resets `_previouslyHeld`), and apply the turn then.
    if (_engine.status != GameStatus.playing) {
      _restart();
      return;
    }

    // Find the first relevant control key in the fresh set and act
    // on it. One control per tick keeps the bike's direction from
    // flipping on simultaneous arrow presses.
    for (final k in fresh) {
      if (k == LogicalKeyboardKey.arrowLeft ||
          k == LogicalKeyboardKey.keyA) {
        _turnLeft();
        return;
      }
      if (k == LogicalKeyboardKey.arrowRight ||
          k == LogicalKeyboardKey.keyD) {
        _turnRight();
        return;
      }
      if (k == LogicalKeyboardKey.space) {
        if (!_started) {
          setState(() => _started = true);
          print('[tron] started');
        } else {
          _togglePause();
        }
        return;
      }
    }
  }

  void _restart() {
    print('[tron] restart');
    setState(() {
      _engine.reset();
      _paused = false;
      // Re-arm — the ticker will sit idle again until the user
      // presses a key. Prevents the "AI wins before you blink"
      // surprise after every restart.
      _started = false;
    });
    _tickNotifier.value = _engine.tick;
    // Reset the polling snapshot so a key the user is STILL HOLDING
    // through the game-over → restart transition counts as a fresh
    // press on the next tick (and steers / arms the game). Without
    // this clear, the held key would compare equal to the previous
    // snapshot and be ignored as "not fresh".
    _previouslyHeld = <LogicalKeyboardKey>{};
    _focusNode.requestFocus();
  }

  void _turnLeft() {
    if (_engine.status != GameStatus.playing) return;
    _engine.player.queueTurnLeft();
    // Steering also arms the ticker — covers the on-screen LEFT
    // button path so clicking it starts the game just like pressing
    // an arrow key.
    if (!_started) {
      setState(() => _started = true);
      print('[tron] started');
    }
    print('[tron] LEFT  -> pending=${_engine.player.pendingDir}');
  }

  void _turnRight() {
    if (_engine.status != GameStatus.playing) return;
    _engine.player.queueTurnRight();
    if (!_started) {
      setState(() => _started = true);
      print('[tron] started');
    }
    print('[tron] RIGHT -> pending=${_engine.player.pendingDir}');
  }

  void _togglePause() {
    setState(() => _paused = !_paused);
    print('[tron] paused=$_paused');
    _focusNode.requestFocus();
  }

  /// Key handler for the [KeyboardListener] wrapping the arena.
  ///
  /// Actual steering lives in [_pollKeyboardForTurn] driven from
  /// `_onTick`, NOT here — see that method for the reasoning. This
  /// handler does two things:
  ///   1. Diagnostic print for every key event.
  ///   2. Maintain `_previouslyHeld` so a fast tap+release between
  ///      ticks is still treated as a fresh press when it arrives.
  ///      Without this, a release between two ticks would leave the
  ///      key in the snapshot, and the next press would be ignored
  ///      as "not fresh".
  void _handleKey(KeyEvent event) {
    final typeName = event.runtimeType.toString();
    if (typeName == 'KeyUpEvent') {
      // Drop the released key from the polling baseline so the next
      // press (potentially within the same tick window) registers
      // as fresh.
      _previouslyHeld = Set<LogicalKeyboardKey>.of(_previouslyHeld)
        ..remove(event.logicalKey);
      print('[tron] key=${event.logicalKey.debugName} (up)');
      return;
    }
    if (typeName != 'KeyDownEvent' && typeName != 'KeyRepeatEvent') {
      return;
    }
    print('[tron] key=${event.logicalKey.debugName}');
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _tickNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // KeyboardListener (rather than raw Focus.onKeyEvent) — proven
        // pattern that the snake example uses. Wraps Focus + key
        // routing internally and exposes a plain `void(KeyEvent)`
        // callback, dodging the unreliable
        // `KeyEventResult`-returning Focus.onKeyEvent path under d4rt.
        child: KeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKey,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _focusNode.requestFocus();
              print('[tron] background tap -> request focus');
            },
            child: Column(
              children: [
                _TopBar(
                  playerWins: _playerWins,
                  aiWins: _aiWins,
                  draws: _draws,
                  paused: _paused,
                  hasFocus: _hasFocus,
                  onRestart: _restart,
                  onPauseToggle: _togglePause,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _engine.cols / _engine.rows,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            RepaintBoundary(
                              child: AnimatedBuilder(
                                animation: _tickNotifier,
                                builder: (context, _) {
                                  return CustomPaint(
                                    painter: ArenaPainter(
                                      engine: _engine,
                                      tick: _tickNotifier.value,
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (_engine.status != GameStatus.playing)
                              _GameOverOverlay(
                                status: _engine.status,
                                onRestart: _restart,
                              )
                            else if (!_started)
                              const _StartOverlay(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _ControlBar(
                  onLeft: _turnLeft,
                  onRight: _turnRight,
                  onPause: _togglePause,
                  paused: _paused,
                ),
                _HelpBar(hasFocus: _hasFocus),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int playerWins;
  final int aiWins;
  final int draws;
  final bool paused;
  final bool hasFocus;
  final VoidCallback onRestart;
  final VoidCallback onPauseToggle;

  const _TopBar({
    required this.playerWins,
    required this.aiWins,
    required this.draws,
    required this.paused,
    required this.hasFocus,
    required this.onRestart,
    required this.onPauseToggle,
  });

  @override
  Widget build(BuildContext context) {
    // The top bar is wide on a desktop window but overflows narrow
    // ones (and the default test viewport). Wrapping the Row in a
    // horizontal SingleChildScrollView turns overflow into "scroll"
    // instead of "RenderFlex overflow assertion".
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF0A0E18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        children: [
          const Icon(Icons.electric_bolt, color: Color(0xFF00E5FF)),
          const SizedBox(width: 8),
          const Text(
            'TRON',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              color: Color(0xFF00E5FF),
            ),
          ),
          const SizedBox(width: 16),
          _FocusBadge(hasFocus: hasFocus),
          const SizedBox(width: 16),
          _ScoreChip(
              label: 'YOU',
              value: playerWins,
              color: const Color(0xFF00E5FF)),
          const SizedBox(width: 12),
          _ScoreChip(
              label: 'CPU', value: aiWins, color: const Color(0xFFFF2D55)),
          const SizedBox(width: 12),
          _ScoreChip(label: 'DRAW', value: draws, color: Colors.grey),
          const SizedBox(width: 24),
          // Spacer() can't live inside SingleChildScrollView (unbounded
          // main axis) — use a fixed gap so the bar still scrolls.
          IconButton(
            tooltip: paused ? 'Resume' : 'Pause',
            onPressed: onPauseToggle,
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
          ),
          IconButton(
            tooltip: 'Restart',
            onPressed: onRestart,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      ),
    );
  }
}

class _FocusBadge extends StatelessWidget {
  final bool hasFocus;
  const _FocusBadge({required this.hasFocus});

  @override
  Widget build(BuildContext context) {
    final color = hasFocus ? const Color(0xFF22E07A) : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(6),
        color: color.withOpacity(0.10),
      ),
      child: Row(
        children: [
          Icon(
            hasFocus ? Icons.keyboard : Icons.keyboard_hide,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            hasFocus ? 'KEYS ACTIVE' : 'CLICK TO ACTIVATE',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _ScoreChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(6),
        color: color.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 12,
              )),
          const SizedBox(width: 8),
          Text('$value',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}

class _ControlBar extends StatelessWidget {
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onPause;
  final bool paused;
  const _ControlBar({
    required this.onLeft,
    required this.onRight,
    required this.onPause,
    required this.paused,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SteerButton(
            icon: Icons.arrow_back,
            label: 'LEFT  (A / ←)',
            color: const Color(0xFF00E5FF),
            onTap: onLeft,
          ),
          const SizedBox(width: 16),
          OutlinedButton.icon(
            onPressed: onPause,
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
            label: Text(paused ? 'RESUME' : 'PAUSE'),
          ),
          const SizedBox(width: 16),
          _SteerButton(
            icon: Icons.arrow_forward,
            label: 'RIGHT  (D / →)',
            color: const Color(0xFF00E5FF),
            onTap: onRight,
          ),
        ],
      ),
    );
  }
}

class _SteerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _SteerButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color.withOpacity(0.7), width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpBar extends StatelessWidget {
  final bool hasFocus;
  const _HelpBar({required this.hasFocus});

  @override
  Widget build(BuildContext context) {
    // Same scroll-on-overflow trick as the top bar — the inline key
    // labels add up to ~600 px and overflow narrow viewports.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFF0A0E18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!hasFocus) ...[
            const Icon(Icons.touch_app, size: 16, color: Colors.amber),
            const SizedBox(width: 6),
            const Text(
              'Click the arena to activate keyboard, or use the buttons.',
              style: TextStyle(color: Colors.amber),
            ),
          ] else ...[
            const _Key(text: 'A'),
            const SizedBox(width: 4),
            const Text('/'),
            const SizedBox(width: 4),
            const _Key(text: '←'),
            const SizedBox(width: 6),
            const Text('left   '),
            const SizedBox(width: 12),
            const _Key(text: 'D'),
            const SizedBox(width: 4),
            const Text('/'),
            const SizedBox(width: 4),
            const _Key(text: '→'),
            const SizedBox(width: 6),
            const Text('right   '),
            const SizedBox(width: 12),
            const _Key(text: 'SPACE'),
            const SizedBox(width: 6),
            const Text('pause / restart'),
          ],
        ],
      ),
      ),
    );
  }
}

class _Key extends StatelessWidget {
  final String text;
  const _Key({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2436),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF2E4566)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Color(0xFF9DC3FF),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Overlay shown before the first move of a round. Disappears when the
/// user presses any key (or taps a steering button).
class _StartOverlay extends StatelessWidget {
  const _StartOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.45),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'READY',
            style: TextStyle(
              color: Color(0xFF00E5FF),
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 12,
              shadows: [
                Shadow(color: Color(0x9900E5FF), blurRadius: 14),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Press any key to start',
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A / ←  turn left   ·   D / →  turn right',
            style: TextStyle(
              color: Colors.white.withOpacity(0.62),
              fontSize: 13,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  final GameStatus status;
  final VoidCallback onRestart;
  const _GameOverOverlay({required this.status, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final (String title, Color color) = switch (status) {
      GameStatus.playerWin => ('YOU WIN', const Color(0xFF00E5FF)),
      GameStatus.aiWin => ('CPU WINS', const Color(0xFFFF2D55)),
      GameStatus.draw => ('DRAW', Colors.amber),
      _ => ('', Colors.white),
    };

    return Container(
      color: Colors.black.withOpacity(0.55),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 56,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
              shadows: [
                Shadow(color: color.withOpacity(0.7), blurRadius: 18),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRestart,
            icon: const Icon(Icons.refresh),
            label: const Text('Play again  (SPACE)'),
          ),
        ],
      ),
    );
  }
}
