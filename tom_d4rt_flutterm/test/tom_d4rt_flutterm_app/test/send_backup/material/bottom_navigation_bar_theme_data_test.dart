import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBarThemeData.
/// Shows bottom nav bar theme data properties.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BottomNavigationBarThemeData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Theme Data Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Prop('backgroundColor', 'Bar background color'),
        _Prop('elevation', 'Shadow elevation'),
        _Prop('selectedIconTheme', 'Selected icon theme'),
        _Prop('unselectedIconTheme', 'Unselected icon theme'),
        _Prop('selectedItemColor', 'Selected item color'),
        _Prop('unselectedItemColor', 'Unselected item color'),
        _Prop('selectedLabelStyle', 'Selected label text style'),
        _Prop('unselectedLabelStyle', 'Unselected label text style'),
        _Prop('showSelectedLabels', 'Show selected labels'),
        _Prop('showUnselectedLabels', 'Show unselected labels'),
        _Prop('type', 'fixed or shifting'),
        _Prop('enableFeedback', 'Enable haptic feedback'),
        _Prop('landscapeLayout', 'Landscape item layout'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
          child: const Text('Set via ThemeData.bottomNavigationBarTheme', style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}

class _Prop extends StatelessWidget {
  final String name, desc;
  const _Prop(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(title: Text(name), subtitle: Text(desc), dense: true);
}
