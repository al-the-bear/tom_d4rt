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
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var n = 1; n <= 9; n++)
          _KeyButton(label: '$n', onTap: () => onNumber(n)),
        _KeyButton(label: '×', onTap: onErase, isErase: true),
      ],
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
