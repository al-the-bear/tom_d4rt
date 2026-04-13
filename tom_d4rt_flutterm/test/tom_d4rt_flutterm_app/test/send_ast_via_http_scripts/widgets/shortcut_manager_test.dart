import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const sections = <Map<String, String>>[
    {
      'title': 'ShortcutManager.shortcuts',
      'detail': 'Maps ShortcutActivator keys to Intent values.',
    },
    {
      'title': 'ShortcutManager.modal',
      'detail': 'When true, unhandled events do not bubble upward.',
    },
    {
      'title': 'handleKeypress()',
      'detail': 'Evaluates key events and returns a KeyEventResult.',
    },
    {
      'title': 'Shortcuts -> Actions',
      'detail': 'Manager match dispatches matching intent to Actions.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ShortcutManager')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final row = sections[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(row['title']!),
              subtitle: Text(row['detail']!),
            ),
          );
        },
      ),
    ),
  );
}
