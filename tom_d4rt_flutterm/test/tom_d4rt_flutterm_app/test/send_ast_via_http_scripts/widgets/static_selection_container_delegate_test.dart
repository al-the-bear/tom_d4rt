import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'StaticSelectionContainerDelegate'},
    {'label': 'Kind', 'value': 'Abstract class / Delegate'},
    {'label': 'Purpose', 'value': 'Provides selection geometry for static, non-editable content'},
    {'label': 'Key method', 'value': 'value — SelectionGeometry getter'},
    {'label': 'Parent', 'value': 'MultiSelectableSelectionContainerDelegate'},
    {'label': 'Use-case', 'value': 'Lists / grids with selectable children'},
    {'label': 'Flutter layer', 'value': 'widgets (selection)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0D1220),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('StaticSelectionContainerDelegate Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF77E6D4), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFD5E4FF))),
          );
        },
      ),
    ),
  );
}
