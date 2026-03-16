import 'package:flutter/material.dart';

/// Deep visual demo for AppBarTheme.
/// Shows different app bar theme styles.
dynamic build(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        _ThemedAppBar('Default', AppBarTheme(backgroundColor: Colors.blue)),
        _ThemedAppBar('Elevated', AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 4)),
        _ThemedAppBar('Flat', AppBarTheme(backgroundColor: Colors.green, elevation: 0)),
        _ThemedAppBar('Transparent', const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)),
        _ThemedAppBar('Custom', AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          centerTitle: true,
        )),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Apply via Theme(data: ThemeData(appBarTheme: ...))', style: TextStyle(fontSize: 11)),
          ),
        ),
      ],
    ),
  );
}

class _ThemedAppBar extends StatelessWidget {
  final String name;
  final AppBarTheme theme;
  const _ThemedAppBar(this.name, this.theme);
  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData(appBarTheme: theme),
    child: AppBar(title: Text(name), actions: [IconButton(icon: const Icon(Icons.info), onPressed: () {})]),
  );
}
