import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Mixin', 'value': 'TreeSliverStateMixin'},
    {'label': 'Kind', 'value': 'State mixin for tree-structured slivers'},
    {'label': 'Purpose', 'value': 'Manages expand/collapse state and tree-node layout for sliver-based tree views'},
    {'label': 'Key method', 'value': 'toggleNode — expands or collapses a tree node'},
    {'label': 'Related', 'value': 'TreeSliver, TreeSliverNode'},
    {'label': 'Use-case', 'value': 'File explorers, nested category lists, org charts'},
    {'label': 'Flutter layer', 'value': 'widgets (sliver tree)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF263238),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TreeSliverStateMixin Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF80CBC4), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFE0F2F1))),
          );
        },
      ),
    ),
  );
}
