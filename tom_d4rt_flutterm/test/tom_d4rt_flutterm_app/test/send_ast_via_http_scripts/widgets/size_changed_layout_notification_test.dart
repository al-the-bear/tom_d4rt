import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Notification trigger',
      'detail': 'Dispatched when child layout size changes after first layout.',
    },
    {
      'topic': 'Listener pattern',
      'detail': 'Use NotificationListener<SizeChangedLayoutNotification>.',
    },
    {
      'topic': 'Common use',
      'detail': 'Coordinate overlays and ink effects with geometry changes.',
    },
    {
      'topic': 'Related type',
      'detail': 'Extends LayoutChangedNotification in Flutter widgets layer.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SizeChangedLayoutNotification')),
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
