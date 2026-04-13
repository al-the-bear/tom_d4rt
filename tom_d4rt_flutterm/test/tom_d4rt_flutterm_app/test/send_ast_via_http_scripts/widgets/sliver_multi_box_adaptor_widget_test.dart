import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Base contract',
      'detail': 'Defines shared mechanics for slivers that lazily supply multiple box children.',
    },
    {
      'topic': 'delegate property',
      'detail': 'Holds a SliverChildDelegate that encapsulates the child production strategy.',
    },
    {
      'topic': 'createElement',
      'detail': 'Creates a SliverMultiBoxAdaptorElement to manage child lifecycles.',
    },
    {
      'topic': 'Subclasses',
      'detail': 'SliverList, SliverGrid, SliverFixedExtentList extend this base class.',
    },
    {
      'topic': 'createRenderObject',
      'detail': 'Subclass provides a specific RenderSliverMultiBoxAdaptor variant.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SliverMultiBoxAdaptorWidget')),
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
