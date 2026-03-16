import 'package:flutter/material.dart';

/// Deep visual demo for DrawerButton - button that opens Scaffold drawer.
/// Shows the drawer toggle button with automatic scaffold integration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DrawerButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // AppBar context
      Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
              ),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('App Title', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            Text('Auto-integrates with Scaffold:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            SizedBox(height: 4),
            Text('• Opens Scaffold.drawer', style: TextStyle(fontSize: 10)),
            Text('• Responds to swipe gestures', style: TextStyle(fontSize: 10)),
            Text('• Handles accessibility', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ],
  );
}
