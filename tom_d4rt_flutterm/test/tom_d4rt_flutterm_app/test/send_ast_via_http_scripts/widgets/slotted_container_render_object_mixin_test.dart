import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {
      'topic': 'Named slot management',
      'detail': 'Provides named slot child management for custom RenderObject containers.',
    },
    {
      'topic': '_setChild(newChild, slot)',
      'detail': 'Resolves old child in slot, drops it if replaced, then adopts new child.',
    },
    {
      'topic': 'attach / detach',
      'detail': 'Iterates children getter and attaches or detaches pipeline owner recursively.',
    },
    {
      'topic': 'visitChildren',
      'detail': 'Maintains render tree depth and traversal semantics across all slots.',
    },
    {
      'topic': 'debugDescribeChildren',
      'detail': 'Exposes per-slot diagnostics with debugNameForSlot labels.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SlottedContainerRenderObjectMixin')),
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
