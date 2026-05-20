// Number-entry keypad: digits 1..9 plus an erase button. Pure presentation
// — all entry logic is handled by the callbacks the parent supplies.
import 'package:flutter/material.dart';

class SudokuKeypad extends StatelessWidget {
  final void Function(int) onNumber;
  final VoidCallback onErase;

  const SudokuKeypad({
    super.key,
    required this.onNumber,
    required this.onErase,
  });

  @override
  Widget build(BuildContext context) {
    // List.generate isolates each `n` in its own callback parameter scope so
    // the onTap closure captures a distinct value per button — see board.dart
    // for the same workaround applied to the cell grid.
    final children = List<Widget>.generate(9, (i) {
      final n = i + 1;
      return _KeyButton(label: '$n', onTap: () => onNumber(n));
    });
    children.add(_KeyButton(label: '×', onTap: onErase, isErase: true));
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: children,
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isErase;

  const _KeyButton({
    required this.label,
    required this.onTap,
    this.isErase = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: isErase ? scheme.errorContainer : scheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 44,
          height: 52,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isErase
                    ? scheme.onErrorContainer
                    : scheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
