import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'insertItem(index)',
      'detail': 'Adds an item and triggers the entrance animation at the given index.',
    },
    {
      'topic': 'removeItem(index, builder)',
      'detail': 'Removes an item and drives a reverse animation for the exit transition.',
    },
    {
      'topic': 'startItemDragReorder',
      'detail': 'Initiates a drag session and creates the overlay proxy widget.',
    },
    {
      'topic': 'cancelReorder',
      'detail': 'Aborts an active drag session and restores the original visual state.',
    },
    {
      'topic': 'EdgeDraggingAutoScroller',
      'detail': 'Coordinates boundary auto-scrolling when drag approaches list edges.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SliverReorderableListState')),
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
