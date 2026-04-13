import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TwoDimensionalChildDelegate'},
    {'label': 'Kind', 'value': 'Abstract delegate for 2D scrollable child management'},
    {'label': 'Purpose', 'value': 'Base contract for providing children to two-dimensional scroll views'},
    {'label': 'Key method', 'value': 'build — returns child widget for a given ChildVicinity'},
    {'label': 'Subclasses', 'value': 'TwoDimensionalChildBuilderDelegate, TwoDimensionalChildListDelegate'},
    {'label': 'Use-case', 'value': 'Custom 2D scroll view implementations with tailored child strategies'},
    {'label': 'Flutter layer', 'value': 'widgets (2D scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalChildDelegate Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFFD9F99D), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFEFF6FF))),
          );
        },
      ),
    ),
  );
}
