import 'package:flutter/cupertino.dart';

/// Demonstrates CupertinoColors theming integration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Dynamic Colors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100, padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: CupertinoColors.systemBackground, border: Border.all(color: CupertinoColors.separator)),
            child: Column(children: [
              Container(width: 30, height: 30, decoration: const BoxDecoration(color: CupertinoColors.label, shape: BoxShape.circle)),
              const SizedBox(height: 4),
              const Text('Auto', style: TextStyle(fontSize: 10)),
            ]),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Wrap(
        spacing: 8,
        children: [_DynChip('systemBackground'), _DynChip('label'), _DynChip('separator')],
      ),
      const SizedBox(height: 8),
      const Text('Adapts to light/dark automatically', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _DynChip extends StatelessWidget {
  final String name;
  const _DynChip(this.name);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: CupertinoColors.activeBlue.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
    child: Text(name, style: const TextStyle(fontSize: 9, fontFamily: 'monospace')),
  );
}
