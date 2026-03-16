import 'package:flutter/material.dart';

/// Deep visual demo for component themes.
/// Shows themed list tiles.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Component Themes')),
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('ListTileTheme Demo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text('Default Theme'),
          subtitle: Text('Uses inherited theme'),
        ),
        ListTileTheme(
          data: ListTileThemeData(
            iconColor: Colors.blue,
            textColor: Colors.blue.shade700,
            tileColor: Colors.blue.shade50,
          ),
          child: const ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Blue Theme'),
            subtitle: Text('Custom colors applied'),
          ),
        ),
        ListTileTheme(
          data: const ListTileThemeData(
            iconColor: Colors.green,
            textColor: Colors.green,
            selectedTileColor: Colors.green,
          ),
          child: const ListTile(
            leading: Icon(Icons.eco),
            title: Text('Green Theme'),
            subtitle: Text('Eco-friendly look'),
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Other Component Themes:', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        _ThemeItem('AppBarTheme', 'App bar styling'),
        _ThemeItem('CardTheme', 'Card appearance'),
        _ThemeItem('ChipTheme', 'Chip styling'),
        _ThemeItem('DialogTheme', 'Dialog appearance'),
        _ThemeItem('DrawerTheme', 'Drawer styling'),
      ],
    ),
  );
}

class _ThemeItem extends StatelessWidget {
  final String name, desc;
  const _ThemeItem(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(leading: const Icon(Icons.palette), title: Text(name), subtitle: Text(desc), dense: true);
}
