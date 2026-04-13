import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Enum', 'value': 'UnfocusDisposition'},
    {'label': 'Kind', 'value': 'Enum describing how focus should be released'},
    {'label': 'Purpose', 'value': 'Controls where focus moves when a node is unfocused'},
    {'label': 'Values', 'value': 'scope — move to enclosing scope; previouslyFocusedChild — restore last child'},
    {'label': 'Related', 'value': 'FocusNode, FocusScopeNode'},
    {'label': 'Use-case', 'value': 'Dialogs, menus, and panels that need controlled focus release'},
    {'label': 'Flutter layer', 'value': 'widgets (focus system)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UnfocusDisposition Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF99F6E4), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFF8FAFC))),
          );
        },
      ),
    ),
  );
}
