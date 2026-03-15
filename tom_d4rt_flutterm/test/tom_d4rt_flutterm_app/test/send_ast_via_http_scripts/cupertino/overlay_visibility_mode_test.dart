import 'package:flutter/cupertino.dart';

/// Demonstrates OverlayVisibilityMode.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('OverlayVisibilityMode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: const [
          _VisChip('never', CupertinoColors.systemGrey),
          _VisChip('editing', CupertinoColors.activeOrange),
          _VisChip('notEditing', CupertinoColors.systemPurple),
          _VisChip('always', CupertinoColors.activeGreen),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        width: 200, height: 44,
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: const Row(children: [Icon(CupertinoIcons.search, size: 16), SizedBox(width: 8), Text('Search...', style: TextStyle(color: CupertinoColors.systemGrey2))]),
      ),
      const SizedBox(height: 8),
      const Text('Controls prefix/suffix visibility', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _VisChip extends StatelessWidget {
  final String name; final Color color;
  const _VisChip(this.name, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
    child: Text(name, style: const TextStyle(color: CupertinoColors.white, fontSize: 10)),
  );
}
