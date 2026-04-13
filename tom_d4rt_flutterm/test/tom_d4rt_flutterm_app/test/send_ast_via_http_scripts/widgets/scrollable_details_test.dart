// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const details = <Map<String, String>>[
    {
      'name': 'axisDirection',
      'value': 'down',
      'note': 'Primary growth direction of the viewport.',
    },
    {
      'name': 'reverse',
      'value': 'false',
      'note': 'Content order follows natural reading direction.',
    },
    {
      'name': 'physics',
      'value': 'BouncingScrollPhysics',
      'note': 'Applies spring-like overscroll behavior.',
    },
    {
      'name': 'controllerAttached',
      'value': 'true',
      'note': 'External controller drives offset inspection.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollableDetails')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: details.length,
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final row = details[index];
          return ListTile(
            tileColor: Colors.teal.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('${row['name']}: ${row['value']}'),
            subtitle: Text(row['note']!),
          );
        },
      ),
    ),
  );
}
