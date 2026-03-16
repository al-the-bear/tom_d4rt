import 'package:flutter/material.dart';

/// Deep visual demo for Material class structure.
/// Shows class organization in Flutter Material.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Material Classes')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Material Library Structure', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Category('Widgets', [
          'AppBar, BottomNavigationBar, Card',
          'Chip, Dialog, Drawer',
          'FloatingActionButton, Scaffold',
        ], Colors.blue),
        _Category('Themes', [
          'ThemeData, ColorScheme',
          'TextTheme, IconTheme',
          'Component-specific themes',
        ], Colors.purple),
        _Category('Buttons', [
          'ElevatedButton, FilledButton',
          'OutlinedButton, TextButton',
          'IconButton, FloatingActionButton',
        ], Colors.green),
        _Category('Input', [
          'TextField, Checkbox, Radio',
          'Slider, Switch, DropdownButton',
          'DatePicker, TimePicker',
        ], Colors.orange),
      ],
    ),
  );
}

class _Category extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  const _Category(this.title, this.items, this.color);
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(Icons.folder, color: color), const SizedBox(width: 8), Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color))]),
          const SizedBox(height: 8),
          for (final item in items) Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text('• ' + item, style: const TextStyle(fontSize: 12))),
        ],
      ),
    ),
  );
}
