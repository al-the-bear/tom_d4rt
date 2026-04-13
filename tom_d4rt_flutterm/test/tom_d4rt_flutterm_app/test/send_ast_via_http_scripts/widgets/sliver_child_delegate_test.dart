import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'SliverChildBuilderDelegate',
      'detail': 'Lazily builds children on demand via an IndexedWidgetBuilder callback.',
    },
    {
      'topic': 'SliverChildListDelegate',
      'detail': 'Wraps a fixed list of widgets for slivers that know all children upfront.',
    },
    {
      'topic': 'shouldRebuild',
      'detail': 'Controls whether the sliver rebuilds its children when the delegate changes.',
    },
    {
      'topic': 'didFinishLayout',
      'detail': 'Called after layout with the first and last visible child indices.',
    },
    {
      'topic': 'estimateMaxScrollOffset',
      'detail': 'Provides an estimated total extent for the scroll metrics.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SliverChildDelegate')),
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
