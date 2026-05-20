// Read-only score readout: moves taken, pairs matched, best result.
//
// The "best" column shows the lowest move count this session has
// ever finished a board at the current difficulty — or `—` if the
// player hasn't completed one yet. The host owns the highscore map
// and just passes the current entry in.
import 'package:flutter/material.dart';

class ScorePanel extends StatelessWidget {
  /// Move counter — incremented on every second-card tap that
  /// constitutes a full attempt (match or miss).
  final int moves;

  /// Pairs solved so far.
  final int matches;

  /// Total pairs required to solve the board.
  final int totalPairs;

  /// Best (lowest) move count for the current difficulty, or `null`
  /// if nothing has been finished yet.
  final int? bestMoves;

  /// Whether the board is fully solved — toggles the headline copy.
  final bool solved;

  const ScorePanel({
    super.key,
    required this.moves,
    required this.matches,
    required this.totalPairs,
    required this.bestMoves,
    required this.solved,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      key: const ValueKey<String>('score-panel'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(
            label: 'Moves',
            value: '$moves',
            highlight: !solved,
            scheme: scheme,
            keyId: 'stat-moves',
          ),
          _StatColumn(
            label: 'Pairs',
            value: '$matches / $totalPairs',
            highlight: solved,
            scheme: scheme,
            keyId: 'stat-pairs',
          ),
          _StatColumn(
            label: 'Best',
            value: bestMoves == null ? '—' : '$bestMoves',
            highlight: false,
            scheme: scheme,
            keyId: 'stat-best',
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final ColorScheme scheme;
  final String keyId;

  const _StatColumn({
    required this.label,
    required this.value,
    required this.highlight,
    required this.scheme,
    required this.keyId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey<String>(keyId),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.2,
            color: scheme.outline,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: highlight ? scheme.primary : scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
