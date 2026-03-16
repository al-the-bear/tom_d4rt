import 'package:flutter/material.dart';

/// Deep visual demo for Scaffold widget.
/// Implements the basic Material Design visual layout structure.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Scaffold', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 180,
        height: 160,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Container(
                height: 30,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Row(
                  children: [
                    Icon(Icons.menu, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text('App Title', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: const Center(child: Text('body', style: TextStyle(color: Colors.grey))),
                ),
              ),
              Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItem(Icons.home, true),
                    _NavItem(Icons.search, false),
                    _NavItem(Icons.person, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Text('appBar, body, bottomNavigationBar, floatingActionButton', style: TextStyle(fontSize: 9, color: Colors.grey)),
    ],
  );
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  const _NavItem(this.icon, this.selected);
  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: selected ? Colors.blue : Colors.grey, size: 20);
  }
}
