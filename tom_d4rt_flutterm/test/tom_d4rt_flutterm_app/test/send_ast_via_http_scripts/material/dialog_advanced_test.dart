import 'package:flutter/material.dart';

/// Deep visual demo for SimpleDialog - dialog with simple choices.
/// Shows list-style option selection in a dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SimpleDialog Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Dialog mockup
      Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Select an option', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const Divider(height: 1),
            _DialogOption(Icons.photo, 'Gallery', Colors.blue),
            _DialogOption(Icons.camera_alt, 'Camera', Colors.green),
            _DialogOption(Icons.folder, 'Files', Colors.orange),
            const SizedBox(height: 8),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Use for simple selection lists', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DialogOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _DialogOption(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      dense: true,
      onTap: () {},
    );
  }
}
