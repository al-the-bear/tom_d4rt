import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldState.
/// State class for Scaffold with drawer control and bottom sheets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldState', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Scaffold.of(context)', style: TextStyle(fontFamily: 'monospace', fontSize: 10)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StateMethod('.openDrawer()', Icons.menu),
                const SizedBox(width: 8),
                _StateMethod('.openEndDrawer()', Icons.menu_open),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StateMethod('.closeDrawer()', Icons.close),
                const SizedBox(width: 8),
                _StateMethod('.closeEndDrawer()', Icons.close),
              ],
            ),
            const SizedBox(height: 8),
            _StateMethod('.showBottomSheet()', Icons.expand_less),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('hasDrawer, isDrawerOpen, hasEndDrawer', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _StateMethod extends StatelessWidget {
  final String method;
  final IconData icon;
  const _StateMethod(this.method, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          Text(method, style: const TextStyle(fontFamily: 'monospace', fontSize: 8)),
        ],
      ),
    );
  }
}
