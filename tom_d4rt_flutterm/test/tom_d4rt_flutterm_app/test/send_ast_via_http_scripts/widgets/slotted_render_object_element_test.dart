import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Element role',
      'detail': 'Manages child elements by named slot identity for SlottedMultiChildRenderObjectWidget.',
    },
    {
      'topic': 'mount and update',
      'detail': 'Inflates child widgets per slot during mount, and diffs per slot during update.',
    },
    {
      'topic': 'Slot-keyed storage',
      'detail': 'Maintains a map from slot identity to child element for efficient lookup.',
    },
    {
      'topic': 'visitChildren',
      'detail': 'Iterates over the active child elements across all occupied slots.',
    },
    {
      'topic': 'insertSlottedChild',
      'detail': 'Adopts a new child element into the render object at the specified slot.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SlottedRenderObjectElement')),
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
