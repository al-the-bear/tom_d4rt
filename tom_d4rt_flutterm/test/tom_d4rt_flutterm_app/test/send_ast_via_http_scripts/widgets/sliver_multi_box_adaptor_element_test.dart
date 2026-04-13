import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Element role',
      'detail': 'Bridges SliverChildDelegate output and RenderSliverMultiBoxAdaptor child lifecycle.',
    },
    {
      'topic': 'createChild(index, after)',
      'detail': 'Render object asks the element manager to materialize a child at the given index.',
    },
    {
      'topic': 'removeChild(renderBox)',
      'detail': 'Detaches unused render boxes and removes corresponding elements.',
    },
    {
      'topic': 'performRebuild',
      'detail': 'Requests widgets from SliverChildDelegate for currently active indices.',
    },
    {
      'topic': 'estimateMaxScrollOffset',
      'detail': 'Forwards extent estimation from delegate to render object scroll metrics.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SliverMultiBoxAdaptorElement')),
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
