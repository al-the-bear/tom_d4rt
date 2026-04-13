import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Widget contract',
      'detail': 'Base class for widgets that use named slots to supply children to a RenderObject.',
    },
    {
      'topic': 'childForSlot',
      'detail': 'Returns the widget for a given slot, or null if the slot is empty.',
    },
    {
      'topic': 'createElement',
      'detail': 'Creates a SlottedRenderObjectElement for slot-based child lifecycle management.',
    },
    {
      'topic': 'Slot enumeration',
      'detail': 'Slots are typically defined as an enum implementing Comparable.',
    },
    {
      'topic': 'Use case',
      'detail': 'Useful for custom multi-child layouts like dialogs with header, body, and actions.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SlottedMultiChildRenderObjectWidget')),
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
