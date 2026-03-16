import 'package:flutter/material.dart';

/// Deep visual demo for DrawerButtonIcon - icon for opening drawer.
/// Shows the hamburger menu icon used to toggle drawers.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DrawerButtonIcon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Standard
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Icon(Icons.menu, size: 40, color: Colors.blue),
                SizedBox(height: 8),
                Text('Drawer', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // End drawer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Icon(Icons.menu_open, size: 40, color: Colors.green),
                SizedBox(height: 8),
                Text('End Drawer', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Hamburger icon for drawer toggle', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
