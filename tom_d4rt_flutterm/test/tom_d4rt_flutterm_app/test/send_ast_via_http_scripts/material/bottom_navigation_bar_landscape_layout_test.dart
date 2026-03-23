// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBarLandscapeLayout - enum for landscape layout modes.
/// Shows how navigation items are arranged in landscape orientation.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BottomNavigationBar Landscape', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 12),
      // Spread layout
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const Text('spread', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            const SizedBox(height: 8),
            Container(
              width: 220,
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _NavItem(Icons.home, 'Home', true),
                  _NavItem(Icons.business, 'Work', false),
                  _NavItem(Icons.school, 'School', false),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      // Centered layout
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const Text('centered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            const SizedBox(height: 8),
            Container(
              width: 220,
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _NavItem(Icons.home, 'Home', true),
                  SizedBox(width: 16),
                  _NavItem(Icons.business, 'Work', false),
                  SizedBox(width: 16),
                  _NavItem(Icons.school, 'School', false),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const Text('Linear layout puts labels beside icons', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  const _NavItem(this.icon, this.label, this.selected);
  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.blue : Colors.grey;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 18, color: color), const SizedBox(width: 4), Text(label, style: TextStyle(fontSize: 10, color: color))],
    );
  }
}
