import 'package:flutter/material.dart';

/// Deep visual demo for AboutListTile widget.
/// ListTile that shows app about dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AboutListTile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            _DrawerTile(Icons.home, 'Home', false),
            _DrawerTile(Icons.settings, 'Settings', false),
            const Divider(height: 1),
            _DrawerTile(Icons.info, 'About', true),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Shows AboutDialog on tap', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;
  const _DrawerTile(this.icon, this.label, this.highlight);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: highlight ? Colors.blue.shade50 : null,
      child: Row(
        children: [
          Icon(icon, color: highlight ? Colors.blue : Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 12, color: highlight ? Colors.blue : null)),
        ],
      ),
    );
  }
}
