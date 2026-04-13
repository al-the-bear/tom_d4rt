import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Mixin purpose',
      'detail': 'Provides slotted child management for widgets with multiple named child slots.',
    },
    {
      'topic': 'SlotType generic',
      'detail': 'Type parameter defines the slot enum or type used to identify each child position.',
    },
    {
      'topic': 'updateRenderObject',
      'detail': 'Propagates slot configuration changes to the render object layer.',
    },
    {
      'topic': 'createElement',
      'detail': 'Creates a SlottedRenderObjectElement that manages children by slot identity.',
    },
    {
      'topic': 'Related classes',
      'detail': 'Works with SlottedContainerRenderObjectMixin and SlottedRenderObjectElement.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SlottedMultiChildRenderObjectWidgetMixin')),
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
