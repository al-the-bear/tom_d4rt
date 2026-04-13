import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalChildListDelegate'},
    {'label': 'Kind', 'value': 'Delegate (pre-built child list for 2D scrollables)'},
    {'label': 'Purpose', 'value': 'Provides a fixed list of children to two-dimensional scroll views'},
    {'label': 'Key param', 'value': 'children — 2D list of pre-built widgets by row and column'},
    {'label': 'Related', 'value': 'TwoDimensionalChildBuilderDelegate, TwoDimensionalScrollView'},
    {'label': 'Use-case', 'value': 'Small grids or tables where all children are known upfront'},
    {'label': 'Flutter layer', 'value': 'widgets (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF111827),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalChildListDelegate Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFFBBF24), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFFFFBEB))),
          );
        },
      ),
    ),
  );
}
