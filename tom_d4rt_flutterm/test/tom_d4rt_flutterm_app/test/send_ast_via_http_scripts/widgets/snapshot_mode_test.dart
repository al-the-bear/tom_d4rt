import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'SnapshotMode.normal',
      'detail': 'Widget renders and paints as usual without rasterization caching.',
    },
    {
      'topic': 'SnapshotMode.permissive',
      'detail': 'Allows snapshot even when platform views or other unsupported content is present.',
    },
    {
      'topic': 'SnapshotMode.forced',
      'detail': 'Forces rasterization snapshot regardless of content compatibility.',
    },
    {
      'topic': 'SnapshotWidget usage',
      'detail': 'SnapshotWidget uses SnapshotMode to control when children are rasterized.',
    },
    {
      'topic': 'Performance trade-off',
      'detail': 'Rasterization reduces repaint cost but increases memory and initial capture cost.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SnapshotMode')),
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
