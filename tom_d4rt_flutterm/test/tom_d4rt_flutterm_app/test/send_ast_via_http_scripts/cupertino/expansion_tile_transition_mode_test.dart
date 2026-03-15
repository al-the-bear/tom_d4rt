import 'package:flutter/cupertino.dart';

/// Demonstrates ExpansionTileTransitionMode.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Expansion Transition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeCard('clipFade', CupertinoIcons.scissors),
          const SizedBox(width: 12),
          _ModeCard('heightFactor', CupertinoIcons.arrow_up_arrow_down),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Expand/collapse animation style', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ModeCard extends StatelessWidget {
  final String name; final IconData icon;
  const _ModeCard(this.name, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    width: 90, padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
    child: Column(children: [Icon(icon, size: 24), const SizedBox(height: 4), Text(name, style: const TextStyle(fontSize: 10))]),
  );
}
