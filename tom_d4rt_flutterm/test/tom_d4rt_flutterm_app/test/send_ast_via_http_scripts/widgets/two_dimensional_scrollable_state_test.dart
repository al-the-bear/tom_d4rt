import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalScrollableState'},
    {'label': 'Kind', 'value': 'State class for TwoDimensionalScrollable'},
    {'label': 'Purpose', 'value': 'Manages scroll positions, controllers, and gesture handling for 2D scrolling'},
    {'label': 'Key property', 'value': 'verticalScrollable / horizontalScrollable — axis-specific scroll states'},
    {'label': 'Related', 'value': 'TwoDimensionalScrollView, TwoDimensionalScrollable'},
    {'label': 'Use-case', 'value': 'Programmatic scroll control in spreadsheet or map views'},
    {'label': 'Flutter layer', 'value': 'widgets (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF111827),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalScrollableState Summary'),
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
                style: const TextStyle(color: Color(0xFFF8FAFC))),
          );
        },
      ),
    ),
  );
}
