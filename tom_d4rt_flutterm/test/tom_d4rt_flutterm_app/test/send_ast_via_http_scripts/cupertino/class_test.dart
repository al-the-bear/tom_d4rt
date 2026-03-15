import 'package:flutter/cupertino.dart';

/// Demonstrates Cupertino framework class hierarchy overview.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Cupertino Framework', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: CupertinoColors.systemGrey6, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const _ChipRow(['CupertinoApp', 'CupertinoTheme']),
            const SizedBox(height: 8),
            const _ChipRow(['CupertinoButton', 'CupertinoTextField']),
            const SizedBox(height: 8),
            const _ChipRow(['CupertinoNavigationBar', 'CupertinoTabBar']),
            const SizedBox(height: 8),
            const _ChipRow(['CupertinoAlertDialog', 'CupertinoPicker']),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('iOS Human Interface Guidelines', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ChipRow extends StatelessWidget {
  final List<String> names;
  const _ChipRow(this.names);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: names.map((n) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(8)),
      child: Text(n, style: const TextStyle(color: CupertinoColors.white, fontSize: 10)),
    )).toList(),
  );
}
