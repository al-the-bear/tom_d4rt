import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'name': 'showName',
      'detail': 'Controls whether the diagnostics property name is rendered.',
    },
    {
      'name': 'level',
      'detail': 'Sets visibility priority in diagnostics output.',
    },
    {
      'name': 'defaultValue',
      'detail': 'Suppresses noisy output when value matches default.',
    },
    {
      'name': 'description',
      'detail': 'Adds a custom diagnostics text summary.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ShortcutMapProperty')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(row['name']!),
              subtitle: Text(row['detail']!),
            ),
          );
        },
      ),
    ),
  );
}
