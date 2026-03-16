import 'package:flutter/material.dart';

/// Deep visual demo for AppBarThemeData.
/// Shows app bar styling configuration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AppBarThemeData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('AppBar Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _PropertyItem('backgroundColor', 'Color', 'App bar background'),
        _PropertyItem('foregroundColor', 'Color', 'Text and icon color'),
        _PropertyItem('elevation', 'double', 'Shadow depth'),
        _PropertyItem('shadowColor', 'Color', 'Shadow color'),
        _PropertyItem('surfaceTintColor', 'Color', 'M3 surface tint'),
        _PropertyItem('iconTheme', 'IconThemeData', 'Leading/actions icons'),
        _PropertyItem('titleTextStyle', 'TextStyle', 'Title text style'),
        _PropertyItem('toolbarTextStyle', 'TextStyle', 'Toolbar text style'),
        _PropertyItem('centerTitle', 'bool', 'Center the title'),
        _PropertyItem('titleSpacing', 'double', 'Title horizontal spacing'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
          child: const Text('Set in ThemeData.appBarTheme', style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}

class _PropertyItem extends StatelessWidget {
  final String name, type, desc;
  const _PropertyItem(this.name, this.type, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
    subtitle: Text(desc),
    trailing: Chip(label: Text(type, style: const TextStyle(fontSize: 10))),
  );
}
