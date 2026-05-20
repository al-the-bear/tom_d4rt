// Scoreboard + status headline shown above the board.
//
// Headline animates between "X's turn", "O's turn", "X wins!", "O wins!"
// and "Draw" via `AnimatedSwitcher`. Scores reflect cumulative results
// across rounds.
import 'package:flutter/material.dart';

class ResultBanner extends StatelessWidget {
  final String currentPlayer;
  final String? winner;
  final bool isDraw;
  final int xWins;
  final int oWins;
  final int draws;

  /// Monotonic per-game-state counter used to give the AnimatedSwitcher
  /// child a unique key per setState — without this, alternating
  /// "X's turn" / "O's turn" headlines re-use the same key while the
  /// previous 250 ms reverse-transition is still in flight, which
  /// makes the AnimatedSwitcher's internal Stack hold two entries
  /// with the same key and trip
  /// `debugChildrenHaveDuplicateKeys`. Including the turn number in
  /// the key ensures every entry the switcher tracks is uniquely
  /// identified.
  final int turn;

  const ResultBanner({
    super.key,
    required this.currentPlayer,
    required this.winner,
    required this.isDraw,
    required this.xWins,
    required this.oWins,
    required this.draws,
    required this.turn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    String headline;
    Color headlineColor;
    if (winner != null) {
      headline = '$winner wins!';
      headlineColor = winner == 'X' ? scheme.primary : scheme.tertiary;
    } else if (isDraw) {
      headline = 'Draw';
      headlineColor = scheme.outline;
    } else {
      headline = "$currentPlayer's turn";
      headlineColor = currentPlayer == 'X' ? scheme.primary : scheme.tertiary;
    }

    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            headline,
            // turn-scoped key so each setState transition gets a unique
            // identifier (see field doc above).
            key: ValueKey('$turn:$headline'),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: headlineColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ScoreChip(
              label: 'X',
              value: xWins,
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
            ),
            const SizedBox(width: 12),
            _ScoreChip(
              label: 'Draws',
              value: draws,
              background: scheme.surfaceContainerHighest,
              foreground: scheme.onSurface,
            ),
            const SizedBox(width: 12),
            _ScoreChip(
              label: 'O',
              value: oWins,
              background: scheme.tertiaryContainer,
              foreground: scheme.onTertiaryContainer,
            ),
          ],
        ),
      ],
    );
  }
}

class _ScoreChip extends StatelessWidget {
  final String label;
  final int value;
  final Color background;
  final Color foreground;

  const _ScoreChip({
    required this.label,
    required this.value,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: foreground,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$value',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
