import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalChildManager'},
    {'label': 'Kind', 'value': 'Abstract interface for 2D viewport child lifecycle'},
    {'label': 'Purpose', 'value': 'Manages creation, recycling, and disposal of children in 2D viewports'},
    {'label': 'Key method', 'value': 'createChild — builds a child at a given ChildVicinity'},
    {'label': 'Related', 'value': 'RenderTwoDimensionalViewport, TwoDimensionalChildDelegate'},
    {'label': 'Use-case', 'value': 'Custom 2D render objects needing fine-grained child lifecycle control'},
    {'label': 'Flutter layer', 'value': 'widgets / rendering (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF1E293B),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalChildManager Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF67E8F9), fontSize: 16),
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
