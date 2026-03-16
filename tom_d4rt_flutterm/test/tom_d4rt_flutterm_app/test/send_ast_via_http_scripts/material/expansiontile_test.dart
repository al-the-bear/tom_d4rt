import 'package:flutter/material.dart';

/// Deep visual demo for ExpansionTile - a ListTile that expands.
/// Shows expandable tile with title, subtitle, and children.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ExpansionTile Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        width: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            // Tile header
            ListTile(
              leading: const Icon(Icons.folder, color: Colors.amber),
              title: const Text('Documents'),
              subtitle: const Text('3 items'),
              trailing: const Icon(Icons.expand_less),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            ),
            // Children
            Container(
              color: Colors.grey.shade50,
              child: Column(
                children: [
                  ListTile(leading: const Icon(Icons.insert_drive_file, size: 20), title: const Text('Report.pdf'), dense: true),
                  ListTile(leading: const Icon(Icons.insert_drive_file, size: 20), title: const Text('Notes.txt'), dense: true),
                  ListTile(leading: const Icon(Icons.insert_drive_file, size: 20), title: const Text('Data.csv'), dense: true,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)))),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
