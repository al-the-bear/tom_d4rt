// Game state + screen layout.
//
// Pattern check: this is the canonical "script-defined StatefulWidget +
// State<T> + setState" shape, with `SingleTickerProviderStateMixin` for
// the win-line `AnimationController`. Runs end-to-end after GEN-110
// (MethodInvocation Function-arg dispatch + Callable wrapping),
// GEN-111 (per-iteration for-loop scope), and GEN-112 (RC-9 fallback
// routes bridged-super methods through `nativeStateProxy` so
// `setState` and `AnimationController.forward` actually schedule
// Flutter rebuilds).
import 'package:flutter/material.dart';

import 'cell.dart';
import 'result_banner.dart';
import 'win_line_painter.dart';

class TicTacToeHome extends StatefulWidget {
  const TicTacToeHome({super.key});

  @override
  State<TicTacToeHome> createState() => _TicTacToeHomeState();
}

class _TicTacToeHomeState extends State<TicTacToeHome>
    with SingleTickerProviderStateMixin {
  List<String?> _cells = List<String?>.filled(9, null);
  String _currentPlayer = 'X';
  WinLine? _winLine;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;
  // Monotonic counter incremented on every state change. Used as part
  // of the ResultBanner's AnimatedSwitcher child key so that two
  // consecutive "X's turn" headlines (separated by an "O's turn"
  // mid-animation) don't collide on the same key inside the
  // switcher's outgoing-entries Stack.
  int _turn = 0;
  late final AnimationController _lineController;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  // ── Game logic ────────────────────────────────────────────────────

  void _handleTap(int index) {
    if (_winLine != null) return; // Round already decided.
    if (_cells[index] != null) return; // Cell already taken.
    setState(() {
      _turn = _turn + 1;
      _cells[index] = _currentPlayer;
      final detected = _findWinner();
      if (detected != null) {
        _winLine = detected;
        if (detected.winner == 'X') {
          _xWins = _xWins + 1;
        } else {
          _oWins = _oWins + 1;
        }
        _lineController.forward(from: 0.0);
      } else if (_isFull()) {
        _draws = _draws + 1;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _isFull() {
    for (final c in _cells) {
      if (c == null) return false;
    }
    return true;
  }

  WinLine? _findWinner() {
    // Rows
    for (var r = 0; r < 3; r++) {
      final a = _cells[r * 3];
      final b = _cells[r * 3 + 1];
      final c = _cells[r * 3 + 2];
      if (a != null && a == b && b == c) {
        return WinLine(kind: WinKind.row, index: r, winner: a);
      }
    }
    // Columns
    for (var c = 0; c < 3; c++) {
      final a = _cells[c];
      final b = _cells[c + 3];
      final cc = _cells[c + 6];
      if (a != null && a == b && b == cc) {
        return WinLine(kind: WinKind.column, index: c, winner: a);
      }
    }
    // Diagonals
    final a = _cells[0];
    final b = _cells[4];
    final c = _cells[8];
    if (a != null && a == b && b == c) {
      return WinLine(kind: WinKind.diagDown, index: 0, winner: a);
    }
    final d = _cells[2];
    final e = _cells[6];
    if (d != null && d == b && b == e) {
      return WinLine(kind: WinKind.diagUp, index: 0, winner: d);
    }
    return null;
  }

  void _newRound() {
    setState(() {
      _turn = _turn + 1;
      _cells = List<String?>.filled(9, null);
      _currentPlayer = 'X';
      _winLine = null;
      _lineController.reset();
    });
  }

  void _resetScores() {
    setState(() {
      _turn = _turn + 1;
      _cells = List<String?>.filled(9, null);
      _currentPlayer = 'X';
      _winLine = null;
      _xWins = 0;
      _oWins = 0;
      _draws = 0;
      _lineController.reset();
    });
  }

  // ── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final gameOver = _winLine != null || _isFull();
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset scoreboard',
            onPressed: _resetScores,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResultBanner(
                    currentPlayer: _currentPlayer,
                    winner: _winLine?.winner,
                    isDraw: _winLine == null && _isFull(),
                    xWins: _xWins,
                    oWins: _oWins,
                    draws: _draws,
                    turn: _turn,
                  ),
                  const SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: scheme.outline,
                        ),
                        color: scheme.surface,
                      ),
                      // StackFit.expand forces the grid (and the optional
                      // win-line overlay) to fill the full square allotted
                      // by AspectRatio. Without it the Stack defaults to
                      // loose fit, leaving its children sized to their
                      // intrinsic dimensions — which collapsed the grid
                      // into a thin strip in interactive runs.
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          _buildGrid(scheme),
                          if (_winLine != null) _buildLineOverlay(scheme),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: gameOver ? _newRound : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text('New round'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(ColorScheme scheme) {
    return Column(
      children: List.generate(3, (r) {
        return Expanded(
          child: Row(
            children: List.generate(3, (c) {
              final index = r * 3 + c;
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: c == 2 ? 0 : 1.5,
                        color: scheme.outlineVariant,
                      ),
                      bottom: BorderSide(
                        width: r == 2 ? 0 : 1.5,
                        color: scheme.outlineVariant,
                      ),
                    ),
                  ),
                  child: TicTacToeCell(
                    id: index,
                    value: _cells[index],
                    enabled: _cells[index] == null && _winLine == null,
                    onTap: () => _handleTap(index),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildLineOverlay(ColorScheme scheme) {
    final lineColor =
        _winLine!.winner == 'X' ? scheme.primary : scheme.tertiary;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _lineController,
        builder: (context, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: WinLinePainter(
              line: _winLine!,
              progress: _lineController.value,
              color: lineColor,
            ),
          );
        },
      ),
    );
  }
}
