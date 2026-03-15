import 'package:flutter/cupertino.dart';

/// Demonstrates NavigationBarBottomMode.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('NavBar Bottom Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModePreview('always', true),
          const SizedBox(width: 12),
          _ModePreview('never', false),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Border visibility at bottom', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
    ],
  );
}

class _ModePreview extends StatelessWidget {
  final String name; final bool showBorder;
  const _ModePreview(this.name, this.showBorder);
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 80, height: 40,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          border: showBorder ? const Border(bottom: BorderSide(color: CupertinoColors.systemGrey4)) : null,
        ),
        child: const Center(child: Text('NavBar', style: TextStyle(fontSize: 10))),
      ),
      const SizedBox(height: 4),
      Text(name, style: const TextStyle(fontSize: 10)),
    ],
  );
}
