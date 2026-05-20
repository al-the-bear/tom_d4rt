// Visual + textual reference for the rules of Sudoku.
//
// Three mini 9×9 grids each highlight one of the regions where the
// digits 1–9 must appear exactly once (row, column, 3×3 box),
// followed by a short list of interaction tips. Designed to sit
// next to the play area on a wide screen.
import 'package:flutter/material.dart';

class SudokuRulesPanel extends StatelessWidget {
  const SudokuRulesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book_outlined,
                    size: 22, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'How to play',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Fill the 9 × 9 grid with digits 1 – 9 so that:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            const _RuleRow(
              highlight: _Highlight.row,
              caption: 'Every row contains the digits 1–9 exactly once.',
            ),
            const SizedBox(height: 14),
            const _RuleRow(
              highlight: _Highlight.col,
              caption:
                  'Every column contains the digits 1–9 exactly once.',
            ),
            const SizedBox(height: 14),
            const _RuleRow(
              highlight: _Highlight.box,
              caption:
                  'Every 3 × 3 box contains the digits 1–9 exactly once.',
            ),
            const SizedBox(height: 20),
            Divider(color: scheme.outlineVariant, height: 1),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.touch_app_outlined,
                    size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Playing',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const _Bullet(
              icon: Icons.ads_click,
              text: 'Tap a cell to select it.',
            ),
            const _Bullet(
              icon: Icons.dialpad,
              text: 'Tap a digit (1–9) to fill the selected cell.',
            ),
            const _Bullet(
              icon: Icons.backspace_outlined,
              text: 'Tap × to erase the selected cell.',
            ),
            _Bullet(
              icon: Icons.priority_high,
              text: 'Conflicts (same digit twice in a row/column/box) '
                  'are shown in red.',
              iconColor: Colors.red.shade700,
            ),
            const _Bullet(
              icon: Icons.lock_outline,
              text: 'Pre-filled clues are bold and cannot be changed.',
            ),
            const _Bullet(
              icon: Icons.skip_next,
              text:
                  'Use the toolbar to reset the puzzle or load the next one.',
            ),
          ],
        ),
      ),
    );
  }
}

enum _Highlight { row, col, box }

class _RuleRow extends StatelessWidget {
  final _Highlight highlight;
  final String caption;

  const _RuleRow({required this.highlight, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MiniGrid(highlight: highlight),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            caption,
            style: const TextStyle(fontSize: 14, height: 1.35),
          ),
        ),
      ],
    );
  }
}

class _MiniGrid extends StatelessWidget {
  final _Highlight highlight;

  const _MiniGrid({required this.highlight});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Soft, theme-derived highlight so the example reads on light or
    // dark surfaces without hard-coding palette values.
    final highlightColor = scheme.primaryContainer;
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black87),
        color: Colors.white,
      ),
      child: Column(
        children: [
          for (var r = 0; r < 9; r++)
            Expanded(
              child: Row(
                children: [
                  for (var c = 0; c < 9; c++)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isHighlighted(r, c)
                              ? highlightColor
                              : Colors.white,
                          border: Border(
                            top: BorderSide(
                              width: r % 3 == 0 ? 1.2 : 0.3,
                              color: r % 3 == 0
                                  ? Colors.black87
                                  : Colors.black26,
                            ),
                            left: BorderSide(
                              width: c % 3 == 0 ? 1.2 : 0.3,
                              color: c % 3 == 0
                                  ? Colors.black87
                                  : Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  bool _isHighlighted(int r, int c) {
    switch (highlight) {
      case _Highlight.row:
        return r == 4;
      case _Highlight.col:
        return c == 4;
      case _Highlight.box:
        return r >= 3 && r < 6 && c >= 3 && c < 6;
    }
  }
}

class _Bullet extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const _Bullet({
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor ?? scheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
