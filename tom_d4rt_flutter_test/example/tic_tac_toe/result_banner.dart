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

  const ResultBanner({
    super.key,
    required this.currentPlayer,
    required this.winner,
    required this.isDraw,
    required this.xWins,
    required this.oWins,
    required this.draws,
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
        // Plain `Text` rather than wrapping in `AnimatedSwitcher`:
        // when the banner's child is repeatedly swapped via a
        // user-State `setState` rebuild, tom_d4rt's bridged
        // `AnimatedSwitcher` accumulates outgoing children in its
        // inner Stack and trips a "Duplicate keys" assertion (4+
        // tickers, same-keyed wrapped Text instances). The cell's
        // AnimatedSwitcher works fine because it transitions on
        // each cell *independently*, not via a shared headline
        // key. Logged in
        // `tom_d4rt_flutter_ast/doc/interpreter_issues.md` for the
        // interpreter fix; the sample uses plain Text for now.
        Text(
          headline,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: headlineColor,
            fontWeight: FontWeight.w800,
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
