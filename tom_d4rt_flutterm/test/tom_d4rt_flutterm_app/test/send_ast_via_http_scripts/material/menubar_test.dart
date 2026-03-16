import 'package:flutter/material.dart';

/// Deep visual demo for MenuBar widget.
/// Shows desktop-style menu bar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MenuBar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuBarItem('File'),
            _MenuBarItem('Edit'),
            _MenuBarItem('View'),
            _MenuBarItem('Help'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      // One menu expanded
      Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MenuBarItem('File', selected: true),
                _MenuBarItem('Edit'),
                _MenuBarItem('View'),
                _MenuBarItem('Help'),
              ],
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(padding: EdgeInsets.all(8), child: Text('New', style: TextStyle(fontSize: 11))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Open', style: TextStyle(fontSize: 11))),
                  Padding(padding: EdgeInsets.all(8), child: Text('Save', style: TextStyle(fontSize: 11))),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _MenuBarItem extends StatelessWidget {
  final String label;
  final bool selected;
  const _MenuBarItem(this.label, {this.selected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: selected ? Colors.blue.withAlpha(50) : null,
      child: Text(label, style: TextStyle(fontSize: 12, color: selected ? Colors.blue : null)),
    );
  }
}
