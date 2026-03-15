import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoColors - iOS system color palette.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('CupertinoColors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      const Wrap(
        spacing: 8, runSpacing: 8,
        children: [
          _ColorChip('activeBlue', CupertinoColors.activeBlue),
          _ColorChip('activeGreen', CupertinoColors.activeGreen),
          _ColorChip('activeOrange', CupertinoColors.activeOrange),
          _ColorChip('destructiveRed', CupertinoColors.destructiveRed),
          _ColorChip('systemGrey', CupertinoColors.systemGrey),
          _ColorChip('systemPurple', CupertinoColors.systemPurple),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Dynamic colors adapt to light/dark mode', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ColorChip extends StatelessWidget {
  final String name; final Color color;
  const _ColorChip(this.name, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    child: Text(name, style: const TextStyle(color: CupertinoColors.white, fontSize: 9)),
  );
}
