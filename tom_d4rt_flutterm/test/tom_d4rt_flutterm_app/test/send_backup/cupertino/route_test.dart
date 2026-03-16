import 'package:flutter/cupertino.dart';

/// Demonstrates Cupertino route concepts.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Cupertino Routes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _RouteCard('CupertinoPageRoute', 'Horizontal slide'),
            const SizedBox(height: 8),
            _RouteCard('CupertinoModalPopupRoute', 'Bottom popup'),
            const SizedBox(height: 8),
            _RouteCard('CupertinoSheetRoute', 'Draggable sheet'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS navigation patterns', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _RouteCard extends StatelessWidget {
  final String name, desc;
  const _RouteCard(this.name, this.desc);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(6)),
    child: Row(children: [
      Expanded(child: Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
      Text(desc, style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey)),
    ]),
  );
}
