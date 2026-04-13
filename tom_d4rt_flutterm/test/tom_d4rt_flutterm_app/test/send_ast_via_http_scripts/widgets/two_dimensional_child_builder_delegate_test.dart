import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalChildBuilderDelegate'},
    {'label': 'Kind', 'value': 'Delegate (lazy child builder for 2D scrollables)'},
    {'label': 'Purpose', 'value': 'Builds children on-demand for two-dimensional scrollable viewports'},
    {'label': 'Key param', 'value': 'builder — callback receiving row and column ChildVicinity'},
    {'label': 'Related', 'value': 'TwoDimensionalScrollView, TwoDimensionalChildDelegate'},
    {'label': 'Use-case', 'value': 'Large grids, spreadsheets, tile maps with lazy loading'},
    {'label': 'Flutter layer', 'value': 'widgets (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF1F2937),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalChildBuilderDelegate Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFB8F2E6), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFDFF4FF))),
          );
        },
      ),
    ),
  );
}
