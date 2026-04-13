import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalViewportParentData'},
    {'label': 'Kind', 'value': 'ParentData for 2D viewport children'},
    {'label': 'Purpose', 'value': 'Stores layout metadata (vicinity, paint offset) for children in a 2D viewport'},
    {'label': 'Key property', 'value': 'vicinity — ChildVicinity identifying the row/column position'},
    {'label': 'Related', 'value': 'RenderTwoDimensionalViewport, ChildVicinity'},
    {'label': 'Use-case', 'value': 'Custom 2D layout protocols that read child position metadata'},
    {'label': 'Flutter layer', 'value': 'rendering (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF1F2937),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalViewportParentData Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFA7F3D0), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFF9FAFB))),
          );
        },
      ),
    ),
  );
}
