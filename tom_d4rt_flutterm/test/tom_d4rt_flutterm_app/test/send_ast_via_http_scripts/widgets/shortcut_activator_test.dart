import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const examples = <Map<String, String>>[
    {
      'activator': 'SingleActivator(LogicalKeyboardKey.keyK, control: true)',
      'meaning': 'Match Ctrl+K as a single key + modifier shortcut.',
    },
    {
      'activator': 'CharacterActivator("?")',
      'meaning': 'Match a typed character regardless of physical key.',
    },
    {
      'activator':
          'LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.enter)',
      'meaning': 'Legacy multi-key set matching API.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ShortcutActivator')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final row = examples[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(row['activator']!),
              subtitle: Text(row['meaning']!),
            ),
          );
        },
      ),
    ),
  );
}
