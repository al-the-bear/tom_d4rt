import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'StandardComponentType enum',
      'detail': 'Identifies the semantic role of a widget component for accessibility and theming.',
    },
    {
      'topic': 'button',
      'detail': 'Standard interactive button component role in the component type system.',
    },
    {
      'topic': 'label',
      'detail': 'Identifies text labels used for form fields and descriptive content.',
    },
    {
      'topic': 'icon',
      'detail': 'Identifies icon components in the standard component taxonomy.',
    },
    {
      'topic': 'Integration',
      'detail': 'Used by design systems to map component types to theme tokens and semantics.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('StandardComponentType')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(row['topic']!),
              subtitle: Text(row['detail']!),
            ),
          );
        },
      ),
    ),
  );
}
